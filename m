Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02A6D3528
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Apr 2023 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDBBaU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Apr 2023 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBBaT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Apr 2023 21:30:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C2191F6;
        Sat,  1 Apr 2023 18:30:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id cu12so17027182pfb.13;
        Sat, 01 Apr 2023 18:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680399017;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx2kcupyV130/bJobMOpT9hod1ARX/5gdftwksDD8V8=;
        b=qVeUEN0LhbVTcqG0WKLiszX8RU7bVbnvR2a/SJPOb5gr7/qRs7GO2gSN2E8CuPiFyq
         RbGdbQMg5zTvRELTtwQ/r3Ij2WFc1SYUcgcpQFhoinypRxx+dr/eh/U1WSXvvlA0uig4
         vcPmUnN7IN4rUETTzoF9/u11vdnRothUvVzvRCLd1lBwj4UTDYNN1HjnuhpkluUI6lEZ
         UVr5rv3EO0LF8oIaZtj9D5+IujxKblBx0Hg/ppyxWZbTLhO9DYlhlljmuqRrW6RyNtlT
         ZW+el+4SnIHzEI9gXfl1ArYhyqh2ckOxUT7+EpFWY98xuufGShUaKUlB7/WgD8O1xWiE
         PN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680399017;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx2kcupyV130/bJobMOpT9hod1ARX/5gdftwksDD8V8=;
        b=awxEVCNOBQGKr7mH21hqCXhBwK8cZKa6t0mF562eCEr2e8JpvKd/6Y0i+eiBm2MXoK
         cNwOko4m2uWcID6ANdANLR7Scabfhksg/SIaUc8l25qwuzDFFy9Lj/eLgSqik5Ss9/Ux
         D8nI4hsCpfaOLDBpS58BHIjIMyXuKPLKYnysKAF8C1aWLqn6TMqfPjJU9CrK4oV+CZzB
         xt0+U1ceIXggzmOslBp463BrlJTWz7s4yaKaYwcpXKpagArG4pt9ENUg2m+TghbhadPr
         uktLJTUcBG7wm26XTLnmWwZfzbBB3zS30Dj/9f1GCo8+B302j4O+0HY1qyY85vOk7Nvc
         bDcA==
X-Gm-Message-State: AAQBX9fddrezinDL0o/IV3nhzjPWRb3SPCeaOzERUAUY8cWbJlNQtfeh
        GE2TNj7EL5VaPD0Z1TPyGj5DAklc0wQMi63F
X-Google-Smtp-Source: AKy350bqGSTywFOFZdP2S1xeboBxAM6UeVUULjHmy1ZGf2RJbByg9osdjHXWh8fmtYG8Zxv9r4NkhA==
X-Received: by 2002:aa7:96e5:0:b0:627:fc3b:4cb4 with SMTP id i5-20020aa796e5000000b00627fc3b4cb4mr8577493pfq.19.1680399016842;
        Sat, 01 Apr 2023 18:30:16 -0700 (PDT)
Received: from localhost ([223.104.210.138])
        by smtp.gmail.com with ESMTPSA id s25-20020aa78d59000000b0059442ec49a2sm3965744pfe.146.2023.04.01.18.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Apr 2023 18:30:16 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     tytso@mit.edu, jun.nie@linaro.org,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2] ext4: fix performance issue of xattr when expanding inode
Date:   Sat,  1 Apr 2023 18:30:00 -0700
Message-Id: <20230402013000.73713-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently ext4 will delete ea entry from ibody and recreate ea entry
which store the same value when expanding inode. The main performance
issue is caused by the fact that ext4 will destroy and recreate the
ea inode, and such behavior is redundant.

The patch is a bit ugly, because ext4_xattr_set_entry() contains the
creating,deleting,replacing of xattr without external intervention,
this looks good. But the movement of ea entry from ibody to block
breaks this, so add an argument for ext4_xattr_set_entry() for this
break, and then ext4_xattr_block_set() will reuse the ea_inode instead
of recreating an ea_inode which store the same value.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/xattr.c | 99 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 767454d74cd6..439581e630d4 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1634,7 +1634,7 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 				struct ext4_xattr_search *s,
 				handle_t *handle, struct inode *inode,
-				bool is_block)
+				bool is_block, struct inode *mv_ea_inode)
 {
 	struct ext4_xattr_entry *last, *next;
 	struct ext4_xattr_entry *here = s->here;
@@ -1727,7 +1727,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 			goto out;
 		}
 	}
-	if (i->value && in_inode) {
+	if (i->value && in_inode && !mv_ea_inode) {
 		WARN_ON_ONCE(!i->value_len);
 
 		ret = ext4_xattr_inode_alloc_quota(inode, i->value_len);
@@ -1819,7 +1819,9 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 
 	if (i->value) {
 		/* Insert new value. */
-		if (in_inode) {
+		if (in_inode && mv_ea_inode) {
+			here->e_value_inum = cpu_to_le32(mv_ea_inode->i_ino);
+		} else if (in_inode) {
 			here->e_value_inum = cpu_to_le32(new_ea_inode->i_ino);
 		} else if (i->value_len) {
 			void *val = s->base + min_offs - new_size;
@@ -1838,7 +1840,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	}
 
 update_hash:
-	if (i->value) {
+	if (i->value && !mv_ea_inode) {
 		__le32 hash = 0;
 
 		/* Entry hash calculation. */
@@ -1922,7 +1924,7 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
 static int
 ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		     struct ext4_xattr_info *i,
-		     struct ext4_xattr_block_find *bs)
+		     struct ext4_xattr_block_find *bs, struct inode *mv_ea_inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *new_bh = NULL;
@@ -1972,7 +1974,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
 			error = ext4_xattr_set_entry(i, s, handle, inode,
-						     true /* is_block */);
+						     true /* is_block */, NULL);
 			ext4_xattr_block_csum_set(inode, bs->bh);
 			unlock_buffer(bs->bh);
 			if (error == -EFSCORRUPTED)
@@ -2040,7 +2042,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */);
+	error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */, mv_ea_inode);
 	if (error == -EFSCORRUPTED)
 		goto bad_block;
 	if (error)
@@ -2286,7 +2288,7 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
 		return -ENOSPC;
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
+	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */, NULL);
 	if (error)
 		return error;
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
@@ -2429,7 +2431,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		if (!is.s.not_found)
 			error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 		else if (!bs.s.not_found)
-			error = ext4_xattr_block_set(handle, inode, &i, &bs);
+			error = ext4_xattr_block_set(handle, inode, &i, &bs, NULL);
 	} else {
 		error = 0;
 		/* Xattr value did not change? Save us some work and bail out */
@@ -2446,7 +2448,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 		if (!error && !bs.s.not_found) {
 			i.value = NULL;
-			error = ext4_xattr_block_set(handle, inode, &i, &bs);
+			error = ext4_xattr_block_set(handle, inode, &i, &bs, NULL);
 		} else if (error == -ENOSPC) {
 			if (EXT4_I(inode)->i_file_acl && !bs.s.base) {
 				brelse(bs.bh);
@@ -2455,7 +2457,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 				if (error)
 					goto cleanup;
 			}
-			error = ext4_xattr_block_set(handle, inode, &i, &bs);
+			error = ext4_xattr_block_set(handle, inode, &i, &bs, NULL);
 			if (!error && !is.s.not_found) {
 				i.value = NULL;
 				error = ext4_xattr_ibody_set(handle, inode, &i,
@@ -2615,6 +2617,10 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	struct ext4_xattr_entry *here = NULL, *last = NULL, *next = NULL;
+	struct inode *old_ea_inode = NULL;
+	size_t name_size = EXT4_XATTR_LEN(entry->e_name_len);
+	size_t min_offs;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2660,20 +2666,76 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 	i.value = buffer;
 	i.value_len = value_size;
+	here = is->s.here;
+	last = is->s.first;
+	min_offs = is->s.end - is->s.base;
+	/* Compute min_offs and last entry */
+	for (; !IS_LAST_ENTRY(last); last = next) {
+		next = EXT4_XATTR_NEXT(last);
+		if ((void *)next >= is->s.end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			error = -EFSCORRUPTED;
+			goto out;
+		}
+		if (!last->e_value_inum && last->e_value_size) {
+			size_t offs = le16_to_cpu(last->e_value_offs);
+
+			if (offs < min_offs)
+				min_offs = offs;
+		}
+	}
+
+	/* Remove the name in ibody */
+	last = ENTRY((void *)last - name_size);
+	memmove(here, (void *)here + name_size,
+		(void *)last - (void *)here + sizeof(__u32));
+	memset(last, 0, name_size);
+
+	/* Get the ea_inode which store the old value */
+	if (here->e_value_inum) {
+		error = ext4_xattr_inode_iget(inode,
+					    le32_to_cpu(here->e_value_inum),
+					    le32_to_cpu(here->e_hash),
+					    &old_ea_inode);
+		if (error) {
+			old_ea_inode = NULL;
+			goto out;
+		}
+	} else if (here->e_value_size) {
+		/* Remove the old value in ibody */
+		void *first_val = is->s.base + min_offs;
+		void *rm_val = is->s.base + le16_to_cpu(here->e_value_offs);
+		size_t rm_size = EXT4_XATTR_SIZE(le32_to_cpu(here->e_value_size));
+		size_t offs = le16_to_cpu(here->e_value_offs);
+
+		memmove(first_val + rm_size, first_val, rm_val - first_val);
+		memset(first_val, 0, rm_size);
+		min_offs += rm_size;
+
+		/* Adjust all value offsets */
+		last = is->s.first;
+		while (!IS_LAST_ENTRY(last)) {
+			size_t o = le16_to_cpu(last->e_value_offs);
+
+			if (!last->e_value_inum &&
+			    last->e_value_size && o < offs)
+				last->e_value_offs = cpu_to_le16(o + rm_size);
+			last = EXT4_XATTR_NEXT(last);
+		}
+	}
+
 	error = ext4_xattr_block_find(inode, &i, bs);
 	if (error)
 		goto out;
 
-	/* Move ea entry from the inode into the block */
-	error = ext4_xattr_block_set(handle, inode, &i, bs);
+	/*
+	 * Move ea entry from the inode into the block, and do not need to
+	 * recreate an ea_inode that store the same value.
+	 */
+	error = ext4_xattr_block_set(handle, inode, &i, bs, old_ea_inode);
 	if (error)
 		goto out;
 
-	/* Remove the chosen entry from the inode */
-	i.value = NULL;
-	i.value_len = 0;
-	error = ext4_xattr_ibody_set(handle, inode, &i, is);
-
 out:
 	kfree(b_entry_name);
 	if (entry->e_value_inum && buffer)
@@ -2684,6 +2746,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		brelse(bs->bh);
 	kfree(is);
 	kfree(bs);
+	iput(old_ea_inode);
 
 	return error;
 }
-- 
2.17.1

