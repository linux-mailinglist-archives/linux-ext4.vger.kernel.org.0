Return-Path: <linux-ext4+bounces-11765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7187C4E84D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E16964F41FE
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BD303A00;
	Tue, 11 Nov 2025 14:35:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD9274FCB;
	Tue, 11 Nov 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871731; cv=none; b=LYDjpZTFkG9rjUm4gGiwngCUqEYRkyeAkZ3MgS+25AvTFj32ze58lHiDUZCSYHCagqkn0xocw7mrj7APjbre0IAvkH+RuIDAf9AJEhGKhB6A7jXS/mXF3/xeG0UzkgLmOQdGIv524roKTm7pXiH1+XtNBEpPAJ41orrohB/6UN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871731; c=relaxed/simple;
	bh=AhUusC2kbbSPQvDU5qsnaDrLaqG9n15u4RVCkzxGSW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvzI/kJQUraik0OZT4fnxyleUo6a3EKq7xO6vEgVCBvmebY6QLB6zFnb2rBxwni4uNFeFv+LV57QuGjzZMJvaxugFsIgFoQsQByzfBrasx3Gqf7E8qTZQRXPiA2WfI8iaeo7FeiaoaMjLXTm8lXkH5xMPaVSJ1reO7Ywbjo4o8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5TZr27K9zYQv0K;
	Tue, 11 Nov 2025 22:35:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2E2F61A1978;
	Tue, 11 Nov 2025 22:35:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S9;
	Tue, 11 Nov 2025 22:35:26 +0800 (CST)
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
Subject: [PATCH v3 05/24] ext4: enable DIOREAD_NOLOCK by default for BS > PS as well
Date: Tue, 11 Nov 2025 22:26:15 +0800
Message-Id: <20251111142634.3301616-6-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S9
X-Coremail-Antispam: 1UD129KBjvdXoW7XF18GFWrWFykGry8Kr47twb_yoWftrcEva
	yfJrWUWr4rGr4S93WrCa1UAFs0kw4xur1rGws5tr1rXwnIqrWxX34qqr95WF15uF4FqFWr
	Ars5XF13Wry2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbm8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
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
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdsqAUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAJBWkSsJdDIAAAsy

From: Baokun Li <libaokun1@huawei.com>

The dioread_nolock related processes already support large folio, so
dioread_nolock is enabled by default regardless of whether the blocksize
is less than, equal to, or greater than PAGE_SIZE.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 760c9d7588be..a9fa824487f9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4390,8 +4390,7 @@ static void ext4_set_def_opts(struct super_block *sb,
 	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
 		set_opt(sb, DELALLOC);
 
-	if (sb->s_blocksize <= PAGE_SIZE)
-		set_opt(sb, DIOREAD_NOLOCK);
+	set_opt(sb, DIOREAD_NOLOCK);
 }
 
 static int ext4_handle_clustersize(struct super_block *sb)
-- 
2.46.1


