Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363DD26EA2D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Sep 2020 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIRAwr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 20:52:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:14818 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIRAwr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Sep 2020 20:52:47 -0400
IronPort-SDR: 7/gsnWFXk4vhs8I+eA10yDfes+G1rUgaILx13Hw4xGR3FSeEnjp9qB9NDrKX76mqQDxHDD0h7r
 250n9XMxTITw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147570419"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="147570419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 17:52:40 -0700
IronPort-SDR: CPpj957UokPMAvWZAgC3jqHtDe7abTNqfpy7Wp8uZMkyqwDKMAps8F33s0vwPVVtsK0ti/nmQ3
 cPY50d5l2k/A==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="483972884"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 17:52:39 -0700
Date:   Thu, 17 Sep 2020 17:52:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
Message-ID: <20200918005238.GC2541163@iweiny-DESK2.sc.intel.com>
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 27, 2020 at 10:33:21PM -0700, Xiao Yang wrote:
> Use the letter 'x' to set/get dax attribute on a directory/file.

This may allow the flag to be set but I don't think this implements the logic
within ext2 to properly support the flag does it?

Just a quick look shows that ext2_ioctl() does not have any dax checks in it
and you don't add them here?

So how does this work?  Does ext2 share all the code with ext4 to make it work?

Ira

> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
> 
> V1->V2:
> 1) Define FS_DAX_FL in order and add missing 'x' letter in manpage.
> 2) Add more detailed description about 'x' attribute.
> 3) 'x' is a separate attribute and doesn't always affect S_DAX(i.e.
>    pagecache bypass) so remove the related info.
> 
>  lib/e2p/pf.c         |  1 +
>  lib/ext2fs/ext2_fs.h |  1 +
>  misc/chattr.1.in     | 15 ++++++++++++---
>  misc/chattr.c        |  3 ++-
>  4 files changed, 16 insertions(+), 4 deletions(-)
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
> index 6c20ea77..88f510a3 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -335,6 +335,7 @@ struct ext2_dx_tail {
>  /* EXT4_EOFBLOCKS_FL 0x00400000 was here */
>  #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
>  #define EXT4_SNAPFILE_FL		0x01000000  /* Inode is a snapshot */
> +#define FS_DAX_FL			0x02000000 /* Inode is DAX */
>  #define EXT4_SNAPFILE_DELETED_FL	0x04000000  /* Snapshot is being deleted */
>  #define EXT4_SNAPFILE_SHRUNK_FL		0x08000000  /* Snapshot shrink has completed */
>  #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data */
> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
> index ff2fcf00..5a4928a5 100644
> --- a/misc/chattr.1.in
> +++ b/misc/chattr.1.in
> @@ -23,13 +23,13 @@ chattr \- change file attributes on a Linux file system
>  .B chattr
>  changes the file attributes on a Linux file system.
>  .PP
> -The format of a symbolic mode is +-=[aAcCdDeFijPsStTu].
> +The format of a symbolic mode is +-=[aAcCdDeFijPsStTux].
>  .PP
>  The operator '+' causes the selected attributes to be added to the
>  existing attributes of the files; '-' causes them to be removed; and '='
>  causes them to be the only attributes that the files have.
>  .PP
> -The letters 'aAcCdDeFijPsStTu' select the new attributes for the files:
> +The letters 'aAcCdDeFijPsStTux' select the new attributes for the files:
>  append only (a),
>  no atime updates (A),
>  compressed (c),
> @@ -45,7 +45,8 @@ secure deletion (s),
>  synchronous updates (S),
>  no tail-merging (t),
>  top of directory hierarchy (T),
> -and undeletable (u).
> +undeletable (u),
> +and direct access for files (x).
>  .PP
>  The following attributes are read-only, and may be listed by
>  .BR lsattr (1)
> @@ -210,6 +211,14 @@ saved.  This allows the user to ask for its undeletion.  Note: please
>  make sure to read the bugs and limitations section at the end of this
>  document.
>  .TP
> +.B x
> +The 'x' attribute can be set on a directory or file.  If the attribute
> +is set on an existing directory, it will be inherited by all files and
> +subdirectories that are subsequently created in the directory.  If an
> +existing directory has contained some files and subdirectories, modifying
> +the attribute on the parent directory doesn't change the attributes on
> +these files and subdirectories.
> +.TP
>  .B V
>  A file with the 'V' attribute set has fs-verity enabled.  It cannot be
>  written to, and the filesystem will automatically verify all data read
> diff --git a/misc/chattr.c b/misc/chattr.c
> index a5d60170..c0337f86 100644
> --- a/misc/chattr.c
> +++ b/misc/chattr.c
> @@ -86,7 +86,7 @@ static unsigned long sf;
>  static void usage(void)
>  {
>  	fprintf(stderr,
> -		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuF] [-v version] files...\n"),
> +		_("Usage: %s [-pRVf] [-+=aAcCdDeijPsStTuFx] [-v version] files...\n"),
>  		program_name);
>  	exit(1);
>  }
> @@ -112,6 +112,7 @@ static const struct flags_char flags_array[] = {
>  	{ EXT2_NOTAIL_FL, 't' },
>  	{ EXT2_TOPDIR_FL, 'T' },
>  	{ FS_NOCOW_FL, 'C' },
> +	{ FS_DAX_FL, 'x' },
>  	{ EXT4_CASEFOLD_FL, 'F' },
>  	{ 0, 0 }
>  };
> -- 
> 2.21.0
> 
> 
> 
