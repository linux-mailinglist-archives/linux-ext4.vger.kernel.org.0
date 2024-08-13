Return-Path: <linux-ext4+bounces-3708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6C950494
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FD61C226CF
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0219CD16;
	Tue, 13 Aug 2024 12:10:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF71991DD;
	Tue, 13 Aug 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551018; cv=none; b=qnKDUmAOuXL+eDVTtLPEnD7nRys4BUWsnpJ0j3CkOZPwEqTMHjZAethFbJUBT3V71V6XWYiMFuxgZpJIUzcf8mJzYraSwKkn5gWX6BaOzWeVh4LiE5VAoqt31+zlv60MaqNTuJfFIfX1JKKLIh6Y8rLWQActs43X5ap9yrnaxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551018; c=relaxed/simple;
	bh=PUAzQnUbsgUKqfDjQJeuAgu4V1DNqjfTgDdRivntvj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plnQjaqdFrEtGhuBT29Y2DsNJCOOvqLTUku/oLBFs4XKnDdG1gaXyV0nLR97dNJb1KzrjFaEljCtpl89FjRJmCwIeaBKrrfEcCFpisAzlAaFVItJZfFmrYAzqcv/t3+LrayYXhyKETYJR2EJQ/hhS4aKrh1xSJno5hhLM4UGENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjqvS3m4Lz4f3m7P;
	Tue, 13 Aug 2024 20:09:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 328C71A0359;
	Tue, 13 Aug 2024 20:10:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDnl7YhTbtmPh4XBg--.33191S4;
	Tue, 13 Aug 2024 20:10:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ext4: avoid potential buffer_head leak in __ext4_new_inode
Date: Tue, 13 Aug 2024 20:07:07 +0800
Message-Id: <20240813120712.2592310-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDnl7YhTbtmPh4XBg--.33191S4
X-Coremail-Antispam: 1UD129KBjvJXoW7trW3GF45XF1UtFWxCFy3Jwb_yoW8Jw47pr
	sxKF1UKF4rXr1agrZ7K34FvFn5KFn7Ka17JF1Fyw1fWFsrtrnIgryfKFyUZ3WakrZ7XF1q
	qF9Ikr4UXr17ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUz-B_UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

If a group is marked EXT4_GROUP_INFO_IBITMAP_CORRUPT after it's inode
bitmap buffer_head was successfully verified, then __ext4_new_inode
will get a valid inode_bitmap_bh of a corrupted group from
ext4_read_inode_bitmap in which case inode_bitmap_bh misses a release.
Hnadle "IS_ERR(inode_bitmap_bh)" and group corruption separately like
how ext4_free_inode does to avoid buffer_head leak.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ialloc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index ad7f13976dc6..f24a238b6b09 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1054,9 +1054,13 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		brelse(inode_bitmap_bh);
 		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
 		/* Skip groups with suspicious inode tables */
-		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
-		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
-		    IS_ERR(inode_bitmap_bh)) {
+		if (IS_ERR(inode_bitmap_bh)) {
+			inode_bitmap_bh = NULL;
+			goto next_group;
+		}
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY) &&
+		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
+			brelse(inode_bitmap_bh);
 			inode_bitmap_bh = NULL;
 			goto next_group;
 		}
-- 
2.30.0


