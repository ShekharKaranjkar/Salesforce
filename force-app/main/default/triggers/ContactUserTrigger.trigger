trigger ContactUserTrigger on Contact (after insert) {
  if(Trigger.isInsert && Trigger.isAfter){
      system.debug('inside user trigger');
        List<User> usrLst = new List<User>(); 
        
        String profId = [select Id from Profile where name='SP' limit 1].Id;
         system.debug('Profile'+profId);
        for(Contact con : [SELECT id,email,firstName,lastname,accountId,MobilePhone,Lithium_ID__c from Contact 
                            where Id =:Trigger.newMap.keySet() AND Account.Name ='Lithium Service Providers']){
            
            //Users creation for Lithium Service Providers Account
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.EmailHeader.triggerUserEmail = false;       
            dmo.EmailHeader.triggerOtherEmail = false;
            dmo.EmailHeader.triggerAutoResponseEmail = false;       
            dmo.optAllOrNone = false;
            
            
            ////
            String orgId = UserInfo.getOrganizationId();
            String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
            Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
            String uniqueName = orgId + dateString + randomInt;
            if(uniqueName.length()>51)
            {
                 uniqueName=uniqueName.substring(0,51);
             }
            
            ////
            system.debug('contact name'+con.firstName);
            // create portal user
            string nick = con.MobilePhone;
            nick += Datetime.now().getTime();
            User newUser = new User(
                                alias = uniqueName.substring(18, 23), 
                                email = Label.Service_Email_Address,
                                emailencodingkey = 'UTF-8', 
                                firstname = con.firstName, 
                                lastname = con.lastname, 
                                MobilePhone = con.MobilePhone,
                                languagelocalekey = 'en_US', 
                                localesidkey = 'en_US', 
                                contactId = con.Id,
                                timezonesidkey = 'Asia/Kolkata', 
                                username = con.MobilePhone+'@lithium.com',//con.email,
                                CommunityNickname = nick,
                                ProfileId = profId,
                				Employee_Id__c = con.Lithium_ID__c,
                                IsActive = true);
            
            newUser.setOptions(dmo);      
            usrLst.add(newUser);  
                                system.debug('newUser'+newUser);
        }
        if(usrLst.size() > 0){
            insert usrLst;
            system.debug('usrLst'+usrLst);
        }
    }

}