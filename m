Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1202EE0E65
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 00:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbfJVW44 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Oct 2019 18:56:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42436 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731850AbfJVW4z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Oct 2019 18:56:55 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9MMumop017696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 18:56:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2A456420456; Tue, 22 Oct 2019 18:56:48 -0400 (EDT)
Date:   Tue, 22 Oct 2019 18:56:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
Message-ID: <20191022225648.GD13621@mit.edu>
References: <20190905110110.32627-1-c17828@cray.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905110110.32627-1-c17828@cray.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 05, 2019 at 02:01:10PM +0300, Artem Blagodarenko wrote:
> tune2fs is used to make e2label duties.  ext2fs_open2() reads group
> descriptors which are not used during disk label obtaining, but takes
> a lot of time on large partitions.
> 
> This patch adds ext2fs_read_sb(), there only initialized superblock
> is returned This saves time dramatically.
> 
> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
> Cray-bug-id: LUS-5777

Sorry for the delay in getting back to you on this.  I've been
thinking about this, and I've found a better to support this
functionality by reusing the pre-existing EXT2_FLAG_SUPER_ONLY flag.
Unlike the previous version of this patch which defined
EXT2_FLAG_JOURNAL_ONLY (which was always a bit strangely named), this
avoids reading *any* block group descriptors when the file system is
open.  Instead, we read the block group descriptors on demand when
ext2fs_group_desc() is called.

So this speeds up "dumpe2fs -h" as well "e2label", and we don't have
to read any block group descriptors at all.  Oh, and it even works
when setting a label using e2label.

What do you think?

					- Ted

commit 639e310d64dd0a2c1302eba8c3f5d0def7eacbf2
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Oct 22 18:42:25 2019 -0400

    Teach ext2fs_open2() to honor the EXT2_FLAG_SUPER_ONLY flag
    
    Opening the file system with EXT2_FLAG_SUPER_ONLY will leave
    fs->group_desc to be NULL and modify "dumpe2fs -h" and tune2fs when it
    is emulating e2label to use this flag.  This speeds up "dumpe2fs -h"
    and "e2label" when operating on very large file systems.
    
    To allow other libext2fs functions to work without too many surprises,
    ext2fs_group_desc() will read in the block group descriptors on
    demand.  This allows "dumpe2fs -h" to be able to read the journal
    inode, for example.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cray-bug-id: LUS-5777

diff --git a/lib/ext2fs/blknum.c b/lib/ext2fs/blknum.c
index 9ee5c66e..fdd51df6 100644
--- a/lib/ext2fs/blknum.c
+++ b/lib/ext2fs/blknum.c
@@ -185,9 +185,45 @@ struct ext2_group_desc *ext2fs_group_desc(ext2_filsys fs,
 					  struct opaque_ext2_group_desc *gdp,
 					  dgrp_t group)
 {
-	int desc_size = EXT2_DESC_SIZE(fs->super) & ~7;
+	struct ext2_group_desc *ret_gdp;
+	errcode_t	retval;
+	static char	*buf = 0;
+	static int	bufsize = 0;
+	blk64_t		blk;
+	int		desc_size = EXT2_DESC_SIZE(fs->super) & ~7;
+	int		desc_per_blk = EXT2_DESC_PER_BLOCK(fs->super);
+
+	if (group > fs->group_desc_count)
+		return NULL;
+	if (gdp)
+		return (struct ext2_group_desc *)((char *)gdp +
+						  group * desc_size);
+
+	/*
+	 * If fs->group_desc wasn't read in when the file system was
+	 * opened, then read it on demand here.
+	 */
+	if (bufsize < fs->blocksize)
+		ext2fs_free_mem(&buf);
+	if (!buf) {
+		retval = ext2fs_get_mem(fs->blocksize, &buf);
+		if (retval)
+			return NULL;
+		bufsize = fs->blocksize;
+	}
 
-	return (struct ext2_group_desc *)((char *)gdp + group * desc_size);
+	blk = ext2fs_descriptor_block_loc2(fs, fs->super->s_first_data_block,
+					   group / desc_per_blk);
+	retval = io_channel_read_blk(fs->io, blk, 1, buf);
+	if (retval)
+		return NULL;
+
+	ret_gdp = (struct ext2_group_desc *)
+		(buf + ((group % desc_per_blk) * desc_size));
+#ifdef WORDS_BIGENDIAN
+	ext2fs_swap_group_desc2(fs, ret_gdp);
+#endif
+	return ret_gdp;
 }
 
 /* Do the same but as an ext4 group desc for internal use here */
diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
index 51b54a44..ec2d6cb4 100644
--- a/lib/ext2fs/openfs.c
+++ b/lib/ext2fs/openfs.c
@@ -393,6 +393,8 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 	}
 	fs->desc_blocks = ext2fs_div_ceil(fs->group_desc_count,
 					  EXT2_DESC_PER_BLOCK(fs->super));
+	if (flags & EXT2_FLAG_SUPER_ONLY)
+		goto skip_read_bg;
 	retval = ext2fs_get_array(fs->desc_blocks, fs->blocksize,
 				&fs->group_desc);
 	if (retval)
@@ -479,7 +481,7 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 		if (fs->flags & EXT2_FLAG_RW)
 			ext2fs_mark_super_dirty(fs);
 	}
-
+skip_read_bg:
 	if (ext2fs_has_feature_mmp(fs->super) &&
 	    !(flags & EXT2_FLAG_SKIP_MMP) &&
 	    (flags & (EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE))) {
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 384ce925..18148e2a 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -666,6 +666,8 @@ int main (int argc, char ** argv)
 		flags |= EXT2_FLAG_FORCE;
 	if (image_dump)
 		flags |= EXT2_FLAG_IMAGE_FILE;
+	if (header_only)
+		flags |= EXT2_FLAG_SUPER_ONLY;
 try_open_again:
 	if (use_superblock && !use_blocksize) {
 		for (use_blocksize = EXT2_MIN_BLOCK_SIZE;
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 39fce4a9..77a45875 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1698,7 +1698,7 @@ static void parse_e2label_options(int argc, char ** argv)
 			argv[1]);
 		exit(1);
 	}
-	open_flag = EXT2_FLAG_JOURNAL_DEV_OK;
+	open_flag = EXT2_FLAG_JOURNAL_DEV_OK | EXT2_FLAG_SUPER_ONLY;
 	if (argc == 3) {
 		open_flag |= EXT2_FLAG_RW;
 		L_flag = 1;
