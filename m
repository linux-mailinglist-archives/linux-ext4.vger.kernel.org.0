Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14F39129E
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhEZIp1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhEZIp1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:45:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F09C061574;
        Wed, 26 May 2021 01:43:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso9048pjb.5;
        Wed, 26 May 2021 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPD75SrJkwfUqt1p4FKKu9RQG2y83AGNxduxxEZqyhE=;
        b=k5yj/B0j3yMScGOmCfDBZ7ExlQI5L97BXmR0OXeWAJ4UBKJpZkA6bvboAVgjQCbKVv
         j2NqvQ8sAyVf/aV6Ow1/z7tPAQOh2hbdfDXipVsJImdVkclaB3tJ3QiQy6AQSeS+yzJO
         IHMTYV2YaMy70pr4ZtP549JI6EyM5vRChShACKBRYK3uwRvTJuRNnUl1sxLHCHtsGBPI
         jIecaoQlHmJkB+/VO/VhSaBaYSoT5fw2lrcbVDLjGQ4ktf2jZFE2IGVQkfCVX3Ek3Mql
         L5X+FcJiDphD90m31Wtqf0K8A2+4oOdviiFEkn9CRXRVBNgDueU8dT7M31I7a2BoYvIT
         /tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPD75SrJkwfUqt1p4FKKu9RQG2y83AGNxduxxEZqyhE=;
        b=Qat4HyLi+LrC+XD2FuxvJARfN3/nvmqELUA1w7CZlgKXOJGFiClzejsfrsW32+u0MZ
         Lh76JFs+gcHFFHA+4rW3yrjyHqDtJxZL1e1L81nsU1hjnFjZfLeWpkBXH0VPAVFKtMgs
         FZ6Aqmnxr4Ue4M8YBCu72SbaDJ/VjeCTSqNBIaPhaYxlpNl/dgwvqKlAo3UEveuw7qW0
         VVnea/7jbC0O1jkNpkiHXXXKhT3/ui7e0L+Vc7xrcoiDyUxwdxNQnw4/Tcb+Uvk2d1XK
         6TlsZQ7zBHcXqluJMzUubSMdwQgvNkgM5QAA/xTd6ziN7j4XPeTnXoRmIye35XjE+jTb
         tzYA==
X-Gm-Message-State: AOAM531e/p4PA+Y1SB7tpLuIfcLzcuapNO+9PwUIcZQ7lLA3NN7Bwbxy
        nBfZ1MwPQMpOImTzYqznffY=
X-Google-Smtp-Source: ABdhPJwWklsHulOAnyaOHzkQ8biR+7iB12oOXT3jlWbtZ3+vYXqOHyigM0n7yMUBgBeh2SCLCjiWFg==
X-Received: by 2002:a17:90a:784e:: with SMTP id y14mr34167296pjl.29.1622018635109;
        Wed, 26 May 2021 01:43:55 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id v15sm15058324pfm.187.2021.05.26.01.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:43:54 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 6/7] ext4: use bb_free_root to get the free data entry
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
 <0b7915bc-193a-137b-4e52-8aaef8d6fef3@gmail.com>
Message-ID: <4df93910-d942-2410-f7cd-cc28f7a00a86@gmail.com>
Date:   Wed, 26 May 2021 16:43:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0b7915bc-193a-137b-4e52-8aaef8d6fef3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is also preparing for following async background discard.
In this patch, the s_freed_data_list is removed and we iterate
all of the group's free_data_root rb tree to get the entry.
After this, we needn't operate it when insert and merge free
data entry any more.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/balloc.c  |   2 +-
 fs/ext4/ext4.h    |   4 +--
 fs/ext4/mballoc.c | 104 +++++++++++++++++++++++++-----------------------------
 3 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 74a5172..8053a5f 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -652,7 +652,7 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 	 * possible we just missed a transaction commit that did so
 	 */
 	smp_mb();
-	if (sbi->s_mb_free_pending == 0)
+	if (!atomic_read(&sbi->s_mb_free_pending))
 		return ext4_has_free_clusters(sbi, 1, 0);
 
 	/*
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 826a56e3..5c5c8e4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1525,9 +1525,7 @@ struct ext4_sb_info {
 	unsigned short *s_mb_offsets;
 	unsigned int *s_mb_maxs;
 	unsigned int s_group_info_size;
-	unsigned int s_mb_free_pending;
-	struct list_head s_freed_data_list;	/* List of blocks to be freed
-						   after commit completed */
+	atomic_t s_mb_free_pending;
 
 	/* tunables */
 	unsigned long s_stripe;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c2bf40a..15715e7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -354,8 +354,7 @@ static inline struct ext4_free_data *efd_entry(struct rb_node *n)
 {
 	return rb_entry_safe(n, struct ext4_free_data, efd_node);
 }
-static int ext4_insert_free_data(struct ext4_sb_info *sbi,
-		struct rb_root *root, struct ext4_free_data *nfd);
+static int ext4_insert_free_data(struct rb_root *root, struct ext4_free_data *nfd);
 
 /*
  * The algorithm using this percpu seq counter goes below:
@@ -2857,8 +2856,7 @@ int ext4_mb_init(struct super_block *sb)
 
 	spin_lock_init(&sbi->s_md_lock);
 	spin_lock_init(&sbi->s_bal_lock);
-	sbi->s_mb_free_pending = 0;
-	INIT_LIST_HEAD(&sbi->s_freed_data_list);
+	atomic_set(&sbi->s_mb_free_pending, 0);
 
 	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
 	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
@@ -3040,9 +3038,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	/* we expect to find existing buddy because it's pinned */
 	BUG_ON(err != 0);
 
-	spin_lock(&EXT4_SB(sb)->s_md_lock);
-	EXT4_SB(sb)->s_mb_free_pending -= entry->efd_count;
-	spin_unlock(&EXT4_SB(sb)->s_md_lock);
+	atomic_sub(entry->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
 
 	db = e4b.bd_info;
 	/* there are blocks to put in buddy to make them really free */
@@ -3084,37 +3080,41 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_free_data *entry, *tmp;
+	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	struct ext4_free_data *fd, *nfd;
+	struct ext4_group_info *grp;
 	struct bio *discard_bio = NULL;
 	struct list_head freed_data_list;
-	struct list_head *cut_pos = NULL;
-	int err;
+	int err, i;
 
-	INIT_LIST_HEAD(&freed_data_list);
+	if (!atomic_read(&sbi->s_mb_free_pending))
+		return;
 
-	spin_lock(&sbi->s_md_lock);
-	list_for_each_entry(entry, &sbi->s_freed_data_list, efd_list) {
-		if (entry->efd_tid != commit_tid)
-			break;
-		cut_pos = &entry->efd_list;
+	INIT_LIST_HEAD(&freed_data_list);
+	for (i = 0; i < ngroups; i++) {
+		grp = ext4_get_group_info(sb, i);
+		ext4_lock_group(sb, i);
+		rbtree_postorder_for_each_entry_safe(fd, nfd,
+				&grp->bb_free_root, efd_node) {
+			if (fd->efd_tid != commit_tid)
+				continue;
+			INIT_LIST_HEAD(&fd->efd_list);
+			list_add_tail(&fd->efd_list, &freed_data_list);
+		}
+		ext4_unlock_group(sb, i);
 	}
-	if (cut_pos)
-		list_cut_position(&freed_data_list, &sbi->s_freed_data_list,
-				  cut_pos);
-	spin_unlock(&sbi->s_md_lock);
 
 	if (test_opt(sb, DISCARD)) {
-		list_for_each_entry(entry, &freed_data_list, efd_list) {
-			err = ext4_issue_discard(sb, entry->efd_group,
-						 entry->efd_start_cluster,
-						 entry->efd_count,
+		list_for_each_entry(fd, &freed_data_list, efd_list) {
+			err = ext4_issue_discard(sb, fd->efd_group,
+						 fd->efd_start_cluster,
+						 fd->efd_count,
 						 &discard_bio);
 			if (err && err != -EOPNOTSUPP) {
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%d block:%d count:%d failed"
-					 " with %d", entry->efd_group,
-					 entry->efd_start_cluster,
-					 entry->efd_count, err);
+					 " with %d", fd->efd_group,
+					 fd->efd_start_cluster, fd->efd_count, err);
 			} else if (err == -EOPNOTSUPP)
 				break;
 		}
@@ -3125,8 +3125,8 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 		}
 	}
 
-	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
-		ext4_free_data_in_buddy(sb, entry);
+	list_for_each_entry_safe(fd, nfd, &freed_data_list, efd_list)
+		ext4_free_data_in_buddy(sb, fd);
 }
 
 int __init ext4_init_mballoc(void)
@@ -5051,32 +5051,27 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
  * are contiguous, AND the extents were freed by the same transaction,
  * AND the blocks are associated with the same group.
  */
-static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
-					struct ext4_free_data *entry,
-					struct ext4_free_data *new_entry,
-					struct rb_root *entry_rb_root)
+static void ext4_try_merge_freed_extent(struct rb_root *root,
+	struct ext4_free_data *fd, struct ext4_free_data *nfd)
 {
-	if ((entry->efd_tid != new_entry->efd_tid) ||
-	    (entry->efd_group != new_entry->efd_group))
+	if ((fd->efd_tid != nfd->efd_tid) ||
+	    (fd->efd_group != nfd->efd_group))
 		return;
-	if (entry->efd_start_cluster + entry->efd_count ==
-	    new_entry->efd_start_cluster) {
-		new_entry->efd_start_cluster = entry->efd_start_cluster;
-		new_entry->efd_count += entry->efd_count;
-	} else if (new_entry->efd_start_cluster + new_entry->efd_count ==
-		   entry->efd_start_cluster) {
-		new_entry->efd_count += entry->efd_count;
+	if (fd->efd_start_cluster + fd->efd_count ==
+	    nfd->efd_start_cluster) {
+		nfd->efd_start_cluster = fd->efd_start_cluster;
+		nfd->efd_count += fd->efd_count;
+	} else if (nfd->efd_start_cluster + nfd->efd_count ==
+		   fd->efd_start_cluster) {
+		nfd->efd_count += fd->efd_count;
 	} else
 		return;
-	spin_lock(&sbi->s_md_lock);
-	list_del(&entry->efd_list);
-	spin_unlock(&sbi->s_md_lock);
-	rb_erase(&entry->efd_node, entry_rb_root);
-	kmem_cache_free(ext4_free_data_cachep, entry);
+	rb_erase(&fd->efd_node, root);
+	kmem_cache_free(ext4_free_data_cachep, fd);
 }
 
-static int ext4_insert_free_data(struct ext4_sb_info *sbi,
-		struct rb_root *root, struct ext4_free_data *nfd)
+static int ext4_insert_free_data(struct rb_root *root,
+		struct ext4_free_data *nfd)
 {
 	struct rb_node **n = &root->rb_node;
 	struct rb_node *p = NULL;
@@ -5100,11 +5095,11 @@ static int ext4_insert_free_data(struct ext4_sb_info *sbi,
 	/* Now try to see the extent can be merged to left and right */
 	fd = efd_entry(rb_prev(&nfd->efd_node));
 	if (fd)
-		ext4_try_merge_freed_extent(sbi, fd, nfd, root);
+		ext4_try_merge_freed_extent(root, fd, nfd);
 
 	fd = efd_entry(rb_next(&nfd->efd_node));
 	if (fd)
-		ext4_try_merge_freed_extent(sbi, fd, nfd, root);
+		ext4_try_merge_freed_extent(root, fd, nfd);
 
 	return 0;
 }
@@ -5122,7 +5117,7 @@ static int ext4_insert_free_data(struct ext4_sb_info *sbi,
 	BUG_ON(e4b->bd_bitmap_page == NULL);
 	BUG_ON(e4b->bd_buddy_page == NULL);
 
-	if (ext4_insert_free_data(sbi, &db->bb_free_root, nfd)) {
+	if (ext4_insert_free_data(&db->bb_free_root, nfd)) {
 		ext4_grp_locked_error(sb, e4b->bd_group, 0,
 				ext4_group_first_block_no(sb, e4b->bd_group) +
 				EXT4_C2B(sbi, nfd->efd_start_cluster),
@@ -5140,10 +5135,7 @@ static int ext4_insert_free_data(struct ext4_sb_info *sbi,
 		get_page(e4b->bd_bitmap_page);
 	}
 
-	spin_lock(&sbi->s_md_lock);
-	list_add_tail(&nfd->efd_list, &sbi->s_freed_data_list);
-	sbi->s_mb_free_pending += nfd->efd_count;
-	spin_unlock(&sbi->s_md_lock);
+	atomic_add(nfd->efd_count, &sbi->s_mb_free_pending);
 	return 0;
 }
 
-- 
1.8.3.1
