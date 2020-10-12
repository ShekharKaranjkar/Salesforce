public class EngagementNotificationHelper {
    
    public static void createNotification(list<Engagement_Activities__c>enList){
        
        Map<Id, list<Service_Provider__c>> srvcProMap = new Map<Id, list<Service_Provider__c>>();
        Map<Id,Engagement_Activities__c> siteEngagMap=new Map<Id,Engagement_Activities__c>();
        set<id> setid = new set<id>();
        Set<Id> spIds=new set<Id>();
        Set<Id> enActivityIds=new set<Id>();
        Map<string,string> setnumber =new Map<string,string>();
        
        Map<Id,List<User>> spUserIDMap =new Map<Id,list<User>>();
        list<Engagement_Activities__c> updateList = new  list<Engagement_Activities__c>();
        for(Engagement_Activities__c r:enList){
            if(r.Site__c !=null)
                siteEngagMap.put(r.Site__c,r);
            enActivityIds.add(r.Id);
        }
        system.debug('');
        for(Service_Provider__c s:[Select id,Site__c,Site__r.Name,Name,Phone_Number__c from Service_Provider__c 
                                   where 
                                   Site__c in:siteEngagMap.keyset() AND Status__c='Active' AND Site__c !=null])
            
        {
            
            if(!srvcProMap.containskey(s.Site__c)){
                srvcProMap.put(s.Site__c,new list<Service_Provider__c>{s});
            }else{
                srvcProMap.get(s.Site__c).add(s);
            }
            
            //  setnumber.put(s.Phone_Number__c+'@lithium.com',s.Site__c);
            spIds.add(s.Id);
        }
        system.debug('spIds-------------'+spIds);
        system.debug('srvcProMap-------------'+srvcProMap);
        if(spIds.size()>0){
            for(user u: [Select id , contact.Service_Provider__r.Site__c from user where contact.Service_Provider__c IN : spIds])
            {
                
                if(!spUserIDMap.containskey(u.contact.Service_Provider__r.Site__c)){
                    spUserIDMap.put(u.contact.Service_Provider__r.Site__c,new list<User>());
                }
                spUserIDMap.get(u.contact.Service_Provider__r.Site__c).add(u);
            }
            
        }
        system.debug('spUserIDMap-------------'+spUserIDMap);
        list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        
        for(Engagement_Activities__c e:[select id, name,Site__c,Activity_Name__c,Start_Date__c,Site__r.Name from Engagement_Activities__c where id IN : enActivityIds ]){
            
        //    system.debug('spUserIDMap-------------'+srvcProMap.containsKey(e.Site__c));
              system.debug('spUserIDMap.containsKey(e.Site__c)-------------'+spUserIDMap.containsKey(e.Site__c));
            if(spUserIDMap.containsKey(e.Site__c)){
                for( user u:spUserIDMap.get(e.Site__c)) {
                    
                    Notification__c noti = new Notification__c();
                    noti.User_Id__c = u.Id;
                    
                    string startda=string.valueOf(e.Start_Date__c);
                  
                    list<string> startDate=startda.split(' ');
                    
                    noti.Message__c = 'Engagement Activity - ' + e.Activity_Name__c + ' is conducted for the Site  - ' +e.Site__r.Name + ' and the Start date is ' + startDate[0] ;
                    notificationInsertlist.add(noti);
                }
            }
            
            
            
        }
        if(notificationInsertlist.size()>0){
            insert notificationInsertlist;
            system.debug(' insert notificationInsertlist;'+notificationInsertlist);
        }
       
    }
}