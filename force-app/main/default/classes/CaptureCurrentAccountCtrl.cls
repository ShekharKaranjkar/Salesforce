/**
 * This is used from the Lightning Component (Aura) that
 * is used on the Customer (aka Account) page that opens
 * the Joined Reports:
 *      Normative Vs Actual Revenue
 *      No of Kms
 *      No of trips
 *      
 * Joined Reports doesn't support filtering via URL Params.
 * These Joined Reports have to work in two ways: filtered
 * w.r.t to an Account when navigated from the Account page
 * and a snapshot of all the records when viewed from the
 * Reports tab.
 *
 * The idea here is clone these Reports namely:
 *      Normative Vs Actual Revenue (Customer)
 *      No of Kms (Customer)
 *      No of trips (Customer)
 *
 * Then use a Custom Setting (Hierarchy) that will have
 * an entry for every user. When the User clicks the
 * button from the Aura Component, it will update
 * the field "Record Id" in the Custom Setting - "Current
 * Viewing Account" with the Id of that Account record
 * in context.
 *
 * Now a Formula Field (Checkbox) will be checked if
 * the Id on the Account and the Id captured in the
 * Record Id field on the Custom Setting - "Current
 * Viewing Account" are the same.
 *
 * We will then add a filter on these Joined Reports
 * such that it will be filtered down to the records
 * where the Checkbox is CHECKED (aka. true)
 *
 * @author      Dazeworks Inc. (Shruti S)
 * @version     1.0
 * @see         [ADD-LINK-TO-USER-STORY]
 */
public without sharing class CaptureCurrentAccountCtrl {
    @AuraEnabled
    public static Boolean capture( String accountId ) {
        Current_Viewing_Account__c cva = Current_Viewing_Account__c.getInstance( UserInfo.getUserId() );
        
        if( cva.Record_Id__c != accountId ) {
            cva.SetupOwnerId   = UserInfo.getUserId();
            cva.Record_Id__c   = accountId;
            
            UPSERT cva Id;
        }
        
        return TRUE;
    }
}