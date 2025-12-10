Return-Path: <linux-ext4+bounces-12273-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E22CB3E77
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A2A1300D4D6
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DD32A3FE;
	Wed, 10 Dec 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEMhqLWA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F3329E61;
	Wed, 10 Dec 2025 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396556; cv=none; b=LdGlGh/yEgHNtm7D3ak9Uv4XKoEEuuh6o6uagwWY/O9FDLhVa6Xbvq7pdsJtdA6V8FuuSLBOXQ0TwETFAGqJYFfA+nU/yi3/x8dWlFQfcR1bJQIi3xNDI12tXMupGv/SdXeDJuc7fdr0SJVHdTjQkm9V0EKvwlcniUCeddfK3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396556; c=relaxed/simple;
	bh=YLMeftSJnCtaaz5zcK9ebyCGVXBr3jQkKEvUZ6cdTYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQiRgOEJ15lrmCUMnoleJ+Yo/nEfxbrgdRFgURwdGKoXfykJzUjR9wOMJUc4n/BS1VgZIzWLA03IfrXEd0eXKfEjs3PzIonTW6x34t/v0cRc9oRgsg0VkafWrV9Wu8QQ3S6h8vbMYdrxUsim8zSBjuU9LInbcDjvEZGAL5iM+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEMhqLWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5784C4CEF1;
	Wed, 10 Dec 2025 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765396555;
	bh=YLMeftSJnCtaaz5zcK9ebyCGVXBr3jQkKEvUZ6cdTYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEMhqLWA0jQ5PNQX7fWLrnTeQuqnWIOirA1jhpeYPp9PP0TOOwzTomiojfd3nPhjZ
	 t1XHDM9Tw4eTqKLuTzBPuhcoQKiHZtLkC5+pVn+HtePjUVRAfiRVV6l+Cu8LjfrnDO
	 hZBpq9ApAHpfNLjTy6ZFMyJPyv5ZEh4TAAkQWmg57f2CETbqviPu3D7J9qAMUIV+om
	 sJ71AuytSt3FEHIf6TN58gl2gUqVJpyMnVhvTM9M7UF4cT1/AW44woJxYhBfzwckHN
	 CgZhtod/DNnW85Es/i+V7kNfd9GlNpP2T+9LmBQmuxke7YFOSN3dZBChCT4KfGHOGD
	 ZPav5WX+dhZrg==
Date: Wed, 10 Dec 2025 11:55:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/12] xfs/424: don't use SCRATCH_DEV helpers
Message-ID: <20251210195555.GF94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-9-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:54AM +0100, Christoph Hellwig wrote:
> This tests forces external devices to be disabled by calling mkfs.xfs
> directly and overriding SCRATCH_{LOG,RT}DEV, but the options specified in
> MKFS_OPTIONS might not work for this configuration.  Instead hard code
> the calls to xfs_db and don't modify the scratch device configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oh yikes.  Yeah, this is more straightforward...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/424 | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/xfs/424 b/tests/xfs/424
> index 6078d34897e7..61e9de375383 100755
> --- a/tests/xfs/424
> +++ b/tests/xfs/424
> @@ -25,17 +25,11 @@ filter_dbval()
>  	awk '{ print $4 }'
>  }
>  
> -# Import common functions.
>  . ./common/filter
>  
> -# Modify as appropriate
> -
> -# Since we have an open-coded mkfs call, disable the external devices and
> -# don't let the post-check fsck actually run since it'll trip over us not
> -# using the external devices.
> +# Since we have an open-coded mkfs call, don't let the post-check fsck run since
> +# it would trip over us not using the external devices.
>  _require_scratch_nocheck
> -export SCRATCH_LOGDEV=
> -export SCRATCH_RTDEV=
>  
>  echo "Silence is golden."
>  
> @@ -62,30 +56,31 @@ for SECTOR_SIZE in $sector_sizes; do
>  		grep -q 'finobt=1' && finobt_enabled=1
>  
>  	for TYPE in agf agi agfl sb; do
> -		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
> -		_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
> +		DADDR=`$XFS_DB_PROG -c "$TYPE" -c "daddr" $SCRATCH_DEV |
> +			filter_dbval`
> +		$XFS_DB_PROG -c "daddr $DADDR" -c "type $TYPE" $SCRATCH_DEV
>  	done
>  
> -	DADDR=`_scratch_xfs_db -c "sb" -c "addr rootino" -c "daddr" |
> +	DADDR=`$XFS_DB_PROG -c "sb" -c "addr rootino" -c "daddr" $SCRATCH_DEV |
>  		filter_dbval`
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type inode"
> -	DADDR=`_scratch_xfs_db -c "agf" -c "addr bnoroot" -c "daddr" |
> +	$XFS_DB_PROG -c "daddr $DADDR" -c "type inode" $SCRATCH_DEV
> +	DADDR=`$XFS_DB_PROG -c "agf" -c "addr bnoroot" -c "daddr" $SCRATCH_DEV |
>  		filter_dbval`
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type bnobt"
> -	DADDR=`_scratch_xfs_db -c "agf" -c "addr cntroot" -c "daddr" |
> +	$XFS_DB_PROG -c "daddr $DADDR" -c "type bnobt" $SCRATCH_DEV
> +	DADDR=`$XFS_DB_PROG -c "agf" -c "addr cntroot" -c "daddr" $SCRATCH_DEV |
>  		filter_dbval`
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type cntbt"
> -	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
> +	$XFS_DB_PROG -c "daddr $DADDR" -c "type cntbt" $SCRATCH_DEV
> +	DADDR=`$XFS_DB_PROG -c "agi" -c "addr root" -c "daddr" $SCRATCH_DEV |
>  		filter_dbval`
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
> +	$XFS_DB_PROG -c "daddr $DADDR" -c "type inobt" $SCRATCH_DEV
>  	if [ $finobt_enabled -eq 1 ]; then
> -		DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
> -			filter_dbval`
> -		_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
> +		DADDR=`$XFS_DB_PROG -c "agi" -c "addr free_root" -c "daddr" $SCRATCH_DEV |
> +			 filter_dbval`
> +		$XFS_DB_PROG -c "daddr $DADDR" -c "type finobt" $SCRATCH_DEV
>  	fi
>  
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
> -	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
> +	$XFS_DB_PROG -c "daddr $DADDR" -c "type text" $SCRATCH_DEV
> +	$XFS_DB_PROG -c "daddr $DADDR" -c "type data" $SCRATCH_DEV
>  done
>  
>  # success, all done
> -- 
> 2.47.3
> 
> 

