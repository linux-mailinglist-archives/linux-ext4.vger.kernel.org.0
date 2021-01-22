Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662922FFC4F
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhAVFpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAVFpp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:45:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F5C0613D6
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:20 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so2944401pgl.10
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gn4GCAW8bWxd1TVMkRBmDJbCrPGF4BHWUc1O5/jfSh4=;
        b=aInN4071ZM74wtH+VMZrkKwlFfGgARtinpfGRIdg24bhLiU6Vc07kUvYpM5JcD5Pjt
         6BWMFB79sQ3ATxvtRSm4+HyKSJ4i5U+DElcxn/A8DCpxmGXE7A2yYSb52IQnmdKLAUOj
         GdvQhQZAcYkQkrFpwaiZfqROewbEnbD64p8iIMa/6NYlEOC14saZ8+rn3WULU4EDzP/U
         lahBl2P8HHdkdThwyX9fclr16nYa8a/R1MFcdnw4rACZ41I+JzAB8GW0iaO0/R9mZW5S
         f6d/+jhx/Y+XSFedTsJhdIwa//jeAqE8ODj1u+3okiaPt4vlc2n3a8VFOdsuErQSe/HT
         X47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gn4GCAW8bWxd1TVMkRBmDJbCrPGF4BHWUc1O5/jfSh4=;
        b=O+3znTSU+y0Qiv2OW467FuY99DvrNy37jkyFv30w0QElpmK0Az0hyJcHW46ckS8qfX
         N5GVSFx7OCNVFiIx5nEuah4K0i9W8w1aMzgutA8vWDBYxwNdblOucO0pFkCS9N7BjN61
         WgZRCsMQ+0n5kqL6Dxp3zZB68+LBdQgkW8s4yGEm6xl3frSxWiJzCFcwhkFWzztD7e9i
         wdT6u65Ct7DXHGnxX4g1NCWPLgI//tvs2mqBApseZXKwIo+OaZEMwhEwz1T9prQN5Aoa
         xrtcLFRCTM1o/Rh4j2T90lEYDEXRaBB4OBqAgnbwPp1b+LwdBRR9WoWCn+u+1mjzVRaI
         wUng==
X-Gm-Message-State: AOAM532gHAwNk+57jEdB9aEUpNSvMty5OlivwtVNKbPbchpkKZMYM4cD
        cEg6r8kZsf3YzKI8YjamuV9hsUx5B6M=
X-Google-Smtp-Source: ABdhPJxQS86JmD6FSjdq8/3isOyPwnwQsuyWyRrtRkyV6NqreQbOuVJIhqOlXTpIksXzGdOUQyE9Vg==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr3315814pjo.189.1611294319649;
        Thu, 21 Jan 2021 21:45:19 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:18 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 1/8] ext2fs: add new APIs needed for fast commits
Date:   Thu, 21 Jan 2021 21:44:57 -0800
Message-Id: <20210122054504.1498532-2-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch adds the following new APIs:

Count the total number of blocks occupied by inode including
intermediate extent tree nodes.
extern errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
                                     struct ext2_inode *inode,
				     blk64_t *ret_count);

Convert ext3_extent to ext2fs_extent.
extern void ext2fs_convert_extent(struct ext2fs_extent *to,
                                       struct ext3_extent *from);

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/ext2fs/ext2fs.h |  4 +++
 lib/ext2fs/extent.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 7218fde9..7a25e0e5 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1341,6 +1341,10 @@ extern errcode_t ext2fs_extent_fix_parents(ext2_extent_handle_t handle);
 extern size_t ext2fs_max_extent_depth(ext2_extent_handle_t handle);
 extern errcode_t ext2fs_fix_extents_checksums(ext2_filsys fs, ext2_ino_t ino,
 					      struct ext2_inode *inode);
+extern errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
+				     struct ext2_inode *inode, blk64_t *ret_count);
+extern errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *from,
+				      int len);
 
 /* fallocate.c */
 #define EXT2_FALLOCATE_ZERO_BLOCKS	(0x1)
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index ac3dbfec..bde6b0f3 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1785,6 +1785,70 @@ out:
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
+errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
+			      struct ext2_inode *inode, blk64_t *ret_count)
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
+	*ret_count = blkcount;
+	ext2fs_extent_free(handle);
+
+	return 0;
+}
+
 #ifdef DEBUG
 /*
  * Override debugfs's prompt
-- 
2.30.0.280.ga3ce27912f-goog

