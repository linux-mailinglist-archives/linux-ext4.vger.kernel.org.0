Return-Path: <linux-ext4+bounces-12232-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F413CADF48
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 19:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2DB305E37B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2DD25F79A;
	Mon,  8 Dec 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLMzlBUN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D551226CFD;
	Mon,  8 Dec 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765216991; cv=none; b=brNdqDhyAoNTwd2xaLUC9xlIj9mCpgldH/h23x1F4fCXZEo5VBe+kLVlFiki0kaKkgGUJEtOabnF9IP9Ff4NFIguyw6PF9LJvzzB8cjk/6B3N7isGOJ8aaXyinyZc/6Itq64smzPIjKGJ3QwCEe+LH9CXFC6s9SpZS5kh17BcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765216991; c=relaxed/simple;
	bh=mKGbWv+8gm1ScPlHPYlrIjOmhZ2UKnWr3QIZ4KlRYd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYcNnBqBOVkVna0IHyw5iwqA0y1Jrz/j5gOL/24mzvIRQ7Pe0aRU52KICFXzWcHrv2vVuN++kgDdQDrcWJfNysKJzm1s83YNe5nPmUj5tYkdO48pc5Bb9/9bHl9SU1BITSL9/MYDM7FXQUUXpRM9qSNCzr1i/h04RHk+tYhDi2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLMzlBUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86CDC4CEF1;
	Mon,  8 Dec 2025 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765216991;
	bh=mKGbWv+8gm1ScPlHPYlrIjOmhZ2UKnWr3QIZ4KlRYd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLMzlBUNFna3qWUozOSin00o0SL+xJqRZvEbQiMEkt6oLB1TbjkCRubJvvK72mbQd
	 K/MQNHGlARwCqU2aU0cFbDBpyE6toIJlAywmV3ub6AWNLo5SvTJkoN1Upy86I3h1m/
	 8K8raMxOlEjm37kDjl83GkYSwK5mjOiOVwKcRD4XMMPmneIn+8IX9i4IGAiASsfwgi
	 66upiR1zk93leCPUWlDrhu/sw5xyanVBE05OjztUjXRCRG21Rddh+qEdXIQIh44WY8
	 yk2dmtmUho2tkXktBy8C3fSsyGzXIrN4w/aWbczyXZxSjYfE1WGRWne1VU/I77lw9q
	 QTKhoWrxi7zcw==
Date: Mon, 8 Dec 2025 10:03:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ext4: fix ext4_tune_sb_params padding
Message-ID: <20251208180310.GH89492@frogsfrogsfrogs>
References: <20251205111906.1247452-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205111906.1247452-1-arnd@kernel.org>

On Fri, Dec 05, 2025 at 12:19:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The padding at the end of struct ext4_tune_sb_params is architecture
> specific and in particular is different between x86-32 and x86-64,
> since the __u64 member only enforces struct alignment on the latter.
> 
> This shows up as a new warning when test-building the headers with
> -Wpadded:
> 
> include/linux/ext4.h:144:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]
> 
> All members inside the structure are naturally aligned, so the only
> difference here is the amount of padding at the end.
> 
> Add explicit padding to mount_opts[] to keep the struct members compatible
> with the original version and also keep the pad[64] member 8-byte
> aligned for future extensions.  This gives a consistent sizeof(struct
> ext4_tune_sb_params) of 232 on all architectures and avoids adding compat
> ioctl handling for EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.
> 
> This is an ABI break on x86-32 but hopefully this can go into 6.18.y
> early enough as a fixup so no actual users will be affected.
> 
> Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: extend mount_opts[] instead of pad[], as suggested by Andreas Dilger
> ---
>  include/uapi/linux/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> index 6829d6f1497d..1c7cdcdb7dca 100644
> --- a/include/uapi/linux/ext4.h
> +++ b/include/uapi/linux/ext4.h
> @@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
>  	__u32 clear_feature_compat_mask;
>  	__u32 clear_feature_incompat_mask;
>  	__u32 clear_feature_ro_compat_mask;
> -	__u8  mount_opts[64];
> +	__u8  mount_opts[68];

Hmm... given that the ondisk super field is a __u8[64], it feels weird
to expose a __u8[68] field in the ioctl ABI and silently truncate the
user's input if they try to use that many bytes.  I'd have enlarged the
padding field but as Ted was both author and maintainer I'm ok with
letting him have the final say.

--D

>  	__u8  pad[64];
>  };
>  
> -- 
> 2.39.5
> 

