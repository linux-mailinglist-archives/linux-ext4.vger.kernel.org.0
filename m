Return-Path: <linux-ext4+bounces-1478-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726986EFC8
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93561C21C76
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584DA17985;
	Sat,  2 Mar 2024 09:21:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3791134DE;
	Sat,  2 Mar 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709371285; cv=none; b=l+SEGhq/4SLaVGu1/Na6BHVoPSbCCBGVcN7TttrzAjjx9Fw2O4z6OwJ3tBA5gxU2h6WNavuWmgm6BIjgc1XScuYb3X5Z44Z9clgT6lkgyO6OxeNt7fyzWnoLAqlIp2vRgBRITlKtDTELvDs0r1xZjtBkcxdsaS239tKjUASx8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709371285; c=relaxed/simple;
	bh=5hzRnUh34nUYKLiZt7NaTdrTOrhwlApFtHI+0BahY4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbqrehMGgtf3o62Ifr5K+7uZdCBapqug8KgNgOJstE/dIZZtR+YVQN/PaRyLyKedaThy2AI9SVUkg4EFf+k4OR9zADI6rcVHQtofuezJHTN26qXGqGKEcSUFdjY+JF5nFrR2nMoNwbW6wj1XpLEwhyX4kmnhQxzLOZ28bxiKB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmzwP2TfCz4f3jqt;
	Sat,  2 Mar 2024 17:21:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C001C1A0175;
	Sat,  2 Mar 2024 17:21:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgA3imyE7+Jld1cqFw--.52350S4;
	Sat, 02 Mar 2024 17:21:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v3 2/3] ext4: hold group lock in ext4 kunit test
Date: Sun,  3 Mar 2024 02:17:54 +0800
Message-Id: <20240302181755.9192-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240302181755.9192-1-shikemeng@huaweicloud.com>
References: <20240302181755.9192-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3imyE7+Jld1cqFw--.52350S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UuFyUArWrur17KFyUJrb_yoW8ArW8pa
	nxCrn0kF45Wr1kuw47G3y0q3Z7Kw4kuw18GrWfCw1fArWfJr9rCF98twnIgr48tF4xXF45
	A3Z0vry3Crs7uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jguciUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Although there is no concurrent block allocation/free in unit test,
internal functions mb_mark_used and mb_free_blocks assert group
lock is always held. Acquire group before calling mb_mark_used and
mb_free_blocks in unit test to avoid the assertion.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ext4/mballoc-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 9d061f80f150..4d9eb4807c98 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -701,7 +701,10 @@ test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
 	ex.fe_start = start;
 	ex.fe_len = len;
 	ex.fe_group = TEST_GOAL_GROUP;
+
+	ext4_lock_group(sb, TEST_GOAL_GROUP);
 	mb_mark_used(e4b, &ex);
+	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	mb_set_bits(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
@@ -761,7 +764,9 @@ test_mb_free_blocks_range(struct kunit *test, struct ext4_buddy *e4b,
 	if (len == 0)
 		return;
 
+	ext4_lock_group(sb, e4b->bd_group);
 	mb_free_blocks(NULL, e4b, start, len);
+	ext4_unlock_group(sb, e4b->bd_group);
 
 	mb_clear_bits(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
@@ -805,7 +810,11 @@ static void test_mb_free_blocks(struct kunit *test)
 	ex.fe_start = 0;
 	ex.fe_len = EXT4_CLUSTERS_PER_GROUP(sb);
 	ex.fe_group = TEST_GOAL_GROUP;
+
+	ext4_lock_group(sb, TEST_GOAL_GROUP);
 	mb_mark_used(&e4b, &ex);
+	ext4_unlock_group(sb, TEST_GOAL_GROUP);
+
 	grp->bb_free = 0;
 	memset(bitmap, 0xff, sb->s_blocksize);
 
-- 
2.30.0


