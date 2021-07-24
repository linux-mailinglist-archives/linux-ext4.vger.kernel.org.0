Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6165E3D4613
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jul 2021 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhGXHCi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jul 2021 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhGXHCa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jul 2021 03:02:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23720C061757;
        Sat, 24 Jul 2021 00:43:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so12193110pja.5;
        Sat, 24 Jul 2021 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8w2zmsxyIIo9zeR+Aa41bNtfSdc8VV13c+ldLYEBWmY=;
        b=Aq7SNyDCRwhUp09v4JStNsnlXQGD4WTNT1tup9jblbDTzUHR4fKpxQztD17SAIPokS
         qOmmCCJeXiVh3Keesr/y4GJLv+lxTPcw0I5dFdbuXxKT0BCjaYSOF44CjFgQb3gPUwSL
         Ub3KvD5Oislo3DvyfUO1L7a6XKwTRqVnrfeiPKpldDnzNRnFoTqcWxRV79RHTdNSVD/W
         DMwGiHrNrkYp6veQrCh3sxzou+u0rQS9yYXt0T5yuCCb6XhXI/5ZOJLVqzD/wzlKzqXp
         yc7N/TZyu6vH130SUle4pZa+66C8soV4lverp5AKq1FRuaaNqyddy/fGtqzJ492/TOJV
         /qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8w2zmsxyIIo9zeR+Aa41bNtfSdc8VV13c+ldLYEBWmY=;
        b=S6ZIke7KM2iIvPHj634OYdJ6xjhPdjREIi03agWQW5LD8W5puQJyVuhhMVsTqlPgPd
         mlMmK1K6h3FwtAnhRJ74Q+TgeB7WHPb35iYooO9rMKElq2487dqi7IUwS2YzOcgoWsJR
         SCv2Na+Edq3yvWK3CD/bK/myVmd6y9+8DErp9Z+Ggy6lh7fIfORBNLi/xDJDVlAyPRn8
         jeFlD/0Bl4FQWNvbkVwuqbk+yXRYM7c+khyapr3xnRPeGQi7imX9YTrODohpho4PJLUo
         VE4Q/QeHn8TvBm3ZPGhNjorIjGiNu3X5svC4UjOAn2UUBDORRIkqyMWSjzDx9C9aMOf1
         c0Lw==
X-Gm-Message-State: AOAM530YCLISl5is6LtpmrVIQH45K4aimaCI6KngRswrSzBv/dHKbwHo
        XILwbnYLvBsrN0zGaU2+cyXjyfJBka2alg==
X-Google-Smtp-Source: ABdhPJz/wLTBu5ITiKmRUUh0VGHjK7J6y71mXgYEOvazPdcQsXacCHa2CzqX4EgJ3I/MX+kEyn8zaw==
X-Received: by 2002:a17:90a:bd06:: with SMTP id y6mr8049415pjr.6.1627112582734;
        Sat, 24 Jul 2021 00:43:02 -0700 (PDT)
Received: from localhost.localdomain ([154.86.159.244])
        by smtp.gmail.com with ESMTPSA id v31sm33002342pgl.49.2021.07.24.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:43:02 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH V3 4/5] ext4: get discard out of jbd2 commit kthread contex
Date:   Sat, 24 Jul 2021 15:41:23 +0800
Message-Id: <20210724074124.25731-5-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210724074124.25731-1-jianchao.wan9@gmail.com>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Right now, discard is issued and waited to be completed in jbd2
commit kthread context after the logs are committed. When large
amount of files are deleted and discard is flooding, jbd2 commit
kthread can be blocked for long time. Then all of the metadata
operations can be blocked to wait the log space.

One case is the page fault path with read mm->mmap_sem held, which
wants to update the file time but has to wait for the log space.
When other threads in the task wants to do mmap, then write mmap_sem
is blocked. Finally all of the following read mmap_sem requirements
are blocked, even the ps command which need to read the /proc/pid/
-cmdline. Our monitor service which needs to read /proc/pid/cmdline
used to be blocked for 5 mins.

This patch frees the blocks back to buddy after commit and then do
discard in a async kworker context in fstrim fashion, namely,
 - mark blocks to be discarded as used if they have not been allocated
 - do discard
 - mark them free
After this, jbd2 commit kthread won't be blocked any more by discard
and we won't get NOSPC even if the discard is slow or throttled.

Link: https://marc.info/?l=linux-kernel&m=162143690731901&w=2
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/ext4.h    |   2 +
 fs/ext4/mballoc.c | 109 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..6b678b968d84 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1536,6 +1536,8 @@ struct ext4_sb_info {
 	unsigned int s_mb_free_pending;
 	struct list_head s_freed_data_list;	/* List of blocks to be freed
 						   after commit completed */
+	struct list_head s_discard_list;
+	struct work_struct s_discard_work;
 	struct rb_root s_mb_avg_fragment_size_root;
 	rwlock_t s_mb_rb_lock;
 	struct list_head *s_mb_largest_free_orders;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 34be2f07449d..a496509e61b7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -386,6 +386,7 @@
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
 static struct kmem_cache *ext4_free_data_cachep;
+static struct workqueue_struct *ext4_discard_wq;
 
 /* We create slab caches for groupinfo data structures based on the
  * superblock block size.  There will be one per mounted filesystem for
@@ -408,6 +409,10 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 			       ext4_group_t group, int cr);
 
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks);
+
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -3308,6 +3313,55 @@ static int ext4_groupinfo_create_slab(size_t size)
 	return 0;
 }
 
+static void ext4_discard_work(struct work_struct *work)
+{
+	struct ext4_sb_info *sbi = container_of(work,
+			struct ext4_sb_info, s_discard_work);
+	struct super_block *sb = sbi->s_sb;
+	struct ext4_free_data *fd, *nfd;
+	struct ext4_buddy e4b;
+	struct list_head discard_list;
+	ext4_group_t grp, load_grp;
+	int err = 0;
+
+	INIT_LIST_HEAD(&discard_list);
+	spin_lock(&sbi->s_md_lock);
+	list_splice_init(&sbi->s_discard_list, &discard_list);
+	spin_unlock(&sbi->s_md_lock);
+
+	load_grp = UINT_MAX;
+	list_for_each_entry_safe(fd, nfd, &discard_list, efd_list) {
+		/*
+		 * If filesystem is umounting or no memory, give up the discard
+		 */
+		if ((sb->s_flags & SB_ACTIVE) && !err) {
+			grp = fd->efd_group;
+			if (grp != load_grp) {
+				if (load_grp != UINT_MAX)
+					ext4_mb_unload_buddy(&e4b);
+
+				err = ext4_mb_load_buddy(sb, grp, &e4b);
+				if (err) {
+					kmem_cache_free(ext4_free_data_cachep, fd);
+					load_grp = UINT_MAX;
+					continue;
+				} else {
+					load_grp = grp;
+				}
+			}
+
+			ext4_lock_group(sb, grp);
+			ext4_try_to_trim_range(sb, &e4b, fd->efd_start_cluster,
+						fd->efd_start_cluster + fd->efd_count - 1, 1);
+			ext4_unlock_group(sb, grp);
+		}
+		kmem_cache_free(ext4_free_data_cachep, fd);
+	}
+
+	if (load_grp != UINT_MAX)
+		ext4_mb_unload_buddy(&e4b);
+}
+
 int ext4_mb_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -3376,6 +3430,8 @@ int ext4_mb_init(struct super_block *sb)
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
+	INIT_LIST_HEAD(&sbi->s_discard_list);
+	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
 
 	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
 	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
@@ -3474,6 +3530,14 @@ int ext4_mb_release(struct super_block *sb)
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
 	int count;
 
+	if (test_opt(sb, DISCARD)) {
+		/*
+		 * wait the discard work to drain all of ext4_free_data
+		 */
+		queue_work(ext4_discard_wq, &sbi->s_discard_work);
+		flush_work(&sbi->s_discard_work);
+	}
+
 	if (sbi->s_group_info) {
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
@@ -3596,7 +3660,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		put_page(e4b.bd_bitmap_page);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
-	kmem_cache_free(ext4_free_data_cachep, entry);
 	ext4_mb_unload_buddy(&e4b);
 
 	mb_debug(sb, "freed %d blocks in %d structures\n", count,
@@ -3611,10 +3674,9 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_free_data *entry, *tmp;
-	struct bio *discard_bio = NULL;
 	struct list_head freed_data_list;
 	struct list_head *cut_pos = NULL;
-	int err;
+	bool wake;
 
 	INIT_LIST_HEAD(&freed_data_list);
 
@@ -3629,30 +3691,20 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 				  cut_pos);
 	spin_unlock(&sbi->s_md_lock);
 
-	if (test_opt(sb, DISCARD)) {
-		list_for_each_entry(entry, &freed_data_list, efd_list) {
-			err = ext4_issue_discard(sb, entry->efd_group,
-						 entry->efd_start_cluster,
-						 entry->efd_count,
-						 &discard_bio);
-			if (err && err != -EOPNOTSUPP) {
-				ext4_msg(sb, KERN_WARNING, "discard request in"
-					 " group:%d block:%d count:%d failed"
-					 " with %d", entry->efd_group,
-					 entry->efd_start_cluster,
-					 entry->efd_count, err);
-			} else if (err == -EOPNOTSUPP)
-				break;
-		}
+	list_for_each_entry(entry, &freed_data_list, efd_list)
+		ext4_free_data_in_buddy(sb, entry);
 
-		if (discard_bio) {
-			submit_bio_wait(discard_bio);
-			bio_put(discard_bio);
-		}
+	if (test_opt(sb, DISCARD)) {
+		spin_lock(&sbi->s_md_lock);
+		wake = list_empty(&sbi->s_discard_list);
+		list_splice_tail(&freed_data_list, &sbi->s_discard_list);
+		spin_unlock(&sbi->s_md_lock);
+		if (wake)
+			queue_work(ext4_discard_wq, &sbi->s_discard_work);
+	} else {
+		list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
+			kmem_cache_free(ext4_free_data_cachep, entry);
 	}
-
-	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
-		ext4_free_data_in_buddy(sb, entry);
 }
 
 int __init ext4_init_mballoc(void)
@@ -3672,8 +3724,14 @@ int __init ext4_init_mballoc(void)
 	if (ext4_free_data_cachep == NULL)
 		goto out_ac_free;
 
+	ext4_discard_wq = alloc_workqueue("ext4discard", WQ_UNBOUND, 0);
+	if (!ext4_discard_wq)
+		goto out_free_data;
+
 	return 0;
 
+out_free_data:
+	kmem_cache_destroy(ext4_free_data_cachep);
 out_ac_free:
 	kmem_cache_destroy(ext4_ac_cachep);
 out_pa_free:
@@ -3693,6 +3751,7 @@ void ext4_exit_mballoc(void)
 	kmem_cache_destroy(ext4_ac_cachep);
 	kmem_cache_destroy(ext4_free_data_cachep);
 	ext4_groupinfo_destroy_slabs();
+	destroy_workqueue(ext4_discard_wq);
 }
 
 
-- 
2.17.1

