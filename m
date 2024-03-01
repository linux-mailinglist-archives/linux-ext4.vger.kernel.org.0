Return-Path: <linux-ext4+bounces-1456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D386DDDA
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 10:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B34B299BD
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04296A8BF;
	Fri,  1 Mar 2024 09:07:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827D6A8B9;
	Fri,  1 Mar 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284043; cv=none; b=cfr7muJXF9vha8OolqXWISqd0eqgQapkdmyriCdizc5FS4Lfsm01sLOO1iDYF1sl/XSWEr29vuQp0CHNzCLIT8g6MC/bZ2umz3Z15HvhPrLR1rEtRJLtuXY24H4Yk7029b9oxbasdoCViFFBTY20fEL8gUdg1gMzIS9/jzVA0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284043; c=relaxed/simple;
	bh=yBGwseHJpUaIWf/NvwlUJOgYsmzRd4X4BVb6nuPf2VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQODiToNbRNjtb3HQZ2ADti2j16e3qjIPnQDiSRFKKO6+dl+JXuvsYRUkKKmEOwl/4s1WYQ2cTtHZJ3IT2wz1jfa5TYCc6zJxN73UDXcbc3c36uQSgzbcVnfMeJF8oJpWu/fz1xoowPtP/W0jIoOL3YM4LQs+DJVjNV122CtJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TmMfm0wtcz4f3mJc;
	Fri,  1 Mar 2024 17:07:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 699A41A0D52;
	Fri,  1 Mar 2024 17:07:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgC31A2umuFl63FqFg--.2523S4;
	Fri, 01 Mar 2024 17:07:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v2 2/2] ext4: hold group lock in ext4 kunit test
Date: Sat,  2 Mar 2024 02:03:42 +0800
Message-Id: <20240301180342.6232-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240301180342.6232-1-shikemeng@huaweicloud.com>
References: <20240301180342.6232-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC31A2umuFl63FqFg--.2523S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UuFyUArWrur17KFyUJrb_yoW8ArW8pa
	nrCrn0kFs8Wr1kuw47G3y0q3Z7K3ykuw1UGrWfCa45ArWfJr97CF98KrnFgF4ktFs7XF45
	Z3Z0vry3Cr4xuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUCVW8JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3lApDUUUU
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
index 0821dc51b81d..fa298579fb9b 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -699,7 +699,10 @@ test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
 	ex.fe_start = start;
 	ex.fe_len = len;
 	ex.fe_group = TEST_GOAL_GROUP;
+
+	ext4_lock_group(sb, TEST_GOAL_GROUP);
 	mb_mark_used(e4b, &ex);
+	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	mb_set_bits(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
@@ -759,7 +762,9 @@ test_mb_free_blocks_range(struct kunit *test, struct ext4_buddy *e4b,
 	if (len == 0)
 		return;
 
+	ext4_lock_group(sb, e4b->bd_group);
 	mb_free_blocks(NULL, e4b, start, len);
+	ext4_unlock_group(sb, e4b->bd_group);
 
 	mb_clear_bits(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
@@ -803,7 +808,11 @@ static void test_mb_free_blocks(struct kunit *test)
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


