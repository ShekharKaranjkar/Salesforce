({
	doInit : function(component, event, helper) {
       
        helper.onLoad(component, event);
        
	},
    approvrd: function(component, event, helper) {
       // alert('approved');
        var buttonName = event.getSource().get("v.value");
       // alert('buttonName'+buttonName);
    },
    rejected:function(component, event, helper) {
        //alert('rejected');
    },
})