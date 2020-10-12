public class VehicleAssignmentTriggerHelper1{
    public static void  checkOdoMeterReading1(List<Vehicle_Assignment__c> vehicleAssignmentList,Map<id,Vehicle_Assignment__c> vehicleAssignmentMap){
        system.debug('vehicleAssignmentList@@'+ vehicleAssignmentList);
        
        integer tenthousand=10000;
        integer twentythousand = 20000;
        integer thirtythousand=30000;
        integer Fourtythousand=40000;
        integer fiftythousand=50000;
        integer sixtythousand=60000;
        integer seventythousand = 70000;
        integer eightythousand = 80000;
        Id devRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByName().get('Scheduled Maintenance').getRecordTypeId();
        
        
        //   duplicateissue.add(issueset.id);
        Set<ID> vehiclesAssignmentSet = New Set<ID>();
        system.debug('vehiclesAssignmentSet'+vehiclesAssignmentSet);
        List<Issues__c> islist = new List<Issues__c>();
        
        
        
        //    List<Vehicle_Assignment__c> vehicleAssin = [select id,name,Odometer_reading__c,Vehicle__r.Status1__c,Vehicle__r.LastModifieddate,Vehicle__r.LastModifiedById from Vehicle_Assignment__c Where ID IN: vehiclesAssignmentSet]  ;
        
       /* for (Vehicle_Assignment__c vehicleAssin : vehicleAssignmentList){
            If(vehicleAssignmentMap.get(vehicleAssin.id).Odometer_reading__c!=vehicleAssin.Odometer_reading__c){ 
                
                vehiclesAssignmentSet.add(vehicleAssin.ID);
            }*/
            
              //  System.debug('Updated Id' + vehiclesAssignmentSet);
            for (Vehicle_Assignment__c vehicleAssin  : [select id,name,Odometer_reading__c,Vehicle__r.Status1__c,Vehicle__r.LastModifieddate,Vehicle__r.LastModifiedById from Vehicle_Assignment__c Where ID IN: vehicleAssignmentMap.keyset()] ){
                
                system.debug('vehicleAssin'+vehicleAssin);            
                If(vehicleAssignmentMap.get(vehicleAssin.id).Odometer_reading__c!=vehicleAssin.Odometer_reading__c){ 
                if (vehicleAssin.Odometer_reading__c >= eightythousand){
                    system.debug(date.today());
                    system.debug('vehicleAssin.Vehicle__r.Status1__c :'+vehicleAssin.Vehicle__r.Status1__c);
                    system.debug('vehicleAssin.Vehicle__r.LastModifieddate :'+vehicleAssin.Vehicle__r.LastModifieddate);
                    if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                        Issues__c isuethreemonths = new Issues__c();
                        isuethreemonths.RecordTypeId = devRecordTypeId;
                        isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                        isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                        isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                        isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                        islist.add(isuethreemonths);
                        system.debug('isue5'+isuethreemonths);
                        // system.debug('Odometer_Reading__c'+ isuethreemonths.Odometer_Reading__c );
                        
                        
                    }  else  if (vehicleAssin.Odometer_reading__c >= eightythousand){
                        Issues__c isueeighty= new Issues__c();
                        isueeighty.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                        isueeighty.Vehicle_Assignment__c = vehicleAssin.Id;
                         isueeighty.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                        isueeighty.RecordTypeId = devRecordTypeId	;
                        isueeighty.scheduled_Maintenance_Type__c = 'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        islist.add(isueeighty);
                        system.debug('isue1'+isueeighty);
                    }
                }
                else 
                    if(vehicleAssin.Odometer_reading__c >= seventythousand ){
                        if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                            Issues__c isuethreemonths = new Issues__c();
                            isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                            isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isuethreemonths.RecordTypeId = devRecordTypeId;
                            isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                            islist.add(isuethreemonths);
                            system.debug('isue5'+isuethreemonths);
                            
                        }
                        else if (vehicleAssin.Odometer_reading__c >= seventythousand ){
                            Issues__c isueseventy= new Issues__c();
                            isueseventy.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isueseventy.Vehicle_Assignment__c = vehicleAssin.Id;
                             isueseventy.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isueseventy.RecordTypeId = devRecordTypeId;
                            isueseventy.scheduled_Maintenance_Type__c = 'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                            islist.add(isueseventy);
                            system.debug('isue2'+isueseventy);
                        }
                    }
                else
                    if (vehicleAssin.Odometer_reading__c >= twentythousand || vehicleAssin.Odometer_reading__c >= thirtythousand ||vehicleAssin.Odometer_reading__c >= Fourtythousand ||vehicleAssin.Odometer_reading__c >= fiftythousand ||vehicleAssin.Odometer_reading__c >= sixtythousand ){
                        if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                            Issues__c isuethreemonths = new Issues__c();
                            isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                             isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isuethreemonths.RecordTypeId = devRecordTypeId;
                            isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Scheduled Service'+';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                            islist.add(isuethreemonths);
                            system.debug('isue5'+isuethreemonths);
                            
                        }
                        else
                            if  (vehicleAssin.Odometer_reading__c >= twentythousand || vehicleAssin.Odometer_reading__c >= thirtythousand ||vehicleAssin.Odometer_reading__c >= Fourtythousand ||vehicleAssin.Odometer_reading__c >= fiftythousand ||vehicleAssin.Odometer_reading__c >= sixtythousand){
                                Issues__c isuetwenty = new Issues__c();
                                isuetwenty.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                                isuetwenty.Vehicle_Assignment__c = vehicleAssin.Id;
                                 isuetwenty.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                                isuetwenty.RecordTypeId = devRecordTypeId;
                                isuetwenty.scheduled_Maintenance_Type__c = 'Scheduled Service'+';'+'Wheel Alignment';
                                islist.add(isuetwenty);
                                system.debug('isue3'+isuetwenty);
                            }
                        
                    }
                else
                    if (vehicleAssin.Odometer_reading__c >= tenthousand){
                        if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                            Issues__c isuethreemonths = new Issues__c();
                            isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                             isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isuethreemonths.RecordTypeId = devRecordTypeId;
                            isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                            islist.add(isuethreemonths);
                            system.debug('isue5'+isuethreemonths);
                            
                        }else
                            if  (vehicleAssin.Odometer_reading__c >= tenthousand){
                                Issues__c isueten = new Issues__c();
                                isueten.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                                 isueten.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                                isueten.Vehicle_Assignment__c = vehicleAssin.Id;
                                isueten.RecordTypeId = devRecordTypeId;
                                isueten.Scheduled_Maintenance_Type__c = 'Wheel Alignment';
                                islist.add(isueten);
                                system.debug('isue4'+isueten);
                            }
                    }
                
                }
            
            If(vehicleAssignmentMap.get(vehicleAssin.id).Vehicle__c!=vehicleAssin.Vehicle__c){ 
                
              /*  vehiclesAssignmentSet.add(vehicleAssin.ID);
                
                System.debug('Updated Id' + vehiclesAssignmentSet);
                vehicleAssin  = [select id,name,Odometer_reading__c,Vehicle__r.Status1__c,Vehicle__r.LastModifieddate,Vehicle__r.LastModifiedById from Vehicle_Assignment__c Where ID IN: vehiclesAssignmentSet]  ;
                
                system.debug('vehicleAssin'+vehicleAssin);      */      
                
                if (vehicleAssin.Odometer_reading__c >= eightythousand){
                    
                    if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                        Issues__c isuethreemonths = new Issues__c();
                        isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                        isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                         isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                        isuethreemonths.RecordTypeId = devRecordTypeId;
                        isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                        islist.add(isuethreemonths);
                        system.debug('isue5'+isuethreemonths);
                        
                    }  else  if (vehicleAssin.Odometer_reading__c >= eightythousand){
                        Issues__c isueeighty= new Issues__c();
                        isueeighty.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                        isueeighty.Vehicle_Assignment__c = vehicleAssin.Id;
                         isueeighty.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                        isueeighty.RecordTypeId = devRecordTypeId	;
                        isueeighty.scheduled_Maintenance_Type__c = 'Battery Service'+';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                        islist.add(isueeighty);
                        system.debug('isue1'+isueeighty);
                    }
                }
                else 
                    if(vehicleAssin.Odometer_reading__c >= seventythousand ){
                        if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                            Issues__c isuethreemonths = new Issues__c();
                            isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                             isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isuethreemonths.RecordTypeId = devRecordTypeId;
                            isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                            islist.add(isuethreemonths);
                            system.debug('isue5'+isuethreemonths);
                            
                        }
                        else if (vehicleAssin.Odometer_reading__c >= seventythousand ){
                            Issues__c isueseventy= new Issues__c();
                            isueseventy.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isueseventy.Vehicle_Assignment__c = vehicleAssin.Id;
                             isueseventy.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isueseventy.RecordTypeId = devRecordTypeId;
                            isueseventy.scheduled_Maintenance_Type__c = 'Tyre Change'+';'+'Scheduled Service'+';'+'Wheel Alignment';
                            islist.add(isueseventy);
                            system.debug('isue2'+isueseventy);
                        }
                    }
                else
                    if (vehicleAssin.Odometer_reading__c >= twentythousand || vehicleAssin.Odometer_reading__c >= thirtythousand ||vehicleAssin.Odometer_reading__c >= Fourtythousand ||vehicleAssin.Odometer_reading__c >= fiftythousand ||vehicleAssin.Odometer_reading__c >= sixtythousand ){
                        if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                            Issues__c isuethreemonths = new Issues__c();
                            isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                             isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isuethreemonths.RecordTypeId = devRecordTypeId;
                            isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Scheduled Service'+';'+'Wheel Alignment'+';'+'3M Cleaning Exterior';
                            islist.add(isuethreemonths);
                            system.debug('isue5'+isuethreemonths);
                        }
                        else
                            if  (vehicleAssin.Odometer_reading__c >= twentythousand || vehicleAssin.Odometer_reading__c >= thirtythousand ||vehicleAssin.Odometer_reading__c >= Fourtythousand ||vehicleAssin.Odometer_reading__c >= fiftythousand ||vehicleAssin.Odometer_reading__c >= sixtythousand){
                                Issues__c isuetwenty = new Issues__c();
                                isuetwenty.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                                isuetwenty.Vehicle_Assignment__c = vehicleAssin.Id;
                                 isuetwenty.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                                isuetwenty.RecordTypeId = devRecordTypeId;
                                isuetwenty.scheduled_Maintenance_Type__c = 'Scheduled Service'+';'+'Wheel Alignment';
                                islist.add(isuetwenty);
                                system.debug('isue3'+isuetwenty);
                            }
                        
                    }
                else
                    if (vehicleAssin.Odometer_reading__c >= tenthousand){
                        if(vehicleAssin.Vehicle__r.Status1__c == 	'Onroad' && vehicleAssin.Vehicle__r.LastModifieddate.date() == Date.today()){
                            Issues__c isuethreemonths = new Issues__c();
                            isuethreemonths.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                            isuethreemonths.Vehicle_Assignment__c = vehicleAssin.Id;
                             isuethreemonths.Vehicle__c =  vehicleAssin.Vehicle__r.id;
                            isuethreemonths.RecordTypeId = devRecordTypeId;
                            isuethreemonths.scheduled_Maintenance_Type__c = '3M Cleaning Interior' +';'+'Wheel Alignment'+';'+ '3M Cleaning Exterior';
                            islist.add(isuethreemonths);
                            system.debug('isue5'+isuethreemonths);
                            
                        }else
                            if  (vehicleAssin.Odometer_reading__c >= tenthousand){
                                Issues__c isueten = new Issues__c();
                                isueten.Odometer_Reading__c = vehicleAssin.Odometer_reading__c;
                                isueten.Vehicle_Assignment__c = vehicleAssin.Id;
                                 isueten.Vehicle__c =  vehicleAssin.Vehicle__r.id;
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
        
    }
}