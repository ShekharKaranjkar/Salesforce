global class Batch_Insurance implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT Id, Name,Policy_Number__c, Policy_Start_Date__c, Policy_End_Date__c, Renewal_Date__c, Insurance_Company__c FROM Insurance__c where Status__c !='Activated']);
    }
    global void execute(Database.BatchableContext bc, List<Insurance__c> records){
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
        Map<string,FeedItem>feeditemaList =new Map<string,FeedItem>();
        
        for(Insurance__c a : records){
            system.debug('records'+a);
            if(a.Renewal_Date__c != null){
                system.debug('!@'+a.Renewal_Date__c.adddays(-7));
                system.debug('!@'+a.Renewal_Date__c.adddays(-15));
                system.debug('!@'+a.Renewal_Date__c.adddays(-30));
                //  system.debug('!@'+a.Renewal_Date__c.adddays(-60));
                system.debug('!!'+before7days);
                if(a.Renewal_Date__c.adddays(-7) == before7days){
                    FeedItem fi = New FeedItem(ParentId = MTComplianceandCOOId,Body = '7 days to go for this Insurance Record '+ a.Name+'and Renewal Date'+a.Renewal_Date__c);
                    feeditemaList.put(a.Name,fi);
                    system.debug('fi'+fi);
                    
                }
                if(a.Renewal_Date__c.adddays(-15) == before15dys){
                    FeedItem fi1 = New FeedItem(ParentId = MTComplainceId,Body = '15 days to go for this Insurance Record '+ a.Name+'and Renewal Date'+a.Renewal_Date__c);
                    feeditemaList.put(a.Name,fi1);
                }
                if(a.Renewal_Date__c.adddays(-30) == before30days){
                    FeedItem fi2 = New FeedItem(ParentId = MTComplainceId,Body = '30 days to go for this Insurance Record '+ a.Name+'and Renewal Date'+a.Renewal_Date__c);
                    feeditemaList.put(a.Name,fi2);
                }
                
            } 
        }    
        system.debug('feeditemaList'+feeditemaList);
        
        if(feeditemaList.size() >0){
            insert feeditemaList.values();
            system.debug('feeditemaList'+feeditemaList);
        } 
    }
    global void finish(Database.BatchableContext bc)
    {
        
    }
}