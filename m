Return-Path: <linux-ext4+bounces-2800-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8168FE6E7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C05B20F7A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89986195F13;
	Thu,  6 Jun 2024 12:56:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC2195993;
	Thu,  6 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678585; cv=none; b=U+mSQXKoGLPXa+LWOMFAlkgP+dww0VLOIhB0fwjCgki+I/NevpukglAE+C5KWJqMr2ANmg2cUmRNIpXSYq7yeCkS86R+jmpaMIfsmCNfJm/KmOmiKnFzWLj4pjeIfeUbHgpzmBlv6LR/sIE5yeDIJKgfExkoZAJpshLvXHg47eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678585; c=relaxed/simple;
	bh=4GxkjKUA66p3QbDCF1sGBl4FwsasV+tKYFpsuJdUGKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ygm3PLM57UeCcKyE3JId34pbc5UnuhMDjQHbhaQSYJQO70ZoIkyIvhhTQSm4RWZNPDbyhmDcpTo3wOm6ycfP9YOWvLI2npSaimuQxVwEm/HQoBHV7TtptPSZYiIdn4QUJ+zl+8ePi8Kb7oC3sdFw3VmmFHcyfnNw86MjB/UJjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vw4880T7bz4f3nZw;
	Thu,  6 Jun 2024 20:56:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 406CE1A016E;
	Thu,  6 Jun 2024 20:56:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgC31A3xsWFmlILsOg--.39039S3;
	Thu, 06 Jun 2024 20:56:19 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ext4: correct comment of ext4_xattr_cmp
Date: Thu,  6 Jun 2024 20:55:06 +0800
Message-Id: <20240606125508.1459893-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgC31A3xsWFmlILsOg--.39039S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1DZF15GF1ruFyDCr45Jrb_yoW3Awb_ta
	4kArsrGrn5Xw1S9Fy5AF13tF1Sg3W8CrnxuF1rKry7ur15ta1jv3yDX345Ars5Wa15J3W3
	C3s7Wry2yFySgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07UAEfrUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The ext4_xattr_cmp never returns negative error number. Correct possible
return value in ext4_xattr_cmp's comment.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b67a176bfcf9..c3db1abe9d77 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3050,8 +3050,7 @@ ext4_xattr_block_cache_insert(struct mb_cache *ea_block_cache,
  *
  * Compare two extended attribute blocks for equality.
  *
- * Returns 0 if the blocks are equal, 1 if they differ, and
- * a negative error number on errors.
+ * Returns 0 if the blocks are equal, 1 if they differ.
  */
 static int
 ext4_xattr_cmp(struct ext4_xattr_header *header1,
-- 
2.30.0


