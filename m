Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0893100CC
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Feb 2021 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBDXhG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Feb 2021 18:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBDXg4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Feb 2021 18:36:56 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48ADC06178A
        for <linux-ext4@vger.kernel.org>; Thu,  4 Feb 2021 15:36:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b21so3228522pgk.7
        for <linux-ext4@vger.kernel.org>; Thu, 04 Feb 2021 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RI6BKTkMfh9NjM4KTjN1e04RS7UgFLGTZmhcEBLUYDA=;
        b=Y3xjQJBSqetp/ayigDiW7virAd6ocVyaA1Lx/V5Ez+7iAveAGyCZmP6EXyHXPDcrqD
         3jYe4bOsncVoLK4WCvl78cj4y9E2iWa1y/+yhc8u/UF6h4JZ43a9b6K7i8agQ7h3B6Ar
         sSwm8wjG/vOcis0dVOs4deee5gfgXs6E+np1pp71dhtq4kGecCZCFuXu+yQ6dvV5zaeD
         D06DRIgqxYdhjW/H3zua3tW+z1fEjkHWqvZpakcSdi3bDbDLznpINFlZXL1+NE6OvtFf
         1lQhyu4TdXPENDwTW8JzIuiPRx27xqGaj3YrQXv0QQDNHTkcRNLSq6fHOEmT1qHytwjJ
         Ywig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RI6BKTkMfh9NjM4KTjN1e04RS7UgFLGTZmhcEBLUYDA=;
        b=NWMHrOFHIPhbyCoQlIkaf+I+og5qSjSCM+usHX6Uq5FcbSmI11WqVorzR7H6gyeeBg
         ucPxnGUepG/ogZgvFpYefnHmUvDFlpa/mD/SazkaCvyZK61X6GVjJtUORVIrOcmCLYn7
         UQFNPJuqKXAnNk/7daXQzSEFIEtCqmBO1A1TlGvi+u3R6fYsl0zpn1H2/6Z/+LWRvZfR
         H0SU0Fc5XJ6SrxWWUcPYkG6NWkiVkohSbmvSayGN7zDqQPeaRjrqHAqn2GUqii1mi0pW
         utU5Wn+x67fZdikwJAg7jZ8tfUu4J9mF9JnETuGSGcnfELhE5ymf95wP+obbuUAd8j7w
         G42A==
X-Gm-Message-State: AOAM530zDJP4v6XkIjIsrSc+qrHcf/UEhVuUF4WJATzuq6oC7d9k85pz
        znk5D+V1Jpj5YpD0ufUhUhOnu87UGso=
X-Google-Smtp-Source: ABdhPJyAn8I9E04IZheE8Iya/9w4w2nkHaw600vcGHHybuf7uo7eoT2pr3hGqOoLeDquUzSsHYxpsQ==
X-Received: by 2002:a63:1602:: with SMTP id w2mr1483974pgl.128.1612481775835;
        Thu, 04 Feb 2021 15:36:15 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:5142:d9c7:4222:def5])
        by smtp.googlemail.com with ESMTPSA id mv14sm10236149pjb.0.2021.02.04.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:36:15 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 3/3] e2fsck: endianness fixes for fast commit replay
Date:   Thu,  4 Feb 2021 15:36:01 -0800
Message-Id: <20210204233601.2369470-3-harshads@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204233601.2369470-1-harshads@google.com>
References: <20210204233601.2369470-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

There are a few places where the endianness conversion wasn't done
right. This patch fixes that. Verified that after this patch,
j_recover_fast_commit passes on big endian qemu VM.

root@debian-powerpc:~/e2fsprogs/tests# make j_recover_fast_commit
j_recover_fast_commit: : ok

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 922c252d..2708942a 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -706,19 +706,19 @@ out:
 static void ext4_fc_replay_fixup_iblocks(struct ext2_inode_large *ondisk_inode,
 	struct ext2_inode_large *fc_inode)
 {
-	if (le32_to_cpu(ondisk_inode->i_flags) & EXT4_EXTENTS_FL) {
+	if (ondisk_inode->i_flags & EXT4_EXTENTS_FL) {
 		struct ext3_extent_header *eh;
 
 		eh = (struct ext3_extent_header *)(&ondisk_inode->i_block[0]);
-		if (eh->eh_magic != EXT3_EXT_MAGIC) {
+		if (le16_to_cpu(eh->eh_magic) != EXT3_EXT_MAGIC) {
 			memset(eh, 0, sizeof(*eh));
-			eh->eh_magic = EXT3_EXT_MAGIC;
+			eh->eh_magic = cpu_to_le16(EXT3_EXT_MAGIC);
 			eh->eh_max = cpu_to_le16(
 				(sizeof(ondisk_inode->i_block) -
 					sizeof(struct ext3_extent_header)) /
-					sizeof(struct ext3_extent));
+				sizeof(struct ext3_extent));
 		}
-	} else if (le32_to_cpu(ondisk_inode->i_flags) & EXT4_INLINE_DATA_FL) {
+	} else if (ondisk_inode->i_flags & EXT4_INLINE_DATA_FL) {
 		memcpy(ondisk_inode->i_block, fc_inode->i_block,
 			sizeof(fc_inode->i_block));
 	}
@@ -728,34 +728,41 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 {
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ino, inode_len = EXT2_GOOD_OLD_INODE_SIZE;
-	struct ext2_inode_large *inode = NULL;
-	struct ext4_fc_inode *fc_inode;
+	struct ext2_inode_large *inode = NULL, *fc_inode = NULL;
+	struct ext4_fc_inode *fc_inode_val;
 	errcode_t err;
 	blk64_t blks;
 
-	fc_inode = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(fc_inode->fc_ino);
+	fc_inode_val = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
+	ino = le32_to_cpu(fc_inode_val->fc_ino);
 
 	if (EXT2_INODE_SIZE(ctx->fs->super) > EXT2_GOOD_OLD_INODE_SIZE)
 		inode_len += ext2fs_le16_to_cpu(
-			((struct ext2_inode_large *)fc_inode->fc_raw_inode)
+			((struct ext2_inode_large *)fc_inode_val->fc_raw_inode)
 				->i_extra_isize);
 	err = ext2fs_get_mem(inode_len, &inode);
 	if (err)
-		return errcode_to_errno(err);
+		goto out;
+	err = ext2fs_get_mem(inode_len, &fc_inode);
+	if (err)
+		goto out;
 	ext4_fc_flush_extents(ctx, ino);
 
 	err = ext2fs_read_inode_full(ctx->fs, ino, (struct ext2_inode *)inode,
 					inode_len);
 	if (err)
 		goto out;
-	memcpy(inode, fc_inode->fc_raw_inode,
-		offsetof(struct ext2_inode_large, i_block));
-	memcpy(&inode->i_generation,
-		&((struct ext2_inode_large *)(fc_inode->fc_raw_inode))->i_generation,
+#ifdef WORDS_BIGENDIAN
+	ext2fs_swap_inode_full(ctx->fs, fc_inode,
+			       (struct ext2_inode_large *)fc_inode_val->fc_raw_inode,
+			       0, sizeof(*inode));
+#else
+	memcpy(fc_inode, fc_inode_val->fc_raw_inode, inode_len);
+#endif
+	memcpy(inode, fc_inode, offsetof(struct ext2_inode_large, i_block));
+	memcpy(&inode->i_generation, &fc_inode->i_generation,
 		inode_len - offsetof(struct ext2_inode_large, i_generation));
-	ext4_fc_replay_fixup_iblocks(inode,
-		(struct ext2_inode_large *)fc_inode->fc_raw_inode);
+	ext4_fc_replay_fixup_iblocks(inode, fc_inode);
 	err = ext2fs_count_blocks(ctx->fs, ino, EXT2_INODE(inode), &blks);
 	if (err)
 		goto out;
@@ -774,6 +781,7 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 
 out:
 	ext2fs_free_mem(&inode);
+	ext2fs_free_mem(&fc_inode);
 	return errcode_to_errno(err);
 }
 
@@ -819,7 +827,7 @@ static int ext4_fc_handle_del_range(e2fsck_t ctx, struct ext4_fc_tl *tl)
 
 	memset(&extent, 0, sizeof(extent));
 	extent.e_lblk = ext2fs_le32_to_cpu(del_range->fc_lblk);
-	extent.e_len = ext2fs_le16_to_cpu(del_range->fc_len);
+	extent.e_len = ext2fs_le32_to_cpu(del_range->fc_len);
 	ret = ext4_fc_read_extents(ctx, ino);
 	if (ret)
 		return ret;
-- 
2.30.0.365.g02bc693789-goog

