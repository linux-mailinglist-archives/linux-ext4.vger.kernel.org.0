Return-Path: <linux-ext4+bounces-12279-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB979CB43EA
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 00:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 088853013EFB
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F12F6597;
	Wed, 10 Dec 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHa8rSJV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61D28B4FE;
	Wed, 10 Dec 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409085; cv=none; b=ttWZdiOwadGUnlhryF/x/0ULL5w11yK4qHrcdq8oaaThNwop4ZsMk52OoMxEt2RFeZgZFWtB+1WMfkatWa8Tafxn203Omn/DwryPpei408XdKSJ2HPxBUUwtED3rrHW0Hhq0CgoAO/bXJRf3kBF1PanVKjjaYAdBxn96fp73yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409085; c=relaxed/simple;
	bh=QHFYGkjS7t/tV5LAsSqLpR1Ex3WMImzlq9muG/JD+p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGN3azoo5SicUg7STinSkN0FmH78I+B7WjvXjZtYmLlj/b0CZH1wy/9LPSTTYOGFxGRQ7sAX3+d6sOdmrb5tAFKqPbWuxu0igrWjApf63uTeKuhusodM0ff7kMirNd96Jpj+faOcJ34LAfwbDref0rfXA+PEwTXjIRPLK0OT2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHa8rSJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015F8C4CEF1;
	Wed, 10 Dec 2025 23:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765409085;
	bh=QHFYGkjS7t/tV5LAsSqLpR1Ex3WMImzlq9muG/JD+p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHa8rSJVWfy4aLXb3iqsSdNm2v0QL6r3Oy7xza97MQ3IqUTQm76ip/MIGWm1TrGYp
	 x03SbNyLltjDkrkGqABVIguTGvpbJaRDdLEFx7FjgOyCq3NXvyJ8nvcW2YL89bh/QP
	 RaZoxlZbomiouPaKcdGTXD+ODE0GNotmlas0pdgjk4wSfBQIHtet5i3o5qxEkQ6ZrR
	 FqBsOOdceTiR+HRTzv5T1VDqRyXYhMGR3DWNTv7l0QrivhNZMCvHmQqRdLJYXEZjd7
	 xJZdedH2uEtv0Jq32qBAHDL2OL8ErFS8qy+h0Ycjm0Zyl59RhJslJr0In8gmCzSP4t
	 oRRT51Z9AKj2A==
Date: Wed, 10 Dec 2025 15:24:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/12] ext4/032: use _check_dev_fs
Message-ID: <20251210232444.GL94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-5-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:50AM +0100, Christoph Hellwig wrote:
> _check_dev_fs is the new designated helper to check file systems on
> arbitrary devices, use that instead of _check_generic_filesystem, which
> is just an implementation detail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks reasonable to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/ext4/032 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 690fcf066c11..043ae4f53505 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -66,7 +66,7 @@ ext4_online_resize()
>  	$UMOUNT_PROG ${IMG_MNT}
>  
>  	echo "+++ check fs" | tee -a $seqres.full
> -	_check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
> +	_check_dev_fs $LOOP_DEVICE >> $seqres.full 2>&1 || \
>  		_fail "fsck should not fail"
>  	_destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
>  }
> -- 
> 2.47.3
> 
> 

