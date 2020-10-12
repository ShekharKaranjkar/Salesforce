@IsTest
public class ApplyLeaveController_Test {
@IsTest
    Static void controllerTestMethod(){
     Profile p = [select id from profile where name='System Administrator'];
        
        //Create a new sys admin user and do an insert  
        User u = new User(alias = 'standti', email='noEmaili@testorg.com',
                          emailencodingkey='UTF-8', lastname='Testoi', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id,
                          timezonesidkey='America/Los_Angeles', username='MrTestUseri@testorg.com');
        
        
        User u1 = [Select u.Profile.Name, u.ProfileId, u.Name, u.Id From User u where u.Profile.Name = 'System Administrator' limit 1];
        system.debug('u1+'+u1);
     account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
      Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
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
        

        Vehicle__c v1 = new Vehicle__c();
        v1.Site__c=campus.Id;
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Financer__c = 'Intelligrow';
        v1.Name = 'MP09213421';
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Status1__c='New';
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        
        // vhlist.add(v1);
        insert v1;
        
        
        
         Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.Last_Name__c = 'test1';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Vehicle_Assigned_To__c=v1.id;
        
        insert sp;
         String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Leave__c' and Name = 'Planned EOS'].Id;
        Leave__c lea = new Leave__c();
        lea.RecordTypeId = strRecordTypeId;
        lea.From_date__c=system.today().addDays(9);
        lea.To_date__c = system.today().addDays(9);
        lea.Service_Provider__c = sp.Id;
        lea.Reason__c = 'Family Emergency';
        insert lea;
        
        ContentVersion cv=new Contentversion();
        cv.title='ABC';
        cv.PathOnClient ='test';
        Blob b=Blob.valueOf('Unit Test Attachment Body');
        cv.versiondata=EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;
        date toDate = system.today().addDays(3);
        date fromDate = system.today().addDays(3);
        string td = string.valueOf(toDate);
        string fd = string.valueOf(fromDate);
         ApplyLeaveController ctrl = New ApplyLeaveController();

        System.currentPageReference().getParameters().put('inputfileids', cv.id);
        System.currentPageReference().getParameters().put('objectname', 'Leave__c');
        System.currentPageReference().getParameters().put('serviceprovider', sp.name);
         Map<String,String> dataMap = new Map<String,String>{'toDate'=> td,'fromDate'=>fd,'inputfileids'=>cv.id,'reason'=>'Family Emergency',
                           'objectname'=>'Leave__c','serviceprovider'=>sp.name};
                ApplyLeaveController.createNewLeave(dataMap);
         ApplyLeaveController.uploadfiles('base64Data', 'filetName',Network.getNetworkId(),lea.Id);
    ctrl.delcontentfiles();
    
    
    
    }   
}