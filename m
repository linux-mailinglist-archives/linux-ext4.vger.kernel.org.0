Return-Path: <linux-ext4+bounces-6208-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F1A190DF
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4318888A0
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41854212D85;
	Wed, 22 Jan 2025 11:47:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DB211A2E;
	Wed, 22 Jan 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546448; cv=none; b=Qf62aLz7jBUs5w71LrFvDk0NvxuMshUvRzt3kdR9Q7wkTbxjE6bDSpi2bwuRmobx9CwxnC2olF0gzyYE6mfA7efD7NKVh9yN/otYP5FiwumX8l8zh8fKtD2S9fp6+C4jOiN9SPMOYdISuSLzIS0kJnZE0psSmOuJytDGq3+eJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546448; c=relaxed/simple;
	bh=WIhs9KCIhiLPZFHPhbpwABjIqLx3fucqJt5GWMZQtow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRCgXXdC8+cSXcrAmmgY7RsCtxMa74UfcQuOf2erVmkMPhfnWRQJVY0bNOmDRg4lXx0jFbpG3pE5kto9Dpbwni7C25f5PBXFPzrtuqWPE3+RQbzq+GKmb4bOzBJeff+meeyTUrKTjl9zxvK0+qIhGRgR/i06v4YafRDakTqpb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdMkD37QLz4f3jdH;
	Wed, 22 Jan 2025 19:47:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1387B1A0D9E;
	Wed, 22 Jan 2025 19:47:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S6;
	Wed, 22 Jan 2025 19:47:20 +0800 (CST)
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
Subject: [PATCH v2 2/7] ext4: add EXT4_FLAGS_EMERGENCY_RO bit
Date: Wed, 22 Jan 2025 19:41:25 +0800
Message-Id: <20250122114130.229709-3-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fWr1UGF1DJr17Kr4xXrb_yoW8Xr4Dpa
	n3Ca48Cr40qF1Uuw47Wa4UX3WIvw18Cw4DWry2ya15WFZ8XryruF1ftFyFqFy0grZ7AFyf
	XF1rKFy7Cw43GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjfU1lkVUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAQBWeQpvkOyAAAs5

From: Baokun Li <libaokun1@huawei.com>

EXT4_FLAGS_EMERGENCY_RO Indicates that the current file system has become
read-only due to some error. Compared to SB_RDONLY, setting it does not
require a lock because we won't clear it, which avoids over-coupling with
vfs freeze. Also, add a helper function ext4_emergency_ro() to check if
the bit is set.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4491e82cfa6f..207510b0b0af 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2237,6 +2237,7 @@ enum {
 	EXT4_FLAGS_RESIZING,	/* Avoid superblock update and resize race */
 	EXT4_FLAGS_SHUTDOWN,	/* Prevent access to the file system */
 	EXT4_FLAGS_BDEV_IS_DAX,	/* Current block device support DAX */
+	EXT4_FLAGS_EMERGENCY_RO,/* Emergency read-only due to fs errors */
 };
 
 static inline int ext4_forced_shutdown(struct super_block *sb)
@@ -2244,6 +2245,11 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
 	return test_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
 }
 
+static inline int ext4_emergency_ro(struct super_block *sb)
+{
+	return test_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
+}
+
 /*
  * Default values for user and/or group using reserved blocks
  */
-- 
2.39.2


