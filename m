Return-Path: <linux-ext4+bounces-3707-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D389950491
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D1AB2802E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A02199398;
	Tue, 13 Aug 2024 12:10:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB7199381;
	Tue, 13 Aug 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551018; cv=none; b=CJMv3oeOgAUOOlvyXsjLvDSZk5cmWv8Zg5iXrOY9LVrmtTR9T9v89Z/J6U/8N6JRqV1CPCUo0r4Padhfuo0JtnFEsCTgOh5z8YolIvAK8af3a7apadqWZaUl+DgiXx23BAaf5TkXLg0AqNeyu2rl8woKyG/1Luybv2NWOf0TF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551018; c=relaxed/simple;
	bh=4+JwmEywB2twePl4a6aS2KtUCCJuJ+Jo9YEkl6zHl3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHTDRj766LQO45wWHrTuoD5j5UbLKQsixl20efbQ45Tf/hfLT5VSSoIehKxycIke/G329xrfqg9AkWG60wdygAshY4NA4X8YeasovW2ZeoIlyFFsOpSosb4VDvTbSpKFnpS9lKlz5jg5DtfjeoG5uFXK+36W/qp53QW+6Pe3HyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjqvT6g3Mz4f3n5l;
	Tue, 13 Aug 2024 20:09:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9456F1A07B6;
	Tue, 13 Aug 2024 20:10:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDnl7YhTbtmPh4XBg--.33191S9;
	Tue, 13 Aug 2024 20:10:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] ext4: check buffer_verified in advance to avoid unneeded ext4_get_group_info
Date: Tue, 13 Aug 2024 20:07:12 +0800
Message-Id: <20240813120712.2592310-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
References: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnl7YhTbtmPh4XBg--.33191S9
X-Coremail-Antispam: 1UD129KBjvdXoWrtFykXw1fWF13Gry3ArWDArb_yoW3ZFbEka
	4kAa1kC3yfJwn7CF4vk3yYyr48KFWkXr15GFWftF13uF1UJFyrZ3ykArnxAFs7ua17JF1D
	K3Z7ZFW7tr4IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Check buffer_verified in advance to avoid unneeded ext4_get_group_info.
This could be a simple cleanup as complier may handle this.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ialloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 0cb109037384..e700236303cd 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -87,10 +87,10 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
 
-	grp = ext4_get_group_info(sb, block_group);
-
 	if (buffer_verified(bh))
 		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 	if (!grp || EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 		return -EFSCORRUPTED;
 
-- 
2.30.0


