@isTest
public class LocationDataTriggerTest {
	
    @isTest
    public static void unitTest1(){
        Account acc = new Account(Name ='Test');
        insert acc;
        
        City__c s = new City__c();
        s.Account__c = acc.Id;
        insert s;
        
        Campus__c camp = new Campus__c();
        camp.Location__c =  s.Id;
        camp.Account__c = acc.Id;
        insert camp;
        
        
        Vehicle__c v = new Vehicle__c();
        v.VIN_Number__c = '12345678901234567';
        v.Site__c = camp.Id;
        insert v;
        
        locationdata__c ld = new locationdata__c();
        ld.Vin_Number__c = '12345678901234567';
        insert ld;
    }
}