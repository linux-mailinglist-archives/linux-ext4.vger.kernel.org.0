Return-Path: <linux-ext4+bounces-11782-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2445C4E8EF
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 15:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3859A3B635D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2134D343D64;
	Tue, 11 Nov 2025 14:35:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDEB3358A7;
	Tue, 11 Nov 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871737; cv=none; b=CCJYBhwMug38RjDHAjnTwsCWdbm+jVItScIFvl/JHwrUon7C40lfdfpXZUO7ZF4oyaYZjShp5j1vDjkyUMiA1AqXiYY9WrFKW6zNkE3pKpZ77hHp9CsPb/zxgx3ZSWxbcenbb1biG3+OGr8exKKU3AkfD9Nf8fJi4xFAMCvVcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871737; c=relaxed/simple;
	bh=QCc0CvjitXEJmRRFH82dwi9L/Z+9mpmMFNFub2Uv1IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4iECVqWdfOaGNb9UrzH7hS5SD6I1svc5FIJsbzSV7opFAmRqCWkfRcrIeZi/96cKalAfI01wLOJ7fbu/vDsv+dOqT9T3yBdxzfPqVDGh7bWFegGGkB0l59hh6uzHZiUnWU9a9LLBWwqbKwZqI7x9/1WWLX9s6sYl9XR5olrJbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5TZs3kvyzYQv4Q;
	Tue, 11 Nov 2025 22:35:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 667C51A19A0;
	Tue, 11 Nov 2025 22:35:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mrSRNpgYWKAQ--.32556S26;
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
Subject: [PATCH v3 22/24] ext4: support verifying data from large folios with fs-verity
Date: Tue, 11 Nov 2025 22:26:32 +0800
Message-Id: <20251111142634.3301616-23-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHo3mrSRNpgYWKAQ--.32556S26
X-Coremail-Antispam: 1UD129KBjvdXoW7Wry5XF13ZF13trW8Wr18Grg_yoWDWFcE93
	ykWw4Iv3yfKws2k3y5Ar4aqryq9F4kWr17uayaqF1Yvr4fZ395A3ZFkrZ8AanrWay7WFZ8
	CFsxJF12yFy29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWkSsIpDUgAAse

From: Baokun Li <libaokun1@huawei.com>

Eric Biggers already added support for verifying data from large folios
several years ago in commit 5d0f0e57ed90 ("fsverity: support verifying
data from large folios").

With ext4 now supporting large block sizes, the fs-verity tests
`kvm-xfstests -c ext4/64k -g verity -x encrypt` pass without issues.

Therefore, remove the restriction and allow large folios to be enabled
together with fs-verity.

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 613a989bf750..7b979e64f481 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5152,8 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (ext4_has_feature_verity(sb))
-		return false;
 	if (ext4_has_feature_encrypt(sb))
 		return false;
 
-- 
2.46.1


