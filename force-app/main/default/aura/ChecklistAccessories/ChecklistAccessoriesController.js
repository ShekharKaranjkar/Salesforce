({
    doInit : function(component, event, helper) {
        component.set("v.vehiclid",component.get('v.recordId'));
        
        var action = component.get("c.getcheckvalues");
        var  newEvent = component.get('v.recordId');
        action.setParams({ 
            "id": newEvent
        }); 
        action.setCallback(this, function(a) {
            //alert('set call back');
            //$A.get('e.force:refreshView').fire();
            var state = a.getState();
            if (state === "SUCCESS") {
                var returnval = a.getReturnValue();
                
                if(returnval.acceslist.length == 1){
                    
                    var toastEvent = $A.get("e.force:showToast");
                    
                    toastEvent.setParams({
                        title : 'Error Message',
                        message: ' "There is already a record for thid record type."',
                        messageTemplate: 'Record {0} created! See it {1}!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                    //window.location.reload();
                    var dismissQuickAction = $A.get("e.force:closeQuickAction");
                    dismissQuickAction.fire();
                    
                    
                }
				 else{
                
              component.set("v.Vehiclerec",returnval.vehcl[0]);
                    
                    //var carrec = {'Id':returnval.Site__r.Location__r.OwnerId,'Name':returnval.Site__r.Location__r.Owner.Name};
                   var carrec = {'Id':returnval.vehcl[0].OwnerId,'Name':returnval.vehcl[0].Owner.Name};
                component.set("v.userobj", carrec);
                    var  vehicle = component.get('v.Vehiclerec');
                    var vehiclarray = [];
                    console.log('vehicle'+vehicle);
                    vehiclarray.push(vehicle);
                    component.set("v.selectedLookUpRecords", vehiclarray);
                    //component.set("v.selectedLookUpRecords",id);
                    var eventrec = component.get("v.driverList");
                    
                    eventrec.Vehicle__c =returnval.acceslist.Id;
                    eventrec.OwnerId =returnval.acceslist.Site__r.Location__r.OwnerId;
                   component.set("v.driverList", eventrec);
                    console.log('eventrec'+JSON.stringify(eventrec));
                    toastEvent.fire();
                    // alert('eventrec'+eventrec);
                    //window.location.reload();
                    var dismissQuickAction = $A.get("e.force:closeQuickAction");
                    dismissQuickAction.fire();
                    
            }
            }
            
        });
        
        $A.enqueueAction(action);
        //alert('recordtypeid'+component.get('v.recordTypeId'))
    },
    CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        cmp.set("v.radioValue1",changeValue);
        //alert('radio val : '+cmp.get("v.driverList.First_Aid_kit__c"));
        cmp.set("v.driverList.First_Aid_kit__c",changeValue);
    },
    
    CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
        cmp.set("v.radioValue2",changeValue1);
        cmp.set("v.driverList.Torch__c",changeValue1);
    },
    CarHandleChange2: function (cmp, event) {
        var changeValue2 = event.getParam("value");
        cmp.set("v.radioValue3",changeValue2);
        cmp.set("v.driverList.Mats__c",changeValue2);
    },
    CarHandleChange3: function (cmp, event) {
        var changeValue3 = event.getParam("value");
        cmp.set("v.radioValue4",changeValue3);
        cmp.set("v.driverList.Umbrella__c",changeValue3);
    },
    CarHandleChange4: function (cmp, event) {
        var changeValue4 = event.getParam("value");
        cmp.set("v.radioValue5",changeValue4);
        cmp.set("v.driverList.Sleep_Alert__c",changeValue4);
    },
    CarHandleChange5: function (cmp, event) {
        var changeValue5 = event.getParam("value");
        cmp.set("v.radioValue6",changeValue5);
        cmp.set("v.driverList.Spare_Wheel__c",changeValue5);
    },
    CarHandleChange6: function (cmp, event) {
        var changeValue6 = event.getParam("value");
        cmp.set("v.radioValue7",changeValue6);
        cmp.set("v.driverList.Physical_Condition_scratches_dents__c",changeValue6);
    },
    CarHandleChange7: function (cmp, event) {
        var changeValue7 = event.getParam("value");
        cmp.set("v.radioValue8",changeValue7);
        cmp.set("v.driverList.Telematics__c",changeValue7);
    },
    CarHandleChange8: function (cmp, event) {
        var changeValue8 = event.getParam("value");
        cmp.set("v.radioValue9",changeValue8);
        cmp.set("v.driverList.Perfume__c",changeValue8);
    },
    CarHandleChange9: function (cmp, event) {
        var changeValue9 = event.getParam("value");
        cmp.set("v.radioValue10",changeValue9);
        cmp.set("v.driverList.Branding__c",changeValue9);
    },
    CarHandleChange10: function (cmp, event) {
        var changeValue10 = event.getParam("value");
        cmp.set("v.radioValue11",changeValue10);
        cmp.set("v.driverList.Fire_extinguisher__c",changeValue10);
    },
    CarHandleChange11: function (cmp, event) {
        var changeValue11 = event.getParam("value");
        cmp.set("v.radioValue12",changeValue11);
        cmp.set("v.driverList.Mobile_Charger__c",changeValue11);
    },
    CarHandleChange12: function (cmp, event) {
        var changeValue12 = event.getParam("value");
        cmp.set("v.radioValue13",changeValue12);
        cmp.set("v.driverList.Camera__c",changeValue12);
    },
    CarHandleChange13: function (cmp, event) {
        var changeValue13 = event.getParam("value");
        cmp.set("v.radioValue14",changeValue13);
        cmp.set("v.driverList.Cleanliness__c",changeValue13);
    },
    CarHandleChange14: function (cmp, event) {
        var changeValue14 = event.getParam("value");
        cmp.set("v.radioValue15",changeValue14);
        cmp.set("v.driverList.Damages_Dent__c",changeValue14);
    },
    CarHandleChange15: function (cmp, event) {
        var changeValue15 = event.getParam("value");
        cmp.set("v.radioValue16",changeValue15);
        cmp.set("v.driverList.Door_Lock_Windows__c",changeValue15);
    },
    CarHandleChange16: function (cmp, event) {
        var changeValue16 = event.getParam("value");
        cmp.set("v.radioValue17",changeValue16);
        cmp.set("v.driverList.Mirrors__c",changeValue16);
    },
    CarHandleChange17: function (cmp, event) {
        var changeValue17 = event.getParam("value");
        cmp.set("v.radioValue18",changeValue17);
        cmp.set("v.driverList.Head_Lights__c",changeValue17);
    },
    CarHandleChange18: function (cmp, event) {
        var changeValue18 = event.getParam("value");
        cmp.set("v.radioValue19",changeValue18);
        cmp.set("v.driverList.Charging_Socket__c",changeValue18);
    },
    CarHandleChange19: function (cmp, event) {
        var changeValue19 = event.getParam("value");
        cmp.set("v.radioValue20",changeValue19);
        cmp.set("v.driverList.Charging_Cable__c",changeValue19);
    },
    CarHandleChange20: function (cmp, event) {
        var changeValue20 = event.getParam("value");
        cmp.set("v.radioValue21",changeValue20);
        cmp.set("v.driverList.Wipers_Washers_Wiper_Blades__c",changeValue20);
    },
    CarHandleChange21: function (cmp, event) {
        var changeValue21 = event.getParam("value");
        cmp.set("v.radioValue22",changeValue21);
        cmp.set("v.driverList.Hazard_Lights_Parking_lights__c",changeValue21);
    },
    CarHandleChange22: function (cmp, event) {
        var changeValue22 = event.getParam("value");
        cmp.set("v.radioValue23",changeValue22);
        cmp.set("v.driverList.Tyres__c",changeValue22);
    },
    CarHandleChange23: function (cmp, event) {
        var changeValue23 = event.getParam("value");
        cmp.set("v.radioValue24",changeValue23);
        cmp.set("v.driverList.Internal_Lights__c",changeValue23);
    },
    CarHandleChange24: function (cmp, event) {
        var changeValue24 = event.getParam("value");
        cmp.set("v.radioValue25",changeValue24);
        cmp.set("v.driverList.Brake_Lights__c",changeValue24);
    },
    CarHandleChange25: function (cmp, event) {
        var changeValue25 = event.getParam("value");
        cmp.set("v.radioValue26",changeValue25);
        cmp.set("v.driverList.Triangle__c",changeValue25);
    },
    CarHandleChange26: function (cmp, event) {
        var changeValue26 = event.getParam("value");
        cmp.set("v.radioValue27",changeValue26);
        cmp.set("v.driverList.Spare_Tyre__c",changeValue26);
    },
    CarHandleChange27: function (cmp, event) {
        var changeValue27 = event.getParam("value");
        cmp.set("v.radioValue28",changeValue27);
        cmp.set("v.driverList.Steering__c",changeValue27);
    },
    CarHandleChange28: function (cmp, event) {
        var changeValue28 = event.getParam("value");
        cmp.set("v.radioValue29",changeValue28);
        cmp.set("v.driverList.BrakesHandBrakes__c",changeValue28);
    },
    CarHandleChange29: function (cmp, event) {
        var changeValue29 = event.getParam("value");
        cmp.set("v.radioValue30",changeValue29);
        cmp.set("v.driverList.Horn__c",changeValue29);
    },
    CarHandleChange30: function (cmp, event) {
        var changeValue30 = event.getParam("value");
        cmp.set("v.radioValue31",changeValue30);
        cmp.set("v.driverList.Head_Restraints__c",changeValue30);
    },
    CarHandleChange31: function (cmp, event) {
        var changeValue31 = event.getParam("value");
        cmp.set("v.radioValue32",changeValue31);
        cmp.set("v.driverList.Seats__c",changeValue31);
    },
    CarHandleChange32: function (cmp, event) {
        var changeValue32 = event.getParam("value");
        cmp.set("v.radioValue33",changeValue32);
        cmp.set("v.driverList.Safety_Belts__c",changeValue32);
    },
    CarHandleChange33: function (cmp, event) {
        var changeValue33 = event.getParam("value");
        cmp.set("v.radioValue34",changeValue33);
        cmp.set("v.driverList.Jack__c",changeValue33);
    },
    CarHandleChange34: function (cmp, event) {
        var changeValue34 = event.getParam("value");
        cmp.set("v.radioValue35",changeValue34);
        cmp.set("v.driverList.Jack_Rod__c",changeValue34);
    },
    CarHandleChange35: function (cmp, event) {
        var changeValue35 = event.getParam("value");
        cmp.set("v.radioValue36",changeValue35);
        cmp.set("v.driverList.AIS_140_Certificate__c",changeValue35);
    },
    CarHandleChange36: function (cmp, event) {
        var changeValue36 = event.getParam("value");
        cmp.set("v.radioValue37",changeValue36);
        cmp.set("v.driverList.AIS_140_GPS__c",changeValue36);
    },
    handleComponentEvent : function(component, event, helper) {
        debugger;
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
        var eventrec = component.get("v.driverList");
        eventrec.OwnerId =selecteduserGetFromEvent.Id;
        component.set("v.driverList", eventrec);
       // alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
        
        var userrec = {'Id':selecteduserGetFromEvent.Id,'Name':selecteduserGetFromEvent.Name};
        var userlist = [];
        userlist.push(userrec);
        component.set("v.userobj", userrec);
        component.set("v.selectedLookUpRecords", userlist);
        
    },
    
    OnSubmit:function(component, event, helper){
        
        //alert('Save'); 
        debugger;      
        var newCheck = component.get("v.driverList");
        newCheck.Vehicle__c = component.get("v.recordId");
        newCheck.Sign__c =component.get("v.userobj").Id;
         console.log('JSON.stringify(newCheck)'+JSON.stringify(newCheck));
        var fieldlist = component.get("v.fieldList");
        var j=0;
        for(var i =0;i<fieldlist.length;i++){
            // var x = fieldlist[i];
            //var y = newCheck[x];
            if(newCheck[fieldlist[i]].length>0)
                j = j+1;
        }
        var isupdatevehicle = false;
        if(j == fieldlist.length)
            isupdatevehicle = true;  
        console.log(newCheck);
        //newCheck.Id = component.get('v.recordId');
        
        var elements = component.find('loadingSpinner');
        
        $A.util.addClass(elements, 'slds-show');
        $A.util.removeClass(elements, 'slds-hide');
        
        var action = component.get("c.createAccessriesRecord");
        console.log('JSON.stringify(newCheck)'+JSON.stringify(newCheck));
        action.setParams({ 
            "jsonCheck": JSON.stringify(newCheck),
            "jsonDate1":component.get("v.WeeklyDate"),"updateVehicle":true
        });
        action.setCallback(this, function(a) {
            // alert('test');
            var state = a.getState();
            $A.util.removeClass(elements, 'slds-show');
            $A.util.addClass(elements, 'slds-hide');
            if(state == "SUCCESS"){
                
                console.log('state'+a.getReturnValue());

                var toastEvent = $A.get("e.force:showToast");
                
                toastEvent.setParams({
                    title : 'Success Message',
                    message: ' "The checklist has been Saved successfully."',
                    messageTemplate: 'Record {0} created! See it {1}!',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                //window.location.reload();
                var dismissQuickAction = $A.get("e.force:closeQuickAction");
                dismissQuickAction.fire();
                              var temp=component.get('v.Vehiclerec');
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": a.getReturnValue(),
                    "slideDevName": "related"
                });
                navEvt.fire();

                
             /*   
                
                component.set("v.radioValue1",a.getReturnValue().First_Aid_kit__c);
                component.set("v.radioValue2",a.getReturnValue().Torch__c);
                component.set("v.radioValue3",a.getReturnValue().Mats__c);
                component.set("v.radioValue4",a.getReturnValue().Umbrella__c);
                component.set("v.radioValue5",a.getReturnValue().Sleep_Alert__c);
                component.set("v.radioValue6",a.getReturnValue().Spare_Wheel__c);
                component.set("v.radioValue7",a.getReturnValue().Physical_Condition_scratches_dents__c);
                component.set("v.radioValue8",a.getReturnValue().Telematics__c);
                component.set("v.radioValue9",a.getReturnValue().Perfume__c);
                component.set("v.radioValue10",a.getReturnValue().Branding__c);
                component.set("v.radioValue11",a.getReturnValue().Fire_extinguisher__c);
                component.set("v.radioValue12",a.getReturnValue().Mobile_Charger__c);
                component.set("v.radioValue13",a.getReturnValue().Camera__c);
                component.set("v.radioValue14",a.getReturnValue().Cleanliness__c);
                component.set("v.radioValue15",a.getReturnValue().Damages_Dent__c);
                component.set("v.radioValue16",a.getReturnValue().Door_Lock_Windows__c);
                component.set("v.radioValue17",a.getReturnValue().Mirrors__c);
                component.set("v.radioValue18",a.getReturnValue().Head_Lights__c);
                component.set("v.radioValue19",a.getReturnValue().Charging_Socket__c);
                component.set("v.radioValue20",a.getReturnValue().Charging_Cable__c);
                component.set("v.radioValue21",a.getReturnValue().Wipers_Washers_Wiper_Blades__c);
                component.set("v.radioValue22",a.getReturnValue().Hazard_Lights_Parking_lights__c);
                component.set("v.radioValue23",a.getReturnValue().Tyres__c);
                component.set("v.radioValue24",a.getReturnValue().Internal_Lights__c);
                component.set("v.radioValue25",a.getReturnValue().Brake_Lights__c);
                component.set("v.radioValue26",a.getReturnValue().Triangle__c);
                component.set("v.radioValue27",a.getReturnValue().Spare_Tyre__c);
                component.set("v.radioValue28",a.getReturnValue().Steering__c);
                component.set("v.radioValue29",a.getReturnValue().BrakesHandBrakes__c);
                component.set("v.radioValue30",a.getReturnValue().Horn__c);
                component.set("v.radioValue31",a.getReturnValue().Head_Restraints__c);
                component.set("v.radioValue32",a.getReturnValue().Seats__c);
                component.set("v.radioValue33",a.getReturnValue().Safety_Belts__c);
                component.set("v.radioValue34",a.getReturnValue().Jack__c);
                component.set("v.radioValue35",a.getReturnValue().Jack_Rod__c);
                component.set("v.radioValue36",a.getReturnValue().AIS_140_Certificate__c);
                component.set("v.radioValue37",a.getReturnValue().AIS_140_GPS__c);
                */
                console.log('Record is Created Successfully');
            } else if(state == "ERROR"){
                console.log(this);
                console.log('Error in calling server side action');
            }                
            
            
        });
        $A.enqueueAction(action);
    } ,
    
    handlemultipleComponentEvent : function(component, event, helper) {
        debugger;
        var selecteduserGetFromEvent = event.getParam("vehicleByEvent");
        var IsServiceProvider = event.getParam("IsServiceProvider");
        var IsServiceProvider1 = event.getParam("IsServiceProvider1");
        var IsServiceProvider2 = event.getParam("IsServiceProvider2");
        var eventrec = component.get("v.driverList");
        if(IsServiceProvider == true){
            eventrec.Driver__c =selecteduserGetFromEvent.Id;
            component.set("v.driverList", eventrec);
            //alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
        }else if(IsServiceProvider1 == true){
            eventrec.Vehicle__c =selecteduserGetFromEvent.Id;
            component.set("v.driverList", eventrec);
            
        }else if (IsServiceProvider2 == true){
            eventrec.Campus__c =selecteduserGetFromEvent.Id;
            component.set("v.driverList", eventrec);
        }
            else {
                eventrec.Sign__c =selecteduserGetFromEvent.Id;
                component.set("v.driverList", eventrec);
                
                alert('sign:'+selecteduserGetFromEvent.Id);
            }
    },
    doCancel: function(component, event) {
        var dismissQuickAction = $A.get("e.force:closeQuickAction");
        dismissQuickAction.fire();
    }
    
})