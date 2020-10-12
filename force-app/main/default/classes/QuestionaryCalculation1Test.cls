@isTest
public class QuestionaryCalculation1Test {
    static testMethod void getFields4222() {
        
        Avg_km_car_month_Custom_Setting__c ak = new Avg_km_car_month_Custom_Setting__c();
        ak.Name = '2000-3000';
        ak.Km__c = 2500;
        insert ak;
        
        No_of_Car_Custom_Setting__c nc = new No_of_Car_Custom_Setting__c();
        nc.Name = '20-40';
        nc.Weights__c = 20;
        insert nc;
        
        Lead_Custom_Setting__c lc = new Lead_Custom_Setting__c();
        lc.Name = '2';
        lc.Weights__c = 20;
        insert lc;
        
        Lead_Custom_Setting1__c lcs1 = new Lead_Custom_Setting1__c();
        lcs1.Name = '10-25 km';
        lcs1.Weights__c = 20;
        insert lcs1;
        
        Shift_Custom_Setting__c scs = new Shift_Custom_Setting__c();
        scs.Name = '2';
        scs.Weights__c = 20;
        insert scs;
        
        Overall_Transportation_Cost_Savings__c ots = new Overall_Transportation_Cost_Savings__c();
        ots.Name = '60.0';
        ots.Weights__c = 100;
        ots.Upto__c = '20';
        insert ots;
        
        Car_No_Custom_Setting__c cnc = new Car_No_Custom_Setting__c();
        cnc.Name ='20-40';
        cnc.Cars__c = 2;
        insert cnc;
        
        Fleet_size_reduction_by_Custom_Setting__c fsr = new Fleet_size_reduction_by_Custom_Setting__c();
        fsr.Name = '42.00';
        fsr.Upto__c = '30';
        insert fsr;
        
        Lead l235 = new Lead();
        l235.Status='C1: New';
        l235.Company='Test Lead';
        l235.LastName='Doe';
        l235.FirstName='John';
        l235.Avg_Km_per_Car_per_month__c='2000-3000';
        l235.What_are_the_no_of_Operational_Days__c = '2';
        l235.Trip_Length_Profile_one_way_distance__c = '10-25 km';
        l235.How_many_number_of_shifts__c = '2';
        
        l235.Number_of_Cars_used__c='20-40';
        
        insert l235;
        String str=l235.Id;
        
        Test.startTest();
        QuestionaryCalculation1.getleadvalues(str);
        Test.stopTest();
        
        
    }
}