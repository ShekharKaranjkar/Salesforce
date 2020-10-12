global class Batch_VehicleDocument implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT Id, Name,RecordTypeId, Date_of_Expiry__c,Recordtype.DeveloperName,status__c FROM Vehicle_Documents__c where Recordtype.DeveloperName in ('Fitness_Certificate','Taxes') AND Name !=Null AND Date_of_Expiry__c!=NUll AND status__c !='Physical Copy Received']);
    }
    global void execute(Database.BatchableContext bc, List<Vehicle_Documents__c> records){
        Date before7days = system.today();
        Date before15dys = system.today();
        Date before30days = system.today();
        Date befor60ays = system.today();
        String MTComplainceId;
        String MTComplianceandCOOId;
        
        For(CollaborationGroup cgs :[select Id,Name from CollaborationGroup]){
            if(cgs.Name=='MT Compliance and COO')
                MTComplianceandCOOId = cgs.Id;
            system.debug('MTComplianceandCOOId'+MTComplianceandCOOId);
            if(cgs.Name == 'MT Complaince')
                MTComplainceId = cgs.Id;  
            if(Test.isRunningTest()){
              MTComplainceId = cgs.Id;  
              MTComplianceandCOOId = cgs.Id;  
            }
            system.debug('MTComplainceId'+MTComplainceId);
        }
        Map<string,FeedItem> feeditemaList =new   Map<string,FeedItem>();
         Map<string,FeedItem> feeditemaList1 =new Map<string,FeedItem>();
        
        for(Vehicle_Documents__c a : records){
            system.debug('records'+a);
            if(a.Recordtype.DeveloperName == 'Fitness_Certificate' && a.Status__c != 'Physical Copy Received'){
                system.debug('!@'+a.Date_of_Expiry__c.adddays(-7));
                system.debug('!@'+a.Date_of_Expiry__c.adddays(-15));
                system.debug('!@'+a.Date_of_Expiry__c.adddays(-30));
                system.debug('!@'+a.Date_of_Expiry__c.adddays(-60));
                system.debug('!!'+before7days);
                if(a.Date_of_Expiry__c.adddays(-7) == before7days){
                    FeedItem fi = New FeedItem(ParentId = MTComplianceandCOOId,Body = '7 days to go for this Record'+a.Name);
                    
                    feeditemaList.put(a.Name,fi);
                    system.debug('id'+a.Name);
                   
                    system.debug('fi'+fi);
                    
                }
                if(a.Date_of_Expiry__c.adddays(-15) == before15dys){
                    FeedItem fi1 = New FeedItem(ParentId = MTComplainceId,Body = '15 days to go for this Record'+a.Name);
                    feeditemaList.put(a.Name,fi1);
                }
                if(a.Date_of_Expiry__c.adddays(-30) == before30days){
                    FeedItem fi2 = New FeedItem(ParentId = MTComplainceId,Body = '30 days to go for this Record'+a.Name);
                    feeditemaList.put(a.Name,fi2);
                }
                if(a.Date_of_Expiry__c.adddays(-60) == befor60ays){
                    FeedItem fi3 = New FeedItem(ParentId = MTComplainceId,Body = '60 days to go for this Record'+a.Name);
                    feeditemaList.put(a.Name,fi3);
                }
            } else {
                if(a.Recordtype.DeveloperName == 'Taxes'){
                    if(a.Date_of_Expiry__c.adddays(-7) == before7days){
                        FeedItem fib = New FeedItem(ParentId = MTComplianceandCOOId,Body = '7 days to go for this Record'+a.Name);
                        system.debug('fi>>>'+fib);
                        feeditemaList1.put(a.Name,fib);
                        system.debug('qw'+ feeditemaList1);
                    }
                    if(a.Date_of_Expiry__c.adddays(-15) == before15dys){	
                        FeedItem fibc = New FeedItem(ParentId = MTComplainceId,Body = '15 days to go for this Record'+a.Name);
                        feeditemaList1.put(a.Name,fibc);
                    }
                    
                } 
            }
        }    
          system.debug('feeditemaList'+feeditemaList);
        system.debug('feeditemaList1'+feeditemaList1);
        if(feeditemaList.size() >0){
            try{
                insert feeditemaList.values();
            system.debug('feeditemaList'+feeditemaList);
            }catch(dmlexception e){
                system.debug('DMLExceptional'+e);
            }
            
        } else{
            if(feeditemaList1.size() >0){
            insert feeditemaList1.values();
                system.debug('feeditemaList1'+feeditemaList1);
        }
    } 
    }
    global void finish(Database.BatchableContext bc)
    {
        
    }
}