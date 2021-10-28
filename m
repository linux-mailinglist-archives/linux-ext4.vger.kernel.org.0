Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A482643E415
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJ1OsP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Oct 2021 10:48:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37072 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230451AbhJ1OsP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Oct 2021 10:48:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19SEjd1s030338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 10:45:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8034A15C00B9; Thu, 28 Oct 2021 10:45:39 -0400 (EDT)
Date:   Thu, 28 Oct 2021 10:45:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2fs: avoid re-reading inode multiple times
Message-ID: <YXq3k/sC+p0NzGsb@mit.edu>
References: <20210407075023.44324-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407075023.44324-1-adilger@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 01:50:23AM -0600, Andreas Dilger wrote:
> Reduce the number of times that the inode is read from storage.
> Factor ext2fs_xattrs_read() into a new ext2fs_xattrs_read_inode()
> function that can accept an in-memory inode, and call that from
> within ext2fs_xattrs_read() and in e2fsck_pass1() when the inode
> is already available.
> 
> Similarly, in e2fsck_pass4() avoid re-reading the inode multiple
> times in disconnect_inode(), check_ea_inode(), and in the main
> function body if possible.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Applied, although I needed to add this initialization patch to avoid a
"make check" failure.

diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
index 157e6eac..d36fe68d 100644
--- a/lib/ext2fs/ext_attr.c
+++ b/lib/ext2fs/ext_attr.c
@@ -998,7 +998,7 @@ errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
 	char *start, *block_buf = NULL;
 	blk64_t blk;
 	size_t i;
-	errcode_t err;
+	errcode_t err = 0;
 
 	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
 
						- Ted
