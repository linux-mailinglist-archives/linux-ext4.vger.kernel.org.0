Return-Path: <linux-ext4+bounces-11768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C825AC4E85C
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21ED54F48FD
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D330EF86;
	Tue, 11 Nov 2025 14:35:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409FF2DC791;
	Tue, 11 Nov 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871731; cv=none; b=f8RRbkIyP7SVW/DRWaxP4DU7CfHj1xWOtWmal3UFKGBOqHOipHlvws6Fm0eA9nhwXxfpO8+ZOQsl462KNxJwwwJUjrjuOAemb4N85n9x1SAUvSNN2plh5vqwhd0MbgLJBYS6PgbHWkciTJcRFHz5itXG7I2TFQkrMLzy+Gd0kaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871731; c=relaxed/simple;
	bh=PAq48xhpNfbZiBhJxNmVlz2A4X/rr2K55fdYckxZBQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4Ct8YH1G64rzHFGULy1uIXmZYK5c1p6n9xCPHAm3XBN/sDpWFTap8Y8RL6t2cjJR2G9lkl+lqZ9ohwWMfsXTKZmAMsIiqmJnSplhBAwYmAaAva7bWeYm302M6o8f0nmIQPE1wFNilZrQPpzwnoyVFoCOYGVpe2IZcTK4XwFT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5Tb30hNJzKHMQB;
	Tue, 11 Nov 2025 22:35:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 47B191A0DD8;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S10;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
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
	libaokun@huaweicloud.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 06/24] ext4: introduce s_min_folio_order for future BS > PS support
Date: Tue, 11 Nov 2025 22:26:16 +0800
Message-Id: <20251111142634.3301616-7-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251111142634.3301616-1-libaokun@huaweicloud.com>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfJFyxtr4xKFyrCw13CFg_yoW8Kw45pF
	nxCFyfGrW8Zry8uFs2gFsrX348Kay8KayUXr4a9w15urWaq3409r1DtF1UAFWYqrW8JFWS
	qF1UKry7Cr13C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUo0PSUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWkSsJdDIQAAsz

From: Baokun Li <libaokun1@huawei.com>

This commit introduces the s_min_folio_order field to the ext4_sb_info
structure. This field will store the minimum folio order required by the
current filesystem, laying groundwork for future support of block sizes
greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ext4/ext4.h  |  3 +++
 fs/ext4/inode.c |  3 ++-
 fs/ext4/super.c | 10 +++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3d18e6bf43cf..6fe8cc3bf9a5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1688,6 +1688,9 @@ struct ext4_sb_info {
 	/* record the last minlen when FITRIM is called. */
 	unsigned long s_last_trim_minblks;
 
+	/* minimum folio order of a page cache allocation */
+	unsigned int s_min_folio_order;
+
 	/* Precomputed FS UUID checksum for seeding other checksums */
 	__u32 s_csum_seed;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6fec3aa2268a..9faa0cf77075 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5181,7 +5181,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
 	if (!ext4_should_enable_large_folio(inode))
 		return;
 
-	mapping_set_folio_order_range(inode->i_mapping, 0,
+	mapping_set_folio_order_range(inode->i_mapping,
+				      EXT4_SB(inode->i_sb)->s_min_folio_order,
 				      EXT4_MAX_PAGECACHE_ORDER(inode));
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a9fa824487f9..a6314a3de51d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5107,11 +5107,8 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	 * If the default block size is not the same as the real block size,
 	 * we need to reload it.
 	 */
-	if (sb->s_blocksize == blocksize) {
-		*lsb = logical_sb_block;
-		sbi->s_sbh = bh;
-		return 0;
-	}
+	if (sb->s_blocksize == blocksize)
+		goto success;
 
 	/*
 	 * bh must be released before kill_bdev(), otherwise
@@ -5142,6 +5139,9 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 		ext4_msg(sb, KERN_ERR, "Magic mismatch, very weird!");
 		goto out;
 	}
+
+success:
+	sbi->s_min_folio_order = get_order(blocksize);
 	*lsb = logical_sb_block;
 	sbi->s_sbh = bh;
 	return 0;
-- 
2.46.1


