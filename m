Return-Path: <linux-ext4+bounces-9937-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F9B53EAC
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 00:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA943B531E
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9AE2EE60E;
	Thu, 11 Sep 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvcrFw3u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69072EE5E1;
	Thu, 11 Sep 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629621; cv=none; b=max8wVqcbEokTp6M9jqsc1eCNbErmhqf5mak5f25ug2ESonodKvaBToQIhnWnXqIFJCksOgy7s37uOpQYca8B1smKXn3e8+AmgQdkUrPupg7ZPrTotpgLgs5zWbBNgrY22F8KQ5HzlFHPZX0ZHETeGz+DnitQVNDRsAXnNGojAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629621; c=relaxed/simple;
	bh=Lghux1Bntyb2GrRrZ11EdHGNaGs6O2s/wGDMZaWtbuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebgl1BIseJJQsBf32DcldRxTgFUXcDuBsLLbqulLPlOWR9FyoJfudMbcUZMnUnHHmq5m8xXhLe1gyEjUIfgiUeOoiUSH1nn4djkExWexKInc9UQ+i5u0uIb/xZ4PzrN4bYM/T7RQFcjdWMtQ/Uza1meQKmo4ufS9+urmId4Cleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvcrFw3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFABC4CEF0;
	Thu, 11 Sep 2025 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757629621;
	bh=Lghux1Bntyb2GrRrZ11EdHGNaGs6O2s/wGDMZaWtbuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvcrFw3uEAk4eWJ2JHg9mcCkmvXQlDvmE9tCwfVxdrEHJmyuI7FD3jlKNBegeK7pG
	 sZf2uG3a41+6i79c9F6LJu93KnzoWycEdZ3Rm/t2jbvurzwTQKv7pGBTbYEDj4H7Uc
	 r/blz9x5vwQLb14UJQYP4PW5pIZiKMr5l6ijSTj+PHPcUWm24z9jH+4Qr5F/uFe3gj
	 HEJufOLIsvp8h1WUpv3+FQImv772fx56qRIu4ixNNG5znYVD+UOhgQL8PdSTdhoD90
	 4a3X7ZhIhb8zZSwNXW2JwdC0kJU45LYtUHu9yscxGYwcyonlqHZa/F+2T5ocr2kGSW
	 W19PLch3Hjqnw==
Date: Thu, 11 Sep 2025 15:27:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()
Message-ID: <20250911222700.GC8084@frogsfrogsfrogs>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
 <20250908-tune2fs-v1-1-e3a6929f3355@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-tune2fs-v1-1-e3a6929f3355@mit.edu>

On Mon, Sep 08, 2025 at 11:15:48PM -0400, Theodore Ts'o via B4 Relay wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> Unlike other strings in the ext4 superblock, we rely on tune2fs to
> make sure s_mount_opts is NUL terminated.  Harden
> parse_apply_sb_mount_options() by treating s_mount_opts as a potential
> __nonstring.

Uh.... does that mean that a filesystem with exactly 64 bytes worth of
mount option string (and no trailing null) could do something malicious?

My guess is that s_usr_quota_inum mostly saves us, but a nastycrafted
filesystem with more than 2^24 inodes could cause an out of bounds
memory access?  But that most likely will just fail the mount option
parser anyway?

--D

> 
> Cc: stable@vger.kernel.org
> Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 699c15db28a82f26809bf68533454a242596f0fd..94c98446c84f9a4614971d246ca7f001de610a8a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2460,7 +2460,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  					struct ext4_fs_context *m_ctx)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	char *s_mount_opts = NULL;
> +	char s_mount_opts[65];
>  	struct ext4_fs_context *s_ctx = NULL;
>  	struct fs_context *fc = NULL;
>  	int ret = -ENOMEM;
> @@ -2468,15 +2468,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	if (!sbi->s_es->s_mount_opts[0])
>  		return 0;
>  
> -	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
> -				sizeof(sbi->s_es->s_mount_opts),
> -				GFP_KERNEL);
> -	if (!s_mount_opts)
> -		return ret;
> +	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
>  
>  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
>  	if (!fc)
> -		goto out_free;
> +		return -ENOMEM;
>  
>  	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
>  	if (!s_ctx)
> @@ -2508,11 +2504,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	ret = 0;
>  
>  out_free:
> -	if (fc) {
> -		ext4_fc_free(fc);
> -		kfree(fc);
> -	}
> -	kfree(s_mount_opts);
> +	ext4_fc_free(fc);
> +	kfree(fc);
>  	return ret;
>  }
>  
> 
> -- 
> 2.51.0
> 
> 
> 

