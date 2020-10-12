({
    doInit : function(component, event, helper) {
        //component.set("v.campusid",component.get('v.recordId'));
         component.set("v.vehiclid",component.get('v.recordId'));
      //  component.set("v.Vehiclerec",component.get('v.recordId'));
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
            alert('set call back'+carrec);
    debugger;
            //$A.get('e.force:refreshView').fire();
            var state = a.getState();
            if (state === "SUCCESS") {
              
                var returnval = a.getReturnValue();
                //alert('dd '+ returnval.eventObj);
                 console.log(JSON.stringify(returnval));
                component.set("v.Vehiclerec",returnval.vehcl[0]);
                var carrec = {'Id':returnval.vehcl[0].OwnerId,'Name':returnval.vehcl[0].Owner.Name};
                
                // component.set("v.userobj", carrec);
                var  vehicle = component.get('v.Vehiclerec');
                // alert('values :'+vehicle);
                var vehiclarray = [];
                vehiclarray.push(vehicle);
                component.set("v.selectedLookUpRecords", vehiclarray);
                var eventrec = component.get("v.checkObj");
               eventrec.Vehicle__c =returnval.vehcl[0].Id;
                eventrec.Sign__c =returnval.vehcl[0].OwnerId;
                comsole.log('test'+eventrec.Sign__c );
                eventrec.OwnerId =$A.get("$SObjectType.CurrentUser.Id");
                component.set("v.checkObj", eventrec);
                //  alert(component.get("v.s"));
            }
            
            
        });
        
        $A.enqueueAction(action);
        
    },
    CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
        cmp.set("v.radioValue1",changeValue);
        cmp.set("v.checkObj.Safe_Work_Procedure__c",changeValue);
    },
    
    CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
        cmp.set("v.radioValue2",changeValue1);
        cmp.set("v.checkObj.Health_Surveillance_Requirements__c",changeValue1);
    },
    CarHandleChange2: function (cmp, event) {
        var changeValue2 = event.getParam("value");
        cmp.set("v.radioValue3",changeValue2);
        cmp.set("v.checkObj.Communication_to_employees__c",changeValue2);
    },
    CarHandleChange3: function (cmp, event) {
        var changeValue3 = event.getParam("value");
        cmp.set("v.radioValue4",changeValue3);
        cmp.set("v.checkObj.Any_Slip_Trip_Hazard_obvious__c",changeValue3);
    },
    CarHandleChange4: function (cmp, event) {
        var changeValue4 = event.getParam("value");
        cmp.set("v.radioValue5",changeValue4);
        cmp.set("v.checkObj.Premises_in_good_condition_no_defects__c",changeValue4);
    },
    CarHandleChange5: function (cmp, event) {
        var changeValue5 = event.getParam("value");
        cmp.set("v.radioValue6",changeValue5);
        cmp.set("v.checkObj.Lighting_adequate_all_working__c",changeValue5);
    },
    CarHandleChange6: function (cmp, event) {
        var changeValue6 = event.getParam("value");
        cmp.set("v.radioValue7",changeValue6);
        cmp.set("v.checkObj.Window_and_Doors__c",changeValue6);
    },
    CarHandleChange7: function (cmp, event) {
        var changeValue7 = event.getParam("value");
        cmp.set("v.radioValue8",changeValue7);
        cmp.set("v.checkObj.Floors_and_Walkways_Clean__c",changeValue7);
    },
    CarHandleChange8: function (cmp, event) {
        var changeValue8 = event.getParam("value");
        cmp.set("v.radioValue9",changeValue8);
        cmp.set("v.checkObj.Temperature_and_ventilation_suitable__c",changeValue8);
    },
    CarHandleChange9: function (cmp, event) {
        var changeValue9 = event.getParam("value");
        cmp.set("v.radioValue10",changeValue9);
        cmp.set("v.checkObj.Fire_Risk_assessment_up_to_date__c",changeValue9);
    },
    CarHandleChange10: function (cmp, event) {
        var changeValue10 = event.getParam("value");
        cmp.set("v.radioValue11",changeValue10);
        cmp.set("v.checkObj.Fire_extinguishers_in_correct_locations__c",changeValue10);
    },
    CarHandleChange11: function (cmp, event) {
        var changeValue11 = event.getParam("value");
        cmp.set("v.radioValue12",changeValue11);
        cmp.set("v.checkObj.Fire_Safety_Notices_with_Clear_instructi__c",changeValue11);
    },
    CarHandleChange12: function (cmp, event) {
        var changeValue12 = event.getParam("value");
        cmp.set("v.radioValue13",changeValue12);
        cmp.set("v.checkObj.Staff_aware_of_evacuation_procedure__c",changeValue12);
    },
    CarHandleChange13: function (cmp, event) {
        var changeValue13 = event.getParam("value");
        cmp.set("v.radioValue14",changeValue13);
        cmp.set("v.checkObj.Toilets_Changing_Washing__c",changeValue13);
    },
    CarHandleChange14: function (cmp, event) {
        var changeValue14 = event.getParam("value");
        cmp.set("v.radioValue15",changeValue14);
        cmp.set("v.checkObj.Portable_electrical_equipment_tested_re__c",changeValue14);
    },
    CarHandleChange15: function (cmp, event) {
        var changeValue15 = event.getParam("value");
        cmp.set("v.radioValue16",changeValue15);
        cmp.set("v.checkObj.Inventory_of_all_electrical_equipment__c",changeValue15);
    },
    CarHandleChange16: function (cmp, event) {
        var changeValue16 = event.getParam("value");
        cmp.set("v.radioValue17",changeValue16);
        cmp.set("v.checkObj.Wiring_checks_up_to_date__c",changeValue16);
    },
    CarHandleChange17: function (cmp, event) {
        var changeValue17 = event.getParam("value");
        cmp.set("v.radioValue18",changeValue17);
        cmp.set("v.checkObj.All_Hazardous_substances_identified__c",changeValue17);
    },
    CarHandleChange18: function (cmp, event) {
        var changeValue18 = event.getParam("value");
        cmp.set("v.radioValue19",changeValue18);
        cmp.set("v.checkObj.Hazardous_substance_stored_separate_and__c",changeValue18);
    },
    CarHandleChange19: function (cmp, event) {
        var changeValue19 = event.getParam("value");
        cmp.set("v.radioValue20",changeValue19);
        cmp.set("v.checkObj.All_staff_trained_to_use_hazardous_subst__c",changeValue19);
    },
    CarHandleChange20: function (cmp, event) {
        var changeValue20 = event.getParam("value");
        cmp.set("v.radioValue21",changeValue20);
        cmp.set("v.checkObj.Any_High_Risk_material__c",changeValue20);
    },
    CarHandleChange21: function (cmp, event) {
        var changeValue21 = event.getParam("value");
        cmp.set("v.radioValue22",changeValue21);
        cmp.set("v.checkObj.Correct_type_for_purpose_ladders_trolle__c",changeValue21);
    },
    CarHandleChange22: function (cmp, event) {
        var changeValue22 = event.getParam("value");
        cmp.set("v.radioValue23",changeValue22);
        cmp.set("v.checkObj.Equipment_inspected_regularly_including__c",changeValue22);
    },
    CarHandleChange23: function (cmp, event) {
        var changeValue23 = event.getParam("value");
        cmp.set("v.radioValue24",changeValue23);
        cmp.set("v.checkObj.Storage_available_for__c",changeValue23);
    },
    CarHandleChange24: function (cmp, event) {
        var changeValue24 = event.getParam("value");
        cmp.set("v.radioValue25",changeValue24);
        cmp.set("v.checkObj.Suitable_adequate_health_and_safety_sign__c",changeValue24);
    },
    CarHandleChange25: function (cmp, event) {
        var changeValue25 = event.getParam("value");
        cmp.set("v.radioValue26",changeValue25);
        cmp.set("v.checkObj.H_amp_S_Law_Poster_displayed_with_Update__c",changeValue25);
    },
    CarHandleChange26: function (cmp, event) {
        var changeValue26 = event.getParam("value");
        cmp.set("v.radioValue27",changeValue26);
        cmp.set("v.checkObj.First_Aid_Kits_and_contact_numbers_for_f__c",changeValue26);
    },
    CarHandleChange27: function (cmp, event) {
        var changeValue27 = event.getParam("value");
        cmp.set("v.radioValue28",changeValue27);
        cmp.set("v.checkObj.First_Aid_Kit_fully_stocked_and_stock_in__c",changeValue27);
    },
    CarHandleChange28: function (cmp, event) {
        var changeValue28 = event.getParam("value");
        cmp.set("v.radioValue29",changeValue28);
        cmp.set("v.checkObj.Work_Benches_Kept_clean_and_Clear__c",changeValue28);
    },
    CarHandleChange29: function (cmp, event) {
        var changeValue29 = event.getParam("value");
        cmp.set("v.radioValue30",changeValue29);
        cmp.set("v.checkObj.All_PPE_in_good_condition_and_BS_standar__c",changeValue29);
    },
    CarHandleChange30: function (cmp, event) {
        var changeValue30 = event.getParam("value");
        cmp.set("v.radioValue31",changeValue30);
        cmp.set("v.checkObj.Suitable_storage_for_PPE__c",changeValue30);
    },
    
    /* handleComponentEvent : function(component, event, helper) {
      debugger;
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
       var eventrec = component.get("v.checkObj");
             eventrec.OwnerId =selecteduserGetFromEvent.Id;
             component.set("v.checkObj", eventrec);
        //alert('Serviec Provider Id:'+selecteduserGetFromEvent.Id);
      
             var userrec = {'Id':returnval.Location__r.OwnerId,'Name':returnval.Location__r.Owner.Name};
             var userlist = [];
             userlist.push(userrec);
             component.set("v.userobj", userrec);
             component.set("v.LookUpRe
             
             
             
    },*/
    handlemultipleComponentEvent : function(component, event, helper) {
       
        var selecteduserGetFromEvent = event.getParam("vehicleByEvent");
        console.log('usertype'+JSON.stringify(selecteduserGetFromEvent));
        var IsServiceProvider = event.getParam("IsServiceProvider");
        var IsServiceProvider1 = event.getParam("IsServiceProvider1");
        var eventrec = component.get("v.checkObj");
        var temp = selecteduserGetFromEvent.Id;
        var t=temp.substring(0, 3);
        console.log('temp'+temp);
        console.log('t'+t);
        if(t == 'a0h'){
            eventrec.Premise__c =selecteduserGetFromEvent.Id;
            
            component.set("v.checkObj", eventrec);
            
            
        }else if(t == '005') {
            eventrec.In_Charge__c =selecteduserGetFromEvent.Id;
            eventrec.Inspection_conducted_by__c =selecteduserGetFromEvent.Id;
            alert(eventrec.Inspection_conducted_by__c);
            component.set("v.checkObj", eventrec); 
            
        }
            else if(t == 'a0n')  {
                 eventrec.Vehicle__c =selecteduserGetFromEvent.Id;
               console.log('vehicle id'+eventrec.Vehicle__c);
                component.set("v.checkObj", eventrec); 
                
            }
               
        
    },
    
    submitmethod:function(component, event, helper){
        
        var newCheck = component.get("v.checkObj");
        console.log('oooooooooo'+JSON.stringify(newCheck));
        console.log('oooooooooo'+component.get("v.MonthlyDate"));  
        
        var action = component.get('c.createRecord');
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
        action.setParams({
            "jsonCheck": JSON.stringify(newCheck),
            "jsonDate":component.get("v.MonthlyDate")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                console.log('hiiiiiii');
                var temp=component.get('v.Vehiclerec');
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": temp.Id,
                    "slideDevName": "related"
                });
                navEvt.fire();
                  //window.location.reload();
                var dismissQuickAction = $A.get("e.force:closeQuickAction");
                dismissQuickAction.fire();
                
                
                                 var temp=component.get('v.Vehiclerec');
                console.log('temp'+JSON.stringify(temp));
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": temp.Id,
                    "slideDevName": "related"
                });
                navEvt.fire();
                
            }
            else if(state == "ERROR"){
                var errors = response.getError();                      
                
                component.set("v.showErrors",true);
                
                component.set("v.errorMessage",errors[0].message);
                
                console.log('errors[0].message'+errors[0].message);
                console.log('Error in calling server side action');
            }    
            
        });
        $A.enqueueAction(action);
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