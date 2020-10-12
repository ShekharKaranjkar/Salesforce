({
    doInit : function(component, event, helper) {
        component.set("v.vehiclid",component.get('v.recordId'));
        console.log('recid'+component.get('v.recordId'));
         navigator.geolocation.getCurrentPosition(function(position) {
            var latit = position.coords.latitude;
            var longit = position.coords.longitude;
            component.set("v.Current_Location__Latitude__s",latit);
            component.set("v.Current_Location__Longitude__s ",longit);
            //alert(latit+':'+longit);
        });
        var action = component.get("c.getcheckvalues");
        var  newEvent = component.get('v.recordId');
        action.setParams({ 
            "id": newEvent
        }); 
        action.setCallback(this, function(a) {
            //alert('set call back');
            debugger;
            //$A.get('e.force:refreshView').fire();
            var state = a.getState();
            if (state === "SUCCESS") {
                
                var returnval = a.getReturnValue();
                if(returnval.chk.length == 1){
                    
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
                    
                    //  alert('dd '+ component.get('v.recordId'));
                    console.log('vehiclecomp'+JSON.stringify(returnval.vehcl[0]));
                    component.set("v.Vehiclerec",returnval.vehcl[0]);                    
                    // var carrec = {'Id':returnval.Site__r.Location__r.OwnerId,'Name':returnval.Site__r.Location__r.Owner.Name};
                    // var carrec = {'Id':returnval.vehcl.OwnerId,'Name':returnval.vehcl.Owner.Name};
                    // component.set("v.userobj", carrec);
                    var  vehicle = component.get('v.Vehiclerec');
                    var vehiclarray = [];
                    console.log('vehicle'+vehicle);
                    vehiclarray.push(vehicle);
                    component.set("v.selectedLookUpRecords", vehiclarray);
                    //component.set("v.selectedLookUpRecords",id);
                    var eventrec = component.get("v.driverList");
                    eventrec.Vehicle__c =returnval.vehcl.Id;
                    eventrec.OwnerId =returnval.vehcl.Site__r.Location__r.OwnerId;
                    component.set("v.driverList", eventrec);
                    console.log('eventrec'+JSON.stringify(eventrec));
                    toastEvent.fire();
                    //window.location.reload();
                    var dismissQuickAction = $A.get("e.force:closeQuickAction");
                    dismissQuickAction.fire();
                    
                }
                
            }
            
        });
        
        $A.enqueueAction(action);
        
    },
    CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        cmp.set("v.radioValue1",changeValue);
        cmp.set("v.driverList.Mud_Flaps__c",changeValue);
    },
    CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
        cmp.set("v.radioValue2",changeValue1);
        cmp.set("v.driverList.Seat_Cover__c",changeValue1);
    },
    CarHandleChange2: function (cmp, event) {
        var changeValue2 = event.getParam("value");
        cmp.set("v.radioValue3",changeValue2);
        cmp.set("v.driverList.AC_Check__c",changeValue2);
    },
    CarHandleChange3: function (cmp, event) {
        var changeValue3 = event.getParam("value");
        cmp.set("v.radioValue4",changeValue3);
        cmp.set("v.driverList.Headlight_and_Indicator_checks__c",changeValue3);
    },
    CarHandleChange4: function (cmp, event) {
        var changeValue4 = event.getParam("value");
        cmp.set("v.radioValue5",changeValue4);
        cmp.set("v.driverList.Break_check__c",changeValue4);
    },
    CarHandleChange5: function (cmp, event) {
        var changeValue5 = event.getParam("value");
        cmp.set("v.radioValue6",changeValue5);
        cmp.set("v.driverList.Slow_charging_cable__c",changeValue5);
    },
    CarHandleChange6: function (cmp, event) {
        var changeValue6 = event.getParam("value");
        cmp.set("v.radioValue7",changeValue6);
        cmp.set("v.driverList.Physical_Condition_scratches_dents__c",changeValue6);
    },
    CarHandleChange7: function (cmp, event) {
        var changeValue7 = event.getParam("value");
        cmp.set("v.radioValue8",changeValue7);
        cmp.set("v.driverList.Stickering__c",changeValue7);
    },
    CarHandleChange8: function (cmp, event) {
        var changeValue8 = event.getParam("value");
        cmp.set("v.radioValue9",changeValue8);
        cmp.set("v.driverList.Spoiler__c",changeValue8);
    },
    CarHandleChange9: function (cmp, event) {
        var changeValue9 = event.getParam("value");
        cmp.set("v.radioValue10",changeValue9);
        cmp.set("v.driverList.Fast_Charge_and_Slow_Charge_working__c",changeValue9);
    },
    CarHandleChange10: function (cmp, event) {
        var changeValue10 = event.getParam("value");
        cmp.set("v.radioValue11",changeValue10);
        cmp.set("v.driverList.Mirror_check__c",changeValue10);
    },
    CarHandleChange11: function (cmp, event) {
        var changeValue11 = event.getParam("value");
        cmp.set("v.radioValue12",changeValue11);
        cmp.set("v.driverList.Power_window_functioning__c",changeValue11);
    },
    CarHandleChange12: function (cmp, event) {
        var changeValue12 = event.getParam("value");
        cmp.set("v.radioValue13",changeValue12);
        cmp.set("v.driverList.Jack_Jack_rod_wheel_spanner__c",changeValue12);
    },
    
    handleComponentEvent : function(component, event, helper) {
        debugger;
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
        var eventrec = component.get("v.driverList");
        eventrec.OwnerId =selecteduserGetFromEvent.Id;
        component.set("v.driverList", eventrec);
        //alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
        
        var userrec = {'Id':returnval.Site__r.Location__r.OwnerId,'Name':returnval.Site__r.Location__r.Owner.Name};
        var userlist = [];
        userlist.push(userrec);
        component.set("v.userobj", userrec);
        component.set("v.LookUpRecords3", userlist);
        
    },
    
    submitmethod:function(component, event, helper){
        debugger;
        var newCheck = component.get("v.driverList");
        newCheck.Vehicle__c = component.get("v.recordId");
        console.log('newCheck'+JSON.stringify(newCheck));
        var fieldlist = component.get("v.fieldList");
        var j=0;
        for(var i =0;i<fieldlist.length;i++){
            // var x = fieldlist[i];
            //var y = newCheck[x];
            if(newCheck[fieldlist[i]].length>0)
                j = j+1;
        }
        var isupdatevehicle1 = false;
        if(j == fieldlist.length)
            isupdatevehicle1 = true;          
        var elements = component.find('loadingSpinner');
        $A.util.addClass(elements, 'slds-show');
        $A.util.removeClass(elements, 'slds-hide');
        var action = component.get("c.createPDIRecord");
        
        action.setParams({ 
            "jsonCheck": JSON.stringify(newCheck),"updateVehicle1":true,
            "lattitude":component.get("v.Current_Location__Latitude__s"),
            "longitude":component.get("v.Current_Location__Longitude__s ")
            
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if(state == "SUCCESS"){
                var retvalues= a.getReturnValue();
                console.log('state'+retvalues);
                //$A.get('e.force:refreshView').fire();
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
                component.set("v.radioValue1",a.getReturnValue().Mud_Flaps__c);
                component.set("v.radioValue2",a.getReturnValue().Seat_Cover__c);
                component.set("v.radioValue3",a.getReturnValue().AC_Check__c);
                component.set("v.radioValue4",a.getReturnValue().Headlight_and_Indicator_checks__c);
                component.set("v.radioValue5",a.getReturnValue().Break_check__c);
                component.set("v.radioValue6",a.getReturnValue().Slow_charging_cable__c);
                component.set("v.radioValue7",a.getReturnValue().Physical_Condition_scratches_dents__c);
                component.set("v.radioValue8",a.getReturnValue().Stickering__c);
                component.set("v.radioValue9",a.getReturnValue().Spoiler__c);
                component.set("v.radioValue10",a.getReturnValue().Fast_Charge_and_Slow_Charge_working__c);
                component.set("v.radioValue11",a.getReturnValue().Mirror_check__c);
                component.set("v.radioValue12",a.getReturnValue().Power_window_functioning__c);
                component.set("v.radioValue13",a.getReturnValue().Jack_Jack_rod_wheel_spanner__c);
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
        var eventrec = component.get("v.driverList");
        if(IsServiceProvider == true){
            eventrec.Driver__c =selecteduserGetFromEvent.Id;
            component.set("v.driverList", eventrec);
            //alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
        }else{
            eventrec.Vehicle__c =selecteduserGetFromEvent.Id;
            component.set("v.driverList", eventrec);
        }
    },
    
    doCancel: function(component, event) {
        var dismissQuickAction = $A.get("e.force:closeQuickAction");
        dismissQuickAction.fire();
    }
    
})