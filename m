Return-Path: <linux-ext4+bounces-6210-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0DA190E4
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A37A484D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37E21325F;
	Wed, 22 Jan 2025 11:47:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB321212FAF;
	Wed, 22 Jan 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546450; cv=none; b=Lf7N9o2jaH3tUyTxojOEaBCFFhSPZyjhORz9k528JAS2l8e4t6Bw/fmsRCfmjdjUJPKJHk82u0ktHDsmEz3vjnfM11Nq89sCSGW0/9I5CizSXArDEOD4iuNZBI4O4Zeo6DKNxDHRJ7TKgtFyo9pwYTv+7GWp/FPiVEHyAQzLHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546450; c=relaxed/simple;
	bh=j6qTMT797FB7cjz8C0On914Mr/mLnPGVSBK5jX13XZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXOAtDAns6Tjs7KebzKXy2vPr3J+DRl6mdxnCkrnemuy4QeoDlZ/io/LjwVNmssFk1+bsEPbiAqK2fe/E8OxIhg9zLWX2zA+zix+DlUWZFI2fdZOEOtbL8c8RHNjhcHts9GDohK1r3BuUblNj2U4Qjf9Q45bypzoIjHZ8j0uqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdMkG2wCDz4f3jdM;
	Wed, 22 Jan 2025 19:47:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0E85C1A13D9;
	Wed, 22 Jan 2025 19:47:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S11;
	Wed, 22 Jan 2025 19:47:22 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 7/7] ext4: show 'shutdown' hint when ext4 is forced to shutdown
Date: Wed, 22 Jan 2025 19:41:30 +0800
Message-Id: <20250122114130.229709-8-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122114130.229709-1-libaokun@huaweicloud.com>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S11
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1fZF48GFWDuFWUKr1DGFg_yoWkAFgEv3
	yfGan7XanxCFs2y3W8CFW5XrZ0kFs2vw15Wr93tryrXw15X3ykJF1DtrZ5Ar1rWaySgr98
	AFs3ZF10qFy7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbykFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY1x
	0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUbT7KDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAQBWeQpvMO7wAAsX

From: Baokun Li <libaokun1@huawei.com>

Now, if dmesg is cleared, we have no way of knowing if the file system has
been shutdown. Moreover, ext4 allows directory reads even after the file
system has been shutdown, so when reading a file returns -EIO, we cannot
determine whether this is a hardware issue or if the file system has been
shutdown.

Therefore, when ext4 file system is shutdown, we're adding a 'shutdown'
hint to commands like mount so users can easily check the file system's
status.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 06633d23d8b2..7455e2559bc0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3047,6 +3047,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	if (ext4_emergency_ro(sb))
 		SEQ_OPTS_PUTS("emergency_ro");
 
+	if (ext4_forced_shutdown(sb))
+		SEQ_OPTS_PUTS("shutdown");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
-- 
2.39.2


