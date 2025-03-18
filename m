Return-Path: <linux-ext4+bounces-6912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12136A677E4
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 16:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D45F42068B
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496020F09F;
	Tue, 18 Mar 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Kctr4a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2A20CCDB
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311858; cv=none; b=HeX/eNsVnfyd+2/8RIlZ0wRnJaKoeSGzXl6eOOnO3nK+PIwEqBA67wyrb0VKx7nV8hn+n6Cvs1LBWPivJF4tB6m8/oFgrCZFM+fi96GXYhqEV6GejuKiEqiEfoW3JIBrARjO/k+dX55Sfc2CJZzg2C2ScYWpGD575YyByr8WhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311858; c=relaxed/simple;
	bh=rp9dAUhA6Vl4Iz6aJiXk146ZIEjOGOWTgWigFaNbiM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHwxKLbUqU7sZJPDyG1XUUoo0gB2GeSXSQT7sTZzOqDElO8HbcY1e0LCp/H12r1RFbpeItCzHkPV4lBenm0Cdldfw8xlzd/y9Fe2BZTbGEN7SDDFcnjYX9zFCcljPu4jNzv/WU33oKtMo/Jby+WpjmIuDIMpgA9+sMc27GvUtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Kctr4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42401C4CEDD;
	Tue, 18 Mar 2025 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742311858;
	bh=rp9dAUhA6Vl4Iz6aJiXk146ZIEjOGOWTgWigFaNbiM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/Kctr4ajIL8jJR1OdSlzL+ocwu0FA69z03dlUdO5KuuUVIi4JZR0TrzNhMeBd+KQ
	 Iti34pQ1O6cih7Sc5q0fRUEqQ5L1QVTxGQ3p4y1MxcnHil4jR+mroQkn/fZ+BXZqXw
	 2c+c9+/E+oul7SU+dGP1VYH3xvBeze7yFeDzoMWWo2daYxcGWJJEN/pPi6R2o26CpU
	 RrQPsQjoX1zzoBgqAyqRT9MnXbO/WK0ks0ScfKIRALAmKfd20IzmkXPgGAXPCSd0xU
	 Y9FLKKLg2zTuYNgWSzq8ZWoxISj5bYRzlyDqZjCTdhMFFyXW6kBSpnl/F7SRCHzdaK
	 seTBik72tdaXw==
Date: Tue, 18 Mar 2025 08:30:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, stable@kernel.org
Subject: Re: [PATCH] ext4: don't over-report free space or inodes in statvfs
Message-ID: <20250318153057.GB2803723@frogsfrogsfrogs>
References: <20250318042347.1028443-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318042347.1028443-1-tytso@mit.edu>

On Tue, Mar 18, 2025 at 12:23:47AM -0400, Theodore Ts'o wrote:
> This fixes an analogus bug that was fixed in xfs in commit
> 4b8d867ca6e2 ("xfs: don't over-report free space or inodes in
> statvfs") where statfs can report misleading / incorrect information
> where project quota is enabled, and the free space is less than the
> remaining quota.
> 
> This commit will resolve a test failure in generic/762 which tests for
> this bug.
> 
> Cc: stable@kernel.org
> Fixes: 689c958cbe6b ("ext4: add project quota support")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Yeah, that looks exactly like the xfs solution to this problem...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/super.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4768770715ca..8cafcd3e9f5f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6820,22 +6820,29 @@ static int ext4_statfs_project(struct super_block *sb,
>  			     dquot->dq_dqb.dqb_bhardlimit);
>  	limit >>= sb->s_blocksize_bits;
>  
> -	if (limit && buf->f_blocks > limit) {
> +	if (limit) {
> +		uint64_t	remaining = 0;
> +
>  		curblock = (dquot->dq_dqb.dqb_curspace +
>  			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
> -		buf->f_blocks = limit;
> -		buf->f_bfree = buf->f_bavail =
> -			(buf->f_blocks > curblock) ?
> -			 (buf->f_blocks - curblock) : 0;
> +		if (limit > curblock)
> +			remaining = limit - curblock;
> +
> +		buf->f_blocks = min(buf->f_blocks, limit);
> +		buf->f_bfree = min(buf->f_bfree, remaining);
> +		buf->f_bavail = min(buf->f_bavail, remaining);
>  	}
>  
>  	limit = min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
>  			     dquot->dq_dqb.dqb_ihardlimit);
> -	if (limit && buf->f_files > limit) {
> -		buf->f_files = limit;
> -		buf->f_ffree =
> -			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
> -			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
> +	if (limit) {
> +		uint64_t	remaining = 0;
> +
> +		if (limit > dquot->dq_dqb.dqb_curinodes)
> +			remaining = limit - dquot->dq_dqb.dqb_curinodes;
> +
> +		buf->f_files = min(buf->f_files, limit);
> +		buf->f_ffree = min(buf->f_ffree, remaining);
>  	}
>  
>  	spin_unlock(&dquot->dq_dqb_lock);
> -- 
> 2.47.2
> 
> 

