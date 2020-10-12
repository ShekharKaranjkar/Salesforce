public class MomEmailTriggerHandler {
    public static void handleMethod(list<event> evtList){
        system.debug('***event--->'+evtList);
        event eve = evtList[0];
        string text = eve.Attendes__c;
        if(text!=null){
        string subject = eve.Subject;
        date startDate = eve.StartDateTime.date();
        date EndDate = eve.EndDateTime.date();
        string DiscussionPoints = eve.Discussion_Points__c;
        List<String> parts = text.split(';');   
        string test = parts[parts.size()-1];
        system.debug('***send to -->'+test);
        list<AccountContactRelation> emailId = [Select id, Contact.Name, Contact.Email from AccountContactRelation where Contact.Name =: parts AND Contact.Email != NUll];
        list<Messaging.singleEmailMessage> mails=new list<Messaging.SingleEmailMessage>();
            for(AccountContactRelation acc: emailId){
            system.debug('***name-->'+acc.Contact.Name);
            system.debug('***email-->'+acc.Contact.Email);
            string mail = acc.Contact.Email;
            //string mail = 'nikitha@dazeworks.com';
            //
            mails.add(sendEmail(mail,subject,startDate,EndDate,DiscussionPoints));
        }
            If(mails.Size()>0)
                messaging.sendEmail(mails);
        }
    }
        
        public static Messaging.SingleEmailMessage sendEmail(string email, string subject, date start, date endDate, string discuss){
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            String[] sendingTo = new String[]{email}; 
            semail.setToAddresses(sendingTo); 
            semail.setSubject(subject); 
            string body = 'Start Date: ' + string.valueOf(start) +  '\n' ;
            body += 'End Date: ' +  string.valueOf(endDate) +  '\n' ;
            body += 'Discussion Points: ' + discuss;
            semail.setPlainTextBody(body); 
           // Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        return semail;
        }
        
        
      

}