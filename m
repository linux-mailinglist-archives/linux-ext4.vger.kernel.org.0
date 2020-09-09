Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11A926274C
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Sep 2020 08:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgIIGle (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Sep 2020 02:41:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbgIIGld (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 9 Sep 2020 02:41:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CCE7DA9A60B9AE5F801A;
        Wed,  9 Sep 2020 14:41:29 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 14:41:19 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] ext4: Fix dead loop in ext4_mb_new_blocks
Date:   Wed, 9 Sep 2020 14:40:42 +0800
Message-ID: <20200909064043.2034549-1-yebin10@huawei.com>
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

Test step:
1. sysctl kernel.panic_on_oops=1
2. mkfs.ext4 -O^has_journal /dev/sdc
3. mount /dev/sdc -o errors=continue test
4. ./fsstress -d ./test/ -l 1000 -n 1000000 -p 1 &
5. run test script:
while true; do
        echo offline > /sys/block/sda/device/state
        sleep 0.05
        echo running > /sys/block/sda/device/state
done

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
 fs/ext4/mballoc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..168ea3e65da2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -373,10 +373,12 @@ static DEFINE_PER_CPU(u64, discard_pa_seq);
 static inline u64 ext4_get_discard_pa_seq_sum(void)
 {
 	int __cpu;
+	int this_cpu = smp_processor_id();;
 	u64 __seq = 0;
 
 	for_each_possible_cpu(__cpu)
-		__seq += per_cpu(discard_pa_seq, __cpu);
+		if (this_cpu != __cpu)
+			__seq += per_cpu(discard_pa_seq, __cpu);
 	return __seq;
 }
 
-- 
2.25.4

