/*
 * * Notification Record will create based on City Ops is Approved for Penalty..
 */ 

public class PenaltyNotificationhelper {
    public static void createNotification(list<Penalty__c>penaltyList,Map<id,Penalty__c> penMap){
system.debug('inside Penality'+penMap.Keyset());
        set<string> setnumber =new set<string>();
             set<string> serviceProIds = new set<string>();
        for(Penalty__c co:  [select id,Lithium_ID__c,Service_Provider_Name__r.Name, Service_Provider_Name__r.Phone_Number__c,Service_Provider_Name__c from Penalty__c where id=: penMap.Keyset()]){
            serviceProIds.add(co.Service_Provider_Name__c);
            
        }
         for(Penalty__c penaltyRecords :[select id,Name,Service_provider_name1__c,Service_Provider_Name__c,Service_Provider_Name__r.Phone_Number__c,Status__c,
                                         Service_Provider_Name__r.Name,Service_Provider_Name__r.Status__c
                                          from Penalty__c Where Service_Provider_Name__c != null  AND id=:penaltyList AND Service_Provider_Name__r.Status__c='Active']){
                                         //  setnumber.add(penaltyRecords.Service_Provider_Name__r.Phone_Number__c +'@lithium.com');
                                            // setnumber.add(penaltyRecords.Service_Provider_Name__r.Name);
                                              system.debug('setnumber9'+setnumber);
                                          }
            list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        
          Map<Id,Id> serviceProIDUserIdMap= new Map<Id,Id>();
        for(user u:[select id,username,Name,contact.Service_Provider__c from User where contact.Service_Provider__c  IN :serviceProIds]){
            serviceProIDUserIdMap.put(u.contact.Service_Provider__c,u.Id);
        }
        // list<user> userId= [select id,username,Name from User where username =:setnumber ];
        for(Penalty__c le1 :penaltyList ){
            system.debug('le134'+le1);
            // username = con.MobilePhone+'@lithium.com',//con.email,
           
          //  system.debug('userId----------'+userId);
             If(penMap.get(le1.id).Status__c!=le1.Status__c && serviceProIDUserIdMap.containsKey(le1.Service_Provider_Name__c)){ 
            if(le1.Service_Provider_Name__c !=null && le1.Status__c =='Approved by City Ops'){
                system.debug('21line----------');
                Notification__c noti = new Notification__c();
                noti.User_Id__c = serviceProIDUserIdMap.get(le1.Service_Provider_Name__c);
                noti.Message__c = 'Penalty has been raised for '+ le1.Penalty_Reason__c + ' and Penalty Amount ₹'+ le1.Amount__c ;
                 insert noti;
                system.debug('noti==========='+noti);
            }
             }
        }
        }
    
    
    }