Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB412B112
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 05:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfL0Etl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 23:49:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38854 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727028AbfL0Etl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 23:49:41 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBR4naXO004572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 23:49:37 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17E34420485; Thu, 26 Dec 2019 23:49:36 -0500 (EST)
Date:   Thu, 26 Dec 2019 23:49:36 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: e2fsprogs.git dumpe2fs / mke2fs sigserv on sparc64
Message-ID: <20191227044936.GB70060@mit.edu>
References: <CADxRZqyeaMuxoT+Rvp--bmX2-WvRs5v1yULcm3E5V4TfV5Qc2A@mail.gmail.com>
 <CADxRZqzPDfu36TB5ajhtyxrOx2HdPTe-8YE+ZnKA7DkdutUkGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqzPDfu36TB5ajhtyxrOx2HdPTe-8YE+ZnKA7DkdutUkGw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 18, 2019 at 03:01:03AM +0300, Anatoly Pugachev wrote:
> On Tue, Dec 17, 2019 at 9:01 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> >
> > Getting current git e2fsprogs of dumpe2fs/mke2fs (and probably others)
> > segfaults (via make check) with the following backtrace...

Hi,

Thanks for reporting this bug.  It should be fixed with this commit:

commit c9a8c53b17ccc4543509d55ff3b343ddbfe805e5
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Dec 26 23:19:54 2019 -0500

    libext2fs: fix crash in ext2fs_open2() on Big Endian systems
    
    Commit e6069a05: ("Teach ext2fs_open2() to honor the
    EXT2_FLAG_SUPER_ONLY flag") changed how the function
    ext2fs_group_desc() handled a request for a gdp pointer for a group
    larger than the number of groups in the file system; it now returns
    NULL, instead of returning a pointer beyond the end of the array.
    
    Previously, the ext2fs_open2() function would swap all of the block
    group descriptors in a block, even if they are beyond the end of the
    file system.  This was OK, since we were not overrunning the allocated
    memory, since it was rounded to a block boundary.  But now that
    ext2fs_group_desc() would return NULL for those gdp, it would cause
    ext2fs_open2(), when it was byte swapping the block group descriptors
    on Big Endian systems, to dereference a null pointer and crash.
    
    This commit adds a NULL pointer check to avoid byte swapping those
    block group descriptors in a bg descriptor block, but which are beyond
    the end of the file system, to address this crash.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Reported-by: Anatoly Pugachev <matorola@gmail.com>

diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
index ec2d6cb4..3331452d 100644
--- a/lib/ext2fs/openfs.c
+++ b/lib/ext2fs/openfs.c
@@ -435,7 +435,8 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 		gdp = (struct ext2_group_desc *) dest;
 		for (j=0; j < groups_per_block*first_meta_bg; j++) {
 			gdp = ext2fs_group_desc(fs, fs->group_desc, j);
-			ext2fs_swap_group_desc2(fs, gdp);
+			if (gdp)
+				ext2fs_swap_group_desc2(fs, gdp);
 		}
 #endif
 		dest += fs->blocksize*first_meta_bg;
@@ -455,7 +456,8 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 		for (j=0; j < groups_per_block; j++) {
 			gdp = ext2fs_group_desc(fs, fs->group_desc,
 						i * groups_per_block + j);
-			ext2fs_swap_group_desc2(fs, gdp);
+			if (gdp)
+				ext2fs_swap_group_desc2(fs, gdp);
 		}
 #endif
 		dest += fs->blocksize;
