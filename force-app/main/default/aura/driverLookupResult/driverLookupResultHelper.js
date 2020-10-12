({
	searchHelper : function(component,event,getInputkeyWord) {
        //debugger;
        // call the apex class method 
        var action = component.get("c.fetchLookUpValues");
        // set param to method  
        action.setParams({
            'searchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPIName"),
            'ExcludeitemsList' : component.get("v.userobj")
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            debugger;
            $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert('users');
                
                var storeResponse = response.getReturnValue();
                // if storeResponse size is equal 0 ,display No Records Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Records Found...');
                } else {
                    component.set("v.Message", '');
                    // set searchResult list with return value from server.
                }
                component.set("v.listOfSearchRecords", storeResponse); 
                var componentlis = component.get("v.listOfSearchRecords");
                //alert('Users cont: '+componentlis.length);
            }
        });
        // enqueue the Action  
        $A.enqueueAction(action);
    },
})