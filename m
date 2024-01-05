Return-Path: <linux-ext4+bounces-712-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E991B824C83
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 02:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985D6285B34
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0636ABB;
	Fri,  5 Jan 2024 01:23:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B54440E;
	Fri,  5 Jan 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T5m0w63Vqz4f3kG1;
	Fri,  5 Jan 2024 09:22:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 302731A088D;
	Fri,  5 Jan 2024 09:23:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXZUXyWZdl68i0Fg--.35140S3;
	Fri, 05 Jan 2024 09:23:00 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] ext4: remove unused return value of __mb_check_buddy
Date: Fri,  5 Jan 2024 17:20:54 +0800
Message-Id: <20240105092102.496631-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240105092102.496631-1-shikemeng@huaweicloud.com>
References: <20240105092102.496631-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXZUXyWZdl68i0Fg--.35140S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4xGF4Uuw1DWF45Kw4rXwb_yoW8GFWfpF
	sxua4Uur4vgFnruw47Kw1DWFyIqw1I9ay7GryF9w1UJr13GrsY9F95KFyYvF1rAFWrGF13
	Aa15Zry3Cr1xCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsgyZUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of __mb_check_buddy.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d56126..9f9b8dd06 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -677,7 +677,7 @@ do {									\
 	}								\
 } while (0)
 
-static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
+static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				const char *function, int line)
 {
 	struct super_block *sb = e4b->bd_sb;
@@ -696,7 +696,7 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 	void *buddy2;
 
 	if (e4b->bd_info->bb_check_counter++ % 10)
-		return 0;
+		return;
 
 	while (order > 1) {
 		buddy = mb_find_buddy(e4b, order, &max);
@@ -758,7 +758,7 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 
 	grp = ext4_get_group_info(sb, e4b->bd_group);
 	if (!grp)
-		return NULL;
+		return;
 	list_for_each(cur, &grp->bb_prealloc_list) {
 		ext4_group_t groupnr;
 		struct ext4_prealloc_space *pa;
@@ -768,7 +768,6 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 		for (i = 0; i < pa->pa_len; i++)
 			MB_CHECK_ASSERT(mb_test_bit(k + i, buddy));
 	}
-	return 0;
 }
 #undef MB_CHECK_ASSERT
 #define mb_check_buddy(e4b) __mb_check_buddy(e4b,	\
-- 
2.30.0


