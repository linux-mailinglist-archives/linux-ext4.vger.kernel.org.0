Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B141B3146
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 22:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDUUem (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Apr 2020 16:34:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48604 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUUel (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Apr 2020 16:34:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKIt1M160759;
        Tue, 21 Apr 2020 20:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1WRUSf3YFb+6KDECI1irGIeeT4sY/hA2UkzIzF0JUMI=;
 b=J/4qdBXo7Bseul8i08SK7pCO6W8p5VMpXKB/y0NpYBPvQCWm0XvKeexKpyrGxqRbW3vA
 HVfDlLc35VYrCRuFXnXgxtPnDBA4LSIehZ8Q4BYSMkuPC/BfL902B/rjTuaGRvAf9WHu
 nHvmscDNKsM+8UDJ6tGEOEXDEyJeXd3+FFaPfKcAnDP0RFdAKpVCLMZMZ3wSN1lRpIWS
 2rNipIJkKeHBWMgFADZ0UqmLeXPWIsgHJkOMd/FCCOPiVWdKE+pbDxk6zI/78cC3wO6S
 l0BCJo01rbk52zgq7n0zKc5Qyhd2Xctm0ht0LjnLL1VzmMHmckOw5ssahXQuhiTGL7MM bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30fsgky7rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:34:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKBbUf186432;
        Tue, 21 Apr 2020 20:34:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30gb3ssps4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:34:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LKYRvY015731;
        Tue, 21 Apr 2020 20:34:27 GMT
Received: from localhost (/10.159.227.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 13:34:27 -0700
Date:   Tue, 21 Apr 2020 13:34:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 11/11] Documentation/dax: Update Usage section
Message-ID: <20200421203423.GE6742@magnolia>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-12-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-12-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210151
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 21, 2020 at 12:17:53PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the Usage section to reflect the new individual dax selection
> functionality.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V8:
> 	Updates from Darrick
> 
> Changes from V7:
> 	Cleanups/clarifications from Darrick and Dan
> 
> Changes from V6:
> 	Update to allow setting FS_XFLAG_DAX any time.
> 	Update with list of behaviors from Darrick
> 	https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> 
> Changes from V5:
> 	Update to reflect the agreed upon semantics
> 	https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> ---
>  Documentation/filesystems/dax.txt | 164 +++++++++++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 679729442fd2..8f4ab08be715 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -17,11 +17,169 @@ For file mappings, the storage device is mapped directly into userspace.
>  Usage
>  -----
>  
> -If you have a block device which supports DAX, you can make a filesystem
> +If you have a block device which supports DAX, you can make a file system
>  on it as usual.  The DAX code currently only supports files with a block
>  size equal to your kernel's PAGE_SIZE, so you may need to specify a block
> -size when creating the filesystem.  When mounting it, use the "-o dax"
> -option on the command line or add 'dax' to the options in /etc/fstab.
> +size when creating the file system.
> +
> +Currently 3 filesystems support DAX: ext2, ext4 and xfs.  Enabling DAX on them
> +is different.
> +
> +Enabling DAX on ext4 and ext2
> +-----------------------------
> +
> +When mounting the filesystem, use the "-o dax" option on the command line or
> +add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
> +within the filesystem.  It is equivalent to the '-o dax=always' behavior below.
> +
> +
> +Enabling DAX on xfs
> +-------------------
> +
> +Summary
> +-------
> +
> + 1. There exists an in-kernel file access mode flag S_DAX that corresponds to
> +    the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
> +    about this access mode.
> +
> + 2. There exists an advisory file inode flag FS_XFLAG_DAX that is
> +    inherited from the parent directory FS_XFLAG_DAX inode flag at file
> +    creation time.  This advisory flag can be set or cleared at any
> +    time, but doing so does not immediately affect the S_DAX state.
> +
> +    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
> +    and the fs is on pmem then it will enable S_DAX at inode load time;
> +    if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> +
> + 3. There exists a dax= mount option.
> +
> +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> +
> +    "-o dax=always" means "always set S_DAX (at least on pmem),
> +                    and ignore FS_XFLAG_DAX."
> +
> +    "-o dax"        is an alias for "dax=always".
> +
> +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> +
> + 4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
> +    be set or cleared at any time.  The flag state is inherited by any files or
> +    subdirectories when they are created within that directory.
> +
> + 5. Programs that require a specific file access mode (DAX or not DAX)
> +    can do one of the following:
> +
> +    (a) Create files in directories that the FS_XFLAG_DAX flag set as
> +        needed; or
> +
> +    (b) Have the administrator set an override via mount option; or
> +
> +    (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
> +        must then cause the kernel to evict the inode from memory.  This
> +        can be done by:
> +
> +        i>  Closing the file and re-opening the file and using statx to
> +            see if the fs has changed the S_DAX flag; and
> +
> +        ii> If the file still does not have the desired S_DAX access
> +            mode, either unmount and remount the filesystem, or close
> +            the file and use drop_caches.
> +
> + 6. It is expected that users who want to squeeze every last bit of performance
> +    out of the particular rough and tumble bits of their storage will also be
> +    exposed to the difficulties of what happens when the operating system can't
> +    totally virtualize those hardware capabilities.  DAX is such a feature.
> +
> +
> +Details
> +-------
> +
> +There are 2 per-file dax flags.  One is a physical inode setting (FS_XFLAG_DAX)
> +and the other a currently enabled state (S_DAX).
> +
> +FS_XFLAG_DAX is maintained, on disk, on individual inodes.  It is preserved
> +within the file system.  This 'physical' config setting can be set using an
> +ioctl and/or an application such as "xfs_io -c 'chattr [-+]x'".  Files and
> +directories automatically inherit FS_XFLAG_DAX from their parent directory
> +_when_ _created_.  Therefore, setting FS_XFLAG_DAX at directory creation time
> +can be used to set a default behavior for an entire sub-tree.  (Doing so on the
> +root directory acts to set a default for the entire file system.)
> +
> +To clarify inheritance here are 3 examples:
> +
> +Example A:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' a
> +mkdir a/b/c/d
> +mkdir a/e
> +
> +	dax: a,e
> +	no dax: b,c,d
> +
> +Example B:
> +
> +mkdir a
> +xfs_io 'chattr +x' a
> +mkdir -p a/b/c/d
> +
> +	dax: a,b,c,d
> +	no dax:
> +
> +Example C:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' c
> +mkdir a/b/c/d
> +
> +	dax: c,d
> +	no dax: a,b
> +
> +
> +The current enabled state (S_DAX) is set when a file inode is _loaded_ based on
> +the underlying media support, the value of FS_XFLAG_DAX, and the file systems
> +dax mount option setting.  See below.
> +
> +statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
> +set and therefore statx will never indicate that S_DAX is set on directories.
> +
> +NOTE: Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs
> +even if the underlying media does not support dax and/or the file system is
> +overridden with a mount option.
> +
> +
> +Overriding FS_XFLAG_DAX (dax= mount option)
> +-------------------------------------------
> +
> +There exists a dax mount option.  Using the mount option does not change the
> +physical configured state of individual files but overrides the S_DAX operating
> +state when inodes are loaded.
> +
> +Given underlying media support, the dax mount option is a tri-state option
> +(never, always, inode) with the following meanings:
> +
> +   "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
> +   "-o dax=always" means "always set S_DAX, ignore FS_XFLAG_DAX"
> +        "-o dax" by itself means "dax=always" to remain compatible with older
> +	         kernels
> +   "-o dax=inode" means "follow FS_XFLAG_DAX"
> +
> +The default state is 'inode'.  Given underlying media support, the following
> +algorithm is used to determine the effective mode of the file S_DAX on a
> +capable device.
> +
> +	S_DAX = FS_XFLAG_DAX;
> +
> +	if (dax_mount == "always")
> +		S_DAX = true;
> +	else if (dax_mount == "off"

Missing trailing parenthesis here.

> +		S_DAX = false;
> +
> +To reiterate: Setting, and inheritance, continues to affect FS_XFLAG_DAX even
> +while the file system is mounted with a dax override.  However, in-core inode
> +state (S_DAX) will continue to be overridden until the filesystem is remounted
> +with dax=inode and the inode is evicted."

Trailing double-quote here.

Otherwise, this looks good to me.

--D

>  
>  
>  Implementation Tips for Block Driver Writers
> -- 
> 2.25.1
> 
