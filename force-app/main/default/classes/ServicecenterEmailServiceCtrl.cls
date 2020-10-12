global class ServicecenterEmailServiceCtrl implements Messaging.InboundEmailHandler{
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env) {
        
        result.success = false;
        system.debug('EmailID is' + env.fromaddress);
        system.debug('EmailID is' + email.fromaddress);
        system.debug('EmailID is' + email.toAddresses);
        system.debug('Plain Body is' + email.PlainTextBody);
        system.debug('HTML Body is' + email.HtmlBody);
        system.debug('subject is' + email.subject);
        // system.debug('from name'+email.Toaddress);
        String[] emailSubjectSplits =new List<String>();
        List<Service_Center__c> servicecenterList=new List<Service_Center__c>();
        if(email.subject!=null){
            emailSubjectSplits = email.subject.split('\\[');
        }
        System.debug('::::'+email.htmlBody.length());
        System.debug('Plain Body Length is'+email.PlainTextBody.Length());
        String body;
        if(email.htmlBody.length()>32000){
            body=email.htmlBody.substring(0,31999);
        }  
        else{
            body=email.htmlBody;
        }
        
        if(emailSubjectSplits!=null && !emailSubjectSplits.isEmpty() && emailSubjectSplits.size()>1){
            
            if(emailSubjectSplits.get(1).contains(']')){
                //ssIdexists=true;
                String  centernamenumber=emailSubjectSplits.get(1).SubStringBefore(']');
                String  centernumber = centernamenumber.split(': ').get(1);
                servicecenterList=[Select Id,Name,ownerId from Service_Center__c where Service_Center_Number__c=:centernumber];
                EmailMessage emailMessage=new EmailMessage(FromAddress = email.fromAddress,
                                                           ToAddress = email.toAddresses[0],
                                                           Subject = email.subject,
                                                           TextBody = email.plainTextBody,
                                                           HtmlBody = email.htmlBody,
                                                           RelatedToId = servicecenterList.get(0).Id,
                                                           status='3'); 
                insert emailMessage;
                
                EmailMessageRelation emr = new EmailMessageRelation();
                emr.emailMessageId = emailMessage.id;
                emr.relationId = servicecenterList.get(0).ownerId; // user id of the sender
                emr.relationType = 'ToAddress';
                insert emr;
                if (email.textAttachments != null) {
                    List < Attachment > attList = new List < Attachment > ();
                    for (Messaging.InboundEmail.TextAttachment bAttachment: email.textAttachments) {
                        
                        Attachment att = new Attachment();
                        att.Body = Blob.valueOf(bAttachment.Body);
                        att.Name = bAttachment.fileName;
                        att.ParentId=servicecenterList.get(0).Id;
                        //system.debug('bAttachment.mimeTypeSubType--->' + bAttachment.mimeTypeSubType);
                        if (bAttachment.mimeTypeSubType != null)
                            att.ContentType = bAttachment.mimeTypeSubType;
                        attList.add(att);
                        
                    }
                    if(attList.size() >= 1){
                        insert attList;
                    }
                }
                
                if (email.binaryAttachments != null) {
                    List < Attachment > attList = new List < Attachment > ();
                    for (Messaging.InboundEmail.binaryAttachment bAttachment: email.binaryAttachments) {
                        
                        Attachment att = new Attachment();
                        att.Body = bAttachment.Body;
                        att.Name = bAttachment.fileName;
                        att.ParentId=servicecenterList.get(0).Id;
                        //system.debug('bAttachment.mimeTypeSubType--->' + bAttachment.mimeTypeSubType);
                        if (bAttachment.mimeTypeSubType != null)
                            att.ContentType = bAttachment.mimeTypeSubType;
                        attList.add(att);
                        
                    }
                    if(attList.size() >= 1){
                        insert attList;
                    }
                }
                
                
                
            }
            
        }
        return result;
    }
    
}