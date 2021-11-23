Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962A845999F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKWBVJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 20:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKWBVJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 20:21:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F794C061574;
        Mon, 22 Nov 2021 17:18:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b13so15656312plg.2;
        Mon, 22 Nov 2021 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KHR91PZFjoFttvxhIVxVMsutPsz8K1QRHL6iXzq/ohs=;
        b=mhlpACSRsEfj/sgKl4lYHP3mkJjUENwKogV/8wVZSEtILhdYzNq0zl3mUH4vfB6Ej+
         tCi49Pti4D+fdCImANd+Q/UWAc42gjUu0bHtqcyktSP0qBJSvOekStiKzh+G2sXIeMRW
         3Tt4srC2n+440/92cT7PZ0E5r0amJKcvgbT14i6E1AytHfuAK29bJ5FoNmb+teWs3nNo
         g1ugejpZ0DmBGvopS04T/zj8Gv2+rpOSdJRMKCc66S56ku0f81pyE/+NQ2u1eiQMQ9Lu
         R4A3gZ9y3Y3OFf3PaCBO6Q7CR9Xs/H14qshdWWgPvS3c0s0D6JiJlGXm0CtS2+gfMBeo
         GLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KHR91PZFjoFttvxhIVxVMsutPsz8K1QRHL6iXzq/ohs=;
        b=D4+xGWJs0KQ7tdb/zXFg+8WmwH1hzZrzdgTyn+U03QGGmlbsuUccNFm3W36yvVVRKI
         sOacFOJAqvCO765Sf/wdnUNX1M5GYh15gBj/2Yp2pjMbGiO8cIzgzAfUlQDHWldJDEKH
         WoIFPLqKGwrFUmYIzvwJw0gA8VDraEagfKLLjYf2h5EVYKdHnj5hOZj8s9a0n1WbmW47
         lBf5wVD2VDG0cHApounqBAxtkMxm/i1nB5PBWyXlOUdeQimO+jya5U5rcWHrYDOSL40V
         Xb+M3gE5ZY0G2gM8SvFlQNb4PoSji4ctE/nWuPXKRjaljeUhpLwRAArvN76I2nPA4uwx
         8rpA==
X-Gm-Message-State: AOAM533q56VNVx+s4ROT/1hQlsZ2ClxvH8ZvJR8/BqeIK/ULE7mgV82Z
        V7Y/5g/IX3kI9M+w2+j/vU0=
X-Google-Smtp-Source: ABdhPJzVhnAguTRhd0LsOA3bjXmgYYk+RsgDY0BAXXrRv7p995Un17Ri3Oeg7fJhHZ89c+htQeL27g==
X-Received: by 2002:a17:902:8e87:b0:143:759c:6a2d with SMTP id bg7-20020a1709028e8700b00143759c6a2dmr1937989plb.59.1637630281208;
        Mon, 22 Nov 2021 17:18:01 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t7sm19971415pjs.45.2021.11.22.17.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 17:18:00 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ext4: fix a possible ABBA deadlock dued to busy PA
Date:   Tue, 23 Nov 2021 09:17:57 +0800
Message-Id: <1637630277-23496-1-git-send-email-brookxu.cn@gmail.com>
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
Reported-by: kernel test robot <lkp@intel.com>
---
v2: reset busy to zero before goto repeat.
v3: fix a clang-analyzer warning report by kernel test robot.

 fs/ext4/mballoc.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 215b706..3dd9b9e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4814,7 +4814,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
  */
 static noinline_for_stack int
 ext4_mb_discard_group_preallocations(struct super_block *sb,
-					ext4_group_t group, int needed)
+				     ext4_group_t group, int *busy)
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
@@ -4846,19 +4845,14 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 		goto out_dbg;
 	}
 
-	if (needed == 0)
-		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
-
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
@@ -4898,22 +4892,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
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
@@ -5455,13 +5440,24 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 {
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	int ret;
-	int freed = 0;
+	int freed = 0, busy = 0;
+	int retry = 0;
 
 	trace_ext4_mb_discard_preallocations(sb, needed);
+
+	if (needed == 0)
+		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
+ repeat:
 	for (i = 0; i < ngroups && needed > 0; i++) {
-		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
+		ret = ext4_mb_discard_group_preallocations(sb, i, &busy);
 		freed += ret;
 		needed -= ret;
+		cond_resched();
+	}
+
+	if (needed > 0 && busy && ++retry < 3) {
+		busy = 0;
+		goto repeat;
 	}
 
 	return freed;
-- 
1.8.3.1

