Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E06F1E3E
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 20:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjD1SzX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 14:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjD1SzX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 14:55:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198D01704
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 11:55:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115eef620so14727577b3a.1
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682708121; x=1685300121;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwsTvGgs6Jnry5ozjxa7cP0CMboK4dVFe5rReCvfmfM=;
        b=RfCR/uceS9hrW9SYT6keNlzqL5o0P1XOxIR+fXb+ymIkMTXp6fOPxbp3seHmjrktBD
         hU478p8fKdgso+XHDXlNR1x04x5nx+FrR6wdCy0X9blCg7x32vAQ/sttj3XJbwso45Nh
         Y+ut4Gz/vMh5jD2Rf/0MAnYiyi5Ycfj2sVBjDQ8EJ8ZWQCDSCjyq9qGkljuOFdafRFd6
         g9xPoiOAPNQy5jF/bhi/PRutvJo/X2FdG7MWwAstbwyD3cigLh5/E6XxMOrVqAgbAxZ7
         i8Grssidq94bQvF/rE91uSPLtNNXq1zhpcawBNV0lBEmcngnL2JyRj4fSXM9fEA4DIln
         Cqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708121; x=1685300121;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwsTvGgs6Jnry5ozjxa7cP0CMboK4dVFe5rReCvfmfM=;
        b=MMPZJF3ouf6j5vuIlTutp+kp0z+uinLIkpGtof5lhAfOCUcDJt0mvoaBlAkoSeTTM6
         yfNBd8z2M3Zwd0TxC1AFD9V8NJgHVk6J53EdDfCMIloewdOflJxxHS5OIL76SoEIH7ZC
         IN5LpX+tDBO8R8WXR8TUK/qloaN7LV2QNRJVvLQr9+iWS5Ctv0RsGJLUv5q0OZnG3TA2
         Aw+8govvIiVaAld4rMoGRZKjHP+WX0rknBfZzFO+eZIerTp7NytNDH/DBz4h4mHNP0DF
         DKYDpMAuS/V4Oy6Jdi9Pf39ZWVDtbzyw6xWke3Vg5NknOzEg4fhlke1bci0ugcuCxwGF
         WQNw==
X-Gm-Message-State: AC+VfDx009avh/xd708knBYOEVjZrlU4MupsICYlZ+9H5aGmkglwZEAo
        vUCasEpHeWCiF6FQD/19v0q4F8T/F6U=
X-Google-Smtp-Source: ACHHUZ7+j51MK1U3/b4ucSUEumY9VqwAGXXV61cfupifq07N2peaLLwCCBzzBvRZekVVgiNbZuFjjw==
X-Received: by 2002:a05:6a00:1688:b0:63b:6279:1039 with SMTP id k8-20020a056a00168800b0063b62791039mr7279977pfc.0.1682708120802;
        Fri, 28 Apr 2023 11:55:20 -0700 (PDT)
Received: from localhost ([101.224.161.147])
        by smtp.gmail.com with ESMTPSA id l18-20020a62be12000000b0063b7b811ce8sm15407387pff.205.2023.04.28.11.55.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Apr 2023 11:55:20 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] ext4: Optimize memory usage in xattr
Date:   Fri, 28 Apr 2023 11:55:17 -0700
Message-Id: <20230428185517.1201-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently struct ext4_attr_info->in_inode use int, but the
value is only 0 or 1, so replace int with bool.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/xattr.c | 8 ++++----
 fs/ext4/xattr.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 767454d..d57408c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1639,7 +1639,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	struct ext4_xattr_entry *last, *next;
 	struct ext4_xattr_entry *here = s->here;
 	size_t min_offs = s->end - s->base, name_len = strlen(i->name);
-	int in_inode = i->in_inode;
+	bool in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
 	struct inode *new_ea_inode = NULL;
 	size_t old_size, new_size;
@@ -2354,7 +2354,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 		.name = name,
 		.value = value,
 		.value_len = value_len,
-		.in_inode = 0,
+		.in_inode = false,
 	};
 	struct ext4_xattr_ibody_find is = {
 		.s = { .not_found = -ENODATA, },
@@ -2441,7 +2441,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 		if (ext4_has_feature_ea_inode(inode->i_sb) &&
 		    (EXT4_XATTR_SIZE(i.value_len) >
 			EXT4_XATTR_MIN_LARGE_EA_SIZE(inode->i_sb->s_blocksize)))
-			i.in_inode = 1;
+			i.in_inode = true;
 retry_inode:
 		error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 		if (!error && !bs.s.not_found) {
@@ -2467,7 +2467,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 				 */
 				if (ext4_has_feature_ea_inode(inode->i_sb) &&
 				    i.value_len && !i.in_inode) {
-					i.in_inode = 1;
+					i.in_inode = true;
 					goto retry_inode;
 				}
 			}
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 824faf0..355d373 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -113,7 +113,7 @@ struct ext4_xattr_info {
 	const void *value;
 	size_t value_len;
 	int name_index;
-	int in_inode;
+	bool in_inode;
 };
 
 struct ext4_xattr_search {
-- 
1.8.3.1

