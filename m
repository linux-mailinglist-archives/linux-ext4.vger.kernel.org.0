Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370602BB506
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgKTTQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgKTTQb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:31 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BBFC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:31 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so8777947pfg.8
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzPvEcwen9tCzLMhzmMye/H24Zg7QoAC4q5q+4mVfC8=;
        b=KSs3yC7/3o9o6PF8qS6wd8wUjlbB+n6LQoFXCg5+6NaT88Sx8CR7HrjehOUsepnS6L
         lF5LVIVmO18hB+X5PN9bbmj+HEMQ0qQkNSphJckrQ4cPI59G/OpZj+apUeTb1G3nQX5C
         L+oqkab2fblmgazpJqZ9HKbiBZnh1fKHwHcf62UQaDDiIrnqkANiqRkUVTCJxZVPZDE+
         /jOdg0k8niRG1vp0nnbcpReLb4cBixTP8D0w0FB46uwOVhnws8MaYv9vPK4CuxH5R2xh
         jWh05GXRIKEL1XYskQWpMtU/Z61ibpB3+NDTvKEsUcuA26tuKLyIvmgxcLnAuC/1096l
         lBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzPvEcwen9tCzLMhzmMye/H24Zg7QoAC4q5q+4mVfC8=;
        b=bcShqQHPKYcKVVOIojGS4v9wwjZvSetvJP9BYrnUe+DY8gG30vMJ0UcaKpgzRihgC1
         CrXmM5nSRv/BJV+7K/6WP0lAwkLCXaOsWbI0RhNHYG0Ia6wNXNpKqlGsLD5d6n2MSE3D
         1X1uXtvSdyzm8wfjoebCA57XlAd5RmZdcBQNB44EUt9OlpmAJwYmDHL7UFu2ARZ6b0q6
         LeQrQUOlguDrlG+p7g/UNaMlQIldTFKCaaRP6ixAFGC4V5/+S99/8ltD0InYmBb95jyH
         d2joQZjRFPEKRmcpkipdT1nE8jyLxqojfgd0TCiIe3oBODwujrECaBtgPGRqC1nR2xux
         P1HQ==
X-Gm-Message-State: AOAM533xSEBOg5lpn5tjdgfXcNBPWFo4mx8V6ibCkfmE8gxHY6p8PJnI
        myOVqolK1Qo8EDXIhUm9L94EitA8Umw=
X-Google-Smtp-Source: ABdhPJzNDy5bHimAwHRirmAychzu5eVTPRI9H8NNTDiBNd2v+Vyrkczk38UNjm8gKLir7gLQmtT0CQ==
X-Received: by 2002:a17:90a:14e5:: with SMTP id k92mr11691739pja.169.1605899790478;
        Fri, 20 Nov 2020 11:16:30 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:29 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 06/15] ext2fs: add new APIs needed for fast commits
Date:   Fri, 20 Nov 2020 11:15:57 -0800
Message-Id: <20201120191606.2224881-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
 lib/ext2fs/ext2fs.h |  4 ++++
 lib/ext2fs/extent.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 01132245..afa9c5e4 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1332,6 +1332,10 @@ extern errcode_t ext2fs_extent_fix_parents(ext2_extent_handle_t handle);
 extern size_t ext2fs_max_extent_depth(ext2_extent_handle_t handle);
 extern errcode_t ext2fs_fix_extents_checksums(ext2_filsys fs, ext2_ino_t ino,
 					      struct ext2_inode *inode);
+extern blk64_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
+					struct ext2_inode *inode);
+extern void ext2fs_convert_extent(struct ext2fs_extent *to,
+					struct ext3_extent *from);
 
 /* fallocate.c */
 #define EXT2_FALLOCATE_ZERO_BLOCKS	(0x1)
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index ac3dbfec..43feea0a 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1785,6 +1785,62 @@ out:
 	return errcode;
 }
 
+void ext2fs_convert_extent(struct ext2fs_extent *to,  struct ext3_extent *from)
+{
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
2.29.2.454.gaff20da3a2-goog

