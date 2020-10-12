/*
** sendNotification this method sending notification to 'Account Teams','Maintanence Team' & 'Particular campus assigned Site Manager'.
** validations this method is to check if F&F made check box 'true' they can't able to Active the SP .
** If F&F Made is not true and inactive from date is more than 60 day error messages we are showing.. 
*/ 

public class InactiveNotificationsToUsers {
    public static void sendNotification(list<Service_Provider__c> spList,Map<id,Service_Provider__c> sptMap){
        set<string> setnumber =new set<string>();
        List<String>userIdsList = New List<String>();
        List<String>useremailList = New List<String>();
        List<String>usernameList = New List<String>();
        List<String>userIdsSM = New List<String>();
        List<String>useremailSM = New List<String>();
        List<String>userIdsAT = New List<String>();
        List<String>useremailAT = New List<String>();
        Map<id,User> usMap = new  Map<id,User>();
        Map<id,Service_Provider__c> service = new  Map<id,Service_Provider__c>();
        list<String> emList = new  list<String>();
        for(Service_Provider__c conRecords :[ select id,Name,Status__c, Site__c, Site__r.Name, Site__r.Site_Supervisor__c,Phone_Number__c, Inactive_From__c,Site__r.Maintenance_Manager__c,
                                             Site__r.Site_Incharge__r.Name from Service_Provider__c  where id=:spList AND Status__c='InActive'])
        {
            
            system.debug('setnumber9'+setnumber);
        }
        
        
        for (User member :  [select id,Email,Name from User where IsActive = True AND  Profile.Name in ('System Administrator','Site Manager')]){
            userIdsList.add(member.id);
            useremailList.add(member.Email);
            
            usMap.put(member.id,member);
        }
        
        for (User member :  [select id,Email,Name from User where IsActive = True AND  Profile.Name in ('Maintenance Head','Maintenance Manager','Maintenance Executive')]){
            userIdsList.add(member.id);
            useremailList.add(member.Email);
            usernameList.add(member.Name);
            usMap.put(member.id,member);
        }
        for (User sm :  [select id,Email,Name from User where IsActive = True AND  Profile.Name in ('Site Manager')]){
            userIdsSM.add(sm.id);
            useremailSM.add(sm.Email);
            //  usernameList.add(sm.Name);
            usMap.put(sm.id,sm);
            
        }
        for (User ATT :  [select id,Email,Name from User where IsActive = True AND  Profile.Name in ('System Administrator','Account Team')]){
           // userIdsAT.add(ATT.id);
            useremailAT.add(ATT.Email);
            usernameList.add(ATT.Name);
            usMap.put(ATT.id,ATT);
        }
        
        String messageBody;
        Id comIdOne;
        string comname;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        for(Service_Provider__c le1 :[ select id,Name,Status__c, Site__c, Site__r.Name, Site__r.Site_Supervisor__c,Phone_Number__c,
                                      Inactive_From__c,Site__r.Maintenance_Manager__c,Site__r.Site_Supervisor__r.Email,
                                      Site__r.Maintenance_Manager__r.Email,
                                      Site__r.Site_Incharge__r.Name from Service_Provider__c  where Id=:spList AND Status__c='InActive'] )
        {
            comIdOne=le1.Id;
            comname=le1.Name;
            if(le1.Inactive_From__c !=null){
                string startda=string.valueOf(le1.Inactive_From__c);
                system.debug('startda'+startda);
                List<String> emaiAddLst = new List<String>();
                list<string> startDate=startda.split(' ');
                If(sptMap.get(le1.id).Status__c!=le1.Status__c ){ 
                    if(le1.Site__r.Site_Supervisor__c != NULL)
                        emaiAddLst.add(le1.Site__r.Site_Supervisor__r.Email);
                    //mail.setToAddresses(new List<String>{le1.Site__r.Site_Supervisor__r.Email});
                    /*if( useremailSM.contains(le1.Site__r.Site_Supervisor__c ) ){
usMap.containskey(le1.Site__r.Site_Supervisor__c);

} */
                    if(useremailAT.size()>0)
                        emaiAddLst.addAll(useremailAT);
                   
                    if(le1.Site__r.Maintenance_Manager__c != NULL)
                        emaiAddLst.add(le1.Site__r.Maintenance_Manager__r.Email);
                      
                    if(emaiAddLst.size() > 0){
                        mail.setToAddresses(emaiAddLst); 
                    }
                    mail.setSubject('Exit Process for Service Provider');
                    mail.setSaveAsActivity(false);
                    
                    messageBody = '<html><body> Hi Sir/Madam, '  + '<br><br>This Email is Regarding to Inform you that the Service Provider Name - ' + comname + ' is going to Exit on Date - ' + startDate[0]+' .' +'<br><br>For More Query Please contact to HR or Admin regarding Exit Process.' +'<br><br> Thanks and Regards,</body></html>';
                    mail.setHtmlBody(messageBody);
                    if(!Test.isRunningTest() && emaiAddLst.size() > 0){
                        
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                }                
            }   
        }
    }
    public static void validations(list<Service_Provider__c> serviceList,Map<id,Service_Provider__c> sptMap){
        
        for(Service_Provider__c le1 :serviceList ){
            if(le1.Inactive_From__c !=null){
                Date startDate =  le1.Inactive_From__c ;
                // DateTime Lastmodifydate = le1.LastModifiedDate;
                DateTime dt = system.now();
                Date myDate = date.newinstance(dt.year(), dt.month(), dt.day());
                system.debug('myDate'+myDate);  
                
                Integer noOfDays = startDate.daysBetween(myDate);
                system.debug('noOfDays'+noOfDays);
                If(sptMap.get(le1.id).Status__c!=le1.Status__c){ 
                    system.debug('insisde if'+sptMap.get(le1.id).Status__c);
                    if(le1.Status__c =='Active' && le1.F_F_Made__c == true){
                        system.debug('109');
                        le1.addError('You Cannot Activate this Service Provider because the F&F Made is Active');
                    }
                    else if ( le1.Status__c =='Active'  && noOfDays >= 60){
                        system.debug('122');
                        le1.addError('You Can only Activate this Service Provider within 2 months of Inactive From Date');
                    }
                }
                
                
            }
        }
    }
}