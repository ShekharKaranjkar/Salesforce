({
	setselectedissuewith : function(component, event, helper) {
         var getSelectissuewith = component.get("v.issue");
        // call the event   
        var compEvent = component.getEvent("Selectedissuewith");
        // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"issuewith" : getSelectissuewith });  
        // fire the event  
        compEvent.fire();
    }
})