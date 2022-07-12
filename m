Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143D5717B0
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiGLKyt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 06:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiGLKyl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 06:54:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5FAE544
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 03:54:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5DF922960;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657623277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdGi0v44l1Vyl1G8V+8Irrfhuz+9JYlV2kXdeUXVjbg=;
        b=x+zixvf9AMMiWCHqMaBkh3zzr09SEE4uvkNLmr8heTHTtBCLAzyNrCuux8QqYlAObhWbQR
        Pd3IrXdgGlBNj8sRPyk/BATcvvj266v+mkLHtr61rAg/A0JQEcK/ljTvJUyRrjgjrdrGS+
        z1KArAVcWbWAAncVGMlDU4TtzNGyqSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657623277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdGi0v44l1Vyl1G8V+8Irrfhuz+9JYlV2kXdeUXVjbg=;
        b=fTo3ov5xO+Zk+uy1VrmdlBSzqYCYn+yLjZjsgz9bvwQOlc/qgDvBPGfevi3xJBXdzYzvEo
        TQPsJO0OFGNFLVAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4FF22C142;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1B9F1A0645; Tue, 12 Jul 2022 12:54:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/10] ext2: Factor our freeing of xattr block reference
Date:   Tue, 12 Jul 2022 12:54:25 +0200
Message-Id: <20220712105436.32204-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712104519.29887-1-jack@suse.cz>
References: <20220712104519.29887-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; h=from:subject; bh=uLup5gvdgoCBkRvzhhYah0h0Ckm+2JpPC82iA9WgAXo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBizVLhKQYFJXKVBN7DA8a6tELmmRzg7SQzNZf0Nk6X LmFlpB6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYs1S4QAKCRCcnaoHP2RA2eI5B/ 4nAXrjZys59+t4qLOBTch8LWVU76ijOJ/WKUJ0gjDmYDkF/QWlu8gMRv0X8BdWXtlmNrNaau2/PZ0Y 2ctNQ9vqQkpwQ7q7MEY3MKQ1U403vcdBVlyLxDILdDjEp71bZm8nOqyOv+9GC353l5GVfn7EQliOCz SNvdBSbp5ECrQ9hPGENlrWVxOvJMKbM0gQP/1o6yZoxmPUc16dybHiWTNG5WKBC7j+T0+RPpBQ5ykj A/Hv81Y61aq12KKo1V394+65KMvec2FGJxRuMHkNGBC8PtWkwlJYhr7VRV3zjzucabA5bHvgUZoSuf /R4e4+sO6VkhYbG00l6nKBtIcmhHU/
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Free of xattr block reference is opencode in two places. Factor it out
into a separate function and use it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 90 +++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 52 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 841fa6d9d744..9885294993ef 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -651,6 +651,42 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	return error;
 }
 
+static void ext2_xattr_release_block(struct inode *inode,
+				     struct buffer_head *bh)
+{
+	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
+
+	lock_buffer(bh);
+	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
+		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
+
+		/*
+		 * This must happen under buffer lock for
+		 * ext2_xattr_set2() to reliably detect freed block
+		 */
+		mb_cache_entry_delete(ea_block_cache, hash,
+				      bh->b_blocknr);
+		/* Free the old block. */
+		ea_bdebug(bh, "freeing");
+		ext2_free_blocks(inode, bh->b_blocknr, 1);
+		/* We let our caller release bh, so we
+		 * need to duplicate the buffer before. */
+		get_bh(bh);
+		bforget(bh);
+		unlock_buffer(bh);
+	} else {
+		/* Decrement the refcount only. */
+		le32_add_cpu(&HDR(bh)->h_refcount, -1);
+		dquot_free_block(inode, 1);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+		ea_bdebug(bh, "refcount now=%d",
+			le32_to_cpu(HDR(bh)->h_refcount));
+		if (IS_SYNC(inode))
+			sync_dirty_buffer(bh);
+	}
+}
+
 /*
  * Second half of ext2_xattr_set(): Update the file system.
  */
@@ -747,34 +783,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 		 * If there was an old block and we are no longer using it,
 		 * release the old block.
 		 */
-		lock_buffer(old_bh);
-		if (HDR(old_bh)->h_refcount == cpu_to_le32(1)) {
-			__u32 hash = le32_to_cpu(HDR(old_bh)->h_hash);
-
-			/*
-			 * This must happen under buffer lock for
-			 * ext2_xattr_set2() to reliably detect freed block
-			 */
-			mb_cache_entry_delete(ea_block_cache, hash,
-					      old_bh->b_blocknr);
-			/* Free the old block. */
-			ea_bdebug(old_bh, "freeing");
-			ext2_free_blocks(inode, old_bh->b_blocknr, 1);
-			mark_inode_dirty(inode);
-			/* We let our caller release old_bh, so we
-			 * need to duplicate the buffer before. */
-			get_bh(old_bh);
-			bforget(old_bh);
-		} else {
-			/* Decrement the refcount only. */
-			le32_add_cpu(&HDR(old_bh)->h_refcount, -1);
-			dquot_free_block_nodirty(inode, 1);
-			mark_inode_dirty(inode);
-			mark_buffer_dirty(old_bh);
-			ea_bdebug(old_bh, "refcount now=%d",
-				le32_to_cpu(HDR(old_bh)->h_refcount));
-		}
-		unlock_buffer(old_bh);
+		ext2_xattr_release_block(inode, old_bh);
 	}
 
 cleanup:
@@ -828,30 +837,7 @@ ext2_xattr_delete_inode(struct inode *inode)
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
-	lock_buffer(bh);
-	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
-		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
-
-		/*
-		 * This must happen under buffer lock for ext2_xattr_set2() to
-		 * reliably detect freed block
-		 */
-		mb_cache_entry_delete(EA_BLOCK_CACHE(inode), hash,
-				      bh->b_blocknr);
-		ext2_free_blocks(inode, EXT2_I(inode)->i_file_acl, 1);
-		get_bh(bh);
-		bforget(bh);
-		unlock_buffer(bh);
-	} else {
-		le32_add_cpu(&HDR(bh)->h_refcount, -1);
-		ea_bdebug(bh, "refcount now=%d",
-			le32_to_cpu(HDR(bh)->h_refcount));
-		unlock_buffer(bh);
-		mark_buffer_dirty(bh);
-		if (IS_SYNC(inode))
-			sync_dirty_buffer(bh);
-		dquot_free_block_nodirty(inode, 1);
-	}
+	ext2_xattr_release_block(inode, bh);
 	EXT2_I(inode)->i_file_acl = 0;
 
 cleanup:
-- 
2.35.3

