Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5577941A8B7
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Sep 2021 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhI1GWU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Sep 2021 02:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1GWT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Sep 2021 02:22:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACDEC061575;
        Mon, 27 Sep 2021 23:20:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so1931479pjb.4;
        Mon, 27 Sep 2021 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1NgwWizDvquhA1vHirCNXX1aD4SPaNDoUx3U2uDuBao=;
        b=Y3WAGLAaZb0+mw36CzoCwxiMxlidxyfTXTNQwI0tTXqTNsvWSiow9P3RpacyvV9esE
         pPMOJDUn8BDW4gRJPUs4o1m8LhSZQks8iQWzpGer1YXDrc3YoB3bxJCMu7uJQ/Q6FkbY
         JaHsmZRqzGBrEClOf/WWyYge4ut3y9Oz0mVrYI7KXBO8oiyjaAw/2TudsLUenkgvACdz
         36BQCFBwReqPAWS+MrdkhTKNGRRGXF/ie4JYlXQYCMPh0g1yC17JH9dsWsG6hoVnzbcV
         aqqaJvcSSQsGcmRJxYBsSJtlIof2tzkd1aCZFGnJJrsDRjyl7qMuh9vfNH50anIdvtF6
         rWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1NgwWizDvquhA1vHirCNXX1aD4SPaNDoUx3U2uDuBao=;
        b=f+879kZD9ZRBZtaO/aFP07bEY/vwhS2EIOQ5KzoFyKz1SJolOtGZRDpIJgoYIuxYif
         6h3xI9Rj+hIdHS2PF9KadzjqT7SO8CaOs1DuP9YMsEoXLKw4WQiZ6toixZgaRj0gkP6U
         0WIb9pKuAqb4BP4y9ANpslyFITiDnQO458frOvPLYI+1i/kcva9P25iZBMc3pla+xoFY
         p4pK637emfar9rHnwMN7YsrLP1fPxphA6N4qWK8O6ezFeN3HK28s21lSejjVyJH4jPPL
         D6JQFovg9Plqas0Je1HHxTSuYryP1kBr5v8L84sM6rxspsak/e1qFG9ELmeMYDlxplN/
         LckQ==
X-Gm-Message-State: AOAM5312YpcLShBdw7LfSYroQAXLSzuTcklAl49D9cyzs6IjzLE1kj+t
        xLk4BzXaf7flK5lGhKQBqX3JkXODt0mLgGrg
X-Google-Smtp-Source: ABdhPJzeJwb5L+mq3sUpv0Gb1D3eHgRjgwMGpKgGpwq8h4+NA8WaMpD6I225TRr2hdaCniPWf2qlhw==
X-Received: by 2002:a17:90a:7892:: with SMTP id x18mr3431485pjk.95.1632810040531;
        Mon, 27 Sep 2021 23:20:40 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id c9sm18923542pfi.212.2021.09.27.23.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 23:20:38 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix a possible ABBA deadlock dued to busy PA
Date:   Tue, 28 Sep 2021 14:20:36 +0800
Message-Id: <1632810036-18005-1-git-send-email-brookxu.cn@gmail.com>
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
 fs/ext4/mballoc.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72bfac2..4ebcda6 100644
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
@@ -5455,15 +5443,22 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
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
 	}
 
+	if (needed > 0 && busy && retry < 3)
+		goto repeat;
+
 	return freed;
 }
 
-- 
1.8.3.1

