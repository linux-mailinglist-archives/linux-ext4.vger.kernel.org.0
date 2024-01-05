Return-Path: <linux-ext4+bounces-709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BA824C7E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 02:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056091F23376
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365A3C0D;
	Fri,  5 Jan 2024 01:23:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8674428;
	Fri,  5 Jan 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5m0t5Mtgz4f3lW9;
	Fri,  5 Jan 2024 09:22:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 762001A08B6;
	Fri,  5 Jan 2024 09:23:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXZUXyWZdl68i0Fg--.35140S4;
	Fri, 05 Jan 2024 09:23:00 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] ext4: remove unused parameter ngroup in ext4_mb_choose_next_group_*()
Date: Fri,  5 Jan 2024 17:20:55 +0800
Message-Id: <20240105092102.496631-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXZUXyWZdl68i0Fg--.35140S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr13Cr47Zr47ArWxAr45Awb_yoW5GF15pF
	4DtF1Uu3yfGF1DuF4xW39Fg3WxKw18uryUAry3Wa4F9ryxJrykJF47tF40yF1UCFs7urnx
	Xas0v348Ca17C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3K9-UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused parameter ngroup in ext4_mb_choose_next_group_*().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9f9b8dd06..765b62729 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -870,7 +870,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * cr level needs an update.
  */
 static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
-			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+			enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *iter;
@@ -944,7 +944,7 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
  * order. Updates *new_cr if cr level needs an update.
  */
 static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL;
@@ -989,7 +989,7 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
  * much and fall to CR_GOAL_LEN_SLOW in that case.
  */
 static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL;
@@ -1124,11 +1124,11 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 	}
 
 	if (*new_cr == CR_POWER2_ALIGNED) {
-		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group, ngroups);
+		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
 	} else if (*new_cr == CR_GOAL_LEN_FAST) {
-		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group, ngroups);
+		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
 	} else if (*new_cr == CR_BEST_AVAIL_LEN) {
-		ext4_mb_choose_next_group_best_avail(ac, new_cr, group, ngroups);
+		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
 	} else {
 		/*
 		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
-- 
2.30.0


