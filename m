Return-Path: <linux-ext4+bounces-820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7BA82E778
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F941C22BEC
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB19A41A92;
	Tue, 16 Jan 2024 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfaq0Y4I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5641228;
	Tue, 16 Jan 2024 01:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248F3C433C7;
	Tue, 16 Jan 2024 01:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367318;
	bh=7y6jgnmOzbH2wRt46wf+NH/QsbV5cy+l4rg+jSvlZuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xfaq0Y4IdFgdGFGipXP0OxJsf4beW4+AiDy00V7ejUeGcmleHJJp8HXlRMejPpkP2
	 I4RtjHImfFygDN9jmhbgYqG9udTI6ScQSpRH2P3CH7tCVdMkQBjBAvk0qbUWN9FSrq
	 mc4cIHdnvyraMdWLvLUn517J6Qk8jcMUYV+Zx7UIJAKfByYzUE5xHmIMQxoHrFBVo3
	 JexowFfzeGBA11obxVF9spY0jC8uH1RbLlyU3EQ3GO9QNiGX5iUDnQs+34YuX3IFsE
	 P2hrc+X8eO0eigD8GHTPk4kklJWpQTugjN64sAsChdSJwpMxVTjeURNi6jTywwp3sH
	 0wyLGHr49f8uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 9/9] ext4: avoid online resizing failures due to oversized flex bg
Date: Mon, 15 Jan 2024 20:08:15 -0500
Message-ID: <20240116010819.219701-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010819.219701-1-sashal@kernel.org>
References: <20240116010819.219701-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 5d1935ac02ca5aee364a449a35e2977ea84509b0 ]

When we online resize an ext4 filesystem with a oversized flexbg_size,

     mkfs.ext4 -F -G 67108864 $dev -b 4096 100M
     mount $dev $dir
     resize2fs $dev 16G

the following WARN_ON is triggered:
==================================================================
WARNING: CPU: 0 PID: 427 at mm/page_alloc.c:4402 __alloc_pages+0x411/0x550
Modules linked in: sg(E)
CPU: 0 PID: 427 Comm: resize2fs Tainted: G  E  6.6.0-rc5+ #314
RIP: 0010:__alloc_pages+0x411/0x550
Call Trace:
 <TASK>
 __kmalloc_large_node+0xa2/0x200
 __kmalloc+0x16e/0x290
 ext4_resize_fs+0x481/0xd80
 __ext4_ioctl+0x1616/0x1d90
 ext4_ioctl+0x12/0x20
 __x64_sys_ioctl+0xf0/0x150
 do_syscall_64+0x3b/0x90
==================================================================

This is because flexbg_size is too large and the size of the new_group_data
array to be allocated exceeds MAX_ORDER. Currently, the minimum value of
MAX_ORDER is 8, the minimum value of PAGE_SIZE is 4096, the corresponding
maximum number of groups that can be allocated is:

 (PAGE_SIZE << MAX_ORDER) / sizeof(struct ext4_new_group_data) ≈ 21845

And the value that is down-aligned to the power of 2 is 16384. Therefore,
this value is defined as MAX_RESIZE_BG, and the number of groups added
each time does not exceed this value during resizing, and is added multiple
times to complete the online resizing. The difference is that the metadata
in a flex_bg may be more dispersed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231023013057.2117948-4-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 682596f3205f..409b4ad28e71 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -227,10 +227,17 @@ struct ext4_new_flex_group_data {
 						   in the flex group */
 	__u16 *bg_flags;			/* block group flags of groups
 						   in @groups */
+	ext4_group_t resize_bg;			/* number of allocated
+						   new_group_data */
 	ext4_group_t count;			/* number of groups in @groups
 						 */
 };
 
+/*
+ * Avoiding memory allocation failures due to too many groups added each time.
+ */
+#define MAX_RESIZE_BG				16384
+
 /*
  * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
  * @flexbg_size.
@@ -245,14 +252,18 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 	if (flex_gd == NULL)
 		goto out3;
 
-	flex_gd->count = flexbg_size;
-	flex_gd->groups = kmalloc_array(flexbg_size,
+	if (unlikely(flexbg_size > MAX_RESIZE_BG))
+		flex_gd->resize_bg = MAX_RESIZE_BG;
+	else
+		flex_gd->resize_bg = flexbg_size;
+
+	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
 	if (flex_gd->groups == NULL)
 		goto out2;
 
-	flex_gd->bg_flags = kmalloc_array(flexbg_size, sizeof(__u16),
+	flex_gd->bg_flags = kmalloc_array(flex_gd->resize_bg, sizeof(__u16),
 					  GFP_NOFS);
 	if (flex_gd->bg_flags == NULL)
 		goto out1;
@@ -1581,8 +1592,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
-				    ext4_fsblk_t n_blocks_count,
-				    unsigned int flexbg_size)
+				    ext4_fsblk_t n_blocks_count)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -1606,7 +1616,7 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
 	BUG_ON(last);
 	ext4_get_group_no_and_offset(sb, n_blocks_count - 1, &n_group, &last);
 
-	last_group = group | (flexbg_size - 1);
+	last_group = group | (flex_gd->resize_bg - 1);
 	if (last_group > n_group)
 		last_group = n_group;
 
@@ -2103,8 +2113,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	/* Add flex groups. Note that a regular group is a
 	 * flex group with 1 group.
 	 */
-	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count,
-					      flexbg_size)) {
+	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count)) {
 		if (jiffies - last_update_time > HZ * 10) {
 			if (last_update_time)
 				ext4_msg(sb, KERN_INFO,
-- 
2.43.0


