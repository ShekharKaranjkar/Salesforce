public class RosterController {
    @AuraEnabled public list<Service_Provider__c> sp {get;set;}
    @AuraEnabled public string monthly {get;set;}
    @AuraEnabled public string weekly {get;set;}
    @AuraEnabled public string weekday {get;set;}
    @AuraEnabled
    public static List<String> getShiftPicklist(){
        List<String> optionlist = new List<String>();
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get('Rostering__c').getDescribe().fields.getMap(); 
        List<Schema.PicklistEntry> picklistValues = field_map.get('Shift__c').getDescribe().getPickListValues();
        
        for (Schema.PicklistEntry pv : picklistValues) {
            optionlist.add(pv.getValue());
        }
        system.debug('optionlist'+optionlist);
        return optionlist;
    }
    
    @AuraEnabled
    public static RosterController getServiceProvider(){
        Id userId= UserInfo.getUserId();
        system.debug('userId'+userId);
  list<Campus__c> campusList= [select id, Assinged_To__c,  name from Campus__c where Site_Incharge__c=:userId ];
        system.debug('campusList'+campusList);
        list<Service_Provider__c> sp1=[select id, Name from Service_Provider__c where  Site__c IN:campusList];
        list<Rostering__c> r=[select id, Name,Lithium_ID__c from Rostering__c where  Lithium_ID__c IN:sp1];
        list<Service_Provider__c> sp=[select id, Name,LithiumIds__c ,Site__c, 
                                      (select id ,Lithium_ID__c, Active__c,Status__c,	All_Status__c, Status_From_Parent__c,Shift_Start_Date__c,Name, Shift_End_Date__c ,RecordType.Name ,RecordTypeId  , 
                                       Start_Time__c ,Shift__c, End_Time__c,   
                                       Sunday__c, Monday__c, Tuesday__c,Wednesday__c, Thrusday__c, Friday__c, Saturday__c,
                                       Approval_Request__r.Status__c
                                       from Rostering__r 
                                       where   (Shift_End_Date__c>today  And Shift_Start_Date__c<=today And Status__c='Approved' )
                                       or (Status__c='Requested')  ORDER BY Status__c DESC limit 1 )  
                                      from Service_Provider__c 
                                      where  Site__c IN:campusList And Status__c ='Active'];
        RosterController rc =new RosterController();
        rc.sp=sp;
        rc.monthly=Schema.SObjectType.Rostering__c.getRecordTypeInfosByName().get('Monthly').getRecordTypeId();
        rc.weekday=Schema.SObjectType.Rostering__c.getRecordTypeInfosByName().get('Weekday').getRecordTypeId();
        rc.weekly=Schema.SObjectType.Rostering__c.getRecordTypeInfosByName().get('Weekend').getRecordTypeId();
        
        return rc;
        
    }
    
    @AuraEnabled
    public static boolean saveRoster(List<Rostering__c> rosterInsertList,
                                     List<Rostering__c> rosterUpdateList,List<Rostering__c> rosterInsertApprovedList, string siteName )
    {
        system.debug('rosterInsertList'+siteName);
        system.debug('rosterInsertList'+rosterInsertList);
        system.debug('rosterUpdateList'+rosterUpdateList);
        
            list<Rostering__c> newRosteringList=new list<Rostering__c>();
            list<Approval_Request__c> ApprovalList=new list<Approval_Request__c>();
            Boolean flag=false;
            if(rosterInsertList.size()>0){
                system.debug('listSize'+rosterInsertList.size());
                Approval_Request__c a=new Approval_Request__c();
                a.Campus__c=siteName;
                a.Status__c='Requested';
                system.debug('a=bfor==========='+a);
                insert a;
                system.debug('a============'+a);
                for(Rostering__c r:rosterInsertList){
                    r.Approval_Request__c=a.Id;
                    system.debug('rosterInsertList'+r);
                }
                system.debug('rosterInsertList'+rosterInsertList);
                insert rosterInsertList;
                 system.debug('rosterInsertListafter'+rosterInsertList);
                flag=true; 
                
                //   update a;
                system.debug('a'+a);
            }
            
            if(rosterUpdateList.size()>0){
                update rosterUpdateList;
                flag=true; 
            }
            
            return flag;
       //   }  catch (Exception e) {
            
          //  throw new AuraHandledException(e.getMessage());    
        //}
        
    }
}