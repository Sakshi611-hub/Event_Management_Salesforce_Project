public with sharing class VendorController {

    @AuraEnabled
    public static void updateVendorServiceCost(Id vendorId, Decimal newServiceCost) {
        try {
            Vendor__c vendor = [SELECT Id, Service_Cost__c FROM Vendor__c WHERE Id = :vendorId LIMIT 1];
            vendor.Service_Cost__c = newServiceCost;
            update vendor;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating vendor service cost: ' + e.getMessage());
        }
    }
}
