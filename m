Return-Path: <linux-ext4+bounces-1406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933E869BCE
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC4F1F27AD8
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A914830A;
	Tue, 27 Feb 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef3Jo3Li"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B31474B0;
	Tue, 27 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050562; cv=none; b=Qoqt+3b9FXXZiDzqfttLPhjJi5kRKEDZ33z5+rEdSyEX825qV+uKf4wFAJXaxwinadPYbWNO0i3f06kXwfnb1VPwmN0afUW8hq4ayMpDt3iXDZCWV2LnUNQ7ABvVDMwbvC18CML03BjZJlCvZzcSMn50BM0QgBC2yuZc5MwHPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050562; c=relaxed/simple;
	bh=rAUcFZjcQztUVMKvFPprvfUZ+DjGOWduITQ7I1pUtvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cN2EaP3CUHmHuT3ypwmEsLJci7WZJcUlyt+fesNeoMLcuTJBUVzzqsmKT7LAgnOx5CXJHqlf/cVf3QTC8QJxHOy5cas0HtHQ6Ru/TrTFyBXqnTe1eFvBqAE3xBKM0roiKrvqkLdvw3gZ37VFzjYRrP3zl6X6hiDP1u72tMgEySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef3Jo3Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEFCC433C7;
	Tue, 27 Feb 2024 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050560;
	bh=rAUcFZjcQztUVMKvFPprvfUZ+DjGOWduITQ7I1pUtvM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ef3Jo3LiGmBxEmLRS8oa+hTrClXtsgp2WW1PQEQPevSva8so4N+zEbyUT/2yVDpSh
	 5aAb3gQHgmrtbqXrVmw8IXJTlNkgtNBPZiOztf11xNwbYeLjVUPBarg/hEg6isFpcG
	 FuF7OltHj13mo7rXMuLASrqP49K6B70U0MydPwG7VhCEqJcf/1Nn9/wpU6xPVc/fj8
	 qZRpvNxgoqwny7lqmC8J0rVvuPHOlG8zfCVxoLjfsO/reQQ+TXJzcCAEUbPf2E7t8h
	 /JzVMQKTS7VKRqFG7f0hDyt9VjJJjVPZcsMdAsqY1yIe7tvt9Lfk+KI12Npu2Gjur3
	 sxuYunja7y9jg==
From: Arnd Bergmann <arnd@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: kunit: use dynamic inode allocation
Date: Tue, 27 Feb 2024 17:15:39 +0100
Message-Id: <20240227161548.2929881-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Storing an inode structure on the stack pushes some functions over the warning
limit for stack frame size:

In file included from fs/ext4/mballoc.c:7039:
fs/ext4/mballoc-test.c:506:13: error: stack frame size (1032) exceeds limit (1024) in 'test_mark_diskspace_used' [-Werror,-Wframe-larger-than]
  506 | static void test_mark_diskspace_used(struct kunit *test)
      |             ^

Use kunit_kzalloc() for all inodes. There may be a better way to do it by
preallocating the inode, which would result in a larger rework.

Fixes: 2b81493f8eb6 ("ext4: Add unit test for ext4_mb_mark_diskspace_used")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/mballoc-test.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 12d0b22cabe1..3b43301054b6 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -332,14 +332,19 @@ static void mbt_kunit_exit(struct kunit *test)
 static void test_new_blocks_simple(struct kunit *test)
 {
 	struct super_block *sb = (struct super_block *)test->priv;
-	struct inode inode = { .i_sb = sb, };
+	struct inode *inode;
 	struct ext4_allocation_request ar;
 	ext4_group_t i, goal_group = TEST_GOAL_GROUP;
 	int err = 0;
 	ext4_fsblk_t found;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	ar.inode = &inode;
+	inode = kunit_kzalloc(test, sizeof(*inode), GFP_KERNEL);
+	if (!inode)
+		return;
+
+	inode->i_sb = sb;
+	ar.inode = inode;
 
 	/* get block at goal */
 	ar.goal = ext4_group_first_block_no(sb, goal_group);
@@ -441,15 +446,20 @@ test_free_blocks_simple_range(struct kunit *test, ext4_group_t goal_group,
 {
 	struct super_block *sb = (struct super_block *)test->priv;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct inode inode = { .i_sb = sb, };
+	struct inode *inode;
 	ext4_fsblk_t block;
 
+	inode = kunit_kzalloc(test, sizeof(*inode), GFP_KERNEL);
+	if (!inode)
+		return;
+	inode->i_sb = sb;
+
 	if (len == 0)
 		return;
 
 	block = ext4_group_first_block_no(sb, goal_group) +
 		EXT4_C2B(sbi, start);
-	ext4_free_blocks_simple(&inode, block, len);
+	ext4_free_blocks_simple(inode, block, len);
 	validate_free_blocks_simple(test, sb, goal_group, start, len);
 	mbt_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
 }
@@ -506,16 +516,21 @@ test_mark_diskspace_used_range(struct kunit *test,
 static void test_mark_diskspace_used(struct kunit *test)
 {
 	struct super_block *sb = (struct super_block *)test->priv;
-	struct inode inode = { .i_sb = sb, };
+	struct inode *inode;
 	struct ext4_allocation_context ac;
 	struct test_range ranges[TEST_RANGE_COUNT];
 	int i;
 
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
 
+	inode = kunit_kzalloc(test, sizeof(*inode), GFP_KERNEL);
+	if (!inode)
+		return;
+	inode->i_sb = sb;
+
 	ac.ac_status = AC_STATUS_FOUND;
 	ac.ac_sb = sb;
-	ac.ac_inode = &inode;
+	ac.ac_inode = inode;
 	for (i = 0; i < TEST_RANGE_COUNT; i++)
 		test_mark_diskspace_used_range(test, &ac, ranges[i].start,
 					       ranges[i].len);
-- 
2.39.2


