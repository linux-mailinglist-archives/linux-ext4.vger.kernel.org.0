Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C38589A30
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiHDJ4w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiHDJ4s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 05:56:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE86582E
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 02:56:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a9so17253670lfm.12
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9d1zy+syKW7oySubV0hs7Wbvd2vMn0db4RnaQ7QptZY=;
        b=fG9DVk/XoS6p/0HoqXbTXZUiblvpqb//8KqyPurwbsl7wpGp7s4tNx3Oy2fXMXOdiY
         gCAxCToTgoI7q2rWXWbaRGe3zGQvCv/fFV1rYjRgMjRWt5ZAQtiZ1a2m1t6j3H/Hs5iG
         QI8OF1WMThGs6GGXp1icDZOsBAOhvcNKN01ZDSEJzrE3pIkE9GvkhlBHJa8wzD1VejCn
         v2TR72u+yhQB/NgjM1DOp2/++4Is28i2BfZxn6Evx1PjmsRf7WXzLS0rj2xdYeBpFuyq
         B/JXyweVjHk1x2FSFwbFAUn7w2dTyQh/EnYzRX1TSJQBYNKwcyGOOgAwNPH2Sm50zAXj
         yY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9d1zy+syKW7oySubV0hs7Wbvd2vMn0db4RnaQ7QptZY=;
        b=Pd9y7wA2EZwPZHCTDHNevn3JbKunv5+3IZolAq+luR9ffWeWreNvcbheIJYbg821Ge
         Aj44nqMWjGFsMQG1tHEuRTVrEMBDpdwkep1iWqFrcTxpaKG4lGXNY6HrLquLtZqySRBt
         yFBZDfBY5k4agweDjcfYiu3PTMxvYSYvtaTIAZQiwRl4CR8fwmNXGyO6ZRH2M9+jKoWh
         kEIbjv66oQ8eJxWBJKBZQaZw7X6ICx2ILQI7XQ0k+WeR8+Zfc6rUC81cq78L9cSJaZjw
         b2sI04V3IBSqpeMRAPFqpmxVcbhW0VB6c+cBZvnsfSHwroxLt6/A9WYj2hXpsth3rfbL
         GRKg==
X-Gm-Message-State: ACgBeo1KfAO3nw1HAkDA9wxvkE9ZXEuPvesFQnU2LHBpPP2R2dGEejt1
        FI55w0TfvEfjwltrcOoY/CZMOf2Q6+j7/tLbBcU=
X-Google-Smtp-Source: AA6agR7IPGm0EHPZYJJs7LPMjJt6Xk7gxZOepGT/hvKUknbYb/yD3XQOu8w08U53fQnT/PncvL3g0g==
X-Received: by 2002:a05:6512:1524:b0:485:b21c:6015 with SMTP id bq36-20020a056512152400b00485b21c6015mr455174lfb.611.1659607004841;
        Thu, 04 Aug 2022 02:56:44 -0700 (PDT)
Received: from lustre.shadowland ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25fc8000000b0048b23d08670sm68593lfg.121.2022.08.04.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:56:44 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH 5/5] deduplicate a buffer_head / kernel device code.
Date:   Thu,  4 Aug 2022 12:56:18 +0300
Message-Id: <20220804095618.887684-5-alexey.lyashkov@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

move a buffer_head and device code into libsupport.
---
 debugfs/journal.c      | 147 -----------------------------------------
 e2fsck/journal.c       | 143 ---------------------------------------
 lib/support/jfs_user.c | 142 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 290 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 202312fe..510a0acb 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -26,8 +26,6 @@
 #include "uuid/uuid.h"
 #include "journal.h"
 
-static int bh_count = 0;
-
 #if EXT2_FLAT_INCLUDES
 #include "blkid.h"
 #else
@@ -47,151 +45,6 @@ static int bh_count = 0;
  * to use the recovery.c file virtually unchanged from the kernel, so we
  * don't have to do much to keep kernel and user recovery in sync.
  */
-int jbd2_journal_bmap(journal_t *journal, unsigned long block,
-		      unsigned long long *phys)
-{
-#ifdef USE_INODE_IO
-	*phys = block;
-	return 0;
-#else
-	struct inode	*inode = journal->j_inode;
-	errcode_t	retval;
-	blk64_t		pblk;
-
-	if (!inode) {
-		*phys = block;
-		return 0;
-	}
-
-	retval = ext2fs_bmap2(inode->i_fs, inode->i_ino,
-			      &inode->i_ext2, NULL, 0, (blk64_t) block,
-			      0, &pblk);
-	*phys = pblk;
-	return (int) retval;
-#endif
-}
-
-struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
-			   int blocksize)
-{
-	struct buffer_head *bh;
-	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
-		sizeof(bh->b_data);
-	errcode_t retval;
-
-	retval = ext2fs_get_memzero(bufsize, &bh);
-	if (retval)
-		return NULL;
-
-	if (journal_enable_debug >= 3)
-		bh_count++;
-	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
-		  blocknr, blocksize, bh_count);
-
-	bh->b_fs = kdev->k_fs;
-	if (kdev->k_dev == K_DEV_FS)
-		bh->b_io = kdev->k_fs->io;
-	else
-		bh->b_io = kdev->k_fs->journal_io;
-	bh->b_size = blocksize;
-	bh->b_blocknr = blocknr;
-
-	return bh;
-}
-
-int sync_blockdev(kdev_t kdev)
-{
-	io_channel	io;
-
-	if (kdev->k_dev == K_DEV_FS)
-		io = kdev->k_fs->io;
-	else
-		io = kdev->k_fs->journal_io;
-
-	return io_channel_flush(io) ? EIO : 0;
-}
-
-void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
-		 struct buffer_head *bhp[])
-{
-	errcode_t retval;
-	struct buffer_head *bh;
-
-	for (; nr > 0; --nr) {
-		bh = *bhp++;
-		if (rw == REQ_OP_READ && !bh->b_uptodate) {
-			jfs_debug(3, "reading block %llu/%p\n",
-				  bh->b_blocknr, (void *) bh);
-			retval = io_channel_read_blk64(bh->b_io,
-						     bh->b_blocknr,
-						     1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_fs->device_name, retval,
-					"while reading block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_uptodate = 1;
-		} else if (rw == REQ_OP_WRITE && bh->b_dirty) {
-			jfs_debug(3, "writing block %llu/%p\n",
-				  bh->b_blocknr,
-				  (void *) bh);
-			retval = io_channel_write_blk64(bh->b_io,
-						      bh->b_blocknr,
-						      1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_fs->device_name, retval,
-					"while writing block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_dirty = 0;
-			bh->b_uptodate = 1;
-		} else {
-			jfs_debug(3, "no-op %s for block %llu\n",
-				  rw == REQ_OP_READ ? "read" : "write",
-				  bh->b_blocknr);
-		}
-	}
-}
-
-void mark_buffer_dirty(struct buffer_head *bh)
-{
-	bh->b_dirty = 1;
-}
-
-static void mark_buffer_clean(struct buffer_head *bh)
-{
-	bh->b_dirty = 0;
-}
-
-void brelse(struct buffer_head *bh)
-{
-	if (bh->b_dirty)
-		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
-	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
-		  bh->b_blocknr, (void *) bh, --bh_count);
-	ext2fs_free_mem(&bh);
-}
-
-int buffer_uptodate(struct buffer_head *bh)
-{
-	return bh->b_uptodate;
-}
-
-void mark_buffer_uptodate(struct buffer_head *bh, int val)
-{
-	bh->b_uptodate = val;
-}
-
-void wait_on_buffer(struct buffer_head *bh)
-{
-	if (!bh->b_uptodate)
-		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-}
-
 
 static void ext2fs_clear_recover(ext2_filsys fs, int error)
 {
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 728f5a24..9ff1dc94 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -27,8 +27,6 @@
 #include "problem.h"
 #include "uuid/uuid.h"
 
-static int bh_count = 0;
-
 /*
  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
  * This creates a larger static binary, and a smaller binary using
@@ -42,147 +40,6 @@ static int bh_count = 0;
  * to use the recovery.c file virtually unchanged from the kernel, so we
  * don't have to do much to keep kernel and user recovery in sync.
  */
-int jbd2_journal_bmap(journal_t *journal, unsigned long block,
-		      unsigned long long *phys)
-{
-#ifdef USE_INODE_IO
-	*phys = block;
-	return 0;
-#else
-	struct inode 	*inode = journal->j_inode;
-	errcode_t	retval;
-	blk64_t		pblk;
-
-	if (!inode) {
-		*phys = block;
-		return 0;
-	}
-
-	retval= ext2fs_bmap2(inode->i_fs, inode->i_ino,
-			     &inode->i_ext2, NULL, 0, (blk64_t) block,
-			     0, &pblk);
-	*phys = pblk;
-	return -1 * ((int) retval);
-#endif
-}
-
-struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
-			   int blocksize)
-{
-	struct buffer_head *bh;
-	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
-		sizeof(bh->b_data);
-	errcode_t retval;
-
-	retval = ext2fs_get_memzero(bufsize, &bh);
-	if (retval)
-		return NULL;
-
-	if (journal_enable_debug >= 3)
-		bh_count++;
-	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
-		  blocknr, blocksize, bh_count);
-
-	bh->b_fs = kdev->k_fs;
-	if (kdev->k_dev == K_DEV_FS)
-		bh->b_io = kdev->k_fs->io;
-	else
-		bh->b_io = kdev->k_fs->journal_io;
-	bh->b_size = blocksize;
-	bh->b_blocknr = blocknr;
-
-	return bh;
-}
-
-int sync_blockdev(kdev_t kdev)
-{
-	io_channel	io;
-
-	if (kdev->k_dev == K_DEV_FS)
-		io = kdev->k_fs->io;
-	else
-		io = kdev->k_fs->journal_io;
-
-	return io_channel_flush(io) ? -EIO : 0;
-}
-
-void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
-		 struct buffer_head *bhp[])
-{
-	errcode_t retval;
-	struct buffer_head *bh;
-
-	for (; nr > 0; --nr) {
-		bh = *bhp++;
-		if (rw == REQ_OP_READ && !bh->b_uptodate) {
-			jfs_debug(3, "reading block %llu/%p\n",
-				  bh->b_blocknr, (void *) bh);
-			retval = io_channel_read_blk64(bh->b_io,
-						     bh->b_blocknr,
-						     1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_fs->device_name, retval,
-					"while reading block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_uptodate = 1;
-		} else if (rw == REQ_OP_WRITE && bh->b_dirty) {
-			jfs_debug(3, "writing block %llu/%p\n",
-				  bh->b_blocknr,
-				  (void *) bh);
-			retval = io_channel_write_blk64(bh->b_io,
-						      bh->b_blocknr,
-						      1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_fs->device_name, retval,
-					"while writing block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_dirty = 0;
-			bh->b_uptodate = 1;
-		} else {
-			jfs_debug(3, "no-op %s for block %llu\n",
-				  rw == REQ_OP_READ ? "read" : "write",
-				  bh->b_blocknr);
-		}
-	}
-}
-
-void mark_buffer_dirty(struct buffer_head *bh)
-{
-	bh->b_dirty = 1;
-}
-
-void brelse(struct buffer_head *bh)
-{
-	if (bh->b_dirty)
-		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
-	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
-		  bh->b_blocknr, (void *) bh, --bh_count);
-	ext2fs_free_mem(&bh);
-}
-
-int buffer_uptodate(struct buffer_head *bh)
-{
-	return bh->b_uptodate;
-}
-
-void mark_buffer_uptodate(struct buffer_head *bh, int val)
-{
-	bh->b_uptodate = val;
-}
-
-void wait_on_buffer(struct buffer_head *bh)
-{
-	if (!bh->b_uptodate)
-		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-}
-
-
 static void e2fsck_clear_recover(e2fsck_t ctx, int error)
 {
 	ext2fs_clear_feature_journal_needs_recovery(ctx->fs->super);
diff --git a/lib/support/jfs_user.c b/lib/support/jfs_user.c
index d8a2f842..26f0090b 100644
--- a/lib/support/jfs_user.c
+++ b/lib/support/jfs_user.c
@@ -1,6 +1,8 @@
 #define DEBUGFS
 #include "jfs_user.h"
 
+static int bh_count = 0;
+
 /*
  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
  * This creates a larger static binary, and a smaller binary using
@@ -60,12 +62,116 @@ errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
 	return 0;
 }
 
+void mark_buffer_dirty(struct buffer_head *bh)
+{
+	bh->b_dirty = 1;
+}
+
+int buffer_uptodate(struct buffer_head *bh)
+{
+	return bh->b_uptodate;
+}
+
+void mark_buffer_uptodate(struct buffer_head *bh, int val)
+{
+	bh->b_uptodate = val;
+}
+
+void wait_on_buffer(struct buffer_head *bh)
+{
+	if (!bh->b_uptodate)
+		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
+}
 
 static void mark_buffer_clean(struct buffer_head * bh)
 {
 	bh->b_dirty = 0;
 }
 
+struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
+			   int blocksize)
+{
+	struct buffer_head *bh;
+	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
+		sizeof(bh->b_data);
+	errcode_t retval;
+
+	retval = ext2fs_get_memzero(bufsize, &bh);
+	if (retval)
+		return NULL;
+
+	if (journal_enable_debug >= 3)
+		bh_count++;
+	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
+		  blocknr, blocksize, bh_count);
+
+	bh->b_fs = kdev->k_fs;
+	if (kdev->k_dev == K_DEV_FS)
+		bh->b_io = kdev->k_fs->io;
+	else
+		bh->b_io = kdev->k_fs->journal_io;
+	bh->b_size = blocksize;
+	bh->b_blocknr = blocknr;
+
+	return bh;
+}
+
+void brelse(struct buffer_head *bh)
+{
+	if (bh->b_dirty)
+		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
+	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
+		  bh->b_blocknr, (void *) bh, --bh_count);
+	ext2fs_free_mem(&bh);
+}
+
+void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
+		 struct buffer_head *bhp[])
+{
+	errcode_t retval;
+	struct buffer_head *bh;
+
+	for (; nr > 0; --nr) {
+		bh = *bhp++;
+		if (rw == REQ_OP_READ && !bh->b_uptodate) {
+			jfs_debug(3, "reading block %llu/%p\n",
+				  bh->b_blocknr, (void *) bh);
+			retval = io_channel_read_blk64(bh->b_io,
+						     bh->b_blocknr,
+						     1, bh->b_data);
+			if (retval) {
+				com_err(bh->b_fs->device_name, retval,
+					"while reading block %llu\n",
+					bh->b_blocknr);
+				bh->b_err = (int) retval;
+				continue;
+			}
+			bh->b_uptodate = 1;
+		} else if (rw == REQ_OP_WRITE && bh->b_dirty) {
+			jfs_debug(3, "writing block %llu/%p\n",
+				  bh->b_blocknr,
+				  (void *) bh);
+			retval = io_channel_write_blk64(bh->b_io,
+						      bh->b_blocknr,
+						      1, bh->b_data);
+			if (retval) {
+				com_err(bh->b_fs->device_name, retval,
+					"while writing block %llu\n",
+					bh->b_blocknr);
+				bh->b_err = (int) retval;
+				continue;
+			}
+			bh->b_dirty = 0;
+			bh->b_uptodate = 1;
+		} else {
+			jfs_debug(3, "no-op %s for block %llu\n",
+				  rw == REQ_OP_READ ? "read" : "write",
+				  bh->b_blocknr);
+		}
+	}
+}
+
+
 void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
 			    int reset, int drop)
 {
@@ -99,3 +205,39 @@ void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
 		ext2fs_free_mem(&journal->j_fs_dev);
 	ext2fs_free_mem(&journal);
 }
+
+int jbd2_journal_bmap(journal_t *journal, unsigned long block,
+		      unsigned long long *phys)
+{
+#ifdef USE_INODE_IO
+	*phys = block;
+	return 0;
+#else
+	struct inode	*inode = journal->j_inode;
+	errcode_t	retval;
+	blk64_t		pblk;
+
+	if (!inode) {
+		*phys = block;
+		return 0;
+	}
+
+	retval = ext2fs_bmap2(inode->i_fs, inode->i_ino,
+			      &inode->i_ext2, NULL, 0, (blk64_t) block,
+			      0, &pblk);
+	*phys = pblk;
+	return (int) retval;
+#endif
+}
+
+int sync_blockdev(kdev_t kdev)
+{
+	io_channel	io;
+
+	if (kdev->k_dev == K_DEV_FS)
+		io = kdev->k_fs->io;
+	else
+		io = kdev->k_fs->journal_io;
+
+	return io_channel_flush(io) ? EIO : 0;
+}
-- 
2.31.1

