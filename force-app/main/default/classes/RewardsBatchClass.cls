/* It will schedule to make reward record.
 * Schedule at every month on day first.
 */
global class RewardsBatchClass implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         
        String query = 'Select id,Status__c  from Service_Provider__c  where  Status__c =\'Active\'';
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<Service_Provider__c> spList) {
        system.debug('spList'+spList);  
        list<Reward__c>rList=new list<Reward__c>();

        for(Service_Provider__c sp : spList) {        
            Reward__c r=new Reward__c();
            r.Service_Provider__c=sp.id;
            rList.add(r);
        }
        try {
          system.debug('rList'+rList);  
            insert rList;
         
        }catch(exception e){
            Debug_Log__c debug=new Debug_Log__c();
            debug.Class_Name__c='RewardsBatchClass';
       
      
            insert debug;
          
        }
         
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}