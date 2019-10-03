Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06754CB1BC
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbfJCWGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:06:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:49696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732344AbfJCWFz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5876DB12B;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E1F91E4819; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/22] ext4: Avoid unnecessary revokes in ext4_alloc_branch()
Date:   Fri,  4 Oct 2019 00:05:53 +0200
Message-Id: <20191003220613.10791-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Error cleanup path in ext4_alloc_branch() calls ext4_forget() on freshly
allocated indirect blocks with 'metadata' set to 1. This results in
generating revoke records for these blocks. However this is unnecessary
as the freed blocks are only allocated in the current transaction and
thus they will never be journalled. Make this cleanup path similar to
e.g. cleanup in ext4_splice_branch() and use ext4_free_blocks() to
handle block forgetting by passing EXT4_FREE_BLOCKS_FORGET and not
EXT4_FREE_BLOCKS_METADATA to ext4_free_blocks(). This also allows
allocating transaction not to reserve any credits for revoke records.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/indirect.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 36699a131168..602abae08387 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -331,11 +331,14 @@ static int ext4_alloc_branch(handle_t *handle,
 	for (i = 0; i <= indirect_blks; i++) {
 		if (i == indirect_blks) {
 			new_blocks[i] = ext4_mb_new_blocks(handle, ar, &err);
-		} else
+		} else {
 			ar->goal = new_blocks[i] = ext4_new_meta_blocks(handle,
 					ar->inode, ar->goal,
 					ar->flags & EXT4_MB_DELALLOC_RESERVED,
 					NULL, &err);
+			/* Simplify error cleanup... */
+			branch[i+1].bh = NULL;
+		}
 		if (err) {
 			i--;
 			goto failed;
@@ -377,18 +380,25 @@ static int ext4_alloc_branch(handle_t *handle,
 	}
 	return 0;
 failed:
+	if (i == indirect_blks) {
+		/* Free data blocks */
+		ext4_free_blocks(handle, ar->inode, NULL, new_blocks[i],
+				 ar->len, 0);
+		i--;
+	}
 	for (; i >= 0; i--) {
 		/*
 		 * We want to ext4_forget() only freshly allocated indirect
-		 * blocks.  Buffer for new_blocks[i-1] is at branch[i].bh and
-		 * buffer at branch[0].bh is indirect block / inode already
-		 * existing before ext4_alloc_branch() was called.
+		 * blocks. Buffer for new_blocks[i] is at branch[i+1].bh
+		 * (buffer at branch[0].bh is indirect block / inode already
+		 * existing before ext4_alloc_branch() was called). Also
+		 * because blocks are freshly allocated, we don't need to
+		 * revoke them which is why we don't set
+		 * EXT4_FREE_BLOCKS_METADATA.
 		 */
-		if (i > 0 && i != indirect_blks && branch[i].bh)
-			ext4_forget(handle, 1, ar->inode, branch[i].bh,
-				    branch[i].bh->b_blocknr);
-		ext4_free_blocks(handle, ar->inode, NULL, new_blocks[i],
-				 (i == indirect_blks) ? ar->len : 1, 0);
+		ext4_free_blocks(handle, ar->inode, branch[i+1].bh,
+				 new_blocks[i], 1,
+				 branch[i+1].bh ? EXT4_FREE_BLOCKS_FORGET : 0);
 	}
 	return err;
 }
-- 
2.16.4

