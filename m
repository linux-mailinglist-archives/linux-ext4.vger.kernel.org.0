Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547DE196A18
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgC1XoL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 19:44:11 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52855 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1XoL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 19:44:11 -0400
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DCE9960005;
        Sat, 28 Mar 2020 23:44:07 +0000 (UTC)
Date:   Sat, 28 Mar 2020 16:43:58 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH v2] ext4: Fix incorrect group count in ext4_fill_super error
 message
Message-ID: <28c22b1845796e52b5fe2832432e859af023ee1b.1585438486.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_fill_super doublechecks the number of groups before mounting; if
that check fails, the resulting error message prints the group count
from the ext4_sb_info sbi, which hasn't been set yet. Move the
assignment to sbi->s_groups_count above its use in the error message.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock before mounting the filesystem")
---
v2: Rather than using the computed group count value in blocks_count,
move the assignment to sbi->s_groups_count up and keep using that. That
makes the code, and the patch, simpler to read and understand.

 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c7c4adb664e..6692bc48520a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4285,6 +4285,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			le32_to_cpu(es->s_first_data_block) +
 			EXT4_BLOCKS_PER_GROUP(sb) - 1);
 	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
+	sbi->s_groups_count = blocks_count;
 	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
 		ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
 		       "(block count %llu, first data block %u, "
@@ -4294,7 +4295,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		       EXT4_BLOCKS_PER_GROUP(sb));
 		goto failed_mount;
 	}
-	sbi->s_groups_count = blocks_count;
 	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
 			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
 	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
-- 
2.26.0

