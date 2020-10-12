public class LeaveNotificationHelper {
    
    public static void createNotification(list<Leave__c>leaveList){
        Id leaveTypeId = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Emergency_Leave').getRecordTypeId();
        Id leaveTypeIdplanned = Schema.SObjectType.Leave__c.getRecordTypeInfosByDeveloperName().get('Planned_Leave').getRecordTypeId();
        set<string> setnumber =new set<string>();
        
        for(Leave__c leaRecords :[select id,Name,Service_Provider__r.Name,Service_Provider__r.Phone_Number__c,Service_Provider__r.Status__c,
                                  Service_Provider__c
                                  from Leave__c Where Service_Provider__r.Status__c ='Active' AND  Service_Provider__c != null  AND id=:leaveList])
        {
            setnumber.add(leaRecords.Service_Provider__c);
        }
        date todays = system.today();
        set<string> userList =new set<string>();
        Map<Id,Id> userIdMap= new Map<Id,Id>();
        for(User us:[select id,username,Name,Contact.Service_Provider__c from User where Contact.Service_Provider__c In:setnumber ]){
            userIdMap.put(us.Contact.Service_Provider__c,us.Id);
            userList.add(us.id);
        }
        
        for(Leave__c le1 :leaveList ){
            if(userIdMap.containsKey(le1.Service_Provider__c)){
                if(le1.From_date__c != null){
                    string startda=string.valueOf(le1.From_date__c);
                    list<string> startDate=startda.split(' ');
                    string endda=string.valueOf(le1.To_date__c);
                    list<string> endDate=endda.split(' ');
                    if(le1.RecordTypeId == leaveTypeIdplanned &&  le1.Approval_Request__c == 'Rejected'){ 
                        Notification__c noti = new Notification__c();
                        noti.User_Id__c = userIdMap.get(le1.Service_Provider__c);
                        noti.Message__c = 'Your Planned EOS is Rejected From Date - ' + startDate[0] +' To Date - ' + endDate[0] +' as 10% of the pool are already on Leave  ';
                        insert noti;
                    }
                    
                    
                    else if(le1.Approval_Request__c =='Approved By Hr' && le1.RecordTypeId == leaveTypeIdplanned){
                        
                        Notification__c noti = new Notification__c();
                        noti.User_Id__c = userIdMap.get(le1.Service_Provider__c);
                        noti.Message__c = 'Your Planned EOS is Approved From Date - ' +  startDate[0] +' To Date - ' + endDate[0] ;
                        // noti.Compliance__c = com.id;
                        insert   noti;
                    }
                    if(le1.RecordTypeId == leaveTypeId && le1.Emergency_Leave_Approval__c =='Approved'  ){
                        system.debug('104');
                        Notification__c noti = new Notification__c();
                        noti.Message__c = 'Your Emergency EOS is Approved From Date - ' +  startDate[0] + ' To Date - ' + endDate[0] ;
                    }
                    else if(le1.RecordTypeId == leaveTypeId && le1.Emergency_Leave_Approval__c =='Rejected' ){
                        system.debug('113');
                        Notification__c noti = new Notification__c();
                        noti.User_Id__c = userIdMap.get(le1.Service_Provider__c);
                        noti.Message__c = 'Your Emergency EOS is Rejected From Date - '+   startDate[0] +' To Date - ' + endDate[0] ;
                        // noti.Compliance__c = com.id;
                        insert   noti;
                        system.debug('noti 119'+noti);
                    }
                }
            }
            
        }
        
    }
}