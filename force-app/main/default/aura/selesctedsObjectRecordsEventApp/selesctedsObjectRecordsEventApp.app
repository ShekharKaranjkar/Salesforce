<aura:application extends="force:slds">
  <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecords" type="sObject[]" default="[]"/>
 
  <c:reUsableMultiSelectLookupCtrl objectAPIName="contact"
                               IconName="standard:contact"
                               lstSelectedRecords="{!v.selectedLookUpRecords}"
                               label="Contact"/>
   <!-- here c: is org. namespace prefix-->
</aura:application>