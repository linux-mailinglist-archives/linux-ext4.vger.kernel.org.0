Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF387A5D6F
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjISJJt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISJJq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 05:09:46 -0400
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2CBA
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 02:09:39 -0700 (PDT)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id iUiBqeSiWLAoIiWjjq8HJR; Tue, 19 Sep 2023 09:09:39 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWjhqEziq3fOSiWjiqAHxS; Tue, 19 Sep 2023 09:09:39 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=65096553
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=pGLkceISAAAA:8
 a=RPJ6JBhKAAAA:8 a=GiWcz6MfNhDLV59xR1kA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 5/7] [v2] lib: deduplicate buffer_head/kernel emulation
Date:   Tue, 19 Sep 2023 03:09:31 -0600
Message-Id: <20230919090933.25567-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFNf+XYlraaCSOwcWcjBVUnqA/gwoTP0GS4pIyiwIuHwc1IHR1X/PONSPh/x54R4VUWXwtco3S9hnm29C1Hq1GGi6gZy/626K5XauC9AkACTTn7d3swA
 qDZQV+pDfAehPKDRo4RTmS1dT1kLdNOIiuP3/26wDhqf3oYNo3BGsGD+msrpVeqBS5C8a4OgZPktr5j2ZTneNzbT7ZBGMVMPqYa7KpypZ4XL3yK1Z+1AZvTH
 QDn9mR2exhoY0I6CW7EkYxMvRVgKPDM+CinFbFuH81BQBm2N/JrHzt3wDNoJkD9j
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@gmail.com>

Move buffer_head and device code into libsupport to allow it
to be shared between debugfs and e2fsck.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/journal.c | 147 ----------------------------------------------
 e2fsck/journal.c  | 143 --------------------------------------------
 2 files changed, 290 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 8c84be25..6e8dec35 100644
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
index d6129ed1..02251956 100644
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
-- 
2.25.1

