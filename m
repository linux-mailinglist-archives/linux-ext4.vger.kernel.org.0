Return-Path: <linux-ext4+bounces-9153-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E7B0E322
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2764E1C85BD4
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAD27D770;
	Tue, 22 Jul 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkNyL6Rb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6B280025;
	Tue, 22 Jul 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207101; cv=none; b=nIsuG2N8XlPFc1rMkiqgG6+Mjtjf6u+z92A78Q4Vz0g6UQE+TPOd6cQVvauN/ue9YyXG+/VH464BBG/9+OrIqNfCZYZYHM9NENydvqiXn2sGqZUtug88sC8BLz046XK0yLOP7+ZMEs/c6FstbAZlHWqYJU7p2x1/jXl/CdmFFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207101; c=relaxed/simple;
	bh=rTGJ4FpBPs31eng44jVccK+/A2bp5NVU33SO120uDME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxSVH2WK+lWT6SzrpsGnPlPwt5Ix4JDxT0Lmfys0RVbm0Khpit0kX25M76ksH+qpspFpPbohxaH9frTMJx2LMGSEqVX2b1TkHPA8NMw9c1tL5ESp8K56GqkYEpcjflehfpF6pbUv4AQ7acF7+tv7hpzHzYmbUNAMnu0yuhWGsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkNyL6Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D45C4CEF1;
	Tue, 22 Jul 2025 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753207101;
	bh=rTGJ4FpBPs31eng44jVccK+/A2bp5NVU33SO120uDME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkNyL6RbQJ/tyLVELIJpngeP2TAs/LEhQTj0whbK6VCznM4HkEzDRDXM5VHWUmffA
	 PSFLanYaJKfrRX/mHCVuIs/as216AYjmvj+rPt7ZrkIPHXpfbWe5Wx0i5iUk1vr4dE
	 xq7ULjuuZK+lsgS4TDPoaLdv1HfF0do1nGpXnR//UOUANRuRafLe/obr3NJRSZSpob
	 Ly4O4vqzNecg3H5cyO6zZM5w+Uf6l43AtdVSctjtbe4lRGFVdhLGGlMbUwlMSus2mr
	 C7ttRy9jbwIKyliiYn64fjIbiiiAlOiCUIXjB+w2NNKGWYOnfCcF7ITao9lb4FFrkc
	 C8bKA8/4PGoyw==
Date: Tue, 22 Jul 2025 10:58:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: disallow atomic writes on DAX
Message-ID: <20250722175820.GV2672070@frogsfrogsfrogs>
References: <20250722150016.3282435-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722150016.3282435-1-john.g.garry@oracle.com>

[cc linux-ext4 because ext4_file_write_iter has the same problem]

On Tue, Jul 22, 2025 at 03:00:16PM +0000, John Garry wrote:
> Atomic writes are not currently supported for DAX, but two problems exist:
> - we may go down DAX write path for IOCB_ATOMIC, which does not handle
>   IOCB_ATOMIC properly
> - we report non-zero atomic write limits in statx (for DAX inodes)
> 
> We may want atomic writes support on DAX in future, but just disallow for
> now.
> 
> For this, ensure when IOCB_ATOMIC is set that we check the write size
> versus the atomic write min and max before branching off to the DAX write
> path. This is not strictly required for DAX, as we should not get this far
> in the write path as FMODE_CAN_ATOMIC_WRITE should not be set.
> 
> In addition, due to reflink being supported for DAX, we automatically get
> CoW-based atomic writes support being advertised. Remedy this by
> disallowing atomic writes for a DAX inode for both sw and hw modes.

You might want to add a separate patch to insert:

	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
		return -EIO;

into dax_iomap_rw to make it clear that DAX doesn't support ATOMIC
writes.

> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Fixes: 9dffc58f2384 ("xfs: update atomic write limits")
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Otherwise seems reasonable to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> Difference to v1:
> - allow use max atomic mount option and always dax together (Darrick)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index ed69a65f56d7..979abcb25bc7 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1099,9 +1099,6 @@ xfs_file_write_iter(
>  	if (xfs_is_shutdown(ip->i_mount))
>  		return -EIO;
>  
> -	if (IS_DAX(inode))
> -		return xfs_file_dax_write(iocb, from);
> -
>  	if (iocb->ki_flags & IOCB_ATOMIC) {
>  		if (ocount < xfs_get_atomic_write_min(ip))
>  			return -EINVAL;
> @@ -1114,6 +1111,9 @@ xfs_file_write_iter(
>  			return ret;
>  	}
>  
> +	if (IS_DAX(inode))
> +		return xfs_file_dax_write(iocb, from);
> +
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		/*
>  		 * Allow a directio write to fall back to a buffered
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 07fbdcc4cbf5..bd6d33557194 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -358,9 +358,20 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
>  
>  static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
>  {
> +	if (IS_DAX(VFS_IC(ip)))
> +		return false;
> +
>  	return xfs_inode_buftarg(ip)->bt_awu_max > 0;
>  }
>  
> +static inline bool xfs_inode_can_sw_atomic_write(const struct xfs_inode *ip)
> +{
> +	if (IS_DAX(VFS_IC(ip)))
> +		return false;
> +
> +	return xfs_can_sw_atomic_write(ip->i_mount);
> +}
> +
>  /*
>   * In-core inode flags.
>   */
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 149b5460fbfd..603effabe1ee 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -616,7 +616,8 @@ xfs_get_atomic_write_min(
>  	 * write of exactly one single fsblock if the bdev will make that
>  	 * guarantee for us.
>  	 */
> -	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
> +	if (xfs_inode_can_hw_atomic_write(ip) ||
> +	    xfs_inode_can_sw_atomic_write(ip))
>  		return mp->m_sb.sb_blocksize;
>  
>  	return 0;
> @@ -633,7 +634,7 @@ xfs_get_atomic_write_max(
>  	 * write of exactly one single fsblock if the bdev will make that
>  	 * guarantee for us.
>  	 */
> -	if (!xfs_can_sw_atomic_write(mp)) {
> +	if (!xfs_inode_can_sw_atomic_write(ip)) {
>  		if (xfs_inode_can_hw_atomic_write(ip))
>  			return mp->m_sb.sb_blocksize;
>  		return 0;
> -- 
> 2.43.5
> 

