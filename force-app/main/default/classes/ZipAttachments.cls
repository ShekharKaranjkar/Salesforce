global with sharing class ZipAttachments{
    public String accountRecordId{get;set;} 
    
    public ZipAttachments(){
        accountRecordId = '00Q5D000002JeZqUAK';//ApexPages.currentpage().getparameters().get('recID');
    }
    
    /*Function to check whether there are any attachments*/
    webservice static Boolean chkAtt(String accId){
        List<Attachment> lstAtt = [SELECT Id,Name from Attachment where ParentId =:accId];
        if(lstAtt.size()>0){
            return true;
        }
        else{
            return false;
        }
    }
    
    /*Function to fetch the attachments related to the Account*/
    @RemoteAction
    public static List<AttachmentWrapper> getAttachments(String accId){
        List<Attachment> lstAttachments = new List<Attachment>();
        List <AttachmentWrapper> lstAttachmentWrapper = new List <AttachmentWrapper>();
        AttachmentWrapper wrapper = new AttachmentWrapper();
        lstAttachments = [SELECT Id, Name, ParentId, ContentType, Body FROM Attachment WHERE ParentId =:accId];
        
        for(Attachment att : lstAttachments){
            wrapper.attName = att.Name;
            wrapper.attEncodedBody = EncodingUtil.base64Encode(att.Body);
            lstAttachmentWrapper.add(wrapper);
        }
        
        return lstAttachmentWrapper;
    }
    
    /*Function to save the attachment to the Document Folder*/
    webservice static Id saveToDocument( String zipFileData, String fileName ){
        
        String userId = UserInfo.getUserId();
        Document doc = new Document();
        doc.Name = fileName;
        doc.FolderId = UserInfo.getUserId();
        doc.Body = EncodingUtil.base64Decode( zipFileData );
        insert doc;
        
        return doc.ID;
    }
    
    
    /*Wrapper Class which holds the Name and Body of Attachments*/
    public class AttachmentWrapper {
        public String attEncodedBody {get; set;}
        public String attName {get; set;}
    }
}