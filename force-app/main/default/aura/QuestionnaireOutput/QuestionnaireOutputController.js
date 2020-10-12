({
	doInit : function(component, event, helper) {
        //alert('Doint');
		 var action = component.get("c.getleadvalues");
   
       var  newLead = component.get('v.recordId');
       action.setParams({ 
       "id": newLead
    }); 
          action.setCallback(this, function(a) {
              debugger;
           var state = a.getState();
            if(state == "SUCCESS"){
              
    //component.set("v.overall",a.getReturnValue());
    
                component.set("v.overall",a.getReturnValue());
              
                //helper.showToast(component, event);

                helper.refreshcomponent(component, event);
               // alert('value'+a.getReturnValue().Can_we_put_charging_stations_in_Parking__c);
                //$A.get('e.force:refreshView').fire();
                //alert('Record is Created Successfully');
            } else if(state == "ERROR"){
               // console.log(this);
                //alert('Error in calling server side action');
            }
        });   
         $A.enqueueAction(action);
    }
  
})