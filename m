Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92031416EF2
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Sep 2021 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhIXJbR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Sep 2021 05:31:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9921 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbhIXJbN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Sep 2021 05:31:13 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HG67j1Y3gz8yCV;
        Fri, 24 Sep 2021 17:25:05 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:29:39 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:29:38 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v3] ext4: flush s_error_work before journal destroy in ext4_fill_super
Date:   Fri, 24 Sep 2021 17:39:17 +0800
Message-ID: <20210924093917.1953239-1-yangerkun@huawei.com>
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

The error path in ext4_fill_super forget to flush s_error_work before
journal destroy, and it may trigger the follow bug since
flush_stashed_error_work can run concurrently with journal destroy
without any protection for sbi->s_journal.

[32031.740193] EXT4-fs (loop66): get root inode failed
[32031.740484] EXT4-fs (loop66): mount failed
[32031.759805] ------------[ cut here ]------------
[32031.759807] kernel BUG at fs/jbd2/transaction.c:373!
[32031.760075] invalid opcode: 0000 [#1] SMP PTI
[32031.760336] CPU: 5 PID: 1029268 Comm: kworker/5:1 Kdump: loaded
4.18.0
[32031.765112] Call Trace:
[32031.765375]  ? __switch_to_asm+0x35/0x70
[32031.765635]  ? __switch_to_asm+0x41/0x70
[32031.765893]  ? __switch_to_asm+0x35/0x70
[32031.766148]  ? __switch_to_asm+0x41/0x70
[32031.766405]  ? _cond_resched+0x15/0x40
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

Besides, after we enable fast commit, ext4_fc_replay can add work to
s_error_work but return success, so the latter journal destroy in
ext4_load_journal can trigger this problem too.

Fix this problem with two steps:
1. Call ext4_commit_super directly in ext4_handle_error for the case
   that called from ext4_fc_replay
2. Since it's hard to pair the init and flush for s_error_work, we'd
   better add a extras flush_work before journal destroy in
   ext4_fill_super

Besides, this patch will call ext4_commit_super in ext4_handle_error for
any nojournal case too. But it seems safe since the reason we call
schedule_work was that we should save error info to sb through journal
if available. Conversely, for the nojournal case, it seems useless delay
commit superblock to s_error_work.

Fixes: c92dc856848f ("ext4: defer saving error info from atomic context")
Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0775950ee84e..45a3df280e23 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -658,7 +658,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * constraints, it may not be safe to do it right here so we
 		 * defer superblock flushing to a workqueue.
 		 */
-		if (continue_fs)
+		if (continue_fs && journal)
 			schedule_work(&EXT4_SB(sb)->s_error_work);
 		else
 			ext4_commit_super(sb);
@@ -5042,12 +5042,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
+		/* flush s_error_work before journal destroy. */
+		flush_work(&sbi->s_error_work);
 		jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
 failed_mount3:
+	/* flush s_error_work before sbi destroy */
 	flush_work(&sbi->s_error_work);
 	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
-- 
2.31.1

