Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5328213694D
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2020 09:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgAJI7V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jan 2020 03:59:21 -0500
Received: from u164.east.ru ([195.170.63.164]:17320 "EHLO u164.east.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgAJI7V (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 Jan 2020 03:59:21 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 03:59:20 EST
Received: by u164.east.ru (Postfix, from userid 1001)
        id A88614F4CEC; Fri, 10 Jan 2020 11:52:17 +0300 (MSK)
Date:   Fri, 10 Jan 2020 11:52:17 +0300
From:   Anatoly Pugachev <matorola@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] libext2fs: Extends commit c9a8c53b, with the same fix for
 ext2fs_flush2() and ext2fs_image_super_write() on a Big Endian systems.
Message-ID: <20200110085217.GA7307@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


libext2fs: extends commit c9a8c53b, with the same fix for ext2fs_flush2() and
ext2fs_image_super_write() on a Big Endian systems.

As follow-up to previous discussion 'dumpe2fs / mke2fs sigserv on sparc64'

Used find for files which refer to:

e2fsprogs.git$ find . -name \*.c | xargs grep -cl 'gdp = ext2fs_group_desc'
./lib/ext2fs/closefs.c
./lib/ext2fs/openfs.c
./lib/ext2fs/imager.c

And applied the same check for a null pointer.

Tested on a debian linux with sparc64 LDOM and ppc64 LPAR.

Fixes sigserv with test suite in "i_bitmaps" test.

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/closefs.c | 3 ++-
 lib/ext2fs/imager.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/closefs.c b/lib/ext2fs/closefs.c
index 1d4d5b7f..58fdd5c6 100644
--- a/lib/ext2fs/closefs.c
+++ b/lib/ext2fs/closefs.c
@@ -339,7 +339,8 @@ errcode_t ext2fs_flush2(ext2_filsys fs, int flags)
 	ext2fs_swap_super(super_shadow);
 	for (j = 0; j < fs->group_desc_count; j++) {
 		gdp = ext2fs_group_desc(fs, group_shadow, j);
-		ext2fs_swap_group_desc2(fs, gdp);
+		if (gdp)
+			ext2fs_swap_group_desc2(fs, gdp);
 	}
 #else
 	super_shadow = fs->super;
diff --git a/lib/ext2fs/imager.c b/lib/ext2fs/imager.c
index 7fd06f74..b40fd826 100644
--- a/lib/ext2fs/imager.c
+++ b/lib/ext2fs/imager.c
@@ -245,7 +245,8 @@ errcode_t ext2fs_image_super_write(ext2_filsys fs, int fd,
 	gdp = (struct ext2_group_desc *) cp;
 	for (j=0; j < groups_per_block*fs->desc_blocks; j++) {
 		gdp = ext2fs_group_desc(fs, fs->group_desc, j);
-		ext2fs_swap_group_desc2(fs, gdp);
+		if (gdp)
+			ext2fs_swap_group_desc2(fs, gdp);
 	}
 #endif
 
@@ -257,7 +258,8 @@ errcode_t ext2fs_image_super_write(ext2_filsys fs, int fd,
 	gdp = (struct ext2_group_desc *) cp;
 	for (j=0; j < groups_per_block*fs->desc_blocks; j++) {
 		gdp = ext2fs_group_desc(fs, fs->group_desc, j);
-		ext2fs_swap_group_desc2(fs, gdp);
+		if (gdp)
+			ext2fs_swap_group_desc2(fs, gdp);
 	}
 #endif
 
-- 
2.25.0.rc1

