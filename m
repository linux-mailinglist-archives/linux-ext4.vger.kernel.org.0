Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF617D993
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCIHGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:11 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52727 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgCIHGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:10 -0400
Received: by mail-pj1-f66.google.com with SMTP id f15so327515pjq.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMWbGKfRKQeJN3GaijBQQqFxZKtaZAKFARMCJ56xrvc=;
        b=QkZ+i8SUddGf5BwdmJSiXwxjWdvOxc6JW+C2UfueztDd0o0cjDxy5uKHFUxAc/yzDC
         T1ZaOpGlKV610AyV+woRh1+DsO/MJfA1DttvZQTfzL6alYUMcPUGefh82ig0+gUrwR9r
         DHXvhVwYqhsBHt2XJqoP09vS5MC19X4WCrgFoHUoTvYmcecZvG0Uo8wva22fNTShjEgq
         Ces0Fgmn4M25csEdv0PmIFwXMPRg3IhNCboJu0efJye9XadQloPtFfiVYe862NtOdsfg
         9xFlWkA9H4kaXM1V+2pURAt/GaGIvLCFQzb/ifjf6Nu8dl6/RiGbmByCjpmz36ZYwX/U
         frSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMWbGKfRKQeJN3GaijBQQqFxZKtaZAKFARMCJ56xrvc=;
        b=kbxpXuO97aQRZFB+E77iAvNxI6+WZpB2xbDbNQ/qS0TodsS06ylK98GvxRmcqwGuqp
         RtohWRByykkiM32fpPM1vAjNRTi3kVn4VVBg/yWe64KRh4vXcSnnXu42whTiS1VO8Pb8
         JAqiosy9Y/cMzUK8J03mcJcnHLo6pyfBRj75iRvtYh/xmBWWaC8glA0fPVHzINWHX6v3
         12UfYUu/R4aIdnVG9/9q8xOySCrIuWcrbK6fMo5g6RKEj4c3UUdrbkUJkzx0/fmM6Aqk
         CEJ6zXwJjWdPOyYNPe3PE06qflMiRJYikyZeUqoJMX3zGBTwUKjsDTv3hCQ6HZz7FSnK
         qSnQ==
X-Gm-Message-State: ANhLgQ1UDZeZcE4f3OK7R+pGKgO33Uuob//tpY4PxxHvKWHpGLnI+Ybi
        R6t8f8Yhivku392vOItR5BcXzn50
X-Google-Smtp-Source: ADFU+vtkAbO9lsiMxASGHtwK1YY+nQ0NJMh/sHpPdv0O4eQdLJWOJMgwzyV11Lxc17ydMl1vZ80k3Q==
X-Received: by 2002:a17:90a:1b6c:: with SMTP id q99mr17520757pjq.115.1583737567530;
        Mon, 09 Mar 2020 00:06:07 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:06 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 16/20] ext4: fast commit recovery path preparation
Date:   Mon,  9 Mar 2020 00:05:22 -0700
Message-Id: <20200309070526.218202-16-harshadshirwadkar@gmail.com>
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

Prepare for making ext4 fast commit recovery path changes. Make a few
existing functions visible. Break and add a  wrapper around
ext4_get_inode_loc to allow reading inode from disk without having
a corresponding VFS inode.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |  7 +++++++
 fs/ext4/inode.c             | 34 +++++++++++++++++++---------------
 fs/ext4/ioctl.c             |  6 +++---
 fs/ext4/namei.c             |  2 +-
 include/trace/events/ext4.h |  8 ++++----
 5 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 401d28b57d81..6dacbb95cc52 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2741,6 +2741,8 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
@@ -2787,6 +2789,8 @@ extern int  ext4_sync_inode(handle_t *, struct inode *);
 extern void ext4_dirty_inode(struct inode *, int);
 extern int ext4_change_inode_journal_flag(struct inode *, int);
 extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
+extern int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
+			  struct ext4_iloc *iloc);
 extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
@@ -2820,12 +2824,15 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
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
index b209f81a01b6..66e56ac6d028 100644
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
 
@@ -4235,22 +4235,21 @@ int ext4_truncate(struct inode *inode)
  * data in memory that is needed to recreate the on-disk version of this
  * inode.
  */
-static int __ext4_get_inode_loc(struct inode *inode,
+static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 				struct ext4_iloc *iloc, int in_mem)
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
@@ -4259,7 +4258,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	 * Figure out the offset within the block group inode table
 	 */
 	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
-	inode_offset = ((inode->i_ino - 1) %
+	inode_offset = ((ino - 1) %
 			EXT4_INODES_PER_GROUP(sb));
 	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
 	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
@@ -4360,7 +4359,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		 * has in-inode xattrs, or we don't have this inode in memory.
 		 * Read the block from disk.
 		 */
-		trace_ext4_load_inode(inode);
+		trace_ext4_load_inode(sb, ino);
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
@@ -4368,9 +4367,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
 		simulate_eio:
-			ext4_set_errno(inode->i_sb, EIO);
-			EXT4_ERROR_INODE_BLOCK(inode, block,
-					       "unable to read itable block");
+			ext4_set_errno(sb, EIO);
+			ext4_error(sb, "unable to read itable block");
 			brelse(bh);
 			return -EIO;
 		}
@@ -4383,10 +4381,16 @@ static int __ext4_get_inode_loc(struct inode *inode,
 int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 {
 	/* We have all inode data except xattrs in memory here. */
-	return __ext4_get_inode_loc(inode, iloc,
+	return __ext4_get_inode_loc(inode->i_sb, inode->i_ino, iloc,
 		!ext4_test_inode_state(inode, EXT4_STATE_XATTR));
 }
 
+int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
+			  struct ext4_iloc *iloc)
+{
+	return __ext4_get_inode_loc(sb, ino, iloc, 0);
+}
+
 static bool ext4_should_use_dax(struct inode *inode)
 {
 	if (!test_opt(inode->i_sb, DAX))
@@ -4536,7 +4540,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
 
-	ret = __ext4_get_inode_loc(inode, &iloc, 0);
+	ret = __ext4_get_inode_loc(sb, inode->i_ino, &iloc, 0);
 	if (ret < 0)
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
@@ -5128,7 +5132,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 	} else {
 		struct ext4_iloc iloc;
 
-		err = __ext4_get_inode_loc(inode, &iloc, 0);
+		err = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, &iloc, 0);
 		if (err)
 			return err;
 		/*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 3ea66e929afe..e0f274fc5874 100644
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
index ae0e112c65d5..5b21fedd2348 100644
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
index c8a05453f166..c1c2f193a604 100644
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
2.25.1.481.gfbce0eb801-goog

