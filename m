Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326DF39E749
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFGTRG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 15:17:06 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54025 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFGTRE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 15:17:04 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 47F2E240004;
        Mon,  7 Jun 2021 19:15:09 +0000 (UTC)
Date:   Mon, 7 Jun 2021 12:15:08 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] fs: ext4: Consolidate checks for resize of bigalloc into
 ext4_resize_begin
Message-ID: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Two different places checked for attempts to resize a filesystem with
the bigalloc feature. Move the check into ext4_resize_begin, which both
places already call.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 fs/ext4/ioctl.c  | 14 --------------
 fs/ext4/resize.c |  5 +++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 31627f7dc5cd..48a7aace337c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -693,13 +693,6 @@ static long ext4_ioctl_group_add(struct file *file,
 	if (err)
 		return err;
 
-	if (ext4_has_feature_bigalloc(sb)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Online resizing not supported with bigalloc");
-		err = -EOPNOTSUPP;
-		goto group_add_out;
-	}
-
 	err = mnt_want_write_file(file);
 	if (err)
 		goto group_add_out;
@@ -871,13 +864,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto group_extend_out;
 		}
 
-		if (ext4_has_feature_bigalloc(sb)) {
-			ext4_msg(sb, KERN_ERR,
-				 "Online resizing not supported with bigalloc");
-			err = -EOPNOTSUPP;
-			goto group_extend_out;
-		}
-
 		err = mnt_want_write_file(filp);
 		if (err)
 			goto group_extend_out;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index bd0d185654f3..d13bb9e76482 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -74,6 +74,11 @@ int ext4_resize_begin(struct super_block *sb)
 		return -EPERM;
 	}
 
+	if (ext4_has_feature_bigalloc(sb)) {
+		ext4_msg(sb, KERN_ERR, "Online resizing not supported with bigalloc");
+		return -EOPNOTSUPP;
+	}
+
 	if (test_and_set_bit_lock(EXT4_FLAGS_RESIZING,
 				  &EXT4_SB(sb)->s_ext4_flags))
 		ret = -EBUSY;
-- 
2.32.0.rc2

