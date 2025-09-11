Return-Path: <linux-ext4+bounces-9938-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE55B53EB3
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 00:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE9B3BDCDB
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 22:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B6F2EFD89;
	Thu, 11 Sep 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyu1zX6N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F32E3B11;
	Thu, 11 Sep 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629882; cv=none; b=WwLFZveVgAS8jwECbRpd5pcDTK8m/1hVrmTe0SOlXj5/b/kqCyDI35B5KUZ7KF6kh7K0CTPj9WLrxZtijUqtDTQskEOJeUQm4Kmz1GjhhA6N9247aSzhBlf4zcsa2NZJ/JOfP8Gh+08GR+hvsZlEz5TxRIhgw6oPQ5vL4C+clcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629882; c=relaxed/simple;
	bh=UJNXFmWY2hKXgtpNoqIpGgW5xkwZlnSIC0aifyjictM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s43Th5G6mpjSo2pt5a9OCfANRhB4smoJ0LCECJWcUHynosWZFuHk0A+iiOOUt46haZ2vo7B76UtT6rTzkxgeCpoIGVMhmIfve67A4i7JpBs4NW6WLffUQlXC76RhaubXn+MXcforsUvLzdBmbSd2wbukzHeYDwwT654QWTEg5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyu1zX6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8264C4CEF0;
	Thu, 11 Sep 2025 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757629882;
	bh=UJNXFmWY2hKXgtpNoqIpGgW5xkwZlnSIC0aifyjictM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyu1zX6NCLHVX1Ww5rrn80gw63IvaWK4a/rMfEA9PU5SQqgr6byy5r2jxrInOpPoI
	 u9oaiWvp7yUWrohELBPi0UobLVCY+FpwzV7Tx40saEl1ifK5Za4wVCZlrSLn04LowJ
	 BMY7JtjywKigsxXt+c9qF8QVmI51Pe6Zi0hzQRCjM/Auz+1KRBL4xgV1PR9fypB/UN
	 XiSDsar2tOL1Aw/6JxiqAmJEES5boHjVTXq3XehJFWq/wOsSSKfv0/7zIWkvCWwWO2
	 F0u8vArAN6UKnMfpvUBXuRDzHkuXqGcCTuAxxsP0Eivau9WxB8/KIWTsNEJRIC9+4w
	 d8GSpet+CZpKw==
Date: Thu, 11 Sep 2025 15:31:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: add support for 32-bit default reserved uid
 and gid values
Message-ID: <20250911223121.GD8084@frogsfrogsfrogs>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
 <20250908-tune2fs-v1-2-e3a6929f3355@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-tune2fs-v1-2-e3a6929f3355@mit.edu>

On Mon, Sep 08, 2025 at 11:15:49PM -0400, Theodore Ts'o via B4 Relay wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> Support for specifying the default user id and group id that is
> allowed to use the reserved block space was added way back when Linux
> only supported 16-bit uid's and gid's.  (Yeah, that long ago.)  It's
> not a commonly used feature, but let's add support for 32-bit user and
> group id's.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/ext4.h  | 16 +++++++++++++++-
>  fs/ext4/super.c |  8 ++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 01a6e2de7fc3ef0e20b039d3200b9c9bd656f59f..4bfcd5f0c74fda30db4009ee28fbee00a2f6b76f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1442,7 +1442,9 @@ struct ext4_super_block {
>  	__le16  s_encoding;		/* Filename charset encoding */
>  	__le16  s_encoding_flags;	/* Filename charset encoding flags */
>  	__le32  s_orphan_file_inum;	/* Inode for tracking orphan inodes */
> -	__le32	s_reserved[94];		/* Padding to the end of the block */
> +	__le16	s_def_resuid_hi;
> +	__le16	s_def_resgid_hi;
> +	__le32	s_reserved[93];		/* Padding to the end of the block */

Does anything actually check that s_reserved is zero?  I couldn't find
any:

$ git grep -w s_reserved fs/ext4 fs/ext2
fs/ext2/ext2.h:480:     __u32   s_reserved[190];        /* Padding to the end of the block */
fs/ext4/ext4.h:1445:    __le32  s_reserved[94];         /* Padding to the end of the block */

$ git grep -w s_reserved lib/ext2fs/ e2fsck/
lib/ext2fs/ext2_fs.h:777:       __le32  s_reserved[94];         /* Padding to the end of the block */
lib/ext2fs/swapfs.c:135:        /* catch when new fields are used from s_reserved */
lib/ext2fs/swapfs.c:136:        EXT2FS_BUILD_BUG_ON(sizeof(sb->s_reserved) != 94 * sizeof(__le32));
lib/ext2fs/tst_super_size.c:156:        check_field(s_reserved, 94 * 4);

Is there a risk that some garbage written to s_reserved (and not caught
by either the kernel or e2fsck) will now appear as a "legitimate" resuid
value?

--D

>  	__le32	s_checksum;		/* crc32c(superblock) */
>  };
>  
> @@ -1812,6 +1814,18 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>  		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
>  }
>  
> +static inline int ext4_get_resuid(struct ext4_super_block *es)
> +{
> +	return(le16_to_cpu(es->s_def_resuid) |
> +	       (le16_to_cpu(es->s_def_resuid_hi) << 16));
> +}
> +
> +static inline int ext4_get_resgid(struct ext4_super_block *es)
> +{
> +	return(le16_to_cpu(es->s_def_resgid) |
> +	       (le16_to_cpu(es->s_def_resgid_hi) << 16));
> +}
> +
>  /*
>   * Returns: sbi->field[index]
>   * Used to access an array element from the following sbi fields which require
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 94c98446c84f9a4614971d246ca7f001de610a8a..0256c8f7c6cee2b8d9295f2fa9a7acd904382e83 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2951,11 +2951,11 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	}
>  
>  	if (nodefs || !uid_eq(sbi->s_resuid, make_kuid(&init_user_ns, EXT4_DEF_RESUID)) ||
> -	    le16_to_cpu(es->s_def_resuid) != EXT4_DEF_RESUID)
> +	    ext4_get_resuid(es) != EXT4_DEF_RESUID)
>  		SEQ_OPTS_PRINT("resuid=%u",
>  				from_kuid_munged(&init_user_ns, sbi->s_resuid));
>  	if (nodefs || !gid_eq(sbi->s_resgid, make_kgid(&init_user_ns, EXT4_DEF_RESGID)) ||
> -	    le16_to_cpu(es->s_def_resgid) != EXT4_DEF_RESGID)
> +	    ext4_get_resgid(es) != EXT4_DEF_RESGID)
>  		SEQ_OPTS_PRINT("resgid=%u",
>  				from_kgid_munged(&init_user_ns, sbi->s_resgid));
>  	def_errors = nodefs ? -1 : le16_to_cpu(es->s_errors);
> @@ -5270,8 +5270,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	ext4_set_def_opts(sb, es);
>  
> -	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
> -	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> +	sbi->s_resuid = make_kuid(&init_user_ns, ext4_get_resuid(es));
> +	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resuid(es));
>  	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
>  	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
>  	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
> 
> -- 
> 2.51.0
> 
> 
> 

