public class Addressproofcls {
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
            Name='file ' + DateTime.now().formatLong() + '.pdf'
        );
        insert att;
        
    }
}