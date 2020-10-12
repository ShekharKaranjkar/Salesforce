@isTest
public class ConverttoSpController_Test {

     static TestMethod void  uploadfiles(){
         
          account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='Test Site for Lithium Service Providers';
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
         
         
         
        Candidate__c com = new Candidate__c();
        com.Aadhar_Number__c = '121212564567';
        com.First_Name__c = 'jj';
        com.Last_Name__c ='kk';
        com.Available_From_Date__c=system.today();
        com.Present_Address_1__c ='kk';
        com.Pan_Card_Id__c='AAAAA1223W';
        com.Address__c='Koc';
        com.Location__c ='Pune';
        com.Phone__c ='9897077053';
        com.Licence_Number__c='1111111111111';
        com.Badge_Number__c='12';
        com.Full_NameSo1__c='jjj';
        com.RelationshipSo1__c ='jj';
        com.PhoneSo1__c='9993420987';
        com.Company_Address__c ='kk';
        com.PhoneE__c ='0909878709';
        com.Landmark__c ='kk';
        com.Addresscurem__c ='jj';
        com.Starting_Datecur__c =system.today();
        com.Police_Station__c ='bvf';
        com.Period_of_Stay__c ='vv';
        com.Ending_Datecur__c = system.today();
        com.Landmarkpocur__c ='gffg';
        com.Starting_Dateper__c=system.today();
        com.Ending_Datepo__c =system.today();
        com.Addresspocur__c ='bv';
        com.Police_Stationcur__c='jnbvb';
        com.Period_of_Staycur__c='hvc';
       // com.Mobile__c ='1212121234';
       // com.Pincode__c='455661';
 		com.Addresspolice__c ='fdf';
        com.Starting_Datepo__c=system.today();
        insert com;
         
          Candidate__c com1 = new Candidate__c();
        com1.Aadhar_Number__c = '121212564567';
        com1.First_Name__c = 'jj1';
        com1.Last_Name__c ='k1k';
        com1.Available_From_Date__c=system.today();
        com1.Present_Address_1__c ='kk';
        com1.Pan_Card_Id__c='AAAAA1223W';
        com1.Address__c='Koc';
        com1.Location__c ='Pune';
        com1.Phone__c ='9897077053';
        com1.Licence_Number__c='1111111111111';
        com1.Badge_Number__c='12';
        com1.Full_NameSo1__c='jjj';
        com1.RelationshipSo1__c ='jj';
        com1.PhoneSo1__c='9993420987';
        com1.Company_Address__c ='kk';
        com1.PhoneE__c ='0909878709';
        com1.Landmark__c ='kk';
        com1.Addresscurem__c ='jj';
        com1.Starting_Datecur__c =system.today();
        com1.Police_Station__c ='bvf';
        com1.Period_of_Stay__c ='vv';
        com1.Ending_Datecur__c = system.today();
        com1.Landmarkpocur__c ='gffg';
        com1.Starting_Dateper__c=system.today();
        com1.Ending_Datepo__c =system.today();
        com1.Addresspocur__c ='bv';
        com1.Police_Stationcur__c='jnbvb';
        com1.Period_of_Staycur__c='hvc';
      //  com1.Mobile__c ='1212121234';
        //com1.Pincode__c=455661;
 		com1.Addresspolice__c ='fdf';
        com1.Starting_Datepo__c=system.today();
         com1.EV_Training__c = true;
         com1.Training_Test_drive__c = true;
         com1.Proposition__c = true;
        insert com1;
         
          Service_Provider__c SpNew = new Service_Provider__c ();
        SpNew.Aadhar_Number__c = com.Aadhar_Number__c;
        SpNew.Address12__c = com.Address12__c;
        SpNew.Address__c = com.Address__c;
        spNew.Name = com.Candidate__c;
        spNew.Status__c = 'Active';
        
        SpNew.Driving_License_Number__c = com.Licence_Number__c;
        SpNew.Phone_Number__c = com.Phone__c;
        SpNew.Location__c = com.Location__c;
        spNew.Site__c = campus.Id;
        spNew.First_Name__c = com.First_Name__c;
        spNew.Middle_Name__c = com.Middle_Name__c;
        spNew.Last_Name__c = com.Last_Name__c;
        spNew.Date_of_Birth__c = com.Date_Of_Birth__c;
        //spNew.Phone__c = com.Phone__c;
        spNew.Present_Address_1__c = com.Present_Address_1__c;
        spNew.Present_Address_2__c = com.Present_Address_2__c;
        spNew.State__c = com.State__c;
       // spNew.Pincode__c = com.Pincode__c;
        spNew.Available_From_Date__c= com.Available_From_Date__c;
        spNew.Aadhar_card__c = com.Aadhar_card__c;
        spNew.PAN__c = com.PAN__c;
        spNew.Blood_Group__c = com.Blood_Group__c;
        spNew.Marital_Status__c = com.Marital_Status__c;
        spNew.Parents_Name__c = com.Parents_Name__c;
        spNew.Signed_Agreement_Model__c = com.Signed_agreement_model__c;
        spNew.Documentation__c = com.Documentation__c;
        
        spNew.Licence_Number__c = com.Licence_Number__c;
        spNew.Start_Date__c = com.Start_Date__c;
        spNew.Expiry_Date__c = com.Expiry_Date__c;
        spNew.Badge_Number__c = com.Badge_Number__c;
        spNew.Driving_Experience_in_Bangalore__c = com.Driving_Experience_in_Bangalore__c;
        spNew.Details_of_Company_and_Individuals__c = com.Details_of_Company_and_Individuals__c;
        
        spNew.Branch__c = com.Branch__c;
        spNew.Type_of_Discharge__c = com.Type_of_Discharge__c;
        spNew.From__c = com.From__c;
        spNew.To__c = com.To__c;
        
        spNew.School__c = com.School__c;
        spNew.Fromedu__c = com.Fromedu__c;
        spNew.Toedu__c = com.Toedu__c;
        spNew.AddressE__c = com.AddressE__c;
        spNew.Did_you_graduate__c = com.Did_you_graduate__c;
        spNew.Certified_Enclosed__c = com.Certificate_Enclosed__c;
        
        spNew.School12__c = com.School12__c;
        spNew.From12__c = com.From12__c;
        spNew.To12__c = com.To12__c;
        spNew.Address12__c = com.Address12__c;
        spNew.Did_you_graduate12__c = com.Did_you_graduate12__c;
        spNew.Certified_Enclosed12__c = com.Certificate_Enclosed12__c;
        
        spNew.CollegeD__c = com.CollegeD__c;
        spNew.FromD__c = com.FromD__c;
        spNew.ToD__c =com.ToD__c;
        spNew.AddressD__c=com.AddressD__c;
        spNew.Did_you_graduateD__c = com.Did_you_graduateD__c;
        spNew.Certified_EnclosedD__c = com.Certificate_EnclosedD__c;
        
        spNew.CompanyE__c = com.CompanyE__c;
        spNew.PhoneE__c = com.PhoneE__c;
        spNew.Addresscurem__c = com.Addresscurem__c;
        spNew.Starting_Datecur__c = com.Starting_Datecur__c;
        spNew.Job_Title__c = com.Job_Title__c;
        spNew.Responsibilities__c = com.Responsibilities__c;
        spNew.Reason_for_Leaving__c = com.Reason_for_Leaving__c;
        spNew.Contact_your_previous_supervisor_for_Ref__c = com.Contact_your_previous_supervisor_for_Ref__c;
        
        spNew.CompanyPE__c = com.CompanyPE__c;
        spNew.PhonePE__c = com.PhonePE__c;
        spNew.AddressPE__c = com.AddressPE__c;
        spNew.Supervisor__c = com.Supervisor__c;
        spNew.Role__c = com.Role__c;
        spNew.FromPE__c = com.FromPE__c;
        spNew.ToPE__c = com.ToPE__c;
        spNew.Reason_for_LeavingPE__c = com.Reason_for_LeavingPE__c;
        spNew.ResponsibilitiesPE__c = com.ResponsibilitiesPE__c;
        spNew.May_we_contact_your_previous_supervisor__c = com.May_we_contact_your_previous_supervisor__c;
        
        spNew.Full_NameSo__c = com.Full_NameSo__c;
        spNew.PhoneSo__c = com.PhoneSo__c;
        spNew.Relationship__c = com.Relationship__c;
        spNew.Company_Address__c = com.Company_Address__c;
        
        
        //spNew.Mobile__c = com.Mobile__c;
        spNew.RelationshipSo4__c = com.RelationshipSo4__c;
        spNew.Landmark__c = com.Landmark__c;
        spNew.Addresspolice__c = com.Addresspolice__c;
        spNew.Starting_Datepo__c = com.Starting_Datepo__c;
        spNew.Police_Station__c = com.Police_Station__c;
        spNew.Period_of_Stay__c = com.Period_of_Stay__c;
        spNew.Ending_Datepo__c = com.Ending_Datepo__c;
        
        spNew.Addresspocur__c = com.Addresspocur__c;
        spNew.Landmarkpocur__c = com.Landmarkpocur__c;
        spNew.Starting_Dateper__c = com.Starting_Dateper__c;
        spNew.Police_Stationcur__c = com.Police_Stationcur__c;
        spNew.Period_of_Staycur__c = com.Period_of_Staycur__c;
        spNew.Ending_Datecur__c = com.Ending_Datecur__c;
        
        spNew.Namepofam__c = com.Namepofam__c;
        spNew.DOB__c = com.DOB__c;
        spNew.Age__c = com.Age__c;
        spNew.Relationshipfam__c = com.Relationshipfam__c;
        spNew.Gender__c = com.Gender__c;
         insert spNew;
        
          Test.startTest();
        
   			ConverttoSpController.checkCandidate(com.Id);

        	ConverttoSpController.CreateSp(com1.Id);
         com1.Service_Provider__c = spNew.Id;
         update com1;
        Test.stopTest();
        
        
    }
}