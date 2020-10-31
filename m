Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891DD2A1A6C
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgJaUFo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgJaUFn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D76C0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b19so4713024pld.0
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sNqY0Kg7nFH/kUDIAO+lIzZMrbS53V4VD/FDja97HA=;
        b=pIQPyh8q2/4vvymYCv5aSXmKNq9meR40oqSo4bDUPybaXHO+rT3/S0+qwqZXWcScm5
         4quevBDeahVlB5D1z93OFcJw/LSvJ7Bk0MW9Uv0iwaGsCreNOQkprIx/5sszGOtOikzu
         12I/+pyPwxDePCrM1mbkWiI0UUXvLGVxqUW+oG7UqQZgJzIJcxz14UDWgO4Zn9bLkIiM
         NHTA7Wtc1UWZ03UZxXxRylrbKMGhpnXeeuyDw0Rgg/Jl7wULHBrDNDopJgXyjBgceLOL
         DZh927dpkvfRE9qX32MW6crWboAW5fmXBrnsC1WBbmLjjfVOE1xfc13+wL7Hv9LRUwhw
         H8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sNqY0Kg7nFH/kUDIAO+lIzZMrbS53V4VD/FDja97HA=;
        b=fuOlTH8P9Wb/0lJoj7OE7AXO4pn3elncVhB7kNZ1V0tligi0qv1HHUljJC46X1yF2l
         +mL9SF3G4vCKrLwEP/Y121WYoF4Z5redteijiPUsK3O1sZS4fVWeBk+MVq/IwEcf4t91
         A4uDzIJ9EdTgCxSEe0xlCwra7khXlN+D8eAGqQjgNWNYyIstvxVJMmRsEIWr+N2InUgs
         946ZKG3lvLFlOGC6u8s9rT6RuAU/YZyy490vfJy88ZBmgDcLAI1BKihyxHYutKjiumkQ
         hicZHhzxPOCPA5DcwQ7H2FJLaQKuj9zwrYVWjJe/7AR1DZyIonk25LgjTcddtozxkWTC
         oX9w==
X-Gm-Message-State: AOAM530NwGWgDhV+cmTBdC1cixbnE1pvaDK47kIdfcbvQ9N4UODMRMUX
        vzeNwxSWoZnofbCfQTnAE3AGEzvGBec=
X-Google-Smtp-Source: ABdhPJxXwuGxyuQwziweVrim+ZZI9mL+ObeSyy0NAjGCdyKRrPa0wXE9/QG6U9bUYgE9MdVkeDZkTA==
X-Received: by 2002:a17:90a:ab86:: with SMTP id n6mr9880866pjq.82.1604174742929;
        Sat, 31 Oct 2020 13:05:42 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:42 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 03/10] ext4: pass handle to ext4_fc_track_* functions
Date:   Sat, 31 Oct 2020 13:05:11 -0700
Message-Id: <20201031200518.4178786-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use transaction id found in handle->h_transaction->h_tid for tracking
fast commit updates. This patch also restructures ext4_unlink to make
handle available inside ext4_unlink for fast commit tracking.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        | 12 +++++------
 fs/ext4/extents.c     | 11 +++++-----
 fs/ext4/fast_commit.c | 39 +++++++++++++++++----------------
 fs/ext4/inode.c       | 10 ++++-----
 fs/ext4/namei.c       | 50 +++++++++++++++++++++----------------------
 fs/ext4/super.c       |  2 +-
 6 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 12673f9ec880..573db158382f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2750,12 +2750,12 @@ extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
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
+void ext4_fc_track_unlink(handle_t *handle, struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_link(handle_t *handle, struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_create(handle_t *handle, struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
 void ext4_fc_start_ineligible(struct super_block *sb, int reason);
 void ext4_fc_stop_ineligible(struct super_block *sb);
@@ -3471,7 +3471,7 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 extern int ext4_ci_compare(const struct inode *parent,
 			   const struct qstr *fname,
 			   const struct qstr *entry, bool quick);
-extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+extern int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
 			 struct inode *inode);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
 		       struct dentry *dentry);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 559100f3e23c..7c8f05db9402 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3723,7 +3723,7 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
 out:
 	ext4_ext_show_leaf(inode, path);
-	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
+	ext4_fc_track_range(handle, inode, ee_block, ee_block + ee_len - 1);
 	return err;
 }
 
@@ -3795,7 +3795,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	if (*allocated > map->m_len)
 		*allocated = map->m_len;
 	map->m_len = *allocated;
-	ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
+	ext4_fc_track_range(handle, inode, ee_block, ee_block + ee_len - 1);
 	return 0;
 }
 
@@ -4329,7 +4329,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	map->m_len = ar.len;
 	allocated = map->m_len;
 	ext4_ext_show_leaf(inode, path);
-	ext4_fc_track_range(inode, map->m_lblk, map->m_lblk + map->m_len - 1);
+	ext4_fc_track_range(handle, inode, map->m_lblk,
+		map->m_lblk + map->m_len - 1);
 out:
 	ext4_ext_drop_refs(path);
 	kfree(path);
@@ -4602,7 +4603,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
-	ext4_fc_track_range(inode, offset >> inode->i_sb->s_blocksize_bits,
+	ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
 			(offset + len - 1) >> inode->i_sb->s_blocksize_bits);
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
@@ -4651,8 +4652,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
-	ext4_fc_track_range(inode, offset >> blkbits,
-			(offset + len - 1) >> blkbits);
 
 	ext4_fc_start_update(inode);
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 354f81ff819d..5c3af472287a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -323,15 +323,18 @@ static inline int ext4_fc_is_ineligible(struct super_block *sb)
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
 
+	if (ext4_handle_valid(handle) && handle->h_transaction)
+		tid = handle->h_transaction->t_tid;
 	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
 	    (sbi->s_mount_state & EXT4_FC_REPLAY))
 		return -EOPNOTSUPP;
@@ -339,15 +342,12 @@ static int ext4_fc_track_template(
 	if (ext4_fc_is_ineligible(inode->i_sb))
 		return -EINVAL;
 
-	running_txn_tid = sbi->s_journal ?
-		sbi->s_journal->j_commit_sequence + 1 : 0;
-
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
@@ -422,7 +422,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
-void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry)
+void ext4_fc_track_unlink(handle_t *handle,
+		struct inode *inode, struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -430,12 +431,13 @@ void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry)
 	args.dentry = dentry;
 	args.op = EXT4_FC_TAG_UNLINK;
 
-	ret = ext4_fc_track_template(inode, __track_dentry_update,
+	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
 	trace_ext4_fc_track_unlink(inode, dentry, ret);
 }
 
-void ext4_fc_track_link(struct inode *inode, struct dentry *dentry)
+void ext4_fc_track_link(handle_t *handle,
+	struct inode *inode, struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -443,12 +445,13 @@ void ext4_fc_track_link(struct inode *inode, struct dentry *dentry)
 	args.dentry = dentry;
 	args.op = EXT4_FC_TAG_LINK;
 
-	ret = ext4_fc_track_template(inode, __track_dentry_update,
+	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
 	trace_ext4_fc_track_link(inode, dentry, ret);
 }
 
-void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
+void ext4_fc_track_create(handle_t *handle, struct inode *inode,
+	struct dentry *dentry)
 {
 	struct __track_dentry_update_args args;
 	int ret;
@@ -456,7 +459,7 @@ void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
 	args.dentry = dentry;
 	args.op = EXT4_FC_TAG_CREAT;
 
-	ret = ext4_fc_track_template(inode, __track_dentry_update,
+	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
 					(void *)&args, 0);
 	trace_ext4_fc_track_create(inode, dentry, ret);
 }
@@ -472,14 +475,14 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
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
 
@@ -515,7 +518,7 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
-void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
+void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end)
 {
 	struct __track_range_args args;
@@ -527,7 +530,7 @@ void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 	args.start = start;
 	args.end = end;
 
-	ret = ext4_fc_track_template(inode,  __track_range, &args, 1);
+	ret = ext4_fc_track_template(handle, inode,  __track_range, &args, 1);
 
 	trace_ext4_fc_track_range(inode, start, end, ret);
 }
@@ -1263,7 +1266,7 @@ static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
 		return 0;
 	}
 
-	ret = __ext4_unlink(old_parent, &entry, inode);
+	ret = __ext4_unlink(NULL, old_parent, &entry, inode);
 	/* -ENOENT ok coz it might not exist anymore. */
 	if (ret == -ENOENT)
 		ret = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 52ff71236290..7f6af784e74f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -731,7 +731,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			if (ret)
 				return ret;
 		}
-		ext4_fc_track_range(inode, map->m_lblk,
+		ext4_fc_track_range(handle, inode, map->m_lblk,
 			    map->m_lblk + map->m_len - 1);
 	}
 
@@ -4110,7 +4110,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
-	ext4_fc_track_range(inode, first_block, stop_block);
+	ext4_fc_track_range(handle, inode, first_block, stop_block);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
@@ -5443,14 +5443,14 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
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
@@ -5700,7 +5700,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 		put_bh(iloc->bh);
 		return -EIO;
 	}
-	ext4_fc_track_inode(inode);
+	ext4_fc_track_inode(handle, inode);
 
 	if (IS_I_VERSION(inode))
 		inode_inc_iversion(inode);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5159830dacb8..f3f8bf61072e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2631,7 +2631,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		inode_save = inode;
 		ihold(inode_save);
 		err = ext4_add_nondir(handle, dentry, &inode);
-		ext4_fc_track_create(inode_save, dentry);
+		ext4_fc_track_create(handle, inode_save, dentry);
 		iput(inode_save);
 	}
 	if (handle)
@@ -2668,7 +2668,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 		ihold(inode_save);
 		err = ext4_add_nondir(handle, dentry, &inode);
 		if (!err)
-			ext4_fc_track_create(inode_save, dentry);
+			ext4_fc_track_create(handle, inode_save, dentry);
 		iput(inode_save);
 	}
 	if (handle)
@@ -2833,7 +2833,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		iput(inode);
 		goto out_retry;
 	}
-	ext4_fc_track_create(inode, dentry);
+	ext4_fc_track_create(handle, inode, dentry);
 	ext4_inc_count(dir);
 
 	ext4_update_dx_flag(dir);
@@ -3175,7 +3175,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		goto end_rmdir;
 	ext4_dec_count(dir);
 	ext4_update_dx_flag(dir);
-	ext4_fc_track_unlink(inode, dentry);
+	ext4_fc_track_unlink(handle, inode, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
 #ifdef CONFIG_UNICODE
@@ -3196,13 +3196,12 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -3221,14 +3220,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
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
@@ -3237,12 +3229,12 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
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
@@ -3256,15 +3248,14 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
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
@@ -3282,9 +3273,16 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
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
+		ext4_fc_track_unlink(handle, d_inode(dentry), dentry);
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3295,6 +3293,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
+	if (handle)
+		ext4_journal_stop(handle);
 
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
@@ -3451,7 +3451,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
-		ext4_fc_track_link(inode, dentry);
+		ext4_fc_track_link(handle, inode, dentry);
 		err = ext4_mark_inode_dirty(handle, inode);
 		/* this can happen only for tmpfile being
 		 * linked the first time
@@ -3919,9 +3919,9 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			EXT4_FC_REASON_RENAME_DIR);
 	} else {
 		if (new.inode)
-			ext4_fc_track_unlink(new.inode, new.dentry);
-		ext4_fc_track_link(old.inode, new.dentry);
-		ext4_fc_track_unlink(old.inode, old.dentry);
+			ext4_fc_track_unlink(handle, new.inode, new.dentry);
+		ext4_fc_track_link(handle, old.inode, new.dentry);
+		ext4_fc_track_unlink(handle, old.inode, old.dentry);
 	}
 
 	if (new.inode) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d92de21212e9..e67d2fa41a78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6561,7 +6561,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	brelse(bh);
 out:
 	if (inode->i_size < off + len) {
-		ext4_fc_track_range(inode,
+		ext4_fc_track_range(handle, inode,
 			(inode->i_size > 0 ? inode->i_size - 1 : 0)
 				>> inode->i_sb->s_blocksize_bits,
 			(off + len) >> inode->i_sb->s_blocksize_bits);
-- 
2.29.1.341.ge80a0c044ae-goog

