/*
 * * Notification Record will create based on City Ops is Approved for Extra Trip..
 */ 

public class ExtraTripNotificationHelper {
    public static void createNotification(list<Extra_Trip__c> exList,Map<id,Extra_Trip__c> exMap){
        set<string> setnumber =new set<string>();
         set<string> serviceProIds = new set<string>();
        for(Extra_Trip__c co:  [select id,Lithium_ID__c,Lithium_ID__r.name,Lithium_ID__r.Phone_Number__c from Extra_Trip__c  where id=: exMap.Keyset()]){
            serviceProIds.add(co.Lithium_ID__c);
            
        }
        for(Extra_Trip__c exRecords :[select id,Name,Lithium_ID__c,Lithium_ID__r.Phone_Number__c,Lithium_ID__r.Name,Lithium_ID__r.Status__c
                                      from Extra_Trip__c Where Lithium_ID__r.Status__c ='Active' AND Lithium_ID__c != null  AND id=:exList]){
                                           setnumber.add(exRecords.Lithium_ID__r.Phone_Number__c +'@lithium.com');
                                          //setnumber.add(exRecords.Lithium_ID__r.Name);
                                          system.debug('setnumber9'+setnumber);
                                      }
         Map<Id,Id> serviceProIDUserIdMap= new Map<Id,Id>();
        for(user u:[select id,username,Name,contact.Service_Provider__c from User where contact.Service_Provider__c  IN :serviceProIds]){
            serviceProIDUserIdMap.put(u.contact.Service_Provider__c,u.Id);
        }
        
        
        list<user> userId= [select id,username,Name from User where username =:setnumber ];
        //    list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        for(Extra_Trip__c le1 :exList ){
            system.debug('le134'+le1);
            // username = con.MobilePhone+'@lithium.com',//con.email,
            // 
            string startda=string.valueOf(le1.Trip_Start__c);
            system.debug('startda'+startda);
            list<string> startDate=startda.split(' ');
            
            Time  startTime =Time.newInstance(le1.Trip_Start__c.hour(), le1.Trip_Start__c.minute(),0,0);
            Time  endTime =Time.newInstance(le1.Trip_End__c.hour(), le1.Trip_End__c.minute(),0,0);
            
            string endda=string.valueOf(le1.Trip_End__c);
            system.debug('endda'+endda);
            list<string> endDate=endda.split(' '); 
            string startTim=TimeFormat.timeFormat(startTime);
            string endTim=TimeFormat.timeFormat(endTime);
            system.debug('userId----------'+userId);
               If(exMap.get(le1.id).Status__c!=le1.Status__c  && serviceProIDUserIdMap.containsKey(le1.Lithium_ID__c)){
            if(le1.Lithium_ID__c !=null && le1.Status__c =='Approved by City Ops/City head'){
                
                Notification__c noti = new Notification__c();
                noti.User_Id__c = serviceProIDUserIdMap.get(le1.Lithium_ID__c);
             //   noti.Message__c = ' Extra Trip has been Approved from ' +  startDate[0] + ' , '  + startTim  + ' to ' +  endDate[0] + ' , '  + endTim  + ' and the Amount is ' + le1.Amount__c ;
                  noti.Message__c = ' Extra Trip has been Approved from ' +  startDate[0] + ' to ' +  endDate[0] + ' Trip Timings are '+ startTim  +' To ' + endTim +' and the Amount is ' + le1.Amount__c ;
                insert noti;
                
            }
               }/*else

if(le1.Lithium_ID__c !=null && le1.Status__c =='Rejected'){

Notification__c noti = new Notification__c();
noti.User_Id__c = userId[0].id;
noti.Message__c = ' Extra Trip has been Rejected ' + le1.Trip_Start__c + ' to ' + le1.Trip_End__c + ' and the Amount is ' + le1.Amount__c ; 

insert noti;

}*/
        }
    }
    
    
}