trigger EngagementActivities on Engagement_Activities__c (After Insert,After Update) {
    if(trigger.isAfter && trigger.isInsert){
        
          EngagementNotificationHelper.createNotification(trigger.New);
        
    }
     if(trigger.isAfter && trigger.isUpdate){
         for(Engagement_Activities__c enActivity : trigger.new){
             if(enActivity.Site__c !=trigger.oldMap.get(enActivity.Id).Site__c){
                 
                 EngagementNotificationHelper.createNotification(trigger.New);
                 
             }
             
         }
        
          
        
    }
    
    
    
/*if((trigger.isAfter && trigger.isInsert)|| (trigger.isAfter && trigger.isUpdate)){
       
      EngagementNotificationHelper.createNotification(trigger.New,trigger.oldmap);
  
    }*/
}