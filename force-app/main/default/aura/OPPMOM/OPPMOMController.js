({
     CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
         cmp.set("v.CarParkingValue",changeValue);
         cmp.set("v.leadObj.Is_Highly_Qualified__c",changeValue);
        var a = cmp.get("v.leadObj.Have_you_met_boss_of_the_contact__c");
        if(changeValue == "Yes" && a == "Yes" )
		 cmp.set("v.leadObj.Question__c",true);             
    },
     CarHandleChange1: function (cmp, event) {
         debugger;
        var changeValue1 = event.getParam("value");
         cmp.set("v.CarParkingValue1",changeValue1);
         cmp.set("v.leadObj.Have_you_met_boss_of_the_contact__c",changeValue1);
           var a = cmp.get("v.leadObj.Is_Highly_Qualified__c");
        if(changeValue1 == "Yes" && a == "Yes" )
		 cmp.set("v.leadObj.Question__c",true);        
    },
     CarHandleChange2: function (cmp, event) {
         debugger;
        var changeValue2 = event.getParam("value");
         cmp.set("v.CarParkingValue2",changeValue2);
         cmp.set("v.leadObj.Roster_Data_Parameters_checked__c",changeValue2);
          var a = cmp.get("v.leadObj.Have_you_identified_EV_initiative_key_dr__c");
           var b = cmp.get("v.leadObj.Have_you_mapped_decision_making_hierarch__c");
        if(changeValue2 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.leadObj.Question__c",true);   
         
    },
     CarHandleChange3: function (cmp, event) {
        var changeValue3 = event.getParam("value");
         cmp.set("v.CarParkingValue1",changeValue3);
         cmp.set("v.leadObj.Have_you_identified_EV_initiative_key_dr__c",changeValue3);
        var a = cmp.get("v.leadObj.Roster_Data_Parameters_checked__c");
           var b = cmp.get("v.leadObj.Have_you_mapped_decision_making_hierarch__c");
        if(changeValue3 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.leadObj.Question__c",true);     
    },
     CarHandleChange4: function (cmp, event) {
        var changeValue4 = event.getParam("value");
         cmp.set("v.CarParkingValue4",changeValue4);
         cmp.set("v.leadObj.Have_you_mapped_decision_making_hierarch__c",changeValue4);
          var a = cmp.get("v.leadObj.Roster_Data_Parameters_checked__c");
           var b = cmp.get("v.leadObj.Have_you_identified_EV_initiative_key_dr__c");
        if(changeValue4 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
     CarHandleChange5: function (cmp, event) {
        var changeValue5 = event.getParam("value");
         cmp.set("v.CarParkingValue5",changeValue5);
         cmp.set("v.leadObj.Have_you_met_atleast_2_and_taken_their_c__c",changeValue5);
         var a = cmp.get("v.leadObj.Is_everyone_aligned_on_the_objective_of__c");
           var b = cmp.get("v.leadObj.Are_they_key_decision_makers__c");
        if(changeValue5 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
     CarHandleChange6: function (cmp, event) {
        var changeValue6 = event.getParam("value");
         cmp.set("v.CarParkingValue6",changeValue6);
         cmp.set("v.leadObj.Is_everyone_aligned_on_the_objective_of__c",changeValue6);
         var a = cmp.get("v.leadObj.Have_you_met_atleast_2_and_taken_their_c__c");
           var b = cmp.get("v.leadObj.Are_they_key_decision_makers__c");
        if(changeValue6 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
     CarHandleChange7: function (cmp, event) {
        var changeValue7 = event.getParam("value");
         cmp.set("v.CarParkingValue7",changeValue7);
         cmp.set("v.leadObj.Are_they_key_decision_makers__c",changeValue7);
         var a = cmp.get("v.leadObj.Is_everyone_aligned_on_the_objective_of__c");
           var b = cmp.get("v.leadObj.Have_you_met_atleast_2_and_taken_their_c__c");
        if(changeValue7 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
    CarHandleChange8: function (cmp, event) {
        var changeValue8 = event.getParam("value");
         cmp.set("v.CarParkingValue8",changeValue8);
         cmp.set("v.leadObj.Has_the_client_requested_for_a_solution__c",changeValue8);
         var a = cmp.get("v.leadObj.Has_client_identified_timelines_for_the__c");
          var b = cmp.get("v.leadObj.Have_you_received_all_operational_info__c");
          var c = cmp.get("v.leadObj.Have_you_identified_the_procurement_proc__c");
          var d = cmp.get("v.leadObj.Is_everyone_aligned_on_the_objective_of__c");
        if(changeValue8 == "Yes" && a == "Yes" && b== "Yes" && c== "Yes" && d=="Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
    CarHandleChange9: function (cmp, event) {
        var changeValue9 = event.getParam("value");
         cmp.set("v.CarParkingValue9",changeValue9);
         cmp.set("v.leadObj.Has_client_identified_timelines_for_the__c",changeValue9);
         var a = cmp.get("v.leadObj.Have_you_received_all_operational_info__c");
           var b = cmp.get("v.leadObj.Have_you_identified_the_procurement_proc__c");
            var c = cmp.get("v.leadObj.If_RFP_has_he_confirmed_to_invite__c");
           var d = cmp.get("v.leadObj.Has_the_client_requested_for_a_solution__c");
        if(changeValue9 == "Yes" && a == "Yes" && b== "Yes"  && c == "Yes" && d == "Yes")
		 cmp.set("v.leadObj.Question__c",true); 
    },
    CarHandleChange10: function (cmp, event) {
        var changeValue10 = event.getParam("value");
         cmp.set("v.CarParkingValue10",changeValue10);
         cmp.set("v.leadObj.Have_you_received_all_operational_info__c",changeValue10);
         var a = cmp.get("v.leadObj.Have_you_identified_the_procurement_proc__c");
           var b = cmp.get("v.leadObj.If_RFP_has_he_confirmed_to_invite__c");
           var c = cmp.get("v.leadObj.Has_client_identified_timelines_for_the__c");
           var d = cmp.get("v.leadObj.Has_the_client_requested_for_a_solution__c");
        if(changeValue10 == "Yes" && a == "Yes" && b== "Yes" && c == "Yes" && d == "Yes")
		 cmp.set("v.leadObj.Question__c",true); 
    },
    CarHandleChange11: function (cmp, event) {
        var changeValue11 = event.getParam("value");
         cmp.set("v.CarParkingValue11",changeValue11);
         cmp.set("v.leadObj.Have_you_identified_the_procurement_proc__c",changeValue11);
         var a = cmp.get("v.leadObj.If_RFP_has_he_confirmed_to_invite__c");
           var b = cmp.get("v.leadObj.Have_you_received_all_operational_info__c");
           var c = cmp.get("v.leadObj.Has_client_identified_timelines_for_the__c");
           var d = cmp.get("v.leadObj.Has_the_client_requested_for_a_solution__c");
        if(changeValue11 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes" && d == "Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
    CarHandleChange12: function (cmp, event) {
        var changeValue12 = event.getParam("value");
         cmp.set("v.CarParkingValue12",changeValue12);
         cmp.set("v.leadObj.If_RFP_has_he_confirmed_to_invite__c",changeValue12);
         var a = cmp.get("v.leadObj.Have_you_identified_the_procurement_proc__c");
           var b = cmp.get("v.leadObj.Have_you_received_all_operational_info__c");
            var c = cmp.get("v.leadObj.Has_client_identified_timelines_for_the__c");
            var d = cmp.get("v.leadObj.Has_the_client_requested_for_a_solution__c");
        if(changeValue12 == "Yes" && a == "Yes" && b== "Yes" && c== "Yes" && d == "Yes" )
		 cmp.set("v.leadObj.Question__c",true); 
    },
	    doInit: function(component, event, helper) {
helper.dointhelper(component, event,false);
    },
    OnSubmit : function(component, event,helper) {
      
    var newLead = component.get("v.leadObj");
   var QualifierMsg = false ;
        if(newLead.Status ==  'U1: First Meeting Done'){
         	if(newLead.Is_Highly_Qualified__c == "Yes" && newLead.Have_you_met_boss_of_the_contact__c == "Yes")
                newLead.Question__c = true;
            else
                newLead.Question__c = false;
        }
        if(newLead.Status ==  'U2: Info Exchanged'){
            debugger;
            //alert(newLead.What_are_the_Locations_for_transport_ser__c);
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
                     )
                newLead.Question__c = true;
            else
            { QualifierMsg  = true; 
                newLead.Question__c = false;
            }
        }
        if(newLead.Status ==  'U3: All Stakeholders Met'){
            if(newLead.Have_you_met_atleast_2_and_taken_their_c__c == "Yes" && newLead.Is_everyone_aligned_on_the_objective_of__c == "Yes" && newLead.Are_they_key_decision_makers__c  == "Yes" )
                newLead.Question__c = true;
            else
                newLead.Question__c = false;
            
        }
        if(newLead.Status ==  'U4: Customer Confirms Need or Sends RFP1'){
            if(newLead.Has_the_client_requested_for_a_solution__c  == "Yes" && newLead.Has_client_identified_timelines_for_the__c == "Yes" && newLead.Have_you_received_all_operational_info__c == "Yes" && newLead.Have_you_identified_the_procurement_proc__c  == "Yes" && newLead.If_RFP_has_he_confirmed_to_invite__c  == "Yes")
                newLead.Question__c = true;
            else
                newLead.Question__c = false;
             
        }
       //// 
        
      console.log(newLead);
    newLead.Id = component.get('v.recordId');
    var action = component.get("c.createRecord");
    console.log(newLead);
    action.setParams({ 
       "jsonLead": JSON.stringify(newLead)
    });
    action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
                debugger;
                console.log('state');
                console.log('Record is Created Successfully');
                 $A.get('e.force:refreshView').fire();
                if(QualifierMsg == true)
                 helper.showToast(component, event,"Please fill the Qualifier.","warning","Success!");
                else{
                      helper.showToast(component, event,"The record has been updated successfully.","success","Success!");

                }

                           helper.dointhelper(component, event,true);

            } else if(state == "ERROR"){
                console.log(this);
                console.log('Error in calling server side action');
                helper.showToast(component, event,"Update failed.Please contact system administrator.","warning","Warning");
            }
        });
    $A.enqueueAction(action);
    }
})