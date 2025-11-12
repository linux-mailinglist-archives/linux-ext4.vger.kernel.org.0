Return-Path: <linux-ext4+bounces-11822-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B089AC5244C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0DD64EC0A5
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8D33032C;
	Wed, 12 Nov 2025 12:30:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90D32ABC8
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950654; cv=none; b=qxpH3+0FQEtFpSJqvQST+LoTCet3x9u7HB8ioQb5iN4d0mjs2BFRTF0QqQ1tN/IAEZZREfkANQZZlYcdSeQw3PsB2KBsQd1QtjFWwuSCezgz2nA/a4krW70vjodJwXQvr5C+KU5hkn3p8yp5h7G5oN1jHM80ehd2ku1oVJ7l3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950654; c=relaxed/simple;
	bh=GjGae+cMtE5y8JLq7UUUxgl5VqSiPo8pi61uC/MiC1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ISu82MMW3ZLMOtbwGbuiYNcd906vvZ3y0Lqejjl2cYXuDSxqMnZPTqN7xTzdsgsapVp2RN8CXcnlfLDp9O9aCGnFQhp6yiuS2qiTZXgND2T844MhvyR3q9fWFCF5O0bav6z7JFs1F0SA8dvxg7RUSZwMoZGhwPxD1oUdBSSdiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d62mh6hNXzKHMVN
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 20:30:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7CF7E1A0359
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 20:30:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHv2fRRpHfX0AQ--.10209S4;
	Wed, 12 Nov 2025 20:30:46 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH e2fsprogs] libext2fs: fix orphan file size > kernel limit with large blocksize
Date: Wed, 12 Nov 2025 20:21:57 +0800
Message-Id: <20251112122157.1990595-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHv2fRRpHfX0AQ--.10209S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4rCw43ZrWkZrWkGr47XFb_yoW5AF1fp3
	W7JrZ5WF1j93W8WFn2ya17t34fWwn3Kw1UXayqvryFgFy5Jrs3Krsrt34YgFyDtrWIvFWv
	9Fs8JrW7trnrXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAKBWkUAgoOjwACs7

From: Baokun Li <libaokun1@huawei.com>

Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
limits the maximum supported orphan file size to 8 << 20.

However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
blocks when creating a filesystem.

With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
than the kernel allows, so mount prints an error and fails:

    EXT4-fs (vdb): orphan file too big: 8650752
    EXT4-fs (vdb): mount failed

Therefore, synchronize the kernel change to e2fsprogs to avoid creating
orphan files larger than the kernel limit.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 lib/ext2fs/ext2fs.h |  2 ++
 lib/ext2fs/orphan.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index bb2170b7..d9df007c 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1819,6 +1819,8 @@ errcode_t ext2fs_set_data_io(ext2_filsys fs, io_channel new_io);
 errcode_t ext2fs_rewrite_to_io(ext2_filsys fs, io_channel new_io);
 
 /* orphan.c */
+#define EXT4_MAX_ORPHAN_FILE_SIZE	8 << 20
+#define EXT4_DEFAULT_ORPHAN_FILE_SIZE	2 << 20
 extern errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks);
 extern errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs);
 extern e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs);
diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
index 14ac3569..40b1c5c7 100644
--- a/lib/ext2fs/orphan.c
+++ b/lib/ext2fs/orphan.c
@@ -164,6 +164,8 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
 	memset(zerobuf, 0, fs->blocksize);
 	ob_tail = ext2fs_orphan_block_tail(fs, buf);
 	ob_tail->ob_magic = ext2fs_cpu_to_le32(EXT4_ORPHAN_BLOCK_MAGIC);
+	if (num_blocks * fs->blocksize > EXT4_MAX_ORPHAN_FILE_SIZE)
+		num_blocks = EXT4_MAX_ORPHAN_FILE_SIZE / fs->blocksize;
 	oi.num_blocks = num_blocks;
 	oi.alloc_blocks = 0;
 	oi.last_blk = 0;
@@ -216,18 +218,18 @@ out:
 
 /*
  * Find reasonable size for orphan file. We choose orphan file size to be
- * between 32 and 512 filesystem blocks and not more than 1/4096 of the
- * filesystem unless it is really small.
+ * between 32 filesystem blocks and EXT4_DEFAULT_ORPHAN_FILE_SIZE, and not
+ * more than 1/fs->blocksize of the filesystem unless it is really small.
  */
 e2_blkcnt_t ext2fs_default_orphan_file_blocks(ext2_filsys fs)
 {
 	__u64 num_blocks = ext2fs_blocks_count(fs->super);
-	e2_blkcnt_t blks = 512;
+	e2_blkcnt_t blks = EXT4_DEFAULT_ORPHAN_FILE_SIZE / fs->blocksize;
 
 	if (num_blocks < 128 * 1024)
 		blks = 32;
-	else if (num_blocks < 2 * 1024 * 1024)
-		blks = num_blocks / 4096;
+	else if (num_blocks < EXT4_DEFAULT_ORPHAN_FILE_SIZE)
+		blks = num_blocks / fs->blocksize;
 	return (blks + EXT2FS_CLUSTER_MASK(fs)) & ~EXT2FS_CLUSTER_MASK(fs);
 }
 
-- 
2.46.1


