Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623C854B551
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jun 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiFNQGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343589AbiFNQGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 12:06:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893A40A19
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jun 2022 09:06:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF33E21BBB;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655222764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6COl2LQlJaZ5BZsz/TM6UQc97rV2f03NHU4M23Nu4x0=;
        b=g5sap53S4PmIl65SIMsRiLkKtdcS8jGjOYsr3pDCluZBLdel34aJ8Op0DlqyRctJOHKfZQ
        fEBhGZTDoOvX2Y/XGYTJ0iBLLbVllihxJtEHqyUg4YhYaC8DhqP44pPsGA4K+PRpZo+2ji
        8NK9ihiigz45/jfyCXA73nUSMczep0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655222764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6COl2LQlJaZ5BZsz/TM6UQc97rV2f03NHU4M23Nu4x0=;
        b=QnLq2UGB8XTQTlw+2hDAbQOKX7O8xDKAvNBpciHfY6kccUgcr/rsJc9OL4YETOv2SrIRFV
        ze6Tx/6/CXm1U/DA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE7412C142;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F21A1A063C; Tue, 14 Jun 2022 18:06:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/10] ext2: Avoid deleting xattr block that is being reused
Date:   Tue, 14 Jun 2022 18:05:22 +0200
Message-Id: <20220614160603.20566-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614124146.21594-1-jack@suse.cz>
References: <20220614124146.21594-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4116; h=from:subject; bh=17AlHDM8vFI5N4ehdJzGSnPztuVqMG0Fi1CpgPOBxOU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqLHBSCkSpEhK0Tur1hv2Ychas4rcIOmeJpJh8RIS HYR8Z6eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqixwQAKCRCcnaoHP2RA2dlCB/ 9zsVsEObtic+9x78KfVHlFty0zZEqpdc8vZMEZd93Qgjv6mvUsrSnnsWVaz1WdAv1XBX3mexqwUDtp vMq7yKfa3tLQsRY/QQT23CcrZgfXGEDXksaKVpdxtImsgYM6/HVIUB+Lr45Lvvnbn3uQ7MzyhrtnNE zM/aDwLV7xoUe2QqKeUuWsy+0cqYFvrZzFt95FUeshkTJDZymF9RQP+MUZZYx+UgXexERATVNz7kik X1/IgjHNS6Z21PF6jv9ML4+SDIu39oAG4lS5C08/MFrIKCND4HUIT01jH7AGzSjpTGjqcIJoJfkIgy AoYdvkI3U6vbjmMoXpEKWYyWPr6thC
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

Currently when we decide to reuse xattr block we detect the case when
the last reference to xattr block is being dropped at the same time and
cancel the reuse attempt. Convert ext2 to a new scheme when as soon as
matching mbcache entry is found, we wait with dropping the last xattr
block reference until mbcache entry reference is dropped (meaning either
the xattr block reference is increased or we decided not to reuse the
block).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 37ce495eb279..e1d9bcd18b81 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -522,17 +522,18 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		lock_buffer(bh);
 		if (header->h_refcount == cpu_to_le32(1)) {
 			__u32 hash = le32_to_cpu(header->h_hash);
+			struct mb_cache_entry *oe;
 
-			ea_bdebug(bh, "modifying in-place");
+			oe = mb_cache_entry_try_delete(EA_BLOCK_CACHE(inode),
+					hash, bh->b_blocknr);
+			if (!oe) {
+				ea_bdebug(bh, "modifying in-place");
+				goto update_block;
+			}
 			/*
-			 * This must happen under buffer lock for
-			 * ext2_xattr_set2() to reliably detect modified block
+			 * Someone is trying to reuse the block, leave it alone
 			 */
-			mb_cache_entry_delete(EA_BLOCK_CACHE(inode), hash,
-					      bh->b_blocknr);
-
-			/* keep the buffer locked while modifying it. */
-			goto update_block;
+			mb_cache_entry_put(EA_BLOCK_CACHE(inode), oe);
 		}
 		unlock_buffer(bh);
 		ea_bdebug(bh, "cloning");
@@ -656,16 +657,29 @@ static void ext2_xattr_release_block(struct inode *inode,
 {
 	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
 
+retry_ref:
 	lock_buffer(bh);
 	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
 		__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
+		struct mb_cache_entry *oe;
 
 		/*
-		 * This must happen under buffer lock for
-		 * ext2_xattr_set2() to reliably detect freed block
+		 * This must happen under buffer lock to properly
+		 * serialize with ext2_xattr_set() reusing the block.
 		 */
-		mb_cache_entry_delete(ea_block_cache, hash,
-				      bh->b_blocknr);
+		oe = mb_cache_entry_try_delete(ea_block_cache, hash,
+					       bh->b_blocknr);
+		if (oe) {
+			/*
+			 * Someone is trying to reuse the block. Wait
+			 * and retry.
+			 */
+			unlock_buffer(bh);
+			mb_cache_entry_wait_unused(oe);
+			mb_cache_entry_put(ea_block_cache, oe);
+			goto retry_ref;
+		}
+
 		/* Free the old block. */
 		ea_bdebug(bh, "freeing");
 		ext2_free_blocks(inode, bh->b_blocknr, 1);
@@ -929,7 +943,7 @@ ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
 	if (!header->h_hash)
 		return NULL;  /* never share */
 	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
-again:
+
 	ce = mb_cache_entry_find_first(ea_block_cache, hash);
 	while (ce) {
 		struct buffer_head *bh;
@@ -941,22 +955,8 @@ ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
 				inode->i_ino, (unsigned long) ce->e_value);
 		} else {
 			lock_buffer(bh);
-			/*
-			 * We have to be careful about races with freeing or
-			 * rehashing of xattr block. Once we hold buffer lock
-			 * xattr block's state is stable so we can check
-			 * whether the block got freed / rehashed or not.
-			 * Since we unhash mbcache entry under buffer lock when
-			 * freeing / rehashing xattr block, checking whether
-			 * entry is still hashed is reliable.
-			 */
-			if (hlist_bl_unhashed(&ce->e_hash_list)) {
-				mb_cache_entry_put(ea_block_cache, ce);
-				unlock_buffer(bh);
-				brelse(bh);
-				goto again;
-			} else if (le32_to_cpu(HDR(bh)->h_refcount) >
-				   EXT2_XATTR_REFCOUNT_MAX) {
+			if (le32_to_cpu(HDR(bh)->h_refcount) >
+			    EXT2_XATTR_REFCOUNT_MAX) {
 				ea_idebug(inode, "block %ld refcount %d>%d",
 					  (unsigned long) ce->e_value,
 					  le32_to_cpu(HDR(bh)->h_refcount),
-- 
2.35.3

