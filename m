Return-Path: <linux-ext4+bounces-814-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8E82E754
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8C1F23930
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FA31A89;
	Tue, 16 Jan 2024 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE9z6R7V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044331759;
	Tue, 16 Jan 2024 01:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC313C433B1;
	Tue, 16 Jan 2024 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367291;
	bh=0lYWFdqEBdyhAqzESI/UXvYDjK+wohA+GeALRKu3lHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE9z6R7VhMfhQuGhzHXxLc2S3o82LpELQs8+4R2knHM5bcjvzOsFSqVdxuzs91oG8
	 NSuZMemOR9q6QISBOn9jcLDaqX7Vt/4erDEOH1vAzLFnDq/KAkrLFYEWQkpd6nCfTk
	 Eip2+P6XG0i2BjjPaO82drYclffUoxHgEyTF6jGgtmD4Bx7DVUw1tTlVD8u9CdDv5t
	 XYAtmCn7QOkCaNSskEvSe1L68+z+79cVyEx7yev0o+dCfzH7DDVBIRL9y/MPKLNOgj
	 PULRvL36sI53Ir4Pvbe8h9gmgaUyKAF0ep3FEfZBKtIld6ofUAR9EoZf/8GPx5MM81
	 5DudpSqiFlp9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 7/9] ext4: unify the type of flexbg_size to unsigned int
Date: Mon, 15 Jan 2024 20:07:51 -0500
Message-ID: <20240116010757.219495-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010757.219495-1-sashal@kernel.org>
References: <20240116010757.219495-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 658a52344fb139f9531e7543a6e0015b630feb38 ]

The maximum value of flexbg_size is 2^31, but the maximum value of int
is (2^31 - 1), so overflow may occur when the type of flexbg_size is
declared as int.

For example, when uninit_mask is initialized in ext4_alloc_group_tables(),
if flexbg_size == 2^31, the initialized uninit_mask is incorrect, and this
may causes set_flexbg_block_bitmap() to trigger a BUG_ON().

Therefore, the flexbg_size type is declared as unsigned int to avoid
overflow and memory waste.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231023013057.2117948-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 9b4199a1e039..96d278688fd7 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -237,7 +237,7 @@ struct ext4_new_flex_group_data {
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 {
 	struct ext4_new_flex_group_data *flex_gd;
 
@@ -292,7 +292,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
 				struct ext4_new_flex_group_data *flex_gd,
-				int flexbg_size)
+				unsigned int flexbg_size)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -393,12 +393,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 		group = group_data[0].group;
 
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
-		       "%d groups, flexbg size is %d:\n", flex_gd->count,
+		       "%u groups, flexbg size is %u:\n", flex_gd->count,
 		       flexbg_size);
 
 		for (i = 0; i < flex_gd->count; i++) {
 			ext4_debug(
-			       "adding %s group %u: %u blocks (%d free, %d mdata blocks)\n",
+			       "adding %s group %u: %u blocks (%u free, %u mdata blocks)\n",
 			       ext4_bg_has_super(sb, group + i) ? "normal" :
 			       "no-super", group + i,
 			       group_data[i].blocks_count,
@@ -1563,7 +1563,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
 				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    unsigned int flexbg_size)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -1941,8 +1941,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	ext4_fsblk_t o_blocks_count;
 	ext4_fsblk_t n_blocks_count_retry = 0;
 	unsigned long last_update_time = 0;
-	int err = 0, flexbg_size = 1 << sbi->s_log_groups_per_flex;
+	int err = 0;
 	int meta_bg;
+	unsigned int flexbg_size = ext4_flex_bg_size(sbi);
 
 	/* See if the device is actually as big as what was requested */
 	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
-- 
2.43.0


