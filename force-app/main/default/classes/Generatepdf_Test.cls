@isTest
public class Generatepdf_Test {
    static testmethod void quoteSave(){
        Lead leadObj = new Lead(Lastname='TEST_LEAD',Company='ABCDEFG',LeadSource = 'Events',Status='C1: New');
        insert leadObj;
        
        
        Attachment attach=new Attachment();   	
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=leadObj.id;
        insert attach;
        
        Test.startTest();
        Generatepdf.quoteSave(leadObj.Id);
        Test.stopTest();
        
        
    }
    
    static testmethod void sendquote(){
        
        Lead lea = new Lead(Lastname='TEST_LEAD',Company='ABCDEFG',LeadSource = 'Events',Status='C1: New');
        
        insert lea;
        string recordId = lea.Id;
        List<String> strEmails = new List<String>{'chandrusathiyan@gmail.com'};
        
        system.debug('JSON.serialize(strEmails) '+ JSON.serialize(strEmails));
        string address1 = JSON.serialize(strEmails);
        string subject = 'Test';
        string body = 'test';
        string cc1= JSON.serialize(strEmails);
        string bcc1 = JSON.serialize(strEmails);
        
        Attachment attach=new Attachment();   	
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=lea.id;
        insert attach;
        List<Attachment> attachments=[select id,name,Body,BodyLength from Attachment where parent.id=:lea.id];
      Test.startTest();
        Generatepdf.sendquote(recordId, address1, subject, body, cc1, bcc1);
     //   Generatepdf.sendquote(recordId,'chandrasekar@dazeworks.com','test','testmail');
        Test.stopTest();
        
    }
    
}