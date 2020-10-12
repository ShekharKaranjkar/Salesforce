public class ApprovalsRequestTriggerHandler {
    public static void statusChanged(List<Approval_Request__c>apList ,map<id,Approval_Request__c>aprequstMap){
        Set<id> apId=new Set<id>();
        Set<id>approvalId=new Set<id>();
        Set<id>serviceProviderId=new Set<id>();
        map<id,Rostering__c>serviceProviderVsdate=new map<id,Rostering__c>();
        map<String,Id>usernameAndIdmap=new map<String,Id>();
        for(Approval_Request__c a:apList){
            if(a.Status__c!=aprequstMap.get(a.id).Status__c){
                apId.add(a.Id);
                
            }
            if(a.Status__c=='Approved' && a.Status__c!=aprequstMap.get(a.id).Status__c){
                approvalId.add(a.Id);
                
            }
        }
        system.debug('apId============'+apId);
        list<Rostering__c>roList= new list<Rostering__c>();
        
        
        
        
        for(Rostering__c r:[select id, status__c,Approval_Request__r.Status__c,Lithium_ID__c from Rostering__c where Approval_Request__c In: apId]){
            r.status__c=r.Approval_Request__r.Status__c;
            roList.add(r);
            //  serviceProviderId.add(r.Lithium_ID__c);
        }
        if(roList.size()>0){
            system.debug('roList============'+roList);
            update roList;
        }
        system.debug('serviceProviderId============'+serviceProviderId);
        list<Rostering__c> roListForNotification = new list<Rostering__c>();
        
        list<Notification__c> notificationInsertlist = new  list<Notification__c>();
        list<String> setnumber = new  list<String>();
        if(approvalId.size()>0){
            roListForNotification=[select id,Lithium_ID__r.Name,  RecordType.Name,Shift_Start_Date__c, Shift_End_Date__c, Start_Time__c,Lithium_ID__r.Phone_Number__c,
                                   End_Time__c,  status__c,Approval_Request__r.Status__c, Lithium_ID__c
                                   from Rostering__c 
                                   where Approval_Request__c In: approvalId];
            for(Rostering__c r:roListForNotification){
                setnumber.add(r.Lithium_ID__r.Phone_Number__c +'@lithium.com');
            }
            for(user u: [select id,username,Name from User where Username in :setnumber]){
                usernameAndIdmap.put(u.username,u.Id);
            }
            
            for(Rostering__c r :roListForNotification )
            {
                //  serviceProviderId.add(r.Lithium_ID__c);
                setnumber.add(r.Lithium_ID__r.Phone_Number__c +'@lithium.com');
                if(r.Lithium_ID__r.Name !=null)
                {
                    
                    string startTim=TimeFormat.timeFormat(r.Start_Time__c);
                    string endTim=TimeFormat.timeFormat(r.End_Time__c);
                    string startda=string.valueOf(r.Shift_Start_Date__c);
                    string endda=string.valueOf(r.Shift_End_Date__c);
                    list<string> startDate=startda.split(' ');
                    list<string> endDate=endda.split(' ');
                    Notification__c noti = new Notification__c();
                    noti.User_Id__c = usernameAndIdmap.get(r.Lithium_ID__r.Phone_Number__c +'@lithium.com');
                    noti.Message__c =  r.RecordType.Name+' Roster for Date '+startDate[0] +' To '+endDate[0]+' Shift Timings are '+startTim +' To '+endTim  ;
                    notificationInsertlist.add(noti);
                }
            }
        }
        
        if(notificationInsertlist.size()> 0){
            insert notificationInsertlist;
        }
        
        Map<id,rostering__c> rosterMap=new map<id,Rostering__c>();
        List<Rostering__c>rosNewListToUpdate=new List<Rostering__c>();
        List<Rostering__c>rosterApprovalList=[select id, status__c,Approval_Request__r.Status__c,Lithium_ID__c,Shift_Start_Date__c
                                              from Rostering__c
                                              where Approval_Request__c In: approvalId];
        for(Rostering__c r:rosterApprovalList)
        {
            // serviceProviderId.add(r.Lithium_ID__c);
            serviceProviderVsdate.put(r.Lithium_ID__c,r);
        }  
        system.debug('serviceProviderVsdate'+serviceProviderVsdate);
        // system.debug('serviceProviderId'+serviceProviderId);
        Set<Id> RostId=new set<Id>();
        for(Rostering__c r:[select id, status__c,Approval_Request__r.Status__c,Lithium_ID__c,Shift_Start_Date__c,Shift_End_Date__c
                            from Rostering__c
                            where Lithium_ID__c In:serviceProviderVsdate.keyset() ANd status__c='Approved'  ])
        {
            if(serviceProviderVsdate.get(r.Lithium_ID__c).Shift_Start_Date__c> r.Shift_Start_Date__c && 
               serviceProviderVsdate.get(r.Lithium_ID__c).Shift_Start_Date__c< r.Shift_End_Date__c  )
            {
                rosterMap.put(r.Lithium_ID__c,r);   
            }
        }
        
        system.debug('rosterMap'+rosterMap);
        if(rosterMap.size()>0){
            for(Rostering__c r:rosterApprovalList)
            {
                if(r.Shift_Start_Date__c>rosterMap.get(r.Lithium_ID__c).Shift_Start_Date__c 
                   && r.Shift_Start_Date__c<rosterMap.get(r.Lithium_ID__c).Shift_End_Date__c && r.Status__c=='Approved')
                {
                    rosterMap.get(r.Lithium_ID__c).Shift_End_Date__c=r.Shift_Start_Date__c.addDays(-1);
                    rosNewListToUpdate.add(rosterMap.get(r.Lithium_ID__c));
                }
                
            }
            update rosNewListToUpdate;
        }
        
        
    }
    
}