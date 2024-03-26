Return-Path: <linux-ext4+bounces-1754-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D188C3FE
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B273307621
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Mar 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CF12BEB5;
	Tue, 26 Mar 2024 13:42:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149B1272C8;
	Tue, 26 Mar 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460544; cv=none; b=IBI3fcRQug8SZ/SAzjtGdJZgwjqpzKG/wi/zy5X9r54e4nfkHTGVibzx1U00IJ6Kl89r8Qg6Ur1hvu3fIBfOa546sSfX4rwh2s2V1pMtg1Xtwg6KSWu8YhDAS9rH0Q3D1XjpRqYv+HEXAOSX2E0FYsSGyQ9mju2xoM7g5bex3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460544; c=relaxed/simple;
	bh=qva94EqQbwbclDVGd6PSU0SSsWbOGjVW93NiGTSeRWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhCpXqoj/wsDdoI6XFl70Vd6lS/02KJ6sUzAFgdYEdlDU4PtjcKu0xUBlv6KWq7eMo2B45MrnhukwcBcfOhO9ETBIQJkGgKKicL9BFrnEL+x3QANVhtOJVCe6fcKfKO9vS+sP4Ejuh3vJvVBg1ofBd3uNOpDd2ULVrcGhGiL99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3rZX5MtZz4f3jcn;
	Tue, 26 Mar 2024 21:42:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EABC51A0B26;
	Tue, 26 Mar 2024 21:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCHowy00AJmmQiSIA--.63567S5;
	Tue, 26 Mar 2024 21:42:18 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH 3/5] ext4: call ext4_mb_mark_free_simple in mb_mark_used to clear bits
Date: Wed, 27 Mar 2024 05:38:21 +0800
Message-Id: <20240326213823.528302-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240326213823.528302-1-shikemeng@huaweicloud.com>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHowy00AJmmQiSIA--.63567S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWxWw4fZF1fuF1furWfZrb_yoWrWr17pF
	W3ZrWfGr40vwn29F4UG3WjgF1F93y8ta45Jas3Ww1rWwnxJryFvFn5KF13Z3WvvrZ3XFyF
	yr4UuFy3Krs7KFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2FAJUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Function ext4_mb_mark_free_simple could search order for bit clearing in
O(1) cost while mb_mark_used will search order in O(distance from chunk
order to target order) and introduce unnecessary bit flips.

Consider we have 4 continuous free bits and going to mark bit 0-2 inuse.
initial state of buddy bitmap:
order 2 |           0           |
order 1 |     1     |     1     |
order 0 |  1  |  1  |  1  |  1  |

mark whole chunk inuse
order 2 |           1           |
order 1 |     1     |     1     |
order 0 |  1  |  1  |  1  |  1  |

split chunk to order 1
order 2 |           1           |
order 1 |     0     |     0     |
order 0 |  1  |  1  |  1  |  1  |

set the first bit in order 1 to mark bit 0-1 inuse
set the second bit in order 1 for split
order 2 |           1           |
order 1 |     1     |     1     |
order 0 |  1  |  1  |  1  |  1  |

step 3: split the second bit in order 1 to order 0
order 2 |           1           |
order 1 |     1     |     1     |
order 0 |  1  |  1  |  0  |  0  |

step 4: set the third bit in order 0 to mark bit 2 inuse.
order 2 |           1           |
order 1 |     1     |     1     |
order 0 |  1  |  1  |  1  |  0  |
There are two unnecessary splits and three unnecessary bit flips.

With ext4_mb_mark_free_simple, we will clear the 4th bit in order 0
with O(1) search and no extra bit flip.

The cost estimated by test_mb_mark_used_cost is as following:
Before (three runs of test):
    # test_mb_mark_used_cost: costed jiffies 311
    # test_mb_mark_used_cost: costed jiffies 304
    # test_mb_mark_used_cost: costed jiffies 305
    # test_mb_mark_used_cost: costed jiffies 323
    # test_mb_mark_used_cost: costed jiffies 317
    # test_mb_mark_used_cost: costed jiffies 317
After (three runs of test):
    # test_mb_mark_used_cost: costed jiffies 166
    # test_mb_mark_used_cost: costed jiffies 152
    # test_mb_mark_used_cost: costed jiffies 159
    # test_mb_mark_used_cost: costed jiffies 138
    # test_mb_mark_used_cost: costed jiffies 149

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a61fc52956b2..62d468379722 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2040,13 +2040,12 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	int ord;
 	int mlen = 0;
 	int max = 0;
-	int cur;
 	int start = ex->fe_start;
 	int len = ex->fe_len;
 	unsigned ret = 0;
 	int len0 = len;
 	void *buddy;
-	bool split = false;
+	int ord_start, ord_end;
 
 	BUG_ON(start + len > (e4b->bd_sb->s_blocksize << 3));
 	BUG_ON(e4b->bd_group != ex->fe_group);
@@ -2071,16 +2070,12 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 
 	/* let's maintain buddy itself */
 	while (len) {
-		if (!split)
-			ord = mb_find_order_for_block(e4b, start);
+		ord = mb_find_order_for_block(e4b, start);
 
 		if (((start >> ord) << ord) == start && len >= (1 << ord)) {
 			/* the whole chunk may be allocated at once! */
 			mlen = 1 << ord;
-			if (!split)
-				buddy = mb_find_buddy(e4b, ord, &max);
-			else
-				split = false;
+			buddy = mb_find_buddy(e4b, ord, &max);
 			BUG_ON((start >> ord) >= max);
 			mb_set_bit(start >> ord, buddy);
 			e4b->bd_info->bb_counters[ord]--;
@@ -2094,20 +2089,28 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 		if (ret == 0)
 			ret = len | (ord << 16);
 
-		/* we have to split large buddy */
 		BUG_ON(ord <= 0);
 		buddy = mb_find_buddy(e4b, ord, &max);
 		mb_set_bit(start >> ord, buddy);
 		e4b->bd_info->bb_counters[ord]--;
 
-		ord--;
-		cur = (start >> ord) & ~1U;
-		buddy = mb_find_buddy(e4b, ord, &max);
-		mb_clear_bit(cur, buddy);
-		mb_clear_bit(cur + 1, buddy);
-		e4b->bd_info->bb_counters[ord]++;
-		e4b->bd_info->bb_counters[ord]++;
-		split = true;
+		ord_start = (start >> ord) << ord;
+		ord_end = ord_start + (1 << ord);
+		if (start > ord_start)
+			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
+						 ord_start, start - ord_start,
+						 e4b->bd_info);
+
+		if (start + len < ord_end) {
+			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
+						 start + len,
+						 ord_end - (start + len),
+						 e4b->bd_info);
+			break;
+		}
+
+		len = start + len - ord_end;
+		start = ord_end;
 	}
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
 
-- 
2.30.0


