@isTest 
public class SchedulerSignedAgreementModel_Test {
    public static testmethod void testshedule(){
                Test.startTest();
     //    Insert acclist;
        String CRON_EXP = '0 0 0 15 3 ? *';
         String jobId = System.schedule('SchedulerSignedAgreementModel',  CRON_EXP, new SchedulerSignedAgreementModel());
        Test.stopTest();
    }
}