Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA0263B32
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Sep 2020 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIJDJx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Sep 2020 23:09:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbgIJDIx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 9 Sep 2020 23:08:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AE58CEA07DC70774B83;
        Thu, 10 Sep 2020 11:08:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 11:08:43 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2] ext4: Fix dead loop in ext4_mb_new_blocks
Date:   Thu, 10 Sep 2020 11:08:06 +0800
Message-ID: <20200910030806.223411-1-yebin10@huawei.com>
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
To Fix this problem, ext4_get_discard_pa_seq_sum function couldn't add
own's cpu "discard_pa_seq" value.

Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..f386fe62727d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -372,11 +372,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 static DEFINE_PER_CPU(u64, discard_pa_seq);
 static inline u64 ext4_get_discard_pa_seq_sum(void)
 {
-	int __cpu;
+	int __cpu, this_cpu;
 	u64 __seq = 0;
 
+	this_cpu = smp_processor_id();
 	for_each_possible_cpu(__cpu)
-		__seq += per_cpu(discard_pa_seq, __cpu);
+		if (this_cpu != __cpu)
+			__seq += per_cpu(discard_pa_seq, __cpu);
 	return __seq;
 }
 
-- 
2.25.4

