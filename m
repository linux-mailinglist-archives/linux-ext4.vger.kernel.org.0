Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6957BC2E59
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfJAHmI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38944 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfJAHmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so7301190pff.6
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/YWvxeiYzEGIXeQlsiw80iCHG2DR3Xru95STQdZmlE=;
        b=riKWZbTRRScCM4Tm+/JWb2/4oo/R9jzQ76l4E/zR7UfIUT3G6kg06BVevOxFbDJdIM
         O5XFllgRUfoaX+LRbaOCoaCOf6raWY+4NA8BIseesL0KgsYIFgMz5O7w9kMaIIpALrJz
         b3RAz7+4dneIn9NHPduZHX4V/PLuDd8lp7utr5y3DqKdsJcE/Gl4MvwIefPjwWqnRkPO
         E4Y64q0DEOvudbdZLkvMLLCMEgUmL0Ii1I4r3iRl0CbwmIrgMgwE4A6Bm1m5GG60jzky
         SoAJE1epNJECEWZOIBvZs7BU9R7wn/1imbeaJtGWw2SlTVSL2PEbsOl5+p6Qr03wXFVm
         jdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/YWvxeiYzEGIXeQlsiw80iCHG2DR3Xru95STQdZmlE=;
        b=AUUQLdv8lfmj4n2oqAIEecOUACMRvq6fkuAnYfvEzpA+WntoB2alEjcd54PlJ2Db3T
         iIm7nF8hkHOw86xKdHU0B9b92/5XWYuWI+zTUuUizMJgU0pZH6EuFl7UfoQg9CuSmXGc
         hSdJTyU6jY+EaH5Y0Ic8TZADeRYvlspRjS9asRMPYF7oT5GrYLy+kPGDcm18A/G6/s/m
         TsOzGv0vpHwVu3ROUHSX0WjdSZuYmG/QQo4nGRJkmDBP8epCjqlyy6TT+laTtTAZlSML
         u1qmBmUOwkjT+OQAR7sYsALR3xxvS4Imoj1GJdFcgduRLjq2T2pXkLV7GrFZc6Mr46XW
         4w6A==
X-Gm-Message-State: APjAAAXuPrkufNRFTNsTdpvgC7G6HMdNP+HFGWDReVTTC6O5XUDikfEd
        xi15Ni1cgblYnZ88MCgsQqTLUhb7asc=
X-Google-Smtp-Source: APXvYqxeJjpYyGntkRhnUKA699eXfTbz3ZQQxzJB9P+tGpHh1dJptfUt3hK4gV2aOrO29tZ6Wug79g==
X-Received: by 2002:aa7:99da:: with SMTP id v26mr26473899pfi.258.1569915726240;
        Tue, 01 Oct 2019 00:42:06 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:05 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 07/13] ext4: track changed files for fast commit
Date:   Tue,  1 Oct 2019 00:40:56 -0700
Message-Id: <20191001074101.256523-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For fast commit, we need to remember all the files that have changed
since last fast commit / full commit. For changes that are fast commit
incompatible, we mark the file system fast commit incompatible. This
patch adds code to either remember files that have changed or to mark
ext4 as fast commit ineligible. We inspect every ext4_mark_inode_dirty
calls and decide whether that particular file change is fast
compatible or not.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/acl.c       |  1 +
 fs/ext4/ext4_jbd2.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h | 44 +++++++++++++++++++++
 fs/ext4/extents.c   | 16 +++++++-
 fs/ext4/ialloc.c    |  8 ++++
 fs/ext4/inline.c    | 10 +++++
 fs/ext4/inode.c     | 24 +++++++++++-
 fs/ext4/ioctl.c     |  3 ++
 fs/ext4/migrate.c   |  1 +
 fs/ext4/namei.c     | 12 +++++-
 fs/ext4/super.c     |  5 +++
 fs/ext4/xattr.c     |  1 +
 12 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 8c7bbf3e566d..e84be9c315db 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -257,6 +257,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		inode->i_mode = mode;
 		inode->i_ctime = current_time(inode);
 		ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
 	}
 out_stop:
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 9066bcfbee29..e70ad7a8e46e 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -331,6 +331,13 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 	return err;
 }
 
+static inline tid_t get_running_txn_tid(struct super_block *sb)
+{
+	if (EXT4_SB(sb)->s_journal)
+		return EXT4_SB(sb)->s_journal->j_commit_sequence + 1;
+	return 0;
+}
+
 static inline
 void ext4_reset_inode_fc_info(struct ext4_fast_commit_inode_info *i_fc)
 {
@@ -350,3 +357,92 @@ void ext4_init_inode_fc_info(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	rwlock_init(&ei->i_fc.fc_lock);
 }
+
+void ext4_fc_enqueue_inode(handle_t *handle, struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);
+
+	if (!ext4_should_fast_commit(inode->i_sb))
+		return;
+
+	spin_lock(&sbi->s_fc_lock);
+	if (!sbi->s_fc_eligible) {
+		spin_unlock(&sbi->s_fc_lock);
+		return;
+	}
+	if (list_empty(&EXT4_I(inode)->i_fc_list)) {
+		list_add(&EXT4_I(inode)->i_fc_list, &sbi->s_fc_q);
+		sbi->s_fc_q_cnt++;
+	}
+	spin_unlock(&sbi->s_fc_lock);
+
+	write_lock(&ei->i_fc.fc_lock);
+	if (ei->i_fc.fc_tid == running_txn_tid) {
+		write_unlock(&ei->i_fc.fc_lock);
+		return;
+	}
+
+	ext4_reset_inode_fc_info(&ei->i_fc);
+	ei->i_fc.fc_lblk_start = i_size_read(inode);
+	ei->i_fc.fc_lblk_end = i_size_read(inode);
+	ei->i_fc.fc_eligible = true;
+	ei->i_fc.fc_tid = running_txn_tid;
+	write_unlock(&ei->i_fc.fc_lock);
+}
+
+void ext4_fc_del(struct inode *inode)
+{
+	if (!ext4_should_fast_commit(inode->i_sb))
+		return;
+
+	if (list_empty(&EXT4_I(inode)->i_fc_list))
+		return;
+
+	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	list_del_init(&EXT4_I(inode)->i_fc_list);
+	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+}
+
+void ext4_fc_mark_new(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);
+
+	write_lock(&ei->i_fc.fc_lock);
+	if (ei->i_fc.fc_tid != running_txn_tid) {
+		ext4_reset_inode_fc_info(&ei->i_fc);
+		ei->i_fc.fc_tid = running_txn_tid;
+		ei->i_fc.fc_eligible = true;
+	}
+	ei->i_fc.fc_new = true;
+	write_unlock(&ei->i_fc.fc_lock);
+}
+
+bool ext4_is_inode_fc_ineligible(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);
+	bool ret = false;
+
+	read_lock(&ei->i_fc.fc_lock);
+	if (running_txn_tid == ei->i_fc.fc_tid)
+		ret = !ei->i_fc.fc_eligible;
+	read_unlock(&ei->i_fc.fc_lock);
+	return ret;
+}
+
+bool ext4_is_inode_fc_new(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);
+	bool ret = false;
+
+	read_lock(&ei->i_fc.fc_lock);
+	if (running_txn_tid == ei->i_fc.fc_tid)
+		ret = ei->i_fc.fc_new;
+	read_unlock(&ei->i_fc.fc_lock);
+
+	return ret;
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 2305c1acd415..65f20fbfb002 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -378,6 +378,17 @@ static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
 	return 0;
 }
 
+static inline int ext4_should_fast_commit(struct super_block *sb)
+{
+	if (!ext4_has_feature_fast_commit(sb))
+		return 0;
+	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
+		return 0;
+	if (test_opt(sb, QUOTA))
+		return 0;
+	return 1;
+}
+
 static inline void ext4_update_inode_fsync_trans(handle_t *handle,
 						 struct inode *inode,
 						 int datasync)
@@ -460,5 +471,38 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 }
 
 void ext4_init_inode_fc_info(struct inode *inode);
+extern void ext4_fc_enqueue_inode(handle_t *handle, struct inode *inode);
+extern void ext4_fc_del(struct inode *inode);
+
+static inline void
+ext4_fc_mark_sb_ineligible(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	spin_lock(&sbi->s_fc_lock);
+	sbi->s_fc_eligible = false;
+	spin_unlock(&sbi->s_fc_lock);
+}
+
+
+static inline void
+ext4_fc_mark_ineligible(struct inode *inode)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	write_lock(&ei->i_fc.fc_lock);
+	if (sbi->s_journal)
+		ei->i_fc.fc_tid = sbi->s_journal->j_commit_sequence + 1;
+	ei->i_fc.fc_eligible = false;
+	write_unlock(&ei->i_fc.fc_lock);
+	spin_lock(&sbi->s_fc_lock);
+	sbi->s_fc_eligible = false;
+	spin_unlock(&sbi->s_fc_lock);
+}
+
 
+void ext4_fc_mark_new(struct inode *inode);
+bool ext4_is_inode_fc_ineligible(struct inode *inode);
+bool ext4_is_inode_fc_new(struct inode *inode);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92266a2da7d6..b30f6175eb71 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -163,6 +163,7 @@ int __ext4_ext_dirty(const char *where, unsigned int line, handle_t *handle,
 	} else {
 		/* path points to leaf/index in inode body */
 		err = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
 	}
 	return err;
 }
@@ -3714,6 +3715,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 		err = ext4_zeroout_es(inode, &zero_ex1);
 		if (!err)
 			err = ext4_zeroout_es(inode, &zero_ex2);
+	} else {
+		ext4_fc_mark_ineligible(inode);
 	}
 	return err ? err : allocated;
 }
@@ -3856,7 +3859,7 @@ static int check_eofblocks_fl(handle_t *handle, struct inode *inode,
 			      struct ext4_ext_path *path,
 			      unsigned int len)
 {
-	int i, depth;
+	int i, ret, depth;
 	struct ext4_extent_header *eh;
 	struct ext4_extent *last_ex;
 
@@ -3898,7 +3901,10 @@ static int check_eofblocks_fl(handle_t *handle, struct inode *inode,
 			return 0;
 out:
 	ext4_clear_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
-	return ext4_mark_inode_dirty(handle, inode);
+	ret = ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_enqueue_inode(handle, inode);
+
+	return ret;
 }
 
 static int
@@ -4607,6 +4613,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 				   inode->i_ino, map.m_lblk,
 				   map.m_len, ret);
 			ext4_mark_inode_dirty(handle, inode);
+			ext4_fc_enqueue_inode(handle, inode);
 			ret2 = ext4_journal_stop(handle);
 			break;
 		}
@@ -4624,6 +4631,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 				ext4_set_inode_flag(inode,
 						    EXT4_INODE_EOFBLOCKS);
 		}
+		ext4_fc_enqueue_inode(handle, inode);
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
 		ret2 = ext4_journal_stop(handle);
@@ -4786,6 +4794,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			ext4_set_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
 	}
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_enqueue_inode(handle, inode);
 
 	/* Zero out partial block at the edges of the range */
 	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
@@ -4957,6 +4966,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 				     "ext4_ext_map_blocks returned %d",
 				     inode->i_ino, map.m_lblk,
 				     map.m_len, ret);
+		ext4_fc_mark_ineligible(inode);
 		ext4_mark_inode_dirty(handle, inode);
 		if (credits)
 			ret2 = ext4_journal_stop(handle);
@@ -5485,6 +5495,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5599,6 +5610,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index ff30f3015551..47d04a33a3ca 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1133,6 +1133,14 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	ext4_set_inode_state(inode, EXT4_STATE_NEW);
 	ext4_init_inode_fc_info(inode);
 
+	if (S_ISDIR(mode) || ext4_is_inode_fc_ineligible(dir) ||
+	    ext4_is_inode_fc_new(dir)) {
+		ext4_fc_mark_ineligible(inode);
+	} else {
+		ext4_fc_mark_new(inode);
+		ei->i_fc.fc_parent_ino = dir->i_ino;
+	}
+
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
 	if (ext4_has_feature_inline_data(sb))
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 88cdf3c90bd1..fbd561cba098 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -435,6 +435,8 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	if (error)
 		goto out;
 
+	ext4_fc_mark_ineligible(inode);
+
 	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
 		0, EXT4_MIN_INLINE_DATA_SIZE);
 	memset(ei->i_data, 0, EXT4_MIN_INLINE_DATA_SIZE);
@@ -759,6 +761,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 
 	ext4_write_unlock_xattr(inode, &no_expand);
 	brelse(iloc.bh);
+	ext4_fc_enqueue_inode(ext4_journal_current_handle(), inode);
 	mark_inode_dirty(inode);
 out:
 	return copied;
@@ -974,6 +977,7 @@ int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
+	ext4_fc_enqueue_inode(ext4_journal_current_handle(), inode);
 	mark_inode_dirty(inode);
 
 	return copied;
@@ -1165,6 +1169,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 	if (err)
 		return err;
 	set_buffer_verified(dir_block);
+	ext4_fc_mark_ineligible(inode);
 	return ext4_mark_inode_dirty(handle, inode);
 }
 
@@ -1216,6 +1221,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 		goto out_restore;
 	}
 
+	ext4_fc_mark_ineligible(inode);
+
 	data_bh = sb_getblk(inode->i_sb, map.m_pblk);
 	if (!data_bh) {
 		error = -ENOMEM;
@@ -1709,6 +1716,8 @@ int ext4_delete_inline_entry(handle_t *handle,
 	if (err)
 		goto out;
 
+	ext4_fc_enqueue_inode(handle, dir);
+
 	ext4_show_inline_dir(dir, iloc.bh, inline_start, inline_size);
 out:
 	ext4_write_unlock_xattr(dir, &no_expand);
@@ -1986,6 +1995,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 
 	if (err == 0) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
+		ext4_fc_enqueue_inode(handle, inode);
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f230a888eddd..6d2efbd9aba9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -262,6 +262,7 @@ void ext4_evict_inode(struct inode *inode)
 		 * cleaned up.
 		 */
 		ext4_orphan_del(NULL, inode);
+		ext4_fc_del(inode);
 		sb_end_intwrite(inode->i_sb);
 		goto no_delete;
 	}
@@ -279,6 +280,8 @@ void ext4_evict_inode(struct inode *inode)
 	if (ext4_inode_is_fast_symlink(inode))
 		memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
 	inode->i_size = 0;
+	ext4_fc_del(inode);
+	ext4_fc_mark_ineligible(inode);
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err) {
 		ext4_warning(inode->i_sb,
@@ -303,6 +306,7 @@ void ext4_evict_inode(struct inode *inode)
 stop_handle:
 		ext4_journal_stop(handle);
 		ext4_orphan_del(NULL, inode);
+		ext4_fc_del(inode);
 		sb_end_intwrite(inode->i_sb);
 		ext4_xattr_inode_array_free(ea_inode_array);
 		goto no_delete;
@@ -326,6 +330,8 @@ void ext4_evict_inode(struct inode *inode)
 	 * having errors), but we can't free the inode if the mark_dirty
 	 * fails.
 	 */
+	ext4_fc_del(inode);
+	ext4_fc_mark_ineligible(inode);
 	if (ext4_mark_inode_dirty(handle, inode))
 		/* If that failed, just do the required in-core inode clear. */
 		ext4_clear_inode(inode);
@@ -1436,8 +1442,10 @@ static int ext4_write_end(struct file *file,
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
-	if (i_size_changed || inline_data)
+	if (i_size_changed || inline_data) {
 		ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
+	}
 
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		/* if we have allocated more blocks and copied
@@ -1550,6 +1558,7 @@ static int ext4_journalled_write_end(struct file *file,
 		pagecache_isize_extended(inode, old_size, pos);
 
 	if (size_changed || inline_data) {
+		ext4_fc_enqueue_inode(handle, inode);
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		if (!ret)
 			ret = ret2;
@@ -2077,6 +2086,7 @@ static int __ext4_journalled_writepage(struct page *page,
 
 	if (inline_data) {
 		ret = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
 	} else {
 		ret = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
 					     do_journal_get_write_access);
@@ -2604,6 +2614,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			EXT4_I(inode)->i_disksize = disksize;
 		up_write(&EXT4_I(inode)->i_data_sem);
 		err2 = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
 		if (err2)
 			ext4_error(inode->i_sb,
 				   "Failed to mark inode %lu dirty",
@@ -3205,6 +3216,7 @@ static int ext4_da_write_end(struct file *file,
 			 * bu greater than i_disksize.(hint delalloc)
 			 */
 			ext4_mark_inode_dirty(handle, inode);
+			ext4_fc_enqueue_inode(handle, inode);
 		}
 	}
 
@@ -3614,8 +3626,12 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 		ret = PTR_ERR(handle);
 		goto orphan_del;
 	}
-	if (ext4_update_inode_size(inode, offset + written))
+
+	if (ext4_update_inode_size(inode, offset + written)) {
 		ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
+	}
+
 	/*
 	 * We may need to truncate allocated but not written blocks beyond EOF.
 	 */
@@ -3851,6 +3867,7 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 				 * ignore it.
 				 */
 				ext4_mark_inode_dirty(handle, inode);
+				ext4_fc_enqueue_inode(handle, inode);
 			}
 		}
 		err = ext4_journal_stop(handle);
@@ -4372,6 +4389,8 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 		goto out_dio;
 	}
 
+	ext4_fc_mark_ineligible(inode);
+
 	ret = ext4_zero_partial_blocks(handle, inode, offset,
 				       length);
 	if (ret)
@@ -4525,6 +4544,7 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
 		ext4_block_truncate_page(handle, mapping, inode->i_size);
 
+	ext4_fc_mark_ineligible(inode);
 	/*
 	 * We add the inode to the orphan list, so that if this
 	 * truncate spans multiple transactions, and we crash, we will
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 442f7ef873fc..a8e23acb5c03 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -987,6 +987,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = mnt_want_write_file(filp);
 		if (err)
 			return err;
+		ext4_fc_mark_sb_ineligible(sb);
 		err = swap_inode_boot_loader(sb, inode);
 		mnt_drop_write_file(filp);
 		return err;
@@ -997,6 +998,8 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		int err = 0, err2 = 0;
 		ext4_group_t o_group = EXT4_SB(sb)->s_groups_count;
 
+		ext4_fc_mark_sb_ineligible(sb);
+
 		if (copy_from_user(&n_blocks_count, (__u64 __user *)arg,
 				   sizeof(__u64))) {
 			return -EFAULT;
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index b1e4d359f73b..b995690d73ce 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -513,6 +513,7 @@ int ext4_ext_migrate(struct inode *inode)
 		 * work to orphan_list_cleanup()
 		 */
 		ext4_orphan_del(NULL, tmp_inode);
+		ext4_fc_del(inode);
 		retval = PTR_ERR(handle);
 		goto out;
 	}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129029534075..8b73c5a38d49 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2140,8 +2140,10 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	 * out all the changes we did so far. Otherwise we can end up
 	 * with corrupted filesystem.
 	 */
-	if (retval)
+	if (retval) {
 		ext4_mark_inode_dirty(handle, dir);
+		ext4_fc_mark_ineligible(dir);
+	}
 	dx_release(frames);
 	brelse(bh2);
 	return retval;
@@ -2661,6 +2663,7 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 		err = ext4_orphan_add(handle, inode);
 		if (err)
 			goto err_unlock_inode;
+		ext4_fc_enqueue_inode(handle, inode);
 		mark_inode_dirty(inode);
 		unlock_new_inode(inode);
 	}
@@ -2773,6 +2776,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	err = ext4_init_new_dir(handle, dir, inode);
 	if (err)
 		goto out_clear_inode;
+	ext4_fc_mark_ineligible(inode);
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (!err)
 		err = ext4_add_entry(handle, dentry, inode);
@@ -3114,6 +3118,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	inode->i_size = 0;
 	ext4_orphan_add(handle, inode);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	ext4_fc_mark_ineligible(inode);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_dec_count(handle, dir);
 	ext4_update_dx_flag(dir);
@@ -3192,6 +3197,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	ext4_update_dx_flag(dir);
+	ext4_fc_mark_ineligible(dir);
 	ext4_mark_inode_dirty(handle, dir);
 	drop_nlink(inode);
 	if (!inode->i_nlink)
@@ -3387,6 +3393,7 @@ static int ext4_link(struct dentry *old_dentry,
 
 	err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
+		ext4_fc_mark_ineligible(inode);
 		ext4_mark_inode_dirty(handle, inode);
 		/* this can happen only for tmpfile being
 		 * linked the first time
@@ -3991,6 +3998,9 @@ static int ext4_rename2(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		return err;
 
+	ext4_fc_mark_ineligible(old_dir);
+	ext4_fc_mark_ineligible(new_dir);
+
 	if (flags & RENAME_EXCHANGE) {
 		return ext4_cross_rename(old_dir, old_dentry,
 					 new_dir, new_dentry);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c90337fc98c1..3e9570ea9748 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1181,6 +1181,7 @@ void ext4_clear_inode(struct inode *inode)
 		EXT4_I(inode)->jinode = NULL;
 	}
 	fscrypt_put_encryption_info(inode);
+	ext4_fc_del(inode);
 }
 
 static struct inode *ext4_nfs_get_inode(struct super_block *sb,
@@ -1325,6 +1326,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 		 * S_DAX may be disabled
 		 */
 		ext4_set_inode_flags(inode);
+		ext4_fc_mark_ineligible(inode);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
 			EXT4_ERROR_INODE(inode, "Failed to mark inode dirty");
@@ -5797,6 +5799,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		EXT4_I(inode)->i_flags |= EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL;
 		inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
 				S_NOATIME | S_IMMUTABLE);
+		ext4_fc_mark_ineligible(inode);
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 	unlock_inode:
@@ -5904,6 +5907,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
 	inode->i_mtime = inode->i_ctime = current_time(inode);
+	ext4_fc_mark_ineligible(inode);
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
@@ -6010,6 +6014,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	if (inode->i_size < off + len) {
 		i_size_write(inode, off + len);
 		EXT4_I(inode)->i_disksize = inode->i_size;
+		ext4_fc_mark_ineligible(inode);
 		ext4_mark_inode_dirty(handle, inode);
 	}
 	return len;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..19bc4046658c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1406,6 +1406,7 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 	inode_unlock(ea_inode);
 
 	ext4_mark_inode_dirty(handle, ea_inode);
+	ext4_fc_enqueue_inode(handle, ea_inode);
 
 out:
 	brelse(bh);
-- 
2.23.0.444.g18eeb5a265-goog

