Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F70322FCA
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhBWRnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBWRnA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 12:43:00 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E70C061786
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id r5so3286736pfh.13
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQo1kj2nVSRFSSFkZ42zbMx/gberwXa3UDbaiFT879Q=;
        b=OxhJgNmkO0nSoeczR3+X5y/16xPmhltRjhVv3b6q+F9t49GPnXezU364jSHJeF5r6G
         CNFq3MBsNABfzCy1X/iMupTHBB2wDmwNOl+Wk9DAB04BJ93db5Tcne1J0XzRhMpaSrts
         SN2SaULlSQ7KpY42QDTjCpVEwJZh8xtk0o7toXbqkxZHqd3hoOHHnhes36jj/PAXzjqm
         aFWqbN3J47W8cxV6HwgR3jv1qR/r7wfQ1Syw0pWLh8tenWW4QKbLshhzcqu7qPoAeXp2
         ujQ65UXL37WLTChg2ceaogffBQ1QZLJzc0bwlxxS8I2mZPc7su+uY3TRt1AosYvi1ICl
         hfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQo1kj2nVSRFSSFkZ42zbMx/gberwXa3UDbaiFT879Q=;
        b=DuYDvNGL2zYDuIJlztp09svawiBHncbSOiRa+w4GXkk8SpVq3EQjsp2Fib+MFKx0NQ
         m3x8WM5eKpia/lk++xJP/cWK55AojQVMQxNA6h7WqTfrtf2A5sneL/il/+uHf6k4dBmO
         UJ1zPQBqATtSEbNCCFByb2hTHqE5ZB4/JKRhhRjOR8rw5lBtifEOKBq5PMvsumIf5bdU
         +tqN3rfbbiRXyQ6Uco4t2OFgFSXzNSzIV+q0DF855z2+Kn66d2AGB2iyc89mobHT005G
         uh9k5PujK7eRRYgG7UdCnO4TaGOXDKYBFTYvxq95C1MwURi1RGlk0LpqbuU38Y+F3fgM
         ldxw==
X-Gm-Message-State: AOAM5304+ASr51876HBkdOtmBRpqGNAahbdnhf0OQIBamo8v5MOdByjR
        F3LO8WKuVGJWk9ZfViwgDN2YNp4yzq0=
X-Google-Smtp-Source: ABdhPJxicYBICcQ40pc0TrUNQswUqxNX57lWWaBUuWDlx75yUZy3V3E5YOd+kvYNIQE0+FDADZ95ow==
X-Received: by 2002:a63:141e:: with SMTP id u30mr8816880pgl.31.1614102139657;
        Tue, 23 Feb 2021 09:42:19 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:9c60:903e:f56e:8b80])
        by smtp.googlemail.com with ESMTPSA id gk14sm5527408pjb.2.2021.02.23.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:42:17 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 1/4] e2fsck: don't ignore return values in e2fsck_rewrite_extent_tree
Date:   Tue, 23 Feb 2021 09:41:53 -0800
Message-Id: <20210223174156.308507-1-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Don't ignore return values of library function calls in
e2fsck_rewrite_extent_tree.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/extents.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 600dbc97..018737af 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -290,8 +290,10 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx, struct extent_list *list)
 	errcode_t err;
 
 	memset(&inode, 0, sizeof(inode));
-	ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
-				sizeof(inode));
+	err = ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+				     sizeof(inode));
+	if (err)
+		return err;
 
 	/* Skip deleted inodes and inline data files */
 	if (inode.i_flags & EXT4_INLINE_DATA_FL)
@@ -305,11 +307,11 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx, struct extent_list *list)
 				  &blk_count);
 	if (err)
 		return err;
-	ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode), blk_count);
-	ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
-		sizeof(inode));
-
-	return 0;
+	err = ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode), blk_count);
+	if (err)
+		return err;
+	return ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+				       sizeof(inode));
 }
 
 errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list *extents)
-- 
2.30.0.617.g56c4b15f3c-goog

