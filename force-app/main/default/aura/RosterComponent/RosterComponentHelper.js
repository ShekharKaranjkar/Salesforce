({
    GetServiceProvider : function(component, event, helper) {
  
        var action = component.get('c.getServiceProvider');
        
        //  var   temp=['--NONE--','12','24'];
        
        //   console.log('listControllingValues========'+JSON.stringify(temp));            
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                try {
                    let serviceProvidertemp = response.getReturnValue();
					        component.set('v.monthRecordTypeID',serviceProvidertemp.monthly);
        component.set('v.weekendRecordTypeID',serviceProvidertemp.weekly);
        component.set('v.weekdayRecordTypeID',serviceProvidertemp.weekday);
                    console.log('serviceProvider========'+JSON.stringify(serviceProvider)); 
                    
                    function msToHMS3( ms ) {
                        var finalTime ;
                        if(ms==0){
                          finalTime = "00:00:00.000"; 
                        }else{
                            var seconds = ms / 1000;
                        var hours = parseInt( seconds / 3600 );
                        seconds = seconds % 3600; 
                        var minutes = parseInt( seconds / 60 ); 
                        seconds = seconds % 60;
                        
                        if(minutes==0 && hours!=0){
                            if(hours<12){
                                finalTime = "0"+hours+":"+"00"+":00.000"; 
                                //  alert('if'+finalTime);
                            }else{
                                finalTime = hours+":"+"00"+":00.000"; 
                            }
                        }
                        else    if(minutes!=0 && hours==0){
                            finalTime = "00"+":"+minutes+":00.000"; 
                            //  alert('if'+finalTime);
                            
                        }
                            else if(hours!=0 && minutes!=0 ){
                                if(hours<12){
                                    finalTime = "0"+hours+":"+minutes+":00.000"; 
                                }else{
                                    finalTime = hours+":"+minutes+":00.000"; 
                                }
                            }
                        }
                        
                        // alert('else'+finalTime);
                        return finalTime;
                        
                    }
                    var rosterObj={
                        "lithiumId": "",
                        "count":0,
                        "driverName": "",
                        "UpdateMonthly":false,
                        "UpdateWeekDay":false,
                        "UpdateWeekend":false,
                        "rosterPresent":false,
                        "Site__c": "",
                        "monthRost": 
                        {
                            "Lithium_ID__c": "",
                            "Id": "",
                            "Status_From_Parent__c":"",
                            "All_Status__c":"",
                            "weekOff":false,
                            "serviceProviderId":"",
                            "Name": "",
                            "DriverName":"",
                            "End_Time__c":"",
                            "Start_Time__c":"",
                            "LithiumIds__c": "",
                            "Shift_Start_Date__c": "",
                            "Shift_End_Date__c": "",
                            "Shift_End_Date_Temp": "",
                            "RecordTypeId": "",
                            "Shift__c": "",
                            "Sunday__c":false,
                            "Monday__c": false,
                            "Tuesday__c": false,
                            "Wednesday__c":false,
                            "Thrusday__c": false,
                            "Friday__c": false,
                            "Saturday__c": false,
                            "new": false,
                            "Update":false,
                            "Site__c":"",
                            "Status__c":""
                        },
                        
                        "weekdayRost": 
                        {
                            
                            "Id": "",
                            "Status_From_Parent__c":"",
                            "All_Status__c":"",
                            "serviceProviderId":"",
                            "DriverName":"",
                            "LithiumIds__c": "",
                            "Start_Time__c": "",
                            "End_Time__c": "",
                            "Shift_Start_Date__c": "",
                            "Shift_End_Date__c": "",
                            "Shift_End_Date_Temp": "",
                                                        "Sunday__c":false,
                            "Monday__c": false,
                            "Tuesday__c": false,
                            "Wednesday__c":false,
                            "Thrusday__c": false,
                            "Friday__c": false,
                            "Saturday__c": false,
                            "End_Time__c":"",
                            "Start_Time__c":"",
                            "RecordTypeId": "",
                              "Site__c":"",
                            "Shift__c": "",
                            "new": false,
                            "Update":false,
                            "Status__c":""
                        },
                        "weekendRost": 
                        {
                            "Id": "",
                            "Status_From_Parent__c":"",
                            "All_Status__c":"",
                            "DriverName":"",
                            "serviceProviderId":"",
                            "LithiumIds__c": "",
                            "Start_Time__c": "",
                            "End_Time__c": "",
                            "Shift_Start_Date__c": "",
                            "Shift_End_Date__c": "",
                                                        "Sunday__c":false,
                            "Monday__c": false,
                            "Tuesday__c": false,
                            "Wednesday__c":false,
                            "Thrusday__c": false,
                            "Friday__c": false,
                            "Saturday__c": false,
                            "End_Time__c":"",
                            "Start_Time__c":"",
                            "Shift_End_Date_Temp": "",
                            "RecordTypeId": "",
                            "Shift__c": "",
                              "Site__c":"",
                            "new": false,
                            "Update":false,
                            "Status__c":""
                        }
                        
                    }
                    var newlistServiceProvider = new Array();
                  var serviceProvider=serviceProvidertemp.sp;
                    for(let i=0 ; i<serviceProvider.length ; i++){
                        let rosterObjTemp = new Object();
                        rosterObjTemp= JSON.parse(JSON.stringify(rosterObj));
                        
                        rosterObjTemp.Site__c=serviceProvider[i].Site__c;
                        rosterObjTemp.weekendRost.DriverName=serviceProvider[i].Name;
                        rosterObjTemp.weekendRost.LithiumIds__c=serviceProvider[i].LithiumIds__c;
                        rosterObjTemp.weekendRost.serviceProviderId=serviceProvider[i].Id;
                        
                        rosterObjTemp.monthRost.DriverName=serviceProvider[i].Name;
                        rosterObjTemp.monthRost.LithiumIds__c=serviceProvider[i].LithiumIds__c;
                        rosterObjTemp.monthRost.serviceProviderId=serviceProvider[i].Id;
                        
                        rosterObjTemp.weekdayRost.DriverName=serviceProvider[i].Name;
                        rosterObjTemp.weekdayRost.LithiumIds__c=serviceProvider[i].LithiumIds__c;
                        rosterObjTemp.weekdayRost.serviceProviderId=serviceProvider[i].Id;
                        
                        
                        
                        if(serviceProvider[i].Rostering__r == undefined){
                            
                         //   console.log('rosterObjTempundefined========'+JSON.stringify(rosterObj)); 
                            
                            newlistServiceProvider.push(JSON.parse(JSON.stringify(rosterObjTemp)));
                        }
                        else{
                         //   console.log('else'); 
                            var roster= serviceProvider[i].Rostering__r
                            for(let t=0 ; t<roster.length ; t++){
                                var flagMonthRost=false;
                                var flagweekdayRost=false;
                                var flagweekendRost=false;
                                if(roster[t].RecordType.Name=='Monthly'){
                                    flagMonthRost=true;
                                    
                                }
                                else if(roster[t].RecordType.Name=='Weekend'){
                                    flagweekendRost=true;
                                }
                                    else  if(roster[t].RecordType.Name=='Weekday'){
                                        flagweekdayRost=true;
                                    }
                                
                                
                                
                                if(flagMonthRost){
                                     
                     
                               rosterObjTemp.UpdateMonthly=true;   
                                    rosterObjTemp.monthRost.All_Status__c=roster[t].All_Status__c;    
                                 
                                    rosterObjTemp.monthRost.Status_From_Parent__c=roster[t].Status_From_Parent__c;  
                                 //   rosterObjTemp.monthRost.Site__c=roster[t].Site__c;
                                    rosterObjTemp.monthRost.weekOff=true;
                                    rosterObjTemp.monthRost.Id=roster[t].Id;
                                    rosterObjTemp.monthRost.RecordTypeId=roster[t].RecordTypeId;
                                    rosterObjTemp.monthRost.Shift__c=roster[t].Shift__c;
                                    rosterObjTemp.monthRost.Sunday__c=!(roster[t].Sunday__c);
                                    rosterObjTemp.monthRost.Monday__c=!(roster[t].Monday__c);
                                    rosterObjTemp.monthRost.Tuesday__c=!(roster[t].Tuesday__c);
                                    rosterObjTemp.monthRost.Wednesday__c=!(roster[t].Wednesday__c);
                                    rosterObjTemp.monthRost.Thrusday__c=!(roster[t].Thrusday__c);
                                    rosterObjTemp.monthRost.Friday__c=!(roster[t].Friday__c);
                                    rosterObjTemp.monthRost.Saturday__c=!(roster[t].Saturday__c);
                                    rosterObjTemp.monthRost.End_Time__c=msToHMS3(roster[t].End_Time__c);
                                    rosterObjTemp.monthRost.Start_Time__c=msToHMS3(roster[t].Start_Time__c);
                                    rosterObjTemp.monthRost.Shift_Start_Date__c=roster[t].Shift_Start_Date__c;
                                    rosterObjTemp.monthRost.Shift_End_Date__c=roster[t].Shift_End_Date__c;
                                    rosterObjTemp.monthRost.Shift_End_Date_Temp=roster[t].Shift_End_Date__c;
                                   rosterObjTemp.monthRost.Status__c=roster[t].Status__c;
                                    
                                }
                                if(flagweekendRost){
                                                    
                     //     rosterObjTemp.UpdateWeekend.Site__c=roster[t].Site__c;
                               rosterObjTemp.UpdateWeekend=true;
                                    rosterObjTemp.weekendRost.All_Status__c=roster[t].All_Status__c; 
                                    rosterObjTemp.weekendRost.Status_From_Parent__c=roster[t].Status_From_Parent__c; 
                                    rosterObjTemp.weekendRost.Id=roster[t].Id;
                                    rosterObjTemp.weekendRost.Sunday__c=roster[t].Sunday__c;
                                    rosterObjTemp.weekendRost.Monday__c=roster[t].Monday__c;
                                    rosterObjTemp.weekendRost.Tuesday__c=roster[t].Tuesday__c;
                                    rosterObjTemp.weekendRost.Wednesday__c=roster[t].Wednesday__c;
                                    rosterObjTemp.weekendRost.Thrusday__c=roster[t].Thrusday__c;
                                    rosterObjTemp.weekendRost.Friday__c=roster[t].Friday__c;
                                    rosterObjTemp.weekendRost.Saturday__c=roster[t].Saturday__c;
                                    rosterObjTemp.weekendRost.Shift__c=roster[t].Shift__c;
                                    rosterObjTemp.weekendRost.Shift_Start_Date__c=roster[t].Shift_Start_Date__c;
                                    rosterObjTemp.weekendRost.Shift_End_Date__c=roster[t].Shift_End_Date__c;
                                    rosterObjTemp.weekendRost.Shift_End_Date_Temp=roster[t].Shift_End_Date__c;
                                    rosterObjTemp.weekendRost.End_Time__c=msToHMS3(roster[t].End_Time__c);
                                    rosterObjTemp.weekendRost.Start_Time__c=msToHMS3(roster[t].Start_Time__c);
                                  rosterObjTemp.weekendRost.Status__c=roster[t].Status__c;
                                }
                                
                                if(flagweekdayRost){
                                    
                         //    rosterObjTemp.UpdateWeekDay.Site__c=roster[t].Site__c;
                               rosterObjTemp.UpdateWeekDay=true;
                                    rosterObjTemp.weekdayRost.All_Status__c=roster[t].All_Status__c; 
                                    rosterObjTemp.weekdayRost.Status_From_Parent__c=roster[t].Status_From_Parent__c; 
                                    rosterObjTemp.weekdayRost.Id=roster[t].Id;
                                    rosterObjTemp.weekdayRost.Shift__c=roster[t].Shift__c;
                                    rosterObjTemp.weekdayRost.Sunday__c=roster[t].Sunday__c;
                                    rosterObjTemp.weekdayRost.Monday__c=roster[t].Monday__c;
                                    rosterObjTemp.weekdayRost.Tuesday__c=roster[t].Tuesday__c;
                                    rosterObjTemp.weekdayRost.Wednesday__c=roster[t].Wednesday__c;
                                    rosterObjTemp.weekdayRost.Thrusday__c=roster[t].Thrusday__c;
                                    rosterObjTemp.weekdayRost.Friday__c=roster[t].Friday__c;
                                    rosterObjTemp.weekdayRost.Saturday__c=roster[t].Saturday__c;
                                    rosterObjTemp.weekdayRost.Shift_Start_Date__c=roster[t].Shift_Start_Date__c;
                                    rosterObjTemp.weekdayRost.Shift_End_Date__c=roster[t].Shift_End_Date__c;
                                    rosterObjTemp.weekdayRost.End_Time__c=msToHMS3(roster[t].End_Time__c);
                                    rosterObjTemp.weekdayRost.Start_Time__c=msToHMS3(roster[t].Start_Time__c);
                                    rosterObjTemp.weekdayRost.Shift_End_Date_Temp=roster[t].Shift_End_Date__c;
                                    rosterObjTemp.weekdayRost.Status__c=roster[t].Status__c;
                                }
                                
                            }
                            rosterObjTemp.rosterPresent=true; 
                           // rosterObjTemp.count=1;
                            newlistServiceProvider.push(JSON.parse(JSON.stringify(rosterObjTemp)));
                        }
                    }
                    console.log('newlistServiceProvider========'+JSON.stringify(newlistServiceProvider)); 
                    component.set('v.serviceProviderList',newlistServiceProvider);
              
                }
                catch(err) {
                    console.log('error-------------'+err.message);
                }
            }
            
        });
        $A.enqueueAction(action);
    },
    errorMsgTost : function(component, event, helper,msg) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error Message',
            message:msg,
            messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
            duration:' 2000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
        
    },
})