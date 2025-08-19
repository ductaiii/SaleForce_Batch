// 4. Đếm số lượng Opportunity theo Stage
// Mục tiêu: Sử dụng Database.Stateful để lưu biến đếm.

// start: Query SELECT Id, StageName FROM Opportunity
// execute: Dùng Map <String, Integer> để đếm theo Stage
// finish: System.debug(map kết quả)
global with sharing class Bai4Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Map<String, Integer> stageCountMap = new Map<String, Integer>();

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, StageName FROM Opportunity');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        for (SObject s : scope) {
            Opportunity opp = (Opportunity)s;
            String stageName = opp.StageName;
            if (stageCountMap.containsKey(stageName)) {
                stageCountMap.put(stageName, stageCountMap.get(stageName) + 1);
            } else {
                stageCountMap.put(stageName, 1);
            }
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Số lượng Opportunity theo Stage: ' + stageCountMap);
    }

}
// Test đếm số lượng Opportunity theo Stage
// Bai4Batch bai4 = new Bai4Batch();
// Database.executeBatch(bai4);
