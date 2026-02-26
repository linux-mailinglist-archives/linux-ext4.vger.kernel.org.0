Return-Path: <linux-ext4+bounces-14041-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCEGAYoqoGlrfwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14041-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:12:10 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7041D1A4E16
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BFB7304FA51
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6D336EE9;
	Thu, 26 Feb 2026 11:10:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E13358D8
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104247; cv=none; b=jEM+mKWwf6EHTxjh+KhxTc5faKQRtPBEHxEgj7D50U+0w5Na73VPVJ8XmNLeg8Ei0rueYmtorAFn1Y6hcAjfFItRG4xWDlLbiUgn+usFdEe63YpI0FrNy4TD3wETjhAtFd32YOD8ue6qInsN0gR+zmEZvx7zQ0ctY24xIJqGTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104247; c=relaxed/simple;
	bh=WNOhhf6If8sH5j7E7NhQtexv/NQlk1esPbD6UvM+VUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=te5JXJ0enw0nAQwAXkHebNLLs6+AH+I9ETv80AuxImp0RtmAkUyMhbAs2nUWXs5RbtOmuMoaP8KWUmbqUmODxPrwvvMvu0V7vmvMAyqA6JXmmfIYEHrCMWhGsv+S7CSjdslTDfH5xmXEQrI6ToBC1faINtjTHSi5azRpxDYcVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fM7zG5D42zYQtHv
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 19:10:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0AE184058F
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 19:10:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPkxKqBpw9NMIw--.27651S4;
	Thu, 26 Feb 2026 19:10:41 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH] ext4: fix mballoc-test.c is not compiled when EXT4_KUNIT_TESTS=M
Date: Thu, 26 Feb 2026 19:09:17 +0800
Message-Id: <20260226110917.1904980-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3WPkxKqBpw9NMIw--.27651S4
X-Coremail-Antispam: 1UD129KBjvAXoW3Cw48XF1ktryxAF4ruw4Uurg_yoW8Cr47Ko
	WIyF12qw48urWUtrW8CrW3J34DC3ykKay3Gr4F9rs8WF47Ar1Y9F12kw43Xr17Gw4IkFyI
	vasxXa43Ar4kCrZxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5d7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14041-lists,linux-ext4=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin@huaweicloud.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 7041D1A4E16
X-Rspamd-Action: no action

From: Ye Bin <yebin10@huawei.com>

Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
To solve this issue, the ext4 test code needs to be decoupled. The ext4
test module is compiled into a separate module.

Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Closes: https://patchwork.kernel.org/project/cifs-client/patch/20260118091313.1988168-2-chenxiaosong.chenxiaosong@linux.dev/
Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/Makefile       |   4 +-
 fs/ext4/mballoc-test.c |  81 ++++++++++++++++----------------
 fs/ext4/mballoc.c      | 102 +++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h      |  30 ++++++++++++
 4 files changed, 172 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 72206a292676..d836c3fe311b 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -14,7 +14,7 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
-ext4-inode-test-objs			+= inode-test.o
-obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
+ext4-test-objs				+= inode-test.o mballoc-test.o
+obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
 ext4-$(CONFIG_FS_ENCRYPTION)		+= crypto.o
diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 4abb40d4561c..749ed2fc2241 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -8,6 +8,7 @@
 #include <linux/random.h>
 
 #include "ext4.h"
+#include "mballoc.h"
 
 struct mbt_grp_ctx {
 	struct buffer_head bitmap_bh;
@@ -337,7 +338,7 @@ ext4_mb_mark_context_stub(handle_t *handle, struct super_block *sb, bool state,
 	if (state)
 		mb_set_bits(bitmap_bh->b_data, blkoff, len);
 	else
-		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
+		mb_clear_bits_test(bitmap_bh->b_data, blkoff, len);
 
 	return 0;
 }
@@ -414,14 +415,14 @@ static void test_new_blocks_simple(struct kunit *test)
 
 	/* get block at goal */
 	ar.goal = ext4_group_first_block_no(sb, goal_group);
-	found = ext4_mb_new_blocks_simple(&ar, &err);
+	found = ext4_mb_new_blocks_simple_test(&ar, &err);
 	KUNIT_ASSERT_EQ_MSG(test, ar.goal, found,
 		"failed to alloc block at goal, expected %llu found %llu",
 		ar.goal, found);
 
 	/* get block after goal in goal group */
 	ar.goal = ext4_group_first_block_no(sb, goal_group);
-	found = ext4_mb_new_blocks_simple(&ar, &err);
+	found = ext4_mb_new_blocks_simple_test(&ar, &err);
 	KUNIT_ASSERT_EQ_MSG(test, ar.goal + EXT4_C2B(sbi, 1), found,
 		"failed to alloc block after goal in goal group, expected %llu found %llu",
 		ar.goal + 1, found);
@@ -429,7 +430,7 @@ static void test_new_blocks_simple(struct kunit *test)
 	/* get block after goal group */
 	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
 	ar.goal = ext4_group_first_block_no(sb, goal_group);
-	found = ext4_mb_new_blocks_simple(&ar, &err);
+	found = ext4_mb_new_blocks_simple_test(&ar, &err);
 	KUNIT_ASSERT_EQ_MSG(test,
 		ext4_group_first_block_no(sb, goal_group + 1), found,
 		"failed to alloc block after goal group, expected %llu found %llu",
@@ -439,7 +440,7 @@ static void test_new_blocks_simple(struct kunit *test)
 	for (i = goal_group; i < ext4_get_groups_count(sb); i++)
 		mbt_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
 	ar.goal = ext4_group_first_block_no(sb, goal_group);
-	found = ext4_mb_new_blocks_simple(&ar, &err);
+	found = ext4_mb_new_blocks_simple_test(&ar, &err);
 	KUNIT_ASSERT_EQ_MSG(test,
 		ext4_group_first_block_no(sb, 0) + EXT4_C2B(sbi, 1), found,
 		"failed to alloc block before goal group, expected %llu found %llu",
@@ -449,7 +450,7 @@ static void test_new_blocks_simple(struct kunit *test)
 	for (i = 0; i < ext4_get_groups_count(sb); i++)
 		mbt_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
 	ar.goal = ext4_group_first_block_no(sb, goal_group);
-	found = ext4_mb_new_blocks_simple(&ar, &err);
+	found = ext4_mb_new_blocks_simple_test(&ar, &err);
 	KUNIT_ASSERT_NE_MSG(test, err, 0,
 		"unexpectedly get block when no block is available");
 }
@@ -493,16 +494,16 @@ validate_free_blocks_simple(struct kunit *test, struct super_block *sb,
 			continue;
 
 		bitmap = mbt_ctx_bitmap(sb, i);
-		bit = mb_find_next_zero_bit(bitmap, max, 0);
+		bit = mb_find_next_zero_bit_test(bitmap, max, 0);
 		KUNIT_ASSERT_EQ_MSG(test, bit, max,
 				    "free block on unexpected group %d", i);
 	}
 
 	bitmap = mbt_ctx_bitmap(sb, goal_group);
-	bit = mb_find_next_zero_bit(bitmap, max, 0);
+	bit = mb_find_next_zero_bit_test(bitmap, max, 0);
 	KUNIT_ASSERT_EQ(test, bit, start);
 
-	bit = mb_find_next_bit(bitmap, max, bit + 1);
+	bit = mb_find_next_bit_test(bitmap, max, bit + 1);
 	KUNIT_ASSERT_EQ(test, bit, start + len);
 }
 
@@ -525,7 +526,7 @@ test_free_blocks_simple_range(struct kunit *test, ext4_group_t goal_group,
 
 	block = ext4_group_first_block_no(sb, goal_group) +
 		EXT4_C2B(sbi, start);
-	ext4_free_blocks_simple(inode, block, len);
+	ext4_free_blocks_simple_test(inode, block, len);
 	validate_free_blocks_simple(test, sb, goal_group, start, len);
 	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
 }
@@ -567,15 +568,15 @@ test_mark_diskspace_used_range(struct kunit *test,
 
 	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
 	memset(bitmap, 0, sb->s_blocksize);
-	ret = ext4_mb_mark_diskspace_used(ac, NULL);
+	ret = ext4_mb_mark_diskspace_used_test(ac, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	max = EXT4_CLUSTERS_PER_GROUP(sb);
-	i = mb_find_next_bit(bitmap, max, 0);
+	i = mb_find_next_bit_test(bitmap, max, 0);
 	KUNIT_ASSERT_EQ(test, i, start);
-	i = mb_find_next_zero_bit(bitmap, max, i + 1);
+	i = mb_find_next_zero_bit_test(bitmap, max, i + 1);
 	KUNIT_ASSERT_EQ(test, i, start + len);
-	i = mb_find_next_bit(bitmap, max, i + 1);
+	i = mb_find_next_bit_test(bitmap, max, i + 1);
 	KUNIT_ASSERT_EQ(test, max, i);
 }
 
@@ -618,54 +619,54 @@ static void mbt_generate_buddy(struct super_block *sb, void *buddy,
 	max = EXT4_CLUSTERS_PER_GROUP(sb);
 	bb_h = buddy + sbi->s_mb_offsets[1];
 
-	off = mb_find_next_zero_bit(bb, max, 0);
+	off = mb_find_next_zero_bit_test(bb, max, 0);
 	grp->bb_first_free = off;
 	while (off < max) {
 		grp->bb_counters[0]++;
 		grp->bb_free++;
 
-		if (!(off & 1) && !mb_test_bit(off + 1, bb)) {
+		if (!(off & 1) && !mb_test_bit_test(off + 1, bb)) {
 			grp->bb_free++;
 			grp->bb_counters[0]--;
-			mb_clear_bit(off >> 1, bb_h);
+			mb_clear_bit_test(off >> 1, bb_h);
 			grp->bb_counters[1]++;
 			grp->bb_largest_free_order = 1;
 			off++;
 		}
 
-		off = mb_find_next_zero_bit(bb, max, off + 1);
+		off = mb_find_next_zero_bit_test(bb, max, off + 1);
 	}
 
 	for (order = 1; order < MB_NUM_ORDERS(sb) - 1; order++) {
 		bb = buddy + sbi->s_mb_offsets[order];
 		bb_h = buddy + sbi->s_mb_offsets[order + 1];
 		max = max >> 1;
-		off = mb_find_next_zero_bit(bb, max, 0);
+		off = mb_find_next_zero_bit_test(bb, max, 0);
 
 		while (off < max) {
-			if (!(off & 1) && !mb_test_bit(off + 1, bb)) {
+			if (!(off & 1) && !mb_test_bit_test(off + 1, bb)) {
 				mb_set_bits(bb, off, 2);
 				grp->bb_counters[order] -= 2;
-				mb_clear_bit(off >> 1, bb_h);
+				mb_clear_bit_test(off >> 1, bb_h);
 				grp->bb_counters[order + 1]++;
 				grp->bb_largest_free_order = order + 1;
 				off++;
 			}
 
-			off = mb_find_next_zero_bit(bb, max, off + 1);
+			off = mb_find_next_zero_bit_test(bb, max, off + 1);
 		}
 	}
 
 	max = EXT4_CLUSTERS_PER_GROUP(sb);
-	off = mb_find_next_zero_bit(bitmap, max, 0);
+	off = mb_find_next_zero_bit_test(bitmap, max, 0);
 	while (off < max) {
 		grp->bb_fragments++;
 
-		off = mb_find_next_bit(bitmap, max, off + 1);
+		off = mb_find_next_bit_test(bitmap, max, off + 1);
 		if (off + 1 >= max)
 			break;
 
-		off = mb_find_next_zero_bit(bitmap, max, off + 1);
+		off = mb_find_next_zero_bit_test(bitmap, max, off + 1);
 	}
 }
 
@@ -707,7 +708,7 @@ do_test_generate_buddy(struct kunit *test, struct super_block *sb, void *bitmap,
 	/* needed by validation in ext4_mb_generate_buddy */
 	ext4_grp->bb_free = mbt_grp->bb_free;
 	memset(ext4_buddy, 0xff, sb->s_blocksize);
-	ext4_mb_generate_buddy(sb, ext4_buddy, bitmap, TEST_GOAL_GROUP,
+	ext4_mb_generate_buddy_test(sb, ext4_buddy, bitmap, TEST_GOAL_GROUP,
 			       ext4_grp);
 
 	KUNIT_ASSERT_EQ(test, memcmp(mbt_buddy, ext4_buddy, sb->s_blocksize),
@@ -761,7 +762,7 @@ test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
 	ex.fe_group = TEST_GOAL_GROUP;
 
 	ext4_lock_group(sb, TEST_GOAL_GROUP);
-	mb_mark_used(e4b, &ex);
+	mb_mark_used_test(e4b, &ex);
 	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	mb_set_bits(bitmap, start, len);
@@ -770,7 +771,7 @@ test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
 	memset(buddy, 0xff, sb->s_blocksize);
 	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
 		grp->bb_counters[i] = 0;
-	ext4_mb_generate_buddy(sb, buddy, bitmap, 0, grp);
+	ext4_mb_generate_buddy_test(sb, buddy, bitmap, 0, grp);
 
 	KUNIT_ASSERT_EQ(test, memcmp(buddy, e4b->bd_buddy, sb->s_blocksize),
 			0);
@@ -799,7 +800,7 @@ static void test_mb_mark_used(struct kunit *test)
 				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
 
-	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
+	ret = ext4_mb_load_buddy_test(sb, TEST_GOAL_GROUP, &e4b);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
@@ -810,7 +811,7 @@ static void test_mb_mark_used(struct kunit *test)
 		test_mb_mark_used_range(test, &e4b, ranges[i].start,
 					ranges[i].len, bitmap, buddy, grp);
 
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_buddy_test(&e4b);
 }
 
 static void
@@ -826,16 +827,16 @@ test_mb_free_blocks_range(struct kunit *test, struct ext4_buddy *e4b,
 		return;
 
 	ext4_lock_group(sb, e4b->bd_group);
-	mb_free_blocks(NULL, e4b, start, len);
+	mb_free_blocks_test(NULL, e4b, start, len);
 	ext4_unlock_group(sb, e4b->bd_group);
 
-	mb_clear_bits(bitmap, start, len);
+	mb_clear_bits_test(bitmap, start, len);
 	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
 	grp->bb_free += len;
 	memset(buddy, 0xff, sb->s_blocksize);
 	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
 		grp->bb_counters[i] = 0;
-	ext4_mb_generate_buddy(sb, buddy, bitmap, 0, grp);
+	ext4_mb_generate_buddy_test(sb, buddy, bitmap, 0, grp);
 
 	KUNIT_ASSERT_EQ(test, memcmp(buddy, e4b->bd_buddy, sb->s_blocksize),
 			0);
@@ -866,7 +867,7 @@ static void test_mb_free_blocks(struct kunit *test)
 				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, grp);
 
-	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
+	ret = ext4_mb_load_buddy_test(sb, TEST_GOAL_GROUP, &e4b);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ex.fe_start = 0;
@@ -874,7 +875,7 @@ static void test_mb_free_blocks(struct kunit *test)
 	ex.fe_group = TEST_GOAL_GROUP;
 
 	ext4_lock_group(sb, TEST_GOAL_GROUP);
-	mb_mark_used(&e4b, &ex);
+	mb_mark_used_test(&e4b, &ex);
 	ext4_unlock_group(sb, TEST_GOAL_GROUP);
 
 	grp->bb_free = 0;
@@ -887,7 +888,7 @@ static void test_mb_free_blocks(struct kunit *test)
 		test_mb_free_blocks_range(test, &e4b, ranges[i].start,
 					  ranges[i].len, bitmap, buddy, grp);
 
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_buddy_test(&e4b);
 }
 
 #define COUNT_FOR_ESTIMATE 100000
@@ -905,7 +906,7 @@ static void test_mb_mark_used_cost(struct kunit *test)
 	if (sb->s_blocksize > PAGE_SIZE)
 		kunit_skip(test, "blocksize exceeds pagesize");
 
-	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
+	ret = ext4_mb_load_buddy_test(sb, TEST_GOAL_GROUP, &e4b);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ex.fe_group = TEST_GOAL_GROUP;
@@ -919,7 +920,7 @@ static void test_mb_mark_used_cost(struct kunit *test)
 			ex.fe_start = ranges[i].start;
 			ex.fe_len = ranges[i].len;
 			ext4_lock_group(sb, TEST_GOAL_GROUP);
-			mb_mark_used(&e4b, &ex);
+			mb_mark_used_test(&e4b, &ex);
 			ext4_unlock_group(sb, TEST_GOAL_GROUP);
 		}
 		end = jiffies;
@@ -930,14 +931,14 @@ static void test_mb_mark_used_cost(struct kunit *test)
 				continue;
 
 			ext4_lock_group(sb, TEST_GOAL_GROUP);
-			mb_free_blocks(NULL, &e4b, ranges[i].start,
+			mb_free_blocks_test(NULL, &e4b, ranges[i].start,
 				       ranges[i].len);
 			ext4_unlock_group(sb, TEST_GOAL_GROUP);
 		}
 	}
 
 	kunit_info(test, "costed jiffies %lu\n", all);
-	ext4_mb_unload_buddy(&e4b);
+	ext4_mb_unload_buddy_test(&e4b);
 }
 
 static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b99d1a7e580e..bd40fc4d3d93 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4086,7 +4086,7 @@ void ext4_exit_mballoc(void)
 
 #define EXT4_MB_BITMAP_MARKED_CHECK 0x0001
 #define EXT4_MB_SYNC_UPDATE 0x0002
-static int
+int
 ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
 		     ext4_group_t group, ext4_grpblk_t blkoff,
 		     ext4_grpblk_t len, int flags, ext4_grpblk_t *ret_changed)
@@ -7190,6 +7190,102 @@ ext4_mballoc_query_range(
 	return error;
 }
 
-#ifdef CONFIG_EXT4_KUNIT_TESTS
-#include "mballoc-test.c"
+#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
+void mb_clear_bits_test(void *bm, int cur, int len)
+{
+	 mb_clear_bits(bm, cur, len);
+}
+EXPORT_SYMBOL_GPL(mb_clear_bits_test);
+
+ext4_fsblk_t
+ext4_mb_new_blocks_simple_test(struct ext4_allocation_request *ar,
+			       int *errp)
+{
+	return ext4_mb_new_blocks_simple(ar, errp);
+}
+EXPORT_SYMBOL_GPL(ext4_mb_new_blocks_simple_test);
+
+int mb_find_next_zero_bit_test(void *addr, int max, int start)
+{
+	return mb_find_next_zero_bit(addr, max, start);
+}
+EXPORT_SYMBOL_GPL(mb_find_next_zero_bit_test);
+
+int mb_find_next_bit_test(void *addr, int max, int start)
+{
+	return mb_find_next_bit(addr, max, start);
+}
+EXPORT_SYMBOL_GPL(mb_find_next_bit_test);
+
+void mb_clear_bit_test(int bit, void *addr)
+{
+	mb_clear_bit(bit, addr);
+}
+EXPORT_SYMBOL_GPL(mb_clear_bit_test);
+
+int mb_test_bit_test(int bit, void *addr)
+{
+	return mb_test_bit(bit, addr);
+}
+EXPORT_SYMBOL_GPL(mb_test_bit_test);
+
+int ext4_mb_mark_diskspace_used_test(struct ext4_allocation_context *ac,
+				     handle_t *handle)
+{
+	return ext4_mb_mark_diskspace_used(ac, handle);
+}
+EXPORT_SYMBOL_GPL(ext4_mb_mark_diskspace_used_test);
+
+int mb_mark_used_test(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
+{
+	return mb_mark_used(e4b, ex);
+}
+EXPORT_SYMBOL_GPL(mb_mark_used_test);
+
+void ext4_mb_generate_buddy_test(struct super_block *sb, void *buddy,
+				 void *bitmap, ext4_group_t group,
+				 struct ext4_group_info *grp)
+{
+	ext4_mb_generate_buddy(sb, buddy, bitmap, group, grp);
+}
+EXPORT_SYMBOL_GPL(ext4_mb_generate_buddy_test);
+
+int ext4_mb_load_buddy_test(struct super_block *sb, ext4_group_t group,
+			    struct ext4_buddy *e4b)
+{
+	return ext4_mb_load_buddy(sb, group, e4b);
+}
+EXPORT_SYMBOL_GPL(ext4_mb_load_buddy_test);
+
+void ext4_mb_unload_buddy_test(struct ext4_buddy *e4b)
+{
+	ext4_mb_unload_buddy(e4b);
+}
+EXPORT_SYMBOL_GPL(ext4_mb_unload_buddy_test);
+
+void mb_free_blocks_test(struct inode *inode, struct ext4_buddy *e4b,
+			 int first, int count)
+{
+	mb_free_blocks(inode, e4b, first, count);
+}
+EXPORT_SYMBOL_GPL(mb_free_blocks_test);
+
+void ext4_free_blocks_simple_test(struct inode *inode, ext4_fsblk_t block,
+				  unsigned long count)
+{
+	return ext4_free_blocks_simple(inode, block, count);
+}
+EXPORT_SYMBOL_GPL(ext4_free_blocks_simple_test);
+
+EXPORT_SYMBOL_GPL(ext4_wait_block_bitmap);
+EXPORT_SYMBOL_GPL(ext4_mb_init);
+EXPORT_SYMBOL_GPL(ext4_get_group_desc);
+EXPORT_SYMBOL_GPL(ext4_count_free_clusters);
+EXPORT_SYMBOL_GPL(ext4_get_group_info);
+EXPORT_SYMBOL_GPL(ext4_free_group_clusters_set);
+EXPORT_SYMBOL_GPL(ext4_mb_release);
+EXPORT_SYMBOL_GPL(ext4_read_block_bitmap_nowait);
+EXPORT_SYMBOL_GPL(mb_set_bits);
+EXPORT_SYMBOL_GPL(ext4_fc_init_inode);
+EXPORT_SYMBOL_GPL(ext4_mb_mark_context);
 #endif
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 15a049f05d04..b32e03e7ae8d 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -270,4 +270,34 @@ ext4_mballoc_query_range(
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
+#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
+extern void mb_clear_bits_test(void *bm, int cur, int len);
+extern int ext4_mb_mark_context(handle_t *handle,
+		struct super_block *sb, bool state,
+		ext4_group_t group, ext4_grpblk_t blkoff,
+		ext4_grpblk_t len, int flags,
+		ext4_grpblk_t *ret_changed);
+extern ext4_fsblk_t
+ext4_mb_new_blocks_simple_test(struct ext4_allocation_request *ar,
+			       int *errp);
+extern int mb_find_next_zero_bit_test(void *addr, int max, int start);
+extern int mb_find_next_bit_test(void *addr, int max, int start);
+extern void mb_clear_bit_test(int bit, void *addr);
+extern int mb_test_bit_test(int bit, void *addr);
+extern int
+ext4_mb_mark_diskspace_used_test(struct ext4_allocation_context *ac,
+				 handle_t *handle);
+extern int mb_mark_used_test(struct ext4_buddy *e4b,
+			     struct ext4_free_extent *ex);
+extern void ext4_mb_generate_buddy_test(struct super_block *sb,
+		void *buddy, void *bitmap, ext4_group_t group,
+		struct ext4_group_info *grp);
+extern int ext4_mb_load_buddy_test(struct super_block *sb,
+		ext4_group_t group, struct ext4_buddy *e4b);
+extern void ext4_mb_unload_buddy_test(struct ext4_buddy *e4b);
+extern void mb_free_blocks_test(struct inode *inode,
+		struct ext4_buddy *e4b, int first, int count);
+extern void ext4_free_blocks_simple_test(struct inode *inode,
+		ext4_fsblk_t block, unsigned long count);
+#endif
 #endif
-- 
2.34.1


