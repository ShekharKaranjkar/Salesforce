@IsTest
public class ServicecenterEmailServiceCtrl_Test {
@istest
    static void emailservicetestmethod(){
         Service_Center__c ser4 = new Service_Center__c();
        ser4.Name = 'kavery nagar ';
        //ser4.Located_City__c = cit.id;
        ser4.State_Province__c = 'TN';
        ser4.Location__Latitude__s =12.9972 ;
        ser4.Location__Longitude__s =77.7044;
        ser4.Street__c = 'Kumaran Nagar';
       // ser4.OwnerId = usrObj.id;
       // ser4.Pincode__c = 636401;
    //    ser4.Zip_Postal_Code__c = 636401;
        ser4.Location__Latitude__s =12.9972 ;
        ser4.Location__Longitude__s=77.7044 ;
        insert ser4;
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();
         List<Service_Center__c>sharedList=[select id,Name,Service_Center_Number__c from Service_Center__c];
        system.debug('!@!@!@'+sharedList);
        email.subject = '[ Bengalure : '+sharedList.get(0).Service_Center_Number__c+']test service center emailservice ctrl';
        email.htmlBody='Testing is not completed.['+sharedList.get(0).Service_Center_Number__c+']';
        email.plainTextBody = '[ Bengalure : '+sharedList.get(0).Service_Center_Number__c+'],Testing is not completed.';
        email.fromAddress = 'vijay@dazeworks.com';
        List<String> toaddress = new List<String>{'vijay@dazeworks.com','abcd@sfdc.com'}; 
            email.toAddresses =toaddress;
        List<String> ccaddress = new List<String>{'test@sfdc.com'}; 
            email.ccAddresses =ccaddress;
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfileone.txt';
        attachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
            
            Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        attachmenttext.body = 'my attachment text';
        attachmenttext.fileName = 'textfiletwo3.txt';
        attachmenttext.mimeTypeSubType = 'texttwo/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
            
            ServicecenterEmailServiceCtrl servicecenterobj = new ServicecenterEmailServiceCtrl();
        servicecenterobj.handleInboundEmail(email, env );
    }
}