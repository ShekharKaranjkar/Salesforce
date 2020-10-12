public class eventctrl {
    @auraenabled
    public static classeventwrapper getevent(string eventid){
        event even=[select id,StartDateTime,Enddatetime,Location,Subject,Description,IsAllDayEvent,WhatId,Attendes__c,OwnerId,Owner.Name,WhoId, 
                    Vehicles__c,Drivers__c,Operations__c,New_Opportunities__c,Technology__c,Threats__c from event where id =:eventid];
        /// update even;
        system.debug('WhatId ' + even);
        Map<String,String>Selectedlist= new Map<String,String>();
        if(even.Attendes__c!=Null){
            for(string i:even.Attendes__c.split(';')){
                Selectedlist.put(i,i);
            }
        }
        Id accid;
        If(even.WhatId!=Null && even.WhatId.getSobjectType() == contact.SobjectType){
            List<Contact> conList = [Select Id,AccountID From Contact Where Id=:even.WhoId AND AccountId !=null];
            if(!conList.IsEmpty())
                accid = conList.get(0).AccountId;
        }
        List<AccountContactRelation>AccountcontactRelastionshipList = New List<AccountContactRelation>();
        if(even.WhatId !=NUll && even.WhatId.getSObjectType() == Account.sObjectType || accid != NUll)
            AccountcontactRelastionshipList = [Select id,Contact.Name from AccountContactRelation where Accountid=:even.WhatId Or Accountid=:accid];
        //for(AccountContactRelation AC:[Select id,Contact.Name from AccountContactRelation where Accountid=:even.WhatId]){
        //if(!Selectedlist.containsKey(AC.Contact.Name))
        //AccountcontactRelastionshipList.add(AC);
        //}
        classeventwrapper wrapper = new classeventwrapper();
        wrapper.eventrecord = even;
        wrapper.AccountcontactRelastionList= AccountcontactRelastionshipList;
        wrapper.Selectedlist=Selectedlist;
        if(even.WhatId !=NUll && even.WhatId.getSObjectType() == Account.sObjectType)
            wrapper.accrecord = [Select id,Name from Account where ID=:even.WhatId];
        else
            wrapper.accrecord = Null; 
        if(even.WhoId !=NUll && even.WhoId.getSObjectType() == Contact.sObjectType)
            wrapper.ContactRecords = [Select id,Name,AccountId,Account.Name from Contact where ID=:even.WhoId];
        else 
            wrapper.ContactRecords = Null;
        return wrapper;
    }
    public Class classeventwrapper{
        @AuraEnabled
        Public Event eventrecord {Set;Get;}
        @AuraEnabled
        Public List<AccountContactRelation>AccountcontactRelastionList{Set;Get;}
        @AuraEnabled 
        Public Map<String,String>Selectedlist{Set;Get;}
        @AuraEnabled
        Public Account accrecord {Set;Get;}
        @AuraEnabled
        Public List<Contact> ContactRecords {Set;Get;}
    }
    @AuraEnabled
    Public Static void updateEvent(Event eventrec,List<String>selectedlist){
        System.debug('multilist'+selectedlist);
        Event eventre = eventrec;
        
        For(String s:selectedlist){
            if(eventre.Attendes__c!=null){
                if(!eventre.Attendes__c.contains(s))
                    eventre.Attendes__c = eventre.Attendes__c+s+';'; 
            }
            else
                eventre.Attendes__c = s+';'; 
        }
        update eventre;
        
    }
    /*@AuraEnabled
public static string saveDetails (Contact regForm1){
INSERT regForm1;
if(regForm1.Id!=Null)
Return 'Sucess';
else
return 'Error';
}*/
    @AuraEnabled
    Public Static void updateeventinserttask(List<Task>tasklist,String eventre,String over,String meet,String MeetingSummary){
        system.debug('$$'+meet);
        event ld = (event) JSON.deserialize(meet, event.class);
        String accountId = [SELECT Id,WhatId FROM Event WHERE Id =: ld.id].WhatId;
        ld.WhatId = accountId;
        system.debug('!!'+ld);
        update ld;
        /* Event eve = New Event();
eve.id=eventre;
//  eve.Meeting_Summary__c=meet;
if(over !=Null)
eve.Over__c = over;
if(MeetingSummary!=null)
eve.Meeting_Summary__c = MeetingSummary;*/
        Task[] tasklist1 = new  List<Task>();
        //system.debug('lll'+eventre.Id);
        
        system.debug('Step 4 ' +[SELECT Id,WhatId FROM Event WHERE Id =: ld.id] );
        for(task ta:tasklist){
            
            system.debug('lll'+ta.OwnerId);
            // Task t = new Task(  RecordTypeId='0125D000000QR4OQAW',WhatId=eventre.WhatId,Subject=ta.Subject,OwnerId=userinfo.getUserId(),ActivityDate = ta.ActivityDate,Event_ID__c=eventre.Id);
            //tasklist1.add(t);
            system.debug('ld.id s' + ld.id);
            ta.Event_ID__c = ld.id;
            system.debug('haha'+accountId);
            if(String.isNotBlank(accountId))
                ta.WhatId = accountId;
        }
        insert tasklist;
        //update eve;
    }
    /*public static string updateeventinserttask (List<task> taskList, event eve,string assignedto){
system.debug( ''+ eve+''+ assignedto);
Update eve;
List<Task>inserTaksList =New List<Task>();
Map<Integer,String>subjectMap = new Map<Integer,String>{0=>'Vehicles',1=>'Operation'};
For(integer i =0;i<taskList.size();i++){
if(i>5){
Task t = new task (subject=subjectMap.get(0),Category__c=taskList.get(i).Category__c,text__c=taskList.get(i).text__c);
inserTaksList.add(t);}else{
Task t = new task (subject=subjectMap.get(i),Category__c=taskList.get(i).Category__c,text__c=taskList.get(i).text__c);
inserTaksList.add(t);
}
}
insert inserTaksList;
String assigne = '%'+assignedto+'%';
system.debug('@@@'+ta.Subject);

User u = [Select Id , Name from User Where Name Like: assigne];
ta.OwnerId= u.id;
ta.RecordTypeId='0125D000000QR4OQAW';
insert ta;
return null;
}*/
    @AuraEnabled
    Public static List<AccountContactRelation> getAccountcontactRelastionshiprecords(string accountid){
        return [Select id,Contact.Name,Contact.Email from AccountContactRelation where Accountid=:accountid];
    }
}