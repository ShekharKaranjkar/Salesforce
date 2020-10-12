({
	doInit : function(component, event, helper) {
        window.setTimeout(
            $A.getCallback(function() {
                component.find("overlayLib").notifyClose();
            }),$A.get("$Label.c.ExternalLoginErrorMsgTimeoutMsec")
        );
	}
})