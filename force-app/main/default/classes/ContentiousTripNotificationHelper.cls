/*
* * Notification Record will create based on City Ops is Approved for Continous Trip..
*/ 

public class ContentiousTripNotificationHelper {
    
    public static void createNotification(list<Continous_trip__c> conList,Map<id,Continous_trip__c> conMap){
        set<string> setnumber =new set<string>();
        set<string> serviceProviderIds = new set<string>();
        Map<Id,Id> serviceProIDUserIdMap= new Map<Id,Id>();
        for(Continous_trip__c conRecords :[select id,Name,Status__c,Service_Provider__c,Service_Provider__r.Phone_Number__c,Service_Provider__r.Name,Service_Provider__r.Status__c
                                           from Continous_trip__c Where Service_Provider__r.Status__c ='Active' AND Service_Provider__c != null  AND id=:conList]){
                                               //   setnumber.add(conRecords.Service_Provider__r.Phone_Number__c +'@lithium.com');
                                               //   setnumber.add(conRecords.Service_Provider__r.Name);
                                               serviceProviderIds.add(conRecords.Service_Provider__c);
                                               
                                               system.debug('setnumber9'+setnumber);
                                           }
        
        //    list<user> userId= [select id,username,Name from User where username =:setnumber ];
        //    list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        for(user u:[select id,username,Name,contact.Service_Provider__c from User where contact.Service_Provider__c in :serviceProviderIds])
        {
            serviceProIDUserIdMap.put(u.contact.Service_Provider__c,u.Id);
            
        }
        for(Continous_trip__c le1 :conList ){
            system.debug('le134'+le1);
            // username = con.MobilePhone+'@lithium.com',//con.email,
            
            Time  startTime =Time.newInstance(le1.Trip_Start__c.hour(), le1.Trip_Start__c.minute(),0,0);
            Time  endTime =Time.newInstance(le1.Trip_End__c.hour(), le1.Trip_End__c.minute(),0,0);
            string startTim=TimeFormat.timeFormat(startTime);
            string endTim=TimeFormat.timeFormat(endTime);
            
            string startda=string.valueOf(le1.Trip_Start__c);
            system.debug('startda'+startda);
            list<string> startDate=startda.split(' ');
            
            string endda=string.valueOf(le1.Trip_End__c);
            system.debug('endda'+endda);
            list<string> endDate=endda.split(' ');
            if(serviceProIDUserIdMap.containsKey(le1.Service_Provider__c)){
              //  system.debug('userId----------'+userId);
                If(conMap.get(le1.id).Status__c!=le1.Status__c){ 
                    if(le1.Service_Provider__c !=null && le1.Status__c =='Approved by City Ops'){
                        
                        Notification__c noti = new Notification__c();
                        noti.User_Id__c = serviceProIDUserIdMap.get(le1.Service_Provider__c);
                        noti.Message__c = 'Continous Trip has been Approved from '+  startDate[0] + ' to ' + endDate[0] +  ' Trip Timings are '+ startTim  +' To ' + endTim  +' and Shift is ' + le1.Shift__c ;
                        
                        insert noti;
                    }    
                }
            }/*else

if(le1.Service_Provider__c !=null && le1.Status__c =='Rejected'){

Notification__c noti = new Notification__c();
noti.User_Id__c = userId[0].id;
noti.Message__c = 'Continous Trip has been Rejected from ' + le1.Trip_Start__c + 'to' + le1.Trip_End__c + 'and shift is' + le1.Shift__c  ;

insert noti;

}*/
        }
    }
}