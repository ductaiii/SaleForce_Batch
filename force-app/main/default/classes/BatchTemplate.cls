global class BatchTemplate implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // truy vấn đối tượng muốn xử lý
        return Database.getQueryLocator('SELECT Id, Name FROM Account Where Name = \'Điêu Thuyền\'');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        // Process each record in the scope
        for (SObject record : scope) {
            // Example processing logic
            System.debug('Processing record: ' + record);
        }
    }

    global void finish(Database.BatchableContext BC) {
        // Logic to execute after all batches are processed
        System.debug('Batch processing completed.');
    }
}