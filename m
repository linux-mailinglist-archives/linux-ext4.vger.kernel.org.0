Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5972774EB
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgIXPKI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 11:10:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgIXPKI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 11:10:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A0BEB03F;
        Thu, 24 Sep 2020 15:10:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03C171E12DD; Thu, 24 Sep 2020 17:10:06 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Ye Bin <yebin10@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext4: Discard preallocations before releasing group lock
Date:   Thu, 24 Sep 2020 17:09:59 +0200
Message-Id: <20200924150959.4335-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_mb_discard_group_preallocations() can be releasing group lock with
preallocations accumulated on its local list. Thus although
discard_pa_seq was incremented and concurrent allocating processes will
be retrying allocations, it can happen that premature ENOSPC error is
returned because blocks used for preallocations are not available for
reuse yet. Make sure we always free locally accumulated preallocations
before releasing group lock.

Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..2287d05c2e49 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4160,7 +4160,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	struct ext4_buddy e4b;
 	int err;
 	int busy = 0;
-	int free = 0;
+	int free, free_total = 0;
 
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
@@ -4188,6 +4188,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 
 	INIT_LIST_HEAD(&list);
 repeat:
+	free = 0;
 	ext4_lock_group(sb, group);
 	this_cpu_inc(discard_pa_seq);
 	list_for_each_entry_safe(pa, tmp,
@@ -4215,22 +4216,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		list_add(&pa->u.pa_tmp_list, &list);
 	}
 
-	/* if we still need more blocks and some PAs were used, try again */
-	if (free < needed && busy) {
-		busy = 0;
-		ext4_unlock_group(sb, group);
-		cond_resched();
-		goto repeat;
-	}
-
-	/* found anything to free? */
-	if (list_empty(&list)) {
-		BUG_ON(free != 0);
-		mb_debug(sb, "Someone else may have freed PA for this group %u\n",
-			 group);
-		goto out;
-	}
-
 	/* now free all selected PAs */
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 
@@ -4248,14 +4233,22 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
 
-out:
+	free_total += free;
+
+	/* if we still need more blocks and some PAs were used, try again */
+	if (free_total < needed && busy) {
+		ext4_unlock_group(sb, group);
+		cond_resched();
+		busy = 0;
+		goto repeat;
+	}
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
 out_dbg:
 	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
-		 free, group, grp->bb_free);
-	return free;
+		 free_total, group, grp->bb_free);
+	return free_total;
 }
 
 /*
-- 
2.16.4

