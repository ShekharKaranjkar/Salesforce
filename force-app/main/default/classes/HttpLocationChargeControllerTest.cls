@isTest
public class HttpLocationChargeControllerTest {
    
    @isTest
    public static void unitTest(){
 
        String sch = '0 0 23 * * ?'; 
 	
        Test.startTest();
    	       Test.setMock(HttpCalloutMock.class, new LocationDataMockTest());

        ScheduleHttpLocationCharge sh1 = new ScheduleHttpLocationCharge();

        system.schedule('Test Territory Check', sch, sh1);
         Test.stopTest(); 
         
        
    }
    @isTest
    public static void unitTest2(){
        System.enqueueJob(new ChargeDataQueueable());
        Locationdata__c ld = new LocationData__c();
        ld.Vin_Number__c = 'ABCDEFG1234567890';
        ld.Lidbid__c = 1;
        insert ld;
        chargedata__c cd = new chargeData__c();
        cd.Vin_Number__c = 'ABCDEFG1234567890';
        cd.Lidbid__c = 1;
        insert cd;
    }
    
    
}