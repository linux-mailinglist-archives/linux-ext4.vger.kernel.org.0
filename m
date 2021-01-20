Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5E2FDDF3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403770AbhAUAa4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbhATVbh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA10C0617A9
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 11so15327602pfu.4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhHEKsESVRhOZd584GINUorgKBPZwu3WJYFtKZs98w4=;
        b=kukvg0IId/JO2kZOsaPFbCrEgUiLvcX3FH6cUSUwUFKFMA5PgQ9K7vIS/97ricvOKp
         kmuJhcyEYVLdijHBiOPogdr6RJuaOQHdXrIXPlXIw5qendjAvP8WSAxKm8xdfhVDt7nK
         mzzkL7RIJaoIN+iNICoqGMQcykP0AJjFonx2qNFVXcoQ8PGNZ4clBcjvfe9gaglq/8GA
         vOb6xGA4yS+we+gAmmD7rd+wLpwgBefb4aXgBvNoQh6gNClMtZzE8ZeaOCpnKCOKcZD1
         iVlWDbVT2v+Sijtro23bKFzDmDQqbBUdayMVkquwzxExu3LEmByGURs4ja/A1dDCv6Hj
         8e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhHEKsESVRhOZd584GINUorgKBPZwu3WJYFtKZs98w4=;
        b=B/Z9uSOCQdQML4ocUrfBC1ew2n4uSbMvmN477nWooAAuEtsyk38VpGsrdmvqyVrHzj
         wJP0cLUD5ceO2VmdwfCgiqK8axViWtlgaUk2+EY5LSFAKJ4OwKPaSDb8NWRchRtDJ0xi
         MXB1d1NBmOBlSk/0lAyJHZZpnBpBkkK8RX7KYnWq3AVxkDQ22yhQd/pWtN3NAtBh6jGP
         pzeFRjhWRqDN8uADY+Oyv7xE81QBw7itCa9Cix2kT6HYCIzBvDkbDF9m/QmNob3sUieM
         ZBHcFETpPcRFbpm5eT5klzjGvlTkmoVUijfI3yAzdGUmnzM3IR4lsgjk6hKvR4ZUXn/W
         EpIQ==
X-Gm-Message-State: AOAM532HwnnA/XjY3y37JU2T9gJFsklaqSB6+EqVkeRWh05iBDwI3pk8
        8nXeBcs4mFTlgQ8dAkLrr7lSz90wg+g=
X-Google-Smtp-Source: ABdhPJw9+zlyV1Tqp+jPFt14DjSklId7Sh42sAYj9nkBR563uwJ8NcjkHa0rwdnLUXBv08uCUeFaFg==
X-Received: by 2002:a05:6a00:2281:b029:1bb:15d2:3b9f with SMTP id f1-20020a056a002281b02901bb15d23b9fmr3783896pfe.25.1611178013170;
        Wed, 20 Jan 2021 13:26:53 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:52 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 06/15] ext2fs: add new APIs needed for fast commits
Date:   Wed, 20 Jan 2021 13:26:32 -0800
Message-Id: <20210120212641.526556-7-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
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
2.30.0.284.gd98b1dd5eaa7-goog

