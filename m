Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3128FD02
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394319AbgJPD4F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394314AbgJPD4C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E4C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so700000pfp.5
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GiP73MTtg21BoAyrRFFkrPiIIvRdM2PWisOE0GLu5/w=;
        b=Ikk4Ohitg8bs1SIF8eh0Jp1sXl5++MXWZhOW3ylZ0Fe16Pxq+5zaqrEF0NJoSou9Wz
         xV6cqtPz6GhnORwVbBvcKaShdN2N/b8Zv1qG1hnNqvDA/s6dqDN5WwFbe5GRK9UAHwis
         GWDIG1ZvVUcDvP4tbKGI8FPkGcWTOyrI+TcAaDJXWDVxxUxQrd41YblRPyhUegb1ZKYK
         D7xdCVq6rH/j8fyg3e3zaKhbjQ8t8DLePmYAR36MwXRiPAE4K0+AoXxgxFvTL3dUjAxG
         Vq/1hFTUNd2Y/uFcvGwS27nJGW2FdNpD4aO4I1pV53Gc4ZyQnD6UcQHHyHRUzzlOsisb
         UJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GiP73MTtg21BoAyrRFFkrPiIIvRdM2PWisOE0GLu5/w=;
        b=AXGH4O5/11hhIme7zSuiA7m2kiFvgOzScBKYViMH6IuHfhvw5G2heNIHwW/bgOkBLH
         K+QKhXiTs2GtXuUzsWnTvU5Cj8lwzZ7pJQd7Qm8jSeUeKxACV5kW/Izw8ru5nxlOCEk3
         Ir2VVwoqXUIM5Fei9L5RBQK9PUiZLOc5TtEKbd9hD5PmWYFu1d6dBgjpmpOSoCD1QQqX
         GD8GUS0V2A0kXcA0EBPkLeDQvzkLgxSE91r9VjqoVOB+xLaFK71byx87keXadyJpgpli
         zdqArn36ffMJToxAOkDxzfeA8z0uNiDdlcE4mAnOZdp/EeVbC2gAXzTmMmwUUDWNEs2p
         fZEw==
X-Gm-Message-State: AOAM5332oeOIiztRao281M1ooQ37OkJ1MaooplK470gUTWKa1R7ELsI8
        HheGA//vvZlVWfTfh+TYNzBdaT6Go7A=
X-Google-Smtp-Source: ABdhPJyr6npZ5hRKu/K1XpyS+BZ7W3IFlNTyNiw9LSP5hVT0wKX1dVekUq71eF8uABm7utkUAEE27Q==
X-Received: by 2002:a62:6241:0:b029:158:caac:f877 with SMTP id w62-20020a6262410000b0290158caacf877mr1710327pfb.71.1602820562155;
        Thu, 15 Oct 2020 20:56:02 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.56.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:01 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/8] ext4: remove redundant mb_regenerate_buddy()
Date:   Fri, 16 Oct 2020 11:55:46 +0800
Message-Id: <1602820552-4082-2-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
References: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

After this patch (163a203), if an abnormal bitmap is detected, we
will mark the group as corrupt, and we will not use this group in
the future. Therefore, it should be meaningless to regenerate the
buddy bitmap of this group, It might be better to delete it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2705a4c..5b8ce76 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -822,24 +822,6 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	spin_unlock(&sbi->s_bal_lock);
 }
 
-static void mb_regenerate_buddy(struct ext4_buddy *e4b)
-{
-	int count;
-	int order = 1;
-	void *buddy;
-
-	while ((buddy = mb_find_buddy(e4b, order++, &count))) {
-		ext4_set_bits(buddy, 0, count);
-	}
-	e4b->bd_info->bb_fragments = 0;
-	memset(e4b->bd_info->bb_counters, 0,
-		sizeof(*e4b->bd_info->bb_counters) *
-		(e4b->bd_sb->s_blocksize_bits + 2));
-
-	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
-		e4b->bd_bitmap, e4b->bd_group);
-}
-
 /* The buddy information is attached the buddy cache inode
  * for convenience. The information regarding each group
  * is loaded via ext4_mb_load_buddy. The information involve
@@ -1510,7 +1492,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 				      block);
 		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
-		mb_regenerate_buddy(e4b);
 		goto done;
 	}
 
-- 
1.8.3.1

