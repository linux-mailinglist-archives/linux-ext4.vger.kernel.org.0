Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB529242F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgJSJCo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgJSJCn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2320C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e15so2405805pfh.6
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XpfG+4jXy7K1bkPX3W7h6p4E1sSG2ZJ02T8UEM6O1EE=;
        b=BCY06CJMeIOX23knlSNZsYIjJjhQAkLVn1mtyE6ajBaO47qgqbyhc+xSzP9AE2uSkG
         uaf/jjlVCO5HM9fcpoPqbLxm5eMD8+j2z0GIj5LMO2w/7sDybIvNf+Aoj92cGEsgbWkP
         7RIyQwzIZglV0s4TrK4K2SA09D9Z8LGIMkZu9iKF8O6PAMJ5Aiw9fsY0aVW0PE5pq2G1
         0oEtl26QR6ciDTOtRaHO/wsBmgREZEHOaGCgqilAeNO1GGJ05nVTdJSZKfEi+mPTlx9j
         cvjM0Ks4x9mCcB+1noCjTfKS6iYIyWx9qKCXFmPQbdUW3sA8+b1dEnlcAlAVzQkrgdQ+
         v0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XpfG+4jXy7K1bkPX3W7h6p4E1sSG2ZJ02T8UEM6O1EE=;
        b=EXqkEgrPR9F3Ds9woPzR5M2wZ1j4W//Fy6SIa7YPps3tcCtibqfOwZxNIFlcnW8djA
         wamVRKf8KOxWVQrGPGizIGVhovdTkBKHKFJBIKg7Gf4uzP/ILW8qebbSlGffQ+1SrFuF
         SetmnNviLBQal3h/BDQheEbCZmtVfCdQQ9C7py/fSUBut/SXuFLb3K3dVEVdJkaQq2SJ
         1QIA2sShZiKlI61P5QgScOuBALr0XGyyZ0DwaQLnOx31KmD6pjJsSsAvO32aMCagVavW
         RW1wkV11XOPxtTHpO7vH1FaAXPiBnDy5I04cFnnWvVINtAfNNDgWAbAddMAZEhE9gOdD
         h+7w==
X-Gm-Message-State: AOAM531Zj7pRJsbvT9P1Q4X6kcXOTBT/bDDWmNtWqkmLw4Omi9RCSzK7
        7GU3IEDq2chZvljlXd8JUTIMBeCrhcI=
X-Google-Smtp-Source: ABdhPJzr0qJK/m6h8frGqpVLA3k1B8LZpuQ1WQRngLRwk1fwC8wdK/1qWWLUWfkxl+d80Pbz3bXczQ==
X-Received: by 2002:a62:5215:0:b029:156:6a80:a257 with SMTP id g21-20020a6252150000b02901566a80a257mr15696001pfb.63.1603098163441;
        Mon, 19 Oct 2020 02:02:43 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:42 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 2/8] ext4: remove redundant mb_regenerate_buddy()
Date:   Mon, 19 Oct 2020 17:02:32 +0800
Message-Id: <1603098158-30406-2-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After this patch (163a203), if an abnormal bitmap is detected, we
will mark the group as corrupt, and we will not use this group in
the future. Therefore, it should be meaningless to regenerate the
buddy bitmap of this group, It might be better to delete it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 74a48d6..03337c8 100644
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

