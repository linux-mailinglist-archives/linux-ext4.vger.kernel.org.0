Return-Path: <linux-ext4+bounces-11788-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F9C4E8A7
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D866A4F4885
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39A346E51;
	Tue, 11 Nov 2025 14:35:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB8337BAF;
	Tue, 11 Nov 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871738; cv=none; b=MYIYN3daoLGr9VwoWF0WJD0Tq4xQGxVaxeoRlCdojYyym3HTZPGozHrXxydw41ttil5HrVUk93zIXLOOLHSE7eb1Qt3YVtdRUjmwo1Lg7IyiMrtRhkKVh6uNor8I7je8qp0utY4yajRmMbmMks+Sm3bNFoHz2l/nHP0YRxx7Hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871738; c=relaxed/simple;
	bh=Hu6wpKVtbeYI2pGK7B2/X00wpZx+xdaPdtX3Ci+NxfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtjoUIbOA3OOgG3A3a5MTyGOiAfB4Mqc/o2p7CjJ+XNv69V3Bsqmhl5dXeyZU1V261l9F8nXF4M4xoFbUpWvlOLwBMa3rMdctCXjdjQfE31jEUSC04yy0lsEAtDTlxiaMvAk8YCQ6oatY7VQiTCTklpV1wQdeijWG+xuCVvuk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5TZs5gjVzYQv4X;
	Tue, 11 Nov 2025 22:35:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 96A7A1A1962;
	Tue, 11 Nov 2025 22:35:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S28;
	Tue, 11 Nov 2025 22:35:28 +0800 (CST)
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
Subject: [PATCH v3 24/24] ext4: enable block size larger than page size
Date: Tue, 11 Nov 2025 22:26:34 +0800
Message-Id: <20251111142634.3301616-25-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251111142634.3301616-1-libaokun@huaweicloud.com>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S28
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fAryUXrWUtF1DZFWUurg_yoW5Xw1kp3
	WrGFy8Jrn8WFyUua9rWanF9as3Gw1vkFyUXryYgw1UZFZFq34xKrn7tFy5XFyjqrZ3uFWf
	XF1vyr13Ar43uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWkSsIpDVAABsZ

From: Baokun Li <libaokun1@huawei.com>

Since block device (See commit 3c20917120ce ("block/bdev: enable large
folio support for large logical block sizes")) and page cache (See commit
ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
cache")) has the ability to have a minimum order when allocating folio,
and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
large folio for regular file"), now add support for block_size > PAGE_SIZE
in ext4.

set_blocksize() -> bdev_validate_blocksize() already validates the block
size, so ext4_load_super() does not need to perform additional checks.
Here we only need to add the FS_LBS bit to fs_flags.

In addition, block sizes larger than the page size are currently supported
only when CONFIG_TRANSPARENT_HUGEPAGE is enabled. To make this explicit,
a blocksize_gt_pagesize entry has been added under /sys/fs/ext4/feature/,
indicating whether bs > ps is supported. This allows mke2fs to check the
interface and determine whether a warning should be issued when formatting
a filesystem with block size larger than the page size.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 3 ++-
 fs/ext4/sysfs.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f1aeba47b0e3..29bc8f5eb527 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7451,7 +7451,8 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
+				  FS_LBS,
 };
 MODULE_ALIAS_FS("ext4");
 
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 987bd00f916a..0018e09b867e 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -332,6 +332,9 @@ EXT4_ATTR_FEATURE(fast_commit);
 #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 EXT4_ATTR_FEATURE(encrypted_casefold);
 #endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+EXT4_ATTR_FEATURE(blocksize_gt_pagesize);
+#endif
 
 static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
@@ -351,6 +354,9 @@ static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(fast_commit),
 #if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 	ATTR_LIST(encrypted_casefold),
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ATTR_LIST(blocksize_gt_pagesize),
 #endif
 	NULL,
 };
-- 
2.46.1


