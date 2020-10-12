public class Generatepdf {
    @AuraEnabled
    public static void quoteSave(String recordId){
        PageReference defaultPage = Page.createpdf; 
        defaultPage.getParameters().put('recid',recordId); 
        Blob pageData; 
        if(!Test.isRunningTest()){ 
            pageData = defaultPage.getContentAsPDF();
        } else {
            pageData = Blob.valueOf('Unit.test');
        }
        //create attachment
        Attachment att = new Attachment(
            ParentId=recordId,
            Body=pageData,
            Name='Invoice ' + DateTime.now().formatLong() + '.pdf'
        );
        insert att;
        
    }
    @AuraEnabled
    public static void sendquote(string recordId,string address1,string subject,string body,string cc1,string bcc1){
        system.debug('recordId'+recordId +'address'+address1 +'subject'+subject+'body'+body+'cc'+cc1 +'bcc'+bcc1);
        
        system.debug('Step1');
        PageReference defaultPageEmail = Page.createpdf; 
        defaultPageEmail.getParameters().put('recid',recordId); 
        Blob pageDataEmail; 
        if(!Test.isRunningTest()){ 
            pageDataEmail = defaultPageEmail.getContentAsPDF();
        } else {
            pageDataEmail = Blob.valueOf('This is a test.');
        }
        //create attachment
        Attachment att = new Attachment(
            ParentId=recordId,
            Body=pageDataEmail,
            Name='InvoiceSend ' + DateTime.now().formatLong() + '.pdf'
        );
        insert att;
        system.debug('tt'+att);
        //  Invoices__c quoteObj=[SELECT Id,Account__r.Name,Date__c FROM Invoices__c limit 1];
        //  Account acc = [select id, name, (select id, name ,Email from Contacts) from account ];
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo =(List<String>) JSON.deserialize(address1, List<String>.class);
        System.debug('sendTo '+ sendTo);
        mail.setToAddresses(sendTo);
        //system.debug('qq'+sendTo);
        
        mail.setReplyTo('noreply@gmail.com'); 
        mail.setSenderDisplayName('Lithium Urban Technologies Pvt Ltd'); 
        
         List<String> ccTo =(List<String>) JSON.deserialize(cc1, List<String>.class);
        System.debug('ccTo '+ ccTo);
        mail.setCcAddresses(ccTo);
        
        //List<String> ccTo = new List<String>();
        //ccTo.add(cc);
        //mail.setCcAddresses(ccTo);
        
         List<String> bccTo =(List<String>) JSON.deserialize(bcc1, List<String>.class);
        System.debug('bccTo '+ bccTo);
        mail.setBccAddresses(bccTo);
        //List<String> bccTo = new List<String>();
        //bccTo.add(bcc);
        //mail.setBccAddresses(bccTo);
        
        
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        
        
        mails.add(mail);
        
        // Messaging.sendEmail(mails);
        
        
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment order By createdDate DESC Limit 1])
        {
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(a.Name);
            efa.setBody(a.Body);
            fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
        Messaging.sendEmail(mails);
        system.debug('dd'+fileAttachments);
    }
    
}