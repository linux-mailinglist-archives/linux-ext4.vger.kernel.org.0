Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458AC3912A0
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhEZIpm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhEZIpl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 04:45:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5BC061574;
        Wed, 26 May 2021 01:44:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l70so378647pga.1;
        Wed, 26 May 2021 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DwD1vsDnhGHFvon4AA8L3Y8755uSa8fPYo7gWryDG1E=;
        b=ISLCACruhT1Bfo3sauqeoqOdn9yt3YeULCXL0B6xXPcj5WE8qQqOxVY3qaZCINP3FZ
         TRNKeMpvsSmi5iNsGnq0tfVIeuhRdfPSMjEwMN/TnzC5fIzLr/acqLuaWBtapno58oGF
         ChKmfFUi1Qa9uikN8OgDS12d50+wFzLGzf/eZz/f1scRdWmNnYX+ctcpOvJfooFljbKd
         9u7VYfEKw5JuGW8O0L5rRxkxvMuE3QNM/nPA1FnaltTroxR0o/W9T8P3FwIveAJg02rR
         3iYHcl0DvsXEttPsEPMp3ZoEn++MJ2m3DIRlfOQOsb05di0uVmjPuUrhQ6GPcoXCTbtr
         TZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwD1vsDnhGHFvon4AA8L3Y8755uSa8fPYo7gWryDG1E=;
        b=e8XLFlQ0rCZM97Sy/aG5VhfdkxZ9Jrl9JUekKusAd6ASMnQiCf7Cg00hjsqMn5ohL5
         2jub9/BdQSm7DFOmELtkwQgrXUUgz61cWvFyQPsjbZ5vEPKWlfeubxKU4z0tQqhrH5pc
         l3HG/EteXQSMtLsMM+BC7ccOJ5xDij0fnaU7tihP8J2CHmpyb9tfPKeY2hy0HCbiEtWg
         sr92v7H+79HS7NguJpjcw5NIV5YQwfAw46m1XgcRF9BMshXUpWRhMSPqr+Q0hIpvo4yW
         nwYtbz9scdW8cTrTMdg7blQv/UXj4axS5VFS2zL9/2c6CsyTohvNSuvg/X7Wjj+OHzP/
         4f0w==
X-Gm-Message-State: AOAM533eWXNLl34W84SDNXJKJ8INaFEchTdAu4ImJSATge/91ZCyyHcy
        t0pixKw/YoJRpiHCTJAf4jQ=
X-Google-Smtp-Source: ABdhPJwfLAUIJ7XsHjJYBXL93zKQLXvTSKmeEiFkgLEDGIzfTuvzl2HAV3sWfVXmeo9ju5pOFyoswQ==
X-Received: by 2002:a63:8f0b:: with SMTP id n11mr23535475pgd.342.1622018649377;
        Wed, 26 May 2021 01:44:09 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.48.252.66])
        by smtp.gmail.com with ESMTPSA id x203sm15177676pfc.86.2021.05.26.01.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 01:44:09 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH V2 7/7] ext4: get discard out of jbd2 commit kthread contex
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
Message-ID: <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
Date:   Wed, 26 May 2021 16:44:06 +0800
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
 fs/ext4/mballoc.c | 162 +++++++++++++++++++++++++++++++++---------------------
 fs/ext4/mballoc.h |   3 -
 3 files changed, 101 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5c5c8e4..2e48c88 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1526,6 +1526,7 @@ struct ext4_sb_info {
 	unsigned int *s_mb_maxs;
 	unsigned int s_group_info_size;
 	atomic_t s_mb_free_pending;
+	struct work_struct s_discard_work;
 
 	/* tunables */
 	unsigned long s_stripe;
@@ -3306,6 +3307,7 @@ struct ext4_group_info {
 	unsigned long	bb_check_counter;
 #endif
 	struct rb_root  bb_free_root;
+	struct rb_root  bb_discard_root;
 	ext4_grpblk_t	bb_first_free;	/* first free block */
 	ext4_grpblk_t	bb_free;	/* total free blocks */
 	ext4_grpblk_t	bb_fragments;	/* nr of freespace fragments */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 15715e7..feea439 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -332,6 +332,7 @@
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
 static struct kmem_cache *ext4_free_data_cachep;
+static struct workqueue_struct *ext4_discard_wq;
 
 /* We create slab caches for groupinfo data structures based on the
  * superblock block size.  There will be one per mounted filesystem for
@@ -355,7 +356,10 @@ static inline struct ext4_free_data *efd_entry(struct rb_node *n)
 	return rb_entry_safe(n, struct ext4_free_data, efd_node);
 }
 static int ext4_insert_free_data(struct rb_root *root, struct ext4_free_data *nfd);
-
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks);
+static void ext4_discard_work(struct work_struct *work);
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -2657,6 +2661,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
+	meta_group_info[i]->bb_discard_root = RB_ROOT;
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
 
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
@@ -2857,6 +2862,7 @@ int ext4_mb_init(struct super_block *sb)
 	spin_lock_init(&sbi->s_md_lock);
 	spin_lock_init(&sbi->s_bal_lock);
 	atomic_set(&sbi->s_mb_free_pending, 0);
+	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
 
 	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
 	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
@@ -2949,6 +2955,15 @@ int ext4_mb_release(struct super_block *sb)
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
+	queue_work(ext4_discard_wq, &sbi->s_discard_work);
 	if (sbi->s_group_info) {
 		for (i = 0; i < ngroups; i++) {
 			cond_resched();
@@ -3024,30 +3039,77 @@ static inline int ext4_issue_discard(struct super_block *sb,
 		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
 }
 
-static void ext4_free_data_in_buddy(struct super_block *sb,
-				    struct ext4_free_data *entry)
+static void ext4_discard_work(struct work_struct *work)
 {
+	struct ext4_sb_info *sbi = container_of(work,
+			struct ext4_sb_info, s_discard_work);
+	struct super_block *sb = sbi->s_sb;
+	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	struct ext4_group_info *grp;
+	struct ext4_free_data *fd, *nfd;
 	struct ext4_buddy e4b;
-	struct ext4_group_info *db;
-	int err, count = 0, count2 = 0;
+	int i, err;
+
+	for (i = 0; i < ngroups; i++) {
+		grp = ext4_get_group_info(sb, i);
+		if (RB_EMPTY_ROOT(&grp->bb_discard_root))
+			continue;
 
-	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
-		 entry->efd_count, entry->efd_group, entry);
+		err = ext4_mb_load_buddy(sb, i, &e4b);
+		if (err) {
+			ext4_warning(sb, "Error %d loading buddy information for %u",
+					err, i);
+			continue;
+		}
 
-	err = ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
-	/* we expect to find existing buddy because it's pinned */
-	BUG_ON(err != 0);
+		ext4_lock_group(sb, i);
+		rbtree_postorder_for_each_entry_safe(fd, nfd,
+				&grp->bb_discard_root, efd_node) {
+			rb_erase(&fd->efd_node, &grp->bb_discard_root);
+			/*
+			 * If filesystem is umounting, give up the discard
+			 */
+			if (sb->s_flags & SB_ACTIVE)
+				ext4_try_to_trim_range(sb, &e4b, fd->efd_start_cluster,
+						fd->efd_start_cluster + fd->efd_count - 1, 1);
+			kmem_cache_free(ext4_free_data_cachep, fd);
+		}
+		ext4_unlock_group(sb, i);
+		ext4_mb_unload_buddy(&e4b);
+	}
+}
 
-	atomic_sub(entry->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
+static int ext4_free_data_in_buddy(struct super_block *sb,
+		ext4_group_t group, tid_t commit_tid)
+{
+	struct ext4_buddy e4b;
+	struct ext4_group_info *db;
+	struct ext4_free_data *fd, *nfd;
+	int cnt, nr_fd;
 
+	/* we expect to find existing buddy because it's pinned */
+	BUG_ON(ext4_mb_load_buddy(sb, group, &e4b));
 	db = e4b.bd_info;
-	/* there are blocks to put in buddy to make them really free */
-	count += entry->efd_count;
-	count2++;
-	ext4_lock_group(sb, entry->efd_group);
-	/* Take it out of per group rb tree */
-	rb_erase(&entry->efd_node, &(db->bb_free_root));
-	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, entry->efd_count);
+	cnt = 0;
+	nr_fd = 0;
+	ext4_lock_group(sb, group);
+	rbtree_postorder_for_each_entry_safe(fd, nfd,
+			&db->bb_free_root, efd_node) {
+		if (fd->efd_tid != commit_tid)
+			continue;
+
+		mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
+			 fd->efd_count, fd->efd_group, fd);
+		atomic_sub(fd->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
+		cnt += fd->efd_count;
+		nr_fd++;
+		rb_erase(&fd->efd_node, &db->bb_free_root);
+		mb_free_blocks(NULL, &e4b, fd->efd_start_cluster, fd->efd_count);
+		if (test_opt(sb, DISCARD))
+			ext4_insert_free_data(&db->bb_discard_root, fd);
+		else
+			kmem_cache_free(ext4_free_data_cachep, fd);
+	}
 
 	/*
 	 * Clear the trimmed flag for the group so that the next
@@ -3055,22 +3117,22 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	 * If the volume is mounted with -o discard, online discard
 	 * is supported and the free blocks will be trimmed online.
 	 */
-	if (!test_opt(sb, DISCARD))
+	if (!test_opt(sb, DISCARD) && cnt)
 		EXT4_MB_GRP_CLEAR_TRIMMED(db);
 
-	if (!db->bb_free_root.rb_node) {
+	if (RB_EMPTY_ROOT(&db->bb_free_root) && cnt) {
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
 		put_page(e4b.bd_buddy_page);
 		put_page(e4b.bd_bitmap_page);
 	}
-	ext4_unlock_group(sb, entry->efd_group);
-	kmem_cache_free(ext4_free_data_cachep, entry);
+	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
-	mb_debug(sb, "freed %d blocks in %d structures\n", count,
-		 count2);
+	mb_debug(sb, "freed %d blocks in %d structures\n", cnt, nr_fd);
+
+	return nr_fd;
 }
 
 /*
@@ -3081,52 +3143,21 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
-	struct ext4_free_data *fd, *nfd;
 	struct ext4_group_info *grp;
-	struct bio *discard_bio = NULL;
-	struct list_head freed_data_list;
-	int err, i;
+	int i, nr;
 
 	if (!atomic_read(&sbi->s_mb_free_pending))
 		return;
 
-	INIT_LIST_HEAD(&freed_data_list);
-	for (i = 0; i < ngroups; i++) {
+	for (i = 0, nr = 0; i < ngroups; i++) {
 		grp = ext4_get_group_info(sb, i);
-		ext4_lock_group(sb, i);
-		rbtree_postorder_for_each_entry_safe(fd, nfd,
-				&grp->bb_free_root, efd_node) {
-			if (fd->efd_tid != commit_tid)
-				continue;
-			INIT_LIST_HEAD(&fd->efd_list);
-			list_add_tail(&fd->efd_list, &freed_data_list);
-		}
-		ext4_unlock_group(sb, i);
-	}
-
-	if (test_opt(sb, DISCARD)) {
-		list_for_each_entry(fd, &freed_data_list, efd_list) {
-			err = ext4_issue_discard(sb, fd->efd_group,
-						 fd->efd_start_cluster,
-						 fd->efd_count,
-						 &discard_bio);
-			if (err && err != -EOPNOTSUPP) {
-				ext4_msg(sb, KERN_WARNING, "discard request in"
-					 " group:%d block:%d count:%d failed"
-					 " with %d", fd->efd_group,
-					 fd->efd_start_cluster, fd->efd_count, err);
-			} else if (err == -EOPNOTSUPP)
-				break;
-		}
-
-		if (discard_bio) {
-			submit_bio_wait(discard_bio);
-			bio_put(discard_bio);
-		}
+		if (RB_EMPTY_ROOT(&grp->bb_free_root))
+			continue;
+		nr += ext4_free_data_in_buddy(sb, i, commit_tid);
 	}
 
-	list_for_each_entry_safe(fd, nfd, &freed_data_list, efd_list)
-		ext4_free_data_in_buddy(sb, fd);
+	if (nr && test_opt(sb, DISCARD))
+		queue_work(ext4_discard_wq, &sbi->s_discard_work);
 }
 
 int __init ext4_init_mballoc(void)
@@ -3146,8 +3177,13 @@ int __init ext4_init_mballoc(void)
 	if (ext4_free_data_cachep == NULL)
 		goto out_ac_free;
 
-	return 0;
+	ext4_discard_wq = alloc_workqueue("ext4discard", WQ_UNBOUND, 0);
+	if (!ext4_discard_wq)
+		goto out_free_data;
 
+	return 0;
+out_free_data:
+	kmem_cache_destroy(ext4_free_data_cachep);
 out_ac_free:
 	kmem_cache_destroy(ext4_ac_cachep);
 out_pa_free:
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index e75b474..d76286b 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -79,9 +79,6 @@
 #define MB_DEFAULT_MAX_INODE_PREALLOC	512
 
 struct ext4_free_data {
-	/* this links the free block information from sb_info */
-	struct list_head		efd_list;
-
 	/* this links the free block information from group_info */
 	struct rb_node			efd_node;
 
-- 
1.8.3.1
