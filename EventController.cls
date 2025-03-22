public with sharing class EventController {
    
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getAttendees(Id eventId) {
        try {
            return [SELECT Id, Name, Email, Ticket_Type__c, Registration_Status__c FROM Attendee__c WHERE Event__c = :eventId];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching attendees: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void updateAttendeeCount(Id eventId) {
        try {
            Event__c event = [SELECT Id, Attendee_Count__c FROM Event__c WHERE Id = :eventId LIMIT 1];
            Integer attendeeCount = [SELECT COUNT() FROM Attendee__c WHERE Event__c = :eventId];
            event.Attendee_Count__c = attendeeCount;
            update event;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating attendee count: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static Event__c createEvent(String eventName, String eventType, DateTime eventDate, String location, String description, Decimal budget) {
        try {
            Event__c newEvent = new Event__c(
                Name = eventName,
                Event_Type__c = eventType,
                Event_Date__c = eventDate,
                Location__c = location,
                Description__c = description,
                Status__c = 'Planned',
                Budget__c = budget
            );
            insert newEvent;
            return newEvent;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating event: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateSponsorPaymentStatus(Id sponsorId, String paymentStatus) {
        try {
            Sponsor__c sponsor = [SELECT Id, Payment_Status__c FROM Sponsor__c WHERE Id = :sponsorId LIMIT 1];
            sponsor.Payment_Status__c = paymentStatus;
            update sponsor;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating sponsor payment status: ' + e.getMessage());
        }
    }
}
