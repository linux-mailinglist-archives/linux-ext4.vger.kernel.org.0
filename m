Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8B54B552
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jun 2022 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiFNQGS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiFNQGL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 12:06:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1E655A4
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jun 2022 09:06:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E32601F97F;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655222764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+HeRgliFnI7kAcv2KClYtB9VZSxdr7UpvMJX25764c=;
        b=Uch9qhaT62yRaNl4+khe50ZUQHmhZcHhyvuaCLE61sTPgj8rtUkuaaNTSXM7QCklp4U2qx
        MOmNOERiy/IP2a97Q4F2cRMZeiYWDaqi1x7zWPqbbX6AE1ldLEuULLMjS5M3K0tU9JTjyJ
        /GVp8wj+h0SS1tbEGx7WbaRoN+omTP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655222764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+HeRgliFnI7kAcv2KClYtB9VZSxdr7UpvMJX25764c=;
        b=CIPf90nV2dgkkkVzx6MWN3Pe5/aWJ+gqU000X9VVNYqgmgjk6P2C0woX/FXMWVDkwIk7sb
        WaOtIVD2tp2NG1BA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF8F02C143;
        Tue, 14 Jun 2022 16:06:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA7C6A063B; Tue, 14 Jun 2022 18:06:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/10] ext2: Unindent codeblock in ext2_xattr_set()
Date:   Tue, 14 Jun 2022 18:05:21 +0200
Message-Id: <20220614160603.20566-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614124146.21594-1-jack@suse.cz>
References: <20220614124146.21594-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; h=from:subject; bh=EFa0XGQF6PxxB+yAjFv5mou0hxbLh72QSoo8aAWEb3o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqLHAOQcZCUA8ow5cnar5Mt4gQlyTw2mts/RYkpym Sdb9f3OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqixwAAKCRCcnaoHP2RA2frFCA CFN7JaSf6fJFmAIb8dZA5MBuUO+6FVZoh9cj7sjfpEkApSp9veBN5QG4OAQWtbIyUOEbXfkTTFC0bG QC+PHzuMT9QlBzga+5zo+bdrEnVFDgD/4LP7WVo+l+3D7RugJhpJ4H6QjbasBkzQFc3ERH7ajpTDLV ViwL8vVpInqzGAETA26mYXFv2l7P4bcFBc7x//4WLF1JdIwWzLIaahrkLz949x7rlZal11vNdr4hHw t2+4SOK/IygXvwlBiwz9aFgqJrS/GfMNe7TICMiDRhVMbUInkBfuzfKbJx4Ni/rnmJYBVFln6wuGOR ZWWjCQnkTQPSjyDZlNMCGIj+S36l51
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

Replace one else in ext2_xattr_set() with a goto. This makes following
code changes simpler to follow. No functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 9885294993ef..37ce495eb279 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -517,7 +517,8 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	/* Here we know that we can set the new attribute. */
 
 	if (header) {
-		/* assert(header == HDR(bh)); */
+		int offset;
+
 		lock_buffer(bh);
 		if (header->h_refcount == cpu_to_le32(1)) {
 			__u32 hash = le32_to_cpu(header->h_hash);
@@ -531,22 +532,20 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 					      bh->b_blocknr);
 
 			/* keep the buffer locked while modifying it. */
-		} else {
-			int offset;
-
-			unlock_buffer(bh);
-			ea_bdebug(bh, "cloning");
-			header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
-			error = -ENOMEM;
-			if (header == NULL)
-				goto cleanup;
-			header->h_refcount = cpu_to_le32(1);
-
-			offset = (char *)here - bh->b_data;
-			here = ENTRY((char *)header + offset);
-			offset = (char *)last - bh->b_data;
-			last = ENTRY((char *)header + offset);
+			goto update_block;
 		}
+		unlock_buffer(bh);
+		ea_bdebug(bh, "cloning");
+		header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
+		error = -ENOMEM;
+		if (header == NULL)
+			goto cleanup;
+		header->h_refcount = cpu_to_le32(1);
+
+		offset = (char *)here - bh->b_data;
+		here = ENTRY((char *)header + offset);
+		offset = (char *)last - bh->b_data;
+		last = ENTRY((char *)header + offset);
 	} else {
 		/* Allocate a buffer where we construct the new block. */
 		header = kzalloc(sb->s_blocksize, GFP_KERNEL);
@@ -559,6 +558,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		last = here = ENTRY(header+1);
 	}
 
+update_block:
 	/* Iff we are modifying the block in-place, bh is locked here. */
 
 	if (not_found) {
-- 
2.35.3

