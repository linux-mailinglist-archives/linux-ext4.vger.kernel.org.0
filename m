Return-Path: <linux-ext4+bounces-11976-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBBC7819B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 892A934477E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617C340DBC;
	Fri, 21 Nov 2025 09:16:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33B23E325;
	Fri, 21 Nov 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716612; cv=none; b=StiLuEYsP5ApQ2Y5Su904rOuQzyiZW8+FEVF7FyFvvZKBe/vHrRPLvIhToQXhVDx9TahopHlV45fbt4Bf16tycaTLfcORoDLlrQExTOSwDtKW5a/kUHu8bwsHzoyrs/R+w4SwbJ6HylZ/UsCS/eXPSqqv4iFfII19cjCgLnIi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716612; c=relaxed/simple;
	bh=CjAZGCBsF0Gl5HD+1R0WQsk0tmGxw4N/8p/Heky+Ukg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNqxq16dZM0lZx1Kn0F5Jnfdbv4y2GuMPT9xgxubUEaCFiDp53wH2g37EQPl/08Qn79PHgxo2STqZzvWxD+f8JRQHa3hg8COMsj0JJ2tU/7cvLx6BTjKBASly+B+6Wyu+z7hHoTBpmgQ2YrW6ih6AEbyKk1bwSl7PXIQjTg98o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCV2N1JzRzKHMvS;
	Fri, 21 Nov 2025 17:16:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 25CB61A07BB;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S11;
	Fri, 21 Nov 2025 17:16:42 +0800 (CST)
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
Subject: [PATCH v4 07/24] ext4: support large block size in ext4_calculate_overhead()
Date: Fri, 21 Nov 2025 17:06:37 +0800
Message-Id: <20251121090654.631996-8-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S11
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DZw47ZFWUuFW5Kw1kAFb_yoW8Wryrp3
	Z3WryxArWruFWDuanruFZrJF48K3WxCFyUKFWa9343Zry7tw1fury3KFyYqr4xXFWxuryS
	v3WUKrWxZr15J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQATBWkf35kfEwAAsr

From: Baokun Li <libaokun1@huawei.com>

ext4_calculate_overhead() used a single page for its bitmap buffer, which
worked fine when PAGE_SIZE >= block size. However, with block size greater
than page size (BS > PS) support, the bitmap can exceed a single page.

To address this, we now use kvmalloc() to allocate memory of the filesystem
block size, to properly support BS > PS.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2286cd1e3cb8..998ddce49093 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4191,7 +4191,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	ext4_fsblk_t overhead = 0;
-	char *buf = (char *) get_zeroed_page(GFP_NOFS);
+	char *buf = kvmalloc(sb->s_blocksize, GFP_NOFS | __GFP_ZERO);
 
 	if (!buf)
 		return -ENOMEM;
@@ -4216,7 +4216,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 		blks = count_overhead(sb, i, buf);
 		overhead += blks;
 		if (blks)
-			memset(buf, 0, PAGE_SIZE);
+			memset(buf, 0, sb->s_blocksize);
 		cond_resched();
 	}
 
@@ -4239,7 +4239,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	}
 	sbi->s_overhead = overhead;
 	smp_wmb();
-	free_page((unsigned long) buf);
+	kvfree(buf);
 	return 0;
 }
 
-- 
2.46.1


