Return-Path: <linux-ext4+bounces-11660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241BC4070D
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB80034FCC6
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8832F744;
	Fri,  7 Nov 2025 14:51:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8332D0E9;
	Fri,  7 Nov 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527093; cv=none; b=ejOaltWbKHotZCWNbWoBVfGqjZsQQUGWeNKkdVPCPASzpwTA9V8Mj6F1M98JokjP7jyY+sPDn3gUki7FE3LhiM+J1lfU8MrVDhHCwkO/Eo5nXMoBPPsHE8a1VkzEbsvcJVBCO0a3M+a9U1ZOC1vQNG7DJyX22QnZ1IAqoPZa0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527093; c=relaxed/simple;
	bh=TxJcg7HBC4yb7+69QbgacaGpZHiTSZmHFXTlTgDC774=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N13bHEVoH45t6AC8LJ16zkk3ERg7pWOccsA9uPl0449H91EFufswFBHSpvAW8KanSgOYEkAzZOd/fCOWxLgFEj1baYLQmnmP9uKl7n+XnqYeNKf2Sbh52VRNGjq45/zbLdHV8fqgqKbSzHaoS2dR6XtqRsJVpvoejkGZEyEBtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d327F0P2mzYQv4k;
	Fri,  7 Nov 2025 22:51:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3A3201A0EE8;
	Fri,  7 Nov 2025 22:51:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgDnPUZoBw5pRwgbDA--.60770S28;
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
Subject: [PATCH v2 24/24] ext4: enable block size larger than page size
Date: Fri,  7 Nov 2025 22:42:49 +0800
Message-Id: <20251107144249.435029-25-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgDnPUZoBw5pRwgbDA--.60770S28
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxArW7Gr1DJF18Cr1UGFg_yoW8Aw48pF
	yrCF10yr15WF4j9a9rXw4vyF93G34kCFWUta4Fga42vrW7t348Grn7tFy5XFWjqrs3Zry8
	XF18AFy7Jr13J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAFBWkNxrUVKAABsq

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

In addition, allocation failures for large folios may trigger warn_alloc()
warnings. Therefore, as with XFS, mark this feature as experimental.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6735152dd219..1fbbae5a0426 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5074,6 +5074,9 @@ static int ext4_check_large_folio(struct super_block *sb)
 		return -EINVAL;
 	}
 
+	if (sb->s_blocksize > PAGE_SIZE)
+		ext4_msg(sb, KERN_NOTICE, "EXPERIMENTAL bs(%lu) > ps(%lu) enabled.",
+			 sb->s_blocksize, PAGE_SIZE);
 	return 0;
 }
 
@@ -7453,7 +7456,8 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
+				  FS_LBS,
 };
 MODULE_ALIAS_FS("ext4");
 
-- 
2.46.1


