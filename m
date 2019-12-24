Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D8129EDD
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXIPB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38757 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfLXIO6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so10419872pfc.5
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9+qc6TATkGgRUU22+j8/LExsEvEXijEeM/OF4F74js=;
        b=BQFpTdAq6/Us6RtGhIY0CH0D1uVUSiJZCYXvH10b6X/JpRc/+AYh89Fy5DuUA3C7zh
         D36TdyWyVeprDPNK/EIZnmIAATkTLybJi8h+yvIKKGOdES7yVh3c445gBfRt9JeNHn5x
         NoJ3uMHe/j0IsbcFLRtoliq10l1fD7RSYbOTBFsG4IC/pjNZkUfjlRecXNzeOOcyj2xD
         P2j+SR1vdOh+lEyHuo9R3Nu+YmxSJJjU6swSX3uPOvotgi3kzh0o06Lb115aPmCnr75H
         mqQD+sHdKBjY8XfS8dxdhfNCyowcS73zK6BSoJdH/8ddwq1XCkJxVroYXlVFpHtoOj2g
         NMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9+qc6TATkGgRUU22+j8/LExsEvEXijEeM/OF4F74js=;
        b=W6D3v3rY4X32tZgQoHWkywvbpgrhkX4e5RizQJw8vELO+QBOzr6yo9e7QzfdZstQMD
         O/CNjA8oMifaGgYSv9tXhWF1tYQ/ZrqzsYuGaNKJjOahVA6erEug5Yp+JYb+lApgbpmq
         t5kkFmOBgaMPpse4o3j0nZ2GbjVEWrXga+SBF2rzjY43eW64kYT5/zyYkEu6MwEm0olG
         /070JjuG7U6ZGZrz2eG0fBPXmePj65VnvCs0naTLRGU0xPbY04ZBL+PBcNqxGTz2SUF0
         3PIoMFrftjogXC92D7KqywIYhyE+th3U3IIjPIkKxZBX9uakCWJwBTJwXYTnQ7tT3zT1
         rSmg==
X-Gm-Message-State: APjAAAVElb7jP7hN0Z5cL1rk20ivZ4WcDNogeOazyade7t+D+VBm4Xh3
        SBPYLr0ZMm+1458qdagBHNJZ8aIr
X-Google-Smtp-Source: APXvYqwPi7NL27b34S6ciJkKk1SGdC+Tqczm6yt8ANwGSDCSJgP+Gto4JdMJ8AhUdEpAknwQBUMbdQ==
X-Received: by 2002:a63:4503:: with SMTP id s3mr35971341pga.311.1577175297118;
        Tue, 24 Dec 2019 00:14:57 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:56 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 11/20] ext4: add fast commit track points
Date:   Tue, 24 Dec 2019 00:13:15 -0800
Message-Id: <20191224081324.95807-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/ioctl.c     |  3 +++
 fs/ext4/namei.c     | 32 ++++++++++++++++++++++++++++++++
 fs/ext4/super.c     |  9 +++++++++
 fs/ext4/xattr.c     |  6 ++++++
 11 files changed, 99 insertions(+)

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
index 0b202e00d93f..14787065d030 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -654,6 +654,9 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 	ar.len = count ? *count : 1;
 	ar.flags = flags;
 
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_META_ALLOC);
+
 	ret = ext4_mb_new_blocks(handle, &ar, errp);
 	if (count)
 		*count = ar.len;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cc3a1489eae4..ede039a01bab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1436,6 +1436,31 @@ struct ext4_super_block {
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
@@ -1618,6 +1643,7 @@ struct ext4_sb_info {
 					 */
 	struct list_head s_fc_dentry_q;
 	spinlock_t s_fc_lock;
+	struct ext4_fc_stats s_fc_stats;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c27f9284064..9e060ba927c1 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -390,6 +390,8 @@ void ext4_fc_mark_ineligible(struct inode *inode, int reason)
 	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
+	WARN_ON(reason >= EXT4_FC_REASON_MAX);
+	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 	if (sbi->s_journal)
 		ei->i_fc_tid = get_running_txn_tid(inode->i_sb);
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_ELIGIBLE);
@@ -402,6 +404,8 @@ void ext4_fc_disable(struct super_block *sb, int reason)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	sbi->s_mount_state |= EXT4_FC_INELIGIBLE;
+	WARN_ON(reason >= EXT4_FC_REASON_MAX);
+	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
 
 /*
@@ -463,6 +467,7 @@ static int __ext4_dentry_update(struct inode *inode, void *arg, bool update)
 	write_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
+		ext4_fc_disable(inode->i_sb, EXT4_FC_REASON_MEM);
 		write_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fb0f99dc8c22..43119ad5970b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4832,6 +4832,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			ext4_set_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
 	}
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_track_inode(inode);
 
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
@@ -5563,6 +5564,8 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_FALLOC_RANGE_OP);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5677,6 +5680,8 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_FALLOC_RANGE_OP);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2fec62d764fa..b3a2439a272e 100644
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
@@ -1986,6 +1988,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 
 	if (err == 0) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
+		ext4_fc_track_inode(inode);
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 07c8da778368..2a61c3a31b74 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2948,6 +2948,7 @@ static int ext4_writepages(struct address_space *mapping,
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
+	ext4_fc_track_inode(inode);
 	percpu_up_read(&sbi->s_journal_flag_rwsem);
 	return ret;
 }
@@ -5572,6 +5573,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
 		error = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_track_inode(inode);
 		ext4_journal_stop(handle);
 	}
 
@@ -5690,6 +5692,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (!error) {
 		setattr_copy(inode, attr);
+		ext4_fc_track_inode(inode);
 		mark_inode_dirty(inode);
 	}
 
@@ -6102,6 +6105,7 @@ void ext4_dirty_inode(struct inode *inode, int flags)
 		goto out;
 
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_track_inode(inode);
 
 	ext4_journal_stop(handle);
 out:
@@ -6187,6 +6191,8 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
+	ext4_fc_mark_ineligible(inode,
+		EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0b7f316fd30f..2bc655b2164e 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -204,6 +204,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	ext4_discard_preallocations(inode);
 
+	if (EXT4_SB(sb)->s_journal)
+		ext4_fc_disable(sb, EXT4_FC_REASON_SWAP_BOOT);
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
 		/* No need to update quota information. */
@@ -1080,6 +1082,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_resize_fs(sb, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
+			ext4_fc_disable(sb, EXT4_FC_REASON_RESIZE);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a405564ae02f..b732c0bb1d51 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2595,6 +2595,8 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		err = ext4_add_nondir(handle, dentry, inode);
 		if (!err && IS_DIRSYNC(dir))
 			ext4_handle_sync(handle);
+		if (!err)
+			ext4_fc_track_create(inode, dentry);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -2627,6 +2629,9 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 		err = ext4_add_nondir(handle, dentry, inode);
 		if (!err && IS_DIRSYNC(dir))
 			ext4_handle_sync(handle);
+		if (!err)
+			ext4_fc_track_create(inode, dentry);
+
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -2661,6 +2666,8 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 		err = ext4_orphan_add(handle, inode);
 		if (err)
 			goto err_unlock_inode;
+
+		ext4_fc_track_inode(inode);
 		mark_inode_dirty(inode);
 		unlock_new_inode(inode);
 	}
@@ -2784,6 +2791,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		iput(inode);
 		goto out_stop;
 	}
+	ext4_fc_track_create(inode, dentry);
 	ext4_inc_count(handle, dir);
 	ext4_update_dx_flag(dir);
 	err = ext4_mark_inode_dirty(handle, dir);
@@ -3227,6 +3235,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry));
+	if (!retval)
+		ext4_fc_track_unlink(d_inode(dentry), dentry);
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3391,6 +3401,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
+		ext4_fc_track_link(inode, dentry);
 		ext4_mark_inode_dirty(handle, inode);
 		/* this can happen only for tmpfile being
 		 * linked the first time
@@ -3839,6 +3850,23 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
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
@@ -3975,7 +4003,11 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
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
index 538ee986d7f7..23a194d871c6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1330,6 +1330,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 		 * S_DAX may be disabled
 		 */
 		ext4_set_inode_flags(inode);
+		ext4_fc_track_inode(inode);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
 			EXT4_ERROR_INODE(inode, "Failed to mark inode dirty");
@@ -4337,6 +4338,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
 	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
 	spin_lock_init(&sbi->s_fc_lock);
+	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
+
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
@@ -5829,6 +5832,8 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		EXT4_I(inode)->i_flags |= EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL;
 		inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
 				S_NOATIME | S_IMMUTABLE);
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_QUOTA);
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 	unlock_inode:
@@ -5936,6 +5941,8 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_QUOTA);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
@@ -6042,6 +6049,8 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	if (inode->i_size < off + len) {
 		i_size_write(inode, off + len);
 		EXT4_I(inode)->i_disksize = inode->i_size;
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_QUOTA);
 		ext4_mark_inode_dirty(handle, inode);
 	}
 	return len;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..4f1744caf9f7 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2433,6 +2433,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
 	}
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_XATTR);
 
 cleanup:
 	brelse(is.iloc.bh);
@@ -2510,6 +2512,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (error == 0)
 			error = error2;
 	}
+	ext4_fc_mark_ineligible(inode,
+				EXT4_FC_REASON_XATTR);
 
 	return error;
 }
@@ -2942,6 +2946,8 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 					 error);
 			goto cleanup;
 		}
+		ext4_fc_mark_ineligible(inode,
+					EXT4_FC_REASON_XATTR);
 	}
 	error = 0;
 cleanup:
-- 
2.24.1.735.g03f4e72817-goog

