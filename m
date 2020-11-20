Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259842BB504
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgKTTQ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgKTTQ3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:29 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02CC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i13so8102800pgm.9
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VcMOaeyz0ktxpU6MKQrj/GLeTsJJb5U72B60NctIIZw=;
        b=lhqyaOt+QCiTWZUBqQVRWetD1e0CJtt5kCGcLAC+7XLNsRTP64PS8sgfv4nj1d51zt
         YaRBcMWXzfkHBqXMevxaEvUJ6R0rMMceZbdnw1K/W9QaBRr0OShG6tbVu6pLHECO0DB5
         HD8HU2oiwL96piAR2/jCP/UIElwY3AKZ17Wf+UCi0DPXJtWoi3f50KfypiX91b8O2eVH
         RvnwbjwhWbYHArWL448dCPtyuzMdtAX49e/7+eQNRYWEYLLsYI42xhLWVNDmGau4zIPu
         28ZUwQkY9+mkjn5WWj1T00eHcbhpp3tLnKzt3yp2O3mzQr8sepsXNce1mdQ2gH/BCPvu
         KdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcMOaeyz0ktxpU6MKQrj/GLeTsJJb5U72B60NctIIZw=;
        b=QC9XsZytDXH0ymOp+BUNwcd2+B3ecZX1ncJuYjNkkepjrDxMm/qGIK0ZzIG/X5LcfX
         OkLcvaZs4Yfu+qECR87arDGQYtNXywF7BCWfNxAQllt26mKxGsMPjzUWi6BebH7AQlh6
         jkobuj/WaK4zg7LYkH+59Z0Vz0+g7hG07O4RmVuBRP5KAxTH/+93rIQPghP5TrEuGwG0
         6DPHSBzcoJZxYOcvk978qqhahnUmQeI51ubg0EjuOI6mZ1BXWhV2uH6Gq7lyQS8ExSTC
         0kRh1lnGxhdoTJGRqY5BbKAmrZT6y96tKUx0uZukZK8i8bKEtcgz+PdznrcU15ntRPh/
         E1Xg==
X-Gm-Message-State: AOAM5328YulYZhVPmXwM30IiP2C/5yO0oy6xnHlvngA9ABiSF5T3ygUQ
        nkBzFSTTohaRN7ZL9WrJmHVrR3I9j68=
X-Google-Smtp-Source: ABdhPJway0sgv7+CFgj82MdU4hhtmL5Zajt1NGeetwzYQ8sQj+QydfIjw5ZKFFA84fa6U0pV57xcAA==
X-Received: by 2002:a17:90a:458e:: with SMTP id v14mr11844064pjg.40.1605899787969;
        Fri, 20 Nov 2020 11:16:27 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:26 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 04/15] mke2fs, dumpe2fs: make fast commit blocks configurable
Date:   Fri, 20 Nov 2020 11:15:55 -0800
Message-Id: <20201120191606.2224881-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch makes number of fast commit blocks configurable. Also, the
number of fast commit blocks can now be seen in dumpe2fs output.

$ ./misc/mke2fs -O fast_commit -t ext4 image
mke2fs 1.46-WIP (20-Mar-2020)
Discarding device blocks: done
Creating filesystem with 5120 1k blocks and 1280 inodes
Allocating group tables: done
Writing inode tables: done
Creating journal (1040 blocks): done
Writing superblocks and filesystem accounting information: done

$ ./misc/dumpe2fs image
dumpe2fs 1.46-WIP (20-Mar-2020)
...
Journal features:         (none)
Total journal size:       1040k
Total journal blocks:     1040
Max transaction length:   1024
Fast commit length:       16
Journal sequence:         0x00000001
Journal start:            0

$ ./misc/mke2fs -O fast_commit -t ext4 image -J fast_commit_size=256,size=1
mke2fs 1.46-WIP (20-Mar-2020)
Creating filesystem with 5120 1k blocks and 1280 inodes
Allocating group tables: done
Writing inode tables: done
Creating journal (1280 blocks): done
Writing superblocks and filesystem accounting information: done

$ ./misc/dumpe2fs image
dumpe2fs 1.46-WIP (20-Mar-2020)
...
Journal features:         (none)
Total journal size:       1280k
Total journal blocks:     1280
Max transaction length:   1024
Fast commit length:       256
Journal sequence:         0x00000001
Journal start:            0

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/unix.c          |  8 ++--
 lib/e2p/e2p.h          |  1 +
 lib/e2p/ljs.c          | 16 +++++--
 lib/ext2fs/ext2fs.h    | 21 ++++++---
 lib/ext2fs/mkjournal.c | 99 +++++++++++++++++++++++++++++-------------
 misc/dumpe2fs.c        | 10 ++++-
 misc/mke2fs.c          | 24 +++++++---
 misc/tune2fs.c         |  8 ++--
 misc/util.c            | 63 ++++++++++++++++++++-------
 misc/util.h            |  4 +-
 10 files changed, 185 insertions(+), 69 deletions(-)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 1cb51672..3162896a 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1388,7 +1388,7 @@ int main (int argc, char *argv[])
 	blk64_t		orig_superblock = ~(blk64_t)0;
 	struct problem_context pctx;
 	int flags, run_result, was_changed;
-	int journal_size;
+	int journal_size, journal_fc_size;
 	int sysval, sys_page_size = 4096;
 	int old_bitmaps;
 	__u32 features[3];
@@ -1912,7 +1912,7 @@ print_unsupp_features:
 	    (ctx->flags & E2F_FLAG_JOURNAL_INODE)) {
 		if (fix_problem(ctx, PR_6_RECREATE_JOURNAL, &pctx)) {
 			if (journal_size < 1024)
-				journal_size = ext2fs_default_journal_size(ext2fs_blocks_count(fs->super));
+				ext2fs_default_journal_size(&journal_size, &journal_fc_size, fs);
 			if (journal_size < 0) {
 				ext2fs_clear_feature_journal(fs->super);
 				fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
@@ -1923,8 +1923,8 @@ print_unsupp_features:
 			log_out(ctx, _("Creating journal (%d blocks): "),
 			       journal_size);
 			fflush(stdout);
-			retval = ext2fs_add_journal_inode(fs,
-							  journal_size, 0);
+			retval = ext2fs_add_journal_inode(fs, journal_size,
+					journal_fc_size, 0);
 			if (retval) {
 				log_out(ctx, "%s: while trying to create "
 					"journal\n", error_message(retval));
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
index 4ffe9b61..9f866c7e 100644
--- a/lib/e2p/ljs.c
+++ b/lib/e2p/ljs.c
@@ -54,7 +54,12 @@ void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 	unsigned int size;
 	int j, printed = 0;
 	unsigned int i, nr_users;
+	int num_fc_blks = 0;
+	int journal_blks = 0;
 
+	if (flags & E2P_LIST_JOURNAL_FLAG_FC)
+		num_fc_blks = jbd2_journal_get_num_fc_blks((journal_superblock_t *)journal_sb_buf);
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
index a8a6e091..01132245 100644
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
 
@@ -1625,15 +1631,18 @@ extern errcode_t ext2fs_zero_blocks(ext2_filsys fs, blk_t blk, int num,
 extern errcode_t ext2fs_zero_blocks2(ext2_filsys fs, blk64_t blk, int num,
 				     blk64_t *ret_blk, int *ret_count);
 extern errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
-						  __u32 num_blocks, int flags,
-						  char  **ret_jsb);
+						  __u32 num_blocks, __u32 num_fc_blks,
+						  int flags, char  **ret_jsb);
+extern errcode_t ext2fs_split_journal_size(ext2_filsys fs, blk_t *journal_blks,
+					   blk_t *fc_blks, blk_t total_blks);
 extern errcode_t ext2fs_add_journal_device(ext2_filsys fs,
 					   ext2_filsys journal_dev);
 extern errcode_t ext2fs_add_journal_inode(ext2_filsys fs, blk_t num_blocks,
-					  int flags);
+					  blk_t num_fc_blocks, int flags);
 extern errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
-					   blk64_t goal, int flags);
-extern int ext2fs_default_journal_size(__u64 num_blocks);
+				    blk_t num_fc_blocks,
+				    blk64_t goal, int flags);
+extern errcode_t ext2fs_default_journal_size(int *journal_size, int *fc_size, ext2_filsys fs);
 extern int ext2fs_journal_sb_start(int blocksize);
 
 /* openfs.c */
@@ -2122,6 +2131,8 @@ static inline unsigned int ext2_dir_htree_level(ext2_filsys fs)
 	return EXT4_HTREE_LEVEL_COMPAT;
 }
 
+#define max(a, b) ((a) > (b) ? (a) : (b))
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/ext2fs/mkjournal.c b/lib/ext2fs/mkjournal.c
index f47f71e6..74d0c7fc 100644
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
@@ -39,13 +40,32 @@
 
 #include "kernel-jbd.h"
 
+errcode_t ext2fs_split_journal_size(ext2_filsys fs, blk_t *journal_blks,
+		blk_t *fc_blks, blk_t total_blks)
+{
+	if (total_blks < JBD2_MIN_JOURNAL_BLOCKS)
+		return EXT2_ET_JOURNAL_TOO_SMALL;
+
+	if (!ext2fs_has_feature_fast_commit(fs->super)) {
+		*journal_blks = total_blks;
+		*fc_blks = 0;
+		return 0;
+	}
+	*journal_blks = ext2fs_blocks_count(fs->super) *
+			EXT2_JOURNAL_TO_FC_BLKS_RATIO /
+			(EXT2_JOURNAL_TO_FC_BLKS_RATIO + 1);
+	*journal_blks = max(JBD2_MIN_JOURNAL_BLOCKS, *journal_blks);
+	*fc_blks = total_blks - *journal_blks;
+	return 0;
+}
+
 /*
  * This function automatically sets up the journal superblock and
  * returns it as an allocated block.
  */
 errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
-					   __u32 num_blocks, int flags,
-					   char  **ret_jsb)
+					   __u32 num_blocks, __u32 num_fc_blks,
+					   int flags, char  **ret_jsb)
 {
 	errcode_t		retval;
 	journal_superblock_t	*jsb;
@@ -64,10 +84,11 @@ errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
 	else
 		jsb->s_header.h_blocktype = htonl(JBD2_SUPERBLOCK_V2);
 	jsb->s_blocksize = htonl(fs->blocksize);
-	jsb->s_maxlen = htonl(num_blocks);
+	jsb->s_maxlen = htonl(num_blocks + num_fc_blks);
 	jsb->s_nr_users = htonl(1);
 	jsb->s_first = htonl(1);
 	jsb->s_sequence = htonl(1);
+	jsb->s_num_fc_blks = htonl(num_fc_blks);
 	memcpy(jsb->s_uuid, fs->super->s_uuid, sizeof(fs->super->s_uuid));
 	/*
 	 * If we're creating an external journal device, we need to
@@ -88,14 +109,16 @@ errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
  * filesystems.
  */
 static errcode_t write_journal_file(ext2_filsys fs, char *filename,
-				    blk_t num_blocks, int flags)
+				    blk_t num_blocks, blk_t num_fc_blocks,
+				    int flags)
 {
 	errcode_t	retval;
 	char		*buf = 0;
 	int		fd, ret_size;
 	blk_t		i;
 
-	if ((retval = ext2fs_create_journal_superblock(fs, num_blocks, flags,
+	if ((retval = ext2fs_create_journal_superblock(fs, num_blocks,
+						       num_fc_blocks, flags,
 						       &buf)))
 		return retval;
 
@@ -119,7 +142,7 @@ static errcode_t write_journal_file(ext2_filsys fs, char *filename,
 	if (flags & EXT2_MKJOURNAL_LAZYINIT)
 		goto success;
 
-	for (i = 1; i < num_blocks; i++) {
+	for (i = 1; i < num_blocks + num_fc_blocks; i++) {
 		ret_size = write(fd, buf, fs->blocksize);
 		if (ret_size < 0) {
 			retval = errno;
@@ -262,7 +285,8 @@ static blk64_t get_midpoint_journal_block(ext2_filsys fs)
  * This function creates a journal using direct I/O routines.
  */
 static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
-				     blk_t num_blocks, blk64_t goal, int flags)
+				     blk_t num_blocks, blk_t num_fc_blocks,
+				     blk64_t goal, int flags)
 {
 	char			*buf;
 	errcode_t		retval;
@@ -271,7 +295,8 @@ static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
 	int			falloc_flags = EXT2_FALLOCATE_FORCE_INIT;
 	blk64_t			zblk;
 
-	if ((retval = ext2fs_create_journal_superblock(fs, num_blocks, flags,
+	if ((retval = ext2fs_create_journal_superblock(fs, num_blocks,
+						       num_fc_blocks, flags,
 						       &buf)))
 		return retval;
 
@@ -295,7 +320,8 @@ static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
 	if (!(flags & EXT2_MKJOURNAL_LAZYINIT))
 		falloc_flags |= EXT2_FALLOCATE_ZERO_BLOCKS;
 
-	inode_size = (unsigned long long)fs->blocksize * num_blocks;
+	inode_size = (unsigned long long)fs->blocksize *
+			(num_blocks + num_fc_blocks);
 	inode.i_mtime = inode.i_ctime = fs->now ? fs->now : time(0);
 	inode.i_links_count = 1;
 	inode.i_mode = LINUX_S_IFREG | 0600;
@@ -304,7 +330,7 @@ static errcode_t write_journal_inode(ext2_filsys fs, ext2_ino_t journal_ino,
 		goto out2;
 
 	retval = ext2fs_fallocate(fs, falloc_flags, journal_ino,
-				  &inode, goal, 0, num_blocks);
+				  &inode, goal, 0, num_blocks + num_fc_blocks);
 	if (retval)
 		goto out2;
 
@@ -337,25 +363,34 @@ out2:
  *
  * n.b. comments assume 4k blocks
  */
-int ext2fs_default_journal_size(__u64 num_blocks)
+errcode_t ext2fs_default_journal_size(int *journal_size, int *fc_size, ext2_filsys fs)
 {
+	__u64 num_blocks = ext2fs_blocks_count(fs->super);
+
 	if (num_blocks < 2048)
-		return -1;
+		return EXT2_ET_TOOSMALL;
 	if (num_blocks < 32768)		/* 128 MB */
-		return (1024);			/* 4 MB */
-	if (num_blocks < 256*1024)	/* 1 GB */
-		return (4096);			/* 16 MB */
-	if (num_blocks < 512*1024)	/* 2 GB */
-		return (8192);			/* 32 MB */
-	if (num_blocks < 4096*1024)	/* 16 GB */
-		return (16384);			/* 64 MB */
-	if (num_blocks < 8192*1024)	/* 32 GB */
-		return (32768);			/* 128 MB */
-	if (num_blocks < 16384*1024)	/* 64 GB */
-		return (65536);			/* 256 MB */
-	if (num_blocks < 32768*1024)	/* 128 GB */
-		return (131072);		/* 512 MB */
-	return 262144;				/* 1 GB */
+		*journal_size = 1024;		/* 4 MB */
+	else if (num_blocks < 256*1024)		/* 1 GB */
+		*journal_size = 4096;		/* 16 MB */
+	else if (num_blocks < 512*1024)	/* 2 GB */
+		*journal_size = 8192;		/* 32 MB */
+	else if (num_blocks < 4096*1024)	/* 16 GB */
+		*journal_size = 16384;		/* 64 MB */
+	else if (num_blocks < 8192*1024)	/* 32 GB */
+		*journal_size = 32768;		/* 128 MB */
+	else if (num_blocks < 16384*1024)	/* 64 GB */
+		*journal_size = 65536;		/* 256 MB */
+	else if (num_blocks < 32768*1024)	/* 128 GB */
+		*journal_size = 131072;		/* 512 MB */
+	else
+		*journal_size = 262144;	/* 1 GB */
+
+	*fc_size = ext2fs_has_feature_fast_commit(fs->super) ?
+		*journal_size / EXT2_JOURNAL_TO_FC_BLKS_RATIO : 0;
+	assert(*journal_size + *fc_size < num_blocks);
+
+	return 0;
 }
 
 int ext2fs_journal_sb_start(int blocksize)
@@ -435,6 +470,7 @@ errcode_t ext2fs_add_journal_device(ext2_filsys fs, ext2_filsys journal_dev)
  * functions if it is not.
  */
 errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
+				    blk_t num_fc_blocks,
 				    blk64_t goal, int flags)
 {
 	errcode_t		retval;
@@ -486,7 +522,8 @@ errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
 		 * filesystems is extremely rare these days...  Ignore it. */
 		flags &= ~EXT2_MKJOURNAL_LAZYINIT;
 
-		if ((retval = write_journal_file(fs, jfile, num_blocks, flags)))
+		if ((retval = write_journal_file(fs, jfile,
+			num_blocks, num_fc_blocks, flags)))
 			goto errout;
 
 		/* Get inode number of the journal file */
@@ -528,7 +565,8 @@ errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
 		}
 		journal_ino = EXT2_JOURNAL_INO;
 		if ((retval = write_journal_inode(fs, journal_ino,
-						  num_blocks, goal, flags)))
+						  num_blocks, num_fc_blocks,
+						  goal, flags)))
 			return retval;
 	}
 
@@ -546,9 +584,10 @@ errout:
 	return retval;
 }
 
-errcode_t ext2fs_add_journal_inode(ext2_filsys fs, blk_t num_blocks, int flags)
+errcode_t ext2fs_add_journal_inode(ext2_filsys fs, blk_t num_blocks,
+		blk_t num_fc_blocks, int flags)
 {
-	return ext2fs_add_journal_inode2(fs, num_blocks, ~0ULL, flags);
+	return ext2fs_add_journal_inode2(fs, num_blocks, num_fc_blocks, ~0ULL, flags);
 }
 
 
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index d295ba4d..e24dc4e6 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -364,6 +364,7 @@ static void print_inline_journal_information(ext2_filsys fs)
 	errcode_t		retval;
 	ext2_ino_t		ino = fs->super->s_journal_inum;
 	char			buf[1024];
+	int			flags;
 
 	if (fs->flags & EXT2_FLAG_IMAGE_FILE)
 		return;
@@ -392,7 +393,9 @@ static void print_inline_journal_information(ext2_filsys fs)
 			_("Journal superblock magic number invalid!\n"));
 		exit(1);
 	}
-	e2p_list_journal_super(stdout, buf, fs->blocksize, 0);
+	flags = ext2fs_has_feature_fast_commit(fs->super) ?
+			E2P_LIST_JOURNAL_FLAG_FC : 0;
+	e2p_list_journal_super(stdout, buf, fs->blocksize, flags);
 }
 
 static void print_journal_information(ext2_filsys fs)
@@ -400,6 +403,7 @@ static void print_journal_information(ext2_filsys fs)
 	errcode_t	retval;
 	char		buf[1024];
 	journal_superblock_t	*jsb;
+	int		flags;
 
 	/* Get the journal superblock */
 	if ((retval = io_channel_read_blk64(fs->io,
@@ -417,7 +421,9 @@ static void print_journal_information(ext2_filsys fs)
 			_("Couldn't find journal superblock magic numbers"));
 		exit(1);
 	}
-	e2p_list_journal_super(stdout, buf, fs->blocksize, 0);
+	flags = ext2fs_has_feature_fast_commit(fs->super) ?
+			E2P_LIST_JOURNAL_FLAG_FC : 0;
+	e2p_list_journal_super(stdout, buf, fs->blocksize, flags);
 }
 
 static int check_mmp(ext2_filsys fs)
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 8c8f5ea4..2d9a5449 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -93,6 +93,7 @@ static uid_t	root_uid;
 static gid_t	root_gid;
 int	journal_size;
 int	journal_flags;
+int	journal_fc_size;
 static int	lazy_itable_init;
 static int	packed_meta_blocks;
 int		no_copy_xattrs;
@@ -604,9 +605,18 @@ static void create_journal_dev(ext2_filsys fs)
 	char			*buf;
 	blk64_t			blk, err_blk;
 	int			c, count, err_count;
+	int			num_journal_blks = 0, num_fc_blks = 0;
+
+	retval = ext2fs_split_journal_size(fs, &num_journal_blks, &num_fc_blks,
+				ext2fs_blocks_count(fs->super));
+	if (retval) {
+		com_err("create_journal_dev", retval, "%s",
+			_("while splitting the journal size"));
+		exit(1);
+	}
 
 	retval = ext2fs_create_journal_superblock(fs,
-				  ext2fs_blocks_count(fs->super), 0, &buf);
+				  num_journal_blks, num_fc_blks, 0, &buf);
 	if (retval) {
 		com_err("create_journal_dev", retval, "%s",
 			_("while initializing journal superblock"));
@@ -1753,6 +1763,8 @@ profile_error:
 		case 'j':
 			if (!journal_size)
 				journal_size = -1;
+			if (!journal_fc_size)
+				journal_fc_size = -1;
 			break;
 		case 'J':
 			parse_journal_opts(optarg);
@@ -2937,7 +2949,7 @@ int main (int argc, char *argv[])
 	badblocks_list	bb_list = 0;
 	badblocks_iterate	bb_iter;
 	blk_t		blk;
-	unsigned int	journal_blocks = 0;
+	blk_t		journal_blocks = 0, journal_fc_blocks = 0;
 	unsigned int	i, checkinterval;
 	int		max_mnt_count;
 	int		val, hash_alg;
@@ -3047,7 +3059,8 @@ int main (int argc, char *argv[])
 	/* Calculate journal blocks */
 	if (!journal_device && ((journal_size) ||
 	    ext2fs_has_feature_journal(&fs_param)))
-		journal_blocks = figure_journal_size(journal_size, fs);
+		figure_journal_size(&journal_blocks, &journal_fc_blocks,
+			journal_size, journal_fc_size, fs);
 
 	sprintf(opt_string, "tdb_data_size=%d", fs->blocksize <= 4096 ?
 		32768 : fs->blocksize * 8);
@@ -3382,7 +3395,7 @@ int main (int argc, char *argv[])
 		free(journal_device);
 	} else if ((journal_size) ||
 		   ext2fs_has_feature_journal(&fs_param)) {
-		overhead += EXT2FS_NUM_B2C(fs, journal_blocks);
+		overhead += EXT2FS_NUM_B2C(fs, journal_blocks + journal_fc_blocks);
 		if (super_only) {
 			printf("%s", _("Skipping journal creation in super-only mode\n"));
 			fs->super->s_journal_inum = EXT2_JOURNAL_INO;
@@ -3395,10 +3408,11 @@ int main (int argc, char *argv[])
 		}
 		if (!quiet) {
 			printf(_("Creating journal (%u blocks): "),
-			       journal_blocks);
+			       journal_blocks + journal_fc_blocks);
 			fflush(stdout);
 		}
 		retval = ext2fs_add_journal_inode2(fs, journal_blocks,
+						   journal_fc_blocks,
 						   journal_location,
 						   journal_flags);
 		if (retval) {
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 670ed9e0..daee154d 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -102,7 +102,7 @@ static int feature_64bit;
 static int fsck_requested;
 static char *undo_file;
 
-int journal_size, journal_flags;
+int journal_size, journal_fc_size, journal_flags;
 char *journal_device;
 static blk64_t journal_location = ~0LL;
 
@@ -1543,7 +1543,7 @@ mmp_error:
  */
 static int add_journal(ext2_filsys fs)
 {
-	unsigned long journal_blocks;
+	blk_t journal_blocks, journal_fc_blocks;
 	errcode_t	retval;
 	ext2_filsys	jfs;
 	io_manager	io_ptr;
@@ -1589,13 +1589,15 @@ static int add_journal(ext2_filsys fs)
 	} else if (journal_size) {
 		fputs(_("Creating journal inode: "), stdout);
 		fflush(stdout);
-		journal_blocks = figure_journal_size(journal_size, fs);
+		figure_journal_size(&journal_blocks, &journal_fc_blocks,
+				    journal_size, journal_fc_size, fs);
 
 		if (journal_location_string)
 			journal_location =
 				parse_num_blocks2(journal_location_string,
 						  fs->super->s_log_block_size);
 		retval = ext2fs_add_journal_inode2(fs, journal_blocks,
+						   journal_fc_blocks,
 						   journal_location,
 						   journal_flags);
 		if (retval) {
diff --git a/misc/util.c b/misc/util.c
index dcd2f0a7..85f10a70 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -200,6 +200,14 @@ void parse_journal_opts(const char *opts)
 			journal_size = strtoul(arg, &p, 0);
 			if (*p)
 				journal_usage++;
+		} else if (strcmp(token, "fast_commit_size") == 0) {
+			if (!arg) {
+				journal_usage++;
+				continue;
+			}
+			journal_fc_size = strtoul(arg, &p, 0);
+			if (*p)
+				journal_usage++;
 		} else if (!strcmp(token, "location")) {
 			if (!arg) {
 				journal_usage++;
@@ -229,42 +237,65 @@ void parse_journal_opts(const char *opts)
 	free(buf);
 }
 
+static inline int jsize_to_blks(ext2_filsys fs, int size)
+{
+	return (size * 1024) / (fs->blocksize / 1024);
+}
+
+/* Fast commit size is in KBs */
+static inline int fcsize_to_blks(ext2_filsys fs, int size)
+{
+	return (size * 1024) / (fs->blocksize);
+}
+
 /*
  * Determine the number of journal blocks to use, either via
  * user-specified # of megabytes, or via some intelligently selected
  * defaults.
  *
- * Find a reasonable journal file size (in blocks) given the number of blocks
- * in the filesystem.  For very small filesystems, it is not reasonable to
- * have a journal that fills more than half of the filesystem.
+ * Find a reasonable journal file size (in blocks) given the number of blocks in
+ * the filesystem. For very small filesystems, it is not reasonable to have a
+ * journal that fills more than half of the filesystem.
  */
-unsigned int figure_journal_size(int size, ext2_filsys fs)
+void figure_journal_size(blk_t *j_blocks, blk_t *fc_blocks,
+		int requested_j_size, int requested_fc_size, ext2_filsys fs)
 {
-	int j_blocks;
+	int def_j_blocks, def_fc_blocks, total_blocks;
+	int ret;
 
-	j_blocks = ext2fs_default_journal_size(ext2fs_blocks_count(fs->super));
-	if (j_blocks < 0) {
+	ret = ext2fs_default_journal_size(&def_j_blocks, &def_fc_blocks, fs);
+	if (ret) {
 		fputs(_("\nFilesystem too small for a journal\n"), stderr);
-		return 0;
+		return;
 	}
 
-	if (size > 0) {
-		j_blocks = size * 1024 / (fs->blocksize	/ 1024);
-		if (j_blocks < 1024 || j_blocks > 10240000) {
-			fprintf(stderr, _("\nThe requested journal "
+	*j_blocks = def_j_blocks;
+	*fc_blocks = def_fc_blocks;
+
+	if (requested_j_size > 0 ||
+		(ext2fs_has_feature_fast_commit(fs->super) && requested_fc_size > 0)) {
+		*j_blocks = requested_j_size > 0 ?
+			jsize_to_blks(fs, requested_j_size) : def_j_blocks;
+
+		*fc_blocks = 0;
+		if (ext2fs_has_feature_fast_commit(fs->super))
+			*fc_blocks = requested_fc_size > 0 ?
+				fcsize_to_blks(fs, requested_fc_size) : def_fc_blocks;
+		total_blocks = *j_blocks + *fc_blocks;
+		if (total_blocks < 1024 || total_blocks > 10240000) {
+			fprintf(stderr, _("\nThe total requested journal "
 				"size is %d blocks; it must be\n"
 				"between 1024 and 10240000 blocks.  "
 				"Aborting.\n"),
-				j_blocks);
+				total_blocks);
 			exit(1);
 		}
-		if ((unsigned) j_blocks > ext2fs_free_blocks_count(fs->super) / 2) {
-			fputs(_("\nJournal size too big for filesystem.\n"),
+		if ((unsigned int) total_blocks > ext2fs_free_blocks_count(fs->super) / 2) {
+			fputs(_("\nTotal journal size too big for filesystem.\n"),
 			      stderr);
 			exit(1);
 		}
 	}
-	return j_blocks;
 }
 
 void print_check_message(int mnt, unsigned int check)
diff --git a/misc/util.h b/misc/util.h
index 49b4b9c1..cee812b4 100644
--- a/misc/util.h
+++ b/misc/util.h
@@ -11,6 +11,7 @@
  */
 
 extern int	 journal_size;
+extern int	 journal_fc_size;
 extern int	 journal_flags;
 extern char	*journal_device;
 extern char	*journal_location_string;
@@ -22,6 +23,7 @@ extern char *get_progname(char *argv_zero);
 extern void proceed_question(int delay);
 extern void parse_journal_opts(const char *opts);
 extern void check_mount(const char *device, int force, const char *type);
-extern unsigned int figure_journal_size(int size, ext2_filsys fs);
+extern void figure_journal_size(blk_t *j_blocks, blk_t *fc_blocks,
+		int requested_j_size, int requested_fc_size, ext2_filsys fs);
 extern void print_check_message(int, unsigned int);
 extern void dump_mmp_msg(struct mmp_struct *mmp, const char *msg);
-- 
2.29.2.454.gaff20da3a2-goog

