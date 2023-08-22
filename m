Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088E778379A
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Aug 2023 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjHVBv4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Aug 2023 21:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjHVBvy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Aug 2023 21:51:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB26180
        for <linux-ext4@vger.kernel.org>; Mon, 21 Aug 2023 18:51:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf11a7cf9fso5830315ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 21 Aug 2023 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692669104; x=1693273904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dq8+16J+7kBShZHlF/4m8nKebVlvwcTg5Lf01E/TI9U=;
        b=WbXqmR7oiY/c3gvlwqSYkrXLRfG4jX9/ekDjOe8MaATcHDyPUUGOcYq8Ae8rnUYMO4
         fvlfnIfVixtTl5ttxi7T1rM3QXayywJWx0/TbwCNk8NMy0sNCc97E+VDhfNNZlscXG6j
         oNBc4bQ0NxZjAEmEj2t7e0y0LW9flIqvPmm6yivnOGsFSHRFPzxIdbHJUOXeiIQL+yZz
         xlPZwzP8BnVyaOCgAfEXrs/3jrMUNLKMZ8209a/qen6+dx6q2htLstVPaqwIqjA9c7zj
         cQ6fR4R2Q9KVZno9kxlKzRHe8m+JXTZcxvEhWuueznjPXTIrlxJiTmcRmx5rBZprUkaU
         Smfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669104; x=1693273904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dq8+16J+7kBShZHlF/4m8nKebVlvwcTg5Lf01E/TI9U=;
        b=hOtihZEq9VBAf458/1O4VzzGIzo4aAC63KXRH3GzEZ+0QvH4t2yNNf6RinMYWhS6tH
         aLJyMWfOonSzkfNrLRUmtGNB6FjZ21eX2g0SgKKy9zsN47uFmJDQaxFjiD/46Zxu9Msm
         Gu7Wei3F4lUgKN9cUpCk5swy6KdZLDKcC2/IE3u1Ag7YsMeFoupNXdPm4g8DzYZAVieD
         XuxLc1UDR8MbNSs9FRsKWWUzmg2N5NRUa/c73IhZK1iPP7t4llNLO/6Tmdl+LmzGihlY
         Faje/yQ6WasGW73RqzqhFAur1/ynHbR2HQmxmvqrzVM3UumiL7jtEVSKz/Dkoypz3nay
         lVuA==
X-Gm-Message-State: AOJu0YwGkNBWrOq+aYCDL7cHZoqSUma48w6JBbiZXgJ9WWZOLXdr1b0j
        1axs83q613GxhtBPXbcVacBMLw==
X-Google-Smtp-Source: AGHT+IGj7NpAYXLu16OQV4GD3lzW4YVYPXHiygcGbgHwTD9ERmMsAO0HagNyTKSTCGpUN65cI/HrkQ==
X-Received: by 2002:a05:6a21:6da5:b0:13d:d5bd:758f with SMTP id wl37-20020a056a216da500b0013dd5bd758fmr11385975pzb.6.1692669104378;
        Mon, 21 Aug 2023 18:51:44 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0068892c40253sm6694943pfn.216.2023.08.21.18.51.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Aug 2023 18:51:44 -0700 (PDT)
From:   Fengnan Chang <changfengnan@bytedance.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v4] ext4: improve trim efficiency
Date:   Tue, 22 Aug 2023 09:51:35 +0800
Message-Id: <20230822015135.50579-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In commit a015434480dc("ext4: send parallel discards on commit
completions"), issue all discard commands in parallel make all
bios could merged into one request, so lowlevel drive can issue
multi segments in one time which is more efficiency, but commit
55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
seems broke this way, let's fix it.
In my test:
1. create 10 normal files, each file size is 10G.
2. deallocate file, punch a 16k holes every 32k.
3. trim all fs.

the time of fstrim fs reduce from 6.7s to 1.3s.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/ext4/mballoc.c | 95 +++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e4c667812a9..4fe832ff0e4b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6874,70 +6874,61 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	return err;
 }
 
-/**
- * ext4_trim_extent -- function to TRIM one single free extent in the group
- * @sb:		super block for the file system
- * @start:	starting block of the free extent in the alloc. group
- * @count:	number of blocks to TRIM
- * @e4b:	ext4 buddy for the group
- *
- * Trim "count" blocks starting at "start" in the "group". To assure that no
- * one will allocate those blocks, mark it as used in buddy bitmap. This must
- * be called with under the group lock.
- */
-static int ext4_trim_extent(struct super_block *sb,
-		int start, int count, struct ext4_buddy *e4b)
-__releases(bitlock)
-__acquires(bitlock)
-{
-	struct ext4_free_extent ex;
-	ext4_group_t group = e4b->bd_group;
-	int ret = 0;
-
-	trace_ext4_trim_extent(sb, group, start, count);
-
-	assert_spin_locked(ext4_group_lock_ptr(sb, group));
-
-	ex.fe_start = start;
-	ex.fe_group = group;
-	ex.fe_len = count;
-
-	/*
-	 * Mark blocks used, so no one can reuse them while
-	 * being trimmed.
-	 */
-	mb_mark_used(e4b, &ex);
-	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
-	ext4_lock_group(sb, group);
-	mb_free_blocks(NULL, e4b, start, ex.fe_len);
-	return ret;
-}
-
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
 __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, bak;
 	void *bitmap;
+	struct ext4_free_data *entry = NULL, *fd, *nfd;
+	struct list_head discard_data_list;
+	struct bio *discard_bio = NULL;
+	struct blk_plug plug;
+	ext4_group_t group = e4b->bd_group;
+	struct ext4_free_extent ex;
+	bool noalloc = false;
+	int ret = 0;
+
+	INIT_LIST_HEAD(&discard_data_list);
 
 	bitmap = e4b->bd_bitmap;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
 
+	blk_start_plug(&plug);
 	while (start <= max) {
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
+		bak = start;
 		next = mb_find_next_bit(bitmap, max + 1, start);
+		/* when only one segment, there is no need to alloc entry */
+		noalloc = (free_count == 0) && (next >= max);
 
 		if ((next - start) >= minblocks) {
-			int ret = ext4_trim_extent(sb, start, next - start, e4b);
-
-			if (ret && ret != -EOPNOTSUPP)
+			trace_ext4_trim_extent(sb, group, start, next - start);
+			ex.fe_start = start;
+			ex.fe_group = group;
+			ex.fe_len = next - start;
+			/*
+			 * Mark blocks used, so no one can reuse them while
+			 * being trimmed.
+			 */
+			mb_mark_used(e4b, &ex);
+			ext4_unlock_group(sb, group);
+			ret = ext4_issue_discard(sb, group, start, next - start, &discard_bio);
+			if (!noalloc) {
+				entry = kmem_cache_alloc(ext4_free_data_cachep,
+							GFP_NOFS|__GFP_NOFAIL);
+				entry->efd_start_cluster = start;
+				entry->efd_count = next - start;
+				list_add_tail(&entry->efd_list, &discard_data_list);
+			}
+			ext4_lock_group(sb, group);
+			if (ret < 0)
 				break;
 			count += next - start;
 		}
@@ -6959,6 +6950,22 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			break;
 	}
 
+	if (discard_bio) {
+		ext4_unlock_group(sb, e4b->bd_group);
+		submit_bio_wait(discard_bio);
+		bio_put(discard_bio);
+		ext4_lock_group(sb, e4b->bd_group);
+	}
+	blk_finish_plug(&plug);
+
+	if (noalloc)
+		mb_free_blocks(NULL, e4b, bak, free_count);
+
+	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
+		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
+		kmem_cache_free(ext4_free_data_cachep, fd);
+	}
+
 	return count;
 }
 
-- 
2.20.1

