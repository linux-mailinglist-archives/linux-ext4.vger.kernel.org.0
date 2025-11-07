Return-Path: <linux-ext4+bounces-11674-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA8C40782
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64CC4F458B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DD33B6EE;
	Fri,  7 Nov 2025 14:51:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD38335BA7;
	Fri,  7 Nov 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527101; cv=none; b=UsfWSyP6jaVarxFJy295MYKdOClgiIgqLAAlCUlzNbiTfqrASc/W1SJ7jJiKelJVpYvgqAsrnCTwinSrnfPGOeXMEgwZ73npw3U7HuSLI+eaMf1ErXA6fCCG+HZAibDpGaqq3W06zUgd9UNSEFERdqqR1rdNmjy+pNPdEopGnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527101; c=relaxed/simple;
	bh=NWAt1HfknmCPeplhlbAFfGZ8z9hcDfoHPGqllS04XFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7CdGGFA0QE0RuZ7pDyE/btIsj3iz6rBWilbxiqtv/JA8Y7NyCrxGxKQWHEG/yi1Ee8Wt9PfyI9gYnSyrVJXQdM8KRLyxvEtR/Ian0FfdVqj9wChRL3zHzEbualFMzcZO+hCNVyyRDuHnfDEsQ2+Q2FVKwMkTdK+zRGV9tZO1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d327Q5k6FzKHMjd;
	Fri,  7 Nov 2025 22:51:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 218631A1A6D;
	Fri,  7 Nov 2025 22:51:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S27;
	Fri, 07 Nov 2025 22:51:24 +0800 (CST)
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
Subject: [PATCH v2 23/24] ext4: add checks for large folio incompatibilities when BS > PS
Date: Fri,  7 Nov 2025 22:42:48 +0800
Message-Id: <20251107144249.435029-24-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S27
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4fAw4fXF4fCFWkur45Jrb_yoW7Xw47pF
	W3CryfZrW8Zr97Wws7tFsrXr1Ykay8tayUJw4xu3WxJ345t34IyFW0vF1ayFyUtrWUXryx
	Xa1Utry29r1DGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBWkNxrAU4QADsm

From: Baokun Li <libaokun1@huawei.com>

Supporting a block size greater than the page size (BS > PS) requires
support for large folios. However, several features (e.g., encrypt)
do not yet support large folios.

To prevent conflicts, this patch adds checks at mount time to prohibit
these features from being used when BS > PS. Since these features cannot
be changed on remount, there is no need to check on remount.

This patch adds s_max_folio_order, initialized during mount according to
filesystem features and mount options. If s_max_folio_order is 0, large
folios are disabled.

With this in place, ext4_set_inode_mapping_order() can be simplified by
checking s_max_folio_order, avoiding redundant checks.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h  |  4 +++-
 fs/ext4/inode.c | 39 ++++++++++-----------------------------
 fs/ext4/super.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4bc0b2b7288a..79dc231d6e22 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1696,7 +1696,9 @@ struct ext4_sb_info {
 	unsigned long s_last_trim_minblks;
 
 	/* minimum folio order of a page cache allocation */
-	unsigned int s_min_folio_order;
+	u16 s_min_folio_order;
+	/* supported maximum folio order, 0 means not supported */
+	u16 s_max_folio_order;
 
 	/* Precomputed FS UUID checksum for seeding other checksums */
 	__u32 s_csum_seed;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b95826e4a419..d53dc5b794d4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5146,42 +5146,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
 	return -EFSCORRUPTED;
 }
 
-static bool ext4_should_enable_large_folio(struct inode *inode)
+void ext4_set_inode_mapping_order(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	u16 min_order, max_order;
 
-	if (!S_ISREG(inode->i_mode))
-		return false;
-	if (ext4_has_feature_encrypt(sb))
-		return false;
-
-	return true;
-}
-
-/*
- * Limit the maximum folio order to 2048 blocks to prevent overestimation
- * of reserve handle credits during the folio writeback in environments
- * where the PAGE_SIZE exceeds 4KB.
- */
-#define EXT4_MAX_PAGECACHE_ORDER(i)		\
-		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
-void ext4_set_inode_mapping_order(struct inode *inode)
-{
-	u32 max_order;
+	max_order = EXT4_SB(sb)->s_max_folio_order;
+	if (!max_order)
+		return;
 
-	if (!ext4_should_enable_large_folio(inode))
+	min_order = EXT4_SB(sb)->s_min_folio_order;
+	if (!min_order && !S_ISREG(inode->i_mode))
 		return;
 
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
-	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) ||
-	    ext4_has_feature_verity(inode->i_sb))
-		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
-	else
-		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
+	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
+		max_order = min_order;
 
-	mapping_set_folio_order_range(inode->i_mapping,
-				      EXT4_SB(inode->i_sb)->s_min_folio_order,
-				      max_order);
+	mapping_set_folio_order_range(inode->i_mapping, min_order, max_order);
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0d32370a459a..6735152dd219 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5040,6 +5040,43 @@ static const char *ext4_has_journal_option(struct super_block *sb)
 	return NULL;
 }
 
+/*
+ * Limit the maximum folio order to 2048 blocks to prevent overestimation
+ * of reserve handle credits during the folio writeback in environments
+ * where the PAGE_SIZE exceeds 4KB.
+ */
+#define EXT4_MAX_PAGECACHE_ORDER(sb)		\
+		umin(MAX_PAGECACHE_ORDER, (11 + (sb)->s_blocksize_bits - PAGE_SHIFT))
+static void ext4_set_max_mapping_order(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		sbi->s_max_folio_order = sbi->s_min_folio_order;
+	else if (ext4_has_feature_verity(sb))
+		sbi->s_max_folio_order = sbi->s_min_folio_order;
+	else
+		sbi->s_max_folio_order = EXT4_MAX_PAGECACHE_ORDER(sb);
+}
+
+static int ext4_check_large_folio(struct super_block *sb)
+{
+	const char *err_str = NULL;
+
+	if (ext4_has_feature_encrypt(sb))
+		err_str = "encrypt";
+
+	if (!err_str) {
+		ext4_set_max_mapping_order(sb);
+	} else if (sb->s_blocksize > PAGE_SIZE) {
+		ext4_msg(sb, KERN_ERR, "bs(%lu) > ps(%lu) unsupported for %s",
+			 sb->s_blocksize, PAGE_SIZE, err_str);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 			   int silent)
 {
@@ -5316,6 +5353,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	ext4_apply_options(fc, sb);
 
+	err = ext4_check_large_folio(sb);
+	if (err < 0)
+		goto failed_mount;
+
 	err = ext4_encoding_init(sb, es);
 	if (err)
 		goto failed_mount;
-- 
2.46.1


