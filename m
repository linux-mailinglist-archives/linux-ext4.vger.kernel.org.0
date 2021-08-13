Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1E3EBBB9
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhHMRz6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 13:55:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53943 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230316AbhHMRzk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 13:55:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DHq0aT013255
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 13:52:01 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5572C15C37C1; Fri, 13 Aug 2021 13:52:00 -0400 (EDT)
Date:   Fri, 13 Aug 2021 13:52:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] mke2fs: warn about missing y2038 support when
 formatting fresh ext4 fs
Message-ID: <YRaxQBRnB3vtRieP@mit.edu>
References: <20210812232222.GE3601392@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812232222.GE3601392@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 12, 2021 at 04:22:22PM -0700, Darrick J. Wong wrote:
> Note that we /don't/ warn about these things if the user has signalled
> that they want an old format such as ext2, ext3, or hurd.  Everyone
> should know by now that those are legacy.

So I took a closer look, and it turns out that we changed the default
inode size for ext2 and ext3 file systems in 2008 (see commit
b1631cce648e ("Create new filesystems with 256-byte inodes by
default"), in e2fsprogs 1.40.4.  Even a positively antedeluvian distro
such as RHEL 7 uses e2fsprogs 1.42.9, and RHEL 6 EOL'ed November 30th,
2020.

There were only two cases where we created file systems with 128 byte
inodes --- "small" and "floppy" sized file systems, and for the GNU
Hurd, which only supports the original 128 byte inode.  What will GNU
Hurd do in 16.5 years?  ¯\_(ツ)_/¯

Given that, I think we can simplify the patch a little, and just use a
mke2fs.conf boolean to disable the warning message.

What do folks think?

						- Ted



commit f569fe86caddf964973ed35cdf36ed520ef23a0c
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Thu Aug 12 16:22:22 2021 -0700

    mke2fs: warn about missing y2038 support when formatting fresh ext4 fs
    
    Filesystems with 128-byte inodes do not support timestamps beyond the
    year 2038.  Since we're now less than 16.5 years away from that point,
    it's time to start warning users about this lack of support when they
    format an ext4 filesystem with small inodes.
    
    (Note that even for ext2 and ext3, we changed the default for
    non-small file systems in 2008 in commit commit b1631cce648e ("Create
    new filesystems with 256-byte inodes by default").)
    
    So change the mke2fs.conf file to specify 256-byte inodes even for
    small filesystems, and then add a warning to mke2fs itself if someone
    is trying to make us format a file system with 128-byte inodes.  This
    can be suppressed by setting the boolean option warn_y2038_dates in
    the mke2fs.conf file to false, which we do in the case of GNU Hurd,
    since it only supports 128 byte inodes as of this writing.
    
    [ Patch reworked by tytso to only warn in the case of GNU Hurd, since
      the default for ext2/ext3 was changed for all but small file systems
      in 2008. ]
    
    Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 92003e11..881ffd31 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2603,6 +2603,17 @@ profile_error:
 		exit(1);
 	}
 
+	/*
+	 * Warn the user that filesystems with 128-byte inodes will
+	 * not work properly beyond 2038.  This can be suppressed via
+	 * a boolean in the mke2fs.conf file, and we will disable this
+	 * warning for ext2, ext3, and hurd file systems.
+	 */
+	if (inode_size == EXT2_GOOD_OLD_INODE_SIZE &&
+	    get_bool_from_profile(fs_types, "warn_y2038_dates", 1))
+		printf(
+_("128-byte inodes cannot handle dates beyond 2038 and are deprecated\n"));
+
 	/* Make sure number of inodes specified will fit in 32 bits */
 	if (num_inodes == 0) {
 		unsigned long long n;
diff --git a/misc/mke2fs.conf.5.in b/misc/mke2fs.conf.5.in
index 08bb9488..62d0fdb5 100644
--- a/misc/mke2fs.conf.5.in
+++ b/misc/mke2fs.conf.5.in
@@ -505,6 +505,13 @@ This relation specifies the base file name for the huge files.
 This relation specifies the (zero-padded) width of the field for the
 huge file number.
 .TP
+.I warn_y2038_dates
+This boolean relation specifies wheather mke2fs will issue a warning
+when creating a file system with 128 byte inodes (and so therefore will
+not support dates after January 19th, 2038.  The default value is true,
+except for file systems created for the GNU Hurd, which does not support
+inodes larger than 128 bytes.
+.TP
 .I zero_hugefiles
 This boolean relation specifies whether or not zero blocks will be
 written to the hugefiles while
diff --git a/misc/mke2fs.conf.in b/misc/mke2fs.conf.in
index 01e35cf8..05680992 100644
--- a/misc/mke2fs.conf.in
+++ b/misc/mke2fs.conf.in
@@ -12,16 +12,13 @@
 	}
 	ext4 = {
 		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
-		inode_size = 256
 	}
 	small = {
 		blocksize = 1024
-		inode_size = 128
 		inode_ratio = 4096
 	}
 	floppy = {
 		blocksize = 1024
-		inode_size = 128
 		inode_ratio = 8192
 	}
 	big = {
@@ -44,4 +41,5 @@
 	hurd = {
 	     blocksize = 4096
 	     inode_size = 128
+	     warn_y2038_dates = 0
 	}
