@isTest 
public class SchedulerForInsurance1_Test {
    public static testmethod void testshedule(){
        Test.startTest();
        SchedulerForInsurance1 vd=new SchedulerForInsurance1();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
        Test.stopTest();
    }
}