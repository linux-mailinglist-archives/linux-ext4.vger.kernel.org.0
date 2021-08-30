Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7F3FB223
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhH3HzQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 03:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbhH3HzO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 03:55:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4413C061575;
        Mon, 30 Aug 2021 00:54:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j2so8068078pll.1;
        Mon, 30 Aug 2021 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Poj9tXQw/InOkYCTuNmrJ+F4REgw4Et+R6OyshD3QEk=;
        b=XapqsaBHtnTknPpJ2zOmMNV8PBR/8g2FtjoC4iuUuXF7EQy/b98YNlCrh2AcpdoMO8
         SHu57hIb6BL5l+O0iJiRBgZ3cNImSsKsihtPi9+0injgt3ka4fmcuaC8YpIip2gSm4Jv
         gkDS7ge7Y0QYWXXlAMGzHVaEgrCX6wVS1xZIa84JwSKi7IQpOu6cnpaewLGUh5JDoUyM
         JK5rmJy8rpkFvXPE6GyXS9oxyx0uTf5iJkIqEKarX6km0XvgBPiQdDlFtZEL04MhgT9q
         Cv+3KbBErhlDD624/CU2KphRJsCqXP+rw8kMWrUU8EpmdpaIUgFLfMvy9uFzlH4cob8L
         APSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Poj9tXQw/InOkYCTuNmrJ+F4REgw4Et+R6OyshD3QEk=;
        b=eqOVHFibR3zVX3z4Yv8At8qrnkFR7BSJR9wzO8HDI1LNCgRiYG6qYZmp7Sm+eOSIBp
         VEekB/79Nhztg8LsPY0dvdjA7Sheyf8pTMLzQ7cmTbKt7aLA2czLzBgmq4dYnqcH6sCc
         etkfZzt0m6lqmdvwsdL4qeZXSUu1zHmUF/wmu1SGbqhjG3XjPBAjLQkqLuyJwxbfaHHI
         YiPdElkfjfJQxv2O6EwYZ+XQ0bPitOacYCL0XmkmkvkVLWQA4dIOjavcGedzvM4R+Uvr
         YiQh0Y+m65o5UzNZqYlZTdcXe2qXRnLJJgJPp3mu0G+cpLBPW87qTdmrYld1kCKszlxb
         nrdw==
X-Gm-Message-State: AOAM532FDcTJ2Xlzq4LNc00x/t6alacGkh9vZnTV2CDs6igw0kLwt1g4
        gbc3F4isuAnGhYyS4dqu8TA=
X-Google-Smtp-Source: ABdhPJzXHJShnJOM3TKf0iIf0J/3lwjiJS8X6Gl9idqd7a7MyereyPCt4Her/hAVslhC4nZGj+wfXg==
X-Received: by 2002:a17:902:a407:b0:138:849b:56f6 with SMTP id p7-20020a170902a40700b00138849b56f6mr19132788plq.0.1630310060316;
        Mon, 30 Aug 2021 00:54:20 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.245])
        by smtp.gmail.com with ESMTPSA id b17sm16260839pgl.61.2021.08.30.00.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:54:20 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH V4 5/5] ext4: flush background discard kwork when retry allocation
Date:   Mon, 30 Aug 2021 15:52:46 +0800
Message-Id: <20210830075246.12516-6-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830075246.12516-1-jianchao.wan9@gmail.com>
References: <20210830075246.12516-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

The background discard kwork tries to mark blocks used and issue
discard. This can make filesystem suffer from NOSPC error, xfstest
generic/371 can fail due to it. Fix it by flushing discard kwork
in ext4_should_retry_alloc. At the same time, give up discard at
the moment.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/balloc.c  | 8 +++++++-
 fs/ext4/ext4.h    | 1 +
 fs/ext4/mballoc.c | 7 +++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 9dc6e74b265c..a0fb0c4bdc7c 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -652,8 +652,14 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 	 * possible we just missed a transaction commit that did so
 	 */
 	smp_mb();
-	if (sbi->s_mb_free_pending == 0)
+	if (sbi->s_mb_free_pending == 0) {
+		if (test_opt(sb, DISCARD)) {
+			atomic_inc(&sbi->s_retry_alloc_pending);
+			flush_work(&sbi->s_discard_work);
+			atomic_dec(&sbi->s_retry_alloc_pending);
+		}
 		return ext4_has_free_clusters(sbi, 1, 0);
+	}
 
 	/*
 	 * it's possible we've just missed a transaction commit here,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6b678b968d84..d71dcac3b97f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1538,6 +1538,7 @@ struct ext4_sb_info {
 						   after commit completed */
 	struct list_head s_discard_list;
 	struct work_struct s_discard_work;
+	atomic_t s_retry_alloc_pending;
 	struct rb_root s_mb_avg_fragment_size_root;
 	rwlock_t s_mb_rb_lock;
 	struct list_head *s_mb_largest_free_orders;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 259822fc0ae9..c0dea52a7124 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3331,9 +3331,11 @@ static void ext4_discard_work(struct work_struct *work)
 	load_grp = UINT_MAX;
 	list_for_each_entry_safe(fd, nfd, &discard_list, efd_list) {
 		/*
-		 * If filesystem is umounting or no memory, give up the discard
+		 * If filesystem is umounting or no memory or suffering
+		 * from no space, give up the discard
 		 */
-		if ((sb->s_flags & SB_ACTIVE) && !err) {
+		if ((sb->s_flags & SB_ACTIVE) && !err &&
+		    !atomic_read(&sbi->s_retry_alloc_pending)) {
 			grp = fd->efd_group;
 			if (grp != load_grp) {
 				if (load_grp != UINT_MAX)
@@ -3431,6 +3433,7 @@ int ext4_mb_init(struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
 	INIT_LIST_HEAD(&sbi->s_discard_list);
 	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
+	atomic_set(&sbi->s_retry_alloc_pending, 0);
 
 	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
 	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
-- 
2.17.1

