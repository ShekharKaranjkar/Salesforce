/*
** Notification Records ill create depends on the campus assigned 'site incharge' once 'Approved/ Rejected'..  
*/ 

public class AttendanceNotificationHelper {
    public static void createNotification(list<Attendance__c>attenList,Map<id,Attendance__c> AttentMap){
        // set<string> setnames = new set<string>();
        set<string> serviceProviderIds = new set<string>();
        Map<Id,Id> serviceProIDUserIdMap= new Map<Id,Id>();
        
        for(Attendance__c attenRecords : [select id,Name,Status__c,Service_Provider__c,Lithium_ID__c,Service_Provider__r.Name,Service_Provider__r.Phone_Number__c,
                                          CreatedDate,Service_Provider__r.Status__c from Attendance__c 
                                          where Service_Provider__r.Status__c = 'Active' AND CreatedDate= Today  AND id=:attenList ])
        {
            
            serviceProviderIds.add(attenRecords.Service_Provider__c);
            
        }
        list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        
        list<user> userId= [select id,username,Name from User where contact.Service_Provider__c in :serviceProviderIds];
        
        for(user u:[select id,username,Name,contact.Service_Provider__c from User where contact.Service_Provider__c in :serviceProviderIds])
        {
            serviceProIDUserIdMap.put(u.contact.Service_Provider__c,u.Id);
            
        }
        system.debug('userId----------'+userId);
        for(Attendance__c al :attenList ){
            system.debug('al34'+al);
            if(serviceProIDUserIdMap.containsKey(al.Service_Provider__c)){
                If(AttentMap.get(al.id).Status__c!=al.Status__c){ 
                    if(al.Status__c =='Approved'){
                        
                        Notification__c noti = new Notification__c();
                        noti.User_Id__c =serviceProIDUserIdMap.get(al.Service_Provider__c);
                        noti.Message__c = 'Your Attendance is Approved ';
                        // noti.Compliance__c = com.id;
                        notificationInsertlist.add(noti);
                        system.debug('notificationInsertlist 34'+notificationInsertlist);
                    }
                    else if(al.Status__c =='Rejected'){
                        
                        Notification__c noti = new Notification__c();
                        noti.User_Id__c =serviceProIDUserIdMap.get(al.Service_Provider__c);
                        noti.Message__c = 'Your Attendance is Rejected ';
                        // noti.Compliance__c = com.id;
                        notificationInsertlist.add(noti);
                        system.debug('notificationInsertlist 34'+notificationInsertlist);
                    }
                }
                
            }
            if(notificationInsertlist.size()> 0){
                insert notificationInsertlist;
                system.debug('notificationInsertlist---------->>>'+notificationInsertlist);
            }
        }
    }
}