Return-Path: <linux-ext4+bounces-6374-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC73A2BA10
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 05:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245D63A675C
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6A23236E;
	Fri,  7 Feb 2025 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puJEZkUo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEB933E7
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901702; cv=none; b=DK+17A0mORosPhXKMs6ZcFdJiY79YpjRWvtFk3vkg6fnyJyG5SljxYCKGTXc3T3mExAvATUVQ1c4AI/2bd0EHogBi2W1L2j8fdW8/+l/6u8FPYWTZDApNEqsYbM/Fm8761YVowrEdOku7TawYbSuDxMPWutsKbnROutmKzOXe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901702; c=relaxed/simple;
	bh=sdlVN2uGgx5cV82/gKxHshSSRDgRf37PqGE5WLS4dMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL3KN6wpgZE/i6BlESktrbOE2mB++MjX4EH2iq8S1R1kZgVFwVgT6R71hpzHH04YqoNtSHnQL1HZJj4xz95+ymFCRGhR2rdmJiAc7f7Hua5OAl4Cn3cduz48cOP/5670waPSbLFsFvYchNpor6lQG8MNQ22nWkKlK9j5IxhJUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puJEZkUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D13C4CED1;
	Fri,  7 Feb 2025 04:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738901701;
	bh=sdlVN2uGgx5cV82/gKxHshSSRDgRf37PqGE5WLS4dMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=puJEZkUolXurssOHB1yko86XJ8dhoFomHPF+b/zQcEbCgRx5RMJh8L14PWv+6UqqD
	 lwjNQzSk+Umfal83LMO8Qkv+d10Y0Uu/ST3yq3W128XQpXRjdz1Ny5g9L+KXj3rh75
	 Y9nK4YCIuEXbCHp8tJiwWMJHBLBAKTYh3H7Nt8HXsqEZJtDWp73fKwr9o6CupnH0wB
	 yEM80cn6JOYLEUt/kQ4+07cnW6Bs7yWE+th/CT/GTBll9kcgZhjy0jnJo8CgZ/wQzI
	 XCqTOgOKLZSuGH3+6EU5n7nKNHyDfkujYyVCok/5YZy6e0SVuPGFOrmUc870BO6Ikg
	 yoX4ixSM+abzg==
Date: Thu, 6 Feb 2025 20:15:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz
Subject: Re: [RESEND PATCH 1/2] ext4: introduce ITAIL helper
Message-ID: <20250207041501.GD21787@frogsfrogsfrogs>
References: <20250207032743.882949-1-yebin@huaweicloud.com>
 <20250207032743.882949-2-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207032743.882949-2-yebin@huaweicloud.com>

On Fri, Feb 07, 2025 at 11:27:42AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Introduce ITAIL helper to get the bound of xattr in inode.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/xattr.c | 10 +++++-----
>  fs/ext4/xattr.h |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7647e9f6e190..0e4494863d15 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -649,7 +649,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
>  		return error;
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
> -	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	end = ITAIL(inode, raw_inode);
>  	error = xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
> @@ -793,7 +793,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  		return error;
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
> -	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	end = ITAIL(inode, raw_inode);
>  	error = xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
> @@ -879,7 +879,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  			goto out;
>  		raw_inode = ext4_raw_inode(&iloc);
>  		header = IHDR(inode, raw_inode);
> -		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +		end = ITAIL(inode, raw_inode);
>  		ret = xattr_check_inode(inode, header, end);
>  		if (ret)
>  			goto out;
> @@ -2235,7 +2235,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	header = IHDR(inode, raw_inode);
>  	is->s.base = is->s.first = IFIRST(header);
>  	is->s.here = is->s.first;
> -	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	is->s.end = ITAIL(inode, raw_inode);
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>  		error = xattr_check_inode(inode, header, is->s.end);
>  		if (error)
> @@ -2786,7 +2786,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  	 */
>  
>  	base = IFIRST(header);
> -	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	end = ITAIL(inode, raw_inode);
>  	min_offs = end - base;
>  	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
>  
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index b25c2d7b5f99..d331bd636480 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -67,6 +67,9 @@ struct ext4_xattr_entry {
>  		((void *)raw_inode + \
>  		EXT4_GOOD_OLD_INODE_SIZE + \
>  		EXT4_I(inode)->i_extra_isize))
> +#define ITAIL(inode, raw_inode) \
> +	((void *)raw_inode + \
> +	 EXT4_SB(inode->i_sb)->s_inode_size)

These are macros, you ought to wrap the arguments in parentheses to
avoid subtle bugs:

#define ITAIL(inode, raw_inode) \
	((void *)(raw_inode) + \
	 EXT4_SB((inode)->i_sb)->s_inode_size)

(or maybe just a static inline helper, but I guess we're passing around
void pointers so meh)

--D

>  #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
>  
>  /*
> -- 
> 2.34.1
> 
> 

