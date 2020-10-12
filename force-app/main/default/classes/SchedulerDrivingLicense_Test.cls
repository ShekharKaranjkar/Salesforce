@isTest 
public class SchedulerDrivingLicense_Test {
    public static testmethod void testshedule(){
        Test.startTest();
        SchedulerDrivingLicense vd=new SchedulerDrivingLicense();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
        Test.stopTest();
    }
}