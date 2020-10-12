@isTest
public class DriverProof_Test {
   
    static TestMethod void onLoad(){
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        
        
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        
        
        
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=acc.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Billing_City__c='mrt';
        campus.Billing_State_Province__c='tp';
        campus.Billing_Street__c='ee';
        campus.Billing_Zip_Postal_Code__c='ff';
        campus.Shipping_City__c='ff';
        campus.Shipping_State_Province__c='ff';
        campus.Shipping_Street__c='ff';
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        Service_Provider__c service1 = new Service_Provider__c( );
     //   service1.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='1234567890';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Site__c=campus.id;
        service1.Phone__c = 1234567;
        service1.Location__c ='Bangalore';
        service1.Last_Name__c = 'kk';
        
        insert service1;
        ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert contentVersionInsert;
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        String addressProofNm = documents[0].Title;
        
        //Create ContentDocumentLink  Record
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = service1.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        
        
        Test.startTest();
        ApexPages.standardController sc=new ApexPages.standardController(service1);
                DriverProof.uploadfiles(service1.id,contentVersionInsert.id);

        DriverProof driver=new DriverProof(sc);
        driver.onLoad();
           driver.deleteRecord();
        /*     PageReference pageRef = Page.createpdf; // Add your VF page Name here
pageRef.getParameters().put('recId', String.valueOf(inv.Id));
Test.setCurrentPage(pageRef);
invoiceId1 testAccPlan = new invoiceId1(); */
        Test.stopTest(); 
    }
    
}