Return-Path: <linux-ext4+bounces-11991-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F1C781E0
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 276FA362471
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323253451CE;
	Fri, 21 Nov 2025 09:17:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFA305E18;
	Fri, 21 Nov 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716625; cv=none; b=b1YgEYxjgqpH9a2Ohmv6aYPxO3ngJjaLK0lH9w9q/X/f005BJtqOaCi0+kg027GRj17NdNeRkidMiDsEN+2r3lWBFU4TCoAOA3glqwb3CShOsD1dZ8gN7/KjVX2kTD7SI2NVSDkW5BFnWqczfYhs6JvGVbyzt3sqcXxXx6bQE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716625; c=relaxed/simple;
	bh=fjCWSMb4W8yBys3EG1WjhzsghzWnwGO7O0H3N2c/aRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVNxZ9Dvt5I/2vyKt6e2bst4KUOBJGbi9Eijo6/acG1eY4OonW7Kg/CBi/tIOyckzFmQYzAUq7I0jf2lPInbZeZnNgEZ3GOwA+xvDKhD+HlRyz4sMYgs4Y52ZjRaW/B8pJ3jCcAC0JbiW/vZnLO35cY9n/qspV0u36nZwzR3sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCV2P07wBzKHMwH;
	Fri, 21 Nov 2025 17:16:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F40FC1A12AD;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXv4LSBpaLMDBg--.2072S24;
	Fri, 21 Nov 2025 17:16:43 +0800 (CST)
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
Subject: [PATCH v4 20/24] ext4: support large block size in __ext4_block_zero_page_range()
Date: Fri, 21 Nov 2025 17:06:50 +0800
Message-Id: <20251121090654.631996-21-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251121090654.631996-1-libaokun@huaweicloud.com>
References: <20251121090654.631996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXv4LSBpaLMDBg--.2072S24
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw45Wr1fWFWrCF4fCr48Zwb_yoWfurcEkF
	W8Xr4rXw4rXFn3Za95Aan0qan2k3WrCFn8ur13Gr1rZFykXFZ5G3yDtrWYyr4qgFsrW3y5
	ArZ7XFWYyFy7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbG-e7UUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgATBWkf34sfGQABsx

From: Zhihao Cheng <chengzhihao1@huawei.com>

Use the EXT4_PG_TO_LBLK() macro to convert folio indexes to blocks to avoid
negative left shifts after supporting blocksize greater than PAGE_SIZE.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a8a31a2b29e..5499b2856f9e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4074,7 +4074,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 
 	blocksize = inode->i_sb->s_blocksize;
 
-	iblock = folio->index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+	iblock = EXT4_PG_TO_LBLK(inode, folio->index);
 
 	bh = folio_buffers(folio);
 	if (!bh)
-- 
2.46.1


