Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8117D98D
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCIHGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCIHGF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id l184so4398024pfl.7
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGeuboarg/b/hh3H1Km6hP6WuHXoGIfo7icoOoDDLMI=;
        b=Jq1UfLa/I8F9b1sKUTBUkS+qHqEvZ82LQjDeFJKtS4vTh95kJHNp/u7x4ph25n03Rz
         MIeplYAWgc/bH65ln7ztGelNfHEOUMwoATVhNNiQEzzanD7qVyOmmAeXo/CDD09hBoeo
         5/c053Topy4lnrc0uU6m0uw6Kp/7O3s3SaAYobL8kgH1D2JEUHCNAgsuGNP9IYr0GPXF
         nQt/EzuKYhynrgCPDYFvAW09v8HxAT36SeOz+gvmj1AY3qegyuSbbDrHsaYnfx3pOoGS
         OLKdBV7gBuFE9/d6X9R8s1PaOvp+NXuUXe3dKEY29Xu4PU8YY2GLwWo3FGJBnNzVcEWh
         PjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGeuboarg/b/hh3H1Km6hP6WuHXoGIfo7icoOoDDLMI=;
        b=Pj6tplWFgsVgyWMnWWNTZT3bOW3Vl0DbvAQxfwIod/I0nukUJ0svYd0HBnAv3IFvuK
         Zodby/eQiz5qb6MEwwU+IsdzcsRh4sj4tWiyh0ExK+0VivpmOGzNzm3bVxTSTLRE2eol
         6adjC4wJ6dCWokZqzDIUuYnx+mCnBhqWMhaAIY2RlgLjm8w7MKpMgLSmwxjte1i/7j/a
         TxteQVgK/hOutpEreIl4sqKF1A/ft21IHLB9pfio4i0AhxgVX5NV7U/d2+Xg47Iq0G8N
         EmGQYufScLY5vQXPRmsQN7ALjnSet/YbfhB26AJE+Ou45Ikyjml84PUDIJi2Yqq61ulP
         2bVw==
X-Gm-Message-State: ANhLgQ3h4eqkKeaT6uYIvR44W8xPlWi9LCUqAp3hZUITFR7dbZD9dOdo
        AvVfdlWWJjn9vDRA3ETi/TAC8Ktz
X-Google-Smtp-Source: ADFU+vvrWfsExvmbWRUmyxNl/fxTI8Bjs0cnkW5ThnZQ7lhVB+/C1hNAnn6HLkS2rAsyG+rSSk8bpw==
X-Received: by 2002:a63:7508:: with SMTP id q8mr13458367pgc.300.1583737563921;
        Mon, 09 Mar 2020 00:06:03 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:03 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 11/20] ext4: add fast commit track points
Date:   Mon,  9 Mar 2020 00:05:17 -0700
Message-Id: <20200309070526.218202-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previous patches in the series have added following tracking routines:

- ext4_fc_track_inode() -> tracks just the inode
- ext4_fc_track_create() -> tracks creation of an inode and remembers
                            its dirent
- ext4_fc_track_unlink() -> tracks inode unlink
- ext4_fc_track_link() -> tracks inode link
- ext4_fc_mark_ineligible() -> marks inode as ineligible for fast
                               commits
- ext4_fc_disable() -> marks entire file system as fast commit
                       ineligible

Add these different track points at various points in the file
system. This patch also adds high level stats to remember reasons why
inodes were marked ineligible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/acl.c       |  1 +
 fs/ext4/balloc.c    |  3 +++
 fs/ext4/ext4.h      | 26 ++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.c |  5 +++++
 fs/ext4/extents.c   |  5 +++++
 fs/ext4/inline.c    |  3 +++
 fs/ext4/inode.c     |  6 ++++++
 fs/ext4/ioctl.c     |  5 +++++
 fs/ext4/namei.c     | 41 +++++++++++++++++++++++++++++++++++++++--
 fs/ext4/super.c     |  9 +++++++++
 fs/ext4/xattr.c     |  6 ++++++
 11 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 8c7bbf3e566d..28e9e04a8e96 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -257,6 +257,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		inode->i_mode = mode;
 		inode->i_ctime = current_time(inode);
 		ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_track_inode(inode);
 	}
 out_stop:
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8fd0b3cdab4c..c3c4e7fc5c6b 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -665,6 +665,9 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 	ar.len = count ? *count : 1;
 	ar.flags = flags;
 
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_META_ALLOC);
+
 	ret = ext4_mb_new_blocks(handle, &ar, errp);
 	if (count)
 		*count = ar.len;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6cc3a93b0ce0..57ccc26012f0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1440,6 +1440,31 @@ struct ext4_super_block {
 #define ext4_has_strict_mode(sbi) \
 	(sbi->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL)
 
+/*
+ * Fast commit ineligible reasons.
+ */
+enum {
+	EXT4_FC_REASON_META_ALLOC,
+	EXT4_FC_REASON_QUOTA,
+	EXT4_FC_REASON_XATTR,
+	EXT4_FC_REASON_CROSS_RENAME,
+	EXT4_FC_REASON_FALLOC_RANGE_OP,
+	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
+	EXT4_FC_REASON_DELETE,
+	EXT4_FC_REASON_MEM,
+	EXT4_FC_REASON_SWAP_BOOT,
+	EXT4_FC_REASON_RESIZE,
+	EXT4_FC_REASON_RENAME_DIR,
+	EXT4_FC_REASON_MAX
+};
+
+struct ext4_fc_stats {
+	int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
+	int fc_num_commits;
+	int fc_ineligible_commits;
+	int fc_numblks;
+};
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1627,6 +1652,7 @@ struct ext4_sb_info {
 					 */
 	struct list_head s_fc_dentry_q;
 	spinlock_t s_fc_lock;
+	struct ext4_fc_stats s_fc_stats;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 793b6c0fc2fa..a29ae83df881 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -431,6 +431,8 @@ void ext4_fc_mark_ineligible(struct inode *inode, int reason)
 	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
+	WARN_ON(reason >= EXT4_FC_REASON_MAX);
+	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 	if (sbi->s_journal)
 		ei->i_fc_tid = get_running_txn_tid(inode->i_sb);
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
@@ -443,6 +445,8 @@ void ext4_fc_disable(struct super_block *sb, int reason)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	sbi->s_mount_state |= EXT4_FC_INELIGIBLE;
+	WARN_ON(reason >= EXT4_FC_REASON_MAX);
+	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
 
 /*
@@ -504,6 +508,7 @@ static int __ext4_dentry_update(struct inode *inode, void *arg, bool update)
 	write_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
+		ext4_fc_disable(inode->i_sb, EXT4_FC_REASON_MEM);
 		write_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 954013d6076b..76538ca1d903 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4813,6 +4813,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			ext4_set_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
 	}
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_track_inode(inode);
 
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
@@ -5551,6 +5552,8 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_FALLOC_RANGE_OP);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5661,6 +5664,8 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_FALLOC_RANGE_OP);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index fad82d08fca5..42c8ab5e536d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -760,6 +760,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 
 	ext4_write_unlock_xattr(inode, &no_expand);
 	brelse(iloc.bh);
+	ext4_fc_track_inode(inode);
 	mark_inode_dirty(inode);
 out:
 	return copied;
@@ -975,6 +976,7 @@ int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
+	ext4_fc_track_inode(inode);
 	mark_inode_dirty(inode);
 
 	return copied;
@@ -1988,6 +1990,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 
 	if (err == 0) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
+		ext4_fc_track_inode(inode);
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 531aac4ec540..5720a12d7371 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2851,6 +2851,7 @@ static int ext4_writepages(struct address_space *mapping,
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
+	ext4_fc_track_inode(inode);
 	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
@@ -5282,6 +5283,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
 		error = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_track_inode(inode);
 		ext4_journal_stop(handle);
 	}
 
@@ -5400,6 +5402,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (!error) {
 		setattr_copy(inode, attr);
+		ext4_fc_track_inode(inode);
 		mark_inode_dirty(inode);
 	}
 
@@ -5830,6 +5833,7 @@ void ext4_dirty_inode(struct inode *inode, int flags)
 		goto out;
 
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_track_inode(inode);
 
 	ext4_journal_stop(handle);
 out:
@@ -5915,6 +5919,8 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
+	ext4_fc_mark_ineligible(inode,
+		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a0ec750018dd..3ea66e929afe 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -204,6 +204,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	ext4_discard_preallocations(inode);
 
+	if (EXT4_SB(sb)->s_journal)
+		ext4_fc_disable(sb, EXT4_FC_REASON_SWAP_BOOT);
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
 		/* No need to update quota information. */
@@ -397,6 +399,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	inode->i_ctime = current_time(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
+	ext4_fc_track_inode(inode);
+
 flags_err:
 	ext4_journal_stop(handle);
 	if (err)
@@ -1080,6 +1084,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_resize_fs(sb, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
+			ext4_fc_disable(sb, EXT4_FC_REASON_RESIZE);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5ee002cc0acd..ae0e112c65d5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2601,7 +2601,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		       bool excl)
 {
 	handle_t *handle;
-	struct inode *inode;
+	struct inode *inode, *inode_save;
 	int err, credits, retries = 0;
 
 	err = dquot_initialize(dir);
@@ -2619,7 +2619,11 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
+		inode_save = inode;
+		ihold(inode_save);
 		err = ext4_add_nondir(handle, dentry, &inode);
+		ext4_fc_track_create(inode_save, dentry);
+		iput(inode_save);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -2634,7 +2638,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 		      umode_t mode, dev_t rdev)
 {
 	handle_t *handle;
-	struct inode *inode;
+	struct inode *inode, *inode_save;
 	int err, credits, retries = 0;
 
 	err = dquot_initialize(dir);
@@ -2651,12 +2655,18 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
 		inode->i_op = &ext4_special_inode_operations;
+		inode_save = inode;
+		ihold(inode_save);
 		err = ext4_add_nondir(handle, dentry, &inode);
+		if (!err)
+			ext4_fc_track_create(inode_save, dentry);
+		iput(inode_save);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
 	if (!IS_ERR_OR_NULL(inode))
 		iput(inode);
+
 	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
 		goto retry;
 	return err;
@@ -2688,6 +2698,8 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 		err = ext4_orphan_add(handle, inode);
 		if (err)
 			goto err_unlock_inode;
+
+		ext4_fc_track_inode(inode);
 		mark_inode_dirty(inode);
 		unlock_new_inode(inode);
 	}
@@ -2813,6 +2825,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		iput(inode);
 		goto out_retry;
 	}
+	ext4_fc_track_create(inode, dentry);
 	ext4_inc_count(handle, dir);
 	ext4_update_dx_flag(dir);
 	err = ext4_mark_inode_dirty(handle, dir);
@@ -3261,6 +3274,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry));
+	if (!retval)
+		ext4_fc_track_unlink(d_inode(dentry), dentry);
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3424,6 +3439,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
+		ext4_fc_track_link(inode, dentry);
 		ext4_mark_inode_dirty(handle, inode);
 		/* this can happen only for tmpfile being
 		 * linked the first time
@@ -3872,6 +3888,23 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			ext4_mark_inode_dirty(handle, new.dir);
 		}
 	}
+
+	if (S_ISDIR(old.inode->i_mode)) {
+		/*
+		 * We disable fast commits here that's because the
+		 * replay code is not yet capable of changing dot dot
+		 * dirents in directories. Since this is a metadata
+		 * update that's ineligible, we need to mark entire fs
+		 * as ineligbile.
+		 */
+		ext4_fc_disable(old.inode->i_sb, EXT4_FC_REASON_RENAME_DIR);
+	} else {
+		if (new.inode)
+			ext4_fc_track_unlink(new.inode, new.dentry);
+		ext4_fc_track_link(old.inode, new.dentry);
+		ext4_fc_track_unlink(old.inode, old.dentry);
+	}
+
 	ext4_mark_inode_dirty(handle, old.dir);
 	if (new.inode) {
 		ext4_mark_inode_dirty(handle, new.inode);
@@ -4008,7 +4041,11 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	ctime = current_time(old.inode);
 	old.inode->i_ctime = ctime;
 	new.inode->i_ctime = ctime;
+	ext4_fc_mark_ineligible(old.inode,
+				EXT4_FC_REASON_CROSS_RENAME);
 	ext4_mark_inode_dirty(handle, old.inode);
+	ext4_fc_mark_ineligible(new.inode,
+				EXT4_FC_REASON_CROSS_RENAME);
 	ext4_mark_inode_dirty(handle, new.inode);
 
 	if (old.dir_bh) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7b30f90ec2b7..a484520e83d5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1384,6 +1384,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 		 * S_DAX may be disabled
 		 */
 		ext4_set_inode_flags(inode);
+		ext4_fc_track_inode(inode);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
 			EXT4_ERROR_INODE(inode, "Failed to mark inode dirty");
@@ -4415,6 +4416,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
 	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
 	spin_lock_init(&sbi->s_fc_lock);
+	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
+
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
@@ -5910,6 +5913,8 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		EXT4_I(inode)->i_flags |= EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL;
 		inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
 				S_NOATIME | S_IMMUTABLE);
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_QUOTA);
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 	unlock_inode:
@@ -6017,6 +6022,8 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_QUOTA);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
@@ -6123,6 +6130,8 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	if (inode->i_size < off + len) {
 		i_size_write(inode, off + len);
 		EXT4_I(inode)->i_disksize = inode->i_size;
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_QUOTA);
 		ext4_mark_inode_dirty(handle, inode);
 	}
 	return len;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8cac7d95c3ad..c090ac12aa93 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2413,6 +2413,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
 	}
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_XATTR);
 
 cleanup:
 	brelse(is.iloc.bh);
@@ -2490,6 +2492,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (error == 0)
 			error = error2;
 	}
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_XATTR);
 
 	return error;
 }
@@ -2922,6 +2926,8 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 					 error);
 			goto cleanup;
 		}
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_XATTR);
 	}
 	error = 0;
 cleanup:
-- 
2.25.1.481.gfbce0eb801-goog

