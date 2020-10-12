public class JobCardJobCarLineItem {
    @AuraEnabled public list<Issues__c> issue {get;set;}
    @AuraEnabled public list<Job_Card__c> jobCard{get;set;}
    @AuraEnabled public list<Job_Card_Line_Item__c> jobli{get;set;}
    @AuraEnabled public string name{get;set;}
    @AuraEnabled public Boolean Site{get;set;}
    @AuraEnabled public Boolean Shift{get;set;}
    @AuraEnabled public Boolean Tracker{get;set;}
    @AuraEnabled public Boolean Supervisor{get;set;}
    @AuraEnabled public Boolean all{get;set;}
    @AuraEnabled
    public static JobCardJobCarLineItem getIssue(String recordId)
    {    
        try{
            JobCardJobCarLineItem jObj= new JobCardJobCarLineItem();
            id u=UserInfo.getUserId();
            user userobj =[select id,Profile.Name,  name from user where id=:u];
            
            jObj.name=userobj.Profile.Name;
            
            jObj.issue =[ select Service_Center__r.RecordType.Name, Vehicle__c, Vehicle__r.City__r.Name,  Vehicle__r.Name,  Id,Name 
                         from Issues__c 
                         where id=:recordId and Service_Center__r.RecordType.Name='Lithium WorkShop'];
            
            system.debug('!!!'+jObj.issue);
            
            list<Job_Card__c>   job =[Select id,Name,Issues__c,Date__c, Odometer_Reading__c, Campus__c,Campus__r.Name, Technician_Name__c,
                                      (select  Id, name,	Issue__c,  RecordType.Name, Available_Products__c, Action_Taken__c, 
                                       From_which_Vehicle__c, Inventory_Product__c,Inventory_Product__r.Name, Part_Name__c, Parts__c ,Quantity__c
                                       from Job_Card_Line_Items__r) 
                                      from Job_Card__c 
                                      where Issues__c=:recordId];  
            //       jObj.jobli =[Select id,Name,Vehicle__c,Vehicle__r.City__r.Name,  Vehicle__r.Name  from Job_Card_Line_Item__c where id=:recordId];
            if(job.size()>0){
                jObj.jobCard=job;
                
            }
            
            return jObj;  
        }catch(Exception ex) {
            System.debug(ex);
            throw new AuraHandledException(ex.getMessage());   
        } 
    }
    @AuraEnabled
    public static     list<Inventory_Product__c> getInventory()
    {    
        try{
            list<Inventory_Product__c> iventr =[Select id,Name,City__c,City__r.Name, Stock__c, Minimum_Stock__c    from Inventory_Product__c ];
            system.debug('!!!'+iventr);
            return iventr;  
        }catch(Exception ex) {
            System.debug(ex);
            throw new AuraHandledException(ex.getMessage());   
        } 
    }
    @AuraEnabled
    public static list<Job_Card__c>  createRecord (list<Job_Card__c>jobcar,list<Job_Card_Line_Item__c>
                                                   updatejobCardLine,String recordId,
                                                   list<string>DeleteoneDList
                                                  )
    {
        
        try{  List< Issues__c> is=[ select Service_Center__r.RecordType.Name, Vehicle__c, Vehicle__r.City__r.Name,  Vehicle__r.Name,  Id,Name 
                                   from Issues__c 
                                   where id=:recordId ];
            Id recInventory = Schema.SObjectType.Job_Card_Line_Item__c.getRecordTypeInfosByName().get('Inventory').getRecordTypeId();
            //system.debug('mapAccountWiseContact'+stExam);
            Id recSwapped = Schema.SObjectType.Job_Card_Line_Item__c.getRecordTypeInfosByName().get('Swapped').getRecordTypeId();
            Id recGeneral = Schema.SObjectType.Job_Card_Line_Item__c.getRecordTypeInfosByName().get('General').getRecordTypeId();
            //system.debug('mapAccountWiseContact'+stExam);
            system.debug('jsonCheck '+ jobcar);
            if( jobcar!=null){
                jobcar[0].	Work_Shop_manger__c=UserInfo.getUserId();
                jobcar[0].Vehicle__c=is[0].Vehicle__c;
                upsert jobcar;
                
            }
            for(Integer i=0; i<updatejobCardLine.size(); i++){
                updatejobCardLine[i].Job_Card__c =jobcar[0].id;
                if(updatejobCardLine[i].Parts__c=='Swapped'){
                    updatejobCardLine[i].RecordTypeId = recSwapped;
                }else if(updatejobCardLine[i].Parts__c=='Inventory'){
                    updatejobCardLine[i].RecordTypeId = recInventory; 
                }else if(updatejobCardLine[i].Parts__c=='General'){
                    updatejobCardLine[i].RecordTypeId = recGeneral;   
                }
            }
            
            if( updatejobCardLine!=null){
                upsert updatejobCardLine;
            }
            
            list<Job_Card_Line_Item__c>deletelist=[Select id,Name,Inventory_Product__c,Available_Products__c, Quantity__c,  Job_Card__c  
                                                   from Job_Card_Line_Item__c where id in:DeleteoneDList ];
            
            delete deletelist;
            list<Job_Card_Line_Item__c>jliList=[Select id,Name,Inventory_Product__c,Available_Products__c, Quantity__c,  Job_Card__c  
                                                from Job_Card_Line_Item__c where Job_Card__c =:jobcar[0].id ];
            map<id,Decimal> mapOfInventry=new map<id,Decimal>();
            for(Job_Card_Line_Item__c j:jliList){
                if(!(j.Quantity__c == NULL && j.Inventory_Product__c==NULL)){
                    
                    mapOfInventry.put(j.Inventory_Product__c,j.Quantity__c);
                    system.debug('map'+mapOfInventry);
                }
            }
            list<Inventory_Product__c>inven =[ Select id,Name,Minimum_Stock__c,Stock__c   from Inventory_Product__c  where id In:mapOfInventry.keySet()];
            system.debug('inven'+inven);
            for(Inventory_Product__c i:inven){
                i.Stock__c=  i.Stock__c-mapOfInventry.get(i.id);
                system.debug('inven'+i.Stock__c);
            }
            
            update inven;
            return jobcar;
           }
        catch(Exception ex) {
            System.debug(ex);
            throw new AuraHandledException(ex.getMessage());   
        } 
        
    }
}