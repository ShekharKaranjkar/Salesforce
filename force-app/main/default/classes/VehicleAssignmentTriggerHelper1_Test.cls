@isTest
public class VehicleAssignmentTriggerHelper1_Test {
    @testSetup static void methodName() {
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=acc.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Billing_City__c='mrt';
        campus.Billing_State_Province__c='tp';
        campus.Billing_Street__c='ee';
        campus.Billing_Zip_Postal_Code__c='ff';
        campus.Shipping_City__c='ff';
        campus.Shipping_State_Province__c='ff';
        campus.Shipping_Street__c='ff';
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        
    }
    static Testmethod void checkOdoMeterReading1(){
        Id devRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByName().get('Scheduled Maintenance').getRecordTypeId();
        Campus__c campus = [Select id from Campus__c limit 1];
        City__c city = [Select id from City__c limit 1];
        list<Vehicle__c> vhlist = new list<Vehicle__c>();
        
       Vehicle__c v1 = new Vehicle__c();
        v1.Site__c=campus.Id;
        v1.City__c = city.id;
        v1.Finance_Type__c ='Owned';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Financer__c = 'Intelligrow';
        v1.Name = 'MP09213421';
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Status1__c='Onroad';
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(v1);
        // insert v1;
        
        Vehicle__c v2= new Vehicle__c();
        v2.Name = 'MP09213421';
        v2.City__c = city.id;
        v2.Finance_Type__c ='Owned';
        v2.Delivery_Date__c = system.today().addDays(3);
        v2.Financer__c = 'Intelligrow';
        v2.Site__c=campus.Id;
        v2.VIN_Number__c='12345678901234567';
        v2.Re_enter_VIN_Number__c='12345678901234567';
        v2.Lease_Loan_Amount__c= 1000;
        v2.Status1__c='Onroad';
        v2.Lease_Loan_Start_Date__c = system.today();
        v2.Lease_Loan_End_Date__c= system.today().addDays(3);
        v2.OEM__c ='Tata';
        v2.Manufacturing_Date__c = system.today().addDays(4);
        v2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v2.Date_of_Purchase__c=system.today().addDays(2);
        v2.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(v2);
        //insert v2;  
        
        Vehicle__c v3= new Vehicle__c();
        v3.Site__c=campus.Id;
        v3.Finance_Type__c ='Owned';
        v3.Delivery_Date__c = system.today().addDays(3);
        v3.Financer__c = 'Intelligrow';
        v3.Name = 'MP09213421';
        v3.VIN_Number__c='12345678901234567';
        v3.Re_enter_VIN_Number__c='12345678901234567';
        v3.Lease_Loan_Amount__c= 1000;
        v3.Status1__c='Onroad';
        v3.City__c = city.id;
        v3.Lease_Loan_Start_Date__c = system.today();
        v3.Lease_Loan_End_Date__c= system.today().addDays(3);
        v3.OEM__c ='Tata';
        v3.Manufacturing_Date__c = system.today().addDays(4);
        v3.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v3.Date_of_Purchase__c=system.today().addDays(2);
        v3.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(v3);
        // insert v3;   
        
        Vehicle__c v4= new Vehicle__c();
        v4.Name = 'MP09213421';
        v4.Finance_Type__c ='Owned';
        v4.Delivery_Date__c = system.today().addDays(3);
        v4.Financer__c = 'Intelligrow';
        v4.Site__c=campus.Id;
        v4.City__c = city.id;
        v4.VIN_Number__c='12345678901234567';
        v4.Re_enter_VIN_Number__c='12345678901234567';
        v4.Lease_Loan_Amount__c= 1000;
        v4.Status1__c='Onroad';
        v4.Lease_Loan_Start_Date__c = system.today();
        v4.Lease_Loan_End_Date__c= system.today().addDays(3);
        v4.OEM__c ='Tata';
        v4.Manufacturing_Date__c = system.today().addDays(4);
        v4.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v4.Date_of_Purchase__c=system.today().addDays(2);
        v4.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(v4);
        //  insert v4;   
        
        Vehicle__c v5= new Vehicle__c();
        v5.Site__c=campus.Id;
        v5.Name = 'MP09213421';
        v5.Delivery_Date__c = system.today().addDays(3);
        v5.Finance_Type__c ='Owned';
        v5.Financer__c = 'Intelligrow';
        v5.VIN_Number__c='12345678901234567';
        v5.Re_enter_VIN_Number__c='12345678901234567';
        v5.Lease_Loan_Amount__c= 1000;
        v5.Status1__c='Onroad';
        v5.City__c = city.id;
        v5.Lease_Loan_Start_Date__c = system.today();
        v5.Lease_Loan_End_Date__c= system.today().addDays(3);
        v5.OEM__c ='Tata';
        v5.Manufacturing_Date__c = system.today().addDays(4);
        v5.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v5.Date_of_Purchase__c=system.today().addDays(2);
        v5.RC_Registration_Date__c = system.today().addDays(1);
        
        vhlist.add(v5);
        //  insert v5;           
        insert vhlist; 
        
        list<Vehicle__c> vhlistforchange = new list<Vehicle__c>();
        for(integer i=0;i<10;i++){
            Vehicle__c v6t= new Vehicle__c();
            v6t.Site__c=campus.Id;
            v6t.Name = 'MP09213421';
            v6t.Delivery_Date__c = system.today().addDays(3);
            v6t.Finance_Type__c ='Owned';
            v6t.Financer__c = 'Intelligrow';
            v6t.City__c = city.id;
            v6t.VIN_Number__c='12345678901234567';
            v6t.Re_enter_VIN_Number__c='12345678901234567';
            v6t.Lease_Loan_Amount__c= 1000;
            v6t.Status1__c='Onroad';
            v6t.Lease_Loan_Start_Date__c = system.today();
            v6t.Lease_Loan_End_Date__c= system.today().addDays(3);
            v6t.OEM__c ='Tata';
            v6t.Manufacturing_Date__c = system.today().addDays(4);
            v6t.Vehicle_Registration_Number__c = 'GJ01RX0349';
            v6t.Date_of_Purchase__c=system.today().addDays(2);
            v6t.RC_Registration_Date__c = system.today().addDays(1);
            vhlistforchange.add(v6t);
        }
        insert vhlistforchange;
        Map<id,Vehicle_Assignment__c>assignList = New map<id,Vehicle_Assignment__c>();
        
        
        for(Vehicle__c ve:vhlist){
            Vehicle_Assignment__c vehass = new Vehicle_Assignment__c();
            vehass.Odometer_reading__c = 15000;
            vehass.Vehicle__c = ve.Id;
            assignList.put(ve.id,vehass);
            
        }
        insert assignList.values();
        
        Map<id,Vehicle_Assignment__c> mapvehicle = new Map<id,Vehicle_Assignment__c>([select id,name,Odometer_reading__c,Vehicle__c from Vehicle_Assignment__c where Vehicle__c=: assignList.keyset() order by Odometer_reading__c desc]);
        
        Test.startTest();
        integer i = 15000;
        integer j = 0;
        for(Vehicle_Assignment__c ass:mapvehicle.values()){
            ass.Odometer_reading__c = i;
            ass.Vehicle__c = vhlistforchange.get(j).Id;
            j++;
            i= i +20000;
        }
       
        update mapvehicle.values();
        
        Test.stopTest();
        
        
    }    
    static Testmethod void checkOdoMeterReading2(){
        Id devRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByName().get('Scheduled Maintenance').getRecordTypeId();
        Campus__c campus = [Select id from Campus__c limit 1];
        list<Vehicle__c> vhlist = new list<Vehicle__c>();
        City__c city= [Select id from City__c limit 1];
        
       Vehicle__c veh1 = new Vehicle__c();
        veh1.Name = 'MP09213421';
        veh1.Delivery_Date__c = system.today().addDays(3);
        veh1.Finance_Type__c ='Owned';
        veh1.Financer__c = 'Intelligrow';
        veh1.City__c = city.id;
        veh1.Site__c=campus.Id;
        veh1.VIN_Number__c='12345678901234567';
        veh1.Re_enter_VIN_Number__c='12345678901234567';
        veh1.Lease_Loan_Amount__c= 1000;
        veh1.Status1__c='Onroad';
        veh1.Lease_Loan_Start_Date__c = system.today();
        veh1.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh1.OEM__c ='Tata';
        veh1.Manufacturing_Date__c = system.today().addDays(4);
        veh1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh1.Date_of_Purchase__c=system.today().addDays(2);
        veh1.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh1);
        
        Service_Provider__c sp=new Service_Provider__c();
        
        Vehicle__c veh2= new Vehicle__c();
        veh2.Name = 'MP09213421';
        veh2.Delivery_Date__c = system.today().addDays(3);
        veh2.Finance_Type__c ='Owned';
        veh2.Financer__c = 'Intelligrow';
        veh2.City__c = city.id;
        veh2.Site__c=campus.Id;
        veh2.VIN_Number__c='12345678901234567';
        veh2.Re_enter_VIN_Number__c='12345678901234567';
        veh2.Lease_Loan_Amount__c= 1000;
        veh2.Status1__c='Onroad';
        veh2.Lease_Loan_Start_Date__c = system.today();
        veh2.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh2.OEM__c ='Tata';
        veh2.Manufacturing_Date__c = system.today().addDays(4);
        veh2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh2.Date_of_Purchase__c=system.today().addDays(2);
        veh2.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh2);
        
        
        Vehicle__c veh3= new Vehicle__c();
        veh3.Name = 'MP09213421';
        veh3.Delivery_Date__c = system.today().addDays(3);
        veh3.Finance_Type__c ='Owned';
        veh3.Financer__c = 'Intelligrow';
        veh3.City__c = city.id;
        veh3.Site__c=campus.Id;
        veh3.VIN_Number__c='12345678901234567';
        veh3.Re_enter_VIN_Number__c='12345678901234567';
        veh3.Lease_Loan_Amount__c= 1000;
        veh3.Status1__c='Onroad';
        veh3.Lease_Loan_Start_Date__c = system.today();
        veh3.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh3.OEM__c ='Tata';
        veh3.Manufacturing_Date__c = system.today().addDays(4);
        veh3.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh3.Date_of_Purchase__c=system.today().addDays(2);
        veh3.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh3);
        
        
        Vehicle__c veh4= new Vehicle__c();
        veh4.Site__c=campus.Id;
        veh4.Name = 'MP09213421';
        veh4.Delivery_Date__c = system.today().addDays(3);
        veh4.Finance_Type__c ='Owned';
        veh4.Financer__c = 'Intelligrow';
        veh4.City__c = city.id;
        veh4.VIN_Number__c='12345678901234567';
        veh4.Re_enter_VIN_Number__c='12345678901234567';
        veh4.Lease_Loan_Amount__c= 1000;
        veh4.Status1__c='Onroad';
        veh4.Lease_Loan_Start_Date__c = system.today();
        veh4.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh4.OEM__c ='Tata';
        veh4.Manufacturing_Date__c = system.today().addDays(4);
        veh4.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh4.Date_of_Purchase__c=system.today().addDays(2);
        veh4.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh4);
        
        
        Vehicle__c veh5= new Vehicle__c();
        veh5.Name = 'MP09213421';
        veh5.Delivery_Date__c = system.today().addDays(3);
        veh5.Finance_Type__c ='Owned';
        veh5.Financer__c = 'Intelligrow';
        veh5.City__c = city.id;
        veh5.Site__c=campus.Id;
        veh5.VIN_Number__c='12345678901234567';
        veh5.Re_enter_VIN_Number__c='12345678901234567';
        veh5.Lease_Loan_Amount__c= 1000;
        veh5.Status1__c='Onroad';
        veh5.Lease_Loan_Start_Date__c = system.today();
        veh5.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh5.OEM__c ='Tata';
        veh5.Manufacturing_Date__c = system.today().addDays(4);
        veh5.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh5.Date_of_Purchase__c=system.today().addDays(2);
        veh5.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh5);
        
        insert vhlist; 
        list<Vehicle__c> vhlistforchange = new list<Vehicle__c>();
        for(integer i=0;i<10;i++){
            Vehicle__c v6t= new Vehicle__c();
            v6t.Name = 'MP09213421';
            v6t.Delivery_Date__c = system.today().addDays(3);
            v6t.Finance_Type__c ='Owned';
            v6t.Financer__c = 'Intelligrow';
            v6t.City__c = city.id;
            v6t.Site__c=campus.Id;
            v6t.VIN_Number__c='12345678901234567';
            v6t.Re_enter_VIN_Number__c='12345678901234567';
            v6t.Lease_Loan_Amount__c= 1000;
            v6t.Status1__c='Onroad';
            v6t.Lease_Loan_Start_Date__c = system.today();
            v6t.Lease_Loan_End_Date__c= system.today().addDays(3);
            v6t.OEM__c ='Tata';
            v6t.Manufacturing_Date__c = system.today().addDays(4);
            v6t.Vehicle_Registration_Number__c = 'GJ01RX0349';
            v6t.Date_of_Purchase__c=system.today().addDays(2);
            v6t.RC_Registration_Date__c = system.today().addDays(1);
            vhlistforchange.add(v6t);
        }
        insert vhlistforchange;
        Map<id,Vehicle_Assignment__c>assignList = New map<id,Vehicle_Assignment__c>();
        
        
        for(Vehicle__c ve:vhlist){
            Vehicle_Assignment__c vehass = new Vehicle_Assignment__c();
            vehass.Odometer_reading__c = 15000;
            vehass.Vehicle__c = ve.Id;
            assignList.put(ve.id,vehass);
            
        }
        insert assignList.values();
        
        Map<id,Vehicle_Assignment__c> mapvehicle = new Map<id,Vehicle_Assignment__c>([select id,name,Odometer_reading__c,Vehicle__c from Vehicle_Assignment__c where Vehicle__c=: assignList.keyset() order by Odometer_reading__c desc]);
        
        Test.startTest();
        integer i = 15000;
        integer j = 0;
        for(Vehicle_Assignment__c ass:mapvehicle.values()){
            ass.Odometer_reading__c = i;
            ass.Vehicle__c = vhlistforchange.get(j).Id;
            j++;
            i= i +20000;
        }
        update mapvehicle.values();
        
        Test.stopTest();
        
    }
     static Testmethod void checkOdoMeterReading3(){
        Id devRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByName().get('Scheduled Maintenance').getRecordTypeId();
        Campus__c campus = [Select id from Campus__c limit 1];
        list<Vehicle__c> vhlist = new list<Vehicle__c>();
        City__c city= [Select id from City__c limit 1];
        
       Vehicle__c veh1 = new Vehicle__c();
        veh1.Name = 'MP09213421';
        veh1.Delivery_Date__c = system.today().addDays(3);
        veh1.Finance_Type__c ='Owned';
        veh1.Financer__c = 'Intelligrow';
        veh1.City__c = city.id;
        veh1.Site__c=campus.Id;
        veh1.VIN_Number__c='12345678901234567';
        veh1.Re_enter_VIN_Number__c='12345678901234567';
        veh1.Lease_Loan_Amount__c= 1000;
        veh1.Status1__c='New';
        veh1.Lease_Loan_Start_Date__c = system.today();
        veh1.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh1.OEM__c ='Tata';
        veh1.Manufacturing_Date__c = system.today().addDays(4);
        veh1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh1.Date_of_Purchase__c=system.today().addDays(2);
        veh1.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh1);
        
        Service_Provider__c sp=new Service_Provider__c();
        
        Vehicle__c veh2= new Vehicle__c();
        veh2.Name = 'MP09213421';
        veh2.Delivery_Date__c = system.today().addDays(3);
        veh2.Finance_Type__c ='Owned';
        veh2.Financer__c = 'Intelligrow';
        veh2.City__c = city.id;
        veh2.Site__c=campus.Id;
        veh2.VIN_Number__c='12345678901234567';
        veh2.Re_enter_VIN_Number__c='12345678901234567';
        veh2.Lease_Loan_Amount__c= 1000;
        veh2.Status1__c='New';
        veh2.Lease_Loan_Start_Date__c = system.today();
        veh2.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh2.OEM__c ='Tata';
        veh2.Manufacturing_Date__c = system.today().addDays(4);
        veh2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh2.Date_of_Purchase__c=system.today().addDays(2);
        veh2.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh2);
        
        
        Vehicle__c veh3= new Vehicle__c();
        veh3.Name = 'MP09213421';
        veh3.Delivery_Date__c = system.today().addDays(3);
        veh3.Finance_Type__c ='Owned';
        veh3.Financer__c = 'Intelligrow';
        veh3.City__c = city.id;
        veh3.Site__c=campus.Id;
        veh3.VIN_Number__c='12345678901234567';
        veh3.Re_enter_VIN_Number__c='12345678901234567';
        veh3.Lease_Loan_Amount__c= 1000;
        veh3.Status1__c='New';
        veh3.Lease_Loan_Start_Date__c = system.today();
        veh3.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh3.OEM__c ='Tata';
        veh3.Manufacturing_Date__c = system.today().addDays(4);
        veh3.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh3.Date_of_Purchase__c=system.today().addDays(2);
        veh3.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh3);
        
        
        Vehicle__c veh4= new Vehicle__c();
        veh4.Site__c=campus.Id;
        veh4.Name = 'MP09213421';
        veh4.Delivery_Date__c = system.today().addDays(3);
        veh4.Finance_Type__c ='Owned';
        veh4.Financer__c = 'Intelligrow';
        veh4.City__c = city.id;
        veh4.VIN_Number__c='12345678901234567';
        veh4.Re_enter_VIN_Number__c='12345678901234567';
        veh4.Lease_Loan_Amount__c= 1000;
        veh4.Status1__c='New';
        veh4.Lease_Loan_Start_Date__c = system.today();
        veh4.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh4.OEM__c ='Tata';
        veh4.Manufacturing_Date__c = system.today().addDays(4);
        veh4.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh4.Date_of_Purchase__c=system.today().addDays(2);
        veh4.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh4);
        
        
        Vehicle__c veh5= new Vehicle__c();
        veh5.Name = 'MP09213421';
        veh5.Delivery_Date__c = system.today().addDays(3);
        veh5.Finance_Type__c ='Owned';
        veh5.Financer__c = 'Intelligrow';
        veh5.City__c = city.id;
        veh5.Site__c=campus.Id;
        veh5.VIN_Number__c='12345678901234567';
        veh5.Re_enter_VIN_Number__c='12345678901234567';
        veh5.Lease_Loan_Amount__c= 1000;
        veh5.Status1__c='New';
        veh5.Lease_Loan_Start_Date__c = system.today();
        veh5.Lease_Loan_End_Date__c= system.today().addDays(3);
        veh5.OEM__c ='Tata';
        veh5.Manufacturing_Date__c = system.today().addDays(4);
        veh5.Vehicle_Registration_Number__c = 'GJ01RX0349';
        veh5.Date_of_Purchase__c=system.today().addDays(2);
        veh5.RC_Registration_Date__c = system.today().addDays(1);
        vhlist.add(veh5);
        
        insert vhlist; 
        list<Vehicle__c> vhlistforchange = new list<Vehicle__c>();
        for(integer i=0;i<10;i++){
            Vehicle__c v6t= new Vehicle__c();
            v6t.Name = 'MP09213421';
            v6t.Delivery_Date__c = system.today().addDays(3);
            v6t.Finance_Type__c ='Owned';
            v6t.Financer__c = 'Intelligrow';
            v6t.City__c = city.id;
            v6t.Site__c=campus.Id;
            v6t.VIN_Number__c='12345678901234567';
            v6t.Re_enter_VIN_Number__c='12345678901234567';
            v6t.Lease_Loan_Amount__c= 1000;
            v6t.Status1__c='New';
            v6t.Lease_Loan_Start_Date__c = system.today();
            v6t.Lease_Loan_End_Date__c= system.today().addDays(3);
            v6t.OEM__c ='Tata';
            v6t.Manufacturing_Date__c = system.today().addDays(4);
            v6t.Vehicle_Registration_Number__c = 'GJ01RX0349';
            v6t.Date_of_Purchase__c=system.today().addDays(2);
            v6t.RC_Registration_Date__c = system.today().addDays(1);
            vhlistforchange.add(v6t);
        }
        insert vhlistforchange;
        Map<id,Vehicle_Assignment__c>assignList = New map<id,Vehicle_Assignment__c>();
        
        
        for(Vehicle__c ve:vhlist){
            Vehicle_Assignment__c vehass = new Vehicle_Assignment__c();
            vehass.Odometer_reading__c = 15000;
            vehass.Vehicle__c = ve.Id;
            assignList.put(ve.id,vehass);
            
        }
        insert assignList.values();
        
        Map<id,Vehicle_Assignment__c> mapvehicle = new Map<id,Vehicle_Assignment__c>([select id,name,Odometer_reading__c,Vehicle__c from Vehicle_Assignment__c where Vehicle__c=: assignList.keyset() order by Odometer_reading__c desc]);
        
        Test.startTest();
        integer i = 15000;
        integer j = 0;
        for(Vehicle_Assignment__c ass:mapvehicle.values()){
            ass.Odometer_reading__c = i;
            ass.Vehicle__c = vhlistforchange.get(j).Id;
            j++;
            i= i +20000;
        }
        update mapvehicle.values();
        
        Test.stopTest();
        
    }
}