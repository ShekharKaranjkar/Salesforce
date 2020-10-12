@isTest
public class RewardTriggerHandlerTest {
    
    @isTest static void roster(){
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
        campus.Site_Incharge__c= userInfo.getUserId();
        insert campus;
        
        Service_Provider__c service1 = new Service_Provider__c( );
        //   service1.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='1234567890';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Status__c = 'Active' ;
        service1.Site__c=campus.id;
        service1.Phone__c = 1234567;
        service1.Location__c ='Bangalore';
        service1.Last_Name__c='rag';
        
        insert service1;
        
        contact con =new contact();
        con.AccountId = acc.Id;
        con.LastName = 'test';
        con.Service_Provider__c = service1.Id;
        insert con;
        
        
        
        list<Rostering__c> r=new list<Rostering__c>();
        Rostering__c ro = new Rostering__c();
        ro.status__c='Approved';
        ro.Sunday__c=true;
        ro.Monday__c=true;
        ro.Tuesday__c=true;
        ro.Wednesday__c=true;
        ro.Thrusday__c=true;
        ro.Friday__c=true;
        ro.Saturday__c=true;
        //   ro.Approval_Request__c=ap.Id;
        ro.Lithium_ID__c=service1.Id;
        ro.Shift_Start_Date__c=system.today().addYears(-20);
        ro.Shift_End_Date__c=system.today().addYears(30);
        ro.Start_Time__c=Time.newInstance(1, 2, 3, 4);
        ro.End_Time__c=Time.newInstance(1, 2, 3, 4).addHours(3);
        r.add(ro); 
        insert r;
        Attendance__c at= new Attendance__c();
        at.Login__c=Datetime.newInstance(2020, 8, 17);
        at.Logout__c=Datetime.newInstance(2020, 8, 17);
        at.Shift_Start__c= Datetime.newInstance(2020, 2, 17);
        at.Shift_End__c= Datetime.newInstance(2020, 2, 17);
        at.Service_Provider__c = service1.Id;
        insert at;
        
        Vehicle__c v2= new Vehicle__c();
        v2.Name = 'MP09213421';
        v2.City__c = c.id;
        v2.Finance_Type__c ='Owned';
        v2.Delivery_Date__c = system.today().addDays(3);
        v2.Financer__c = 'Intelligrow';
        v2.Site__c=campus.Id;
        v2.VIN_Number__c='12345678901234567';
        v2.Re_enter_VIN_Number__c='12345678901234567';
        v2.Lease_Loan_Amount__c= 1000;
        v2.Status1__c='New';
        v2.Lease_Loan_Start_Date__c = system.today();
        v2.Lease_Loan_End_Date__c= system.today().addDays(3);
        v2.OEM__c ='Tata';
        v2.Manufacturing_Date__c = system.today().addDays(4);
        v2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v2.Date_of_Purchase__c=system.today().addDays(2);
        v2.RC_Registration_Date__c = system.today().addDays(1);
        insert v2;
        MIS__c m= new MIS__c();
        m.ShiftTime__c='20:08';
        m.Distance__c=10;
        m.ServiceProvider__c=service1.Id;
        m.Vehicle__c= v2.id;
        insert m;
        
        Driver_Recovery__c dr=new Driver_Recovery__c();
        dr.Service_Provider__c=service1.Id;
        insert dr;
        
        Vehicle_Assignment__c va=new Vehicle_Assignment__c();
        va.Vehicle__c=v2.Id;
        va.Service_Provider__c=service1.id;
        va.Check_In_Time__c=DateTime.newInstance(2020, 1, 31, 7, 8, 16);
        va.Check_Out_Time__c=DateTime.newInstance(2020, 1, 31, 7, 8, 16).addHours(23);
        insert va;
        list<Reward__c>rList= new list<Reward__c>();
        Reward__c rw=new Reward__c();
        rw.Service_Provider__c=service1.id;
        rList.add(rw);
        insert rList;
        
        Test.startTest();
        RewardTriggerHandler.calculateDistanceAndTrip(rList);
        RewardsBatchClass b= new RewardsBatchClass();
        Database.executeBatch(b);
        
        RewardSchedulerBatch vd=new RewardSchedulerBatch();
        String sch = '0 0 2 * * ?';
        system.schedule('Test Territory Check', sch, vd);
        Test.stopTest(); 
        
    }
}