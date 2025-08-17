// 2. Cập nhật Phone của Contact rỗng thành '000-000'
// Mục tiêu: Batch update dữ liệu.

// start: Query SELECT Id, Phone FROM Contact WHERE Phone = null
// execute: Gán Phone = '000-000' và update
// finish: Log "Đã update xong Contact thiếu Phone"

global with sharing class Bai2Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Phone FROM Contact WHERE Phone = null'); // Truy vấn Contact thiếu Phone
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for (SObject s : scope) {

            Contact con = (Contact)s; // Chuyển đổi SObject thành Contact
            con.Phone = '000-000'; // set Phone
            contactsToUpdate.add(con);
            system.debug('Cập nhật Contact: ' + con.Id + ' với Phone: ' + con.Phone); // Log thông tin cập nhật
        }
        update contactsToUpdate;
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Đã update xong Contact thiếu Phone' );
    }
}
// test dữ liệu
// bai2Batch b2 = new bai2Batch();
// Database.executeBatch(b2, 200);