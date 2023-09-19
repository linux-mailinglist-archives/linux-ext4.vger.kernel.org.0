Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264F27A5D40
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjISJCt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjISJCq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 05:02:46 -0400
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E732A115
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 02:02:40 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id i7dPqdL1vLAoIiWcyq8H68; Tue, 19 Sep 2023 09:02:40 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWcpqDHfQHFsOiWcxqzzJ3; Tue, 19 Sep 2023 09:02:40 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=650963b0
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=pGLkceISAAAA:8
 a=RPJ6JBhKAAAA:8 a=Po-VWPXRGcvJT5Xng5YA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 3/7] [v2] lib: kill e2fsck use of ctx->journal_io
Date:   Tue, 19 Sep 2023 03:02:23 -0600
Message-Id: <20230919090227.25363-3-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919090227.25363-1-adilger@dilger.ca>
References: <20230919090227.25363-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfANi6FL8tqIbIXxuuyvKkxOrv5EJXEHK658yStNbgq222pe+9mG4WfUpaYqpCqDwkaszumJ1McN+ukZeY88c6FMOQgcRoX/N2UlKn+Ba3sA+GuIsm4sh
 PYFGMHbMmrbP460Z4TRvz4gkj8FOE9TAaiaMJ2ztsqB/udJ/FVHeB/ei62qDFAa+JOhdhGarVJV0VG2K1kq7EU0HiRC6v8wv7bv/sBMx2pak/4k/rhrNSl3R
 /MfA6TI1XrR+MvQZ5I/eXZS1WJoAdSjAjvhvXmyS8+0pGN9kmT/BhfH2stKJurg5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@gmail.com>

Replace e2fsck-specific code with generic one to use fs->journal_io.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/journal.c       | 34 --------------------------
 e2fsck/e2fsck.c         |  6 +----
 e2fsck/e2fsck.h         |  1 -
 e2fsck/journal.c        | 53 +++++++----------------------------------
 lib/support/jbd2_user.h |  2 ++
 5 files changed, 11 insertions(+), 85 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index bf199699..8c84be25 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -590,40 +590,6 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	return 0;
 }
 
-static void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
-				   int reset, int drop)
-{
-	journal_superblock_t *jsb;
-
-	if (drop)
-		mark_buffer_clean(journal->j_sb_buffer);
-	else if (fs->flags & EXT2_FLAG_RW) {
-		jsb = journal->j_superblock;
-		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
-			jsb->s_start = 0; /* this marks the journal as empty */
-		ext2fs_journal_sb_csum_set(journal, jsb);
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-	brelse(journal->j_sb_buffer);
-
-	if (fs && fs->journal_io) {
-		if (fs->io != fs->journal_io)
-			io_channel_close(fs->journal_io);
-		fs->journal_io = NULL;
-		free(fs->journal_name);
-		fs->journal_name = NULL;
-	}
-
-#ifndef USE_INODE_IO
-	if (journal->j_inode)
-		ext2fs_free_mem(&journal->j_inode);
-#endif
-	if (journal->j_fs_dev)
-		ext2fs_free_mem(&journal->j_fs_dev);
-	ext2fs_free_mem(&journal);
-}
-
 /*
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 1e295e3e..421ef4a9 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -83,11 +83,7 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_icount(ctx->inode_link_info);
 		ctx->inode_link_info = 0;
 	}
-	if (ctx->journal_io) {
-		if (ctx->fs && ctx->fs->io != ctx->journal_io)
-			io_channel_close(ctx->journal_io);
-		ctx->journal_io = 0;
-	}
+
 	if (ctx->fs && ctx->fs->dblist) {
 		ext2fs_free_dblist(ctx->fs->dblist);
 		ctx->fs->dblist = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index b8caa43b..d9e24341 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -380,7 +380,6 @@ struct e2fsck_struct {
 	/*
 	 * ext3 journal support
 	 */
-	io_channel	journal_io;
 	char	*journal_name;
 
 	/*
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index bc3c699a..367ec31d 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -86,7 +86,7 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 	if (kdev->k_dev == K_DEV_FS)
 		bh->b_io = kdev->k_ctx->fs->io;
 	else
-		bh->b_io = kdev->k_ctx->journal_io;
+		bh->b_io = kdev->k_ctx->fs->journal_io;
 	bh->b_size = blocksize;
 	bh->b_blocknr = blocknr;
 
@@ -100,7 +100,7 @@ int sync_blockdev(kdev_t kdev)
 	if (kdev->k_dev == K_DEV_FS)
 		io = kdev->k_ctx->fs->io;
 	else
-		io = kdev->k_ctx->journal_io;
+		io = kdev->k_ctx->fs->journal_io;
 
 	return io_channel_flush(io) ? -EIO : 0;
 }
@@ -156,11 +156,6 @@ void mark_buffer_dirty(struct buffer_head *bh)
 	bh->b_dirty = 1;
 }
 
-static void mark_buffer_clean(struct buffer_head * bh)
-{
-	bh->b_dirty = 0;
-}
-
 void brelse(struct buffer_head *bh)
 {
 	if (bh->b_dirty)
@@ -1028,7 +1023,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		io_ptr = inode_io_manager;
 #else
 		journal->j_inode = j_inode;
-		ctx->journal_io = ctx->fs->io;
+		ctx->fs->journal_io = ctx->fs->io;
 		if ((ret = jbd2_journal_bmap(journal, 0, &start)) != 0) {
 			retval = (errcode_t) (-1 * ret);
 			goto errout;
@@ -1075,12 +1070,12 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 
 		retval = io_ptr->open(journal_name, flags,
-				      &ctx->journal_io);
+				      &ctx->fs->journal_io);
 	}
 	if (retval)
 		goto errout;
 
-	io_channel_set_blksize(ctx->journal_io, ctx->fs->blocksize);
+	io_channel_set_blksize(ctx->fs->journal_io, ctx->fs->blocksize);
 
 	if (ext_journal) {
 		blk64_t maxlen;
@@ -1414,38 +1409,6 @@ static errcode_t e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
 	return 0;
 }
 
-static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
-				   int reset, int drop)
-{
-	journal_superblock_t *jsb;
-
-	if (drop)
-		mark_buffer_clean(journal->j_sb_buffer);
-	else if (!(ctx->options & E2F_OPT_READONLY)) {
-		jsb = journal->j_superblock;
-		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
-			jsb->s_start = 0; /* this marks the journal as empty */
-		ext2fs_journal_sb_csum_set(journal, jsb);
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-	brelse(journal->j_sb_buffer);
-
-	if (ctx->journal_io) {
-		if (ctx->fs && ctx->fs->io != ctx->journal_io)
-			io_channel_close(ctx->journal_io);
-		ctx->journal_io = 0;
-	}
-
-#ifndef USE_INODE_IO
-	if (journal->j_inode)
-		ext2fs_free_mem(&journal->j_inode);
-#endif
-	if (journal->j_fs_dev)
-		ext2fs_free_mem(&journal->j_fs_dev);
-	ext2fs_free_mem(&journal);
-}
-
 /*
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
@@ -1492,7 +1455,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		    (!fix_problem(ctx, PR_0_JOURNAL_UNSUPP_VERSION, &pctx))))
 			retval = e2fsck_journal_fix_corrupt_super(ctx, journal,
 								  &pctx);
-		e2fsck_journal_release(ctx, journal, 0, 1);
+		ext2fs_journal_release(ctx->fs, journal, 0, 1);
 		return retval;
 	}
 
@@ -1573,7 +1536,7 @@ no_has_journal:
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
-	e2fsck_journal_release(ctx, journal, reset, 0);
+	ext2fs_journal_release(ctx->fs, journal, reset, 0);
 	return retval;
 }
 
@@ -1622,7 +1585,7 @@ errout:
 	jbd2_journal_destroy_revoke(journal);
 	jbd2_journal_destroy_revoke_record_cache();
 	jbd2_journal_destroy_revoke_table_cache();
-	e2fsck_journal_release(ctx, journal, 1, 0);
+	ext2fs_journal_release(ctx->fs, journal, 1, 0);
 	return retval;
 }
 
diff --git a/lib/support/jbd2_user.h b/lib/support/jbd2_user.h
index 22f8cb7e..e4316f58 100644
--- a/lib/support/jbd2_user.h
+++ b/lib/support/jbd2_user.h
@@ -256,6 +256,8 @@ int ext2fs_journal_verify_csum_type(journal_t *j, journal_superblock_t *jsb);
 __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb);
 int ext2fs_journal_sb_csum_verify(journal_t *j, journal_superblock_t *jsb);
 errcode_t ext2fs_journal_sb_csum_set(journal_t *j, journal_superblock_t *jsb);
+void ext2fs_journal_release(ext2_filsys fs, journal_t *journal, int reset,
+			    int drop);
 
 /*
  * Kernel compatibility functions are defined in journal.c
-- 
2.25.1

