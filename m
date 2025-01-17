Return-Path: <linux-ext4+bounces-6144-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D7A14B21
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 09:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FCF188BFB6
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F81F8AFA;
	Fri, 17 Jan 2025 08:28:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB501F8905;
	Fri, 17 Jan 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102530; cv=none; b=oNY7H0B/e0e0ANf5pmHKFxwx5FPp9oWG/f64q/VlgbsfYaEC17USYVx0mkSaVEcvUrZLVnTK7uuCulaYLXfQOkhd5CpGhZkN+oXJDk/9bbfMGj7SH5E2/lnC6ewYqBhknsIEGfBPQeHoXUGsrJ0eViT26hSOmJ9nXbRl8hBiW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102530; c=relaxed/simple;
	bh=pcllArBN6kLj9Y9pr+mTHArbMzo/KMXQwv7Ty0KH2Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtWrWhZRgwenLA1WNYFmq+Dq6fQuEnzQBvm31NeSmm1bFQj/1EFUh4gkOYKSGCOviDPZR1xB9tnSOzvAqmzaV9bIaqH8Ye9FHEz8tL773o8S0QNAPdZOX3vMGiUloozTn4xstEwsADeUzfVToszjERn+Kuvy5JH8SQDsptJl9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YZCYN3Shbz4f3jR1;
	Fri, 17 Jan 2025 16:28:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E97BF1A0AD8;
	Fri, 17 Jan 2025 16:28:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl+5FIpnZbnIBA--.46013S5;
	Fri, 17 Jan 2025 16:28:44 +0800 (CST)
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
Subject: [PATCH 1/7] ext4: convert EXT4_FLAGS_* defines to enum
Date: Fri, 17 Jan 2025 16:23:09 +0800
Message-Id: <20250117082315.2869996-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250117082315.2869996-1-libaokun@huaweicloud.com>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl+5FIpnZbnIBA--.46013S5
X-Coremail-Antispam: 1UD129KBjvdXoWrurWxAFyUZFW7AFyxJry8AFb_yoWfArbEk3
	y7Zr4rGrZxCrnakF1ruryYyry0gw4Iyr4UJFsYgryrXr4UJrW5XryDAryDArn5uF4UWF43
	Ar48ZryxtFy8XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7V
	Ujtl1JUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWeHbHgT0AACs7

From: Baokun Li <libaokun1@huawei.com>

Do away with the defines and use an enum as it's cleaner.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4e7de7eaa374..612208527512 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2232,9 +2232,11 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
 /*
  * Superblock flags
  */
-#define EXT4_FLAGS_RESIZING	0
-#define EXT4_FLAGS_SHUTDOWN	1
-#define EXT4_FLAGS_BDEV_IS_DAX	2
+enum {
+	EXT4_FLAGS_RESIZING,	/* Avoid superblock update and resize race */
+	EXT4_FLAGS_SHUTDOWN,	/* Prevent access to the file system */
+	EXT4_FLAGS_BDEV_IS_DAX	/* Current block device support DAX */
+};
 
 static inline int ext4_forced_shutdown(struct super_block *sb)
 {
-- 
2.39.2


