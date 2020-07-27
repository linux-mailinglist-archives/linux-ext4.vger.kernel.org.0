Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A335322F3F2
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgG0Phu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 11:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgG0Phu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 11:37:50 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB53206E7;
        Mon, 27 Jul 2020 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595864270;
        bh=XnuQiY0/sAxAK9Dw1wg0YHNGkBxTCCbCKWLsBKHOG2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zh3iohzaNVhm1hbPwC2bSSWthIxFvCpfpfKFfeOKCRSYv8wPEUgMoRN5xb8bXDJ3E
         vqF6A0XhjGVRhfjYFNaK2Dc4aLGDiQH5e63tbNsPPyrb1RMUUF5uMA+KtDX4Z8kYZM
         5JVBfDrlQmOdnln1B2nlz74N7gHEuKixSAxndIW4=
Date:   Mon, 27 Jul 2020 08:37:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] chattr/lsattr: Support dax attribute
Message-ID: <20200727153748.GA1138@sol.localdomain>
References: <20200727092901.2728-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727092901.2728-1-yangx.jy@cn.fujitsu.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 27, 2020 at 05:29:01PM +0800, Xiao Yang wrote:
> Use the letter 'x' to set/get dax attribute on a directory/file.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  lib/e2p/pf.c         |  1 +
>  lib/ext2fs/ext2_fs.h |  1 +
>  misc/chattr.1.in     | 10 ++++++++--
>  misc/chattr.c        |  3 ++-
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/e2p/pf.c b/lib/e2p/pf.c
> index 0c6998c4..e59cccff 100644
> --- a/lib/e2p/pf.c
> +++ b/lib/e2p/pf.c
> @@ -44,6 +44,7 @@ static struct flags_name flags_array[] = {
>  	{ EXT2_TOPDIR_FL, "T", "Top_of_Directory_Hierarchies" },
>  	{ EXT4_EXTENTS_FL, "e", "Extents" },
>  	{ FS_NOCOW_FL, "C", "No_COW" },
> +	{ FS_DAX_FL, "x", "Dax" },
>  	{ EXT4_CASEFOLD_FL, "F", "Casefold" },
>  	{ EXT4_INLINE_DATA_FL, "N", "Inline_Data" },
>  	{ EXT4_PROJINHERIT_FL, "P", "Project_Hierarchy" },
> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> index 6c20ea77..b5e2e42a 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -334,6 +334,7 @@ struct ext2_dx_tail {
>  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>  /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
>  #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
>  #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a snapshot */
>  #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being deleted */
>  #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot shrink has completed */

How about putting the values in order?

> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
> index ff2fcf00..b27c8e1f 100644
> --- a/misc/chattr.1.in
> +++ b/misc/chattr.1.in
> @@ -23,7 +23,7 @@ chattr \- change file attributes on a Linux file system
>  .B chattr
>  changes the file attributes on a Linux file system.
>  .PP
> -The format of a symbolic mode is +-=[aAcCdDeFijPsStTu].
> +The format of a symbolic mode is +-=[aAcCdDeFijPsStTux].
>  .PP
>  The operator '+' causes the selected attributes to be added to the
>  existing attributes of the files; '-' causes them to be removed; and '='
> @@ -45,7 +45,8 @@ secure deletion (s),
>  synchronous updates (S),
>  no tail-merging (t),
>  top of directory hierarchy (T),
> -and undeletable (u).
> +undeletable (u),
> +and direct access for files (x).

There's another part that needs to be updated to add "x":

"The letters 'aAcCdDeFijPsStTu' select the new attributes for the files:"
