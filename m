Return-Path: <linux-ext4+bounces-1492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC186FAFB
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 08:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088B9280C16
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D99168C4;
	Mon,  4 Mar 2024 07:39:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2014ABA;
	Mon,  4 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537952; cv=none; b=a0J+/oNDzCHxj47jugzJ73CBvNJJZC4NYAMBb0G2Kj0tBD/xejBLI4/cChrgM3kfhNrN91dY5UmGg+oLFwCvGDBL/Nj+vIN/xWqSb1mlJ81GCjiLiVBC3A/fpljy0IwD3OJwYlSDikjz4zwVxQghNDkjO2EJ6reuZcAys9Ih0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537952; c=relaxed/simple;
	bh=5hzRnUh34nUYKLiZt7NaTdrTOrhwlApFtHI+0BahY4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmMVoRjzZJZtPfNsNSl6Px/WfVXnFXeIin+NnJBAwXRLga+IcYQM3ko3A00h2Ud6F1B4vtyK95BWoUHbhNTuCKVr4OPk8gXWemHn4JRR2OMg6pol4c4IsX3XpbTUQalcG1U9fJ9bkgdmWGH8ESe8sXeyJDeTBlOiPOhN2EDfHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tp9Yh1z9lz4f3jHV;
	Mon,  4 Mar 2024 15:39:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B7B371A0172;
	Mon,  4 Mar 2024 15:39:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDXKGuXeuVlWUH1Fw--.2277S4;
	Mon, 04 Mar 2024 15:39:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v4 2/3] ext4: hold group lock in ext4 kunit test
Date: Tue,  5 Mar 2024 00:35:42 +0800
Message-Id: <20240304163543.6700-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240304163543.6700-1-shikemeng@huaweicloud.com>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXKGuXeuVlWUH1Fw--.2277S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UuFyUArWrur17KFyUJrb_yoW8ArW8pa
	nxCrn0kF45Wr1kuw47G3y0q3Z7Kw4kuw18GrWfCw1fArWfJr9rCF98twnIgr48tF4xXF45
	A3Z0vry3Crs7uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
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


