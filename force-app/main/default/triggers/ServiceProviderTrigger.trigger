trigger ServiceProviderTrigger on Service_Provider__c (before Insert,before Update,after update) {
 
    if(trigger.isBefore && trigger.isInsert){
        system.debug('inside the trigger');
       LithiumIdFormat.accordingToLocation(trigger.New);
        
        
        
    }
    if(trigger.isBefore &&( trigger.isUpdate ||trigger.isInsert)){
        //   If site is changed trigger the method for checking site limit
        for (Service_Provider__c newRecord : trigger.new)
        {
            
            if (trigger.isInsert || 
                (trigger.isUpdate && (newRecord.Site__c != trigger.oldMap.get(newRecord.Id).Site__c ||
                                      newRecord.Status__c != trigger.oldMap.get(newRecord.Id).Status__c)) )
            {
                LithiumIdFormat.checkSiteLimit(trigger.New);
            }
        }
        
        ChangeUserContactUserName.changeUserContactPhone(trigger.newMap,trigger.oldMap);
    }
    if(trigger.isAfter && trigger.isUpdate){
        
        InactiveNotificationsToUsers.sendNotification(trigger.New,trigger.oldmap);
        InactiveNotificationsToUsers.validations(trigger.New,trigger.oldmap);
        
        
    }
 
}