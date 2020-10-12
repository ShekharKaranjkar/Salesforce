({
	  doint : function(component, event, helper) {
          //console.log('hi::::'+component.get("v.pageReference").state.additionalParams.split('&')[1].split('=')[1]);
          debugger;
        var recordTypeId = component.get("v.pageReference").state.recordTypeId;
          component.set('v.recordTypeId',recordTypeId);
		console.log('recordTypeId'+recordTypeId);
          //console.log('component.get("v.pageReference").state ' ,component.get("v.pageReference").state.additionalParams);
          if(component.get("v.pageReference").state.additionalParams)
          	component.set('v.parentrecid',component.get("v.pageReference").state.additionalParams.split('&')[1].split('=')[1]);
         helper.fetchRecordType(component, event, helper);
          
	}
})