Return-Path: <linux-ext4+bounces-11667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416CC40755
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C275D1A41F28
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F5335BBB;
	Fri,  7 Nov 2025 14:51:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0423346AC;
	Fri,  7 Nov 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527098; cv=none; b=DCnTAW/TkgmZDbUFVjBU4YY3Xj+q6en1d5JLXLqGiEpzysqOaTSxHC2Mc+PDww8AM6Ag4Fhe9HzDotYfmp2kDS8Mx0AwNlKyZR1Erdw8A4kA8RmZ+wAz2v0pjBk+vuIlJpJwzIfslTNh3rKPwRSY/zUy6Z5Pql2g/mm6YvvJH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527098; c=relaxed/simple;
	bh=pvBN5x2VZnYxpaX3ch26zWwZEePiM0O7XP3ruFG8nrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nL6xbPBiFyOSuC2UzPM+1/lStAwzIcEm+0VSA3aSUg10Vf/kvfgHbNi4hHeKwE/NBAjNwlYr28cYJ+DJMfG4tModLTiREZU8mishMQ0+zNKZVZe2NADboFu+uh2KTb3XhfiCliKy68rgSJCw7u49SjzBI5tJcGyFXClslP2ucpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d327P3wNRzKHMgC;
	Fri,  7 Nov 2025 22:51:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D50EB1A0EC1;
	Fri,  7 Nov 2025 22:51:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S11;
	Fri, 07 Nov 2025 22:51:23 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	mcgrof@kernel.org,
	ebiggers@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH v2 07/24] ext4: support large block size in ext4_calculate_overhead()
Date: Fri,  7 Nov 2025 22:42:32 +0800
Message-Id: <20251107144249.435029-8-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251107144249.435029-1-libaokun@huaweicloud.com>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S11
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DZw47ZFWUuFW5Kw1kAFb_yoW8Xw4Up3
	Z3WryxCrWruF1DuanruFZrJF4xKa97CFyUKFWa9343Zry7t3s3ur9xKFyYqFWIqFWxury0
	v3WYgrWxZr15G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBWkNxrAU1wADsQ

From: Baokun Li <libaokun1@huawei.com>

ext4_calculate_overhead() used a single page for its bitmap buffer, which
worked fine when PAGE_SIZE >= block size. However, with block size greater
than page size (BS > PS) support, the bitmap can exceed a single page.

To address this, we now use kvmalloc() to allocate memory of the filesystem
block size, to properly support BS > PS.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a6314a3de51d..0d32370a459a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4189,7 +4189,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	ext4_fsblk_t overhead = 0;
-	char *buf = (char *) get_zeroed_page(GFP_NOFS);
+	char *buf = kvmalloc(sb->s_blocksize, GFP_NOFS | __GFP_ZERO);
 
 	if (!buf)
 		return -ENOMEM;
@@ -4214,7 +4214,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 		blks = count_overhead(sb, i, buf);
 		overhead += blks;
 		if (blks)
-			memset(buf, 0, PAGE_SIZE);
+			memset(buf, 0, sb->s_blocksize);
 		cond_resched();
 	}
 
@@ -4237,7 +4237,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	}
 	sbi->s_overhead = overhead;
 	smp_wmb();
-	free_page((unsigned long) buf);
+	kvfree(buf);
 	return 0;
 }
 
-- 
2.46.1


