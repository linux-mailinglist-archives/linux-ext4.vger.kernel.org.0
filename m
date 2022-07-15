Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50025761FC
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiGOMj4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiGOMjr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 08:39:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201758734E;
        Fri, 15 Jul 2022 05:39:44 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LkrSF56qHzVft5;
        Fri, 15 Jul 2022 20:35:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 20:39:33 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Jul
 2022 20:39:32 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>, <ritesh.list@gmail.com>,
        <lczerner@redhat.com>, <akpm@osdl.org>, <shaggy@austin.ibm.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] jbd2: Fix assertion 'jh->b_frozen_data == NULL' failure when journal aborted
Date:   Fri, 15 Jul 2022 20:51:52 +0800
Message-ID: <20220715125152.4022726-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following process will fail assertion 'jh->b_frozen_data == NULL' in
jbd2_journal_dirty_metadata():

                   jbd2_journal_commit_transaction
unlink(dir/a)
 jh->b_transaction = trans1
 jh->b_jlist = BJ_Metadata
                    journal->j_running_transaction = NULL
                    trans1->t_state = T_COMMIT
unlink(dir/b)
 handle->h_trans = trans2
 do_get_write_access
  jh->b_modified = 0
  jh->b_frozen_data = frozen_buffer
  jh->b_next_transaction = trans2
 jbd2_journal_dirty_metadata
  is_handle_aborted
   is_journal_aborted // return false

           --> jbd2 abort <--

                     while (commit_transaction->t_buffers)
                      if (is_journal_aborted)
                       jbd2_journal_refile_buffer
                        __jbd2_journal_refile_buffer
                         WRITE_ONCE(jh->b_transaction,
						jh->b_next_transaction)
                         WRITE_ONCE(jh->b_next_transaction, NULL)
                         __jbd2_journal_file_buffer(jh, BJ_Reserved)
        J_ASSERT_JH(jh, jh->b_frozen_data == NULL) // assertion failure !

The reproducer (See detail in [Link]) reports:
 ------------[ cut here ]------------
 kernel BUG at fs/jbd2/transaction.c:1629!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 2 PID: 584 Comm: unlink Tainted: G        W
 5.19.0-rc6-00115-g4a57a8400075-dirty #697
 RIP: 0010:jbd2_journal_dirty_metadata+0x3c5/0x470
 RSP: 0018:ffffc90000be7ce0 EFLAGS: 00010202
 Call Trace:
  <TASK>
  __ext4_handle_dirty_metadata+0xa0/0x290
  ext4_handle_dirty_dirblock+0x10c/0x1d0
  ext4_delete_entry+0x104/0x200
  __ext4_unlink+0x22b/0x360
  ext4_unlink+0x275/0x390
  vfs_unlink+0x20b/0x4c0
  do_unlinkat+0x42f/0x4c0
  __x64_sys_unlink+0x37/0x50
  do_syscall_64+0x35/0x80

After journal aborting, __jbd2_journal_refile_buffer() is executed with
holding @jh->b_state_lock, we can fix it by moving 'is_handle_aborted()'
into the area protected by @jh->b_state_lock.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216251
Fixes: 470decc613ab20 ("[PATCH] jbd2: initial copy of files from jbd")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/transaction.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e9c308ae475f..e0377f558eb1 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1486,8 +1486,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	struct journal_head *jh;
 	int ret = 0;
 
-	if (is_handle_aborted(handle))
-		return -EROFS;
 	if (!buffer_jbd(bh))
 		return -EUCLEAN;
 
@@ -1534,6 +1532,18 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	journal = transaction->t_journal;
 	spin_lock(&jh->b_state_lock);
 
+	if (is_handle_aborted(handle)) {
+		/*
+		 * Check journal aborting with @jh->b_state_lock locked,
+		 * since 'jh->b_transaction' could be replaced with
+		 * 'jh->b_next_transaction' during old transaction
+		 * committing if journal aborted, which may fail
+		 * assertion on 'jh->b_frozen_data == NULL'.
+		 */
+		ret = -EROFS;
+		goto out_unlock_bh;
+	}
+
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
-- 
2.31.1

