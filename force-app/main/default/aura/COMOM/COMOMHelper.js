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
   dointhelper :function(component, event,showmessage) {
		 var action = component.get("c.getleadvalues");
       var  newContract = component.get('v.recordId');
       action.setParams({ 
       "id": newContract
    }); 
      action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
                component.set("v.Sdiv",false);
                component.set("v.Pdiv",false);
               
                debugger;
                component.set("v.ConObj",a.getReturnValue());
                     component.set("v.CarParkingValue",a.getReturnValue().Has_the_KAM_and_ops_team_been_introduced__c);
                     component.set("v.CarParkingValue1",a.getReturnValue().Is_the_marketing_team_preparing_for_laun__c);
                     component.set("v.CarParkingValue2",a.getReturnValue().Have_we_understood_client_s_billing_and__c);
                     component.set("v.CarParkingValue3",a.getReturnValue().Have_all_drivers_cars_supervisors_been__c);
                     component.set("v.CarParkingValue4",a.getReturnValue().Are_any_CXOs_attending_EV_launch_at_clie__c);
                console.log('Record :'+a.getReturnValue());
               // alert(a.getReturnValue().Are_any_CXOs_attending_EV_launch_at_clie__c);
                var Contract = component.get("v.ConObj");
                
                //alert(':'+Contract.Are_any_CXOs_attending_EV_launch_at_clie__c);
                //ert('!!!'+lead.Status+'length'+lead.Status.length);
                var elements;
                component.set("v.Hdiv",false);
                if(Contract.Status =='Upload Signed Contract'){
                    component.set("v.Sdiv",true);
                     elements = component.find('show_combo');}
                if(Contract.Status =='Historical'){
                    component.set("v.Hdiv",true);
                }
                    if(Contract.Status =='Active'){
                    component.set("v.Pdiv",true);
                    elements = component.find('show_combo1');}
                $A.util.removeClass(elements, 'slds-hide');
                $A.util.addClass(elements, 'slds-show');
            } else if(state == "ERROR"){
            }
        });   
         $A.enqueueAction(action);
	}
})