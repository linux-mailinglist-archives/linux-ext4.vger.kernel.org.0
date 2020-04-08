Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27941A2B85
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDHVz4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:56 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52787 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDHVzz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:55 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so402713pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywrQ3rmZNsHtpw6BLvpEJBkorcBqqE2Vs2YJycAZq3k=;
        b=Pw6EKq2juQKoGyrZ/obk+xlWVkOUTYfmTuJ1KgpuvJe2krcy6V7Ochaqd73F+LfVOH
         1uztOQz9SIcvSr2CDq28pr2OkOvDxY0QDDNJu52V3ZYm/VCSSWFP7l9aiT2E1ZPAu7bJ
         4CxM0lu4nWK8TtSUBxTXhBBE2rwafjIRqhfUAKz/pRvy881lJPqRcxrdnkTl5KbDtM31
         zO1E+66gMvqHxlDXX+vBzNBKLfOkE1PhdQTJvF5mLbPUqPpyaYe8qAups4lYgEF3V2ik
         oB7FDZQdKEp3N0P1JJNMMhmBhK6jh+MHuIwNV5oDYA6zDCbOJka/Gk7KNdrCAx5cKpoW
         bauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywrQ3rmZNsHtpw6BLvpEJBkorcBqqE2Vs2YJycAZq3k=;
        b=H7IBIg7NosaPIyoOax1O0GKXI2+pkV88dBSGbdSelSOiUX/df8VXNjIiOFBab3hrjp
         nGlIa/6+rC2ZxalrFVMw6+bVSxVytqzzzCa2VvKceR4DjuvnGY3fSgybGIZ8KOkGxwGD
         FuiwfIUCRnAiAIA8je+EWTeyuc+seV7q0xSC2sZoqs7WblNCF9ihR9W+Bcghht/fPtqK
         0kSUUzYrkv3hWhbnh8/PGTDwoQIBNpxKWh5uFDJmmHyxUsmQybjG/RL6IkmpUfuEdJtC
         j7GTu0YeyZAuBD9yJoEScen4LS+RnP53kTdSeV8AyRQPluBxKIpd9VZsi29rYfwfdFBd
         RBCw==
X-Gm-Message-State: AGi0PuZr29xBUKl6u3RRXDu1owzziWyhmzDGMeQ4+9e4zVcq2ikJuQLd
        NDpqcTOQp83FKii6tTsy5XSOskd5
X-Google-Smtp-Source: APiQypIF7Y59H2NjHiVmcR/oR9kAHWUP69/XCEcegzklOMjSq6vn8mjF5NYEIswMOyIxtG96krFR+g==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr9141820plp.44.1586382952477;
        Wed, 08 Apr 2020 14:55:52 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:52 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 11/20] ext4: add fast commit track points
Date:   Wed,  8 Apr 2020 14:55:21 -0700
Message-Id: <20200408215530.25649-11-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
index 0e0a4d6209c7..25960bb4fe69 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -664,6 +664,9 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 	ar.len = count ? *count : 1;
 	ar.flags = flags;
 
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_META_ALLOC);
+
 	ret = ext4_mb_new_blocks(handle, &ar, errp);
 	if (count)
 		*count = ar.len;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c39966facf86..922939320d02 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1439,6 +1439,31 @@ struct ext4_super_block {
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
@@ -1626,6 +1651,7 @@ struct ext4_sb_info {
 					 */
 	struct list_head s_fc_dentry_q;
 	spinlock_t s_fc_lock;
+	struct ext4_fc_stats s_fc_stats;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 9f12ae2fb3ab..4bef01f9814a 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -427,6 +427,8 @@ void ext4_fc_mark_ineligible(struct inode *inode, int reason)
 	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
+	WARN_ON(reason >= EXT4_FC_REASON_MAX);
+	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 	if (sbi->s_journal)
 		ei->i_fc_tid = get_running_txn_tid(inode->i_sb);
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
@@ -439,6 +441,8 @@ void ext4_fc_disable(struct super_block *sb, int reason)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	sbi->s_mount_state |= EXT4_FC_INELIGIBLE;
+	WARN_ON(reason >= EXT4_FC_REASON_MAX);
+	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
 
 /*
@@ -500,6 +504,7 @@ static int __ext4_dentry_update(struct inode *inode, void *arg, bool update)
 	write_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
+		ext4_fc_disable(inode->i_sb, EXT4_FC_REASON_MEM);
 		write_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 031752cfb6f7..b19f0e596503 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4578,6 +4578,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_track_inode(inode);
 
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
@@ -5273,6 +5274,8 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_FALLOC_RANGE_OP);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5383,6 +5386,8 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_FALLOC_RANGE_OP);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f35e289e17aa..4d48a6d985c8 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -759,6 +759,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 
 	ext4_write_unlock_xattr(inode, &no_expand);
 	brelse(iloc.bh);
+	ext4_fc_track_inode(inode);
 	mark_inode_dirty(inode);
 out:
 	return copied;
@@ -974,6 +975,7 @@ int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
+	ext4_fc_track_inode(inode);
 	mark_inode_dirty(inode);
 
 	return copied;
@@ -1946,6 +1948,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 
 	if (err == 0) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
+		ext4_fc_track_inode(inode);
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3bf0ad4d7d32..e5b45f32dd30 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2849,6 +2849,7 @@ static int ext4_writepages(struct address_space *mapping,
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
+	ext4_fc_track_inode(inode);
 	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
@@ -5295,6 +5296,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
 		error = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_track_inode(inode);
 		ext4_journal_stop(handle);
 	}
 
@@ -5413,6 +5415,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (!error) {
 		setattr_copy(inode, attr);
+		ext4_fc_track_inode(inode);
 		mark_inode_dirty(inode);
 	}
 
@@ -5843,6 +5846,7 @@ void ext4_dirty_inode(struct inode *inode, int flags)
 		goto out;
 
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_track_inode(inode);
 
 	ext4_journal_stop(handle);
 out:
@@ -5928,6 +5932,8 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
+	ext4_fc_mark_ineligible(inode,
+		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cb..f66bcf185f5b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -204,6 +204,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	ext4_discard_preallocations(inode);
 
+	if (EXT4_SB(sb)->s_journal)
+		ext4_fc_disable(sb, EXT4_FC_REASON_SWAP_BOOT);
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
 		/* No need to update quota information. */
@@ -385,6 +387,8 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	inode->i_ctime = current_time(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
+	ext4_fc_track_inode(inode);
+
 flags_err:
 	ext4_journal_stop(handle);
 	if (err)
@@ -1068,6 +1072,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_resize_fs(sb, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
+			ext4_fc_disable(sb, EXT4_FC_REASON_RESIZE);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 77fc136fe718..2d9c3767d8d6 100644
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
index 695bc43d5916..ea712c9cf77b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1381,6 +1381,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 		 * S_DAX may be disabled
 		 */
 		ext4_set_inode_flags(inode);
+		ext4_fc_track_inode(inode);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
 			EXT4_ERROR_INODE(inode, "Failed to mark inode dirty");
@@ -4424,6 +4425,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
 	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
 	spin_lock_init(&sbi->s_fc_lock);
+	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
+
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
@@ -5914,6 +5917,8 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		EXT4_I(inode)->i_flags |= EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL;
 		inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
 				S_NOATIME | S_IMMUTABLE);
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_QUOTA);
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 	unlock_inode:
@@ -6021,6 +6026,8 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_QUOTA);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
@@ -6127,6 +6134,8 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	if (inode->i_size < off + len) {
 		i_size_write(inode, off + len);
 		EXT4_I(inode)->i_disksize = inode->i_size;
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_QUOTA);
 		ext4_mark_inode_dirty(handle, inode);
 	}
 	return len;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 21df43a25328..5859d186796a 100644
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
2.26.0.110.g2183baf09c-goog

