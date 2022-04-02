Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F864EFFC9
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Apr 2022 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiDBIst (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Apr 2022 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348256AbiDBIss (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Apr 2022 04:48:48 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 01:46:54 PDT
Received: from forward103o.mail.yandex.net (forward103o.mail.yandex.net [37.140.190.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3DC1AAA45
        for <linux-ext4@vger.kernel.org>; Sat,  2 Apr 2022 01:46:53 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 404D510AA717;
        Sat,  2 Apr 2022 11:41:08 +0300 (MSK)
Received: from vla1-395bc165982e.qloud-c.yandex.net (vla1-395bc165982e.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:179c:0:640:395b:c165])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 3C57C13E80013;
        Sat,  2 Apr 2022 11:41:08 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla1-395bc165982e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id xwai8JkTCI-f7fGFsuD;
        Sat, 02 Apr 2022 11:41:08 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1648888868;
        bh=+FJK84ojG8N7iYdcOvuyVxtYWhfTV+y/OUWLbG99+Ag=;
        h=Date:Subject:Cc:To:From:Message-Id;
        b=fLId3tJPfgLlMu+1nna9gTlso/SDisNw3ZoaPL9AIeTkTYzFWoFWyT1dGrWz903IK
         zcP6z0nWIdj8GFAGrOJTUcbJr87R41SeZocI61AWRgjXZVyMxnySQC3luMHXAyvI/E
         0+0zWp3NBBtfM8XF+SS1uYHHVtfhu+5q3LI7rTes=
Authentication-Results: vla1-395bc165982e.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Hbwr6k3KsZ-f7Le7RDE;
        Sat, 02 Apr 2022 11:41:07 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   anserper@ya.ru
To:     linux-ext4@vger.kernel.org
Cc:     Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
Date:   Sat,  2 Apr 2022 11:40:23 +0300
Message-Id: <20220402084023.1841375-1-anserper@ya.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andrew Perepechko <andrew.perepechko@hpe.com>

When changing a large xattr value to a different large xattr value,
the old xattr inode is freed. Truncate during the final iput causes
current transaction restart. Eventually, parent inode bh is marked
dirty and kernel panic happens when jbd2 figures out that this bh
belongs to the committed transaction.

A possible fix is to call this final iput in a separate thread.
This way, setxattr transactions will never be split into two.
Since the setxattr code adds xattr inodes with nlink=0 into the
orphan list, old xattr inodes will be properly cleaned up in
any case.

Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>
HPE-bug-id: LUS-10534

Changes since v1:
- fixed a bug added during the porting
- fixed a workqueue related deadlock reported by Tetsuo Handa
---
 fs/ext4/ext4.h    |  7 +++++--
 fs/ext4/page-io.c |  2 +-
 fs/ext4/super.c   | 15 ++++++++-------
 fs/ext4/xattr.c   | 39 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3f87cca49f0c..52db5d6bae7f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1650,8 +1650,11 @@ struct ext4_sb_info {
 	struct flex_groups * __rcu *s_flex_groups;
 	ext4_group_t s_flex_groups_allocated;
 
-	/* workqueue for reserved extent conversions (buffered io) */
-	struct workqueue_struct *rsv_conversion_wq;
+	/*
+	 * workqueue for reserved extent conversions (buffered io)
+	 * and large ea inodes reclaim
+	 */
+	struct workqueue_struct *s_misc_wq;
 
 	/* timer for periodic error stats printing */
 	struct timer_list s_err_report;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 495ce59fb4ad..0142b88471ff 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -228,7 +228,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
 	WARN_ON(!io_end->handle && sbi->s_journal);
 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
-	wq = sbi->rsv_conversion_wq;
+	wq = sbi->s_misc_wq;
 	if (list_empty(&ei->i_rsv_conversion_list))
 		queue_work(wq, &ei->i_rsv_conversion_work);
 	list_add_tail(&io_end->list, &ei->i_rsv_conversion_list);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c..ee03f593b264 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1200,10 +1200,11 @@ static void ext4_put_super(struct super_block *sb)
 	int i, err;
 
 	ext4_unregister_li_request(sb);
+	flush_workqueue(sbi->s_misc_wq);
 	ext4_quota_off_umount(sb);
 
 	flush_work(&sbi->s_error_work);
-	destroy_workqueue(sbi->rsv_conversion_wq);
+	destroy_workqueue(sbi->s_misc_wq);
 	ext4_release_orphan_info(sb);
 
 	/*
@@ -5294,9 +5295,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * The maximum number of concurrent works can be high and
 	 * concurrency isn't really necessary.  Limit it to 1.
 	 */
-	EXT4_SB(sb)->rsv_conversion_wq =
-		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
-	if (!EXT4_SB(sb)->rsv_conversion_wq) {
+	EXT4_SB(sb)->s_misc_wq =
+		alloc_workqueue("ext4-misc", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!EXT4_SB(sb)->s_misc_wq) {
 		printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
 		ret = -ENOMEM;
 		goto failed_mount4;
@@ -5514,8 +5515,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_root = NULL;
 failed_mount4:
 	ext4_msg(sb, KERN_ERR, "mount failed");
-	if (EXT4_SB(sb)->rsv_conversion_wq)
-		destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
+	if (EXT4_SB(sb)->s_misc_wq)
+		destroy_workqueue(EXT4_SB(sb)->s_misc_wq);
 failed_mount_wq:
 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
 	sbi->s_ea_inode_cache = NULL;
@@ -6129,7 +6130,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	trace_ext4_sync_fs(sb, wait);
-	flush_workqueue(sbi->rsv_conversion_wq);
+	flush_workqueue(sbi->s_misc_wq);
 	/*
 	 * Writeback quota in non-journalled quota case - journalled quota has
 	 * no dirty dquots
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 042325349098..ee13675fbead 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1544,6 +1544,36 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 	return 0;
 }
 
+struct delayed_iput_work {
+	struct work_struct work;
+	struct inode *inode;
+};
+
+static void delayed_iput_fn(struct work_struct *work)
+{
+	struct delayed_iput_work *diwork;
+
+	diwork = container_of(work, struct delayed_iput_work, work);
+	iput(diwork->inode);
+	kfree(diwork);
+}
+
+static void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
+{
+	if (!inode) {
+		kfree(work);
+		return;
+	}
+
+	if (!work) {
+		iput(inode);
+	} else {
+		INIT_WORK(&work->work, delayed_iput_fn);
+		work->inode = inode;
+		queue_work(EXT4_SB(inode->i_sb)->s_misc_wq, &work->work);
+	}
+}
+
 /*
  * Reserve min(block_size/8, 1024) bytes for xattr entries/names if ea_inode
  * feature is enabled.
@@ -1561,6 +1591,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
 	struct inode *new_ea_inode = NULL;
+	struct delayed_iput_work *diwork = NULL;
 	size_t old_size, new_size;
 	int ret;
 
@@ -1637,7 +1668,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	 * Finish that work before doing any modifications to the xattr data.
 	 */
 	if (!s->not_found && here->e_value_inum) {
-		ret = ext4_xattr_inode_iget(inode,
+		diwork = kmalloc(sizeof(*diwork), GFP_NOFS);
+		if (!diwork)
+			ret = -ENOMEM;
+		else
+			ret = ext4_xattr_inode_iget(inode,
 					    le32_to_cpu(here->e_value_inum),
 					    le32_to_cpu(here->e_hash),
 					    &old_ea_inode);
@@ -1790,7 +1825,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 
 	ret = 0;
 out:
-	iput(old_ea_inode);
+	delayed_iput(old_ea_inode, diwork);
 	iput(new_ea_inode);
 	return ret;
 }
-- 
2.25.1

