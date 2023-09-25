trigger BearAlertTopicAssignmentTrigger on TopicAssignment (after insert) {
    // Get FeedItem posts only
    Set<Id> feedIds = new Set<Id>();
    for (TopicAssignment ta : Trigger.new){
        if (ta.EntityId.getSObjectType().getDescribe().getName().equals('FeedItem')) {
            feedIds.add(ta.EntityId);
        }
    }

    // Publish messages as notifications
    List<Notification__e> notifications = new List<Notification__e>();
    for (String message: messages) {
        notifications.add(new Notification__e(Message__c = message));
    }
    List<Database.SaveResult> results = EventBus.publish(notifications);
    // Inspect publishing results
    for (Database.SaveResult result : results) {
        if (!result.isSuccess()) {
            for (Database.Error error : result.getErrors()) {
                System.debug('Error returned: ' + error.getStatusCode() +' - '+ error.getMessage());
            }
        }
    }
}
