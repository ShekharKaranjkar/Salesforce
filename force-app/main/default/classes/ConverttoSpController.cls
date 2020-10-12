/*
** To Convert the records from Candidate to Service Provider..**
*/
public class ConverttoSpController {
    @AuraEnabled
    public static Boolean checkCandidate(String candId){
        system.debug('inside method');
        
        list<Candidate__c> CanLiST = [select Id from Candidate__c where Id=:candId and Service_Provider__c = null order by createddate desc limit 1];
        system.debug('candId'+CanLiST);
        if(CanLiST != null && !CanLiST.isempty()){
            return True;
        }else
            return False;
        
    }
    @AuraEnabled
    public static Boolean CreateSp(String candidateId){
        system.debug('candidateId'+candidateId);
        Campus__c siteId = [select id,name from Campus__c where name ='Test Site for Lithium Service Providers'];
        Candidate__c canList = [select id,Aadhar_card__c,EV_Training__c,EV_Training_Score__c,Proposition_Score__c,Training_Test_Drive_Score__c ,Proposition__c,Aadhar_Card_Id__c,Candidate__c,Did_you_graduate12__c,Starting_Dateper__c,Addresscurem__c,Aadhar_Number__c,Location__c,Did_you_graduateD__c,Ending_Datecur__c,DOB__c,PhoneSo__c,Documentation__c,Did_you_graduate__c,Driving_Experience_in_Bangalore__c,Details_of_Company_and_Individuals__c,Address__c,Date_Of_Birth__c, Address12__c, AddressD__c, AddressE__c, AddressPE__c, Addresspocur__c, Addresspolice__c, Age__c, Available_From_Date__c, Badge_Number__c, Blood_Group__c, Branch__c, Certificate_Enclosed__c, Certificate_Enclosed12__c, Certificate_EnclosedD__c, City__c, CollegeD__c, Company_Address__c, Company_AddressSo1__c,Company_AddressSo2__c, CompanyE__c, CompanyPE__c, Contact_your_previous_supervisor_for_Ref__c, Ending_Datepo__c, Ending_Earnings__c, Expiry_Date__c, First_Name__c, From__c, From12__c, FromD__c, Fromedu__c, FromPE__c, Full_NameSo__c, Full_NameSo1__c, Full_NameSo2__c, Gender__c,If_other_than_honorable_explain__c, IsDeleted, Job_Title__c, Landmark__c, Landmarkpocur__c, Last_Name__c, LastReferencedDate, LastViewedDate, Licence_Number__c, Marital_Status__c, May_we_contact_your_previous_supervisor__c, Middle_Name__c, Mobile__c, Name, Namepofam__c, NameSo4__c, PAN__c, Parents_Name__c, Period_of_Stay__c, Period_of_Staycur__c, Phone__c, PhoneE__c, PhonePE__c, PhoneSo1__c, PhoneSo2__c, Photo_id_proof__c, Photo_proof_image__c, Photo_Proof_Preview__c, Pincode__c, Police_Station__c, Police_Stationcur__c, Present_Address_1__c, Present_Address_2__c, Reason_for_Leaving__c, Reason_for_LeavingPE__c, Relationship__c, Relationshipfam__c, RelationshipSo1__c, RelationshipSo2__c, RelationshipSo4__c, Responsibilities__c, ResponsibilitiesPE__c, Role__c, School__c, School12__c, Service_Provider__c, Signed_agreement_model__c, Start_Date__c, Starting_Datecur__c, Starting_Datepo__c, Starting_Earnings__c, State__c, Supervisor__c, To__c, To12__c, ToD__c, Toedu__c, ToPE__c, Training_Test_drive__c, Type_of_Discharge__c,CRA__c,MSA__c,Passort_Size_Photo__c,Address_Proof_Id__c,Driving_Badge_Id__c,Driving_License2_Id__c,Driving_License_Id__c,Pan_Card_Id__c,Passport_Id__c,Voter_Id_Card_Id__c,CRA_Picture__c,Aadhar_Card_Picture__c,Address_Proof_Picture__c,Driving_Badge_Picture__c,Driving_Licence_Front_Page_Picture__c,Driving_Licence_Back_Page_Picture__c,PAN_Card_Picture__c,Passport_Size_Picture__c,Bank_PassBook_Picture__c,VoterId_Card_Picture__c,MSA_Picture__c  from Candidate__c  where Id=:candidateId order by createddate desc limit 1];
        
        Service_Provider__c SpNew = new Service_Provider__c ();
        SpNew.Aadhar_Number__c = canList.Aadhar_Number__c;
        SpNew.Address12__c = canList.Address12__c;
        SpNew.Address__c = canList.Address__c;
        spNew.Name = canList.Candidate__c;
        spNew.Status__c = 'Active';
        
        SpNew.Driving_License_Number__c = canList.Licence_Number__c;
        SpNew.Phone_Number__c = canList.Phone__c;
        SpNew.Location__c = canList.Location__c;
        spNew.Site__c = siteId.Id;
        spNew.First_Name__c = canList.First_Name__c;
        spNew.Middle_Name__c = canList.Middle_Name__c;
        spNew.Last_Name__c = canList.Last_Name__c;
        spNew.Date_of_Birth__c = canList.Date_Of_Birth__c;
        //spNew.Phone__c = canList.Phone__c;
        spNew.Present_Address_1__c = canList.Present_Address_1__c;
        spNew.Present_Address_2__c = canList.Present_Address_2__c;
        spNew.State__c = canList.State__c;
        //  spNew.Pincode__c = canList.Pincode__c;
        spNew.Available_From_Date__c= canList.Available_From_Date__c;
        spNew.Aadhar_card__c = canList.Aadhar_card__c;
        spNew.PAN__c = canList.PAN__c;
        spNew.Blood_Group__c = canList.Blood_Group__c;
        spNew.Marital_Status__c = canList.Marital_Status__c;
        spNew.Parents_Name__c = canList.Parents_Name__c;
        spNew.Signed_Agreement_Model__c = canList.Signed_agreement_model__c;
        spNew.Documentation__c = canList.Documentation__c;
        
        spNew.Licence_Number__c = canList.Licence_Number__c;
        spNew.Start_Date__c = canList.Start_Date__c;
        spNew.Expiry_Date__c = canList.Expiry_Date__c;
        spNew.Badge_Number__c = canList.Badge_Number__c;
        spNew.Driving_Experience_in_Bangalore__c = canList.Driving_Experience_in_Bangalore__c;
        spNew.Details_of_Company_and_Individuals__c = canList.Details_of_Company_and_Individuals__c;
        
        spNew.Branch__c = canList.Branch__c;
        spNew.Type_of_Discharge__c = canList.Type_of_Discharge__c;
        spNew.From__c = canList.From__c;
        spNew.To__c = canList.To__c;
        
        spNew.School__c = canList.School__c;
        spNew.Fromedu__c = canList.Fromedu__c;
        spNew.Toedu__c = canList.Toedu__c;
        spNew.AddressE__c = canList.AddressE__c;
        spNew.Did_you_graduate__c = canList.Did_you_graduate__c;
        spNew.Certified_Enclosed__c = canList.Certificate_Enclosed__c;
        
        spNew.School12__c = canList.School12__c;
        spNew.From12__c = canList.From12__c;
        spNew.To12__c = canList.To12__c;
        spNew.Address12__c = canList.Address12__c;
        spNew.Did_you_graduate12__c = canList.Did_you_graduate12__c;
        spNew.Certified_Enclosed12__c = canList.Certificate_Enclosed12__c;
        
        spNew.CollegeD__c = canList.CollegeD__c;
        spNew.FromD__c = canList.FromD__c;
        spNew.ToD__c =canList.ToD__c;
        spNew.AddressD__c=canList.AddressD__c;
        spNew.Did_you_graduateD__c = canList.Did_you_graduateD__c;
        spNew.Certified_EnclosedD__c = canList.Certificate_EnclosedD__c;
        
        spNew.CompanyE__c = canList.CompanyE__c;
        spNew.PhoneE__c = canList.PhoneE__c;
        spNew.Addresscurem__c = canList.Addresscurem__c;
        spNew.Starting_Datecur__c = canList.Starting_Datecur__c;
        spNew.Job_Title__c = canList.Job_Title__c;
        spNew.Responsibilities__c = canList.Responsibilities__c;
        spNew.Reason_for_Leaving__c = canList.Reason_for_Leaving__c;
        spNew.Contact_your_previous_supervisor_for_Ref__c = canList.Contact_your_previous_supervisor_for_Ref__c;
        
        spNew.CompanyPE__c = canList.CompanyPE__c;
        spNew.PhonePE__c = canList.PhonePE__c;
        spNew.AddressPE__c = canList.AddressPE__c;
        spNew.Supervisor__c = canList.Supervisor__c;
        spNew.Role__c = canList.Role__c;
        spNew.FromPE__c = canList.FromPE__c;
        spNew.ToPE__c = canList.ToPE__c;
        spNew.Reason_for_LeavingPE__c = canList.Reason_for_LeavingPE__c;
        spNew.ResponsibilitiesPE__c = canList.ResponsibilitiesPE__c;
        spNew.May_we_contact_your_previous_supervisor__c = canList.May_we_contact_your_previous_supervisor__c;
        
        spNew.Full_NameSo__c = canList.Full_NameSo__c;
        spNew.PhoneSo__c = canList.PhoneSo__c;
        spNew.Relationship__c = canList.Relationship__c;
        spNew.Company_Address__c = canList.Company_Address__c;
        
        
        spNew.Mobile__c = canList.Mobile__c;
        spNew.RelationshipSo4__c = canList.RelationshipSo4__c;
        spNew.Landmark__c = canList.Landmark__c;
        spNew.Addresspolice__c = canList.Addresspolice__c;
        spNew.Starting_Datepo__c = canList.Starting_Datepo__c;
        spNew.Police_Station__c = canList.Police_Station__c;
        spNew.Period_of_Stay__c = canList.Period_of_Stay__c;
        spNew.Ending_Datepo__c = canList.Ending_Datepo__c;
        
        spNew.Addresspocur__c = canList.Addresspocur__c;
        spNew.Landmarkpocur__c = canList.Landmarkpocur__c;
        spNew.Starting_Dateper__c = canList.Starting_Dateper__c;
        spNew.Police_Stationcur__c = canList.Police_Stationcur__c;
        spNew.Period_of_Staycur__c = canList.Period_of_Staycur__c;
        spNew.Ending_Datecur__c = canList.Ending_Datecur__c;
        
        spNew.Namepofam__c = canList.Namepofam__c;
        spNew.DOB__c = canList.DOB__c;
        spNew.Age__c = canList.Age__c;
        spNew.Relationshipfam__c = canList.Relationshipfam__c;
        spNew.Gender__c = canList.Gender__c;
        list<Candidate__c> canRec = [SELECT Id,PAN_Card_Picture__c,Aadhar_Card_Picture__c,Address_Proof_Picture__c,Driving_Licence_Front_Page_Picture__c,Driving_Licence_Back_Page_Picture__c,Bank_PassBook_Picture__c,VoterId_Card_Picture__c,CRA_Picture__c,MSA_Picture__c,Passport_Size_Picture__c FROM Candidate__c WHERE id=:candidateId];
        system.debug('canRec'+canRec);
        Map<Id,Candidate__c> canMap = new Map<Id,Candidate__c>();
        // system.debug('canList.CRA_Picture__c'+conLink);
        if(canList.EV_Training__c && canList.Training_Test_drive__c && canList.Proposition__c  && canList.Address_Proof_Picture__c != null&&canList.Aadhar_Card_Picture__c !=null &&canList.VoterId_Card_Picture__c !=null &&canList.Passport_Size_Picture__c !=null &&canList.Driving_Licence_Front_Page_Picture__c !=null &&canList.Driving_Licence_Back_Page_Picture__c!=null&&canList.Bank_PassBook_Picture__c!=null&&canList.PAN_Card_Picture__c!=null&& canList.CRA_Picture__c!=null &&canList.MSA_Picture__c!=null&&canList.EV_Training_Score__c>=60 &&canList.Proposition_Score__c >=60&&canList.Training_Test_Drive_Score__c>=60 ){
            for(Candidate__c cn:canRec){
                canMap.put(cn.PAN_Card_Picture__c, cn);
                canMap.put(cn.Aadhar_Card_Picture__c, cn);
                canMap.put(cn.Address_Proof_Picture__c, cn);
                canMap.put(cn.Driving_Licence_Front_Page_Picture__c, cn);
                canMap.put(cn.Driving_Licence_Back_Page_Picture__c, cn);
                canMap.put(cn.Bank_PassBook_Picture__c, cn);
                canMap.put(cn.VoterId_Card_Picture__c, cn);
                canMap.put(cn.CRA_Picture__c, cn);
                canMap.put(cn.MSA_Picture__c, cn);
                canMap.put(cn.Passport_Size_Picture__c, cn);
                
            }
            
            list<ContentDocumentLink> conLink = [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where ContentDocumentId in:canMap.Keyset() and LinkedEntityId in ( SELECT Id FROM Candidate__c where Id=:candidateId) ];
            
            insert spNew;
            system.debug('spNew'+spNew);
            
            for(ContentDocumentLink conList :conLink ){
                system.debug('conList'+conList);
                ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = spNew.Id;
                cdl.ContentDocumentId = conList.ContentDocumentId;
                cdl.shareType = 'V';
                Insert cdl;
                system.debug('cdl'+cdl);
                
            } 
            
            
            Candidate__c canUpdate = [select Id,Name from Candidate__c where Id=:candidateId];
            canUpdate.Service_Provider__c = spNew.Id;
            update canUpdate;
            return true;
        }
        else{
            system.debug('error'); 
            
            return false;
        }
        
        
    }
}