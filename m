Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA65322FCB
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhBWRnK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhBWRnE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 12:43:04 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7D7C061574
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:24 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so12820769pgl.10
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75c0REdhzMgWGu4NXzfQnu8KSZIrAqpqhx602Q2twFs=;
        b=HoyW4bU7uDAkZJIvFShPPVu2NzBtapTcVzbyul64LSFy/luXjCzPpi6TSfZAiQBzuJ
         GXWERaDufEPeZ36zBhi1SgUy5ZeI6ZebcNuGqnFadYTONH/iE3qvYJWO5GratIYfObM4
         lbGEvY5BRcVLpbuBYT1VcJoHbm2CfyfK5VkohFkplMX1lceKWGcrs/cG6OZX7u4nbZ/P
         4GKILgfacwrBm3Uu4ZX2zcY0Q9KyNl2uWaFHZTR6w15yCsoPsUHB2fDiSwzODCmP4BN0
         DVo/DeoVnKAiCOlJD5RwsLj7cmuopJ1GXFEdENuTezOFe3QcooH+HyRD5LzM3pVh7ySb
         9wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75c0REdhzMgWGu4NXzfQnu8KSZIrAqpqhx602Q2twFs=;
        b=R5aCsDeff735O11WEnn93xIbdf8MwwYPiQui5HY4Osd+vddKyvzvwBbgTHKRn3hWrT
         L3tj8rwKLP95A95wereIfFCsbwrmaNiDmo3IxhkCufi/UwnTDnS5Mw0xVQmQGxI/s+67
         GyUMnX7Zedg8tHfwYz8YCg4ZMNZMaNWrrEcQz+4R7tD28Qrqwws7q3Qq4+MWfFtwjrpJ
         k2E+DHlo9DHstxpOGF6cuJ012MSn4Bb8Y4oHk8l8TUhkcwyL3c6inrrlfHILDNH3WRSE
         z8eqU8Jx1SY8XlrCvUbxEYHqJr2aHWnaATVP4FD28xIC2YUephbibLqNSuBxMwqJmUei
         49aQ==
X-Gm-Message-State: AOAM530zv9t/JhGVq3Lo2y3A6vCU1UjpY8/sV32a/4YT0P6f7WrKR714
        xi8ycTDAMw6SYrvTzLltl9S7IecUsw0=
X-Google-Smtp-Source: ABdhPJwDdHxaOvzbu8ZEiD2a1Dv/X+Ko76vuYUe8sZBACjnC1rG4vcV8tWGV3rPGSpp3Ys6oJOuECA==
X-Received: by 2002:a65:5843:: with SMTP id s3mr8992998pgr.425.1614102143597;
        Tue, 23 Feb 2021 09:42:23 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:9c60:903e:f56e:8b80])
        by smtp.googlemail.com with ESMTPSA id gk14sm5527408pjb.2.2021.02.23.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:42:22 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 4/4] e2fsck: initialize variable before first use in fast commit replay
Date:   Tue, 23 Feb 2021 09:41:56 -0800
Message-Id: <20210223174156.308507-4-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210223174156.308507-1-harshads@google.com>
References: <20210223174156.308507-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Initialize ext2fs_ex variable in ext4_fc_replay_scan() before first
use. Also ensure make ext2fs_decode_extent completely overwrite the
extent structure passed to it as argument to prevent potential future
bugs for the users of the function.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c    | 2 +-
 lib/ext2fs/extent.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a67ef745..8e7ba819 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -289,7 +289,7 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 	struct ext4_fc_tail *tail;
 	__u8 *start, *end;
 	struct ext4_fc_head *head;
-	struct ext2fs_extent ext2fs_ex;
+	struct ext2fs_extent ext2fs_ex = {0};
 
 	state = &ctx->fc_replay_state;
 
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index 9e611038..b324c7b0 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1797,7 +1797,7 @@ errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *addr, int len)
 			<< 32);
 	to->e_lblk = ext2fs_le32_to_cpu(from->ee_block);
 	to->e_len = ext2fs_le16_to_cpu(from->ee_len);
-	to->e_flags |= EXT2_EXTENT_FLAGS_LEAF;
+	to->e_flags = EXT2_EXTENT_FLAGS_LEAF;
 	if (to->e_len > EXT_INIT_MAX_LEN) {
 		to->e_len -= EXT_INIT_MAX_LEN;
 		to->e_flags |= EXT2_EXTENT_FLAGS_UNINIT;
-- 
2.30.0.617.g56c4b15f3c-goog

