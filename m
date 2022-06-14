Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4A54B550
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jun 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiFNQG1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356374AbiFNQGM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 12:06:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19855A4
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jun 2022 09:06:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0B87321BBC;
        Tue, 14 Jun 2022 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655222765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdGi0v44l1Vyl1G8V+8Irrfhuz+9JYlV2kXdeUXVjbg=;
        b=CpsesqgfkATbFMvB69aITjYK27+trPTmjo/3ui4KBAx6pDbPXtOtws8zBqBt4ONPOjoqID
        Hta//pHxYithTbd+M0RRiwEAhTZFPqWkhSzIWToWKPKbPTMpfkC3bZebZKOBDZQ02CByxZ
        vNSC9KFGkgVte2N1ujqF9iaw6U8j5xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655222765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdGi0v44l1Vyl1G8V+8Irrfhuz+9JYlV2kXdeUXVjbg=;
        b=ErCOaBZULvNK3Mv/b8Ec/lJsacKDHPlYkdQb4ktZjgXn9cfnCgeEh5NQda26YmkVl0sgcR
        P3QeoviLWzcLm0AQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE4BD2C14B;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3106A063A; Tue, 14 Jun 2022 18:06:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/10] ext2: Factor our freeing of xattr block reference
Date:   Tue, 14 Jun 2022 18:05:20 +0200
Message-Id: <20220614160603.20566-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614124146.21594-1-jack@suse.cz>
References: <20220614124146.21594-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; h=from:subject; bh=uLup5gvdgoCBkRvzhhYah0h0Ckm+2JpPC82iA9WgAXo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqLHAKQYFJXKVBN7DA8a6tELmmRzg7SQzNZf0Nk6X LmFlpB6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqixwAAKCRCcnaoHP2RA2U3gCA DMSR07tvxts1B++Cv9pK//SpXfMJUzVusvUZ+3wPod3Yf1cymM82CMqHeRvz0JRRcuRnGGE60LiHHp U1j4ujllA+Obn02sg3GITgPxIAker0eQ2ERb/Y5q+oKu14zUem8KFzV3w/nCKa8GkfTVjqmnNRyI8x /WJjiqPphSBWJcyPR7IqLdZZyoKAM5Li0beBCN/ue+Ce/KADuzgbo1YtieAsFq8ebqoa3RzudUYk+O amRM74BHyk8Oi5zJ00PXLLLaE8gaSt0GpDCJ4a81qbmjkQWPt6vaj7+QRoQ2PNdHJvJzdKu+ugueKy a8o5zfkhdOcg/yMxb9P2mRAvijYH15
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

