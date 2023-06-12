Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211872C48E
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjFLMkc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 08:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFLMkb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 08:40:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C7E4A
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 05:40:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-650bacd6250so3320270b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686573630; x=1689165630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJquZgA76BSmiwPTwdcZvv8HMtB2zit5x2dH7MVfNuM=;
        b=Kq6vT1wBZ2mNe7fpEVKhE76AM3FBq23mdh2fJe4UVHhZU2+Qd0RVdAT6+V6LuTbHL9
         IDtFIam3dKQyodkBimhtPGDqn+nZl95gjcTR8QM//HHgKhkuYUoYVPI/R3VoJEed6BHA
         7qinyAWccJNBV9qzMSEK596SIMbWuy/4EeElaA6ObqPP6XCbc4Zu5anUNxMPSjGD9AZV
         ovMBSK8qRqA8NCESCGicChVWHC3TLJT7Bk8Q/Twqr2ubSw3ua64MPYmFsNP1JhmeyTjw
         XP1to15m0x2E6dPDwSVi6vE8GOar3+Uh1Z4mZkDmMUFRiyFJx+zxDoukfJnspp0YUQmh
         tsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686573630; x=1689165630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJquZgA76BSmiwPTwdcZvv8HMtB2zit5x2dH7MVfNuM=;
        b=WKW7qP/t0FC7dkTYdsfeMDa9eRHTjUHmWHiqCM1sguWQOfqiKh4ttMScHNTy3iIuqo
         05wA//W97HfnTLBEH5pPdEJ2SEGVLffwTLU0TAce2D2uD0Qo2dEH8BFI9zd81YqZmSbb
         aDDtur+viF8dmIoK+nRWrIEc/X1PlyYwETYrYBsIDo5tFa6+fbzLqYZxz79uuKQPmYfg
         D5X1wgjyKQ/O7GQIleNT3HyAvlDGE+c+nByIcvVeqINJ1ywXkecRQo7dRgIpjPlIj9TD
         NAcvrdMbFbVi5cpRDnWXGWgRS5Xdk7X8Ecv0iNDi/EnvUrNJRJ5kk3Ql4HG1EhzbmdDp
         RJ8A==
X-Gm-Message-State: AC+VfDwMkTse0rkoWsmU2doZjT4joW6o1ylmBC8RP3jPG/e+l1V9wVB3
        f74GbtUtHMIY4XTSjd0ZJm3wdw==
X-Google-Smtp-Source: ACHHUZ66Dfxma/yCR3b6ZMAOci7Ea2V7yR3Q4VsR+NeJ/p3wh2BH71xudK0ajK+OO+H5A3mNIPYh8Q==
X-Received: by 2002:a17:903:1207:b0:1ae:8b4b:327d with SMTP id l7-20020a170903120700b001ae8b4b327dmr9068984plh.42.1686573629968;
        Mon, 12 Jun 2023 05:40:29 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001a6f7744a27sm2394019plg.87.2023.06.12.05.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:40:29 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] ext4: Make running and commit transaction have their own freed_data_list
Date:   Mon, 12 Jun 2023 20:40:17 +0800
Message-Id: <20230612124017.14115-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

When releasing space in jbd, we traverse s_freed_data_list to get the
free range belonging to the current commit transaction. In extreme cases,
the time spent may not be small, and we have observed cases exceeding
10ms. This patch makes running and commit transactions manage their own
free_data_list respectively, eliminating unnecessary traversal.

And in the callback phase of the commit transaction, no one will touch
it except the jbd thread itself, so s_md_lock is no longer needed.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/mballoc.c | 19 +++++--------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 813b4da098a0..356905357dc9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1557,7 +1557,7 @@ struct ext4_sb_info {
 	unsigned int *s_mb_maxs;
 	unsigned int s_group_info_size;
 	unsigned int s_mb_free_pending;
-	struct list_head s_freed_data_list;	/* List of blocks to be freed
+	struct list_head s_freed_data_list[2];	/* List of blocks to be freed
 						   after commit completed */
 	struct list_head s_discard_list;
 	struct work_struct s_discard_work;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4f2a1df98141..8fab5720a979 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3626,7 +3626,8 @@ int ext4_mb_init(struct super_block *sb)
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
-	INIT_LIST_HEAD(&sbi->s_freed_data_list);
+	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
+	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
 	INIT_LIST_HEAD(&sbi->s_discard_list);
 	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
 	atomic_set(&sbi->s_retry_alloc_pending, 0);
@@ -3878,21 +3879,11 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_free_data *entry, *tmp;
 	struct list_head freed_data_list;
-	struct list_head *cut_pos = NULL;
+	struct list_head *s_freed_head = &sbi->s_freed_data_list[commit_tid & 1];
 	bool wake;
 
 	INIT_LIST_HEAD(&freed_data_list);
-
-	spin_lock(&sbi->s_md_lock);
-	list_for_each_entry(entry, &sbi->s_freed_data_list, efd_list) {
-		if (entry->efd_tid != commit_tid)
-			break;
-		cut_pos = &entry->efd_list;
-	}
-	if (cut_pos)
-		list_cut_position(&freed_data_list, &sbi->s_freed_data_list,
-				  cut_pos);
-	spin_unlock(&sbi->s_md_lock);
+	list_replace_init(s_freed_head, &freed_data_list);
 
 	list_for_each_entry(entry, &freed_data_list, efd_list)
 		ext4_free_data_in_buddy(sb, entry);
@@ -6298,7 +6289,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	}
 
 	spin_lock(&sbi->s_md_lock);
-	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
+	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
 	sbi->s_mb_free_pending += clusters;
 	spin_unlock(&sbi->s_md_lock);
 }
-- 
2.20.1

