Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223835717B2
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiGLKyw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiGLKyo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 06:54:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D15AE545
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 03:54:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CBE3F22964;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657623277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yDba34Dxt5BSP/tiGOdmMiwXh2MZYpIh5DszGKjacg=;
        b=hT4dXMdujW3Pn/ZmVdmYX8AmSnR7t1Ct7UfWXvtgSWtTSD7GNAzBu7HB+SdMYXtlA3aoHE
        B1ukQEKEoULs5jcZ1I2l0y7suwJit2uPckq4ZsM26dotvujMjte/cTHlrPcCBtlix9Ue4x
        PdsygWnZ+nWCUX4RCesqBT4UktXrlF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657623277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yDba34Dxt5BSP/tiGOdmMiwXh2MZYpIh5DszGKjacg=;
        b=coG2HYCgnJg2C50LRSHztYCTHEK9YU+iXBKCKpt1tyeXAUI4JF9P4oluvvoIc1ZU8SCtLG
        HZFMXfb5ARuqhGCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A50692C146;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 29407A0647; Tue, 12 Jul 2022 12:54:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/10] ext2: Avoid deleting xattr block that is being reused
Date:   Tue, 12 Jul 2022 12:54:27 +0200
Message-Id: <20220712105436.32204-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712104519.29887-1-jack@suse.cz>
References: <20220712104519.29887-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4118; h=from:subject; bh=0/5R0mG9kt87Fv4ka246ul43XvRBXSBIqS6Wg/9dv9w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBizVLidnfMnkyQrW6oDqvwbxs8Alc+2uy18pH8Oggq 4xoVs8uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYs1S4gAKCRCcnaoHP2RA2c41CA DNTR9OQIRFP+Em0hgXZAtJ93dx0EJom7Bzf3v+h02XiMjVZqPARzINJ1f36SdXb569laeb+ufJS0on JKBuoPas5O/zV/XQpVpr8pde5A0wkNjHQSFBZekbL2fNRkaXlmcfKtgKPtZctqdpOhZERTXsZzQ6fu EX7MmTiHU6gOb1TQCbwBGest+typ6tazah0RygsV+QsvFzrLjGxa1gSNlzuOV32a+GkJLM5SdB412d qh2FcroRXKeWee+Sexskspc84s45N/YnG7zJcSeMBDJujrBYcqx4osrSs1eeXEfL6awnIoQ3sm7Lgd 2jOhkhRN0lPnAbgqiHpat2+ciUx+aP
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
index 37ce495eb279..641abfa4b718 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -522,17 +522,18 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		lock_buffer(bh);
 		if (header->h_refcount == cpu_to_le32(1)) {
 			__u32 hash = le32_to_cpu(header->h_hash);
+			struct mb_cache_entry *oe;
 
-			ea_bdebug(bh, "modifying in-place");
+			oe = mb_cache_entry_delete_or_get(EA_BLOCK_CACHE(inode),
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
+		oe = mb_cache_entry_delete_or_get(ea_block_cache, hash,
+						  bh->b_blocknr);
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

