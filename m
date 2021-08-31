Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29433FC6E0
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Aug 2021 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbhHaLzm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Aug 2021 07:55:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9389 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhHaLzl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Aug 2021 07:55:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GzQVZ2pg0z8wsr;
        Tue, 31 Aug 2021 19:50:30 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 19:54:35 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 31 Aug 2021 19:54:35 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2] ext4: flush s_error_work before journal destroy in ext4_fill_super
Date:   Tue, 31 Aug 2021 20:04:49 +0800
Message-ID: <20210831120449.2910005-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Fixes: c92dc856848f ("ext4: defer saving error info from atomic context")
Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d6df62fc810c..06b5ad34d892 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -659,7 +659,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		 * constraints, it may not be safe to do it right here so we
 		 * defer superblock flushing to a workqueue.
 		 */
-		if (continue_fs)
+		if (continue_fs && journal)
 			schedule_work(&EXT4_SB(sb)->s_error_work);
 		else
 			ext4_commit_super(sb);
@@ -5172,12 +5172,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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

