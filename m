Return-Path: <linux-ext4+bounces-7807-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BAAB35A0
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D381C1898174
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B32797A1;
	Mon, 12 May 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa9e4Q/O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598617555;
	Mon, 12 May 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048253; cv=none; b=V9cuCmsEZSQSoy6D7xsJ/Tq5LUf/J5MJ1CtDpH1BZz3ZG0vgvfrjf0qZrW2rT4ZotYPQ30DsutpMaFoL/VRiTGM+hkxtfwiKBzwdHgPjJ5bAzns0kkFwpr33nzJatiFxNZAOIG3DeAG2hMoIQWTCnSvK+w4fT5ZzJp3Poij0KJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048253; c=relaxed/simple;
	bh=wqh9HZy0k6PHTnNj+aTG+u6pBD6Q5cSG8VSQ2zyYTzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2I3nIWeHyjb/bdFP/SqvObugFy4lO0gMchnwYUbi35/zwJME4qOmboKz4LPcte2HbOco5VmMGZAywdjev8ssvY3FnoK4a2zPAqtAmR7fMy/FacmTGtOBzwQeUwiMR9Tx4B21sshmJLC775TUMQlHuSpJmpoAqU8KLfTkAc8DBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa9e4Q/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28888C4CEE7;
	Mon, 12 May 2025 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747048253;
	bh=wqh9HZy0k6PHTnNj+aTG+u6pBD6Q5cSG8VSQ2zyYTzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xa9e4Q/OqCFDMljrde1+ciIyetJEu9n7Y4nwR96dtLVlH+OuknDI9olbnMmU0wPe2
	 TvTeRZGOIPgvfrMYlDLQjwihrQ2+fbFXenipbToQ7Pe1HhF/SLkTSZptOojPO3vzdZ
	 sEYSdICBJ/IKLh+aFP0sxR0g/K/D+EHYBZJxwkG9vdgK7TjS/3xUTH/RZkZkYgON7z
	 OGUbQSOaGR1/0YT4g0fg14fJ/KgTuUZ5+mf9166nXniPN7ZmURWBD46z/mv+NAyukZ
	 5C73K7XQOEBhxCZp7VtNEfeNFkUL7RMF6GdYsfvR/1/Brj7NvzF8X+yK8IRplbjL0i
	 vwEOCOcjOkUVQ==
Date: Mon, 12 May 2025 13:10:47 +0200
From: Carlos Maiolino <cem@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org, 
	zlang@kernel.org, david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v5 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Message-ID: <xwx4pyblttfkrxfq3wlorwz743oathzvjdigehgke4gsu6vona@xfftyhxmzr22>
References: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
 <uvQIPMIpyNU1GgrBWDuyTQvD6gJNGgIBfFc0qRZt-ehl_bRnVMTBNcfYRxRqjgkUSJVXaltU7eN1HGLqi4Vp1w==@protonmail.internalid>
 <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>

On Mon, May 12, 2025 at 03:27:14PM +0530, Nirjhar Roy (IBM) wrote:
> Bug: When we compile the kernel with CONFIG_XFS_SUPPORT_V4=y,
> remount with "-o remount,noattr2" on a v5 XFS does not
> fail explicitly.
> 
> Reproduction:
> mkfs.xfs -f /dev/loop0
> mount /dev/loop0 /mnt/scratch
> mount -o remount,noattr2 /dev/loop0 /mnt/scratch
> 
> However, with CONFIG_XFS_SUPPORT_V4=n, the remount
> correctly fails explicitly. This is because the way the
> following 2 functions are defined:
> 
> static inline bool xfs_has_attr2 (struct xfs_mount *mp)
> {
> 	return !IS_ENABLED(CONFIG_XFS_SUPPORT_V4) ||
> 		(mp->m_features & XFS_FEAT_ATTR2);
> }
> static inline bool xfs_has_noattr2 (const struct xfs_mount *mp)
> {
> 	return mp->m_features & XFS_FEAT_NOATTR2;
> }
> 
> xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n
> and hence, the following if condition in
> xfs_fs_validate_params() succeeds and returns -EINVAL:
> 
> /*
>  * We have not read the superblock at this point, so only the attr2
>  * mount option can set the attr2 feature by this stage.
>  */
> 
> if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
> 	xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
> 	return -EINVAL;
> }
> 
> With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return
> false and hence no error is returned.
> 
> Fix: Check if the existing mount has crc enabled(i.e, of
> type v5 and has attr2 enabled) and the
> remount has noattr2, if yes, return -EINVAL.
> 
> I have tested xfs/{189,539} in fstests with v4
> and v5 XFS with both CONFIG_XFS_SUPPORT_V4=y/n and
> they both behave as expected.
> 
> This patch also fixes remount from noattr2 -> attr2 (on a v4 xfs).
> 
> Related discussion in [1]
> 
> [1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b2dd0c0bf509..606a95ac816f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2114,6 +2114,21 @@ xfs_fs_reconfigure(
>  	if (error)
>  		return error;
> 
> +	/* attr2 -> noattr2 */
> +	if (xfs_has_noattr2(new_mp)) {
> +		if (xfs_has_crc(mp)) {
> +			xfs_warn(mp,
> +			"attr2 is always enabled for a V5 filesystem - can't be changed.");
> +			return -EINVAL;

This looks good to me now:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

I still wish hch's opinion here though before merging it. Giving his was the
first RwB, I want to make sure he still keeps his RwB with the above change.


FWIW, for a next patch, there is no need to copy ext4 list for a code change
that is totally unrelated to ext4. This just generates unnecessary extra
traffic.


> +		}
> +		mp->m_features &= ~XFS_FEAT_ATTR2;
> +		mp->m_features |= XFS_FEAT_NOATTR2;
> +	} else if (xfs_has_attr2(new_mp)) {
> +		/* noattr2 -> attr2 */
> +		mp->m_features &= ~XFS_FEAT_NOATTR2;
> +		mp->m_features |= XFS_FEAT_ATTR2;
> +	}
> +
>  	/* inode32 -> inode64 */
>  	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
>  		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
> @@ -2126,6 +2141,17 @@ xfs_fs_reconfigure(
>  		mp->m_maxagi = xfs_set_inode_alloc(mp, mp->m_sb.sb_agcount);
>  	}
> 
> +	/*
> +	 * Now that mp has been modified according to the remount options,
> +	 * we do a final option validation with xfs_finish_flags()
> +	 * just like it is done during mount. We cannot use
> +	 * xfs_finish_flags()on new_mp as it contains only the user
> +	 * given options.
> +	 */
> +	error = xfs_finish_flags(mp);
> +	if (error)
> +		return error;
> +
>  	/* ro -> rw */
>  	if (xfs_is_readonly(mp) && !(flags & SB_RDONLY)) {
>  		error = xfs_remount_rw(mp);
> --
> 2.43.5
> 
> 

