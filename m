Return-Path: <linux-ext4+bounces-11658-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FFC40707
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E5E189F75B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C532E6BB;
	Fri,  7 Nov 2025 14:51:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C932C954;
	Fri,  7 Nov 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527092; cv=none; b=MuTxVHBdvFvmnVH1TaW8WSjlt4v8bDiGGkyDglED7DBYb/pSJLtUxhfBAEsluxyxqoN6tsOmvDMm4WMokOpM5rbaCY+75yWSkPrPUF01oUTKDqc9IIYRQMui4RL81U/hYyB6JCc8N+HN2xeq+iwAyK7M3eGPZz7eGRCj1G9KWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527092; c=relaxed/simple;
	bh=fIV+cVATTFR98zuPxQgz18xkYBAgWR6arLVXE3PaQ7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2cXD3SLf5va67VO59PFVjDtkqzVa/Yn/PMN1Q5WY0/w6pqBiFc8199r9OEoFC3DKIdkJKBIShr5VmIlMqw+rbxne9kPPPi0iaKTkjzDafiuP3tDbdbSAgvIj7/oM6Mx0fOGEvPQJHDHWWW9JitHR7DM15LqNEvpPvZPl0RGbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d327D5X0QzYQv4M;
	Fri,  7 Nov 2025 22:51:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id ED5311A1A77;
	Fri,  7 Nov 2025 22:51:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S25;
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
Subject: [PATCH v2 21/24] ext4: make data=journal support large block size
Date: Fri,  7 Nov 2025 22:42:46 +0800
Message-Id: <20251107144249.435029-22-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S25
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1Utw1DJFW5Xw4xur4Uurg_yoW5tw1xpF
	y3Gry8J395ZFyq9w48tF47Zr1Yq3WfKayUAas3uFnxZws8J34IvF4jyFnxAFy5JrW8Wa1S
	qay0kr1UuanIkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBWkNxrAU4AAAsk

From: Baokun Li <libaokun1@huawei.com>

Currently, ext4_set_inode_mapping_order() does not set max folio order
for files with the data journalling flag. For files that already have
large folios enabled, ext4_inode_journal_mode() ignores the data
journalling flag once max folio order is set.

This is not because data journalling cannot work with large folios, but
because credit estimates will go through the roof if there are too many
blocks per folio.

Since the real constraint is blocks-per-folio, to support data=journal
under LBS, we now set max folio order to be equal to min folio order for
files with the journalling flag. When LBS is disabled, the max folio order
remains unset as before.

Additionally, the max_order check in ext4_inode_journal_mode() is removed,
and mapping order is reset in ext4_change_inode_journal_flag().

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4_jbd2.c |  3 +--
 fs/ext4/inode.c     | 14 ++++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index a0e66bc10093..05e5946ed9b3 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -16,8 +16,7 @@ int ext4_inode_journal_mode(struct inode *inode)
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
-	    !test_opt(inode->i_sb, DELALLOC) &&
-	    !mapping_large_folio_support(inode->i_mapping))) {
+	    !test_opt(inode->i_sb, DELALLOC))) {
 		/* We do not support data journalling for encrypted data */
 		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
 			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 22d215f90c64..517701024d18 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5152,9 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
-	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
-		return false;
 	if (ext4_has_feature_verity(sb))
 		return false;
 	if (ext4_has_feature_encrypt(sb))
@@ -5172,12 +5169,20 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
 void ext4_set_inode_mapping_order(struct inode *inode)
 {
+	u32 max_order;
+
 	if (!ext4_should_enable_large_folio(inode))
 		return;
 
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
+		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
+	else
+		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
+
 	mapping_set_folio_order_range(inode->i_mapping,
 				      EXT4_SB(inode->i_sb)->s_min_folio_order,
-				      EXT4_MAX_PAGECACHE_ORDER(inode));
+				      max_order);
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -6585,6 +6590,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
 	}
 	ext4_set_aops(inode);
+	ext4_set_inode_mapping_order(inode);
 
 	jbd2_journal_unlock_updates(journal);
 	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
-- 
2.46.1


