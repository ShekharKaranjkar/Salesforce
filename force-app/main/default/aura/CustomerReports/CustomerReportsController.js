({
    openReport : function(component, event, helper) {
        helper.setBusy( component, true );
        
        helper.getReportId( component, event );
    }
})