public class VehicleAssignmentTriggerHelper{
    public static void  checkOdoMeterReading(List<Vehicle_Assignment__c> vehicleAssignmentList,Map<id,Vehicle_Assignment__c> vehicleAssignmentMap){
        system.debug('vehicleAssignmentList@@'+ vehicleAssignmentList);
        
        integer tenthousand=10000;
        integer twentythousand = 20000;
        integer thirtythousand=30000;
        integer Fourtythousand=40000;
        integer fiftythousand=50000;
        integer sixtythousand=60000;
        integer seventythousand = 70000;
        integer eightythousand = 80000;
        
        set<id> issueset = new set<id>();
        list<Issues__c> duplicateissue =[SELECT Id, Name, Maintenance_Planned_Date__c, scheduled_Maintenance_Type__c FROM Issues__c] ;
        
     //   duplicateissue.add(issueset.id);
        Set<ID> vehiclesAssignmentSet = New Set<ID>();
        system.debug('vehiclesAssignmentSet'+vehiclesAssignmentSet);
        List<Issues__c> islist = new List<Issues__c>();
          
        Id devRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByName().get('Scheduled Maintenance').getRecordTypeId();
        
     //    List<Vehicle_Assignment__c> vehicleAssin = [select id,name,Odometer_reading__c,Vehicle__r.Status1__c,Vehicle__r.LastModifieddate,Vehicle__r.LastModifiedById from Vehicle_Assignment__c Where ID IN: vehiclesAssignmentSet]  ;
        
        for (Vehicle_Assignment__c vehicleAssin : vehicleAssignmentList){
            If(vehicleAssignmentMap.get(vehicleAssin.id).Odometer_reading__c!=vehicleAssin.Odometer_reading__c){ 
                 
            vehiclesAssignmentSet.add(vehicleAssin.ID);
            
            System.debug('Updated Id' + vehiclesAssignmentSet);
         vehicleAssin  = [select id,name,Odometer_reading__c,Vehicle__r.Status1__c,Vehicle__r.LastModifieddate,Vehicle__r.LastModifiedById from Vehicle_Assignment__c Where ID IN: vehiclesAssignmentSet]  ;
            
            system.debug('vehicleAssin'+vehicleAssin);            
            
            if (vehicleAssin.Odometer_reading__c >= eightythousand){
                
                 if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifiedById == '0055D000002vhCqQAI'){
                        Issues__c isuethreemonths = new Issues__c();
                        isuethreemonths.RecordTypeId = devRecordTypeId;
                        isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        isuethreemonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(3)   ;
                        islist.add(isuethreemonths);
                        system.debug('isue5'+isuethreemonths);
                        Issues__c isuesixmonths = new Issues__c();
                        isuesixmonths.RecordTypeId = devRecordTypeId;
                        isuesixmonths.scheduled_Maintenance_Type__c = '3M Cleaning Exterior'+';'+'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        isuesixmonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(6)   ;
                        
                        islist.add(isuesixmonths);
                        system.debug('isue6'+isuesixmonths);
                
                 }  else  if (vehicleAssin.Odometer_reading__c >= eightythousand){
                Issues__c isueeighty= new Issues__c();
                
                isueeighty.RecordTypeId = devRecordTypeId	;
                isueeighty.scheduled_Maintenance_Type__c = 'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                islist.add(isueeighty);
                system.debug('isue1'+isueeighty);
            }
            }
            else 
                if(vehicleAssin.Odometer_reading__c >= seventythousand ){
                   if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifiedById == '0055D000002vhCqQAI'){
                        Issues__c isuethreemonths = new Issues__c();
                        isuethreemonths.RecordTypeId = devRecordTypeId;
                        isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        isuethreemonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(3)   ;
                        islist.add(isuethreemonths);
                        system.debug('isue5'+isuethreemonths);
                        Issues__c isuesixmonths = new Issues__c();
                        isuesixmonths.RecordTypeId = devRecordTypeId;
                        isuesixmonths.scheduled_Maintenance_Type__c = '3M Cleaning Exterior'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        isuesixmonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(6)   ;
                        
                        islist.add(isuesixmonths);
                        system.debug('isue6'+isuesixmonths);
                    }
                    else if (vehicleAssin.Odometer_reading__c >= seventythousand ){
                    Issues__c isueseventy= new Issues__c();
                    isueseventy.RecordTypeId = devRecordTypeId;
                    isueseventy.scheduled_Maintenance_Type__c = 'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                    islist.add(isueseventy);
                    system.debug('isue2'+isueseventy);
                }
                }
            else
                if (vehicleAssin.Odometer_reading__c >= twentythousand || vehicleAssin.Odometer_reading__c >= thirtythousand ||vehicleAssin.Odometer_reading__c >= Fourtythousand ||vehicleAssin.Odometer_reading__c >= fiftythousand ||vehicleAssin.Odometer_reading__c >= sixtythousand ){
                     if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifiedById == '0055D000002vhCqQAI'){
                        Issues__c isuethreemonths = new Issues__c();
                        isuethreemonths.RecordTypeId = devRecordTypeId;
                        isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Scheduled Service'+';'+'Wheel Alignment';
                        isuethreemonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(3)   ;
                        islist.add(isuethreemonths);
                        system.debug('isue5'+isuethreemonths);
                        Issues__c isuesixmonths = new Issues__c();
                        isuesixmonths.RecordTypeId = devRecordTypeId;
                        isuesixmonths.scheduled_Maintenance_Type__c = '3M Cleaning Exterior'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        isuesixmonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(6)   ;
                        
                        islist.add(isuesixmonths);
                        system.debug('isue6'+isuesixmonths);
                    }
                 else
                    if  (vehicleAssin.Odometer_reading__c >= twentythousand || vehicleAssin.Odometer_reading__c >= thirtythousand ||vehicleAssin.Odometer_reading__c >= Fourtythousand ||vehicleAssin.Odometer_reading__c >= fiftythousand ||vehicleAssin.Odometer_reading__c >= sixtythousand){
                         Issues__c isuetwenty = new Issues__c();
                      isuetwenty.RecordTypeId = devRecordTypeId;
                    isuetwenty.scheduled_Maintenance_Type__c = 'Scheduled Service'+';'+'Wheel Alignment';
                    islist.add(isuetwenty);
                    system.debug('isue3'+isuetwenty);
                    }
            
                }
            else
                if (vehicleAssin.Odometer_reading__c >= tenthousand){
                    if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifiedById == '0055D000002vhCqQAI'){
                        Issues__c isuethreemonths = new Issues__c();
                        isuethreemonths.RecordTypeId = devRecordTypeId;
                        isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Wheel Alignment';
                        isuethreemonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(3)   ;
                        islist.add(isuethreemonths);
                        system.debug('isue5'+isuethreemonths);
                        Issues__c isuesixmonths = new Issues__c();
                        isuesixmonths.RecordTypeId = devRecordTypeId;
                        isuesixmonths.scheduled_Maintenance_Type__c = '3M Cleaning Exterior'+';'+'Wheel Alignment';
                        isuesixmonths.Maintenance_Planned_Date__c = vehicleAssin.Vehicle__r.LastModifieddate.date().addMonths(6)   ;
                        
                        islist.add(isuesixmonths);
                        system.debug('isue6'+isuesixmonths);
                    }else
                        if  (vehicleAssin.Odometer_reading__c >= tenthousand){
                         //   Vehicle_Assignment__c  updatecvechile = [SELECT Id, Vehicle__c, Odometer_reading__c FROM Vehicle_Assignment__c where Id=:vehicleAssin.Id];
                            Issues__c isueten = new Issues__c();
                            isueten.RecordTypeId = devRecordTypeId;
                            isueten.Scheduled_Maintenance_Type__c = 'Wheel Alignment';
                            islist.add(isueten);
                            system.debug('isue4'+isueten);
                        }
                }

            
            }
        }
        
                    if(islist.size() > 0){
                        insert islist;
                        system.debug('qw'+islist);
                    } 
                    
        for     (Vehicle_Assignment__c vehicleAssin : vehicleAssignmentList){
            
        }
                
        }
        }