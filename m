Return-Path: <linux-ext4+bounces-11939-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F6C74607
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E787B351F7F
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925F3446C6;
	Thu, 20 Nov 2025 13:51:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCAC3446CD;
	Thu, 20 Nov 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646718; cv=none; b=p8VsmBkLETmUrXC6fldCNPub7OWOrckT2vCD22Pi7shAeVNomeYTLZjP6FjNcuvFUWTwYzLCtvf/O/Zrt01JZDzy2VeYit8m3w/eIXhbkQTSo+LFwX7opyZs581lI4SpWhjyag+aeEzf994KgV+NOVqwLzE4BF8D2J7pwE6Ooj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646718; c=relaxed/simple;
	bh=D7RTr9CKU63wIg/Qn6lQc4OvJEkqTg5dEAHhJ0R6gVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ikvNBTskz2k1i7z+tXScsZwOHQkMifAUfrigEBbU+tUN+ttJ9HO3LZdDEN0oKjjORjZlbqhms9B8kwLfyxVhebeoA2WHnWH9GKQy1hcmX/AV3B5vjH2i5B0DkIIXZZchrdl08Drgm3gNZim4JWJ5IlCggW1+95M3n1H0rNhx+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dC0BL6VRwzKHMST;
	Thu, 20 Nov 2025 21:51:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A12291A06D7;
	Thu, 20 Nov 2025 21:51:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBnD3b4HB9pu4ClBQ--.4222S4;
	Thu, 20 Nov 2025 21:51:52 +0800 (CST)
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
Subject: [PATCH] ext4: align max orphan file size with e2fsprogs limit
Date: Thu, 20 Nov 2025 21:42:33 +0800
Message-Id: <20251120134233.2994147-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnD3b4HB9pu4ClBQ--.4222S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UAr1xCFyxCFyrZFyxKrg_yoW8WrW3pF
	y5Jw1rGa10ga4Y9anakFsrJry8A3Wfu3WDXFyq934Yqry5Jr9agrnxt34jgFyDtrZ7Jr40
	gFs7W34Yvrsru3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
	F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JULyCXUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgASBWkejgs9uwAAsh

From: Baokun Li <libaokun1@huawei.com>

Kernel commit 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
limits the maximum supported orphan file size to 8 << 20.

However, in e2fsprogs, the orphan file size is set to 32–512 filesystem
blocks when creating a filesystem.

With 64k block size, formatting an ext4 fs >32G gives an orphan file bigger
than the kernel allows, so mount prints an error and fails:

    EXT4-fs (vdb): orphan file too big: 8650752
    EXT4-fs (vdb): mount failed

To prevent this issue and allow previously created 64KB filesystems to
mount, we updates the maximum allowed orphan file size in the kernel to
512 filesystem blocks.

Fixes: 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/orphan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 82d5e7501455..fb57bba0d19d 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -8,6 +8,8 @@
 #include "ext4.h"
 #include "ext4_jbd2.h"
 
+#define EXT4_MAX_ORPHAN_FILE_BLOCKS 512
+
 static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
 {
 	int i, j, start;
@@ -588,7 +590,7 @@ int ext4_init_orphan_info(struct super_block *sb)
 	 * consuming absurd amounts of memory when pinning blocks of orphan
 	 * file in memory.
 	 */
-	if (inode->i_size > 8 << 20) {
+	if (inode->i_size > (EXT4_MAX_ORPHAN_FILE_BLOCKS << inode->i_blkbits)) {
 		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
 			 (unsigned long long)inode->i_size);
 		ret = -EFSCORRUPTED;
-- 
2.46.1


