Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9908C250392
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHXQqn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 12:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgHXQjS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Aug 2020 12:39:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D89022CBB;
        Mon, 24 Aug 2020 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287158;
        bh=52vBbmsBFLCXiruHnbKs1X3w4gPBnAULIjWYXi8ychI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxvcEHXPpREJGZ1W25Oh7g+v0WgCjIoI1XWB0eWUrFHWhjtA6rMdlRi7Tkx6/YZlf
         AMeJGT1seIa6B9HaRQqh1GrR26VR+7ZwDELgGkuEh5mxGVhsuH/jiW4VWFy2stv06V
         VjtaJ17/JkIE/nC7JFKzyNHVNWIVkVtwmK4jZV7w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/11] ext4: don't BUG on inconsistent journal feature
Date:   Mon, 24 Aug 2020 12:39:05 -0400
Message-Id: <20200824163914.607152-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163914.607152-1-sashal@kernel.org>
References: <20200824163914.607152-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 11215630aada28307ba555a43138db6ac54fa825 ]

A customer has reported a BUG_ON in ext4_clear_journal_err() hitting
during an LTP testing. Either this has been caused by a test setup
issue where the filesystem was being overwritten while LTP was mounting
it or the journal replay has overwritten the superblock with invalid
data. In either case it is preferable we don't take the machine down
with a BUG_ON. So handle the situation of unexpectedly missing
has_journal feature more gracefully. We issue warning and fail the mount
in the cases where the race window is narrow and the failed check is
most likely a programming error. In cases where fs corruption is more
likely, we do full ext4_error() handling before failing mount / remount.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200710140759.18031-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 68 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ffc985d781373..da0cb9a7d6fdc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -63,10 +63,10 @@ static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
 			     unsigned long journal_devnum);
 static int ext4_show_options(struct seq_file *seq, struct dentry *root);
 static int ext4_commit_super(struct super_block *sb, int sync);
-static void ext4_mark_recovery_complete(struct super_block *sb,
+static int ext4_mark_recovery_complete(struct super_block *sb,
 					struct ext4_super_block *es);
-static void ext4_clear_journal_err(struct super_block *sb,
-				   struct ext4_super_block *es);
+static int ext4_clear_journal_err(struct super_block *sb,
+				  struct ext4_super_block *es);
 static int ext4_sync_fs(struct super_block *sb, int wait);
 static int ext4_remount(struct super_block *sb, int *flags, char *data);
 static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
@@ -4458,7 +4458,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
 	if (needs_recovery) {
 		ext4_msg(sb, KERN_INFO, "recovery complete");
-		ext4_mark_recovery_complete(sb, es);
+		err = ext4_mark_recovery_complete(sb, es);
+		if (err)
+			goto failed_mount8;
 	}
 	if (EXT4_SB(sb)->s_journal) {
 		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
@@ -4501,10 +4503,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
 	goto failed_mount;
 
-#ifdef CONFIG_QUOTA
 failed_mount8:
 	ext4_unregister_sysfs(sb);
-#endif
 failed_mount7:
 	ext4_unregister_li_request(sb);
 failed_mount6:
@@ -4640,7 +4640,8 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 	struct inode *journal_inode;
 	journal_t *journal;
 
-	BUG_ON(!ext4_has_feature_journal(sb));
+	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
+		return NULL;
 
 	journal_inode = ext4_get_journal_inode(sb, journal_inum);
 	if (!journal_inode)
@@ -4670,7 +4671,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	struct ext4_super_block *es;
 	struct block_device *bdev;
 
-	BUG_ON(!ext4_has_feature_journal(sb));
+	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
+		return NULL;
 
 	bdev = ext4_blkdev_get(j_dev, sb);
 	if (bdev == NULL)
@@ -4762,7 +4764,8 @@ static int ext4_load_journal(struct super_block *sb,
 	int err = 0;
 	int really_read_only;
 
-	BUG_ON(!ext4_has_feature_journal(sb));
+	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
+		return -EFSCORRUPTED;
 
 	if (journal_devnum &&
 	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
@@ -4831,7 +4834,12 @@ static int ext4_load_journal(struct super_block *sb,
 	}
 
 	EXT4_SB(sb)->s_journal = journal;
-	ext4_clear_journal_err(sb, es);
+	err = ext4_clear_journal_err(sb, es);
+	if (err) {
+		EXT4_SB(sb)->s_journal = NULL;
+		jbd2_journal_destroy(journal);
+		return err;
+	}
 
 	if (!really_read_only && journal_devnum &&
 	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
@@ -4930,26 +4938,32 @@ static int ext4_commit_super(struct super_block *sb, int sync)
  * remounting) the filesystem readonly, then we will end up with a
  * consistent fs on disk.  Record that fact.
  */
-static void ext4_mark_recovery_complete(struct super_block *sb,
-					struct ext4_super_block *es)
+static int ext4_mark_recovery_complete(struct super_block *sb,
+				       struct ext4_super_block *es)
 {
+	int err;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 
 	if (!ext4_has_feature_journal(sb)) {
-		BUG_ON(journal != NULL);
-		return;
+		if (journal != NULL) {
+			ext4_error(sb, "Journal got removed while the fs was "
+				   "mounted!");
+			return -EFSCORRUPTED;
+		}
+		return 0;
 	}
 	jbd2_journal_lock_updates(journal);
-	if (jbd2_journal_flush(journal) < 0)
+	err = jbd2_journal_flush(journal);
+	if (err < 0)
 		goto out;
 
 	if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
 		ext4_clear_feature_journal_needs_recovery(sb);
 		ext4_commit_super(sb, 1);
 	}
-
 out:
 	jbd2_journal_unlock_updates(journal);
+	return err;
 }
 
 /*
@@ -4957,14 +4971,17 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
  * has recorded an error from a previous lifetime, move that error to the
  * main filesystem now.
  */
-static void ext4_clear_journal_err(struct super_block *sb,
+static int ext4_clear_journal_err(struct super_block *sb,
 				   struct ext4_super_block *es)
 {
 	journal_t *journal;
 	int j_errno;
 	const char *errstr;
 
-	BUG_ON(!ext4_has_feature_journal(sb));
+	if (!ext4_has_feature_journal(sb)) {
+		ext4_error(sb, "Journal got removed while the fs was mounted!");
+		return -EFSCORRUPTED;
+	}
 
 	journal = EXT4_SB(sb)->s_journal;
 
@@ -4989,6 +5006,7 @@ static void ext4_clear_journal_err(struct super_block *sb,
 		jbd2_journal_clear_err(journal);
 		jbd2_journal_update_sb_errno(journal);
 	}
+	return 0;
 }
 
 /*
@@ -5268,8 +5286,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			    (sbi->s_mount_state & EXT4_VALID_FS))
 				es->s_state = cpu_to_le16(sbi->s_mount_state);
 
-			if (sbi->s_journal)
+			if (sbi->s_journal) {
+				/*
+				 * We let remount-ro finish even if marking fs
+				 * as clean failed...
+				 */
 				ext4_mark_recovery_complete(sb, es);
+			}
 			if (sbi->s_mmp_tsk)
 				kthread_stop(sbi->s_mmp_tsk);
 		} else {
@@ -5317,8 +5340,11 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			 * been changed by e2fsck since we originally mounted
 			 * the partition.)
 			 */
-			if (sbi->s_journal)
-				ext4_clear_journal_err(sb, es);
+			if (sbi->s_journal) {
+				err = ext4_clear_journal_err(sb, es);
+				if (err)
+					goto restore_opts;
+			}
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
 			if (!ext4_setup_super(sb, es, 0))
 				sb->s_flags &= ~MS_RDONLY;
-- 
2.25.1

