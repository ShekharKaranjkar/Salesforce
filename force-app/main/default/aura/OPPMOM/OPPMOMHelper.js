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
            console.log('dointhelper');
         var action = component.get("c.getleadvalues");
       var  newLead = component.get('v.recordId');
       action.setParams({ 
       "id": newLead
    }); 
      action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
                debugger;
                //window.Location.reload();
                component.set("v.U4div",false);
                component.set("v.U1div",false);
                component.set("v.U2div",false);
                component.set("v.U3div",false);
               component.set("v.C3div",false);
               component.set("v.C2div",false);
               component.set("v.C1div",false);

                component.set("v.leadObj",a.getReturnValue());
                     component.set("v.CarParkingValue",a.getReturnValue().Is_Highly_Qualified__c);
                     component.set("v.CarParkingValue1",a.getReturnValue().Have_you_met_boss_of_the_contact__c);
                     component.set("v.CarParkingValue2",a.getReturnValue().Roster_Data_Parameters_checked__c);
                     component.set("v.CarParkingValue3",a.getReturnValue().Have_you_identified_EV_initiative_key_dr__c);
                     component.set("v.CarParkingValue4",a.getReturnValue().Have_you_mapped_decision_making_hierarch__c);
                     component.set("v.CarParkingValue5",a.getReturnValue().Have_you_met_atleast_2_and_taken_their_c__c);
                     component.set("v.CarParkingValue6",a.getReturnValue().Is_everyone_aligned_on_the_objective_of__c);
                     component.set("v.CarParkingValue7",a.getReturnValue().Are_they_key_decision_makers__c);
                     component.set("v.CarParkingValue8",a.getReturnValue().Has_the_client_requested_for_a_solution__c);
                     component.set("v.CarParkingValue9",a.getReturnValue().Has_client_identified_timelines_for_the__c);
                     component.set("v.CarParkingValue10",a.getReturnValue().Have_you_received_all_operational_info__c);
                     component.set("v.CarParkingValue11",a.getReturnValue().Have_you_identified_the_procurement_proc__c);
                     component.set("v.CarParkingValue12",a.getReturnValue().If_RFP_has_he_confirmed_to_invite__c);

                var lead = component.get("v.leadObj");
                //ert('!!!'+lead.Status+'length'+lead.Status.length);
                var elements;
                if(lead.Status ==  'C1: New'){
                    component.set("v.C1div",true);
                    elements = component.find('show_combo5');}
                if(lead.Status ==  'C2: Working - Not Contacted'){
                    component.set("v.C2div",true);
                    elements = component.find('show_combo6');}
                 if(lead.Status ==  'C3: Working - Contacted'){
                    component.set("v.C3div",true);
                    elements = component.find('show_combo4');}
                if(lead.Status ==  'U1: First Meeting Done'){
                    component.set("v.U1div",true);
                    elements = component.find('show_combo');}
                if(lead.Status ==  'U2: Info Exchanged'){
                     component.set("v.U2div",true);
                    elements = component.find('show_combo1');}
                if(lead.Status ==  'U3: All Stakeholders Met'){
                     component.set("v.U3div",true);
                    elements = component.find('show_combo2');}
                if(lead.Status ==  'U4: Customer Confirms Need or Sends RFP1'){
                     component.set("v.U4div",true);
                    elements = component.find('show_combo3');}
                $A.util.removeClass(elements, 'slds-hide');
                $A.util.addClass(elements, 'slds-show');
                component.set("v.messageif",showmessage);
                //alert('Class Name: '+elements.getElements());
            } else if(state == "ERROR"){
            helper.showToast(component, event,"Unable to fetching the data.Please contact system administrator.","warning","Warning");

            }
        });   
         $A.enqueueAction(action);
},   
})