({
	showToast : function(component, event, message,type,title) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": title,
        "message": message,
        "type":type
    });
    toastEvent.fire();
},
    dointhelper : function(component, event,showmessage) {
  var action = component.get("c.getleadvalues");
       var  newOpportunity = component.get('v.recordId');
       action.setParams({ 
       "id": newOpportunity
    }); 
      action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
                debugger;
                component.set("v.M1div",false);
                component.set("v.M2div",false);
                component.set("v.M3div",false);
                component.set("v.M4div",false);
                component.set("v.M5div",false);
                component.set("v.M6div",false);
                component.set("v.W1div",false);
                component.set("v.W2div",false);
                component.set("v.W3div",false);
              //  component.set("v.Pdiv",false);
                component.set("v.OppObj",a.getReturnValue());
                 component.set("v.CarParkingValue",a.getReturnValue().Does_the_solution_meet_the_client_object__c);
                 component.set("v.CarParkingValue1",a.getReturnValue().Does_the_solution_saves_cost__c);
                 component.set("v.CarParkingValue2",a.getReturnValue().Is_the_solution_operationally_viable__c);
                 component.set("v.CarParkingValue3",a.getReturnValue().Have_we_internally_reviewed_the_final__c);
                 component.set("v.CarParkingValue4",a.getReturnValue().Have_you_prepared_an_executive_summary__c);
                 component.set("v.CarParkingValue5",a.getReturnValue().Have_you_taken_time_with_the_client__c);
                 component.set("v.CarParkingValue6",a.getReturnValue().Are_all_stakeholder_from_clientavailable__c);
                 component.set("v.CarParkingValue7",a.getReturnValue().Do_you_need_Ops_or_Leadership_to_be_part__c);
                 component.set("v.CarParkingValue8",a.getReturnValue().Have_you_identified_influencers_for__c);
                 component.set("v.CarParkingValue9",a.getReturnValue().Do_you_know_the_client_current_cost__c);
                 component.set("v.CarParkingValue10",a.getReturnValue().Are_you_aware_of_his_current_suppliers__c);
                 component.set("v.CarParkingValue11",a.getReturnValue().Is_the_client_cost_sensitive__c);
                 component.set("v.CarParkingValue12",a.getReturnValue().Has_the_client_made_aware_of_Fuel_price__c);
                 component.set("v.CarParkingValue13",a.getReturnValue().Have_you_collected_market_intel_about__c);
               // alert('aa:'+component.get("v.CarParkingValue13"));
                 component.set("v.CarParkingValue14",a.getReturnValue().Does_Lithium_commercials_save_client_s__c);
                // alert('bb:'+component.get("v.CarParkingValue14"));
                component.set("v.CarParkingValue15",a.getReturnValue().Have_we_created_Savings_glidepath__c);
                // alert('cc:'+component.get("v.CarParkingValue15"));
                component.set("v.CarParkingValue16",a.getReturnValue().Are_all_the_inclusions_and_exclusions__c);
               //  alert('dd:'+component.get("v.CarParkingValue16"));
                component.set("v.CarParkingValue17",a.getReturnValue().Does_the_customer_wants_to_negotiate__c);
                 component.set("v.CarParkingValue18",a.getReturnValue().Are_you_aware_of_client_s_commercial__c);
                 component.set("v.CarParkingValue19",a.getReturnValue().Have_you_discussed_the_key_contract_term__c);
                 component.set("v.CarParkingValue20",a.getReturnValue().Do_we_have_room_to_negotiate_and_close__c);
                 component.set("v.CarParkingValue21",a.getReturnValue().Have_we_aprised_client_of_lithium_s_valu__c);
                 //alert(':'+component.get("v.CarParkingValue16"));
                component.set("v.CarParkingValue22",a.getReturnValue().Have_all_internal_stakeholders_reviewd_t__c);
                //alert('bb:'+component.get("v.CarParkingValue22"));
                component.set("v.CarParkingValue23",a.getReturnValue().Have_we_highligted_all_deviations_in_the__c);
                // alert('cc:'+component.get("v.CarParkingValue23"));
                component.set("v.CarParkingValue24",a.getReturnValue().Has_the_client_set_expectations_on_timel__c);
                 //alert('dd:'+component.get("v.CarParkingValue24"));
                component.set("v.CarParkingValue25",a.getReturnValue().Have_we_signed_the_contract_document__c);
                 component.set("v.CarParkingValue26",a.getReturnValue().Have_we_shared_deployment_plan_and_ramp__c);
                 component.set("v.CarParkingValue27",a.getReturnValue().Is_every_internal_fuction_aware_of_their__c);
                 component.set("v.CarParkingValue28",a.getReturnValue().Has_the_charging_infra_work_planned_for__c);
                 component.set("v.CarParkingValue29",a.getReturnValue().Has_the_client_discussed_operational_dos__c);
                //  component.set("v.CarParkingValue30",a.getReturnValue().Have_all_drivers_cars_supervisors_been__c);
               //  component.set("v.CarParkingValue31",a.getReturnValue().Are_any_CXOs_attending_EV_launch_at_clie__c);

                var Opp = component.get("v.OppObj");
                
                
                //ert('!!!'+lead.Status+'length'+lead.Status.length);
                var elements;
                if(Opp.StageName ==  'M1: Solution Sent for Approval'){
                    component.set("v.M1div",true);
                    elements = component.find('show_combo1');}
                if(Opp.StageName ==  'M2: Solution Approved Internally'){
                     component.set("v.M2div",true);
                    elements = component.find('show_combo2');}
                if(Opp.StageName ==  'M3: Client given appointment to present Solution'){
                    if(Opp.Approval_Status__c != 'Pending'){
                        component.set("v.M3div",true);
                        elements = component.find('show_combo3');
                    }else
                        component.set("v.showQualifiermessage",true); 
                }
                if(Opp.StageName ==  'M4: Customer in Principal agrees and request for quote'){
                     component.set("v.M4div",true);
                    elements = component.find('show_combo4');}
                 if(Opp.StageName ==  'M5: Commercial proposal sent, Meeting Setup to present'){
                     component.set("v.M5div",true);
                    elements = component.find('show_combo5');}
                 if(Opp.StageName ==  'M6: Customer agrees to commercial proposal. Ready to start contratual discussion'){
                     component.set("v.M6div",true);
                    elements = component.find('show_combo6');}
                 if(Opp.StageName ==  'W1: Customer wishes to negotiate'){
                     component.set("v.W1div",true);
                    elements = component.find('show_combo7');}
                 if(Opp.StageName ==  'W2: All terms agreed , Customer has sent final agreed contract'){
                     component.set("v.W2div",true);
                    elements = component.find('show_combo8');}
                 if(Opp.StageName	 ==  'Rollout Plan'){
                     component.set("v.W3div",true);
                    elements = component.find('show_combo9');}
                if(Opp.StageName	 ==  'Project Kickoff' || Opp.StageName	 ==  'Planning'
                   || Opp.StageName	 ==  'Execution' || Opp.StageName	 ==  'Completed'){
                     component.set("v.pilotNoQ",true);
                    //elements = component.find('show_combo9');
                }
              //  if(Opp.StageName  ==  'Project Kickoff'){
                  //   component.set("v.Pdiv",true);
                  //  elements = component.find('show_combo10');}
                
                $A.util.removeClass(elements, 'slds-hide');
                $A.util.addClass(elements, 'slds-show');
                component.set("v.messageif",showmessage);
            } else if(state == "ERROR"){
            }
       });    
         $A.enqueueAction(action);
  
},
})