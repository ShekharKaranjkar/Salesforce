public class saveinvoice {
    @AuraEnabled
    public static void getsaveAttach(string recordId){
       // PageReference defaultPage = Page.createpdf('/apex/createpdf?id=' + recordId); //page location
        {
        System.debug('recordId ' + recordId );
        PageReference defaultPage = new PageReference('/apex/createpdf?id=' + recordId );
       // PageReference defaultPage = Page.customOrderPdf; /apex/CustomOrderPdf?   //page location
       // defaultPage.getParameters().put('recid',recordId); //passing in id for specific record
        Blob pageData; //variable to hold binary PDF data.
        if(!Test.isRunningTest()){ // for code coverage
            pageData = defaultPage.getContentAsPDF();
        } else {
            pageData = Blob.valueOf('This is a test.');
        }
        //create attachment
        Attachment att = new Attachment(
            ParentId=recordId,
            Body=pageData,
            Name='Quote ' + DateTime.now().formatLong() + '.pdf'
        );
        insert att;
        system.debug('att%%%'+att);
    }
    }
}