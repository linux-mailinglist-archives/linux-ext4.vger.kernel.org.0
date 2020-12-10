Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B242D644C
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392914AbgLJSAm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 13:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392985AbgLJR5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:22 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898BC0611C5
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:47 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w5so4140959pgj.3
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BonF8649NDeNtuVjliUA05A8wcCiaaIn8/qLKQNE5Hw=;
        b=qyPPxnBleLnhzsALhpHdqx3733he6njcYBH/2jX9ReSGD+70Ickx4I9+J9442Gzin+
         WY7uSMJMjhalJ+68X46opYKs6iCOQma5pXM6FaX1kVik/fWIBSGNsEZVe3azzJUM6dHI
         OV5JifRDeuuUmGP6jxMJCdlEfwVLReEasAPsZ2cmjzpSIuQ7Qk4EMNWautFMPXM3husU
         mtq/DvA059x8Ho63FQbOKNM9Zx3S54umxvHRbhd+zIohQDHUw56f2SPJ4MWGHTPaAr27
         TiWZlAJ/LawPzm57VX/emrhhQVCJZS3KvwzMZ+2H543E74GVu2jCp3IhPr9AZDkxFyMi
         OV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BonF8649NDeNtuVjliUA05A8wcCiaaIn8/qLKQNE5Hw=;
        b=eiZOCVuSjphc6L9DX3zdRKsz4aEEpHLi/8o00DujjUFCSYblO1PZsU77ICmNPkRVE7
         V+Z16BJ4Uu9fcktCjDLkSU3xKUwR3nV0H+OHwEOtl2GeyDcxrkEwc21aCwLqKNipoyIt
         qdEYtP9HFHBgitQyzQNNRF9vrx77RM1KB8qhzosdd86Na36j1Xx9LYOt0Sa6i0mywMGq
         uuS10dj5osouQeiy5C3eq4yOsXbg3soLBGcJYJVl9PU+xzVzJENmrWWmgICLschjl73Q
         0sUSg96BiFX347aPk0zyjQmd5tE6J1Gk05zNFVHL641Nnz/4kC4Oq5SnCxgPSYAUfhzG
         eaIw==
X-Gm-Message-State: AOAM5337l8Ix609tTNTlLaHl43amAHhqrjohaJ3DfyFyqDPvcMBFwnez
        tIsazOHr4QDBsShfKSwPQcpiNCTSTRc=
X-Google-Smtp-Source: ABdhPJyqX2IC8I/x2h30L0cEE008nspNI7iYgZijyCU/SigZ70rNgGe6I3HT8AgnNkGVsuO4IJywMQ==
X-Received: by 2002:a63:1a1d:: with SMTP id a29mr7683409pga.19.1607623006714;
        Thu, 10 Dec 2020 09:56:46 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:45 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 08/15] e2fsck: add fast commit setup code
Date:   Thu, 10 Dec 2020 09:56:01 -0800
Message-Id: <20201210175608.3265541-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add fast_commit.h that contains the necessary helpers needed for fast
commit replay. Note that this file is also byte by byte identical with
kernel's fast_commit.h. Also, we introduce the
"e2fsck_fc_replay_state" structure which is needed for ext4 fast
commit replay.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/e2fsck.h          |  16 +++
 e2fsck/journal.c         |  15 +++
 lib/ext2fs/ext2_fs.h     |   1 +
 lib/ext2fs/ext2fs.h      |   3 +
 lib/ext2fs/fast_commit.h | 203 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 238 insertions(+)
 create mode 100644 lib/ext2fs/fast_commit.h

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 3b9c1874..f75cc343 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -68,6 +68,7 @@
 #endif
 
 #include "support/quotaio.h"
+#include "ext2fs/fast_commit.h"
 
 /*
  * Exit codes used by fsck-type programs
@@ -239,6 +240,18 @@ struct extent_list {
 	errcode_t retval;
 	ext2_ino_t ino;
 };
+
+/* State structure for fast commit replay */
+struct e2fsck_fc_replay_state {
+	struct extent_list fc_extent_list;
+	int fc_replay_num_tags;
+	int fc_replay_expected_off;
+	int fc_current_pass;
+	int fc_cur_tag;
+	int fc_crc;
+	__u16 fc_super_state;
+};
+
 struct e2fsck_struct {
 	ext2_filsys fs;
 	const char *program_name;
@@ -431,6 +444,9 @@ struct e2fsck_struct {
 
 	/* Undo file */
 	char *undo_file;
+
+	/* Fast commit replay state */
+	struct e2fsck_fc_replay_state fc_replay_state;
 };
 
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 75fefcde..2c8e3441 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -278,6 +278,17 @@ static int process_journal_block(ext2_filsys fs,
 	return 0;
 }
 
+/*
+ * Main recovery path entry point. This function returns JBD2_FC_REPLAY_CONTINUE
+ * to indicate that it is expecting more fast commit blocks. It returns
+ * JBD2_FC_REPLAY_STOP to indicate that replay is done.
+ */
+static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
+				enum passtype pass, int off, tid_t expected_tid)
+{
+	return JBD2_FC_REPLAY_STOP;
+}
+
 static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 {
 	struct process_block_struct pb;
@@ -514,6 +525,10 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
+	if (ext2fs_has_feature_fast_commit(ctx->fs->super))
+		journal->j_fc_replay_callback = ext4_fc_replay;
+	else
+		journal->j_fc_replay_callback = NULL;
 
 #ifdef USE_INODE_IO
 	if (j_inode)
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index bfc30c29..b1e4329c 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -543,6 +543,7 @@ struct ext2_inode *EXT2_INODE(struct ext2_inode_large *large_inode)
 #define EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
 #define EXT2_ERROR_FS			0x0002	/* Errors detected */
 #define EXT3_ORPHAN_FS			0x0004	/* Orphans being recovered */
+#define EXT4_FC_REPLAY			0x0020	/* Ext4 fast commit replay ongoing */
 
 /*
  * Misc. filesystem flags
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index fdcb28f6..eb2e6549 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -2148,4 +2148,7 @@ static inline unsigned int ext2_dir_htree_level(ext2_filsys fs)
 }
 #endif
 
+/* Commonly used helpers */
+#define max(a, b) ((a) > (b) ? (a) : (b))
+
 #endif /* _EXT2FS_EXT2FS_H */
diff --git a/lib/ext2fs/fast_commit.h b/lib/ext2fs/fast_commit.h
new file mode 100644
index 00000000..b83e1810
--- /dev/null
+++ b/lib/ext2fs/fast_commit.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __FAST_COMMIT_H__
+#define __FAST_COMMIT_H__
+
+#include "jfs_compat.h"
+
+/*
+ * Note this file is present in e2fsprogs/lib/ext2fs/fast_commit.h and
+ * linux/fs/ext4/fast_commit.h. These file should always be byte identical.
+ */
+
+/* Fast commit tags */
+#define EXT4_FC_TAG_ADD_RANGE		0x0001
+#define EXT4_FC_TAG_DEL_RANGE		0x0002
+#define EXT4_FC_TAG_CREAT		0x0003
+#define EXT4_FC_TAG_LINK		0x0004
+#define EXT4_FC_TAG_UNLINK		0x0005
+#define EXT4_FC_TAG_INODE		0x0006
+#define EXT4_FC_TAG_PAD			0x0007
+#define EXT4_FC_TAG_TAIL		0x0008
+#define EXT4_FC_TAG_HEAD		0x0009
+
+#define EXT4_FC_SUPPORTED_FEATURES	0x0
+
+/* On disk fast commit tlv value structures */
+
+/* Fast commit on disk tag length structure */
+struct ext4_fc_tl {
+	__le16 fc_tag;
+	__le16 fc_len;
+};
+
+/* Value structure for tag EXT4_FC_TAG_HEAD. */
+struct ext4_fc_head {
+	__le32 fc_features;
+	__le32 fc_tid;
+};
+
+/* Value structure for EXT4_FC_TAG_ADD_RANGE. */
+struct ext4_fc_add_range {
+	__le32 fc_ino;
+	__u8 fc_ex[12];
+};
+
+/* Value structure for tag EXT4_FC_TAG_DEL_RANGE. */
+struct ext4_fc_del_range {
+	__le32 fc_ino;
+	__le32 fc_lblk;
+	__le32 fc_len;
+};
+
+/*
+ * This is the value structure for tags EXT4_FC_TAG_CREAT, EXT4_FC_TAG_LINK
+ * and EXT4_FC_TAG_UNLINK.
+ */
+struct ext4_fc_dentry_info {
+	__le32 fc_parent_ino;
+	__le32 fc_ino;
+	__u8 fc_dname[0];
+};
+
+/* Value structure for EXT4_FC_TAG_INODE and EXT4_FC_TAG_INODE_PARTIAL. */
+struct ext4_fc_inode {
+	__le32 fc_ino;
+	__u8 fc_raw_inode[0];
+};
+
+/* Value structure for tag EXT4_FC_TAG_TAIL. */
+struct ext4_fc_tail {
+	__le32 fc_tid;
+	__le32 fc_crc;
+};
+
+/*
+ * Fast commit reason codes
+ */
+enum {
+	/*
+	 * Commit status codes:
+	 */
+	EXT4_FC_REASON_OK = 0,
+	EXT4_FC_REASON_INELIGIBLE,
+	EXT4_FC_REASON_ALREADY_COMMITTED,
+	EXT4_FC_REASON_FC_START_FAILED,
+	EXT4_FC_REASON_FC_FAILED,
+
+	/*
+	 * Fast commit ineligiblity reasons:
+	 */
+	EXT4_FC_REASON_XATTR = 0,
+	EXT4_FC_REASON_CROSS_RENAME,
+	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
+	EXT4_FC_REASON_NOMEM,
+	EXT4_FC_REASON_SWAP_BOOT,
+	EXT4_FC_REASON_RESIZE,
+	EXT4_FC_REASON_RENAME_DIR,
+	EXT4_FC_REASON_FALLOC_RANGE,
+	EXT4_FC_REASON_INODE_JOURNAL_DATA,
+	EXT4_FC_COMMIT_FAILED,
+	EXT4_FC_REASON_MAX
+};
+
+#ifdef __KERNEL__
+/*
+ * In memory list of dentry updates that are performed on the file
+ * system used by fast commit code.
+ */
+struct ext4_fc_dentry_update {
+	int fcd_op;		/* Type of update create / unlink / link */
+	int fcd_parent;		/* Parent inode number */
+	int fcd_ino;		/* Inode number */
+	struct qstr fcd_name;	/* Dirent name */
+	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
+	struct list_head fcd_list;
+};
+
+struct ext4_fc_stats {
+	unsigned int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
+	unsigned long fc_num_commits;
+	unsigned long fc_ineligible_commits;
+	unsigned long fc_numblks;
+};
+
+#define EXT4_FC_REPLAY_REALLOC_INCREMENT	4
+
+/*
+ * Physical block regions added to different inodes due to fast commit
+ * recovery. These are set during the SCAN phase. During the replay phase,
+ * our allocator excludes these from its allocation. This ensures that
+ * we don't accidentally allocating a block that is going to be used by
+ * another inode.
+ */
+struct ext4_fc_alloc_region {
+	ext4_lblk_t lblk;
+	ext4_fsblk_t pblk;
+	int ino, len;
+};
+
+/*
+ * Fast commit replay state.
+ */
+struct ext4_fc_replay_state {
+	int fc_replay_num_tags;
+	int fc_replay_expected_off;
+	int fc_current_pass;
+	int fc_cur_tag;
+	int fc_crc;
+	struct ext4_fc_alloc_region *fc_regions;
+	int fc_regions_size, fc_regions_used, fc_regions_valid;
+	int *fc_modified_inodes;
+	int fc_modified_inodes_used, fc_modified_inodes_size;
+};
+
+#define region_last(__region) (((__region)->lblk) + ((__region)->len) - 1)
+#endif
+
+#define fc_for_each_tl(__start, __end, __tl)				\
+	for (tl = (struct ext4_fc_tl *)(__start);			\
+	     (__u8 *)tl < (__u8 *)(__end);				\
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +			\
+					sizeof(struct ext4_fc_tl) +	\
+					+ le16_to_cpu(tl->fc_len)))
+
+static inline const char *tag2str(__u16 tag)
+{
+	switch (tag) {
+	case EXT4_FC_TAG_LINK:
+		return "ADD_ENTRY";
+	case EXT4_FC_TAG_UNLINK:
+		return "DEL_ENTRY";
+	case EXT4_FC_TAG_ADD_RANGE:
+		return "ADD_RANGE";
+	case EXT4_FC_TAG_CREAT:
+		return "CREAT_DENTRY";
+	case EXT4_FC_TAG_DEL_RANGE:
+		return "DEL_RANGE";
+	case EXT4_FC_TAG_INODE:
+		return "INODE";
+	case EXT4_FC_TAG_PAD:
+		return "PAD";
+	case EXT4_FC_TAG_TAIL:
+		return "TAIL";
+	case EXT4_FC_TAG_HEAD:
+		return "HEAD";
+	default:
+		return "ERROR";
+	}
+}
+
+/* Get length of a particular tlv */
+static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
+{
+	return le16_to_cpu(tl->fc_len);
+}
+
+/* Get a pointer to "value" of a tlv */
+static inline __u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
+{
+	return (__u8 *)tl + sizeof(*tl);
+}
+
+#endif /* __FAST_COMMIT_H__ */
-- 
2.29.2.576.ga3fc446d84-goog

