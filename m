Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0C3E9B43
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhHKXdS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 19:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232470AbhHKXdS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Aug 2021 19:33:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A924A60E52;
        Wed, 11 Aug 2021 23:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628724773;
        bh=BNegfWbn0FRBCYIUVHxxfej7z9/3cEFe82zvevU9uN0=;
        h=Date:From:To:Cc:Subject:From;
        b=iqCVojisgFqhKE/O4gdkMYZKGxsnqcTrO3hYyAEyK6PcPRVIJxQXe1GUTGmNnIYrK
         pQvJTh3Ju178C+6MV5tvMJ0Nk/gmXk7Pbr9p/RPY8AHL2mWwvMo4na83U1OsOjvP/r
         6fbvVZVQ1GbLXtwdChaTZzuPWDUAvbE6/3At8NCpxGCTFB4Ullr7CeXyRUwQsF/6l4
         wxcxxrxbyirnhIH/kQirsyVAQyqziH6EbUPf/uI/5pYnNLNQmv1za2rMB7kp6oxSHN
         vIebu8bEwtU/cQ5S9rWpHXhtagZ+N+5+g+rfDBVnXM/kO7AwEag8lcnbxqM4TvB6+E
         o+aX4mnojGUoQ==
Date:   Wed, 11 Aug 2021 16:32:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] mke2fs: warn about missing y2038 support when formatting
 fresh ext4 fs
Message-ID: <20210811233253.GC3601392@magnolia>
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
 misc/mke2fs.c       |   35 +++++++++++++++++++++++++++++++++++
 misc/mke2fs.conf.in |    4 ++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 92003e11..b16880c2 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1537,6 +1537,30 @@ static int get_device_geometry(const char *file,
 }
 #endif
 
+/*
+ * Returns true if the user is forcing an old format (e.g. ext2, ext3).
+ *
+ * If there is no fs_types list, the user invoked us with no explicit type and
+ * gets the default (ext4) format.  If we find the latest format (ext4) in the
+ * type list, some combination of program name and -T argument put us in ext4
+ * mode.  Anything else (ext2, ext3, hurd) and we return false.
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
@@ -2603,6 +2627,17 @@ static void PRS(int argc, char *argv[])
 		exit(1);
 	}
 
+	/* If the user didn't tell us to format with an old ondisk format... */
+	if (!old_format_forced(fs_types)) {
+		/*
+		 * ...warn them that filesystems with 128-byte inodes will not
+		 * work properly beyond 2038.
+		 */
+		if (inode_size == EXT2_GOOD_OLD_INODE_SIZE)
+			printf(
+_("128-byte inodes cannot handle dates beyond 2038 and are deprecated\n"));
+	}
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
