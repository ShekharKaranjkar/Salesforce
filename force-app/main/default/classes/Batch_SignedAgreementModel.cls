/*
 * This Batch is used to checkout the Sp from the Driver menu after '12 hrs' and '16 hrs' as they signedAggreed in SP record.
 */ 


global class Batch_SignedAgreementModel implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,Service_Provider__c,Type__c,Login__c,Logout__c,'+
                                        'Service_Provider__r.Signed_Agreement_Model__c,'
                                        +'Service_Provider__r.Name FROM Attendance__c where Logout__c = null AND Service_Provider__r.Signed_Agreement_Model__c !=null AND Service_Provider__r.Status__c =\'Active\'');
    }
    global void execute(Database.BatchableContext BC, List<Attendance__c> attenList){
        List<Attendance__c> updateattList = new List<Attendance__c>();
        Datetime currentTime = system.now();
        for(Attendance__c att : attenList){ 
            system.debug('att.Service_Provider__r.Signed_Agreement_Model__c'+att.Service_Provider__r.Signed_Agreement_Model__c);
            system.debug('Login__c.addHours(14)'+att.Login__c.addHours(14));
            if(att.Login__c.addHours(14) <= currentTime && att.Service_Provider__r.Signed_Agreement_Model__c =='12 hrs'){
                att.Logout__c = system.now();
                att.Type__c='Check out';
                updateattList.add(att);
            }
            else  if(att.Login__c.addHours(16) <= currentTime && att.Service_Provider__r.Signed_Agreement_Model__c =='16 hrs' ){
                att.Logout__c = system.now();
                att.Type__c='Check out';
                updateattList.add(att);
            }
        }
        if(updateattList.size() > 0){
            update updateattList;
            system.debug('updateattList 39 ---->'+updateattList);
        }
    }
    global void finish(Database.BatchableContext BC){
    }
}