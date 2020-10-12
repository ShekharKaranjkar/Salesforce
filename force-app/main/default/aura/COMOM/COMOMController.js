({
	 CarHandleChange: function (cmp, event) {
        var changeValue = event.getParam("value");
         cmp.set("v.CarParkingValue",changeValue);
         cmp.set("v.ConObj.Has_the_KAM_and_ops_team_been_introduced__c",changeValue);
          var a = cmp.get("v.ConObj.Is_the_marketing_team_preparing_for_laun__c");
           var b = cmp.get("v.ConObj.Have_we_understood_client_s_billing_and__c");
        if(changeValue == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.ConObj.Question__c",true);   
    },
     CarHandleChange1: function (cmp, event) {
        var changeValue1 = event.getParam("value");
         cmp.set("v.CarParkingValue1",changeValue1);
         cmp.set("v.ConObj.Is_the_marketing_team_preparing_for_laun__c",changeValue1);
         var a = cmp.get("v.ConObj.Has_the_KAM_and_ops_team_been_introduced__c");
         var b = cmp.get("v.ConObj.Have_we_understood_client_s_billing_and__c");
        if(changeValue1 == "Yes" && a == "Yes" && b== "Yes" )
		 cmp.set("v.ConObj.Question__c",true);   
    },
     CarHandleChange2: function (cmp, event) {
        var changeValue2 = event.getParam("value");
         cmp.set("v.CarParkingValue2",changeValue2);
         console.log('changeValue2 ', changeValue2);
         cmp.set("v.ConObj.Have_we_understood_client_s_billing_and__c",changeValue2);
         var a = cmp.get("v.ConObj.Has_the_KAM_and_ops_team_been_introduced__c");
         var b = cmp.get("v.ConObj.Is_the_marketing_team_preparing_for_laun__c");
       	 console.log('a ', a);
         console.log('b ', b);
         
         if(changeValue2 == "Yes" && a == "Yes" && b== "Yes" )
			 cmp.set("v.ConObj.Question__c",true);   
    },
    CarHandleChange3: function (cmp, event) {
        var changeValue3 = event.getParam("value");
         cmp.set("v.CarParkingValue3",changeValue3);
         cmp.set("v.ConObj.Have_all_drivers_cars_supervisors_been__c",changeValue3);
         var a = cmp.get("v.ConObj.Are_any_CXOs_attending_EV_launch_at_clie__c");
        if(changeValue3 == "Yes" && a == "Yes" )
		 cmp.set("v.ConObj.Question__c",true);   
    },
     CarHandleChange4: function (cmp, event) {
        var changeValue4 = event.getParam("value");
         cmp.set("v.CarParkingValue4",changeValue4);
        // alert(':"'+changeValue4);
         cmp.set("v.ConObj.Are_any_CXOs_attending_EV_launch_at_clie__c",changeValue4);
         //var adsa = cmp.get("v.ConObj.Are_any_CXOs_attending_EV_launch_at_clie__c");
         //alert(adsa);
         var a = cmp.get("v.ConObj.Have_all_drivers_cars_supervisors_been__c");
        if(changeValue4 == "Yes" && a == "Yes")
		 cmp.set("v.ConObj.Question__c",true);   
    },
    doInit: function(component, event, helper) {
        helper.dointhelper(component, event,false);
    },
    OnSubmit : function(component, event,helper) {
    var newLead = component.get("v.ConObj");
      console.log(newLead);
        
        //Add on
		if(newLead.Status =='Upload Signed Contract'){
        	if(newLead.Has_the_KAM_and_ops_team_been_introduced__c == "Yes" &&
               newLead.Is_the_marketing_team_preparing_for_laun__c == "Yes" &&
               newLead.Have_we_understood_client_s_billing_and__c == "Yes")
                newLead.Question__c = true;
            else
                newLead.Question__c = false;    
        }
        if(newLead.Status =='Active'){
        	if(newLead.Have_all_drivers_cars_supervisors_been__c == "Yes" &&
               newLead.Are_any_CXOs_attending_EV_launch_at_clie__c == "Yes")
                newLead.Question__c = true;
            else
                newLead.Question__c = false;
        }        
        //Add on
    newLead.Id = component.get('v.recordId');
    var action = component.get("c.createRecord");
    console.log(newLead);
        
       /* var body = {'Id':newLead.Id,'Question' :newLead.Question__c,'Status':newLead.Status,'Has_the_KAM_and_ops_team_been_introduced__c':newLead.Has_the_KAM_and_ops_team_been_introduced__c,                              
                    'Is_the_marketing_team_preparing_for_laun':newLead.Is_the_marketing_team_preparing_for_laun__c,
                                                             'Have_we_understood_client_s_billing_and':newLead.Have_we_understood_client_s_billing_and__c,
                                                             'Are_any_CXOs_attending_EV_launch_at_clie':newLead.Are_any_CXOs_attending_EV_launch_at_clie__c,
                                                            'Have_all_drivers_cars_supervisors_been':newLead.Have_all_drivers_cars_supervisors_been__c
                                                              };*/
    action.setParams({ 
       "jsonContract": JSON.stringify(newLead)
    });
        
    action.setCallback(this, function(a) {
           var state = a.getState();
            if(state == "SUCCESS"){
               // window.Location.reload();
                console.log('state');
                //Reset Form
                /*var newLead = {'sobjectType': 'Lead',
                                    'What_are_the_Locations_for_transport_ser__c': ''
                                   };
               
                component.set("v.fields",newLead);*/
                console.log('Record is Created Successfully');
                
                helper.showToast(component, event,"The record has been updated successfully.","success","Success!");
                 helper.dointhelper(component, event,true);
                $A.get('e.force:refreshView').fire();
                           


            } else if(state == "ERROR"){
                console.log(this);
                console.log('Error in calling server side action');
               helper.showToast(component, event,"update failed.Please contact administrator.","warning","Warning!");

            }
        });
    $A.enqueueAction(action);
    }
})