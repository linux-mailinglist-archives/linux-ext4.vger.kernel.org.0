Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562EB4C5BF
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 05:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFTDYO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 23:24:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41811 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726133AbfFTDYO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jun 2019 23:24:14 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5K3O9nP029349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jun 2019 23:24:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BDC4D420484; Wed, 19 Jun 2019 23:24:09 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: clean up kerneldoc warnigns when building with W=1
Date:   Wed, 19 Jun 2019 23:24:06 -0400
Message-Id: <20190620032406.20221-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/balloc.c      |  4 ++--
 fs/ext4/dir.c         |  3 +++
 fs/ext4/extents.c     |  4 ++--
 fs/ext4/indirect.c    | 22 ++++++++--------------
 fs/ext4/mballoc.c     |  5 +++--
 fs/ext4/move_extent.c | 12 ++++++------
 6 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index e5d6ee61ff48..0b202e00d93f 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -603,9 +603,9 @@ int ext4_claim_free_clusters(struct ext4_sb_info *sbi,
 }
 
 /**
- * ext4_should_retry_alloc()
+ * ext4_should_retry_alloc() - check if a block allocation should be retried
  * @sb:			super block
- * @retries		number of attemps has been made
+ * @retries:		number of attemps has been made
  *
  * ext4_should_retry_alloc() is called when ENOSPC is returned, and if
  * it is profitable to retry the operation, this function will wait
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index c7843b149a1e..1f7784bee42a 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -33,6 +33,9 @@
 static int ext4_dx_readdir(struct file *, struct dir_context *);
 
 /**
+ * is_dx_dir() - check if a directory is using htree indexing
+ * @inode: directory inode
+ *
  * Check if the given dir-inode refers to an htree-indexed directory
  * (or a directory which could potentially get converted to use htree
  * indexing).
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d40ed940001e..92266a2da7d6 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5676,8 +5676,8 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 }
 
 /**
- * ext4_swap_extents - Swap extents between two inodes
- *
+ * ext4_swap_extents() - Swap extents between two inodes
+ * @handle: handle for this transaction
  * @inode1:	First inode
  * @inode2:	Second inode
  * @lblk1:	Start block for first inode
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 2024d3fa5504..36699a131168 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -294,14 +294,12 @@ static int ext4_blks_to_allocate(Indirect *branch, int k, unsigned int blks,
 }
 
 /**
- *	ext4_alloc_branch - allocate and set up a chain of blocks.
- *	@handle: handle for this transaction
- *	@inode: owner
- *	@indirect_blks: number of allocated indirect blocks
- *	@blks: number of allocated direct blocks
- *	@goal: preferred place for allocation
- *	@offsets: offsets (in the blocks) to store the pointers to next.
- *	@branch: place to store the chain in.
+ * ext4_alloc_branch() - allocate and set up a chain of blocks
+ * @handle: handle for this transaction
+ * @ar: structure describing the allocation request
+ * @indirect_blks: number of allocated indirect blocks
+ * @offsets: offsets (in the blocks) to store the pointers to next.
+ * @branch: place to store the chain in.
  *
  *	This function allocates blocks, zeroes out all but the last one,
  *	links them into chain and (if we are synchronous) writes them to disk.
@@ -396,15 +394,11 @@ static int ext4_alloc_branch(handle_t *handle,
 }
 
 /**
- * ext4_splice_branch - splice the allocated branch onto inode.
+ * ext4_splice_branch() - splice the allocated branch onto inode.
  * @handle: handle for this transaction
- * @inode: owner
- * @block: (logical) number of block we are adding
- * @chain: chain of indirect blocks (with a missing link - see
- *	ext4_alloc_branch)
+ * @ar: structure describing the allocation request
  * @where: location of missing link
  * @num:   number of indirect blocks we are adding
- * @blks:  number of direct blocks we are adding
  *
  * This function fills the missing link and does all housekeeping needed in
  * inode (->i_blocks, etc.). In case of success we end up with the full
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99ba720dbb7a..a3e2767bdf2f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4696,8 +4696,9 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
  * ext4_free_blocks() -- Free given blocks and update quota
  * @handle:		handle for this transaction
  * @inode:		inode
- * @block:		start physical block to free
- * @count:		number of blocks to count
+ * @bh:			optional buffer of the block to be freed
+ * @block:		starting physical block to be freed
+ * @count:		number of blocks to be freed
  * @flags:		flags used by ext4_free_blocks
  */
 void ext4_free_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 1083a9f3f16a..3ec9627c9713 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -13,11 +13,10 @@
 #include "ext4_extents.h"
 
 /**
- * get_ext_path - Find an extent path for designated logical block number.
- *
- * @inode:	an inode which is searched
+ * get_ext_path() - Find an extent path for designated logical block number.
+ * @inode:	inode to be searched
  * @lblock:	logical block number to find an extent path
- * @path:	pointer to an extent path pointer (for output)
+ * @ppath:	pointer to an extent path pointer (for output)
  *
  * ext4_find_extent wrapper. Return 0 on success, or a negative error value
  * on failure.
@@ -42,8 +41,9 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 }
 
 /**
- * ext4_double_down_write_data_sem - Acquire two inodes' write lock
- *                                   of i_data_sem
+ * ext4_double_down_write_data_sem() - write lock two inodes's i_data_sem
+ * @first: inode to be locked
+ * @second: inode to be locked
  *
  * Acquire write lock of i_data_sem of the two inodes
  */
-- 
2.22.0

