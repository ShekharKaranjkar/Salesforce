@isTest 
public class SchedulerForInactivity_Test {
    public static testmethod void testshedule(){
        Test.startTest();
        SchedulerForInactivity vd=new SchedulerForInactivity();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
        Test.stopTest();
    }
}