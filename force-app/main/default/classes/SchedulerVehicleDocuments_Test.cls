@isTest 

public class SchedulerVehicleDocuments_Test{
    public static testmethod void testshedule(){
        Test.startTest();
    SchedulerForVehicleDocument1 vd=new SchedulerForVehicleDocument1();
    String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
 Test.stopTest();
  
}
   
}