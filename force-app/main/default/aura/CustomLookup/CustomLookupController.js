({
	itemSelected : function(component, event, helper) {
		console.log('itemSelected');
        helper.itemSelected(component, event, helper);
	}, 
    serverCall :  function(component, event, helper) {
        console.log('serverCall');
		helper.serverCall(component, event, helper);
	},
    clearSelection : function(component, event, helper){
        console.log('clearSelection');
        helper.clearSelection(component, event, helper);
    } 
})