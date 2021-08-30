Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C393FB222
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhH3HzO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhH3HzL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 03:55:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670CC06175F;
        Mon, 30 Aug 2021 00:54:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so13282022pjb.0;
        Mon, 30 Aug 2021 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qU/SKKt4HVb4peWmTc3cXYsUa1fPhibZRh/04xCAyHI=;
        b=loS6NHat4Hl+K/TiQR1PPPnNvY4jMJT9h1JxOy7P72oK+jEVFbFFufldoTITEAUYvQ
         +elNnnnQO8pXSMoVgBt+bXRYx66FZtsSbnFKVnMeyL/B0XbHPkQqUFQSzKE/kHUHSZ0O
         p+fgubwJfmfwiJEVhGtgSmaQBPrakoATc99OODjx/hiOpeR2H/Fe9rCwfK8n8zCE9C3X
         01b7xa/NXvgnE41QXuIYaom+tDEwaCE3W9y+heOv0mFy8Q7d6cRFiPrLH0FHe9k3QvBe
         lBYT57vhObqlXQWQY2+KPcENYbVGdC5XXdpq5j5woUOa++oVcnJZjokhbZ9esO2GbQbQ
         oPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qU/SKKt4HVb4peWmTc3cXYsUa1fPhibZRh/04xCAyHI=;
        b=gaDMVo+YWdWh7efneHHnm28mxdCu4fGrNhLlmPp/rGKk8PlMnJfnDJ1Sykx9+hQ+Dp
         dBF8MXJholIRipEU/KZKa3lT/9g8hvGdh20LfEKeM5g/f1g0oDuwCx8oO4AJEgUpOgGB
         WjENtYpt8CtHcKJDX/2wpKod6cRvg0p+wMPNiqpPG5QeDrMnuOrvCn6nHyL7FYkfXBS2
         LKOsd9+qG8DLCvUQ6vGCLjshMWLhbaHLaAdaYo2GGZWFamabi003wl2kgWvyJpKdYxbF
         T/vP4zAXxYdqDQ2FJ6S17R89s3QN2UIf2Cwch2s29z/jGTry/RNbiVVpVctwXopPY92Y
         GDig==
X-Gm-Message-State: AOAM531foj46irlpRtQCUH/F0oEaysN7THMUxXw+hRvKltiJr1znVHlL
        /xZ3xj3Ps1QOuH/3pM4Juhk=
X-Google-Smtp-Source: ABdhPJw74q+90KF0+ig0nCj12Ft8lMc/L2YF+XGOP9KpWln/6zGxa1whnWm05FmtabvAUrdYkuvLgQ==
X-Received: by 2002:a17:90a:ba03:: with SMTP id s3mr16922653pjr.168.1630310057723;
        Mon, 30 Aug 2021 00:54:17 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.245])
        by smtp.gmail.com with ESMTPSA id b17sm16260839pgl.61.2021.08.30.00.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:54:17 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH V4 4/5] ext4: get discard out of jbd2 commit kthread contex
Date:   Mon, 30 Aug 2021 15:52:45 +0800
Message-Id: <20210830075246.12516-5-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830075246.12516-1-jianchao.wan9@gmail.com>
References: <20210830075246.12516-1-jianchao.wan9@gmail.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/ext4.h    |   2 +
 fs/ext4/mballoc.c | 101 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 78 insertions(+), 25 deletions(-)

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
index ef2aa2b1a939..259822fc0ae9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -408,6 +408,10 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 			       ext4_group_t group, int cr);
 
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks);
+
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -3308,6 +3312,55 @@ static int ext4_groupinfo_create_slab(size_t size)
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
@@ -3376,6 +3429,8 @@ int ext4_mb_init(struct super_block *sb)
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
+	INIT_LIST_HEAD(&sbi->s_discard_list);
+	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
 
 	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
 	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
@@ -3474,6 +3529,14 @@ int ext4_mb_release(struct super_block *sb)
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
 	int count;
 
+	if (test_opt(sb, DISCARD)) {
+		/*
+		 * wait the discard work to drain all of ext4_free_data
+		 */
+		flush_work(&sbi->s_discard_work);
+		WARN_ON_ONCE(!list_empty(&sbi->s_discard_list));
+	}
+
 	if (sbi->s_group_info) {
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
@@ -3596,7 +3659,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		put_page(e4b.bd_bitmap_page);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
-	kmem_cache_free(ext4_free_data_cachep, entry);
 	ext4_mb_unload_buddy(&e4b);
 
 	mb_debug(sb, "freed %d blocks in %d structures\n", count,
@@ -3611,10 +3673,9 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_free_data *entry, *tmp;
-	struct bio *discard_bio = NULL;
 	struct list_head freed_data_list;
 	struct list_head *cut_pos = NULL;
-	int err;
+	bool wake;
 
 	INIT_LIST_HEAD(&freed_data_list);
 
@@ -3629,30 +3690,20 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
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
+			queue_work(system_unbound_wq, &sbi->s_discard_work);
+	} else {
+		list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
+			kmem_cache_free(ext4_free_data_cachep, entry);
 	}
-
-	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
-		ext4_free_data_in_buddy(sb, entry);
 }
 
 int __init ext4_init_mballoc(void)
-- 
2.17.1

