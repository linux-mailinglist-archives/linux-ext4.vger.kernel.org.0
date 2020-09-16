Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C089626CA0E
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgIPToi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 15:44:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbgIPToc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 15:44:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 120A5A12D752EA1615A3;
        Wed, 16 Sep 2020 19:37:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 19:37:46 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <riteshh@linux.ibm.com>, <jack@suse.cz>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v5 1/2] ext4: Discard preallocations before releasing group lock
Date:   Wed, 16 Sep 2020 19:38:58 +0800
Message-ID: <20200916113859.1556397-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200916113859.1556397-1-yebin10@huawei.com>
References: <20200916113859.1556397-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

ext4_mb_discard_group_preallocations() can be releasing group lock with
preallocations accumulated on its local list. Thus although
discard_pa_seq was incremented and concurrent allocating processes will
be retrying allocations, it can happen that premature ENOSPC error is
returned because blocks used for preallocations are not available for
reuse yet. Make sure we always free locally accumulated preallocations
before releasing group lock.

Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..f736819a381b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4215,22 +4215,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
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
 
@@ -4248,7 +4232,17 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
 	}
 
-out:
+	/* if we still need more blocks and some PAs were used, try again */
+	if (free < needed && busy) {
+		ext4_unlock_group(sb, group);
+		cond_resched();
+		busy = 0;
+		/* Make sure we increment discard_pa_seq again */
+		needed -= free;
+		free = 0;
+		goto repeat;
+	}
+
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
-- 
2.25.4

