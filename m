Return-Path: <linux-ext4+bounces-5758-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3A9F7311
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D318931BF
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E286347;
	Thu, 19 Dec 2024 03:02:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED611EA90;
	Thu, 19 Dec 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577349; cv=none; b=YqJERDgwhrNhJxOjkbsQbLAGFG+N8/FBYXxZGIOOZerI+tDNHBSHnSLxl3Fuv0uPzAehkx71bb8nM7I+5+PB4oNZl+Qld4aGALJ7/2Ucpp06U8ldiaImxuIe2mFtsqvJ0Qs0k/GLe/gfpghf54waUoAWLvVzUs+TiJIOOqpL5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577349; c=relaxed/simple;
	bh=nOrJFcJYLVFcmoUVY4GVB8jgP1zQjtf7+BZ3PWqOcDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhiPAFh64azXt0Za5J1bfhJOtdOwKbvq1r32TtexAqiqfgePr39JqrOYZNS/PLIyvYrdWJ88RJfFJ22SW85FNy89WTtFa5ATk1eQSXJ/w4zmsNPi9fEmGAaWe5+46S3zTzdjS9QGGX5nxo3QPq5od4d4T5f1YwERL1fRDO17VgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDFhC4TvJz4f3kFQ;
	Thu, 19 Dec 2024 11:02:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 28D9E1A07B6;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S4;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ext4: remove unneeded bits mask in dx_get_block()
Date: Thu, 19 Dec 2024 19:00:23 +0800
Message-Id: <20241219110027.1440876-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyfGrWrur15Aw13Gr1DGFg_yoWfKFbEya
	yDAr4xWF4fZ3ZakF1YyrW7trn5KF4F9F1UZa4fXryfZFn8JayfAw1DZrn8Z34DWa93Xa45
	CrnYvryUCr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-BMNUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

As high four bits of block in dx_entry is not used by any feature for now,
we can remove unneeded bits mask in dx_get_block() and add it back when
it's really needed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/namei.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index adec145b6f7d..8ff840ef4730 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -561,14 +561,9 @@ ext4_next_entry(struct ext4_dir_entry_2 *p, unsigned long blocksize)
 		ext4_rec_len_from_disk(p->rec_len, blocksize));
 }
 
-/*
- * Future: use high four bits of block for coalesce-on-delete flags
- * Mask them off for now.
- */
-
 static inline ext4_lblk_t dx_get_block(struct dx_entry *entry)
 {
-	return le32_to_cpu(entry->block) & 0x0fffffff;
+	return le32_to_cpu(entry->block);
 }
 
 static inline void dx_set_block(struct dx_entry *entry, ext4_lblk_t value)
-- 
2.30.0


