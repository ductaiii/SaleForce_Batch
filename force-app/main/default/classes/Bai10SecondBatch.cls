// mục đích batch này là để sau khi Bai10Batch kia chạy xong thì batch này sẽ thực hiện , nội dung batch này sẽ xử lý các bản ghi đã được cập nhật bởi batch trước đó
global with sharing class Bai10SecondBatch implements Database.Batchable<SObject> {
      global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = 'Đã lau bàn'; // xử lý tiếp
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Xong Batch 2: Lau bàn.');
    }
}