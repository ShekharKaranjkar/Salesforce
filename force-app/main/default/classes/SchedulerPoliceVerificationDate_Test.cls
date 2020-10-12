@isTest 
public class SchedulerPoliceVerificationDate_Test {
    public static testmethod void testshedule(){
        Test.startTest();
        SchedulerPoliceVerificationDate vd=new SchedulerPoliceVerificationDate();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
        Test.stopTest();
    }
}