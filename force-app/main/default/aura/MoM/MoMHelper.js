({
addRecord: function(component, event) {
        
        var TaskList1 = component.get("v.TaskList1");
        TaskList1.push({});
        component.set("v.TaskList1", TaskList1);        
    	
	},
    add1: function(component, event) {
        
        var TaskList2 = component.get("v.TaskList2");
        TaskList2.push({});
        component.set("v.TaskList2", TaskList2);        
    	
	},
     addRecord3: function(component, event) {
        
        var TaskList3 = component.get("v.TaskList3");
        TaskList3.push({});
        component.set("v.TaskList3", TaskList3);        
    	
	},
    
    addRecord4: function(component, event) {
        
        var TaskList4 = component.get("v.TaskList4");
        TaskList4.push({});
        component.set("v.TaskList4", TaskList4);        
    	
	},
    
    addRecord5: function(component, event) {
        
        var TaskList5 = component.get("v.TaskList5");
        TaskList5.push({});
        component.set("v.TaskList5", TaskList5);        
    	
	},
    
    addRecord6: function(component, event) {
        
        var TaskList6= component.get("v.TaskList6");
        TaskList6.push({});
        component.set("v.TaskList6", TaskList6);        
    	
	},
    showToast : function(component, event, message,type,title) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type":type
        });
        toastEvent.fire();
    },
    showspinner : function(component, event){
        var elements = component.find('spinnerID');
         $A.util.removeClass(elements, 'slds-hide');
        $A.util.addClass(elements, 'slds-show');
    },
    hidespinner : function(component, event){
        var elements = component.find('spinnerID');
         $A.util.removeClass(elements, 'slds-show');
        $A.util.addClass(elements, 'slds-hide');
    },
    showpopup : function(component, event){
        var elements = component.find('showpopupid');
         $A.util.removeClass(elements, 'slds-hide');
        $A.util.addClass(elements, 'slds-show');
    },
    hidespopup : function(component, event){
        var elements = component.find('showpopupid');
         $A.util.removeClass(elements, 'slds-show');
        $A.util.addClass(elements, 'slds-hide');
    }
})