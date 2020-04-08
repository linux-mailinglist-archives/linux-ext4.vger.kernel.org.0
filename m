Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619821A2B8A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDHVz6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:58 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56203 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgDHVz5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:57 -0400
Received: by mail-pj1-f68.google.com with SMTP id a32so394920pje.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHLRuyVAfUzUijQHLOb3XGMomAzso/SIDFCvB1CAdhc=;
        b=RUY1oJ5Yhj3joMsHtxOSP+RxasNWtXwm389mRk/BceBm/UoWkahex4FMsbFhlKx85N
         i8BE3psgG+ALG97E57qLtPiLkPcIqmN/YBBF5Zgw/eik7vBeqh0ujwRYAxvzPg+3APNQ
         5ylsTxJnjRQY8RJSOLCz1HNIOSQHhg6votcl+2aP1rkQuoi/qz+1VIpV6D+BHifVyEVu
         Ywyh3CEz7Rm4VCEE0yCol7WRf3kg5MOOBu92+inxWnt2sxlN+8DfFVGYOVAizGvHB3d1
         2kbaLOrkAPQwbpg3oMQIs+wlkzrZU1GnA7Ry6dwx1egOKQxSlFWJglol1RUu+hJ2cBw5
         Oxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHLRuyVAfUzUijQHLOb3XGMomAzso/SIDFCvB1CAdhc=;
        b=Gfxzp4TUevLrRmOqukax269wl1z4PpcHGUvSKO7YmQPNSeL2x7NtXJgj1BxxpwJsRC
         uEubUpqybBWdaFli7swNma4BanJtq4ssM21QsvMYwilckAanyapGi9OnKUZCiR+lN7ok
         2NLGpZ0zyU5OGDdWs+drEwLjdEO5188y6BCdy97YNAlstZ/sHmME7ifrWqRcZ1u9WLB/
         imeuhUjzWi9bPvKAFvppTH4/imQ5OE8/hC4ixnPtXV3se5qPsDIzzIZeGJ+j2d7JgOGk
         OZ4YJpqm4hJhln3tXuxtBRFcXQ+pL3u/L+D4zoS9LB9DylsGLLXDqoR8krdwFunxPrrV
         7XOg==
X-Gm-Message-State: AGi0PuZlObdqI14ebordPqJLC6OGi07P0GphDgYy91tEysRGSnje7uuN
        u4x90ewpzfUKXgzUM1k+Y6NwSStW
X-Google-Smtp-Source: APiQypIV3wfskg5VjFL18D5hTFdB/lowWCSg/muD5jMVoE+ZC3H2+KDW6/WMcJSK+ua3drl/otJstQ==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr8247861plc.209.1586382955755;
        Wed, 08 Apr 2020 14:55:55 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:55 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 16/20] ext4: fast commit recovery path preparation
Date:   Wed,  8 Apr 2020 14:55:26 -0700
Message-Id: <20200408215530.25649-16-harshads@google.com>
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

Prepare for making ext4 fast commit recovery path changes. Make a few
existing functions visible. Break and add a  wrapper around
ext4_get_inode_loc to allow reading inode from disk without having
a corresponding VFS inode.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |  7 ++++
 fs/ext4/inode.c             | 64 +++++++++++++++++++++++++++----------
 fs/ext4/ioctl.c             |  6 ++--
 fs/ext4/namei.c             |  2 +-
 include/trace/events/ext4.h |  8 ++---
 5 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c4e74bcbbf90..7c9ca8b962f8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2740,6 +2740,8 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
@@ -2786,6 +2788,8 @@ extern int  ext4_sync_inode(handle_t *, struct inode *);
 extern void ext4_dirty_inode(struct inode *, int);
 extern int ext4_change_inode_journal_flag(struct inode *, int);
 extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
+extern int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
+			  struct ext4_iloc *iloc);
 extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
@@ -2819,12 +2823,15 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 /* ioctl.c */
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
+extern void ext4_reset_inode_seed(struct inode *inode);
 
 /* migrate.c */
 extern int ext4_ext_migrate(struct inode *);
 extern int ext4_ind_migrate(struct inode *inode);
 
 /* namei.c */
+extern int ext4_init_new_dir(handle_t *handle, struct inode *dir,
+			     struct inode *inode);
 extern int ext4_dirblock_csum_verify(struct inode *inode,
 				     struct buffer_head *bh);
 extern int ext4_orphan_add(handle_t *, struct inode *);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9cbd3f98c5f3..b5ca07497bbc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -101,8 +101,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 	return provided == calculated;
 }
 
-static void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
-				struct ext4_inode_info *ei)
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei)
 {
 	__u32 csum;
 
@@ -4251,22 +4251,22 @@ int ext4_truncate(struct inode *inode)
  * data in memory that is needed to recreate the on-disk version of this
  * inode.
  */
-static int __ext4_get_inode_loc(struct inode *inode,
-				struct ext4_iloc *iloc, int in_mem)
+static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
+				struct ext4_iloc *iloc, int in_mem,
+				ext4_fsblk_t *ret_block)
 {
 	struct ext4_group_desc	*gdp;
 	struct buffer_head	*bh;
-	struct super_block	*sb = inode->i_sb;
 	ext4_fsblk_t		block;
 	struct blk_plug		plug;
 	int			inodes_per_block, inode_offset;
 
 	iloc->bh = NULL;
-	if (inode->i_ino < EXT4_ROOT_INO ||
-	    inode->i_ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
+	if (ino < EXT4_ROOT_INO ||
+	    ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
 		return -EFSCORRUPTED;
 
-	iloc->block_group = (inode->i_ino - 1) / EXT4_INODES_PER_GROUP(sb);
+	iloc->block_group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
 	gdp = ext4_get_group_desc(sb, iloc->block_group, NULL);
 	if (!gdp)
 		return -EIO;
@@ -4275,7 +4275,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	 * Figure out the offset within the block group inode table
 	 */
 	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
-	inode_offset = ((inode->i_ino - 1) %
+	inode_offset = ((ino - 1) %
 			EXT4_INODES_PER_GROUP(sb));
 	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
 	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
@@ -4376,7 +4376,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		 * has in-inode xattrs, or we don't have this inode in memory.
 		 * Read the block from disk.
 		 */
-		trace_ext4_load_inode(inode);
+		trace_ext4_load_inode(sb, ino);
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
@@ -4384,8 +4384,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
 		simulate_eio:
-			ext4_error_inode_block(inode, block, EIO,
-					       "unable to read itable block");
+			if (ret_block)
+				*ret_block = block;
 			brelse(bh);
 			return -EIO;
 		}
@@ -4395,11 +4395,43 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	return 0;
 }
 
+static int __ext4_get_inode_loc_noinmem(struct inode *inode,
+					struct ext4_iloc *iloc)
+{
+	ext4_fsblk_t err_blk;
+	int ret;
+
+	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc, 0,
+					&err_blk);
+
+	if (ret == -EIO)
+		ext4_error_inode_block(inode, err_blk, EIO,
+					"unable to read itable block");
+
+	return ret;
+}
+
 int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 {
+	ext4_fsblk_t err_blk;
+	int ret;
+
 	/* We have all inode data except xattrs in memory here. */
-	return __ext4_get_inode_loc(inode, iloc,
-		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
+	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc,
+		!ext4_test_inode_state(inode, EXT4_STATE_XATTR), &err_blk);
+
+	if (ret == -EIO)
+		ext4_error_inode_block(inode, err_blk, EIO,
+					"unable to read itable block");
+
+	return ret;
+}
+
+
+int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
+			  struct ext4_iloc *iloc)
+{
+	return __ext4_get_inode_loc(sb, ino, iloc, 0, NULL);
 }
 
 static bool ext4_should_use_dax(struct inode *inode)
@@ -4551,7 +4583,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
 
-	ret = __ext4_get_inode_loc(inode, &iloc, 0);
+	ret = __ext4_get_inode_loc_noinmem(inode, &iloc);
 	if (ret < 0)
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
@@ -5142,7 +5174,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 	} else {
 		struct ext4_iloc iloc;
 
-		err = __ext4_get_inode_loc(inode, &iloc, 0);
+		err = __ext4_get_inode_loc_noinmem(inode, &iloc);
 		if (err)
 			return err;
 		/*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f66bcf185f5b..93523709f039 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -86,7 +86,7 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
 	i_size_write(inode2, isize);
 }
 
-static void reset_inode_seed(struct inode *inode)
+void ext4_reset_inode_seed(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
@@ -199,8 +199,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	inode->i_generation = prandom_u32();
 	inode_bl->i_generation = prandom_u32();
-	reset_inode_seed(inode);
-	reset_inode_seed(inode_bl);
+	ext4_reset_inode_seed(inode);
+	ext4_reset_inode_seed(inode_bl);
 
 	ext4_discard_preallocations(inode);
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2d9c3767d8d6..3e69006e79f4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2742,7 +2742,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	return ext4_next_entry(de, blocksize);
 }
 
-static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
+int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 			     struct inode *inode)
 {
 	struct buffer_head *dir_block = NULL;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 4f7c9c00910e..8f31fd427ccc 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1755,9 +1755,9 @@ TRACE_EVENT(ext4_ext_load_extent,
 );
 
 TRACE_EVENT(ext4_load_inode,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct super_block *sb, unsigned long ino),
 
-	TP_ARGS(inode),
+	TP_ARGS(sb, ino),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev		)
@@ -1765,8 +1765,8 @@ TRACE_EVENT(ext4_load_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
-		__entry->ino		= inode->i_ino;
+		__entry->dev		= sb->s_dev;
+		__entry->ino		= ino;
 	),
 
 	TP_printk("dev %d,%d ino %ld",
-- 
2.26.0.110.g2183baf09c-goog

