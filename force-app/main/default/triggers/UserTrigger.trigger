trigger UserTrigger on User (after insert,After Update) {
    if(Trigger.isInsert && Trigger.isAfter){
        List<Contact> conLst = new List<Contact>();
        for(User u : [SELECT Id,username,ContactId from User where Id IN: Trigger.newMap.keySet() AND Profile.Name ='SP'
                      AND ContactId != NULL]){
            Contact con = new Contact();
            con.Id = u.ContactId;
            con.username__c = u.username;
            con.userId__c = u.Id;
            conLst.add(con);
        }
        if(conLst.size() > 0){
            update conLst;
        }
    }
    if(trigger.isAfter && trigger.isUpdate){
        system.debug('inside trigger');
        set<id> conset = new set<id>();
        for (User u : trigger.new)
        {
            if (u.Username != trigger.oldMap.get(u.Id).Username)
            {
                system.debug('inside userif');
                conset.add(u.id);
            }
        }
        if(conset.size() > 0 && !(system.isFuture())){
            system.debug('conset'+conset);
              UserTriggerHandler.updateconuserName(conset);
        }
    }
}