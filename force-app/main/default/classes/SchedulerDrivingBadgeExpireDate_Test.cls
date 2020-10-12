@isTest 
public class SchedulerDrivingBadgeExpireDate_Test {
    public static testmethod void testshedule(){
        Test.startTest();
        SchedulerDrivingBadgeExpireDate vd=new SchedulerDrivingBadgeExpireDate();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
        Test.stopTest();
    }
}