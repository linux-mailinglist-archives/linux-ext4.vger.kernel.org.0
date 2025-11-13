Return-Path: <linux-ext4+bounces-11850-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFDC568E0
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D9214EBA0E
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993162C0F6F;
	Thu, 13 Nov 2025 09:10:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49434286A4
	for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025022; cv=none; b=M+QcsmjGAYvgxUKZC1d3cqJMDqgPit7VuvdiCRHem69rxx7Si8/CrexN+Y8M8r70opNcky7c+QMZUXOD7Um4F+2DP8SxtXFGBkr7eyUe/5isRkp4SLrNJgYj3d6q0kE5gAqChFwBXHmDTCLuTM8h45dkgf3fhDx4VR/T/cnyT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025022; c=relaxed/simple;
	bh=7oyzAKSqljrSry/Mk8stbcXslWYkfTED0rfBU1cyMxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nXp9Kd6PgMH5irn9UXo0JTf6I25epEJZ5Ey6mn83hucW9TW7qlrUeBGoNJQfGDb4bYOlrPFy2FqkICVitlAt85PHoG240Fi9rMFKAMCr+KrE3+Fg7YJFzjXRYM8cH0dKLluIXh6adMKraDIaiLOl03OaPmvH6AvzOJW5UaKutoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6ZGs30ZVzKHMkB
	for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 17:09:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 46A7D1A06E6
	for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 17:10:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHt1oBVpzWtZAg--.38563S4;
	Thu, 13 Nov 2025 17:10:14 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	djwong@kernel.org,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH e2fsprogs v2] libext2fs: fix orphan file size > kernel limit with large blocksize
Date: Thu, 13 Nov 2025 17:01:22 +0800
Message-Id: <20251113090122.2385797-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHt1oBVpzWtZAg--.38563S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UAr1xCFyxCFyrZFyxKrg_yoW8WF4Up3
	W5JryrG3Wj9FyUXFnFyw47tryruwnIgw1UX3WqvryF9Fy3tr9akrs7t34YqFyqyryIyrWv
	qFsxCrWUtr1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
	F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUmD7-UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQALBWkVU5glawAAs2

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
v1->v2:
 * Revert the changes in ext2fs_default_orphan_file_blocks()

v1: https://lore.kernel.org/r/20251112122157.1990595-1-libaokun@huaweicloud.com

 lib/ext2fs/orphan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
index 14ac3569..6124a59a 100644
--- a/lib/ext2fs/orphan.c
+++ b/lib/ext2fs/orphan.c
@@ -164,6 +164,12 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
 	memset(zerobuf, 0, fs->blocksize);
 	ob_tail = ext2fs_orphan_block_tail(fs, buf);
 	ob_tail->ob_magic = ext2fs_cpu_to_le32(EXT4_ORPHAN_BLOCK_MAGIC);
+	/*
+	 * Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not
+	 * too big") limits the maximum supported orphan file size to 8 << 20.
+	 */
+	if (num_blocks * fs->blocksize > (8 << 20))
+		num_blocks = (8 << 20) / fs->blocksize;
 	oi.num_blocks = num_blocks;
 	oi.alloc_blocks = 0;
 	oi.last_blk = 0;
-- 
2.46.1


