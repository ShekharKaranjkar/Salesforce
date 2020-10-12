({
	nextComponent : function(component, event, helper) {
        debugger;
        ///component.set("v.showparent",false);
		//component.set("v.showchild",true);
        var newComponent = $A.get("e.force:navigateToComponent");
        newComponent.setParams({
            componentDef: "c:DriverRepairIssueResolved",
            /*componentAttributes: {
                //Set you attributes here if required.
            }*/
        });
       newComponent.fire();
     
	}

})