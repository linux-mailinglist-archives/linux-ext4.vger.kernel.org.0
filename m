Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE561969D7
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Mar 2020 23:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgC1We3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 18:34:29 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50115 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgC1We3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 18:34:29 -0400
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E4C8A1C0004;
        Sat, 28 Mar 2020 22:34:25 +0000 (UTC)
Date:   Sat, 28 Mar 2020 15:34:15 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH] ext4: Fix incorrect inodes per group in error message
Message-ID: <8be03355983a08e5d4eed480944613454d7e2550.1585434649.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ext4_fill_super detects an invalid number of inodes per group, the
resulting error message printed the number of blocks per group, rather
than the number of inodes per group. Fix it to print the correct value.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Fixes: cd6bb35bf7f6d ("ext4: use more strict checks for inodes_per_block on mount")
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c7c4adb664e..c50922fa780a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4157,7 +4157,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > blocksize * 8) {
 		ext4_msg(sb, KERN_ERR, "invalid inodes per group: %lu\n",
-			 sbi->s_blocks_per_group);
+			 sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
 	sbi->s_itb_per_group = sbi->s_inodes_per_group /
-- 
2.26.0

