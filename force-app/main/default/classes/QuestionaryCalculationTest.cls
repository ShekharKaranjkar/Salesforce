@istest
public class QuestionaryCalculationTest {
    @testSetup static void customsettingmethod() {
        Shift_Custom_Setting__c shift = new Shift_Custom_Setting__c();
        shift.Name = '2';
        shift.Weights__c = 0.2;
        Insert shift;
        Lead_Custom_Setting1__c setting1 =new Lead_Custom_Setting1__c();
        setting1.Name = '25-30 km';
        setting1.Weights__c = 0.3;
        Insert setting1;
        Overall_Transportation_Cost_Savings__c overall = New Overall_Transportation_Cost_Savings__c();
        overall.Name = '0.7';
        overall.Upto__c = 'Upto 10%';
        
        Insert overall;
        
        Lead_Custom_Setting__c setting =New Lead_Custom_Setting__c();
        setting.Name = '22';
        setting.Weights__c = 0.2;
        Insert setting;
        
        Trip_Custom_Setting__c trip = New Trip_Custom_Setting__c();
        trip.Name = '100-200';
        trip.Weights__c = 0.2;
        Insert trip;
        
        Occupancy_Custom_Setting__c occupancy = New Occupancy_Custom_Setting__c();
        occupancy.Name = '30-50%';
        occupancy.Weights__c=0.6;
        Insert occupancy;
        
        Occupancy_Increase_Setting__c increase = New Occupancy_Increase_Setting__c();
        increase.Name = '0.8';
        increase.By__c = 'By 30%';
        insert increase;
        
        Avg_km_car_month_Custom_Setting__c avg = New Avg_km_car_month_Custom_Setting__c();
        avg.Name = '2000-3000';
        avg.Km__c = 2500;
        Insert avg;
        
        No_of_Car_Custom_Setting__c cars = New No_of_Car_Custom_Setting__c();
        cars.Name = '20-40';
        cars.Weights__c = 30.0;
        Insert cars;
        
        Car_No_Custom_Setting__c carsnum = New Car_No_Custom_Setting__c();
        carsnum.name = '20-40';
        carsnum.Cars__c = 0.70;
        Insert carsnum;
        
        Fleet_size_reduction_by_Custom_Setting__c fleet =New Fleet_size_reduction_by_Custom_Setting__c();
        fleet.Name='1.20';
        fleet.Upto__c = 'Upto 25%';
        insert fleet;
        
        
    } 
    static testMethod void getFields() {
        list<Lead> l1=new list<Lead>();
        Lead l = new Lead();
        l.Status='C1: New';
        l.Company='Test Lead';
        l.LastName='Doe';
        l.FirstName='John';
        l.What_are_the_no_of_Operational_Days__c='22';
        l.Trip_Length_Profile_one_way_distance__c='25-30 km';
        l.How_many_number_of_shifts__c='2';
        l.No_of_Trips_per_Day__c='100-200';
        l.What_are_your_Occupancies_for_vehicles__c='30-50%';
        l.Avg_Km_per_Car_per_month__c='2000-3000';
        l.Number_of_Cars_used__c='20-40';
   		
        l1.add(l);
        insert l1;
        
        Test.startTest();
        QuestionaryCalculation.handleMethod(l1);
        QuestionaryCalculation1.getleadvalues(l1.get(0).Id);
        Test.stopTest();
        
        
    }
  
}