Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396DF320014
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBSVE2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 16:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSVE1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 16:04:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE6C061574
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id m2so5749420pgq.5
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrnY6Npwb6W1700F7fs11McB1yk4bBHdasXw09wHVUI=;
        b=uwXpt8QlADhefDb4ozF+N7zHLCtbSpoF+FoGLFWXx8zBVkMMdJ8KlF9ToTR5kCjkC8
         ySP1aML11C2bqeV9+iHn8exEx0K5tdPY/R+k8C4Azc8zVnWIDzovmyG5obUkjso1WtZA
         fIEvr+lPU00+yh6euea8GdFq0ZeWakReT0P2lUsiHdN9n02fB80xk/6LnvoT8JFVpFQ3
         cDFKzQfTafA+dbXqaBL3OQoe5yCO/ytzHKk5ROa0gEyh6QBJ44lkTIGGVyDInRjTwa7T
         VS4pxB6hrcLna2pfIoK7KZCzhKxWOEtwHVW++aUh8Ktia0LAzgXRXZk0WtFacW2XFnJy
         SXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CrnY6Npwb6W1700F7fs11McB1yk4bBHdasXw09wHVUI=;
        b=UTgRwVpptflx6ecgwQ4fVjhEA0dsWBMIp4WdvEzy2GZBYESsg5IqcIBYDbGKwag9BA
         /oO233hsGBeYswvQa/b/4gWmMvRna73BJYPUIdNr2/zk9wn/b8ntOmI0IuIbEP5d5bg8
         FLYoXPVCIftRJ6fx8DjX6BLsJ45SavBvDWZiaqS+UmnFTpAKAIa91YRunOwXaPJpReRZ
         Xhy7i8j8hRxrTqUSUiQMAFN0CEymvrd9QI2DQuwycttSHO3ANaG5p9O7QJntsgew3vNj
         qb1L+WDm+B0WzzMF++dA9MNIFRapKlIQK/YZoCLJdRIeCx3YcpvQ/uzVkIExW2PkG14C
         Tmug==
X-Gm-Message-State: AOAM530muH+EmouoXES9de+ZJY141LHG8386eoh6B18cDxfWGQ0a/sAh
        3a7xl+F85Wo7y7+akapHAHvpV7P39H8=
X-Google-Smtp-Source: ABdhPJzPy9rKeBBGE5vwIi5vT2F68nzgx8k538oAp9dQrhyT2huj75YsoAPdE32He27VYyXurfStAw==
X-Received: by 2002:a63:8f4c:: with SMTP id r12mr9980755pgn.311.1613768626160;
        Fri, 19 Feb 2021 13:03:46 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:48e6:60ce:73b8:bccd])
        by smtp.googlemail.com with ESMTPSA id 30sm10318756pgl.77.2021.02.19.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:03:45 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/4] e2fsck: don't ignore return values in e2fsck_rewrite_extent_tree
Date:   Fri, 19 Feb 2021 13:03:30 -0800
Message-Id: <20210219210333.1439525-1-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Don't ignore return values of ext2fs_read/write_inode_full() in
e2fsck_rewrite_extent_tree.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/extents.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 600dbc97..f48f14ff 100644
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
@@ -306,10 +308,8 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx, struct extent_list *list)
 	if (err)
 		return err;
 	ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode), blk_count);
-	ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
-		sizeof(inode));
-
-	return 0;
+	return ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+				       sizeof(inode));
 }
 
 errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list *extents)
-- 
2.30.0.617.g56c4b15f3c-goog

