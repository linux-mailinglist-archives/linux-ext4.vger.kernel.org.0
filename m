Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF07E41BC14
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Sep 2021 03:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbhI2BOJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Sep 2021 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbhI2BOJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Sep 2021 21:14:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21482C06161C;
        Tue, 28 Sep 2021 18:12:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so536874pff.3;
        Tue, 28 Sep 2021 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2MMge1Bbq+tVQ9rbGODc1DW+eqgqDcqIYZ/e7PNWRJ8=;
        b=hJt7l/Nx3YuJhIWSgBGOMyYXYeJcasI5vMI4eyFg9qYN8M46vT7Afzvq8gTmos8YBs
         3Y3yjKsKm/uwI+Yb5hgDaQu1Bw8/Cla3GxHOxtpW8iAHX6eUqfeBOpD06XG5WVbiBvIa
         vBLy+ttQvZly+ewCC28UsECIOrIH6C5pOxCW5zJuxSlpAngz04cMvgOj/361i9T4b8cu
         cTN6hOVBhBmPUjjEEvlL1vWrs4tmhmf5hhJQdJ9g4hlEw0tv8bCcoJarYXIm6oYpgID3
         td7AHKYgLRECWmSJnbmvyAtAJvLVHuhIX9BZwY20f2iIg7XICw8uH9ce9DR+aRTULrlA
         acuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2MMge1Bbq+tVQ9rbGODc1DW+eqgqDcqIYZ/e7PNWRJ8=;
        b=ech1dBiPZM2WIzw0CNcKShkJaky1/zYKv+t2KLGvA/iTp3+wf9fk0vt8OSaYXIiyip
         8p2ro1Wal4immmZHIC58sUuni5hYudpxFGHE5cmHArrDbtnR+5yY8EeBlEBfMU++Xzp9
         aaDX727ft5toi5zdegozYpURdclshdrPxpaV+bPqQFB7n8/OdF0xMD+kWVor0MbZHeBU
         oqkBMnSNwKmFW5zXb/xfAO2arZZRDo1Ku/3w6RncQbED0w3iKy5LypPAvFmDuR5Q6jGB
         GqGn3jtRvMKjIp7y8uYMdsnKRDeGRL0yIQCZ6kTVhMs7DIf1AXSZ2WPU0FdB5Xr7v6GA
         NwuA==
X-Gm-Message-State: AOAM533OfVkK1+68gy6H/+ZKAK9Cq+51Cp+hW4c+YCWdyAzwqAfo1cny
        KP0GS/kYbFwyABfHcMZekjrxbp2PN2so4jJ0
X-Google-Smtp-Source: ABdhPJwLpaCidMAUcGRjIWsl0VRTMQ4Bib7rHc6tQRJYRt6cWUdLnWCDL6ecDaYQ+cPgpKjfxb6O6Q==
X-Received: by 2002:aa7:9718:0:b0:43e:ee6:fd94 with SMTP id a24-20020aa79718000000b0043e0ee6fd94mr691187pfg.73.1632877948576;
        Tue, 28 Sep 2021 18:12:28 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n3sm908078pjv.15.2021.09.28.18.12.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 18:12:28 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ext4: fix a possible ABBA deadlock dued to busy PA
Date:   Wed, 29 Sep 2021 09:12:25 +0800
Message-Id: <1632877945-18526-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

We found on older kernel (3.10) that in the scenario of insufficient
disk space, system may trigger an ABBA deadlock problem, it seems that
this problem still exists in latest kernel, try to fix it here. The
main process triggered by this problem is that task A occupies the PA
and waits for the jbd2 transaction finish, the jbd2 transaction waits
for the completion of task B's IO (plug_list), but task B waits for
the release of PA by task A to finish discard, which indirectly forms
an ABBA deadlock. The related calltrace is as follows:

    Task A
    vfs_write
    ext4_mb_new_blocks()
    ext4_mb_mark_diskspace_used()       JBD2
    jbd2_journal_get_write_access()  -> jbd2_journal_commit_transaction()
  ->schedule()                          filemap_fdatawait()
 |                                              |
 | Task B                                       |
 | do_unlinkat()                                |
 | ext4_evict_inode()                           |
 | jbd2_journal_begin_ordered_truncate()        |
 | filemap_fdatawrite_range()                   |
 | ext4_mb_new_blocks()                         |
  -ext4_mb_discard_group_preallocations() <-----

Here, try to cancel ext4_mb_discard_group_preallocations() internal
retry due to PA busy, and do a limited number of retries inside
ext4_mb_discard_preallocations(), which can circumvent the above
problems, but also has some advantages:

1. Since the PA is in a busy state, if other groups have free PAs,
   keeping the current PA may help to reduce fragmentation.
2. Continue to traverse forward instead of waiting for the current
   group PA to be released. In most scenarios, the PA discard time
   can be reduced.

However, in the case of smaller free space, if only a few groups have
space, then due to multiple traversals of the group, it may increase
CPU overhead. But in contrast, I feel that the overall benefit is
better than the cost.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
v2: reset busy to zero before goto repeat.

 fs/ext4/mballoc.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72bfac2..72de6c1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4814,7 +4814,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
  */
 static noinline_for_stack int
 ext4_mb_discard_group_preallocations(struct super_block *sb,
-					ext4_group_t group, int needed)
+				     ext4_group_t group, int needed, int *busy)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct buffer_head *bitmap_bh = NULL;
@@ -4822,8 +4822,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 	struct list_head list;
 	struct ext4_buddy e4b;
 	int err;
-	int busy = 0;
-	int free, free_total = 0;
+	int free = 0;
 
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
@@ -4850,15 +4849,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
 
 	INIT_LIST_HEAD(&list);
-repeat:
-	free = 0;
 	ext4_lock_group(sb, group);
 	list_for_each_entry_safe(pa, tmp,
 				&grp->bb_prealloc_list, pa_group_list) {
 		spin_lock(&pa->pa_lock);
 		if (atomic_read(&pa->pa_count)) {
 			spin_unlock(&pa->pa_lock);
-			busy = 1;
+			*busy = 1;
 			continue;
 		}
 		if (pa->pa_deleted) {
@@ -4898,22 +4895,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
 
-	free_total += free;
-
-	/* if we still need more blocks and some PAs were used, try again */
-	if (free_total < needed && busy) {
-		ext4_unlock_group(sb, group);
-		cond_resched();
-		busy = 0;
-		goto repeat;
-	}
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
 out_dbg:
 	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
-		 free_total, group, grp->bb_free);
-	return free_total;
+		 free, group, grp->bb_free);
+	return free;
 }
 
 /*
@@ -5455,13 +5443,22 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 {
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	int ret;
-	int freed = 0;
+	int freed = 0, busy = 0;
+	int retry = 0;
 
 	trace_ext4_mb_discard_preallocations(sb, needed);
+ repeat:
+	retry++;
 	for (i = 0; i < ngroups && needed > 0; i++) {
-		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
+		ret = ext4_mb_discard_group_preallocations(sb, i, needed, &busy);
 		freed += ret;
 		needed -= ret;
+		cond_resched();
+	}
+
+	if (needed > 0 && busy && retry < 3) {
+		busy = 0;
+		goto repeat;
 	}
 
 	return freed;
-- 
1.8.3.1

