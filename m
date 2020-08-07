Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6626923F068
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHGQDs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 12:03:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:1878 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgHGQDr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 Aug 2020 12:03:47 -0400
IronPort-SDR: vd7L8cBP2fRl1tef1NSRdyT0lqejJaeGhmTMgsSpmpx3zNBEKaJB3DJGk1xMenw2UlFKCVGuqt
 Le8ehk/jdpGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="171181585"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="171181585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 09:03:46 -0700
IronPort-SDR: FjX2DggntkZp0f5kzZdo6oPFSHGEpOXq7JkyGijK+u2zefz6jO3k27bSkA+x8c+XF1L0Yvwbld
 bq9lhBehDHxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="468276403"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2020 09:03:45 -0700
Date:   Fri, 7 Aug 2020 09:03:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     darrick.wong@oracle.com, tytso@mit.edu, ebiggers@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
Message-ID: <20200807160305.GQ1573827@iweiny-DESK2.sc.intel.com>
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 28, 2020 at 01:33:21PM +0800, Xiao Yang wrote:
> Use the letter 'x' to set/get dax attribute on a directory/file.
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

Per-file support is not supported on ext2...

So I'm suspicious of this change.  It is probably not an issue but I just
wanted to check if you are trying to test on ext2?

Ira

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
