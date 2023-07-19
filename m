Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9547591C0
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jul 2023 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSJhI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jul 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGSJhI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jul 2023 05:37:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF94E75
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jul 2023 02:36:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55acbe0c7e4so1022311a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jul 2023 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689759401; x=1690364201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44DhDFoMRI5iIzGErukjcxbOS4AaQXo9GD0r4eD2+Oo=;
        b=PqFDpWIjP4kr/10tgjdxDBq1M1loHBvANmx4Oslnsw8dLqONwKm5EZWRujJvfToqG6
         G8fJVjodW2Rv2LaXXDW1sg5aQ1Z/tMfOhXaOyp1Dke7mBajS6ULJSd02O9SQSZNlJxJ6
         NucpzR/F/sCX+FzFOCtUmTf//NPYTJsoh+mMuWKBoV5EdDrOJj0cngoapguzZhNzQuLI
         5F15HUl9VaO76my+vrx3vDgGO58AjbkqCri0VR+QZukwSpqOYtUa2XdQjEmRlaCDbR4B
         WTe+cVGadBA/8zNpfSid4dmzl8KuRhH5njJj0WGBOOzrIUKm3v+PqwIBBYH+3yza4Cs1
         1sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759401; x=1690364201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44DhDFoMRI5iIzGErukjcxbOS4AaQXo9GD0r4eD2+Oo=;
        b=RlltRkS9fDH7HG7QfJxYyvwoMZ51HErIlE9vWY6OhePksrs0sIYPgZXTj0tuTzCHn3
         PK8bjO0MSdqIZj/JTDlFOI/ofGpuTlwl3+E4Sn++pU/6B9jwkVvGWvJfK7NY7WxO87oF
         l4/Mh40+BekOG23FCAFNHZsLoZqtIdgMRgJ0geKkmkM9eBg/fPB70BXAACzELuOjKIQ8
         Gt0jluc+e8EMGv0borBrikSYHNDpZ5Lc+p1mBLtXiimriXllsduzaeEYL5Zor8+jLqSu
         jHtHkwJR3L4bQfa1zmqm4B8mwgwqjjMlJo9hVzf5gZw/Wg8zcd5qbGfVv2R/xxR3MHtB
         euaw==
X-Gm-Message-State: ABy/qLaowq2uQIH2K9zJ11vHs+OhIxRKA+tJ+g79LmUcv9CFhPY/gvWa
        G/n5zgdV9rYb0hpGdMYXNBr3Rg==
X-Google-Smtp-Source: APBJJlFJ4IyLFCu3aJew5CLYirQuySuVBK6wK0ZpPNmV/TCIWDNZvTrrx9PnX5LbPPkRHTgz1Aas3Q==
X-Received: by 2002:a17:90a:cc0d:b0:25c:1ad3:a4a1 with SMTP id b13-20020a17090acc0d00b0025c1ad3a4a1mr12353072pju.1.1689759401554;
        Wed, 19 Jul 2023 02:36:41 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a0e4200b0025bdc3454c6sm901735pja.8.2023.07.19.02.36.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jul 2023 02:36:41 -0700 (PDT)
From:   Fengnan Chang <changfengnan@bytedance.com>
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@bytedance.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2] ext4: improve discard efficiency
Date:   Wed, 19 Jul 2023 17:36:33 +0800
Message-Id: <20230719093633.34141-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
In my test, the time of fstrim fs with multi big sparse file
reduce from 6.7s to 1.3s.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202307171455.ee68ef8b-oliver.sang@intel.com
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/ext4/mballoc.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..84685b746297 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * be called with under the group lock.
  */
 static int ext4_trim_extent(struct super_block *sb,
-		int start, int count, struct ext4_buddy *e4b)
+		int start, int count, struct ext4_buddy *e4b,
+		struct bio **biop, struct ext4_free_data **entryp)
 __releases(bitlock)
 __acquires(bitlock)
 {
@@ -6812,9 +6813,16 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
+	ret = ext4_issue_discard(sb, group, start, count, biop);
+	if (!ret) {
+		struct ext4_free_data *entry = kmem_cache_alloc(ext4_free_data_cachep,
+				GFP_NOFS|__GFP_NOFAIL);
+		entry->efd_start_cluster = start;
+		entry->efd_count = count;
+		*entryp  = entry;
+	}
+
 	ext4_lock_group(sb, group);
-	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
 }
 
@@ -6826,6 +6834,12 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
 	void *bitmap;
+	struct ext4_free_data *entry = NULL, *fd, *nfd;
+	struct list_head discard_data_list;
+	struct bio *discard_bio = NULL;
+	struct blk_plug plug;
+
+	INIT_LIST_HEAD(&discard_data_list);
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
@@ -6833,6 +6847,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 	count = 0;
 	free_count = 0;
 
+	blk_start_plug(&plug);
 	while (start <= max) {
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
@@ -6840,10 +6855,13 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, e4b,
+							&discard_bio, &entry);
 
-			if (ret && ret != -EOPNOTSUPP)
+			if (ret < 0)
 				break;
+
+			list_add_tail(&entry->efd_list, &discard_data_list);
 			count += next - start;
 		}
 		free_count += next - start;
@@ -6863,6 +6881,18 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		if ((e4b->bd_info->bb_free - free_count) < minblocks)
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
+	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
+		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
+		kmem_cache_free(ext4_free_data_cachep, fd);
+	}
 
 	return count;
 }
-- 
2.37.1 (Apple Git-137.1)

