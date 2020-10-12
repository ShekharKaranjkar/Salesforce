({
     CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
         cmp.set("v.CarParkingValue",changeValue);
         cmp.set("v.OppObj.Does_the_solution_meet_the_client_object__c",changeValue);
         var a = cmp.get("v.OppObj.Does_the_solution_saves_cost__c");
         var b = cmp.get("v.OppObj.Is_the_solution_operationally_viable__c");
         if(changeValue == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);             
    },
     CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
         cmp.set("v.CarParkingValue1",changeValue1);
         cmp.set("v.OppObj.Does_the_solution_saves_cost__c",changeValue1);
         var a = cmp.get("v.OppObj.Does_the_solution_meet_the_client_object__c");
         var b = cmp.get("v.OppObj.Is_the_solution_operationally_viable__c");
         if(changeValue1 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);
    },
     CarHandleChange2: function (cmp, event) {

        var changeValue2 = event.getParam("value");
         cmp.set("v.CarParkingValue2",changeValue2);
         cmp.set("v.OppObj.Is_the_solution_operationally_viable__c",changeValue2);
         var a = cmp.get("v.OppObj.Does_the_solution_saves_cost__c");
         var b = cmp.get("v.OppObj.Does_the_solution_meet_the_client_object__c");
         if(changeValue2 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);

     },
     CarHandleChange3: function (cmp, event) {
         debugger;
        var changeValue3= event.getParam("value");
         cmp.set("v.CarParkingValue3",changeValue3);
         cmp.set("v.OppObj.Have_we_internally_reviewed_the_final__c",changeValue3);
         var a = cmp.get("v.OppObj.Have_you_prepared_an_executive_summary__c");
         var b = cmp.get("v.OppObj.Have_you_taken_time_with_the_client__c");
         if(changeValue3 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange4: function (cmp, event) {
             debugger;
        var changeValue4 = event.getParam("value");
         cmp.set("v.CarParkingValue4",changeValue4);
         cmp.set("v.OppObj.Have_you_prepared_an_executive_summary__c",changeValue4);
             var a = cmp.get("v.OppObj.Have_we_internally_reviewed_the_final__c");
         var b = cmp.get("v.OppObj.Have_you_taken_time_with_the_client__c");
         if(changeValue4 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange5: function (cmp, event) {
             debugger;
        var changeValue5= event.getParam("value");
         cmp.set("v.CarParkingValue5",changeValue5);
         cmp.set("v.OppObj.Have_you_taken_time_with_the_client__c",changeValue5);
             var a = cmp.get("v.OppObj.Have_you_prepared_an_executive_summary__c");
         var b = cmp.get("v.OppObj.Have_we_internally_reviewed_the_final__c");
         if(changeValue5 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);
            // alert(cmp.get("v.OppObj.Question__c"));
             
    },
         CarHandleChange6: function (cmp, event) {
        var changeValue6 = event.getParam("value");
         cmp.set("v.CarParkingValue6",changeValue6);
         cmp.set("v.OppObj.Are_all_stakeholder_from_clientavailable__c",changeValue6);
             var a = cmp.get("v.OppObj.Do_you_need_Ops_or_Leadership_to_be_part__c");
         var b = cmp.get("v.OppObj.Have_you_identified_influencers_for__c");
         if(changeValue6 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange7: function (cmp, event) {
        var changeValue7 = event.getParam("value");
         cmp.set("v.CarParkingValue7",changeValue7);
         cmp.set("v.OppObj.Do_you_need_Ops_or_Leadership_to_be_part__c",changeValue7);
              var a = cmp.get("v.OppObj.Are_all_stakeholder_from_clientavailable__c");
         var b = cmp.get("v.OppObj.Have_you_identified_influencers_for__c");
         if(changeValue7 == "Yes" && a == "Yes" && b == "Yes")
		 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange8: function (cmp, event) {
        var changeValue8 = event.getParam("value");
         cmp.set("v.CarParkingValue8",changeValue8);
         cmp.set("v.OppObj.Have_you_identified_influencers_for__c",changeValue8);
             var a = cmp.get("v.OppObj.Do_you_need_Ops_or_Leadership_to_be_part__c");
             var b = cmp.get("v.OppObj.Are_all_stakeholder_from_clientavailable__c");
             if(changeValue8 == "Yes" && a == "Yes" && b == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
     CarHandleChange9: function (cmp, event) {
        var changeValue9 = event.getParam("value");
         cmp.set("v.CarParkingValue9",changeValue9);
         cmp.set("v.OppObj.Do_you_know_the_client_current_cost__c",changeValue9);
         var a = cmp.get("v.OppObj.Are_you_aware_of_his_current_suppliers__c");
         var b = cmp.get("v.OppObj.Is_the_client_cost_sensitive__c");
         var c = cmp.get("v.OppObj.Has_the_client_made_aware_of_Fuel_price__c");
         if(changeValue9 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
             cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange10: function (cmp, event) {
        var changeValue10 = event.getParam("value");
         cmp.set("v.CarParkingValue10",changeValue10);
         cmp.set("v.OppObj.Are_you_aware_of_his_current_suppliers__c",changeValue10);
             var a = cmp.get("v.OppObj.Do_you_know_the_client_current_cost__c");
         var b = cmp.get("v.OppObj.Is_the_client_cost_sensitive__c");
         var c = cmp.get("v.OppObj.Has_the_client_made_aware_of_Fuel_price__c");
         if(changeValue10 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
             cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange11: function (cmp, event) {
        var changeValue11 = event.getParam("value");
         cmp.set("v.CarParkingValue11",changeValue11);
         cmp.set("v.OppObj.Is_the_client_cost_sensitive__c",changeValue11);
             var a = cmp.get("v.OppObj.Do_you_know_the_client_current_cost__c");
             var b = cmp.get("v.OppObj.Are_you_aware_of_his_current_suppliers__c");
             var c = cmp.get("v.OppObj.Has_the_client_made_aware_of_Fuel_price__c");
             if(changeValue11 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
             
    },
         CarHandleChange12: function (cmp, event) {
        var changeValue12 = event.getParam("value");
         cmp.set("v.CarParkingValue12",changeValue12);
         cmp.set("v.OppObj.Has_the_client_made_aware_of_Fuel_price__c",changeValue12);
             var a = cmp.get("v.OppObj.Do_you_know_the_client_current_cost__c");
             var b = cmp.get("v.OppObj.Are_you_aware_of_his_current_suppliers__c");
             var c = cmp.get("v.OppObj.Is_the_client_cost_sensitive__c");
             if(changeValue12 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange13: function (cmp, event) {
        var changeValue13 = event.getParam("value");
         cmp.set("v.CarParkingValue13",changeValue13);
         cmp.set("v.OppObj.Have_you_collected_market_intel_about__c",changeValue13);
            // alert('a:'+cmp.get("v.OppObj.Have_you_collected_market_intel_about__c"));
             var a = cmp.get("v.OppObj.Does_Lithium_commercials_save_client_s__c");
             var b = cmp.get("v.OppObj.Have_we_created_Savings_glidepath__c");
             var c = cmp.get("v.OppObj.Are_all_the_inclusions_and_exclusions__c");
             if(changeValue13 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
        
         CarHandleChange14: function (cmp, event) {
        var changeValue14 = event.getParam("value");
         cmp.set("v.CarParkingValue14",changeValue14);
         cmp.set("v.OppObj.Does_Lithium_commercials_save_client_s__c",changeValue14);
            // alert('b:'+cmp.get("v.OppObj.Does_Lithium_commercials_save_client_s__c"));
              var a = cmp.get("v.OppObj.Have_you_collected_market_intel_about__c");
             var b = cmp.get("v.OppObj.Have_we_created_Savings_glidepath__c");
             var c = cmp.get("v.OppObj.Are_all_the_inclusions_and_exclusions__c");
             if(changeValue14 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange15: function (cmp, event) {
        var changeValue15 = event.getParam("value");
         cmp.set("v.CarParkingValue15",changeValue15);
         cmp.set("v.OppObj.Have_we_created_Savings_glidepath__c",changeValue15);
             //alert('c:'+cmp.get("v.OppObj.Have_we_created_Savings_glidepath__c"));
              var a = cmp.get("v.OppObj.Does_Lithium_commercials_save_client_s__c");
             var b = cmp.get("v.OppObj.Have_you_collected_market_intel_about__c");
             var c = cmp.get("v.OppObj.Are_all_the_inclusions_and_exclusions__c");
             if(changeValue15 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
        
         CarHandleChange16: function (cmp, event) {
        var changeValue16 = event.getParam("value");
         cmp.set("v.CarParkingValue16",changeValue16);
         cmp.set("v.OppObj.Are_all_the_inclusions_and_exclusions__c",changeValue16);
            // alert('d:'+cmp.get("v.OppObj.Are_all_the_inclusions_and_exclusions__c"));
              var a = cmp.get("v.OppObj.Does_Lithium_commercials_save_client_s__c");
             var b = cmp.get("v.OppObj.Have_we_created_Savings_glidepath__c");
             var c = cmp.get("v.OppObj.Have_you_collected_market_intel_about__c");
             if(changeValue16 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange17: function (cmp, event) {
             //debugger;
        var changeValue17 = event.getParam("value");
         cmp.set("v.CarParkingValue17",changeValue17);
         cmp.set("v.OppObj.Does_the_customer_wants_to_negotiate__c",changeValue17);
             var a = cmp.get("v.OppObj.Are_you_aware_of_client_s_commercial__c");
             var b = cmp.get("v.OppObj.Have_you_discussed_the_key_contract_term__c");
             var c = cmp.get("v.OppObj.Do_we_have_room_to_negotiate_and_close__c");
             if(changeValue17 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
    },
         CarHandleChange18: function (cmp, event) {
             debugger;
        var changeValue18 = event.getParam("value");
         cmp.set("v.CarParkingValue18",changeValue18);
         cmp.set("v.OppObj.Are_you_aware_of_client_s_commercial__c",changeValue18);
		var a = cmp.get("v.OppObj.Does_the_customer_wants_to_negotiate__c");
             var b = cmp.get("v.OppObj.Have_you_discussed_the_key_contract_term__c");
             var c = cmp.get("v.OppObj.Do_we_have_room_to_negotiate_and_close__c");
             if(changeValue18 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);     
    },
         CarHandleChange19: function (cmp, event) {
             debugger;
        var changeValue19 = event.getParam("value");
         cmp.set("v.CarParkingValue19",changeValue19);
         cmp.set("v.OppObj.Have_you_discussed_the_key_contract_term__c",changeValue19);
             var a = cmp.get("v.OppObj.Does_the_customer_wants_to_negotiate__c");
             var b = cmp.get("v.OppObj.Does_the_customer_wants_to_negotiate__c");
             var c = cmp.get("v.OppObj.Do_we_have_room_to_negotiate_and_close__c");
             if(changeValue19 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true); 
    },
      CarHandleChange20: function (cmp, event) {
          debugger;
        var changeValue20 = event.getParam("value");
         cmp.set("v.CarParkingValue20",changeValue20);
         cmp.set("v.OppObj.Do_we_have_room_to_negotiate_and_close__c",changeValue20);
          var a = cmp.get("v.OppObj.Does_the_customer_wants_to_negotiate__c");
             var b = cmp.get("v.OppObj.Have_you_discussed_the_key_contract_term__c");
             var c = cmp.get("v.OppObj.Does_the_customer_wants_to_negotiate__c");
             if(changeValue20 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true); 

     },
     CarHandleChange21: function (cmp, event) {
        var changeValue21 = event.getParam("value");
         cmp.set("v.CarParkingValue21",changeValue21);
         cmp.set("v.OppObj.Have_we_aprised_client_of_lithium_s_valu__c",changeValue21);
		 var a = cmp.get("v.OppObj.Have_all_internal_stakeholders_reviewd_t__c");
             var b = cmp.get("v.OppObj.Have_we_highligted_all_deviations_in_the__c");
             var c = cmp.get("v.OppObj.Has_the_client_set_expectations_on_timel__c");
             if(changeValue21 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true); 
     },
     CarHandleChange22: function (cmp, event) {
        var changeValue22 = event.getParam("value");
         cmp.set("v.CarParkingValue22",changeValue22);
         cmp.set("v.OppObj.Have_all_internal_stakeholders_reviewd_t__c",changeValue22);
			var a = cmp.get("v.OppObj.Have_we_aprised_client_of_lithium_s_valu__c");
             var b = cmp.get("v.OppObj.Have_we_highligted_all_deviations_in_the__c");
             var c = cmp.get("v.OppObj.Has_the_client_set_expectations_on_timel__c");
             if(changeValue22 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
     CarHandleChange23: function (cmp, event) {
        var changeValue23 = event.getParam("value");
         cmp.set("v.CarParkingValue23",changeValue23);
         cmp.set("v.OppObj.Have_we_highligted_all_deviations_in_the__c",changeValue23);
var a = cmp.get("v.OppObj.Have_all_internal_stakeholders_reviewd_t__c");
             var b = cmp.get("v.OppObj.Have_we_aprised_client_of_lithium_s_valu__c");
             var c = cmp.get("v.OppObj.Has_the_client_set_expectations_on_timel__c");
             if(changeValue23 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
     CarHandleChange24: function (cmp, event) {
        var changeValue24 = event.getParam("value");
         cmp.set("v.CarParkingValue24",changeValue24);
         cmp.set("v.OppObj.Has_the_client_set_expectations_on_timel__c",changeValue24);
var a = cmp.get("v.OppObj.Have_all_internal_stakeholders_reviewd_t__c");
             var b = cmp.get("v.OppObj.Have_we_highligted_all_deviations_in_the__c");
             var c = cmp.get("v.OppObj.Have_we_aprised_client_of_lithium_s_valu__c");
             if(changeValue24 == "Yes" && a == "Yes" && b == "Yes" && c == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
   
    CarHandleChange25: function (cmp, event) {
        var changeValue25 = event.getParam("value");
         cmp.set("v.CarParkingValue25",changeValue25);
         cmp.set("v.OppObj.Have_we_signed_the_contract_document__c",changeValue25);
var a = cmp.get("v.OppObj.Have_we_shared_deployment_plan_and_ramp__c");
                 if(changeValue25 == "Yes" && a == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
    CarHandleChange26: function (cmp, event) {
        var changeValue26 = event.getParam("value");
         cmp.set("v.CarParkingValue26",changeValue26);
         cmp.set("v.OppObj.Have_we_shared_deployment_plan_and_ramp__c",changeValue26);
var a = cmp.get("v.OppObj.Have_we_signed_the_contract_document__c");
                 if(changeValue26 == "Yes" && a == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
     CarHandleChange27: function (cmp, event) {
        var changeValue27 = event.getParam("value");
         cmp.set("v.CarParkingValue27",changeValue27);
         cmp.set("v.OppObj.Is_every_internal_fuction_aware_of_their__c",changeValue27);
		var a = cmp.get("v.OppObj.Has_the_charging_infra_work_planned_for__c");
             var b = cmp.get("v.OppObj.Has_the_client_discussed_operational_dos__c");
             if(changeValue27 == "Yes" && a == "Yes" && b == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     }, 
    CarHandleChange28: function (cmp, event) {
        var changeValue28 = event.getParam("value");
         cmp.set("v.CarParkingValue28",changeValue28);
         cmp.set("v.OppObj.Has_the_charging_infra_work_planned_for__c",changeValue28);
var a = cmp.get("v.OppObj.Is_every_internal_fuction_aware_of_their__c");
             var b = cmp.get("v.OppObj.Has_the_client_discussed_operational_dos__c");
             if(changeValue28 == "Yes" && a == "Yes" && b == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
    
     CarHandleChange29: function (cmp, event) {
        var changeValue29 = event.getParam("value");
         cmp.set("v.CarParkingValue29",changeValue29);
         cmp.set("v.OppObj.Has_the_client_discussed_operational_dos__c",changeValue29);
var a = cmp.get("v.OppObj.Has_the_charging_infra_work_planned_for__c");
             var b = cmp.get("v.OppObj.Is_every_internal_fuction_aware_of_their__c");
             if(changeValue29 == "Yes" && a == "Yes" && b == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
   /*  CarHandleChange30: function (cmp, event) {
        var changeValue30 = event.getParam("value");
         cmp.set("v.CarParkingValue30",changeValue30);
         cmp.set("v.OppObj.Have_all_drivers_cars_supervisors_been__c",changeValue30);
var a = cmp.get("v.OppObj.Are_any_CXOs_attending_EV_launch_at_clie__c");
                 if(changeValue30 == "Yes" && a == "Yes")
                 cmp.set("v.OppObj.Question__c",true);
     },
     CarHandleChange31: function (cmp, event) {
        var changeValue31 = event.getParam("value");
         cmp.set("v.CarParkingValue31",changeValue31);
         cmp.set("v.OppObj.Are_any_CXOs_attending_EV_launch_at_clie__c",changeValue31);
var a = cmp.get("v.OppObj.Have_all_drivers_cars_supervisors_been__c");
                 if(changeValue31 == "Yes" && a == "Yes")
                 cmp.set("v.OppObj.Question__c",true); 
     },*/
	    doInit: function(component, event, helper) {
            helper.dointhelper(component, event,false);
      },
    OnSubmit : function(component, event,helper) {
      //debugger;
    var newLead = component.get("v.OppObj");
    //Add on
    if(newLead.StageName ==  'M1: Solution Sent for Approval'){
        if(newLead.Does_the_solution_meet_the_client_object__c == "Yes" && newLead.Does_the_solution_saves_cost__c == "Yes" && newLead.Is_the_solution_operationally_viable__c == "Yes")
            newLead.Question__c = true;
        else
            newLead.Question__c = false;
    }
    if(newLead.StageName ==  'M2: Solution Approved Internally'){
        if(newLead.Have_we_internally_reviewed_the_final__c == "Yes" && newLead.Have_you_prepared_an_executive_summary__c == "Yes" && newLead.Have_you_taken_time_with_the_client__c == "Yes")
            newLead.Question__c = true;
        else
            newLead.Question__c = false;
    }
    if(newLead.StageName ==  'M3: Client given appointment to present Solution'){
        if(newLead.Are_all_stakeholder_from_clientavailable__c == "Yes" && newLead.Do_you_need_Ops_or_Leadership_to_be_part__c == "Yes" && newLead.Have_you_identified_influencers_for__c == "Yes" && newLead.Approval_Status__c == "Approved")
            newLead.Question__c = true;
        else
            newLead.Question__c = false;
    }
    if(newLead.StageName ==  'M4: Customer in Principal agrees and request for quote'){
        console.log();
        if(newLead.Do_you_know_the_client_current_cost__c == "Yes" && 
           newLead.Are_you_aware_of_his_current_suppliers__c == "Yes" && 
           newLead.Is_the_client_cost_sensitive__c == "Yes" && 
           newLead.Has_the_client_made_aware_of_Fuel_price__c == "Yes")
            newLead.Question__c = true;
        else
            newLead.Question__c = false;
    }
    if(newLead.StageName ==  'M5: Commercial proposal sent, Meeting Setup to present'){
        if(newLead.Have_you_collected_market_intel_about__c == "Yes" && newLead.Does_Lithium_commercials_save_client_s__c == "Yes" && newLead.Have_we_created_Savings_glidepath__c == "Yes" && newLead.Have_we_created_Savings_glidepath__c == "Yes" && newLead.Are_all_the_inclusions_and_exclusions__c == "Yes")
            newLead.Question__c = true;
        else
        newLead.Question__c = false;
    }
    if(newLead.StageName ==  'M6: Customer agrees to commercial proposal. Ready to start contratual discussion'){
        if(newLead.Does_the_customer_wants_to_negotiate__c == "Yes" &&
           newLead.Are_you_aware_of_client_s_commercial__c == "Yes" &&
           newLead.Have_you_discussed_the_key_contract_term__c == "Yes" &&
           newLead.Do_we_have_room_to_negotiate_and_close__c == "Yes")
            newLead.Question__c = true;
        else
            newLead.Question__c = false;
    }
    if(newLead.StageName ==  'W1: Customer wishes to negotiate'){
        if(newLead.Have_we_aprised_client_of_lithium_s_valu__c == "Yes" && newLead.Have_all_internal_stakeholders_reviewd_t__c == "Yes" && newLead.Have_we_highligted_all_deviations_in_the__c == "Yes" && newLead.Has_the_client_set_expectations_on_timel__c == "Yes")
            newLead.Question__c = true;
        else
        newLead.Question__c = false;
    }
    if(newLead.StageName ==  'W2: All terms agreed , Customer has sent final agreed contract'){
        if(newLead.Have_we_signed_the_contract_document__c == "Yes" && newLead.Have_we_shared_deployment_plan_and_ramp__c == "Yes")
            newLead.Question__c = true;
        else
        newLead.Question__c = false;
    }
    if(newLead.StageName	 ==  'Rollout Plan'){
    	if(newLead.Is_every_internal_fuction_aware_of_their__c == "Yes" && newLead.Has_the_charging_infra_work_planned_for__c == "Yes" && newLead.Has_the_client_discussed_operational_dos__c == "Yes")
            newLead.Question__c = true;
        else
        newLead.Question__c = false;
    }
    //Add on
        
        
        
      console.log(newLead);
    newLead.Id = component.get('v.recordId');
    var action = component.get("c.createRecord");
    console.log(newLead);
    action.setParams({ 
       "jsonOpportunity": JSON.stringify(newLead)
    });
    action.setCallback(this, function(a) {
        debugger;
           var state = a.getState();
            if(state == "SUCCESS"){
                 //window.location.reload();
                console.log('state');
                //Reset Form
                /*var newLead = {'sobjectType': 'Lead',
                                    'What_are_the_Locations_for_transport_ser__c': ''
                                   };
               
                component.set("v.fields",newLead);*/
                console.log('Record is Created Successfully');
                if(newLead.Approval_Status__c == "Rejected"){
                     helper.showToast(component, event,"Opportunity is Rejected","error","Error!");

                }else{
                    helper.showToast(component, event,"The record has been updated successfully.","success","Success!");
                    helper.dointhelper(component, event,true);
                }
                $A.get('e.force:refreshView').fire();
            } else if(state == "ERROR"){
                console.log(this);
                console.log('Error in calling server side action');
                 helper.showToast(component, event,"Update failed.Please contact system administrator.","warning","Warning");
            }
        });
    $A.enqueueAction(action);
    }

})