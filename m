Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD17E129EDF
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLXIPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38760 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfLXIPC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so10419928pfc.5
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rhdIUp0JlKEJ7hMySHf7VAtUKJ7QbVudbbCaYIxY7g=;
        b=hJnwG1ImZyFRaxKoywJ9XxSlAsKszdKr36KkKGg/lEfEdSIAb/C0oiZjntSy/2441n
         ZWS1UQDsPW1wCDyvYg/yCUYWjNTSyFxsEidTuQ7eIvdcoiHjVwnlqw4KFK7EzcTwMDf4
         UAcKR9UDDw625lDbAuGeDT8OJHu9S7jnJNJxsLlQtqnv/n0X7bTCpX0C5A0JO4aszaZ4
         RxcMxSYRFfm4IQpRauhWbnb71T0a/d/qh5Z3wCCRwVhOPys0B0suEUT3sazHWeRXTYEl
         ZFoPImHlIWCs4BybBh8NrYscVjP7MavpuTSDyxYPtPno0lLMUMgmxnF52SVeRhz7trz+
         uj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rhdIUp0JlKEJ7hMySHf7VAtUKJ7QbVudbbCaYIxY7g=;
        b=I37KC3Uci8L/4Z+J8/p5209BoPNALNo+pPsLZmFBnQnblcM/er06+eB99wJcvGDVLF
         KUaJTVfDAd01CvzE+jZ17aOVi8bTDdpFAC1/L0gVWrRTW3PB4uTpMkFspEG3vdNqbcqH
         AQIwkSLYrWRl+VeNJ3Xd26ucp/wzrgvq24kkfa3DJSDSpak5GMBrmzFNRCIcbzM4rxBW
         1TfBdw7IBrvYEZdQ56BGiCMWAQN6/eIYDAkDX0IW5r3eZ7PGPDFX5Hj8m34qTK39zk8p
         S+wBfo9i9q7NiUXwt1PxeZL5LKMc7wXdA8vLBOmyLiFsihg0NfIR3lVisY0pULY0R0PD
         rq2Q==
X-Gm-Message-State: APjAAAVQKXl1vcofqFbLQgZHox6pSGNod19cFxje/2VEKBSu7ZudCmlG
        34wrrFmBjp9vT/YdkXJvDP+tE2x9
X-Google-Smtp-Source: APXvYqzwiLIgB59BwAzHamEKEhsO+1M7hDzoXOaCCEotXFVaz04WqUMJ/LAclOpHPSAbFmUZIlkxpw==
X-Received: by 2002:a63:770c:: with SMTP id s12mr37069448pgc.25.1577175300995;
        Tue, 24 Dec 2019 00:15:00 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:15:00 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 16/20] ext4: fast commit recovery path preparation
Date:   Tue, 24 Dec 2019 00:13:20 -0800
Message-Id: <20191224081324.95807-16-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/inode.c             | 32 ++++++++++++++++++--------------
 fs/ext4/ioctl.c             |  6 +++---
 fs/ext4/namei.c             |  2 +-
 include/trace/events/ext4.h |  8 ++++----
 5 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9c2f67c64b4f..f2603deefe51 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2651,6 +2651,8 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
@@ -2699,6 +2701,8 @@ extern int  ext4_sync_inode(handle_t *, struct inode *);
 extern void ext4_dirty_inode(struct inode *, int);
 extern int ext4_change_inode_journal_flag(struct inode *, int);
 extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
+extern int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
+			  struct ext4_iloc *iloc);
 extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
@@ -2734,12 +2738,15 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
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
index c4cde431d5fa..e902000dac51 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -103,8 +103,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 	return provided == calculated;
 }
 
-static void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
-				struct ext4_inode_info *ei)
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei)
 {
 	__u32 csum;
 
@@ -4548,22 +4548,21 @@ int ext4_truncate(struct inode *inode)
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
@@ -4572,7 +4571,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	 * Figure out the offset within the block group inode table
 	 */
 	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
-	inode_offset = ((inode->i_ino - 1) %
+	inode_offset = ((ino - 1) %
 			EXT4_INODES_PER_GROUP(sb));
 	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
 	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
@@ -4671,15 +4670,14 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		 * has in-inode xattrs, or we don't have this inode in memory.
 		 * Read the block from disk.
 		 */
-		trace_ext4_load_inode(inode);
+		trace_ext4_load_inode(sb, ino);
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
 		blk_finish_plug(&plug);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
-			EXT4_ERROR_INODE_BLOCK(inode, block,
-					       "unable to read itable block");
+			ext4_error(sb, "unable to read itable block");
 			brelse(bh);
 			return -EIO;
 		}
@@ -4692,10 +4690,16 @@ static int __ext4_get_inode_loc(struct inode *inode,
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
@@ -4845,7 +4849,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
 
-	ret = __ext4_get_inode_loc(inode, &iloc, 0);
+	ret = __ext4_get_inode_loc(sb, inode->i_ino, &iloc, 0);
 	if (ret < 0)
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
@@ -5423,7 +5427,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 	} else {
 		struct ext4_iloc iloc;
 
-		err = __ext4_get_inode_loc(inode, &iloc, 0);
+		err = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, &iloc, 0);
 		if (err)
 			return err;
 		/*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 2bc655b2164e..59ff5f90ed2a 100644
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
index b732c0bb1d51..48fea5ce8530 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2710,7 +2710,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	return ext4_next_entry(de, blocksize);
 }
 
-static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
+int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 			     struct inode *inode)
 {
 	struct buffer_head *dir_block = NULL;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index e47059a02fec..8da371b38332 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1738,9 +1738,9 @@ TRACE_EVENT(ext4_ext_load_extent,
 );
 
 TRACE_EVENT(ext4_load_inode,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct super_block *sb, unsigned long ino),
 
-	TP_ARGS(inode),
+	TP_ARGS(sb, ino),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev		)
@@ -1748,8 +1748,8 @@ TRACE_EVENT(ext4_load_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
-		__entry->ino		= inode->i_ino;
+		__entry->dev		= sb->s_dev;
+		__entry->ino		= ino;
 	),
 
 	TP_printk("dev %d,%d ino %ld",
-- 
2.24.1.735.g03f4e72817-goog

