@isTest
public class reUsableMultiSelectLookup_Test{
    testmethod static void fetchLookUpValues(){
        
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Canara Bank';
        Acc.Lithium_Billing_Entity__c  = 'Bangalore';
        Insert Acc;
        
        Contact c = new Contact();
        c.lastname = 'test';
        c.AccountId = Acc.id;
        c.Email = 'chandrusathiyan@gmail.com';
        insert c;
        
        //Lead l = new Lead();
        Test.startTest();
        reUsableMultiSelectLookupCtrl.fetchLookUpValues('chandrusathiyan@gmail.com', 'Contact', null);
        AssignToLookUp.fetchLookUpValues('chandrusathiyan@gmail.com', 'Contact', null);
        AssignToLookUp.fetchLookUpValues('chandrusathiyan', 'Lead', null);
        lookUpController.fetchContact('chandrusathiyan@gmail.com');
        Test.stopTest();
    }
}