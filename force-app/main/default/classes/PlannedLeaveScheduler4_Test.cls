@isTest 
public class PlannedLeaveScheduler4_Test {
    public static testmethod void testshedule(){
                Test.startTest();
     //    Insert acclist;
        String CRON_EXP = '0 0 0 15 3 ? *';
         String jobId = System.schedule('PlannedLeaveScheduler4',  CRON_EXP, new PlannedLeaveScheduler4());
        Test.stopTest();
    }
}