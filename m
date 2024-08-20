Return-Path: <linux-ext4+bounces-3796-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F079587DE
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 15:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D170B2268A
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012E191F88;
	Tue, 20 Aug 2024 13:25:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353318E370;
	Tue, 20 Aug 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160352; cv=none; b=LdPVBKQX2qhCEy3iklZcoxFT9QruWJH4WttBLYuadz+mRcfqueGAJ7323/opi0vqtPCmkjFdGWUlZoNQfKszBIUhgoviDOl43M8toBArdOAH5cOuEzU8wWqWZYK0dSTrN/VpR7NybwtD7c0qhiYr2XhFrqksLqzCbs3f8jGQARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160352; c=relaxed/simple;
	bh=3O/NuobT52t8UiEwWdkeeKmXlY1EshI1XwNj7Whed+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kN/Y/DO7K+tG1c/fJagLiKcuUztptLCJA+Nb9urxk8HYpMkNqVzc6nR3+aBgP+seTmOp+fSUwc/9pXUaVFG+QWH0URIc3GV3JCH+iuib/I+HvToxelAXPfdfWBFHaMTkRHIz6NenWGaE2Inort0MbPBi06a8HveO18xE6dEqJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp9FX5z6jz4f3kKp;
	Tue, 20 Aug 2024 21:25:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 731131A16E4;
	Tue, 20 Aug 2024 21:25:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgDH_bxWmcRmD7_dCA--.4366S7;
	Tue, 20 Aug 2024 21:25:46 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: harshadshirwadkar@gmail.com,
	darrick.wong@oracle.com,
	akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] ext4: move checksum length calculation of inode bitmap into ext4_inode_bitmap_csum_[verify/set]() functions
Date: Tue, 20 Aug 2024 21:22:32 +0800
Message-Id: <20240820132234.2759926-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDH_bxWmcRmD7_dCA--.4366S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xGrWkWw45urW7GFy8Krg_yoW7JFW3pa
	s8tF1UCr45ZFsF9r4xKryxZw18Kwn5KwsrWFWSkw13CFZrJwnYqFy8KFyUAa4ayF4kXFnI
	vr1Ykw47uw13W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

There are some little improve:
1. remove repeat code to calculate checksum length of inode bitmap
2. remove unnecessary checksum length calculation if checksum is not
enabled.
3. use more efficient bit shift operation instead of div opreation.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/bitmap.c |  8 ++++++--
 fs/ext4/ext4.h   |  4 ++--
 fs/ext4/ialloc.c | 12 ++++--------
 fs/ext4/resize.c |  3 +--
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index cd725bebe69e..2a135075468d 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -18,15 +18,17 @@ unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
 
 int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
-				  struct buffer_head *bh, int sz)
+				  struct buffer_head *bh)
 {
 	__u32 hi;
 	__u32 provided, calculated;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int sz;
 
 	if (!ext4_has_metadata_csum(sb))
 		return 1;
 
+	sz = EXT4_INODES_PER_GROUP(sb) >> 3;
 	provided = le16_to_cpu(gdp->bg_inode_bitmap_csum_lo);
 	calculated = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
 	if (sbi->s_desc_size >= EXT4_BG_INODE_BITMAP_CSUM_HI_END) {
@@ -40,14 +42,16 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 
 void ext4_inode_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
-				struct buffer_head *bh, int sz)
+				struct buffer_head *bh)
 {
 	__u32 csum;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int sz;
 
 	if (!ext4_has_metadata_csum(sb))
 		return;
 
+	sz = EXT4_INODES_PER_GROUP(sb) >> 3;
 	csum = ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)bh->b_data, sz);
 	gdp->bg_inode_bitmap_csum_lo = cpu_to_le16(csum & 0xFFFF);
 	if (sbi->s_desc_size >= EXT4_BG_INODE_BITMAP_CSUM_HI_END)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index efed7f09876d..7494b2abb794 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2693,10 +2693,10 @@ struct mmpd_data {
 extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
 void ext4_inode_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
-				struct buffer_head *bh, int sz);
+				struct buffer_head *bh);
 int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
-				  struct buffer_head *bh, int sz);
+				  struct buffer_head *bh);
 void ext4_block_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh);
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 8ee4754c70f5..0234f5e91d8d 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -98,8 +98,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 	if (buffer_verified(bh))
 		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
-	if (!ext4_inode_bitmap_csum_verify(sb, desc, bh,
-					   EXT4_INODES_PER_GROUP(sb) / 8) ||
+	if (!ext4_inode_bitmap_csum_verify(sb, desc, bh) ||
 	    ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_CRC)) {
 		ext4_unlock_group(sb, block_group);
 		ext4_error(sb, "Corrupt inode bitmap - block_group = %u, "
@@ -327,8 +326,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 		if (percpu_counter_initialized(&sbi->s_dirs_counter))
 			percpu_counter_dec(&sbi->s_dirs_counter);
 	}
-	ext4_inode_bitmap_csum_set(sb, gdp, bitmap_bh,
-				   EXT4_INODES_PER_GROUP(sb) / 8);
+	ext4_inode_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
@@ -853,8 +851,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 
 	ext4_free_inodes_set(sb, gdp, ext4_free_inodes_count(sb, gdp) - 1);
 	if (ext4_has_group_desc_csum(sb)) {
-		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh,
-					   EXT4_INODES_PER_GROUP(sb) / 8);
+		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh);
 		ext4_group_desc_csum_set(sb, group, gdp);
 	}
 
@@ -1225,8 +1222,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 	if (ext4_has_group_desc_csum(sb)) {
-		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh,
-					   EXT4_INODES_PER_GROUP(sb) / 8);
+		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh);
 		ext4_group_desc_csum_set(sb, group, gdp);
 	}
 	ext4_unlock_group(sb, group);
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 0ba9837d65ca..e04eb08b9060 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1319,8 +1319,7 @@ static int ext4_set_bitmap_checksums(struct super_block *sb,
 	bh = ext4_get_bitmap(sb, group_data->inode_bitmap);
 	if (!bh)
 		return -EIO;
-	ext4_inode_bitmap_csum_set(sb, gdp, bh,
-				   EXT4_INODES_PER_GROUP(sb) / 8);
+	ext4_inode_bitmap_csum_set(sb, gdp, bh);
 	brelse(bh);
 
 	bh = ext4_get_bitmap(sb, group_data->block_bitmap);
-- 
2.30.0


