Return-Path: <linux-ext4+bounces-3793-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1A9587D9
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 15:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7D5B22328
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2651917F0;
	Tue, 20 Aug 2024 13:25:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1719148A;
	Tue, 20 Aug 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160351; cv=none; b=Ao51WfIZZPq9zsceAw/hSXOJMsohmS0usApXj6kzz/Ury1AMMtsl0G1/ulrrIeUAPkhXLlTYcCSifVINuuewlCofovLPQv2Mn1vcVKm7r6U8svpl4u7nuNAp6hX1Ns/bt2+BJzqwZfc0Q2MduWgsAcVfznANcYjEAp2JUByIkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160351; c=relaxed/simple;
	bh=qpnhpFm0weNYC7/k5hGg8LzRwNYMYkE4Aw/jSOsakno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdfrMXZQKA4CuDvEaVOWRW5t30picsEH62iMxIYlqO+ROEZsk46KCi+zAbUbmVXjtT/w2NRqhpZQNAMohj43ng+DBHaKuyM1rs9uhcMHEjDV8aiSsVa5ziGUdSRkVK4f3vQ9A3MfbaQR2zl9tD8JP36aJQdFdSo0WjA7Dc4xlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp9FX3L35z4f3k6d;
	Tue, 20 Aug 2024 21:25:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 17F201A16E5;
	Tue, 20 Aug 2024 21:25:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgDH_bxWmcRmD7_dCA--.4366S6;
	Tue, 20 Aug 2024 21:25:45 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: harshadshirwadkar@gmail.com,
	darrick.wong@oracle.com,
	akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] ext4: remove dead check in __ext4_new_inode()
Date: Tue, 20 Aug 2024 21:22:31 +0800
Message-Id: <20240820132234.2759926-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240820132234.2759926-1-shikemeng@huaweicloud.com>
References: <20240820132234.2759926-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH_bxWmcRmD7_dCA--.4366S6
X-Coremail-Antispam: 1UD129KBjvdXoWruw43AF4xZw18Ar13uF4rXwb_yoWfKrX_G3
	ykta1kC3yYqan3Gayvqrs8tF4DKr48Gr15Wry3K34fZ3WktrWDCa1kAr43AFW3Wayqvr98
	uFW7Jry7tFyrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

If we can't grab any inode, the prvious find_inode_bit() will set ino
to be >= EXT4_INODES_PER_GROUP(sb). So the check of need to repeat
in the same group is not needed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ialloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 81641be38c0e..8ee4754c70f5 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1064,7 +1064,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 			goto next_group;
 
-repeat_in_this_group:
 		ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &ino);
 		if (!ret2)
 			goto next_group;
@@ -1114,8 +1113,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		if (!ret2)
 			goto got; /* we grabbed the inode! */
 
-		if (ino < EXT4_INODES_PER_GROUP(sb))
-			goto repeat_in_this_group;
 next_group:
 		if (++group == ngroups)
 			group = 0;
-- 
2.30.0


