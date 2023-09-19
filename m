Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB77A5D22
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 10:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjISI5z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjISI5r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 04:57:47 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43187116
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 01:57:40 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id iE0mqXQH06NwhiWWfqy4L9; Tue, 19 Sep 2023 08:56:09 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWWVqDGNWHFsOiWWfqzyzP; Tue, 19 Sep 2023 08:56:09 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=65096229
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=pGLkceISAAAA:8
 a=RPJ6JBhKAAAA:8 a=r0t2UcEzMhTVQyylJSYA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 4/7] [v2] lib: remove e2fsck context from bh emulation
Date:   Tue, 19 Sep 2023 02:55:49 -0600
Message-Id: <20230919085552.25262-4-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919085552.25262-1-adilger@dilger.ca>
References: <20230919085552.25262-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJKltDuyek5a8XRZtbby1oqzZAm3ybKVr+qHC7w9/fWC3oyKBh6aVVguNfd3g+HTE9uNregyVVE90ZBQDSSH8TseE2bCF+mU/2GFEfBs40pZyFU1pU5Q
 yZj7p336MnsBo+bY4PiYMlFKnBYK7m9Df3UVQFlE8w7sNMtHUi76QPrMUzMpMUwW9l+DIapgJELwf/5goupws5cwFgWmNJdzyn8FuEij+UKvTwvd7RSx+Wgc
 D0UPS580Ltv+ul2kORI2mPN35bLXK39rbGjwmaX+gKff0VwpJ4yKBmf8uZ9grLyY
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@gmail.com>

In order to generalize journal handing, remove the e2fsck
context from generic structures like buffer_head, and device.
But fast commit code wants an e2fsck context as well, so move
the context pointer to journal struct.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 e2fsck/journal.c        | 46 ++++++++++++++++++++---------------------
 lib/ext2fs/jfs_compat.h |  2 ++
 lib/support/jbd2_user.h | 12 -----------
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 367ec31d..d6129ed1 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -58,7 +58,7 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long block,
 		return 0;
 	}
 
-	retval= ext2fs_bmap2(inode->i_ctx->fs, inode->i_ino,
+	retval= ext2fs_bmap2(inode->i_fs, inode->i_ino,
 			     &inode->i_ext2, NULL, 0, (blk64_t) block,
 			     0, &pblk);
 	*phys = pblk;
@@ -70,11 +70,12 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 			   int blocksize)
 {
 	struct buffer_head *bh;
-	int bufsize = sizeof(*bh) + kdev->k_ctx->fs->blocksize -
+	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
 		sizeof(bh->b_data);
+	errcode_t retval;
 
-	bh = e2fsck_allocate_memory(kdev->k_ctx, bufsize, "block buffer");
-	if (!bh)
+	retval = ext2fs_get_memzero(bufsize, &bh);
+	if (retval)
 		return NULL;
 
 	if (journal_enable_debug >= 3)
@@ -82,11 +83,11 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
 		  blocknr, blocksize, bh_count);
 
-	bh->b_ctx = kdev->k_ctx;
+	bh->b_fs = kdev->k_fs;
 	if (kdev->k_dev == K_DEV_FS)
-		bh->b_io = kdev->k_ctx->fs->io;
+		bh->b_io = kdev->k_fs->io;
 	else
-		bh->b_io = kdev->k_ctx->fs->journal_io;
+		bh->b_io = kdev->k_fs->journal_io;
 	bh->b_size = blocksize;
 	bh->b_blocknr = blocknr;
 
@@ -98,9 +99,9 @@ int sync_blockdev(kdev_t kdev)
 	io_channel	io;
 
 	if (kdev->k_dev == K_DEV_FS)
-		io = kdev->k_ctx->fs->io;
+		io = kdev->k_fs->io;
 	else
-		io = kdev->k_ctx->fs->journal_io;
+		io = kdev->k_fs->journal_io;
 
 	return io_channel_flush(io) ? -EIO : 0;
 }
@@ -120,7 +121,7 @@ void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
 						     bh->b_blocknr,
 						     1, bh->b_data);
 			if (retval) {
-				com_err(bh->b_ctx->device_name, retval,
+				com_err(bh->b_fs->device_name, retval,
 					"while reading block %llu\n",
 					bh->b_blocknr);
 				bh->b_err = (int) retval;
@@ -135,7 +136,7 @@ void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
 						      bh->b_blocknr,
 						      1, bh->b_data);
 			if (retval) {
-				com_err(bh->b_ctx->device_name, retval,
+				com_err(bh->b_fs->device_name, retval,
 					"while writing block %llu\n",
 					bh->b_blocknr);
 				bh->b_err = (int) retval;
@@ -223,7 +224,7 @@ static int process_journal_block(ext2_filsys fs,
 static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 				int off, tid_t expected_tid)
 {
-	e2fsck_t ctx = j->j_fs_dev->k_ctx;
+	e2fsck_t ctx = j->j_ctx;
 	struct e2fsck_fc_replay_state *state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_add_range ext;
@@ -805,7 +806,7 @@ static int ext4_fc_handle_del_range(e2fsck_t ctx, __u8 *val)
 static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 				enum passtype pass, int off, tid_t expected_tid)
 {
-	e2fsck_t ctx = journal->j_fs_dev->k_ctx;
+	e2fsck_t ctx = journal->j_ctx;
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_tl tl;
@@ -933,10 +934,11 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	}
 	dev_journal = dev_fs+1;
 
-	dev_fs->k_ctx = dev_journal->k_ctx = ctx;
+	dev_fs->k_fs = dev_journal->k_fs = ctx->fs;
 	dev_fs->k_dev = K_DEV_FS;
 	dev_journal->k_dev = K_DEV_JOURNAL;
 
+	journal->j_ctx = ctx;
 	journal->j_dev = dev_journal;
 	journal->j_fs_dev = dev_fs;
 	journal->j_inode = NULL;
@@ -961,7 +963,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			goto errout;
 		}
 
-		j_inode->i_ctx = ctx;
+		j_inode->i_fs = ctx->fs;
 		j_inode->i_ino = sb->s_journal_inum;
 
 		if ((retval = ext2fs_read_inode(ctx->fs,
@@ -1203,9 +1205,8 @@ static errcode_t e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
 }
 
 #define V1_SB_SIZE	0x0024
-static void clear_v2_journal_fields(journal_t *journal)
+static void clear_v2_journal_fields(e2fsck_t ctx, journal_t *journal)
 {
-	e2fsck_t ctx = journal->j_dev->k_ctx;
 	struct problem_context pctx;
 
 	clear_problem_context(&pctx);
@@ -1220,9 +1221,8 @@ static void clear_v2_journal_fields(journal_t *journal)
 }
 
 
-static errcode_t e2fsck_journal_load(journal_t *journal)
+static errcode_t e2fsck_journal_load(e2fsck_t ctx, journal_t *journal)
 {
-	e2fsck_t ctx = journal->j_dev->k_ctx;
 	journal_superblock_t *jsb;
 	struct buffer_head *jbh = journal->j_sb_buffer;
 	struct problem_context pctx;
@@ -1248,14 +1248,14 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 		    jsb->s_feature_incompat ||
 		    jsb->s_feature_ro_compat ||
 		    jsb->s_nr_users)
-			clear_v2_journal_fields(journal);
+			clear_v2_journal_fields(ctx, journal);
 		break;
 
 	case JBD2_SUPERBLOCK_V2:
 		journal->j_format_version = 2;
 		if (ntohl(jsb->s_nr_users) > 1 &&
 		    uuid_is_null(ctx->fs->super->s_journal_uuid))
-			clear_v2_journal_fields(journal);
+			clear_v2_journal_fields(ctx, journal);
 		if (ntohl(jsb->s_nr_users) > 1) {
 			fix_problem(ctx, PR_0_JOURNAL_UNSUPP_MULTIFS, &pctx);
 			return EXT2_ET_JOURNAL_UNSUPP_VERSION;
@@ -1442,7 +1442,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		return retval;
 	}
 
-	retval = e2fsck_journal_load(journal);
+	retval = e2fsck_journal_load(ctx, journal);
 	if (retval) {
 		if ((retval == EXT2_ET_CORRUPT_JOURNAL_SB) ||
 		    ((retval == EXT2_ET_UNSUPP_FEATURE) &&
@@ -1560,7 +1560,7 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 	if (retval)
 		return retval;
 
-	retval = e2fsck_journal_load(journal);
+	retval = e2fsck_journal_load(ctx, journal);
 	if (retval)
 		goto errout;
 
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index 0e96b56c..938ee600 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -37,6 +37,7 @@ typedef struct kdev_s *kdev_t;
 
 struct buffer_head;
 struct inode;
+struct e2fsck_struct;
 
 typedef unsigned int gfp_t;
 #define GFP_KERNEL	0
@@ -94,6 +95,7 @@ struct journal_s
 	struct jbd2_revoke_table_s *j_revoke_table[2];
 	tid_t			j_failed_commit;
 	__u32			j_csum_seed;
+	struct e2fsck_struct *	j_ctx;
 	int (*j_fc_replay_callback)(struct journal_s *journal,
 				    struct buffer_head *bh,
 				    enum passtype pass, int off,
diff --git a/lib/support/jbd2_user.h b/lib/support/jbd2_user.h
index e4316f58..73473663 100644
--- a/lib/support/jbd2_user.h
+++ b/lib/support/jbd2_user.h
@@ -41,11 +41,7 @@
 #endif
 
 struct buffer_head {
-#ifdef DEBUGFS
 	ext2_filsys	b_fs;
-#else
-	e2fsck_t	b_ctx;
-#endif
 	io_channel	b_io;
 	int		b_size;
 	int		b_err;
@@ -56,21 +52,13 @@ struct buffer_head {
 };
 
 struct inode {
-#ifdef DEBUGFS
 	ext2_filsys	i_fs;
-#else
-	e2fsck_t	i_ctx;
-#endif
 	ext2_ino_t	i_ino;
 	struct ext2_inode i_ext2;
 };
 
 struct kdev_s {
-#ifdef DEBUGFS
 	ext2_filsys	k_fs;
-#else
-	e2fsck_t	k_ctx;
-#endif
 	int		k_dev;
 };
 
-- 
2.25.1

