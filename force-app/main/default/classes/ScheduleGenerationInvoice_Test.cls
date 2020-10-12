@IsTest
public class ScheduleGenerationInvoice_Test {

    @istest
    static void startschedule(){
        List<Account>acclist =new List<Account>();
                Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Acc.Invoice_Creation_Date__c = system.today();
        Acc.Payment_Terms__c = '15';
        Acc.Invoice_Generation__c = 'Monthly';
        insert Acc;
       
        
        Test.startTest();
        String CRON_EXP = '0 0 0 15 3 ? *';
         String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new SchedulerGenerationInvoice());
        Test.stopTest();
    }
}