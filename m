Return-Path: <linux-ext4+bounces-801-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3982E6E3
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29B3B20FAE
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D1224D8;
	Tue, 16 Jan 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbJfQoCF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED688224C7;
	Tue, 16 Jan 2024 01:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033FEC43390;
	Tue, 16 Jan 2024 01:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367173;
	bh=zS87hTq9f8JJJ56z1N67FjwHZ1y5nTUs1aJLsUBN2Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbJfQoCFVmTpvU8j5Y5QVrje7HwXbhbMdomM2CLDNbCtTWVJnxLljmyxPIDBz5/fM
	 2FsquPIix3ExH9hyI6gKGjBgWrj2n7q0kwYaLq1+ylDkJRed9YzHIWNIKzbp6zNO9S
	 zGIxpPShPUeHq87UkFkPPi2HoVyv0TXWRormBM4y+ZrKiGKVTQ+vYiCXGMYLxGQNOP
	 gSLxQLULseSoDdJNuVPljNL3x0f91r96qtHqG/t1F7ZzuG8B1gn6dGdZ84DXTNlgvN
	 bDoYt2CsUv1DGFSL0eNQYthVnUZRVbRpl9GlxOze8wLJLMBscg8ODHSgXl8NIP1yId
	 DhAAluK/3xUNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/19] ext4: unify the type of flexbg_size to unsigned int
Date: Mon, 15 Jan 2024 20:05:12 -0500
Message-ID: <20240116010532.218428-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 667381180b26..f3a9b97bb7e7 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -241,7 +241,7 @@ struct ext4_new_flex_group_data {
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 {
 	struct ext4_new_flex_group_data *flex_gd;
 
@@ -296,7 +296,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
 				struct ext4_new_flex_group_data *flex_gd,
-				int flexbg_size)
+				unsigned int flexbg_size)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -397,12 +397,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
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
@@ -1623,7 +1623,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
 				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    unsigned int flexbg_size)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -2007,8 +2007,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
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


