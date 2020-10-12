({
	doInit : function(component, event, helper) {
		//alert('');
////		var reocrids = component.get('v.entityId');
    //    consle.log('reocrids'+reocrids)
         helper.onLoad(component, event);
        
	},
    approvrd: function(component, event, helper) {
       // alert('approved');
        var buttonName = event.getSource().get("v.value");
        alert('buttonName'+buttonName);
    },
    rejected:function(component, event, helper) {
        //alert('rejected');
    },
})