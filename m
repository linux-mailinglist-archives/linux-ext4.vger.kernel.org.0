Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585DE3EBD6D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhHMUcZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 16:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233931AbhHMUcZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Aug 2021 16:32:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A3476103A;
        Fri, 13 Aug 2021 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628886718;
        bh=nWj+Ug0gLuO++h2BYTrRBLzIj5+WBHKsMF+Akq3N7Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBd7+hnNT9qvrRqqdZEec+3LBhIzf5hNow5pG6kEW3XsuNJPtZLRuZhpHPxwgw+sE
         iEr+gPGp5QZIObvV20gCOO2lgsbC6ssqCixkldoVykcQPNOUE8qi7N1C/kxzCx6C6a
         GI8Co5PBCri61D0xvI+xB7fPpkhkZVhDd8/NfZRnBOOwRfbzVVfS8lWdUSZ5j5wGKv
         n6OTpkOHNAMNABkeqo35KFubUPF33XXqw7dkwkCBXtdJKBBk6iCrpOaMQejQ51c2Ur
         VmSO81m5Bt0P8NWCtorCkl7HMQvF1HJQXReezuj6XIFKQZrxOG0/zafandDASzmgqo
         ltVXme4drK7yw==
Date:   Fri, 13 Aug 2021 13:31:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH -v5] mke2fs: warn about missing y2038 support when
 formatting fresh ext4 fs
Message-ID: <20210813203157.GF3601392@magnolia>
References: <YRbI4E3b42X3otJv@mit.edu>
 <20210813193518.359670-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813193518.359670-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 13, 2021 at 03:35:18PM -0400, Theodore Ts'o wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Filesystems with 128-byte inodes do not support timestamps beyond the
> year 2038.  Since we're now less than 16.5 years away from that point,
> it's time to start warning users about this lack of support when they
> format an ext4 filesystem with small inodes.
> 
> (Note that even for ext2 and ext3, we changed the default for
> non-small file systems in 2008 in commit commit b1631cce648e ("Create
> new filesystems with 256-byte inodes by default").)
> 
> So change the mke2fs.conf file to specify 256-byte inodes even for
> small filesystems, and then add a warning to mke2fs itself if someone
> is trying to make us format a file system with 128-byte inodes.  This
> can be suppressed by setting the boolean option warn_y2038_dates in
> the mke2fs.conf file to false, which we do in the case of GNU Hurd,
> since it only supports 128 byte inodes as of this writing.
> 
> [ Patch reworked by tytso to only warn in the case of GNU Hurd, since
>   the default for ext2/ext3 was changed for all but small file systems
>   in 2008. ]
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

LGTM, insofar as I don't know how useful it is to review "my" own patch.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  misc/mke2fs.c         | 11 +++++++++++
>  misc/mke2fs.conf.5.in |  7 +++++++
>  misc/mke2fs.conf.in   |  4 +---
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 92003e11..a4573972 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -2603,6 +2603,17 @@ profile_error:
>  		exit(1);
>  	}
>  
> +	/*
> +	 * Warn the user that filesystems with 128-byte inodes will
> +	 * not work properly beyond 2038.  This can be suppressed via
> +	 * a boolean in the mke2fs.conf file, and we will disable this
> +	 * warning for file systems created for the GNU Hurd.
> +	 */
> +	if (inode_size == EXT2_GOOD_OLD_INODE_SIZE &&
> +	    get_bool_from_profile(fs_types, "warn_y2038_dates", 1))
> +		printf(
> +_("128-byte inodes cannot handle dates beyond 2038 and are deprecated\n"));
> +
>  	/* Make sure number of inodes specified will fit in 32 bits */
>  	if (num_inodes == 0) {
>  		unsigned long long n;
> diff --git a/misc/mke2fs.conf.5.in b/misc/mke2fs.conf.5.in
> index 08bb9488..0b570303 100644
> --- a/misc/mke2fs.conf.5.in
> +++ b/misc/mke2fs.conf.5.in
> @@ -505,6 +505,13 @@ This relation specifies the base file name for the huge files.
>  This relation specifies the (zero-padded) width of the field for the
>  huge file number.
>  .TP
> +.I warn_y2038_dates
> +This boolean relation specifies wheather mke2fs will issue a warning
> +when creating a file system with 128 byte inodes (and so therefore will
> +not support dates after January 19th, 2038).  The default value is true,
> +except for file systems created for the GNU Hurd since it only supports
> +128-byte inodes.
> +.TP
>  .I zero_hugefiles
>  This boolean relation specifies whether or not zero blocks will be
>  written to the hugefiles while
> diff --git a/misc/mke2fs.conf.in b/misc/mke2fs.conf.in
> index 01e35cf8..05680992 100644
> --- a/misc/mke2fs.conf.in
> +++ b/misc/mke2fs.conf.in
> @@ -12,16 +12,13 @@
>  	}
>  	ext4 = {
>  		features = has_journal,extent,huge_file,flex_bg,metadata_csum,64bit,dir_nlink,extra_isize
> -		inode_size = 256
>  	}
>  	small = {
>  		blocksize = 1024
> -		inode_size = 128
>  		inode_ratio = 4096
>  	}
>  	floppy = {
>  		blocksize = 1024
> -		inode_size = 128
>  		inode_ratio = 8192
>  	}
>  	big = {
> @@ -44,4 +41,5 @@
>  	hurd = {
>  	     blocksize = 4096
>  	     inode_size = 128
> +	     warn_y2038_dates = 0
>  	}
> -- 
> 2.31.0
> 
