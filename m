Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB59382330
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhEQD6k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 May 2021 23:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhEQD6k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 May 2021 23:58:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBEBC061573;
        Sun, 16 May 2021 20:57:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4786035pjp.4;
        Sun, 16 May 2021 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7zD/4U/VXqIEHlzDY7beHDVpQxyfO9r+gVfWdj0Ct6A=;
        b=tH6cU6iFbBhGJlDuuKwyMuGaQ4D32r82hoWOTD3nIAfR0RZpbHua9VAIZwd4PXrc2F
         9YsycAx8AMIqUberl/4GCRJ7W0P5EnB6q9LL/ofCnv+O+GbCKpVDH2J2+B2ZdvwoIJaW
         COeHyJmkboG5tMQpY5Tq23tgvIyU7XQMa+QBNWG44Qy3Mdls+n8HOPrh/sxoZ9CMTo/h
         MQgUBydH80SbPae4TbzgrMG0wGPmyx8FVvVxMc/GWZIHAnyiPU76S3o5rza7WBHtNixQ
         1romUCYesWvOe1rW87fGGfpoBw5Z+6Yscyn7VX+w1gGiLJAiOofbl0+bVFmTKUc+5HG0
         vWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7zD/4U/VXqIEHlzDY7beHDVpQxyfO9r+gVfWdj0Ct6A=;
        b=ifETs/BNYEhhEstGT92tF6YtlJA8MtiLTHtf2HGgiNPeyBZe0/CXjuu6XlaVbl6uHM
         OkTDfXtH5ZDNUdEk8Vm0Sb8JwOQOfx9uLxmcX+IGUOwUam6DoEgIQ5g0eZWNbj546zEu
         uIPQbf0KGwsD6aH81sYPNOcdwwdS6JGjUwl3GvdlHu87jnR+vGGyWaGmsVB7QNJfcaaz
         z73kZYSoGH4iZq1dF69V3IiaePuvNsqAeIJF+p5Xbl7m/CltuGG9fOFKapGxH4JpGDE+
         ywG51c/+4bYAraZACIP9efOceVDGaDjupNaoKVR7mDso36E1HuErxIZrcmiXjwyPTelb
         inSA==
X-Gm-Message-State: AOAM530qyC99HI1XoeEEsmzOFFKviL6uB1aI2/DrtrmF/97ZjNHOyedv
        xPsAaPZax93MOflrdL1MMex4XJ5fXi2i2w==
X-Google-Smtp-Source: ABdhPJyqhhl8A2VSvcr68anY7nY6ve+7Th7somWfGhWeZUtFFmrTAuG/NzjIZulPia6ZSfyB5p0qzQ==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr64550203pji.14.1621223843981;
        Sun, 16 May 2021 20:57:23 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.202])
        by smtp.gmail.com with ESMTPSA id f18sm9371245pjh.55.2021.05.16.20.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 20:57:23 -0700 (PDT)
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [PATCH] ext4: get discard out of jbd2 commit kthread
Message-ID: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
Date:   Mon, 17 May 2021 11:57:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
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

This patch moves the discard out of jbd2 kthread context and do it
in kworker. And drain the kwork when cannot get space in mb buddy.
This is done out of jbd2 handle and won't block the commit process.
After that, we could use blk-wbt or other method to throttle the
discard and needn't to worry it block the jbd2 commit kthread any
more.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/balloc.c  |   1 +
 fs/ext4/ext4.h    |   4 ++
 fs/ext4/mballoc.c | 130 ++++++++++++++++++++++++++++++++++++++++++------------
 fs/ext4/mballoc.h |   5 +++
 fs/ext4/super.c   |   3 ++
 5 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 9dc6e74b..e8676a8 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -661,6 +661,7 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 	 */
 	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
 	(void) jbd2_journal_force_commit_nested(sbi->s_journal);
+	flush_work(&sbi->s_afd_work);
 	return 1;
 }
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 37002663..5c4d4bf 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1531,6 +1531,10 @@ struct ext4_sb_info {
 	struct list_head *s_mb_largest_free_orders;
 	rwlock_t *s_mb_largest_free_orders_locks;
 
+	struct list_head s_afd_list;
+	spinlock_t s_afd_lock;
+	struct work_struct s_afd_work;
+
 	/* tunables */
 	unsigned long s_stripe;
 	unsigned int s_mb_max_linear_groups;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3239e66..b463daa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -386,6 +386,7 @@
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
 static struct kmem_cache *ext4_free_data_cachep;
+static struct workqueue_struct *ext4_discard_wq;
 
 /* We create slab caches for groupinfo data structures based on the
  * superblock block size.  There will be one per mounted filesystem for
@@ -408,6 +409,7 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 			       ext4_group_t group, int cr);
 
+static void ext4_async_discard_work(struct work_struct *work);
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -3375,6 +3377,9 @@ int ext4_mb_init(struct super_block *sb)
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
+	INIT_LIST_HEAD(&sbi->s_afd_list);
+	spin_lock_init(&sbi->s_afd_lock);
+	INIT_WORK(&sbi->s_afd_work, ext4_async_discard_work);
 
 	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
 	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
@@ -3602,6 +3607,94 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		 count2);
 }
 
+static void do_discard_and_free_data(struct super_block *sb,
+		struct list_head *free_list)
+{
+	struct ext4_free_data *entry, *nxt;
+	struct bio *discard_bio = NULL;
+	struct blk_plug plug;
+	int err;
+
+	if (!test_opt(sb, DISCARD))
+		goto free_data;
+
+	blk_start_plug(&plug);
+	list_for_each_entry(entry, free_list, efd_list) {
+		err = ext4_issue_discard(sb, entry->efd_group,
+				entry->efd_start_cluster,
+				entry->efd_count,
+				&discard_bio);
+		if (err && err != -EOPNOTSUPP)
+			ext4_msg(sb, KERN_WARNING,
+				"discard request in group:%d block:%d count:%d failed with %d",
+				entry->efd_group,
+				entry->efd_start_cluster,
+				entry->efd_count, err);
+		else if (err == -EOPNOTSUPP)
+			break;
+	}
+	blk_finish_plug(&plug);
+
+	if (discard_bio) {
+		submit_bio_wait(discard_bio);
+		bio_put(discard_bio);
+	}
+
+free_data:
+	list_for_each_entry_safe(entry, nxt, free_list, efd_list)
+		ext4_free_data_in_buddy(sb, entry);
+}
+
+static void ext4_async_discard_work(struct work_struct *work)
+{
+	struct ext4_sb_info *sbi = container_of(work,
+			struct ext4_sb_info, s_afd_work);
+	struct ext4_async_free_data *afd, *nxt;
+	LIST_HEAD(afd_list);
+
+	/*
+	 * Don't worry about the lifecycle of sb, kill_sb would
+	 * invoke sync_fs who waits to drain all of async discard
+	 * work.
+	 */
+	spin_lock(&sbi->s_afd_lock);
+	list_splice_init(&sbi->s_afd_list, &afd_list);
+	spin_unlock(&sbi->s_afd_lock);
+
+	list_for_each_entry_safe(afd, nxt, &afd_list, list_node) {
+		list_del(&afd->list_node);
+		do_discard_and_free_data(sbi->s_sb, &afd->free_list);
+		kfree(afd);
+	}
+}
+
+/*
+ * Try to do discard out of jbd2 kthread, otherwise it may
+ * block the process of transaction commit.
+ */
+static bool ext4_do_async_discard(struct super_block *sb,
+		struct list_head *free_list)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_async_free_data *afd;
+
+	afd = kmalloc(sizeof(*afd), GFP_NOFS);
+	if (!afd)
+		return false;
+
+	INIT_LIST_HEAD(&afd->list_node);
+	INIT_LIST_HEAD(&afd->free_list);
+
+	list_splice(free_list, &afd->free_list);
+	spin_lock(&sbi->s_afd_lock);
+	if (list_empty(&sbi->s_afd_list))
+		queue_work(ext4_discard_wq, &sbi->s_afd_work);
+	list_add_tail(&afd->list_node, &sbi->s_afd_list);
+	spin_unlock(&sbi->s_afd_lock);
+
+	return true;
+}
+
 /*
  * This function is called by the jbd2 layer once the commit has finished,
  * so we know we can free the blocks that were released with that commit.
@@ -3609,11 +3702,9 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_free_data *entry, *tmp;
-	struct bio *discard_bio = NULL;
+	struct ext4_free_data *entry;
 	struct list_head freed_data_list;
 	struct list_head *cut_pos = NULL;
-	int err;
 
 	INIT_LIST_HEAD(&freed_data_list);
 
@@ -3628,30 +3719,9 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
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
-
-		if (discard_bio) {
-			submit_bio_wait(discard_bio);
-			bio_put(discard_bio);
-		}
-	}
-
-	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
-		ext4_free_data_in_buddy(sb, entry);
+	if (!test_opt(sb, DISCARD) ||
+	    !ext4_do_async_discard(sb, &freed_data_list))
+		do_discard_and_free_data(sb, &freed_data_list);
 }
 
 int __init ext4_init_mballoc(void)
@@ -3671,8 +3741,14 @@ int __init ext4_init_mballoc(void)
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
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 39da92c..b762727 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -212,6 +212,11 @@ struct ext4_buddy {
 	ext4_group_t bd_group;
 };
 
+struct ext4_async_free_data {
+	struct list_head list_node;
+	struct list_head free_list;
+};
+
 static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
 					struct ext4_free_extent *fex)
 {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7dc94f3..545a02c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5752,6 +5752,9 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 			ret = err;
 	}
 
+	if (test_opt(sb, DISCARD))
+		flush_work(&sbi->s_afd_work);
+
 	return ret;
 }
 
-- 
1.8.3.1
