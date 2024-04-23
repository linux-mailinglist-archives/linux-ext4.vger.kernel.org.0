Return-Path: <linux-ext4+bounces-2156-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E638AE674
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7471F22430
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFAA12EBF7;
	Tue, 23 Apr 2024 12:40:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC112DDAC;
	Tue, 23 Apr 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876054; cv=none; b=tXjc9xPw/TzEMesm53YidtiM2hXxadwgTboFtJsjA1U1GACnKiRP22wOevoJthMp0XpdWJliG+8SvAjvxoKe/aY/w+j5gtiIzDFMg7KujVNmCwwkDhnKX/gLgqg4RIQmGVFCy7MHi2WPdbv1C1urLiP31Oi0xCTm1WJeO8KXpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876054; c=relaxed/simple;
	bh=xrcKKyueyRmWYlrLSjxKDPS0MeWA/AvpTFX4TJN6LYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npEVk7BBManodn9Hfy96lIy2/EZYSqxzJMOgybke2ox5jq6M8h9pOy8NX1lHeOzzJOWqoq/cUDQvITPBXhKhiNQNe23ejivnDZZsBM4R4v+NKcV+46n0M66g4og9cFofBWMJyoGusGT+3J5Ao/oy5Qd5rAikLGpsjIcDjZvQAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VP1th28Ykz4f3kp5;
	Tue, 23 Apr 2024 20:40:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 223591A0568;
	Tue, 23 Apr 2024 20:40:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3VQ5OrCdm2gAAKw--.9734S5;
	Tue, 23 Apr 2024 20:40:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v2 3/5] ext4: call ext4_mb_mark_free_simple to free continuous bits in found chunk
Date: Tue, 23 Apr 2024 20:40:44 +0800
Message-Id: <20240423124046.974134-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423124046.974134-1-shikemeng@huaweicloud.com>
References: <20240423124046.974134-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3VQ5OrCdm2gAAKw--.9734S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8Jr4rtr15tr17Cr1UAwb_yoW5Zr48pF
	43GrW3Gr4rJr929FsrCr1qg34rKw4vyFy5GayfWw1rKFnxAr9Yvr95GrnxZ34kJrWfJ3W0
	ya1UurW5Gw47Ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In mb_mark_used, we will find free chunk and mark it inuse. For chunk
in mid of passed range, we could simply mark whole chunk inuse. For chunk
at end of range, we may need to mark a continuous bits at end of part of
chunk inuse and keep rest part of chunk free. To only mark a part of
chunk inuse, we firstly mark whole chunk inuse and then mark a continuous
range at end of chunk free.
Function mb_mark_used does several times of "mb_find_buddy; mb_clear_bit;
..." to mark a continuous range free which can be done by simply calling
ext4_mb_mark_free_simple which free continuous bits in a more effective
way.
Just call ext4_mb_mark_free_simple in mb_mark_used to use existing and
effective code to free continuous blocks in chunk at end of passed range.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a61fc52956b2..5acf413808a2 100644
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
@@ -2094,20 +2089,29 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
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
+		/* first chunk */
+		if (start > ord_start)
+			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
+						 ord_start, start - ord_start,
+						 e4b->bd_info);
+
+		/* last chunk */
+		if (start + len < ord_end) {
+			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
+						 start + len,
+						 ord_end - (start + len),
+						 e4b->bd_info);
+			break;
+		}
+		len = start + len - ord_end;
+		start = ord_end;
 	}
 	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
 
-- 
2.30.0


