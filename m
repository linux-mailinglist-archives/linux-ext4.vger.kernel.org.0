Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADE2A8DD6
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKFD73 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD72 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:28 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA320C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 72so95793pfv.7
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoMrL3xjs0iWU5tSplC8CchjMHLt2heZAi93JuRduFo=;
        b=GdQNf6OgY6JffnhSqnNp+MuDylk/CSXoGmjmzb5bfqCxCeHXVB6y2VuNA7CEoH1Kg7
         ekHcyZ22sOpg8I9/2+9rzWlNrwkLGROcJyz7bcQP4cvUlM0e4LFGn2z9FsRDxZGKkR1c
         WqzK2+Za6tfWkKYe5Z5/AzWzw1cq/Xq+YQrCEvAwD4/I70agX+oLIeqMUJI1aKxOIxz9
         TYuh/HsFV3j8we41ED7OkxZAhrmrcjIJvj6ytSuT8+BtgocDvDHgLysTieT1xz8m6/vS
         NTyHefyQfnLJ2Nm47OL4deToVXSJN4SnAq3Zri0cSHmucxV5K1MIRSDLxlbNdRP5QrpT
         +IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoMrL3xjs0iWU5tSplC8CchjMHLt2heZAi93JuRduFo=;
        b=qMQ4XKO/KMse6iPteyEM7qTqe5jzwxbtm1Oavl96AnhPsn+323S5/b5hpDrY8q9lB4
         Z9El6SsnZj9JfVU1caI+RXRlAe5VgtAJ3yhw5P+TfoylsAyG1UDY/a05PqhM0PJhjxFZ
         F9Br3m67xpA+XQYEbjxalzqf5eKMiaBja57eYYVZ3Ic6fD6vexdVx0+Fv1gI3qEF90wL
         ljmykrFhn7f3bMNeT+A6Qk0M0hj64tdNbWPfgQ0IbCaJ23ewlQ/H4sTPFj2zx1yoRKsJ
         OeOM/DeRa8rchWbITfdJta7fR7tZ2b936XvQ4/g1zOUbqQP59FzHBqQegJDgqNb401ki
         LXuQ==
X-Gm-Message-State: AOAM532eqGdOJC968WedaTvxwkXuainEdfkizvMOC6vBmooV9yEfj/Si
        G34m+R2lq3Pf2Yb9aNQAfcr6DIfFveg=
X-Google-Smtp-Source: ABdhPJw8BOszLextwHj7M3iL8haHayzt59ufTuWUBojkKjXoUqYEJh1l3PQLYNMCR2MgCae5TCBrHw==
X-Received: by 2002:a62:32c5:0:b029:158:7361:58d3 with SMTP id y188-20020a6232c50000b0290158736158d3mr179516pfy.75.1604635167477;
        Thu, 05 Nov 2020 19:59:27 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:26 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 04/22] ext4: fixup ext4_fc_track_* functions' signature
Date:   Thu,  5 Nov 2020 19:58:53 -0800
Message-Id: <20201106035911.1942128-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Firstly, pass handle to all ext4_fc_track_* functions and use
transaction id found in handle->h_transaction->h_tid for tracking fast
commit updates. Secondly, don't pass inode to
ext4_fc_track_link/create/unlink functions. inode can be found inside
these functions as d_inode(dentry). However, rename path is an
exeception. That's because in that case, we need inode that's not same
as d_inode(dentry). To handle that, add a couple of low-level wrapper
functions that take inode and dentry as arguments.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        | 16 +++++++-----
 fs/ext4/extents.c     |  2 +-
 fs/ext4/fast_commit.c | 48 +++++++++++++++++++++-------------
 fs/ext4/inode.c       | 10 +++----
 fs/ext4/namei.c       | 61 ++++++++++++++++++++-----------------------
 5 files changed, 74 insertions(+), 63 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 12673f9ec880..23f8edd4fb2a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2750,12 +2750,16 @@ extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
 int ext4_fc_info_show(struct seq_file *seq, void *v);
 void ext4_fc_init(struct super_block *sb, journal_t *journal);
 void ext4_fc_init_inode(struct inode *inode);
-void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end);
-void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
-void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
-void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
-void ext4_fc_track_inode(struct inode *inode);
+void __ext4_fc_track_unlink(handle_t *handle, struct inode *inode,
+	struct dentry *dentry);
+void __ext4_fc_track_link(handle_t *handle, struct inode *inode,
+	struct dentry *dentry);
+void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry);
+void ext4_fc_track_link(handle_t *handle, struct dentry *dentry);
+void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
+void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
 void ext4_fc_start_ineligible(struct super_block *sb, int reason);
 void ext4_fc_stop_ineligible(struct super_block *sb);
@@ -3471,7 +3475,7 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 extern int ext4_ci_compare(const struct inode *parent,
 			   const struct qstr *fname,
 			   const struct qstr *entry, bool quick);
-extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+extern int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
 			 struct inode *inode);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
 		       struct dentry *dentry);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1db762c770ca..1bac0e237e7c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4599,7 +4599,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
-	ext4_fc_track_range(inode, offset >> inode->i_sb->s_blocksize_bits,
+	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
 			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 48b7bc129392..9399e9cccb7e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -323,13 +323,14 @@ static inline int ext4_fc_is_ineligible(struct super_block *sb)
  * If enqueue is set, this function enqueues the inode in fast commit list.
  */
 static int ext4_fc_track_template(
-	struct inode *inode, int (*__fc_track_fn)(struct inode *, void *, bool),
+	handle_t *handle, struct inode *inode,
+	int (*__fc_track_fn)(struct inode *, void *, bool),
 	void *args, int enqueue)
 {
-	tid_t running_txn_tid;
 	bool update = false;
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	tid_t tid = 0;
 	int ret;
 
 	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
@@ -339,15 +340,13 @@ static int ext4_fc_track_template(
 	if (ext4_fc_is_ineligible(inode->i_sb))
 		return -EINVAL;
 
-	running_txn_tid = sbi->s_journal ?
-		sbi->s_journal->j_commit_sequence + 1 : 0;
-
+	tid = handle->h_transaction->t_tid;
 	mutex_lock(&ei->i_fc_lock);
-	if (running_txn_tid == ei->i_sync_tid) {
+	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
 		ext4_fc_reset_inode(inode);
-		ei->i_sync_tid = running_txn_tid;
+		ei->i_sync_tid = tid;
 	}
 	ret = __fc_track_fn(inode, args, update);
 	mutex_unlock(&ei->i_fc_lock);
@@ -422,7 +421,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
-void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry)
+void __ext4_fc_track_unlink(handle_t *handle,
+		struct inode *inode, struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -430,12 +430,18 @@ void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry)
 	args.dentry = dentry;
 	args.op = EXT4_FC_TAG_UNLINK;
 
-	ret = ext4_fc_track_template(inode, __track_dentry_update,
+	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
 	trace_ext4_fc_track_unlink(inode, dentry, ret);
 }
 
-void ext4_fc_track_link(struct inode *inode, struct dentry *dentry)
+void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
+{
+	__ext4_fc_track_unlink(handle, d_inode(dentry), dentry);
+}
+
+void __ext4_fc_track_link(handle_t *handle,
+	struct inode *inode, struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -443,20 +449,26 @@ void ext4_fc_track_link(struct inode *inode, struct dentry *dentry)
 	args.dentry = dentry;
 	args.op = EXT4_FC_TAG_LINK;
 
-	ret = ext4_fc_track_template(inode, __track_dentry_update,
+	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
 	trace_ext4_fc_track_link(inode, dentry, ret);
 }
 
-void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
+void ext4_fc_track_link(handle_t *handle, struct dentry *dentry)
+{
+	__ext4_fc_track_link(handle, d_inode(dentry), dentry);
+}
+
+void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
+	struct inode *inode = d_inode(dentry);
 	int ret;
 
 	args.dentry = dentry;
 	args.op = EXT4_FC_TAG_CREAT;
 
-	ret = ext4_fc_track_template(inode, __track_dentry_update,
+	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
 	trace_ext4_fc_track_create(inode, dentry, ret);
 }
@@ -472,14 +484,14 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
-void ext4_fc_track_inode(struct inode *inode)
+void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
 		return;
 
-	ret = ext4_fc_track_template(inode, __track_inode, NULL, 1);
+	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(inode, ret);
 }
 
@@ -515,7 +527,7 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
-void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end)
 {
 	struct __track_range_args args;
@@ -527,7 +539,7 @@ void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 	args.start = start;
 	args.end = end;
 
-	ret = ext4_fc_track_template(inode,  __track_range, &args, 1);
+	ret = ext4_fc_track_template(handle, inode,  __track_range, &args, 1);
 
 	trace_ext4_fc_track_range(inode, start, end, ret);
 }
@@ -1263,7 +1275,7 @@ static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
 		return 0;
 	}
 
-	ret = __ext4_unlink(old_parent, &entry, inode);
+	ret = __ext4_unlink(NULL, old_parent, &entry, inode);
 	/* -ENOENT ok coz it might not exist anymore. */
 	if (ret == -ENOENT)
 		ret = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 081b6a86b5db..87120c4c44f3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -732,7 +732,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			if (ret)
 				return ret;
 		}
-		ext4_fc_track_range(inode, map->m_lblk,
+		ext4_fc_track_range(handle, inode, map->m_lblk,
 			    map->m_lblk + map->m_len - 1);
 	}
 
@@ -4111,7 +4111,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
-	ext4_fc_track_range(inode, first_block, stop_block);
+	ext4_fc_track_range(handle, inode, first_block, stop_block);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
@@ -5444,14 +5444,14 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			}
 
 			if (shrink)
-				ext4_fc_track_range(inode,
+				ext4_fc_track_range(handle, inode,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits,
 					(oldsize > 0 ? oldsize - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits);
 			else
 				ext4_fc_track_range(
-					inode,
+					handle, inode,
 					(oldsize > 0 ? oldsize - 1 : oldsize) >>
 					inode->i_sb->s_blocksize_bits,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
@@ -5701,7 +5701,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 		put_bh(iloc->bh);
 		return -EIO;
 	}
-	ext4_fc_track_inode(inode);
+	ext4_fc_track_inode(handle, inode);
 
 	if (IS_I_VERSION(inode))
 		inode_inc_iversion(inode);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5159830dacb8..b0d4371b684b 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2610,7 +2610,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		       bool excl)
 {
 	handle_t *handle;
-	struct inode *inode, *inode_save;
+	struct inode *inode;
 	int err, credits, retries = 0;
 
 	err = dquot_initialize(dir);
@@ -2628,11 +2628,9 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		inode->i_op = &ext4_file_inode_operations;
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
-		inode_save = inode;
-		ihold(inode_save);
 		err = ext4_add_nondir(handle, dentry, &inode);
-		ext4_fc_track_create(inode_save, dentry);
-		iput(inode_save);
+		if (!err)
+			ext4_fc_track_create(handle, dentry);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -2647,7 +2645,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 		      umode_t mode, dev_t rdev)
 {
 	handle_t *handle;
-	struct inode *inode, *inode_save;
+	struct inode *inode;
 	int err, credits, retries = 0;
 
 	err = dquot_initialize(dir);
@@ -2664,12 +2662,9 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
 		inode->i_op = &ext4_special_inode_operations;
-		inode_save = inode;
-		ihold(inode_save);
 		err = ext4_add_nondir(handle, dentry, &inode);
 		if (!err)
-			ext4_fc_track_create(inode_save, dentry);
-		iput(inode_save);
+			ext4_fc_track_create(handle, dentry);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -2833,7 +2828,6 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		iput(inode);
 		goto out_retry;
 	}
-	ext4_fc_track_create(inode, dentry);
 	ext4_inc_count(dir);
 
 	ext4_update_dx_flag(dir);
@@ -2841,6 +2835,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (err)
 		goto out_clear_inode;
 	d_instantiate_new(dentry, inode);
+	ext4_fc_track_create(handle, dentry);
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
@@ -3175,7 +3170,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		goto end_rmdir;
 	ext4_dec_count(dir);
 	ext4_update_dx_flag(dir);
-	ext4_fc_track_unlink(inode, dentry);
+	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
 #ifdef CONFIG_UNICODE
@@ -3196,13 +3191,12 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
 		  struct inode *inode)
 {
 	int retval = -ENOENT;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
-	handle_t *handle = NULL;
 	int skip_remove_dentry = 0;
 
 	bh = ext4_find_entry(dir, d_name, &de, NULL);
@@ -3221,14 +3215,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 			skip_remove_dentry = 1;
 		else
-			goto out_bh;
-	}
-
-	handle = ext4_journal_start(dir, EXT4_HT_DIR,
-				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
-	if (IS_ERR(handle)) {
-		retval = PTR_ERR(handle);
-		goto out_bh;
+			goto out;
 	}
 
 	if (IS_DIRSYNC(dir))
@@ -3237,12 +3224,12 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 	if (!skip_remove_dentry) {
 		retval = ext4_delete_entry(handle, dir, de, bh);
 		if (retval)
-			goto out_handle;
+			goto out;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		ext4_update_dx_flag(dir);
 		retval = ext4_mark_inode_dirty(handle, dir);
 		if (retval)
-			goto out_handle;
+			goto out;
 	} else {
 		retval = 0;
 	}
@@ -3256,15 +3243,14 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 	inode->i_ctime = current_time(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 
-out_handle:
-	ext4_journal_stop(handle);
-out_bh:
+out:
 	brelse(bh);
 	return retval;
 }
 
 static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 {
+	handle_t *handle;
 	int retval;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
@@ -3282,9 +3268,16 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (retval)
 		goto out_trace;
 
-	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry));
+	handle = ext4_journal_start(dir, EXT4_HT_DIR,
+				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
+	if (IS_ERR(handle)) {
+		retval = PTR_ERR(handle);
+		goto out_trace;
+	}
+
+	retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
 	if (!retval)
-		ext4_fc_track_unlink(d_inode(dentry), dentry);
+		ext4_fc_track_unlink(handle, dentry);
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3295,6 +3288,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
+	if (handle)
+		ext4_journal_stop(handle);
 
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
@@ -3451,7 +3446,6 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
-		ext4_fc_track_link(inode, dentry);
 		err = ext4_mark_inode_dirty(handle, inode);
 		/* this can happen only for tmpfile being
 		 * linked the first time
@@ -3459,6 +3453,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 		if (inode->i_nlink == 1)
 			ext4_orphan_del(handle, inode);
 		d_instantiate(dentry, inode);
+		ext4_fc_track_link(handle, dentry);
 	} else {
 		drop_nlink(inode);
 		iput(inode);
@@ -3919,9 +3914,9 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			EXT4_FC_REASON_RENAME_DIR);
 	} else {
 		if (new.inode)
-			ext4_fc_track_unlink(new.inode, new.dentry);
-		ext4_fc_track_link(old.inode, new.dentry);
-		ext4_fc_track_unlink(old.inode, old.dentry);
+			ext4_fc_track_unlink(handle, new.dentry);
+		__ext4_fc_track_link(handle, old.inode, new.dentry);
+		__ext4_fc_track_unlink(handle, old.inode, old.dentry);
 	}
 
 	if (new.inode) {
-- 
2.29.1.341.ge80a0c044ae-goog

