Return-Path: <linux-ext4+bounces-12262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55FCB266B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 09:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6312C3022FEF
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0482FD7A7;
	Wed, 10 Dec 2025 08:26:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE32EE611
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355196; cv=none; b=myuGq0CiQlgjv2zb0SxhV7UFDDDJyvjxUpuQK6ViOY2efUceM943paiorGhRoknkw/PIaxkiplVVldsvKpu0I6k0FsYQI2zSEXH6zsX0gFUWWA4EwgKi1WG5dCMRyQ2OmwWbUcaaX7bGLXsteG7MdGcFhJPAFmbKYO8hMhCo1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355196; c=relaxed/simple;
	bh=dgQda72Oa06Dex9Csmekr/S8tpN4vjUHolTIYNKzj6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZoqgBU+X1hh3uOm1KygV1+4xUmD7wxvgGh4XkQk6mZirx7cbJzqq1SHB0ilS6FhtDJPtUx0qoM+mQs5tbDgnkVNL/Tm+Sehc8rZAFMQJfL9Ai2A9K/OhvgEpzBulIMdJwJNhDtzjjWrw47WI4Vv+uTu40LiIKr42JtzjWjSpx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dR8161S1zzKHMp9
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 16:25:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F108C1A1C48
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 16:26:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgAnVE61LjlpW472BA--.57045S4;
	Wed, 10 Dec 2025 16:26:29 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH e2fsprogs] lib/quota: fix checksum mismatch on uninitialized PRJQUOTA inode
Date: Wed, 10 Dec 2025 16:15:58 +0800
Message-Id: <20251210081558.2714709-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnVE61LjlpW472BA--.57045S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXw48Kw1fZr1DXr15tw4fKrg_yoW5uFWkpF
	Z2ga1Yqa45Gry2kF4vvr4rZr1fKFyIgr4UWr48Ga4Fyrn5Xrs5tF1rKa4FvF9xJrs5A34Y
	vF18C3WDWw1UWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
	F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUmD7-UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQARBWk4EuUJDwABs0

From: Baokun Li <libaokun1@huawei.com>

In quota_inode_init_new(), we attempt to read and truncate an existing
quota inode before proceeding with its initialization.

This read operation verifies the inode's checksum. This works fine for
USRQUOTA and GRPQUOTA inodes because write_reserved_inodes() is always
called during ext4 image creation to set appropriate checksums for these
reserved inodes.

However, the PRJQUOTA inode is not reserved, and its corresponding inode
table block may not have been zeroed, potentially containing stale data.
Consequently, reading this inode can fail due to a checksum mismatch.

This can be reproduced by running the following sequence:

  dd if=/dev/random of=$DISK bs=1M count=128
  mkfs.ext4 -F -q -b 1024 $DISK 5G
  tune2fs -O quota,project $DISK

Which results in the following error output:

 tune2fs 1.47.3 (8-Jul-2025)
 [ERROR] quotaio.c:279:quota_inode_init_new: ex2fs_read_inode failed
 [ERROR] quotaio.c:341:quota_file_create: init_new_quota_inode failed
 tune2fs: Inode checksum does not match inode while writing quota file (2)

While running `kvm-xfstests -c ext4/1k -C 1 generic/383`, the test itself
does not fail, but checksum verification failures are reported even
without fault injection, which led to discovering this issue.

To fix this, we stop attempting to read the quota inode that is about
to be initialized inside quota_inode_init_new(). Instead, the logic
to attempt truncation of an existing quota inode is moved to be handled
inside quota_file_create().

Fixes: 080e09b4 ("Add project quota support")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 lib/support/quotaio.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/lib/support/quotaio.c b/lib/support/quotaio.c
index f5f2c7f7..827df85b 100644
--- a/lib/support/quotaio.c
+++ b/lib/support/quotaio.c
@@ -274,18 +274,6 @@ static errcode_t quota_inode_init_new(ext2_filsys fs, ext2_ino_t ino)
 	errcode_t err = 0;
 	time_t now;
 
-	err = ext2fs_read_inode(fs, ino, &inode);
-	if (err) {
-		log_err("ex2fs_read_inode failed");
-		return err;
-	}
-
-	if (EXT2_I_SIZE(&inode)) {
-		err = quota_inode_truncate(fs, ino);
-		if (err)
-			return err;
-	}
-
 	memset(&inode, 0, sizeof(struct ext2_inode));
 	ext2fs_iblk_set(fs, &inode, 0);
 	now = fs->now ? fs->now : time(0);
@@ -319,6 +307,10 @@ errcode_t quota_file_create(struct quota_handle *h, ext2_filsys fs,
 	if (fmt == -1)
 		fmt = QFMT_VFS_V1;
 
+	err = ext2fs_read_bitmaps(fs);
+	if (err)
+		goto out_err;
+
 	h->qh_qf.fs = fs;
 	qf_inum = quota_type2inum(qtype, fs->super);
 	if (qf_inum == 0 && qtype == PRJQUOTA) {
@@ -330,15 +322,19 @@ errcode_t quota_file_create(struct quota_handle *h, ext2_filsys fs,
 		ext2fs_mark_ib_dirty(fs);
 	} else if (qf_inum == 0) {
 		return EXT2_ET_BAD_INODE_NUM;
+	} else {
+		err = quota_inode_truncate(fs, qf_inum);
+		if (err) {
+			log_err("quota_inode_truncate failed, ino=%u, type=%d",
+				qf_inum, qtype);
+			return err;
+		}
 	}
 
-	err = ext2fs_read_bitmaps(fs);
-	if (err)
-		goto out_err;
-
 	err = quota_inode_init_new(fs, qf_inum);
 	if (err) {
-		log_err("init_new_quota_inode failed");
+		log_err("init_new_quota_inode failed, ino=%u, type=%d",
+			qf_inum, qtype);
 		goto out_err;
 	}
 	h->qh_qf.ino = qf_inum;
-- 
2.46.1


