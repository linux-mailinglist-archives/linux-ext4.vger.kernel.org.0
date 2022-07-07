Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266556A90C
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiGGRES (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiGGREH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 13:04:07 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 10:04:03 PDT
Received: from root.slava.cc (root.slava.cc [168.119.137.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D15C965
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 10:04:03 -0700 (PDT)
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1657212855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s6QfGxIhanK/aSuHFBmFYHnUNZjoa7GG0K+0iDzUl44=;
        b=V0Gayry+Qet9uZ1Q6PoRpPKLcECRKXn3AvKrKg2DwQAYQN8DpiejjV1O7WsU3FKoo/xE6r
        Ko0VUEgN3ohLBAcpXsjM8ZRw9HGeh4gE3EJ41Wn2ICA9ZNJXyTLhMAW1nTKU9NjqSKx9JR
        UkVtRbOuwblQJTjCChB6enjn0xmhf6Y=
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, krisman@collabora.com,
        Slava Bacherikov <slava@bacher09.org>
Subject: [PATCH] tune2fs: allow disabling casefold feature
Date:   Thu,  7 Jul 2022 19:54:00 +0300
Message-Id: <20220707165400.52951-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Casefold can be safely disabled if there are no directories with +F
attribute ( EXT4_CASEFOLD_FL ). This checks all inodes for that flag and in
case there isn't any, it disables casefold FS feature. When FS has
directories with +F attributes, user could convert these directories,
probably by mounting FS and executing some script or by doing it
manually. Afterwards, it would be possible to disable casefold FS flag
via tune2fs.

Signed-off-by: Slava Bacherikov <slava@bacher09.org>
---
 misc/tune2fs.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..1c5c2969 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -204,7 +204,8 @@ static __u32 clear_ok_features[3] = {
 		EXT4_FEATURE_INCOMPAT_FLEX_BG |
 		EXT4_FEATURE_INCOMPAT_MMP |
 		EXT4_FEATURE_INCOMPAT_64BIT |
-		EXT4_FEATURE_INCOMPAT_CSUM_SEED,
+		EXT4_FEATURE_INCOMPAT_CSUM_SEED |
+		EXT4_FEATURE_INCOMPAT_CASEFOLD,
 	/* R/O compat */
 	EXT2_FEATURE_RO_COMPAT_LARGE_FILE |
 		EXT4_FEATURE_RO_COMPAT_HUGE_FILE|
@@ -1020,6 +1021,41 @@ out:
 	return retval;
 }
 
+static int has_casefold_inode(ext2_filsys fs)
+{
+	int length = EXT2_INODE_SIZE(fs->super);
+	struct ext2_inode *inode = NULL;
+	ext2_inode_scan	scan;
+	errcode_t	retval;
+	ext2_ino_t	ino;
+	int found_casefold = 0;
+
+	retval = ext2fs_get_mem(length, &inode);
+	if (retval)
+		fatal_err(retval, "while allocating memory");
+
+	retval = ext2fs_open_inode_scan(fs, 0, &scan);
+	if (retval)
+		fatal_err(retval, "while opening inode scan");
+
+	do {
+		retval = ext2fs_get_next_inode_full(scan, &ino, inode, length);
+		if (retval)
+			fatal_err(retval, "while getting next inode");
+		if (!ino)
+			break;
+
+		if(inode->i_flags & EXT4_CASEFOLD_FL) {
+			found_casefold = 1;
+			break;
+		}
+	} while(1);
+
+	ext2fs_free_mem(&inode);
+	ext2fs_close_inode_scan(scan);
+	return found_casefold;
+}
+
 static errcode_t disable_uninit_bg(ext2_filsys fs, __u32 csum_feature_flag)
 {
 	struct ext2_group_desc *gd;
@@ -1554,6 +1590,20 @@ mmp_error:
 		enabling_casefold = 1;
 	}
 
+	if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fputs(_("The casefold feature may only be disabled when "
+				"the filesystem is unmounted.\n"), stderr);
+			return 1;
+		}
+		if (has_casefold_inode(fs)) {
+			fputs(_("The casefold feature couldn't be disabled when "
+					"there are inodes with +F flag.\n"), stderr);
+			return 1;
+		}
+		enabling_casefold = 0;
+	}
+
 	if (FEATURE_ON(E2P_FEATURE_INCOMPAT,
 		EXT4_FEATURE_INCOMPAT_CSUM_SEED)) {
 		if (!ext2fs_has_feature_metadata_csum(sb)) {
