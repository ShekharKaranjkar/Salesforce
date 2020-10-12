({
    doInit : function(component, event, helper) {
        component.set("v.vehiclid",component.get('v.recordId'));
        
        var action = component.get("c.getcheckvalues");
        var  newEvent;
        if(component.get('v.recordId') != undefined)
            newEvent = component.get('v.recordId');
        else if(component.get('v.parentrecid') != undefined)
            newEvent=component.get("v.parentrecid");
        action.setParams({ 
            "id": newEvent
        }); 
        action.setCallback(this, function(a) {
            //alert('set call back');
            debugger;
            //$A.get('e.force:refreshView').fire();
            var state = a.getState();
            if (state === "SUCCESS") {
                debugger;
                var returnval = a.getReturnValue();
                console.log(JSON.stringify(returnval));
                var carrec;
                 var eventrec = component.get("v.checkObj");
                component.set("v.Vehiclerec",returnval.vehcl[0]);
                   console.log('test'+JSON.stringify(component.get("v.Vehiclerec")));
                if(returnval.vehcl != null && returnval.vehcl != undefined && returnval.vehcl.length>0){
                    carrec = {'Id':returnval.vehcl[0].OwnerId,'Name':returnval.vehcl[0].Owner.Name};
                    component.set("v.Vehiclerec",returnval.vehcl[0]);
                    eventrec.Vehicle__c =returnval.vehcl[0].Id;
                eventrec.Sign__c =returnval.vehcl[0].OwnerId;
                //eventrec.OwnerId =$A.get("$SObjectType.CurrentUser.Id");
                }
                    
                else{
                     carrec = {'Id':$A.get("$SObjectType.CurrentUser.Id"),'Name':$A.get("$SObjectType.CurrentUser.Name")};
                    console.log(JSON.stringify(carrec));
                eventrec.Sign__c =$A.get("$SObjectType.CurrentUser.Id");
               // eventrec.OwnerId =$A.get("$SObjectType.CurrentUser.Id");
                }
                // var userId = $A.get("$SObjectType.CurrentUser.Id");
                //console.log(userId);
               // console.log('carrec'+carre);
                component.set("v.Siteobj",carrec);
                var  vehicle = component.get('v.Vehiclerec');
                var vehiclarray = [];
                vehiclarray.push(vehicle);
                component.set("v.selectedsignedLookUpRecords", vehiclarray);
                //alert(component.get("v.selectedsignedLookUpRecords"));
                component.set("v.checkObj", eventrec);
            }
        });
        
        $A.enqueueAction(action);
        
    },
    
    
    CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        cmp.set("v.HoodValue",changeValue);
        cmp.set("v.checkObj.Hood__c",changeValue);
    },
    
    CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
        cmp.set("v.FrontValue",changeValue1);
        cmp.set("v.checkObj.Front__c",changeValue1);
    },
    CarHandleChange2: function (cmp, event) {
        var changeValue2 = event.getParam("value");
        cmp.set("v.radioValue1",changeValue2);
        cmp.set("v.checkObj.Front_Bumper__c",changeValue2);
    },
    CarHandleChange3: function (cmp, event) {
        var changeValue3 = event.getParam("value");
        cmp.set("v.radioValue2",changeValue3);
        cmp.set("v.checkObj.Fenders__c",changeValue3);
    },
    CarHandleChange4: function (cmp, event) {
        var changeValue4 = event.getParam("value");
        cmp.set("v.radioValue3",changeValue4);
        cmp.set("v.checkObj.Doors__c",changeValue4);
    },
    CarHandleChange5: function (cmp, event) {
        var changeValue5 = event.getParam("value");
        cmp.set("v.radioValue4",changeValue5);
        cmp.set("v.checkObj.Roof__c",changeValue5);
    },
    CarHandleChange6: function (cmp, event) {
        var changeValue6 = event.getParam("value");
        cmp.set("v.radioValue5",changeValue6);
        cmp.set("v.checkObj.Rear__c",changeValue6);
    },
    CarHandleChange7: function (cmp, event) {
        var changeValue7 = event.getParam("value");
        cmp.set("v.radioValue6",changeValue7);
        cmp.set("v.checkObj.Rear_Bumper__c",changeValue7);
    },
    CarHandleChange8: function (cmp, event) {
        var changeValue8 = event.getParam("value");
        cmp.set("v.radioValue7",changeValue8);
        cmp.set("v.checkObj.Trunk_Dickie__c",changeValue8);
    },
    CarHandleChange9: function (cmp, event) {
        var changeValue9 = event.getParam("value");
        cmp.set("v.radioValue8",changeValue9);
        cmp.set("v.checkObj.Trim__c",changeValue9);
    },
    CarHandleChange10: function (cmp, event) {
        var changeValue10 = event.getParam("value");
        cmp.set("v.radioValue9",changeValue10);
        cmp.set("v.checkObj.Charging_Socket_Port__c",changeValue10);
    },
    CarHandleChange11: function (cmp, event) {
        var changeValue11 = event.getParam("value");
        cmp.set("v.radioValue10",changeValue11);
        cmp.set("v.checkObj.Paint_Condition__c",changeValue11);
    },
    CarHandleChange12: function (cmp, event) {
        var changeValue12 = event.getParam("value");
        cmp.set("v.radioValue11",changeValue12);
        cmp.set("v.checkObj.Windshield__c",changeValue12);
    },
    CarHandleChange13: function (cmp, event) {
        var changeValue13 = event.getParam("value");
        cmp.set("v.radioValue12",changeValue13);
        cmp.set("v.checkObj.Windows__c",changeValue13);
    },
    CarHandleChange14: function (cmp, event) {
        var changeValue14 = event.getParam("value");
        cmp.set("v.radioValue13",changeValue14);
        cmp.set("v.checkObj.Mirrors__c",changeValue14);
    },
    CarHandleChange15: function (cmp, event) {
        var changeValue15 = event.getParam("value");
        cmp.set("v.radioValue14",changeValue15);
        cmp.set("v.checkObj.Rear_Window__c",changeValue15);
    },
    CarHandleChange16: function (cmp, event) {
        var changeValue16 = event.getParam("value");
        cmp.set("v.radioValue15",changeValue16);
        cmp.set("v.checkObj.Tyres__c",changeValue16);
    },
    CarHandleChange17: function (cmp, event) {
        var changeValue17 = event.getParam("value");
        cmp.set("v.radioValue16",changeValue17);
        cmp.set("v.checkObj.Wheels__c",changeValue17);
    },
    CarHandleChange18: function (cmp, event) {
        var changeValue18 = event.getParam("value");
        cmp.set("v.radioValue17",changeValue18);
        cmp.set("v.checkObj.Spare_Tyre__c",changeValue18);
    },
    CarHandleChange19: function (cmp, event) {
        var changeValue19 = event.getParam("value");
        cmp.set("v.radioValue18",changeValue19);
        cmp.set("v.checkObj.Seats__c",changeValue19);
    },
    CarHandleChange20: function (cmp, event) {
        var changeValue20 = event.getParam("value");
        cmp.set("v.radioValue19",changeValue20);
        cmp.set("v.checkObj.Headliner__c",changeValue20);
    },
    CarHandleChange21: function (cmp, event) {
        var changeValue21 = event.getParam("value");
        cmp.set("v.radioValue20",changeValue21);
        cmp.set("v.checkObj.Carpet__c",changeValue21);
    },
    CarHandleChange22: function (cmp, event) {
        var changeValue22 = event.getParam("value");
        cmp.set("v.radioValue21",changeValue22);
        cmp.set("v.checkObj.Door_Panels__c",changeValue22);
    },
    CarHandleChange23: function (cmp, event) {
        var changeValue23 = event.getParam("value");
        cmp.set("v.radioValue22",changeValue23);
        cmp.set("v.checkObj.Glove_Box__c",changeValue23);
    },
    CarHandleChange24: function (cmp, event) {
        var changeValue24 = event.getParam("value");
        cmp.set("v.radioValue23",changeValue24);
        cmp.set("v.checkObj.Dashboard__c",changeValue24);
    },
    CarHandleChange25: function (cmp, event) {
        var changeValue25 = event.getParam("value");
        cmp.set("v.radioValue24",changeValue25);
        cmp.set("v.checkObj.Power_window__c",changeValue25);
    },
    CarHandleChange26: function (cmp, event) {
        var changeValue26 = event.getParam("value");
        cmp.set("v.radioValue25",changeValue26);
        cmp.set("v.checkObj.Seat_Adjustments__c",changeValue26);
    },
    CarHandleChange27: function (cmp, event) {
        var changeValue27 = event.getParam("value");
        cmp.set("v.radioValue26",changeValue27);
        cmp.set("v.checkObj.Air_conditioning__c",changeValue27);
    },
    CarHandleChange28: function (cmp, event) {
        var changeValue28 = event.getParam("value");
        cmp.set("v.radioValue27",changeValue28);
        cmp.set("v.checkObj.Locks_Child_Lock__c",changeValue28);
    },
    CarHandleChange29: function (cmp, event) {
        var changeValue29 = event.getParam("value");
        cmp.set("v.radioValue28",changeValue29);
        cmp.set("v.checkObj.Steering__c",changeValue29);
    },
    CarHandleChange30: function (cmp, event) {
        var changeValue30 = event.getParam("value");
        cmp.set("v.radioValue29",changeValue30);
        cmp.set("v.checkObj.Audio_Systems__c",changeValue30);
    },
    CarHandleChange31: function (cmp, event) {
        var changeValue31 = event.getParam("value");
        cmp.set("v.radioValue30",changeValue31);
        cmp.set("v.checkObj.Navigation_Infotainment_System__c",changeValue31);
    },
    CarHandleChange32: function (cmp, event) {
        var changeValue32 = event.getParam("value");
        cmp.set("v.radioValue31",changeValue32);
        cmp.set("v.checkObj.Safety_System__c",changeValue32);
    },
    CarHandleChange33: function (cmp, event) {
        var changeValue33 = event.getParam("value");
        cmp.set("v.radioValue32",changeValue33);
        cmp.set("v.checkObj.Headlights__c",changeValue33);
    },
    CarHandleChange34: function (cmp, event) {
        var changeValue34 = event.getParam("value");
        cmp.set("v.radioValue33",changeValue34);
        cmp.set("v.checkObj.Taillights__c",changeValue34);
    },
    CarHandleChange35: function (cmp, event) {
        var changeValue35 = event.getParam("value");
        cmp.set("v.radioValue34",changeValue35);
        cmp.set("v.checkObj.Signal_Lights__c",changeValue35);
    },
    CarHandleChange36: function (cmp, event) {
        var changeValue36 = event.getParam("value");
        cmp.set("v.radioValue35",changeValue36);
        cmp.set("v.checkObj.Brake_Lights__c",changeValue36);
    },
    CarHandleChange37: function (cmp, event) {
        var changeValue37 = event.getParam("value");
        cmp.set("v.radioValue36",changeValue37);
        cmp.set("v.checkObj.Parking_Lights__c",changeValue37);
    },
    CarHandleChange38: function (cmp, event) {
        var changeValue38 = event.getParam("value");
        cmp.set("v.radioValue37",changeValue38);
        cmp.set("v.checkObj.Motor_Performance__c",changeValue38);
    },
    CarHandleChange39: function (cmp, event) {
        var changeValue39 = event.getParam("value");
        cmp.set("v.radioValue38",changeValue39);
        cmp.set("v.checkObj.Battery_Performance__c",changeValue39);
    },
    CarHandleChange40: function (cmp, event) {
        var changeValue40 = event.getParam("value");
        cmp.set("v.radioValue39",changeValue40);
        cmp.set("v.checkObj.Acceleration__c",changeValue40);
    },
    CarHandleChange41: function (cmp, event) {
        var changeValue41 = event.getParam("value");
        cmp.set("v.radioValue40",changeValue41);
        cmp.set("v.checkObj.Steering1__c",changeValue41);
    },
    CarHandleChange42: function (cmp, event) {
        var changeValue42 = event.getParam("value");
        cmp.set("v.radioValue41",changeValue42);
        cmp.set("v.checkObj.Braking__c",changeValue42);
    },
    CarHandleChange43: function (cmp, event) {
        var changeValue43 = event.getParam("value");
        cmp.set("v.radioValue42",changeValue43);
        cmp.set("v.checkObj.Suspension_Performance__c",changeValue43);
    },
    
    handleComponentEvent : function(component, event, helper) {
        debugger;
        //   var selecteduserGetFromEvent = event.getParam("recordByEvent");
        var selecteduserGetFromEvent = $A.get("$SObjectType.CurrentUser.Id");
        alert(selecteduserGetFromEvent);
        var eventrec = component.get("v.checkObj");
        eventrec.Sign__c =selecteduserGetFromEvent.Id;
        //   alert('event owner :'+selecteduserGetFromEvent.Id);
        component.set("v.checkObj", eventrec);
        var userrec = {'Id':selecteduserGetFromEvent.Id,'Name':selecteduserGetFromEvent.Owner.Name};
        var userlist = [];
        userlist.push(userrec);
        component.set("v.Siteobj", userrec);
        component.set("v.selectedsignedLookUpRecords", userlist);
        
        
    },
    
    OnSubmit : function(component, event,helper) {
        //  alert('Save');
        debugger; 
        var newCheck = component.get("v.checkObj");
        // alert('owner'+newCheck.OwnerId);
        console.log(newCheck);
        var elements = component.find('loadingSpinner');
        
        $A.util.addClass(elements, 'slds-show');
        $A.util.removeClass(elements, 'slds-hide');
        
        var action = component.get("c.createRecord");
        action.setParams({ 
            "jsonCheck": JSON.stringify(newCheck),
            "jsonDate1":component.get("v.WeeklyDate")
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if(state == "SUCCESS"){
                console.log('state');
                $A.util.addClass(elements, 'slds-hide');
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
                    "recordId": temp.Id,
                    "slideDevName": "related"
                });
                navEvt.fire();
                
                console.log('Record is Created Successfully');
                
            } else if(state == "ERROR"){
                console.log(this);
                let errors = a.getError();
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    console.log(errors[0].message);
                }
                console.log('Error in calling server side action');
            }                
            
            
        });
        $A.enqueueAction(action);
    },
    handlemultipleComponentEvent : function(component, event, helper) {
        debugger;
        alert('selecteduserGetFromEvent'+selecteduserGetFromEvent)
        var selecteduserGetFromEvent = event.getParam("vehicleByEvent");
        var IsServiceProvider = event.getParam("IsServiceProvider");
        var IsServiceProvider1 = event.getParam("IsServiceProvider1");
        var IsServiceProvider2 = event.getParam("IsServiceProvider2");
        var isSignedUser = event.getParam("isSignedUser");
        var eventrec = component.get("v.checkObj");
        
        if(IsServiceProvider == true){
            eventrec.Driver__c =selecteduserGetFromEvent.Id;
            component.set("v.checkObj", eventrec);
            // alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
        }else if (IsServiceProvider1 == true) {
            eventrec.Vehicle__c =selecteduserGetFromEvent.Id;
            component.set("v.checkObj", eventrec); 
        }else if (IsServiceProvider2 == true) {
            eventrec.Campus__c =selecteduserGetFromEvent.Id;
            component.set("v.checkObj", eventrec); 
        }
            else if(isSignedUser == true) {
                eventrec.Sign__c =selecteduserGetFromEvent.Id;
                component.set("v.Siteobj", eventrec); 
                
            }
    },
    
    doCancel: function(component, event) {
        var dismissQuickAction = $A.get("e.force:closeQuickAction");
        dismissQuickAction.fire();
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/lightning/o/Checklist__c/list?filterName=Recent' 
        });
        urlEvent.fire();
    }
})