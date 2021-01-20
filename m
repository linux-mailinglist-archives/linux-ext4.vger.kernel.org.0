Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A92FDE10
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393227AbhAUAan (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbhATVbh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1759C0617A6
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m5so3037058pjv.5
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LlLcW8fzUC32ddu0SX7GqKcyuiAZjcHSMTYkbPaWmfU=;
        b=QAuXu+V2xQ18sDK4Jo0ccGvlnw1qBr4uxwSR7KRVizUF7SHOFPAABwh/8IfBhHBjKg
         irSpueA0TmT3BUNubNsNMnJ++Xfn5D+ZHD6GHi0lGznoRRy2FEoouWATuhQEZHZlnPn6
         uKdUqb+NpucH8fcCBHP8UBYh/fQDBlroPHY6msZx50SFk361zSik+cYZJ1XhrgAtpemz
         DQHZZnkn0lwaaFaiGJ4mw5vcrfcrCOdvWmYCMHpZ5gqZclKhymWu/cgz4HM5GmqB423T
         Uf6MlcCl8bIetBIP37Kqz3UULfERs5h40qW4jFTJd+a2V01R7rY5rKWIfCIePsVUlt3i
         cstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlLcW8fzUC32ddu0SX7GqKcyuiAZjcHSMTYkbPaWmfU=;
        b=PqMNfKAKBgAS7oDxiweOzMpbfXdDYX1GhaPO0XqgflNg6NNLC4hZ+qE+2BTP4xVEt4
         nmARRC0FRdrCgpCvMhKMc55ewH3Gi+wh6zkanNPltjkZPoX6itWpu+ejli0pX+TrPa24
         qq94Y6D0btgCsfHDu0Rt6BO+cuPGXavQ5NxPpG4ZkDW1Pa8+xvmi2YnTep3m9vnCYqtW
         IloaZ7EmsamHK4jKrEr8TA6GBwXUiZVeBc5mmMkavfY+exeCiNqizSEQqzh3VaVrc03a
         ZrauFEtEDaQUDT0t4vavGAY8e2V07luwjiBd9EhxNeaoMBoB5kVe7gDe+tSO1quFfvhk
         rAhw==
X-Gm-Message-State: AOAM531+Jq+uHQA51hHmL8EPEPrnoLJfXB37DEcuWQUQQmNCySZ3T+Z+
        s/mo3k6C61+jK/oCuZIAwUh6edKOj5M=
X-Google-Smtp-Source: ABdhPJwtZEGm3fi3W7ghn8JN6Di+i1U9zoYryZ7FoRPHf5+CyJZ1inER4/U3blWQ+o8h3tnqPzhe/w==
X-Received: by 2002:a17:90b:1b50:: with SMTP id nv16mr7501410pjb.153.1611178010835;
        Wed, 20 Jan 2021 13:26:50 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:50 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 04/15] libext2fs: provide APIs to configure fast commit blocks
Date:   Wed, 20 Jan 2021 13:26:30 -0800
Message-Id: <20210120212641.526556-5-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch adds new libext2fs that allow configuring number of fast
commit blocks in journal superblock. We also add a struct
ext2fs_journal_params which contains number of fast commit blocks and
number of normal journal blocks. With this patch, the preferred way
for configuring number of blocks with and without fast commits is:

struct ext2fs_journal_params params;

ext2fs_get_journal_params(&params, ...);
params.num_journal_blocks = ...;
params.num_fc_blocks = ...;
ext2fs_create_journal_superblock2(..., &params, ...);
         OR
ext2fs_add_journal_inode3(..., &params, ...);

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/e2p/e2p.h          |  1 +
 lib/e2p/ljs.c          | 16 +++++--
 lib/ext2fs/ext2fs.h    | 18 ++++++++
 lib/ext2fs/mkjournal.c | 96 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 113 insertions(+), 18 deletions(-)

diff --git a/lib/e2p/e2p.h b/lib/e2p/e2p.h
index 90efb624..65702a7e 100644
--- a/lib/e2p/e2p.h
+++ b/lib/e2p/e2p.h
@@ -47,6 +47,7 @@ void print_fs_state (FILE * f, unsigned short state);
 int setflags (int fd, unsigned long flags);
 int setversion (int fd, unsigned long version);
 
+#define E2P_LIST_JOURNAL_FLAG_FC		0x1
 void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 			    int exp_block_size, int flags);
 
diff --git a/lib/e2p/ljs.c b/lib/e2p/ljs.c
index 4ffe9b61..d118ec44 100644
--- a/lib/e2p/ljs.c
+++ b/lib/e2p/ljs.c
@@ -54,7 +54,12 @@ void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 	unsigned int size;
 	int j, printed = 0;
 	unsigned int i, nr_users;
+	int num_fc_blks = 0;
+	int journal_blks = 0;
 
+	if (flags & E2P_LIST_JOURNAL_FLAG_FC)
+		num_fc_blks = jbd_get_num_fc_blks((journal_superblock_t *)journal_sb_buf);
+	journal_blks = ntohl(jsb->s_maxlen) - num_fc_blks;
 	fprintf(f, "%s", "Journal features:        ");
 	for (i=0, mask_ptr=&jsb->s_feature_compat; i <3; i++,mask_ptr++) {
 		mask = e2p_be32(*mask_ptr);
@@ -68,7 +73,7 @@ void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 	if (printed == 0)
 		fprintf(f, " (none)");
 	fputc('\n', f);
-	fputs("Journal size:             ", f);
+	fputs("Total journal size:       ", f);
 	size = (ntohl(jsb->s_blocksize) / 1024) * ntohl(jsb->s_maxlen);
 	if (size < 8192)
 		fprintf(f, "%uk\n", size);
@@ -78,8 +83,13 @@ void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 	if (exp_block_size != (int) ntohl(jsb->s_blocksize))
 		fprintf(f, "Journal block size:       %u\n",
 			(unsigned int)ntohl(jsb->s_blocksize));
-	fprintf(f, "Journal length:           %u\n",
-		(unsigned int)ntohl(jsb->s_maxlen));
+	fprintf(f, "Total journal blocks:     %u\n",
+		(unsigned int)(journal_blks + num_fc_blks));
+	fprintf(f, "Max transaction length:   %u\n",
+		(unsigned int)journal_blks);
+	fprintf(f, "Fast commit length:       %u\n",
+		(unsigned int)num_fc_blks);
+
 	if (ntohl(jsb->s_first) != 1)
 		fprintf(f, "Journal first block:      %u\n",
 			(unsigned int)ntohl(jsb->s_first));
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index a8a6e091..ec841006 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -220,6 +220,12 @@ typedef struct ext2_file *ext2_file_t;
 #define EXT2_MKJOURNAL_LAZYINIT	0x0000002 /* don't zero journal inode before use*/
 #define EXT2_MKJOURNAL_NO_MNT_CHECK 0x0000004 /* don't check mount status */
 
+/*
+ * Normal journal area size to fast commit area size ratio. This is used to
+ * set default size of fast commit area.
+ */
+#define EXT2_JOURNAL_TO_FC_BLKS_RATIO		64
+
 struct blk_alloc_ctx;
 struct opaque_ext2_group_desc;
 
@@ -1620,6 +1626,12 @@ extern errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum
 			      const char *name);
 
 /* mkjournal.c */
+struct ext2fs_journal_params {
+	blk_t num_journal_blocks;
+	blk_t num_fc_blocks;
+};
+extern errcode_t ext2fs_get_journal_params(
+		struct ext2fs_journal_params *params, ext2_filsys fs);
 extern errcode_t ext2fs_zero_blocks(ext2_filsys fs, blk_t blk, int num,
 				    blk_t *ret_blk, int *ret_count);
 extern errcode_t ext2fs_zero_blocks2(ext2_filsys fs, blk64_t blk, int num,
@@ -1627,12 +1639,18 @@ extern errcode_t ext2fs_zero_blocks2(ext2_filsys fs, blk64_t blk, int num,
 extern errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
 						  __u32 num_blocks, int flags,
 						  char  **ret_jsb);
+extern errcode_t ext2fs_create_journal_superblock2(ext2_filsys fs,
+						  struct ext2fs_journal_params *params,
+						  int flags, char  **ret_jsb);
 extern errcode_t ext2fs_add_journal_device(ext2_filsys fs,
 					   ext2_filsys journal_dev);
 extern errcode_t ext2fs_add_journal_inode(ext2_filsys fs, blk_t num_blocks,
 					  int flags);
 extern errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
 					   blk64_t goal, int flags);
+extern errcode_t ext2fs_add_journal_inode3(ext2_filsys fs,
+				    struct ext2fs_journal_params *params,
+				    blk64_t goal, int flags);
 extern int ext2fs_default_journal_size(__u64 num_blocks);
 extern int ext2fs_journal_sb_start(int blocksize);
 
diff --git a/lib/ext2fs/mkjournal.c b/lib/ext2fs/mkjournal.c
index f47f71e6..732ba7d6 100644
--- a/lib/ext2fs/mkjournal.c
+++ b/lib/ext2fs/mkjournal.c
@@ -12,6 +12,7 @@
 #include "config.h"
 #include <stdio.h>
 #include <string.h>
+#include <assert.h>
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
@@ -43,14 +44,14 @@
  * This function automatically sets up the journal superblock and
  * returns it as an allocated block.
  */
-errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
-					   __u32 num_blocks, int flags,
-					   char  **ret_jsb)
+errcode_t ext2fs_create_journal_superblock2(ext2_filsys fs,
+					   struct ext2fs_journal_params *jparams,
+					   int flags, char **ret_jsb)
 {
 	errcode_t		retval;
 	journal_superblock_t	*jsb;
 
-	if (num_blocks < JBD2_MIN_JOURNAL_BLOCKS)
+	if (jparams->num_journal_blocks < JBD2_MIN_JOURNAL_BLOCKS)
 		return EXT2_ET_JOURNAL_TOO_SMALL;
 
 	if ((retval = ext2fs_get_mem(fs->blocksize, &jsb)))
@@ -64,10 +65,11 @@ errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
 	else
 		jsb->s_header.h_blocktype = htonl(JBD2_SUPERBLOCK_V2);
 	jsb->s_blocksize = htonl(fs->blocksize);
-	jsb->s_maxlen = htonl(num_blocks);
+	jsb->s_maxlen = htonl(jparams->num_journal_blocks + jparams->num_fc_blocks);
 	jsb->s_nr_users = htonl(1);
 	jsb->s_first = htonl(1);
 	jsb->s_sequence = htonl(1);
+	jsb->s_num_fc_blks = htonl(jparams->num_fc_blocks);
 	memcpy(jsb->s_uuid, fs->super->s_uuid, sizeof(fs->super->s_uuid));
 	/*
 	 * If we're creating an external journal device, we need to
@@ -82,20 +84,32 @@ errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
 	return 0;
 }
 
+errcode_t ext2fs_create_journal_superblock(ext2_filsys fs, __u32 num_blocks,
+					int flags, char **ret_sb)
+{
+	struct ext2fs_journal_params jparams;
+
+	jparams.num_journal_blocks = num_blocks;
+	jparams.num_fc_blocks = 0;
+
+	return ext2fs_create_journal_superblock2(fs, &jparams, flags, ret_sb);
+}
+
 /*
  * This function writes a journal using POSIX routines.  It is used
  * for creating external journals and creating journals on live
  * filesystems.
  */
 static errcode_t write_journal_file(ext2_filsys fs, char *filename,
-				    blk_t num_blocks, int flags)
+				    struct ext2fs_journal_params *jparams,
+				    int flags)
 {
 	errcode_t	retval;
 	char		*buf = 0;
 	int		fd, ret_size;
 	blk_t		i;
 
-	if ((retval = ext2fs_create_journal_superblock(fs, num_blocks, flags,
+	if ((retval = ext2fs_create_journal_superblock2(fs, jparams, flags,
 						       &buf)))
 		return retval;
 
@@ -119,7 +133,7 @@ static errcode_t write_journal_file(ext2_filsys fs, char *filename,
 	if (flags & EXT2_MKJOURNAL_LAZYINIT)
 		goto success;
 
-	for (i = 1; i < num_blocks; i++) {
+	for (i = 1; i < jparams->num_journal_blocks + jparams->num_fc_blocks; i++) {
 		ret_size = write(fd, buf, fs->blocksize);
 		if (ret_size < 0) {
 			retval = errno;
@@ -262,7 +276,8 @@ static blk64_t get_midpoint_journal_block(ext2_filsys fs)
  * This function creates a journal using direct I/O routines.
  */
 static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
-				     blk_t num_blocks, blk64_t goal, int flags)
+				     struct ext2fs_journal_params *jparams,
+				     blk64_t goal, int flags)
 {
 	char			*buf;
 	errcode_t		retval;
@@ -271,7 +286,7 @@ static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
 	int			falloc_flags = EXT2_FALLOCATE_FORCE_INIT;
 	blk64_t			zblk;
 
-	if ((retval = ext2fs_create_journal_superblock(fs, num_blocks, flags,
+	if ((retval = ext2fs_create_journal_superblock2(fs, jparams, flags,
 						       &buf)))
 		return retval;
 
@@ -295,7 +310,8 @@ static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
 	if (!(flags & EXT2_MKJOURNAL_LAZYINIT))
 		falloc_flags |= EXT2_FALLOCATE_ZERO_BLOCKS;
 
-	inode_size = (unsigned long long)fs->blocksize * num_blocks;
+	inode_size = (unsigned long long)fs->blocksize *
+			(jparams->num_journal_blocks + jparams->num_fc_blocks);
 	inode.i_mtime = inode.i_ctime = fs->now ? fs->now : time(0);
 	inode.i_links_count = 1;
 	inode.i_mode = LINUX_S_IFREG | 0600;
@@ -304,7 +320,8 @@ static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
 		goto out2;
 
 	retval = ext2fs_fallocate(fs, falloc_flags, journal_ino,
-				  &inode, goal, 0, num_blocks);
+				  &inode, goal, 0,
+				  jparams->num_journal_blocks + jparams->num_fc_blocks);
 	if (retval)
 		goto out2;
 
@@ -358,6 +375,43 @@ int ext2fs_default_journal_size(__u64 num_blocks)
 	return 262144;				/* 1 GB */
 }
 
+errcode_t ext2fs_get_journal_params(struct ext2fs_journal_params *params,
+		ext2_filsys fs)
+{
+	blk_t total_blks;
+	int ret;
+
+	memset(params, 0, sizeof(*params));
+	if (ext2fs_has_feature_journal_dev(fs->super)) {
+		total_blks = ext2fs_blocks_count(fs->super);
+		if (total_blks < JBD2_MIN_JOURNAL_BLOCKS)
+			return EXT2_ET_JOURNAL_TOO_SMALL;
+
+		if (!ext2fs_has_feature_fast_commit(fs->super)) {
+			params->num_journal_blocks = total_blks;
+			params->num_fc_blocks = 0;
+			return 0;
+		}
+		params->num_journal_blocks = ext2fs_blocks_count(fs->super) *
+				EXT2_JOURNAL_TO_FC_BLKS_RATIO /
+				(EXT2_JOURNAL_TO_FC_BLKS_RATIO + 1);
+		if (JBD2_MIN_JOURNAL_BLOCKS > params->num_journal_blocks)
+			params->num_journal_blocks = JBD2_MIN_JOURNAL_BLOCKS;
+		params->num_fc_blocks = total_blks - params->num_journal_blocks;
+		return 0;
+	}
+
+	ret = ext2fs_default_journal_size(ext2fs_blocks_count(fs->super));
+	if (ret < 0)
+		return EXT2_ET_JOURNAL_TOO_SMALL;
+
+	params->num_journal_blocks = ret;
+	if (ext2fs_has_feature_fast_commit(fs->super))
+		params->num_fc_blocks = params->num_journal_blocks /
+			EXT2_JOURNAL_TO_FC_BLKS_RATIO;
+	return 0;
+}
+
 int ext2fs_journal_sb_start(int blocksize)
 {
 	if (blocksize == EXT2_MIN_BLOCK_SIZE)
@@ -434,7 +488,7 @@ errcode_t ext2fs_add_journal_device(ext2_filsys fs, ext2_filsys journal_dev)
  * POSIX routines if the filesystem is mounted, or using direct I/O
  * functions if it is not.
  */
-errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
+errcode_t ext2fs_add_journal_inode3(ext2_filsys fs, struct ext2fs_journal_params *jparams,
 				    blk64_t goal, int flags)
 {
 	errcode_t		retval;
@@ -486,7 +540,7 @@ errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
 		 * filesystems is extremely rare these days...  Ignore it. */
 		flags &= ~EXT2_MKJOURNAL_LAZYINIT;
 
-		if ((retval = write_journal_file(fs, jfile, num_blocks, flags)))
+		if ((retval = write_journal_file(fs, jfile, jparams, flags)))
 			goto errout;
 
 		/* Get inode number of the journal file */
@@ -528,7 +582,7 @@ errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
 		}
 		journal_ino = EXT2_JOURNAL_INO;
 		if ((retval = write_journal_inode(fs, journal_ino,
-						  num_blocks, goal, flags)))
+						  jparams, goal, flags)))
 			return retval;
 	}
 
@@ -546,6 +600,18 @@ errout:
 	return retval;
 }
 
+errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
+				    blk64_t goal, int flags)
+{
+	struct ext2fs_journal_params jparams;
+	errcode_t ret;
+
+	jparams.num_journal_blocks = num_blocks;
+	jparams.num_fc_blocks = 0;
+
+	return ext2fs_add_journal_inode3(fs, &jparams, goal, flags);
+}
+
 errcode_t ext2fs_add_journal_inode(ext2_filsys fs, blk_t num_blocks, int flags)
 {
 	return ext2fs_add_journal_inode2(fs, num_blocks, ~0ULL, flags);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

