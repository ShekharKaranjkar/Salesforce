({ 
     CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
       // alert(changeValue);
         cmp.set("v.CarParkingValue",changeValue);
         cmp.set("v.leadObj.Can_we_put_charging_stations_in_Parking__c",changeValue);
    },
    doInit: function(component, event, helper) {
         //alert('meathod called');
        //debugger;
        //this.OnSubmit1(component, event);
      var action = component.get("c.getleadvalues");
       var  newLead = component.get('v.recordId');
       action.setParams({ 
       "id": newLead
    }); 
      action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
                //alert('state');
                component.set("v.leadObj",a.getReturnValue());
                component.set("v.CarParkingValue",a.getReturnValue().Can_we_put_charging_stations_in_Parking__c);
               // alert('value'+a.getReturnValue().Can_we_put_charging_stations_in_Parking__c);
                //$A.get('e.force:refreshView').fire();
                //alert('Record is Created Successfully');
                
                
            } else if(state == "ERROR"){
               // console.log(this);
                //alert('Error in calling server side action');
            }
        });   
         $A.enqueueAction(action);
    },
  OnSubmit : function(component, event,helper) {
      //alert('Save');
    var newLead = component.get("v.leadObj");
      //alert(newLead.Can_we_put_charging_stations_in_Parking__c);
      //alert(newLead.What_are_the_Locations_for_transport_ser__c);
      //alert(newLead.How_many_number_of_shifts__c);
      console.log(newLead);
      debugger;
      var changeValue2 = component.get("v.leadObj.Roster_Data_Parameters_checked__c");
      var a = component.get("v.leadObj.Have_you_identified_EV_initiative_key_dr__c");
      var b = component.get("v.leadObj.Have_you_mapped_decision_making_hierarch__c");
       var isexecute = false;
      if(newLead.What_are_the_Locations_for_transport_ser__c !=undefined 
               && newLead.What_are_the_Shift_Durations__c!=undefined  && 
              newLead.No_of_Trips_per_Day__c !=undefined  &&
               newLead.What_are_the_no_of_Operational_Days__c !=undefined  && 
               newLead.How_many_number_of_shifts__c !=undefined  &&
               newLead.What_is_the_load_distribution_on_Saturda__c !=undefined && 
               newLead.What_is_the_load_distribution_on_Sunday__c !=undefined  && 
               newLead.Are_the_Escort_Trips_treated_as_1_Trip__c !=undefined  &&
               newLead.Are_Back_to_Back_Trips_treated_as_1Trip__c !=undefined  &&
               newLead.What_are_current_Internal_trans_systems__c !=undefined  &&
               newLead.Can_we_put_charging_stations_in_Parking__c !=undefined 
         ){
      if(changeValue2 == "Yes" && a == "Yes" && b== "Yes" ){
          newLead.Question__c = true; }
          isexecute = true;
       }else{
           isexecute = false;
          helper.showToast(component, event,"Please fill the mandatory fileds.","error","Error!");

       }
      if(isexecute == true){
    newLead.Id = component.get('v.recordId');
    var action = component.get("c.createRecord");
    console.log(newLead);
    action.setParams({ 
      "jsonLead": JSON.stringify(newLead)
    });
    action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
               
                console.log('state');
                //Reset Form
                /*var newLead = {'sobjectType': 'Lead',
                                    'What_are_the_Locations_for_transport_ser__c': ''
                                   };
               
                component.set("v.fields",newLead);*/
                console.log('Record is Created Successfully');
                helper.showToast(component, event,"The record has been updated successfully.","success","Success!");

                //helper.showToast(component, event);
                // $A.get('e.force:refreshView').fire();
                //helper.refreshcomponent(component, event);
                window.location.reload();
                
            } else if(state == "ERROR"){
             helper.showToast(component, event,"Update failed.Please contact system administrator.","warning","Warning!");

                console.log(this);
                console.log('Error in calling server side action');
            }                
                
                
        });
          $A.enqueueAction(action);}
},
    // this function automatic call by aura:waiting event  
  /*  showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
   },
    
 // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
       component.set("v.Spinner", false);
    }*/
})