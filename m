Return-Path: <linux-ext4+bounces-10245-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A6B86668
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D4F585D3B
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949326A0C6;
	Thu, 18 Sep 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWRyRKCG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B372628;
	Thu, 18 Sep 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219482; cv=none; b=K7nv0lA1otcThho1+jxs8v3WUP3QDiYmmEcIpM8Og4fitNmlYEY2hpaF1UvJly0g3HDY6uZkerMw79GQW8NZOebMK5+taJaKEHPRBYXgnc15rpFLd6m6wupjYqwG+qrov6kIupBVh4V7V3DfM+ov0U+qy5zJz4hkXw1gZfw+upM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219482; c=relaxed/simple;
	bh=qufkgZZKy7ZxxYOj9C7tikS569ucn5i+tCKgORZvN1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8sw7E3k9+H3mcSYTLiUb0AghsdEoiTA5zQ7A62bwOppbFhtr/9NyctrtzvDbcsEyLcevd1ktiJ6bRUzugbXQMpRrwI8bYMlNvB/gDX59k37ltBtUXEB++9pHXaRGwHQ7QcwHKp68P/gCv7vS6H+aEjbZi3mo1mfiPsPbAHx0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWRyRKCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C965CC4CEE7;
	Thu, 18 Sep 2025 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758219481;
	bh=qufkgZZKy7ZxxYOj9C7tikS569ucn5i+tCKgORZvN1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWRyRKCGQJieRPPDTFdYziXCuu9h2uRIFu6l+4JgDL/FrBUoF12ThYjZ4U63MIzzd
	 g2MDGGecmVjzXj8E1r00f3cjJU97FigcPWIRzk92ogH44Fs8K4jMoFCfFCLp4fkBB9
	 Eks+pBFCFK9/21H2sQP/hwt8GnUluSjjrd306N9WLrcjWtwBvQAVDPTz4cGOxAtcvb
	 dO0WMXeZXClkAdbNJRahEoL9EFOSs6I9OKa+Lf/2cxYm2V98D5WBwDVImQjfvy1mz8
	 CBlkbtuZTE0+W2sBf/UZWVg7xL4RvO1MCjzH7crSE5tovJRxMv/reD+OOGv/sISpSS
	 Ep7wYMw0ttolQ==
Date: Thu, 18 Sep 2025 11:18:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH] Fix: ext4: guard against EA inode refcount underflow in
 xattr update
Message-ID: <20250918181801.GI8084@frogsfrogsfrogs>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918175545.48297-1-eraykrdg1@gmail.com>

On Thu, Sep 18, 2025 at 08:55:46PM +0300, Ahmet Eray Karadag wrote:
> syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
> inode refcount that is already <= 0 and then applies ref_change (often
> -1). That lets the refcount underflow and we proceed with a bogus value,
> triggering errors like:
> 
>   EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
>   EXT4-fs warning: ea_inode dec ref err=-117
> 
> Make the invariant explicit: if the current refcount is non-positive,
> treat this as on-disk corruption, emit EXT4_ERROR_INODE(), and fail the
> operation with -EFSCORRUPTED instead of updating the refcount. Delete the
> WARN_ONCE() as negative refcounts are now impossible; keep error reporting
> in ext4_error_inode().
> 
> This prevents the underflow and the follow-on orphan/cleanup churn.
> 
> Fixes: https://syzbot.org/bug?extid=0be4f339a8218d2a5bb1
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
>  fs/ext4/xattr.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5a6fe1513fd2..a056f98579c3 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1030,6 +1030,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  
>  	ref_count = ext4_xattr_inode_get_ref(ea_inode);
>  	ref_count += ref_change;
> +	if (ref_count < 0) {

Shouldn't this check ref_count >= ref_change *before* updating it?

--D

> +		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
> +				"EA inode %lu ref underflow: ref_count=%lld ref_change=%d",
> +				ea_inode->i_ino, ref_count, ref_change);
> +		ret = -EFSCORRUPTED;
> +		goto out;
> +	}
>  	ext4_xattr_inode_set_ref(ea_inode, ref_count);
>  
>  	if (ref_change > 0) {
> @@ -1044,9 +1051,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  			ext4_orphan_del(handle, ea_inode);
>  		}
>  	} else {
> -		WARN_ONCE(ref_count < 0, "EA inode %lu ref_count=%lld",
> -			  ea_inode->i_ino, ref_count);
> -
>  		if (ref_count == 0) {
>  			WARN_ONCE(ea_inode->i_nlink != 1,
>  				  "EA inode %lu i_nlink=%u",
> -- 
> 2.34.1
> 
> 

