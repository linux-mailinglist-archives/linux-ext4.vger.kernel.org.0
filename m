Return-Path: <linux-ext4+bounces-9499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DFB2FB5B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F607622EC8
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376B2EC554;
	Thu, 21 Aug 2025 13:47:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B452EC546;
	Thu, 21 Aug 2025 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784040; cv=none; b=pDL4nGhjUB4AiFGm0TF529ct4H3PFoMAQCG4lu10yPZLQtBZgr7fHRK9KU0CvEvEkAk+3iytOsY3TzqNQoo6aVbeDS5huPUfRv44H63K8EMezgfhDkyay55hihl7QVc79nvBjvN/QqB56ob8PP7BoMc2UGAMJ5lAqmBFKmCAWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784040; c=relaxed/simple;
	bh=3ZVNvqFDjJxm5ZzDqKpS6MfeIKDwhSVa/QX5wPdQnss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nuHFI+jqUXtNtn4eF83NVIPz4J+XtH/PD1HVolu/tbaaGbZmI5xmjH/3aT2YVgV/XNdEyCLJNcCQauHtIdKEeVIJO8q9mvFna+Ce5VDzh8rOAIJ2xM986K/M8Q+9Wj+9oFC+etfYXqP3NUQrlzNpWP2UNB5Ot7Su5g122uB2SqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c74PZ4R0mzKHMVZ;
	Thu, 21 Aug 2025 21:47:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1DE0A1A1D5D;
	Thu, 21 Aug 2025 21:47:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxRgI6doV1LFEQ--.11929S4;
	Thu, 21 Aug 2025 21:47:13 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH] ext4: add ext4_sb_bread_nofail() helper function for ext4_free_branches()
Date: Thu, 21 Aug 2025 21:38:57 +0800
Message-Id: <20250821133857.80542-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxRgI6doV1LFEQ--.11929S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyDZw1ftF43Zr15JFyUtrb_yoW5Ww4fpw
	n8CFyxCrWj93Wq9anxKa13tw1fAw4IkF1DGa4I9398XrW5X3savFyUtF15KFyjvFW3Xrsx
	XF1jk34fAr1fCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAFBWikJ3MK3AACsN

From: Baokun Li <libaokun1@huawei.com>

The implicit __GFP_NOFAIL flag in ext4_sb_bread() was removed in commit
8a83ac54940d ("ext4: call bdev_getblk() from sb_getblk_gfp()"), meaning
the function can now fail under memory pressure.

Most callers of ext4_sb_bread() propagate the error to userspace and do not
remount the filesystem read-only. However, ext4_free_branches() handles
ext4_sb_bread() failure by remounting the filesystem read-only.

This implies that an ext3 filesystem (mounted via the ext4 driver) could be
forcibly remounted read-only due to a transient page allocation failure,
which is unacceptable.

To mitigate this, introduce a new helper function, ext4_sb_bread_nofail(),
which explicitly uses __GFP_NOFAIL, and use it in ext4_free_branches().

Fixes: 8a83ac54940d ("ext4: call bdev_getblk() from sb_getblk_gfp()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h     | 2 ++
 fs/ext4/indirect.c | 2 +-
 fs/ext4/super.c    | 9 +++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 106484739932..32315e51639e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3134,6 +3134,8 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, blk_opf_t op_flags);
 extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 						   sector_t block);
+extern struct buffer_head *ext4_sb_bread_nofail(struct super_block *sb,
+						sector_t block);
 extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 				bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 7de327fa7b1c..39350a18e919 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1025,7 +1025,7 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			}
 
 			/* Go read the buffer for the next level down */
-			bh = ext4_sb_bread(inode->i_sb, nr, 0);
+			bh = ext4_sb_bread_nofail(inode->i_sb, nr);
 
 			/*
 			 * A read failure? Report error and clear slot
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..a0e2b396aa76 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -265,6 +265,15 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
 }
 
+struct buffer_head *ext4_sb_bread_nofail(struct super_block *sb,
+					 sector_t block)
+{
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_mapping,
+			~__GFP_FS) | __GFP_MOVABLE | __GFP_NOFAIL;
+
+	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
+}
+
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
 	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
-- 
2.39.2


