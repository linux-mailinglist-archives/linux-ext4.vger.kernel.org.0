Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA392C63F4
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgK0LeL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:51620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgK0LeK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58FC1ADCD;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC8341E1328; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/12] ext4: Drop sync argument of ext4_commit_super()
Date:   Fri, 27 Nov 2020 12:34:02 +0100
Message-Id: <20201127113405.26867-10-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Everybody passes 1 as sync argument of ext4_commit_super(). Just drop
it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 73a09b73fc11..aae12ea1466a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -65,7 +65,7 @@ static struct ratelimit_state ext4_mount_msg_ratelimit;
 static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
 			     unsigned long journal_devnum);
 static int ext4_show_options(struct seq_file *seq, struct dentry *root);
-static int ext4_commit_super(struct super_block *sb, int sync);
+static int ext4_commit_super(struct super_block *sb);
 static int ext4_mark_recovery_complete(struct super_block *sb,
 					struct ext4_super_block *es);
 static int ext4_clear_journal_err(struct super_block *sb,
@@ -621,7 +621,7 @@ static void save_error_info(struct super_block *sb, int error,
 {
 	__save_error_info(sb, error, ino, block, func, line);
 	if (!bdev_read_only(sb->s_bdev))
-		ext4_commit_super(sb, 1);
+		ext4_commit_super(sb);
 }
 
 /* Deal with the reporting of failure conditions on a filesystem such as
@@ -686,7 +686,7 @@ static void flush_stashed_error_work(struct work_struct *work)
 	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
 						s_error_work);
 
-	ext4_commit_super(sbi->s_sb, 1);
+	ext4_commit_super(sbi->s_sb);
 }
 
 #define ext4_error_ratelimit(sb)					\
@@ -1151,7 +1151,7 @@ static void ext4_put_super(struct super_block *sb)
 		es->s_state = cpu_to_le16(sbi->s_mount_state);
 	}
 	if (!sb_rdonly(sb))
-		ext4_commit_super(sb, 1);
+		ext4_commit_super(sb);
 
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
@@ -2641,7 +2641,7 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 	if (sbi->s_journal)
 		ext4_set_feature_journal_needs_recovery(sb);
 
-	err = ext4_commit_super(sb, 1);
+	err = ext4_commit_super(sb);
 done:
 	if (test_opt(sb, DEBUG))
 		printk(KERN_INFO "[EXT4 FS bs=%lu, gc=%u, "
@@ -4862,7 +4862,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
 	    !ext4_has_feature_encrypt(sb)) {
 		ext4_set_feature_encrypt(sb);
-		ext4_commit_super(sb, 1);
+		ext4_commit_super(sb);
 	}
 
 	/*
@@ -5415,7 +5415,7 @@ static int ext4_load_journal(struct super_block *sb,
 		es->s_journal_dev = cpu_to_le32(journal_devnum);
 
 		/* Make sure we flush the recovery flag to disk. */
-		ext4_commit_super(sb, 1);
+		ext4_commit_super(sb);
 	}
 
 	return 0;
@@ -5425,7 +5425,7 @@ static int ext4_load_journal(struct super_block *sb,
 	return err;
 }
 
-static int ext4_commit_super(struct super_block *sb, int sync)
+static int ext4_commit_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
@@ -5502,8 +5502,7 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 
 	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
-	if (sync)
-		lock_buffer(sbh);
+	lock_buffer(sbh);
 	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
@@ -5519,16 +5518,14 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 		set_buffer_uptodate(sbh);
 	}
 	mark_buffer_dirty(sbh);
-	if (sync) {
-		unlock_buffer(sbh);
-		error = __sync_dirty_buffer(sbh,
-			REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
-		if (buffer_write_io_error(sbh)) {
-			ext4_msg(sb, KERN_ERR, "I/O error while writing "
-			       "superblock");
-			clear_buffer_write_io_error(sbh);
-			set_buffer_uptodate(sbh);
-		}
+	unlock_buffer(sbh);
+	error = __sync_dirty_buffer(sbh,
+		REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
+	if (buffer_write_io_error(sbh)) {
+		ext4_msg(sb, KERN_ERR, "I/O error while writing "
+		       "superblock");
+		clear_buffer_write_io_error(sbh);
+		set_buffer_uptodate(sbh);
 	}
 	return error;
 }
@@ -5559,7 +5556,7 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
 
 	if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
 		ext4_clear_feature_journal_needs_recovery(sb);
-		ext4_commit_super(sb, 1);
+		ext4_commit_super(sb);
 	}
 out:
 	jbd2_journal_unlock_updates(journal);
@@ -5601,7 +5598,7 @@ static int ext4_clear_journal_err(struct super_block *sb,
 
 		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
-		ext4_commit_super(sb, 1);
+		ext4_commit_super(sb);
 
 		jbd2_journal_clear_err(journal);
 		jbd2_journal_update_sb_errno(journal);
@@ -5703,7 +5700,7 @@ static int ext4_freeze(struct super_block *sb)
 		ext4_clear_feature_journal_needs_recovery(sb);
 	}
 
-	error = ext4_commit_super(sb, 1);
+	error = ext4_commit_super(sb);
 out:
 	if (journal)
 		/* we rely on upper layer to stop further updates */
@@ -5725,7 +5722,7 @@ static int ext4_unfreeze(struct super_block *sb)
 		ext4_set_feature_journal_needs_recovery(sb);
 	}
 
-	ext4_commit_super(sb, 1);
+	ext4_commit_super(sb);
 	return 0;
 }
 
@@ -5985,7 +5982,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
-		err = ext4_commit_super(sb, 1);
+		err = ext4_commit_super(sb);
 		if (err)
 			goto restore_opts;
 	}
-- 
2.16.4

