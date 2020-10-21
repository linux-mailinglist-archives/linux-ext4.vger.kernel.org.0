Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0C294A4D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437549AbgJUJQO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgJUJQN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D5C0613CF
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so1122064pfp.5
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DYPRUGrJa1UcR6EzKh7Vsiy0NCh65P8azvf+4W9rR10=;
        b=AUFxeApKqTLVdORbPZwrlbvLJFlbXzTMVh/NzQ/kVoDPp8cHG8n4M3V/jF452wWXiB
         98SgpcGYZlcfl9/bUaZL89DgCNbKN552XJix9+Rum4mTQ+Db7hQ+/qJltkkux9uQa+5+
         NAgQW9c1dLh6DnOGkwNi2/itZ/6gk2ux2PNlfanm8E4bvK2+A7xLANKLiO7H8OKrgGMg
         Sl/AgTTAMylcZ6OLx9BQGhp995FaAmoTi+Vojhbacb5LWks1M4WhKslxxZd7ZjOilrBn
         8kRjIHXNzRtBe8UpqPbF7x8mZHz5jvUVNX/hwsMxWkRoyPvPKBLWLvFQMWEefU5dMIwf
         BmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DYPRUGrJa1UcR6EzKh7Vsiy0NCh65P8azvf+4W9rR10=;
        b=DQ5SCCt8xHQMssvzYm1s480ElHzaksoDa+AChMvE/TqFxKnZlVUn6ClqIig8IlM/Et
         6lhoutGUulYpJlzPvl9R3IQv96CcITPlftQIze0onpe/ZHw+svXskzjZYOCBA6KFzIRy
         ZdiBN5II2jEt8sQDYEFhMEt0unwgd5azsZT+lHM1Iy3dPUdXoAZuqr2CLxasKFPIMG8c
         7C5cMsNIFR0EfIBaQCxQYCDT8f+0Q7G0c69nO886ULVwbf+jrU6SDYxYVcFN/42Sh5CQ
         EiUqsgXJbQdjvMts2TrM8HlT3V1P0WhWn+nCgnm6n0M9ihuMvq+1+OOTq/RyE4KC2zKb
         vlwA==
X-Gm-Message-State: AOAM530hziRcSX1L2uXsU8fY8fv4UqvIWTLknMUE8T5HzeFOTIJ2w019
        alifncZEcIlH7T60OK1Fz4AzX1GbfTY=
X-Google-Smtp-Source: ABdhPJxTEFzIul1z3OZVo1Jc6a+h7gZHJFHcRaittJ9cCUQC574Eezzjns3t7VAv7TbSIyN54HGgUg==
X-Received: by 2002:aa7:9048:0:b029:152:883a:9a94 with SMTP id n8-20020aa790480000b0290152883a9a94mr2496532pfo.24.1603271772992;
        Wed, 21 Oct 2020 02:16:12 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:12 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/8] ext4: remove redundant mb_regenerate_buddy()
Date:   Wed, 21 Oct 2020 17:15:22 +0800
Message-Id: <1603271728-7198-2-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
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
index 85abbfb..22301f3 100644
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

