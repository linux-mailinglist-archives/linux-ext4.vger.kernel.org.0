Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B72AA679
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKGP6n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgKGP6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:43 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCDC0613D2
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:43 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so2405950plo.0
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prCHr1Qm4fANZO9EoAFrXQE5GSwUExCTKLrBWMgi4jg=;
        b=eDDsEmrYthzmZmOSh02CJhiiRMCC1AiQD+eTzybjWdiInc7BivC8eKkDrhUyPS2z13
         +/zC6HtukDX5Jc6jc+ND9s2+Mzu3723XzS/Zl4kU669zG/gRslcJ1irduZ3V/yWX+F2l
         9PqXyfotzEhlYGL8v0rD7mM2dG6m5nChVPTJpMvbH96AmkHVbgbTOQwy+R/8zwe123ZA
         6ONF0uv3OYgX99MyxtehZ3snDU92ih0i4Lbe43QgG3l/i+eg0FZ2lqUaXIFIH3VJVFLe
         uT0KnYZ95PtgLY5/EIDvh6E2D9bWohKobzFUiNlbgpmCfiP7bRIrjvfCgBoA15yU0Jwj
         w4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prCHr1Qm4fANZO9EoAFrXQE5GSwUExCTKLrBWMgi4jg=;
        b=gFRIS3SZ7gC93D/c6jV8QrYyw76JN2CVQi3dHHjJEOx/w6KH75dVHErMEqkz9Zynsy
         JWSQZB6J/K8wf8rnwDajmlauCVcmfxoQzTJe3uC4I5R/m0fn+IabJcfqA3kQU9TN1s+e
         8mccURS6/X9ZnUoeJWC7OCy2MWo1303/42lOvKAN4RET8ROTPG9943/mHbXa9cwhf/Hu
         1ACnE4G7hSES9rfmslGhydU/spzhsyktbYIZHr4iBjHrgkSSLi4GR7udp3508WSeQkrA
         vH884Q8mE9yVz38HQQyTH95M/FHFYJZ3hHRrZyYBSR6hXYoEH7jCw0n1sgrozqcGN+bc
         ALdA==
X-Gm-Message-State: AOAM533SPR7QrYSB4P+7oRmGbtGxcAHOOc6ykjSwZF1f/Dq4G9bS3Ywa
        bGWSeRbpaLs8TbRxPFB7YdaZBXXEcn4=
X-Google-Smtp-Source: ABdhPJwO2/7sRwwDj5Djs/yB1qAlqo+yq3uaVO3tD9rNxNeh5vkFdMVia+7xRQi5ITGGXzAfjh/ajw==
X-Received: by 2002:a17:90a:15c8:: with SMTP id w8mr4856377pjd.66.1604764722867;
        Sat, 07 Nov 2020 07:58:42 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:42 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 2/8] ext4: remove redundant mb_regenerate_buddy()
Date:   Sat,  7 Nov 2020 23:58:12 +0800
Message-Id: <1604764698-4269-2-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

After this patch (163a203), if an abnormal bitmap is detected, we
will mark the group as corrupt, and we will not use this group in
the future. Therefore, it should be meaningless to regenerate the
buddy bitmap of this group, It might be better to delete it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/mballoc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 24af9ed..5b74555 100644
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
@@ -1512,7 +1494,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		}
-		mb_regenerate_buddy(e4b);
 		goto done;
 	}
 
-- 
1.8.3.1

