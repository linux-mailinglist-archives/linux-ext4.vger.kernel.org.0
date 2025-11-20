Return-Path: <linux-ext4+bounces-11940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AC6C747A5
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EED8C4F73EE
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CEC33DEEE;
	Thu, 20 Nov 2025 14:04:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA3292B4B;
	Thu, 20 Nov 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647485; cv=none; b=cTszvHDSCwlfcsgfHSaZYhPB3JR0sEi5e8HEhQ3XtMVwHiAE+e5ljlsg2Xbu5uXZA1EIdaE2Lp97Zr6FnCbkuPcb99BXk6/7pcTNPtA46hJ1gsohrOLk7uz911NhJ3dPtXiQuK8aMxEOarcz39J4hddq4DLktP9t568H+sla1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647485; c=relaxed/simple;
	bh=4zyREGKcISJB9fG6DLLYGachBcrX8cG98nVCAXn7Qh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DHvd/Ba5ykvAYX8aV3hDM1hN/oH8RX52Ro3dSK4kiB/4JoO8qCoCN5NXE3DUrDFwvx2JXTXoKqr9pdlxIL+kreRupuSUgFD1bMyLjD9jw64uq21dNTzUBLohhTdn1+pBlrIlfyZj5uaTgIzRbo2SP0jy++FgrE39wn4zXBDHZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dC0Sr4lGzzYQv0n;
	Thu, 20 Nov 2025 22:03:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9636D1A16C0;
	Thu, 20 Nov 2025 22:04:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgB31Hr0Hx9p_4amBQ--.47572S4;
	Thu, 20 Nov 2025 22:04:36 +0800 (CST)
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
Subject: [PATCH e2fsprogs v3] libext2fs: fix orphan file size > kernel limit with large blocksize
Date: Thu, 20 Nov 2025 21:55:14 +0800
Message-Id: <20251120135514.3013973-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB31Hr0Hx9p_4amBQ--.47572S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UAr1xCFyxCFyrZFyxKrg_yoW8Cry5pF
	W5J3s8G3Wj9Fy8W3Z2ya17try8GwnYyw1UXw1qv34FgFy5trn3Krsxt34YgFWDtr97A3y0
	9FsrZryUtFyqqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
	F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUosqWUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQASBWkejhg-VAAAsc

From: Baokun Li <libaokun1@huawei.com>

Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
limits the maximum supported orphan file size to 8 << 20.

However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
blocks when creating a filesystem.

With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
than the kernel allows, so mount prints an error and fails:

    EXT4-fs (vdb): orphan file too big: 8650752
    EXT4-fs (vdb): mount failed

Thus, orphan file size is capped at 512 filesystem blocks in both e2fsprogs
and the kernel.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
v1->v2:
 * Revert the changes in ext2fs_default_orphan_file_blocks()

v2->v3:
 * Aligning with the old default of 512 filesystem blocks for
   max orphan file size allows existing 64KB block filesystems
   (created under 64KB page size) to mount without error.

v1: https://lore.kernel.org/r/20251112122157.1990595-1-libaokun@huaweicloud.com
v2: https://lore.kernel.org/r/20251113090122.2385797-1-libaokun@huaweicloud.com

 lib/ext2fs/orphan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
index 14ac3569..0f1889cb 100644
--- a/lib/ext2fs/orphan.c
+++ b/lib/ext2fs/orphan.c
@@ -15,6 +15,8 @@
 #include "ext2_fs.h"
 #include "ext2fsP.h"
 
+#define EXT4_MAX_ORPHAN_FILE_BLOCKS 512
+
 errcode_t ext2fs_truncate_orphan_file(ext2_filsys fs)
 {
 	struct ext2_inode inode;
@@ -129,6 +131,9 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
 	struct ext4_orphan_block_tail *ob_tail;
 	time_t now;
 
+	if (num_blocks > EXT4_MAX_ORPHAN_FILE_BLOCKS)
+		num_blocks = EXT4_MAX_ORPHAN_FILE_BLOCKS;
+
 	if (ino) {
 		err = ext2fs_read_inode(fs, ino, &inode);
 		if (err)
-- 
2.46.1


