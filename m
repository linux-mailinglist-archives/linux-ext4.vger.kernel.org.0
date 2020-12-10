Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF32D643F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393005AbgLJR6T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392845AbgLJR5r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CAC061285
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:45 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id c12so4428608pgm.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOHf4c/LhKsi08O1pVH90ZtBXzVnM8d9sMPgNCwkdJQ=;
        b=NT7pp0WYeFyf2mKEV1JesBmhSkUfzJJXWVCZnlfmUvh0EXc//OiHKgjuH3g6PjDKGW
         1sqT5bB9hz7pD9Y95OA/olL665dlrGeyyhDBJYPEGFbV1y78O0b3T1wYZ2IVdh9oE5Ux
         bI5pN4kjhnNl202qZw1rIFslmWo51KcFJ6nMGgdTp/qpqPNKSCB/TuWREAE2OGLDK7cC
         VK9YPzMUYc1GeKII9/SsS8oZi9TAAtacePfntcfTIldB4QjGBM+8J4HQ8QDtq4Tk1jDP
         yXu5ZUR7/lkw6Nd86M3bk73zsGj0CXLizfqNfJVGWfE2ToL9dpReWbPKfX/E31fhCKQQ
         i2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOHf4c/LhKsi08O1pVH90ZtBXzVnM8d9sMPgNCwkdJQ=;
        b=TUcSxNFrivXjFGC1rRMeKYffFlRae6OwWsZRv5/qkFqoMjHdT2q+6S25Yt+86eMLm9
         lwS3UcMUpcMBfGYWUp/W5mgE0Ft5AuIMGAVXJcZtvqKnsaEHIkKzEuz+8SnvARl21fix
         6dJ2EzlYQjDEzwy8M1y9VGLwTn+BmqomjjEB5xCWmjI666PSmfZqe58DEkmNfDH2Bz/3
         T3J9n3+jyXMGW1NsAW3QXqyr/XdN098vnQt/CXvsi+c8X7YuoB1Gq7eqPjUlEeBq59FC
         pAOy+OXp7t1efCp2tCGX2FtV3Mlf7WZ9pItjhp/xkz9Q2w7dY6GzmnbcDauJOt5gfcqE
         D/dw==
X-Gm-Message-State: AOAM5311jAq4sO0iBfWRikiRPzkY6qWdUxl598FUsMkn0/LlWigyfmfs
        PkG0WLhMJOHgR+5HCUjU4IeYeM69vSI=
X-Google-Smtp-Source: ABdhPJyI+EYZ25syeqrafxD2XLp9AyBIOgU+Wxe9v8qljsOl68MvCh5qjyp+Absj8E5oN5b88qNY9g==
X-Received: by 2002:a62:ca:0:b029:19e:67a9:f0f2 with SMTP id 193-20020a6200ca0000b029019e67a9f0f2mr7778099pfa.60.1607623004220;
        Thu, 10 Dec 2020 09:56:44 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:43 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 06/15] ext2fs: add new APIs needed for fast commits
Date:   Thu, 10 Dec 2020 09:55:59 -0800
Message-Id: <20201210175608.3265541-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch adds the following new APIs:

Count the total number of blocks occupied by inode including
intermediate extent tree nodes.
extern blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
                                       struct ext2_inode *inode);

Convert ext3_extent to ext2fs_extent.
extern void ext2fs_convert_extent(struct ext2fs_extent *to,
                                       struct ext3_extent *from);

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/ext2fs/ext2fs.h |  4 +++
 lib/ext2fs/extent.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index ec841006..fdcb28f6 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1332,6 +1332,10 @@ extern errcode_t ext2fs_extent_fix_parents(ext2_extent_handle_t handle);
 extern size_t ext2fs_max_extent_depth(ext2_extent_handle_t handle);
 extern errcode_t ext2fs_fix_extents_checksums(ext2_filsys fs, ext2_ino_t ino,
 					      struct ext2_inode *inode);
+extern blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
+					struct ext2_inode *inode);
+extern errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *from,
+				      int len);
 
 /* fallocate.c */
 #define EXT2_FALLOCATE_ZERO_BLOCKS	(0x1)
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index ac3dbfec..8d5fc1ab 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1785,6 +1785,69 @@ out:
 	return errcode;
 }
 
+errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *addr, int len)
+{
+	struct ext3_extent *from = (struct ext3_extent *)addr;
+
+	if (len != sizeof(struct ext3_extent))
+		return EXT2_ET_INVALID_ARGUMENT;
+
+	to->e_pblk = ext2fs_le32_to_cpu(from->ee_start) +
+		((__u64) ext2fs_le16_to_cpu(from->ee_start_hi)
+			<< 32);
+	to->e_lblk = ext2fs_le32_to_cpu(from->ee_block);
+	to->e_len = ext2fs_le16_to_cpu(from->ee_len);
+	to->e_flags |= EXT2_EXTENT_FLAGS_LEAF;
+	if (to->e_len > EXT_INIT_MAX_LEN) {
+		to->e_len -= EXT_INIT_MAX_LEN;
+		to->e_flags |= EXT2_EXTENT_FLAGS_UNINIT;
+	}
+
+	return 0;
+}
+
+blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
+			struct ext2_inode *inode)
+{
+	ext2_extent_handle_t	handle;
+	struct ext2fs_extent	extent;
+	errcode_t		errcode;
+	int			i;
+	blk64_t			blkcount = 0;
+	blk64_t			*intermediate_nodes;
+
+	errcode = ext2fs_extent_open2(fs, ino, inode, &handle);
+	if (errcode)
+		goto out;
+
+	errcode = ext2fs_extent_get(handle, EXT2_EXTENT_ROOT, &extent);
+	if (errcode)
+		goto out;
+
+	ext2fs_get_array(handle->max_depth, sizeof(blk64_t),
+				&intermediate_nodes);
+	blkcount = handle->level;
+	while (!errcode) {
+		if (extent.e_flags & EXT2_EXTENT_FLAGS_LEAF) {
+			blkcount += extent.e_len;
+			for (i = 0; i < handle->level; i++) {
+				if (intermediate_nodes[i] !=
+					handle->path[i].end_blk) {
+					blkcount++;
+					intermediate_nodes[i] =
+						handle->path[i].end_blk;
+				}
+			}
+		}
+		errcode = ext2fs_extent_get(handle, EXT2_EXTENT_NEXT, &extent);
+	}
+	ext2fs_free_mem(&intermediate_nodes);
+out:
+	ext2fs_extent_free(handle);
+
+	return blkcount;
+}
+
 #ifdef DEBUG
 /*
  * Override debugfs's prompt
-- 
2.29.2.576.ga3fc446d84-goog

