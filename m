Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E95268990
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgINKqg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 06:46:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgINKqf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Sep 2020 06:46:35 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 104DE68FA01E207A969D;
        Mon, 14 Sep 2020 18:46:32 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 18:46:22 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <riteshh@linux.ibm.com>, <jack@suse.cz>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v4]  ext4: Fix dead loop in ext4_mb_new_blocks
Date:   Mon, 14 Sep 2020 18:47:42 +0800
Message-ID: <20200914104742.1745082-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As we test disk offline/online with running fsstress, we find fsstress
process is keeping running state.
kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
....
kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114

ext4_mb_new_blocks
repeat:
        ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
                freed = ext4_mb_discard_preallocations
                        ext4_mb_discard_group_preallocations
                                this_cpu_inc(discard_pa_seq);
                ---> freed == 0
                seq_retry = ext4_get_discard_pa_seq_sum
                        for_each_possible_cpu(__cpu)
                                __seq += per_cpu(discard_pa_seq, __cpu);
                if (seq_retry != *seq) {
                        *seq = seq_retry;
                        ret = true;
                }

As we see seq_retry is sum of discard_pa_seq every cpu, if
ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
cpu maybe increase one, so condition "seq_retry != *seq" have always
been met.
Ritesh Harjani suggest to in ext4_mb_discard_group_preallocations function we
only increase discard_pa_seq when there is some PA to free.

Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mballoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..ff47347012f4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4189,7 +4189,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	INIT_LIST_HEAD(&list);
 repeat:
 	ext4_lock_group(sb, group);
-	this_cpu_inc(discard_pa_seq);
 	list_for_each_entry_safe(pa, tmp,
 				&grp->bb_prealloc_list, pa_group_list) {
 		spin_lock(&pa->pa_lock);
@@ -4206,6 +4205,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		/* seems this one can be freed ... */
 		ext4_mb_mark_pa_deleted(sb, pa);
 
+		if (!free)
+			this_cpu_inc(discard_pa_seq);
+
 		/* we can trust pa_free ... */
 		free += pa->pa_free;
 
-- 
2.25.4

