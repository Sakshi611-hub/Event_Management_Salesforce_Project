public with sharing class TaskController {

    @AuraEnabled
    public static Task__c createTask(String taskName, Id eventId, Id assignedTo, DateTime dueDate, String priority) {
        try {
            Task__c newTask = new Task__c(
                Name = taskName,
                Event__c = eventId,
                Assigned_To__c = assignedTo,
                Due_Date__c = dueDate,
                Priority__c = priority,
                Status__c = 'Not Started'
            );
            insert newTask;
            return newTask;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating task: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateTaskStatus(Id taskId, String newStatus) {
        try {
            Task__c task = [SELECT Id, Status__c FROM Task__c WHERE Id = :taskId LIMIT 1];
            task.Status__c = newStatus;
            update task;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating task status: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void updateTaskDueDate(Id taskId, DateTime newDueDate) {
        try {
            Task__c task = [SELECT Id, Due_Date__c FROM Task__c WHERE Id = :taskId LIMIT 1];
            task.Due_Date__c = newDueDate;
            update task;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating task due date: ' + e.getMessage());
        }
    }
}
