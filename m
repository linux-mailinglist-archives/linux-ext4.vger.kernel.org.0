Return-Path: <linux-ext4+bounces-8180-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC441AC1F41
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 11:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803AF7BAE37
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B46225A3D;
	Fri, 23 May 2025 09:03:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3E224893;
	Fri, 23 May 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990997; cv=none; b=aKqhLpoY0lD9m1VYLVOxw5SA1xZz8ybJhJnw2NNowN5DzsAVQ0Bg8/PzNB/44ixuFU8FcKZ4LahVRfc5eUb0+XrUYXiHQWAmhiTl5G/iTWS+7IJjl6tuQry6DpH1B3jcjhHbmxJ9j7NZNno8nWjf2pJk7a8MBzb9l+Z4HM1uw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990997; c=relaxed/simple;
	bh=7l5SfPkeJLkABkv2Lg6ATbrd6Cq4z5wQ6b7/+3v9SWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wxj3y0UxeFAveV07n5Qlj3soo6SXXjCGwrQ4kQqtOfYubL1ydkRboLgUcicr0rIxp3fTy+7aLyfLFC/okVK5QtNz/eyKugcbAta7jUVrlPXORTduWSExpJSop62jUgjg+aG0Mgdzov1GRiUuOQkgRkXdehR5Y8IQeodeIoO+0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b3fMP2ggPzYQv7c;
	Fri, 23 May 2025 17:03:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 885961A1C4D;
	Fri, 23 May 2025 17:03:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_MOTBocBILNQ--.27999S8;
	Fri, 23 May 2025 17:03:12 +0800 (CST)
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
Subject: [PATCH 4/4] ext4: fix typo in CR_GOAL_LEN_SLOW comment
Date: Fri, 23 May 2025 16:58:21 +0800
Message-Id: <20250523085821.1329392-5-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250523085821.1329392-1-libaokun@huaweicloud.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_MOTBocBILNQ--.27999S8
X-Coremail-Antispam: 1UD129KBjvdXoWruF4DuF1kCFWfur45KF1fXrb_yoWxArX_ta
	yUZr48Wrnxtrn29a4rur9aqFnFgr48Gr1UuFZ8GrnYqayUX3yfX3Wvyrs8Z3Z8ur4UAFn8
	ZwsIqF17AF92qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUby8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY1x
	0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0JU9Aw3UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQARBWgwLIEFbAADsK

From: Baokun Li <libaokun1@huawei.com>

Remove the superfluous "find_".

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f6d01702423d..1182700901cc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -157,7 +157,7 @@ enum criteria {
 
 	/*
 	 * Reads each block group sequentially, performing disk IO if
-	 * necessary, to find find_suitable block group. Tries to
+	 * necessary, to find suitable block group. Tries to
 	 * allocate goal length but might trim the request if nothing
 	 * is found after enough tries.
 	 */
-- 
2.46.1


