Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736D83FB21E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhH3HzH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhH3HzG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 03:55:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE4AC061575;
        Mon, 30 Aug 2021 00:54:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 17so12619352pgp.4;
        Mon, 30 Aug 2021 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e7QzE5a7xIvgafPHNKctBgNQATX7OF0j0qgT1voJcZQ=;
        b=PP18Nk+KsT8dkBurJaywE4WblyDrmInEEz5221mHQeZRICF47nud3RRLWTnXi8tHOn
         y+QBuwtGkmQKXut5p/A1qlMsSJP0aWToZDUEj7P7az7zoxAitCqlbh6yWv/uffdJB0ow
         FeNyJwRc4TEk32l/7xX2arXDnjVOD9RaOInYBQ2CLj/dvkWiWrJKI2653e7uWKxmfPB0
         GwhfCqX4+t91uigPdBXOLKzjckHAIHyLSfwnHo0XOh5F50/gYRm5e4PW/3ONfON7hCN9
         skdoeOCKcxr8T803T74OWIZf9HF/LdwiDMPw4OIZAF44RWoELuVR73XiRDugqgQaxYwc
         QdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e7QzE5a7xIvgafPHNKctBgNQATX7OF0j0qgT1voJcZQ=;
        b=nbBiUHM/SIc9qR95YgoJGvY3evgcC5tDqcNkkzLFXkqvLz40BYY4EJs93B29xZvaNu
         oBDxg2sb35pOzpX0hn8YHkldYyOslVk9BGt+rppjuXKU95AteOoIqcWeeMbvCA4QkyHL
         sYHaHBXPqK1sDlB9sOx0BwkoAsLDa0S79fMmHArB7UH5cyFBKOosUHkKLm4h9PTidibI
         GQ6PWeETSBQfZ38wmGNYVp8sDxu9zJrhI0bG5tVtOr3bR0a8PsBX1Ib8uQ7VoMkFzQjy
         qKaOUvmWwmP9nKRtpPCD2BJBIOaNW7NnkJtCx92Z9Mz3IZ0cprUOBEX8BSHN2yx8u2cR
         8bGA==
X-Gm-Message-State: AOAM532Uc01HOjhZmA6SQ7QE7b7n/YDRacgZAR/X/ONQ+I1NCq+aTZ6f
        dVd97GCO/qQEa7PxQU4RcUY8FDIkenFqqINY
X-Google-Smtp-Source: ABdhPJwP6zUoE07I2StDaX8Ti01Vtl5MLtGcF0Hn+2LMZw9j1uYkTL27+U7zp8j82iC36CWFJWu/7Q==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr20648634pgq.206.1630310052455;
        Mon, 30 Aug 2021 00:54:12 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.245])
        by smtp.gmail.com with ESMTPSA id b17sm16260839pgl.61.2021.08.30.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:54:12 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH V4 2/5] ext4: add new helper interface ext4_try_to_trim_range()
Date:   Mon, 30 Aug 2021 15:52:43 +0800
Message-Id: <20210830075246.12516-3-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830075246.12516-1-jianchao.wan9@gmail.com>
References: <20210830075246.12516-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

There is no functional change in this patch but just split the
codes, which serachs free block and does trim, into a new function
ext4_try_to_trim_range. This is preparing for the following async
backgroup discard.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 09fb0223afaa..e47089cc6c07 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6218,6 +6218,54 @@ __acquires(bitlock)
 	return ret;
 }
 
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+{
+	ext4_grpblk_t next, count, free_count;
+	void *bitmap;
+	int ret = 0;
+
+	bitmap = e4b->bd_bitmap;
+	start = (e4b->bd_info->bb_first_free > start) ?
+		e4b->bd_info->bb_first_free : start;
+	count = 0;
+	free_count = 0;
+
+	while (start <= max) {
+		start = mb_find_next_zero_bit(bitmap, max + 1, start);
+		if (start > max)
+			break;
+		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		if ((next - start) >= minblocks) {
+			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			if (ret && ret != -EOPNOTSUPP)
+				break;
+			ret = 0;
+			count += next - start;
+		}
+		free_count += next - start;
+		start = next + 1;
+
+		if (fatal_signal_pending(current)) {
+			count = -ERESTARTSYS;
+			break;
+		}
+
+		if (need_resched()) {
+			ext4_unlock_group(sb, e4b->bd_group);
+			cond_resched();
+			ext4_lock_group(sb, e4b->bd_group);
+		}
+
+		if ((e4b->bd_info->bb_free - free_count) < minblocks)
+			break;
+	}
+
+	return count;
+}
+
 /**
  * ext4_trim_all_free -- function to trim all free space in alloc. group
  * @sb:			super block for file system
@@ -6241,10 +6289,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -6254,57 +6300,23 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
-	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
-		goto out;
-
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
 
-	while (start <= max) {
-		start = mb_find_next_zero_bit(bitmap, max + 1, start);
-		if (start > max)
-			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
-
-		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, &e4b);
-			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
-			count += next - start;
-		}
-		free_count += next - start;
-		start = next + 1;
-
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
-
-		if (need_resched()) {
-			ext4_unlock_group(sb, group);
-			cond_resched();
-			ext4_lock_group(sb, group);
-		}
-
-		if ((e4b.bd_info->bb_free - free_count) < minblocks)
-			break;
+	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
+		if (ret >= 0)
+			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
+	} else {
+		ret = 0;
 	}
 
-	if (!ret) {
-		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
-out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
-		count, group);
+		ret, group);
 
 	return ret;
 }
-- 
2.17.1

