({
    setBusy: function( component, isBusy ) {
        component.set( "v.isBusy", isBusy );
    },
    
    getReportId : function( component, event ) {
        let reportId = component.get( `v.${ event.currentTarget.name }` );

        this.captureAccountId( component, reportId );
    },

    captureAccountId: function( component, reportId ) {
        let self = this;

        let action = component.get( "c.capture" );
        
        action.setParams(
            {
                "accountId" : component.get( "v.recordId" )
            }
        );
        
        action.setCallback(
            this,
            function( response ) {
                this.setBusy( component, false );
                
                let state = response.getState();

                if ( state === "SUCCESS" ) {
                    if( response.getReturnValue() ) {
                        self.navigateToReport( reportId );
                    }
                }
                else if ( state === "ERROR" ) {
                    let errors = response.getError();

                    if ( errors ) {
                        if ( errors[0] && errors[0].message ) {
                            console.log(
                                `Error message: ${ errors[0].message }`
                            );
                        }
                    } else {
                        console.log( "Unknown error" );
                    }
                }
            }
        );
        
        $A.enqueueAction( action );
    },

    navigateToReport: function( reportId ) {
        $A.get( "e.force:navigateToURL" ).setParams(
            {
                "url": `/${ reportId }`
            }
        ).fire();
    }
})