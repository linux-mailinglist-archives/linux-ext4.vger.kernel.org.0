Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20901969AC
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Mar 2020 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgC1VyQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 17:54:16 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48987 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgC1VyQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 17:54:16 -0400
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CD9A660004;
        Sat, 28 Mar 2020 21:54:11 +0000 (UTC)
Date:   Sat, 28 Mar 2020 14:54:01 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error
 message
Message-ID: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_fill_super doublechecks the number of groups before mounting; if
that check fails, the resulting error message prints the group count
from the ext4_sb_info sbi, which hasn't been set yet. Print the freshly
computed group count instead (which at that point has just been computed
in "blocks_count").

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock before mounting the filesystem")
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c7c4adb664e..7f5f37653a03 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4288,7 +4288,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
 		ext4_msg(sb, KERN_WARNING, "groups count too large: %u "
 		       "(block count %llu, first data block %u, "
-		       "blocks per group %lu)", sbi->s_groups_count,
+		       "blocks per group %lu)", blocks_count,
 		       ext4_blocks_count(es),
 		       le32_to_cpu(es->s_first_data_block),
 		       EXT4_BLOCKS_PER_GROUP(sb));
-- 
2.26.0
