Return-Path: <linux-ext4+bounces-2801-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF358FE6E6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 14:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6476E1F25721
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B0195F16;
	Thu,  6 Jun 2024 12:56:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8B195B13;
	Thu,  6 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678585; cv=none; b=diQFn87XxHCZ8ermyEsSgYjWolCuCiyQd7vRsGZYBeMQusuMhvzybjAAqMW5srDJ6eKF5W/+/WK2jIPKbPHoxXYQyarItaV1sB80ZbUJphwPMMzs0J0RrmqONDskicVXSgFMO5BBspwi7kRMgomnMBGwlwA6w7iFmM4pViacLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678585; c=relaxed/simple;
	bh=RgTX+M5nQNBqP5GqXs68I/ytp3G6EXzwjpsGD6jj/sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=id61v0fDvNKuEoKkMqDQ5E/HbcfhCWB6tgKC2YmaBkBRvfjkbxV+50vPkLwuJ5ecj27WrwrRnIIE1zNftUHCYQn8Ca7+q0iQLOKFcrE6BNoBMurVsYTRHzT5NA4ijcXr6T1ZcHwtQbEIqeEJn+1Ns4HCLIWqtjhPK2BDBpALFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vw4884Vt7z4f3nZy;
	Thu,  6 Jun 2024 20:56:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C98CA1A06E0;
	Thu,  6 Jun 2024 20:56:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgC31A3xsWFmlILsOg--.39039S5;
	Thu, 06 Jun 2024 20:56:19 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ext4: correct comment of h_checksum
Date: Thu,  6 Jun 2024 20:55:08 +0800
Message-Id: <20240606125508.1459893-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
References: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC31A3xsWFmlILsOg--.39039S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1ruF1kXr1xAFWfGryUJrb_yoWfGwb_Ka
	4kKr48Jry5WFs2gr1fCF1rt3yvqr4Iyr43WF4Utr1fWa45ta18Z34DJr45Zr98Wa48G34r
	Aw18ZFy7Cry8KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jec_-UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Checksum of xattr block is always crc32c(uuid+blknum+xattrblock), see
ext4_xattr_block_csum_set for detail. Remove incorrect comment that
"id = inum if refcount=1".

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/xattr.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..7df0d77643c7 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -32,8 +32,7 @@ struct ext4_xattr_header {
 	__le32	h_refcount;	/* reference count */
 	__le32	h_blocks;	/* number of disk blocks used */
 	__le32	h_hash;		/* hash value of all attributes */
-	__le32	h_checksum;	/* crc32c(uuid+id+xattrblock) */
-				/* id = inum if refcount=1, blknum otherwise */
+	__le32	h_checksum;	/* crc32c(uuid+blknum+xattrblock) */
 	__u32	h_reserved[3];	/* zero right now */
 };
 
-- 
2.30.0


