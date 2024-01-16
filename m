Return-Path: <linux-ext4+bounces-810-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8282E736
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433FD1C22B4D
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE62C86B;
	Tue, 16 Jan 2024 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKP1woj6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5B2C85C;
	Tue, 16 Jan 2024 01:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FD6C43390;
	Tue, 16 Jan 2024 01:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367270;
	bh=fxT45cPAEaGEGf83D8rfOsNr83w5bcfQ9SMEjjP2rOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKP1woj6gTiVsL8vvBcNP7efQB9VLdp+MYuKR8aXLQMAqvOnSqyq1a737HhO57Rk3
	 dhnPps+B/EPWr2NE//sb/wtGwTYeeIbBVNdUkVs0rSORI1HQ1EODs1Aq8DwB1rcZNV
	 mdvBBxGyYaTELMDncrtEWAAXADd+O8DymbtxLSQi5rH+eOjP9YVRMRT94/UkJ/rSm0
	 /2bEE58UoCLJVXNN8tIrJ9JGmqgyL4wiMtRpZQwDsqAoc65KtRXkEntEGhoIAPLIcT
	 0bz3948R+JBOvonPPjBy6hfmF7SES5relMUByHYEvujLLpWMW5mghnpdzxju6xI2nM
	 BSVKeOFi6+yjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/11] ext4: unify the type of flexbg_size to unsigned int
Date: Mon, 15 Jan 2024 20:07:09 -0500
Message-ID: <20240116010729.219219-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010729.219219-1-sashal@kernel.org>
References: <20240116010729.219219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index d0c41343a5c4..492683235423 100644
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
@@ -1577,7 +1577,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
 				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    unsigned int flexbg_size)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -1963,8 +1963,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
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


