Return-Path: <linux-ext4+bounces-3798-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C324A9587E4
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8058D284B54
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43338192B83;
	Tue, 20 Aug 2024 13:25:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E37192B82;
	Tue, 20 Aug 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160355; cv=none; b=Yw7lmZe7nIKpEWOb+dZhE9k+M+L06+HiJaeQqcuzmBzfNClX061BTwthgRQ5p6rcm3yrNKSuSTGXF0D3QvZaFyAeZe7AVfAUfQCGibJGUfjIrSyoRBmG7/gdkM0rIXA0CDNvsKjAH3nJKrPZsf9UUSuVHNMLSGZnx7DEQhNwbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160355; c=relaxed/simple;
	bh=ls/H6HuoT7WVtmZj+++LInXvh93hRW9SojjxrJ0niu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JktejmnhPnlJw1YUl1XhTFoaSFqu1IOOW9mVLrpE4q2BM7QpB+/UD4LHIr40AU7R26HSLtCqC8kwkuKrkoxmZICS0XYK+FLs0dbq+0uiByb2t1SUwXCg7+a0tRdDHeG+jOEjlxAHKJ/RSVOLySFtBKNDAeC3q+BgYqUObP7SaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wp9FQ5P12z4f3jdL;
	Tue, 20 Aug 2024 21:25:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D7AD71A0359;
	Tue, 20 Aug 2024 21:25:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgDH_bxWmcRmD7_dCA--.4366S3;
	Tue, 20 Aug 2024 21:25:44 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: harshadshirwadkar@gmail.com,
	darrick.wong@oracle.com,
	akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used()
Date: Tue, 20 Aug 2024 21:22:28 +0800
Message-Id: <20240820132234.2759926-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDH_bxWmcRmD7_dCA--.4366S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4UArW8AF17uF4fWF1UGFg_yoWkCFg_u3
	97Ar18J3yruwn3GF4vvrs8ArZ2kay0k3WrWFs5ta43Zws8t395uryDZrnxAr97uwsIvrn8
	AasFvry3JrWFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb8n5UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Release inode_bitmap_bh from ext4_read_inode_bitmap() in
ext4_mark_inode_used() to avoid buffer_head leak.
By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
is NULL.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ialloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9dfd768ed9f8..ad7f13976dc6 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -755,10 +755,10 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 	struct ext4_group_desc *gdp;
 	ext4_group_t group;
 	int bit;
-	int err = -EFSCORRUPTED;
+	int err;
 
 	if (ino < EXT4_FIRST_INO(sb) || ino > max_ino)
-		goto out;
+		return -EFSCORRUPTED;
 
 	group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
@@ -860,6 +860,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 	err = ext4_handle_dirty_metadata(NULL, NULL, group_desc_bh);
 	sync_dirty_buffer(group_desc_bh);
 out:
+	brelse(inode_bitmap_bh);
 	return err;
 }
 
-- 
2.30.0


