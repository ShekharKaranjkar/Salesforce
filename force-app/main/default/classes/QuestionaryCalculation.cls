public class QuestionaryCalculation {
    public static void handleMethod (list<lead> reg){
        if(reg.get(0).What_are_the_no_of_Operational_Days__c!=null & reg.get(0).Trip_Length_Profile_one_way_distance__c!=null
           &reg.get(0).How_many_number_of_shifts__c!=null){
        Map<String, Lead_Custom_Setting__c> LeadCustomSettingMap = Lead_Custom_Setting__c.getAll();
       Decimal value1 = LeadCustomSettingMap.get(reg.get(0).What_are_the_no_of_Operational_Days__c).Weights__c;
        system.debug('Value1' +value1);
              system.debug('@@@@@@'+reg.get(0).Trip_Length_Profile_one_way_distance__c); 
         Map<String, Lead_Custom_Setting1__c> LeadCustomSettingMap1 = Lead_Custom_Setting1__c.getAll();
      Decimal value2 = LeadCustomSettingMap1.get(reg.get(0).Trip_Length_Profile_one_way_distance__c).Weights__c;
        system.debug('Value2' +value2);
         Map<String, Shift_Custom_Setting__c> LeadCustomSettingMap2 = Shift_Custom_Setting__c.getAll();
       Decimal value3 = LeadCustomSettingMap2.get(reg.get(0).How_many_number_of_shifts__c).Weights__c;
        system.debug('Value3' +value3);
       Decimal value4 =value1+value2+value3;
          system.debug('Value4' +value4);
       
         Map<String, Overall_Transportation_Cost_Savings__c> LeadCustomSettingMap3 = Overall_Transportation_Cost_Savings__c.getAll();
        	
               String finalValue = LeadCustomSettingMap3.get(String.valueof(value4)).Upto__c;
           reg.get(0).Overall_Transportation_Cost__c = finalValue;
           }
        
        if(reg.get(0).No_of_Trips_per_Day__c!=null & reg.get(0).What_are_your_Occupancies_for_vehicles__c!=null)
           {
         Map<String, Trip_Custom_Setting__c> TripCustomSetting = Trip_Custom_Setting__c.getAll();
       Decimal value01 = TripCustomSetting.get(reg.get(0).No_of_Trips_per_Day__c).Weights__c;
        system.debug('Value01' +value01);
system.debug('@!'+reg.get(0).What_are_your_Occupancies_for_vehicles__c);
         Map<String, Occupancy_Custom_Setting__c> OccupancyCustomSetting = Occupancy_Custom_Setting__c.getAll();
       Decimal value02 = OccupancyCustomSetting.get(reg.get(0).What_are_your_Occupancies_for_vehicles__c).Weights__c;
     system.debug('Value02' +value02);
        Decimal value03 =value01+value02;
        Map<String, Occupancy_Increase_Setting__c> OccupancyIncreaseSetting = Occupancy_Increase_Setting__c.getAll();
        String finalValue1 = OccupancyIncreaseSetting.get(String.valueof(value03)).By__c;
         reg.get(0).Occupancy_Increase__c = finalValue1;
}
        if(reg.get(0).Avg_Km_per_Car_per_month__c!=null & reg.get(0).Number_of_Cars_used__c!=null)
          
           {
        Map<String, Avg_km_car_month_Custom_Setting__c> AvgkmcarmonthCustomSetting = Avg_km_car_month_Custom_Setting__c.getAll();
        Decimal value001 = AvgkmcarmonthCustomSetting.get(reg.get(0).Avg_Km_per_Car_per_month__c).Km__c;
        system.debug('Value001:' +value001);
         Map<String, No_of_Car_Custom_Setting__c> NoofCarCustomSetting = No_of_Car_Custom_Setting__c.getAll();
      Decimal value002 = NoofCarCustomSetting.get(reg.get(0).Number_of_Cars_used__c).Weights__c;
     system.debug('Value002:' +value002);
        Decimal Value003 = (65*1.05*0.1*12);
        Decimal value004 =(value001*value002)*Value003;
        //String finalValue2 = String.valueof(value004);
       reg.get(0).Diesel_abatement_cost_anually__c = value004;
         }
        if(reg.get(0).Trip_Length_Profile_one_way_distance__c!=null & reg.get(0).How_many_number_of_shifts__c!=null & reg.get(0).Number_of_Cars_used__c!=null)
          
          
           {
         Map<String, Car_No_Custom_Setting__c> CarNoCustomSetting = Car_No_Custom_Setting__c.getAll();
      Decimal value006 = CarNoCustomSetting.get(reg.get(0).Number_of_Cars_used__c).Cars__c;
               system.debug('value006' +value006);
        Map<String, Lead_Custom_Setting1__c> LeadCustomSettingMap1 = Lead_Custom_Setting1__c.getAll();
      Decimal value2 = LeadCustomSettingMap1.get(reg.get(0).Trip_Length_Profile_one_way_distance__c).Weights__c;
        system.debug('Value2' +value2);
         Map<String, Shift_Custom_Setting__c> LeadCustomSettingMap2 = Shift_Custom_Setting__c.getAll();
       Decimal value3 = LeadCustomSettingMap2.get(reg.get(0).How_many_number_of_shifts__c).Weights__c;
        system.debug('Value3' +value3);
        Decimal value005 = value2+value3+value006;
               system.debug('value005' +value005);
         Map<String, Fleet_size_reduction_by_Custom_Setting__c> FleetsizereductionbyCustomSetting = Fleet_size_reduction_by_Custom_Setting__c.getAll();
        String finalValue3 = FleetsizereductionbyCustomSetting.get(String.valueof(value005)).Upto__c;
          reg.get(0).Fleet_Size_Reduction__c = finalValue3;
}
        if(reg.get(0).Avg_Km_per_Car_per_month__c!=null & reg.get(0).Number_of_Cars_used__c!=null)
         
           {
         Map<String, Avg_km_car_month_Custom_Setting__c> AvgkmcarmonthCustomSetting = Avg_km_car_month_Custom_Setting__c.getAll();
       Decimal value001 = AvgkmcarmonthCustomSetting.get(reg.get(0).Avg_Km_per_Car_per_month__c).Km__c;
        //system.debug('Value001:' +value001);
         Map<String, No_of_Car_Custom_Setting__c> NoofCarCustomSetting = No_of_Car_Custom_Setting__c.getAll();
      Decimal value002 = NoofCarCustomSetting.get(reg.get(0).Number_of_Cars_used__c).Weights__c;
     //system.debug('Value002:' +value002);
        Decimal value009 =1.1023113109244;
        Decimal value007 = ((value002*value001)*2.68)/1000;
        Decimal value008 = (value007/value009).setScale(2);
        //String finalValue4 = String.valueof(value008);
        reg.get(0).Co2e_footprint_abatement_MT_annually__c = value008;
    }
    }
   
}