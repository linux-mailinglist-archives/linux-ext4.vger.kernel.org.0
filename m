Return-Path: <linux-ext4+bounces-3705-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A657B95048D
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2706EB27DB5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD019AD8E;
	Tue, 13 Aug 2024 12:10:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B1199230;
	Tue, 13 Aug 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551017; cv=none; b=pO5IA7HGfuaMN6L8URCOgG9JSa09XBz0kh1nijUzJmbpdM73BCAOsA59UjUi+pKUvrebGprl11YajYHGdXlRh1rx70rTYKHpkopQS8eFGGWcnb2iLhM8uVY6dKi3k2U5vaiCc77uc90Hqw8ze+hmvBHbZCtqdr/gbwynG141tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551017; c=relaxed/simple;
	bh=rS6N5KlkT98oXSzbXBnTmaAa8BGeGJKXKWr+rXkheGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrcrGVrLYB5qCuVuRqmAO4ZMj8CkpHODqYz5v3jqS+mlUhmem3Pzr/Q5KifZQvjCiGUX54krdWR5QahT/kqTdQ8Ak1WN94mKB9sdUO6VQv6IKocXx4zCceBK3FWW/us4f8V2YbTX8DzmbYohj7ZwFoe1Op+Wycb6Ag3ylveqWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjqvZ4qS7z4f3k6L;
	Tue, 13 Aug 2024 20:10:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F1B821A0E97;
	Tue, 13 Aug 2024 20:10:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDnl7YhTbtmPh4XBg--.33191S7;
	Tue, 13 Aug 2024 20:10:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] ext4: move checksum length calculation of inode bitmap into ext4_inode_bitmap_csum_[verify/set] functions
Date: Tue, 13 Aug 2024 20:07:10 +0800
Message-Id: <20240813120712.2592310-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDnl7YhTbtmPh4XBg--.33191S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xGrWkWw45urW7GFy8Krg_yoW7JFW3pa
	4DtF1UCr45ZFsF9r4xKryxZw18Kwn5KwsrWFWSkw13CFZrJwnYqFy8KFyUAa4ayF4kXFnF
	vr1Ykw47uw13W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjxU2CJmUUUUU
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
index f446588af368..39fcffe4c529 100644
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
 
@@ -1228,8 +1225,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
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


