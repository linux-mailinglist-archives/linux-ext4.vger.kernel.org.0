Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B74D3CF461
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jul 2021 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhGTFgb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Jul 2021 01:36:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11454 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhGTFfY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Jul 2021 01:35:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GTT044YqBzcgSj;
        Tue, 20 Jul 2021 14:12:36 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 14:15:58 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 20 Jul 2021 14:15:58 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] ext4: flush s_error_work before journal destroy in ext4_fill_super
Date:   Tue, 20 Jul 2021 14:24:09 +0800
Message-ID: <20210720062409.960734-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

'commit c92dc856848f ("ext4: defer saving error info from atomic
context")' and '2d01ddc86606 ("ext4: save error info to sb through journal
if available")' add s_error_work to fix checksum error problem. But the
error path in ext4_fill_super can lead the follow BUG_ON.

Our testcase got follow BUG:
[32031.759805] ------------[ cut here ]------------
[32031.759807] kernel BUG at fs/jbd2/transaction.c:373!
[32031.760075] invalid opcode: 0000 [#1] SMP PTI
[32031.760336] CPU: 5 PID: 1029268 Comm: kworker/5:1 Kdump: loaded
Tainted: G           OE    --------- -  -
4.18.0
...
[32031.766665]  jbd2__journal_start+0xf1/0x1f0 [jbd2]
[32031.766934]  jbd2_journal_start+0x19/0x20 [jbd2]
[32031.767218]  flush_stashed_error_work+0x30/0x90 [ext4]
[32031.767487]  process_one_work+0x195/0x390
[32031.767747]  worker_thread+0x30/0x390
[32031.768007]  ? process_one_work+0x390/0x390
[32031.768265]  kthread+0x10d/0x130
[32031.768521]  ? kthread_flush_work_fn+0x10/0x10
[32031.768778]  ret_from_fork+0x35/0x40

static int start_this_handle(...)
    BUG_ON(journal->j_flags & JBD2_UNMOUNT); <---- Trigger this

flush_stashed_error_work will try to access journal. We cannot flush
s_error_work after journal destroy.

Fixes: c92dc856848f ("ext4: defer saving error info from atomic context")
Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..7db2be03848f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5173,15 +5173,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
 	sbi->s_ea_block_cache = NULL;
+failed_mount3a:
+	ext4_es_unregister_shrinker(sbi);
+failed_mount3:
+	flush_work(&sbi->s_error_work);
 
 	if (sbi->s_journal) {
 		jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
 	}
-failed_mount3a:
-	ext4_es_unregister_shrinker(sbi);
-failed_mount3:
-	flush_work(&sbi->s_error_work);
 	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
 failed_mount2:
-- 
2.31.1

