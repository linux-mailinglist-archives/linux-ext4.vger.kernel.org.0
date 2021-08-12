Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EDD3EAD93
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 01:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhHLXWt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 19:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhHLXWs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Aug 2021 19:22:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD4C60E9B;
        Thu, 12 Aug 2021 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628810542;
        bh=H45Qm9TmpFWzJZOmnegU1uJpH5BCvoJoOFsil17E6Ck=;
        h=Date:From:To:Cc:Subject:From;
        b=jt4/1Wvll67xGjBRUBKth/3yM8ThRqN5pKh+OKhOpxu9gOggRgRTSGUFZZIVKPGS6
         4vZn0NWKu2XFXMJ6jCJKWO10z1hhqmUoXpTrTdhZiFyePNahdVFvc4IDNoC69ix48l
         pub+86lvkc5zpbc/0K/xGE5XZR7rUTYNNqpvbCNC/TLytabIFQv1TOFBARgZgxynKv
         nQGGudAiaUcY+0kXt1DLvKVF5c/z4DtP2a8y5lY5zQbMKZBvNvu0cVoHW4psXMutkX
         Zp6NH6xtF9bMTrPbSm2CHB7kLG+xzoGBxL3Nn414Sja4pyY5vsKjOu3Rj7JnPlrrgl
         5+HuQBm95deuA==
Date:   Thu, 12 Aug 2021 16:22:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH v2] mke2fs: warn about missing y2038 support when formatting
 fresh ext4 fs
Message-ID: <20210812232222.GE3601392@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Filesystems with 128-byte inodes do not support timestamps beyond the
year 2038.  Since we're now less than 16.5 years away from that point,
it's time to start warning users about this lack of support when they
format an ext4 filesystem with small inodes.

First, change the mke2fs.conf file to specify 256-byte inodes even for
small filesystems, then add a warning to mke2fs itself if someone is
trying to make us format an ext4 filesystem with 128-byte inodes.

Note that we /don't/ warn about these things if the user has signalled
that they want an old format such as ext2, ext3, or hurd.  Everyone
should know by now that those are legacy.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
v2: fix the comments
---
 misc/mke2fs.c       |   39 +++++++++++++++++++++++++++++++++++++++
 misc/mke2fs.conf.in |    4 ++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 92003e11..114a64f7 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1537,6 +1537,35 @@ static int get_device_geometry(const char *file,
 }
 #endif
 
+/*
+ * Decide if the user is formatting with an old feature set (e.g. ext2, ext3).
+ *
+ * If there is no fs_types list, assume that the user's getting ext4 and return
+ * 0.  If we find 'ext4' anywhere in the fs_types list, take that as a sign
+ * that the user will get ext4 and return 0.  Any other case returns 1.
+ *
+ * Normally, 'ext4' will be the first item in fs_types, but the user can
+ * combine argv[0], -t, and -T options in such a way that fs_types will start
+ * with some other word and the 'ext4' will end up in a non-zero slot.  A
+ * simple way to do this is "mke2fs -T ext4 /dev/XXX".  The user is supposed to
+ * use -t for the fs type and not -T, but we've never enforced that.
+ */
+static inline int
+old_format_forced(char **fs_types)
+{
+	int found_ext4 = 0;
+	int i;
+
+	if (!fs_types)
+		return 0;
+
+	for (i = 0; fs_types[i]; i++)
+		if (!strcmp(fs_types[i], "ext4"))
+			found_ext4 = 1;
+
+	return !found_ext4;
+}
+
 static void PRS(int argc, char *argv[])
 {
 	int		b, c, flags;
@@ -2603,6 +2632,16 @@ static void PRS(int argc, char *argv[])
 		exit(1);
 	}
 
+	/*
+	 * If we're formatting with an ext4 feature set (and not an old ondisk
+	 * format), warn the user that filesystems with 128-byte inodes will
+	 * not work properly beyond 2038.
+	 */
+	if (!old_format_forced(fs_types) &&
+	    inode_size == EXT2_GOOD_OLD_INODE_SIZE)
+		printf(
+_("128-byte inodes cannot handle dates beyond 2038 and are deprecated\n"));
+
 	/* Make sure number of inodes specified will fit in 32 bits */
 	if (num_inodes == 0) {
 		unsigned long long n;
diff --git a/misc/mke2fs.conf.in b/misc/mke2fs.conf.in
index 01e35cf8..2fa1a824 100644
--- a/misc/mke2fs.conf.in
+++ b/misc/mke2fs.conf.in
@@ -16,12 +16,12 @@
 	}
 	small = {
 		blocksize = 1024
-		inode_size = 128
+		inode_size = 256
 		inode_ratio = 4096
 	}
 	floppy = {
 		blocksize = 1024
-		inode_size = 128
+		inode_size = 256
 		inode_ratio = 8192
 	}
 	big = {
