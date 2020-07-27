Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C991122F45F
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgG0QKv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 12:10:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgG0QKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jul 2020 12:10:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RG7as6012719;
        Mon, 27 Jul 2020 16:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/XXQ+21ZUQLHwY7d8G0uRyUefSWbaK2AjO1wbxShvjI=;
 b=aMF5/EmaqqH6vmw3jWOcFwm/srsR+HyBBMaMjkc6IRcScvXDXJGZ1fq30pdoPuKprPor
 x4VISDzsevpwj1eIqVt/r1Sbrp3aHwldHa4BuqmzbuLEbHcbk/5pWIpl13fznCK96uLH
 xy0cpCUTyJtZ+wpVK38P9+Kp7p7PPiINEgyYrykGcmcNdzy8N5UxAWVR1pKcTQXrW92B
 5GjuRPDTMcdz2i7O1UkXF7AGiWdNkADm3PG30LlZ53kcrIJdNze1nib4uXXUV+8WrprH
 uNGahI+NInm5/pPrkcsE6OcS3g0/UutTDScDFcaWDRQiAknhQmJxXspxxOA+UGtV212M NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32hu1j2fgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 16:10:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RG8fB7128923;
        Mon, 27 Jul 2020 16:08:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32hu5su3v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 16:08:41 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RG8Wim013342;
        Mon, 27 Jul 2020 16:08:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 09:08:32 -0700
Date:   Mon, 27 Jul 2020 09:08:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     ira.weiny@intel.com, tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] chattr/lsattr: Support dax attribute
Message-ID: <20200727160831.GO7625@magnolia>
References: <20200727092901.2728-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727092901.2728-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=26 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=26 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270111
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
>  .PP
>  The following attributes are read-only, and may be listed by
>  .BR lsattr (1)
> @@ -210,6 +211,11 @@ saved.  This allows the user to ask for its undeletion.  Note: please
>  make sure to read the bugs and limitations section at the end of this
>  document.
>  .TP
> +.B x
> +A file with the 'x' attribute set is accessed directly on the memory-like
> +disk(e.g. /dev/pmem) by the kernel.  Kernel will skip page cache and do
> +reads/writes on the file directly.

There's much more to FS_DAX_FL than that.

See the "Enabling DAX on XFS and ext4" section of
Documentation/filesystems/dax.txt.

Note the part where you can set it on directories too; and also the part
where there's a separate state for whether or not you get the pagecache
bypass.

--D

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
