({
    doInit : function(component, event, helper) {
        helper.getIssue(component, event, helper);
    },
    
    addNewRowjoblineitem : function(component, event, helper) {
        helper.createObject(component, event,helper);
    },
    createObjectIventory : function(component, event, helper) {
        helper.createObjectIventory(component, event,helper);
    },
    addNewRowjoblineitemGeneral : function(component, event, helper) {
        helper.createObjectGeneral(component, event,helper);
    },
    
    removeDeletedRow : function(component, event, helper) {
        helper.removeDeletedRowSwapped(component, event,helper);
    },
    removeDeletedRowIventory : function(component, event, helper) {
        helper.removeDeletedRowIventory(component, event,helper);
    },
    removeDeletedGeneral : function(component, event, helper) {
        helper.removeDeletedRowGeneral(component, event,helper);
    },
    

    goesBack: function(component,event,helper){      
        helper.gotoIssueRecord(component, event, helper);   
    },
    Save: function(component, event, helper) {
        helper.JobCardAndJobLineItems(component, event, helper);
    },
    
    
})