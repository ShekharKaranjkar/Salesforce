public class UserTriggerHandler {
 @future
    public static void updateconuserName(Set<Id> conId)
    {
        List<Contact> conLst = new List<Contact>();
        system.debug('conId'+conId);
        for(user u: [select id,ContactId,username from user where id in:conId]){
            system.debug('u.ContactId');
            contact cc = new contact();
            cc.Id = u.ContactId;
            cc.username__c = u.username;
            conLst.add(cc);
        }
        if(conLst.size() > 0){
            system.debug('conLst'+conLst);
            update conLst;
        }
    }
}