Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E04E35D9
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 02:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiCVBKt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 21:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiCVBKs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 21:10:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189519C17;
        Mon, 21 Mar 2022 18:09:19 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KMtfv06kcz1GClN;
        Tue, 22 Mar 2022 09:09:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 09:09:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: fix bug_on in start_this_handle during umount filesystem
Date:   Tue, 22 Mar 2022 09:24:19 +0800
Message-ID: <20220322012419.725457-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got issue as follows:
------------[ cut here ]------------
kernel BUG at fs/jbd2/transaction.c:389!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 9 PID: 131 Comm: kworker/9:1 Not tainted 5.17.0-862.14.0.6.x86_64-00001-g23f87daf7d74-dirty #197
Workqueue: events flush_stashed_error_work
RIP: 0010:start_this_handle+0x41c/0x1160
RSP: 0018:ffff888106b47c20 EFLAGS: 00010202
RAX: ffffed10251b8400 RBX: ffff888128dc204c RCX: ffffffffb52972ac
RDX: 0000000000000200 RSI: 0000000000000004 RDI: ffff888128dc2050
RBP: 0000000000000039 R08: 0000000000000001 R09: ffffed10251b840a
R10: ffff888128dc204f R11: ffffed10251b8409 R12: ffff888116d78000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888128dc2000
FS:  0000000000000000(0000) GS:ffff88839d680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001620068 CR3: 0000000376c0e000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jbd2__journal_start+0x38a/0x790
 jbd2_journal_start+0x19/0x20
 flush_stashed_error_work+0x110/0x2b3
 process_one_work+0x688/0x1080
 worker_thread+0x8b/0xc50
 kthread+0x26f/0x310
 ret_from_fork+0x22/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

Above issue may happen as follows:
      umount            read procfs            error_work
ext4_put_super
  flush_work(&sbi->s_error_work);

                      ext4_mb_seq_groups_show
	                ext4_mb_load_buddy_gfp
			  ext4_mb_init_group
			    ext4_mb_init_cache
	                      ext4_read_block_bitmap_nowait
			        ext4_validate_block_bitmap
				  ext4_error
			            ext4_handle_error
			              schedule_work(&EXT4_SB(sb)->s_error_work);

  ext4_unregister_sysfs(sb);
  jbd2_journal_destroy(sbi->s_journal);
    journal_kill_thread
      journal->j_flags |= JBD2_UNMOUNT;

                                          flush_stashed_error_work
				            jbd2_journal_start
					      start_this_handle
					        BUG_ON(journal->j_flags & JBD2_UNMOUNT);

To solve this issue, we call 'ext4_unregister_sysfs' in 'ext4_put_super' firstly
like 'ext4_fill_super' error handle.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c..a673012e35c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1199,20 +1199,25 @@ static void ext4_put_super(struct super_block *sb)
 	int aborted = 0;
 	int i, err;
 
-	ext4_unregister_li_request(sb);
-	ext4_quota_off_umount(sb);
-
-	flush_work(&sbi->s_error_work);
-	destroy_workqueue(sbi->rsv_conversion_wq);
-	ext4_release_orphan_info(sb);
-
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
 	 * Since we could still access attr_journal_task attribute via sysfs
 	 * path which could have sbi->s_journal->j_task as NULL
+	 * Unregister sysfs before flush sbi->s_error_work.
+	 * Since user may read /proc/fs/ext4/xx/mb_groups during umount, If
+	 * read metadata verify failed then will queue error work.
+	 * flush_stashed_error_work will call start_this_handle may trigger
+	 * BUG_ON.
 	 */
 	ext4_unregister_sysfs(sb);
 
+	ext4_unregister_li_request(sb);
+	ext4_quota_off_umount(sb);
+
+	flush_work(&sbi->s_error_work);
+	destroy_workqueue(sbi->rsv_conversion_wq);
+	ext4_release_orphan_info(sb);
+
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
 		err = jbd2_journal_destroy(sbi->s_journal);
-- 
2.31.1

