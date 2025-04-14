Return-Path: <linux-ext4+bounces-7230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB84A87786
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 07:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA00D189081B
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6011A08A6;
	Mon, 14 Apr 2025 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WwhW0WuC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD891E485;
	Mon, 14 Apr 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744609705; cv=none; b=ZBvYahPK+F3HZQUwLWpwAdEg1DTluR8twR4eGryDYStiZZIlgMDwFP4PBenw9agSDi535bd2TtJl9ek8tfIpdazCPHnwdvInBibmZnzzQdZRflcvkcZc6XibaN87m787MAwKdWAuHSYy+U3IRh+JvS2jDSQVVq1PibudAobghEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744609705; c=relaxed/simple;
	bh=SbapbrkpoGdeQpyjbd4RPY4p9FflrUn2+C6Sn4nvZrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwvyKTMt6TiYpau0n9zez5AriKEJNWf9p4UPszNkQIItYiRW9JO/Rw/QxGJjhhviy2eHklxB0IQPLc/xpteAAqIH65XVEEANetNmFZOwNErWR68gW9RfJZVuMbYYcKNYleDA/X14DjTtQHSQdSr/PtFO6kvsthtKSpsCRFvaJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WwhW0WuC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y7c2eL7DWSvin2AXqYFI2csGJzyQuS49Lz+Est+gDOU=; b=WwhW0WuCH1QOz3z+HdRnvcP+xA
	IdWcaD/iTaJPaz4CwbKaLlk2NwsAmc3S6RdzoYDC7ypVcHjANOMoBb7Wb+e+NgJbGi5Nf9OPDVm2D
	nOHP1LSHGtxFif6BiOw6CKRumT1f7vPpTyCZScReDFMZ4VMWrzJx1Dwjpi+tByZLo+teWnj2rd7l9
	Gix7tRWa/bfsMCe2gpKFemfLJg0jeKbZ/tG8AhzqIVsNdlnJrG3W+BSPu92e7uWfQVoYiAxhx0M9O
	UbVeloRhiAkEbrtu/rNDj30ObYLX6Vz4IG7PS5dLAY30Z67qsqHTvzOnDj4nXaZRoxr04++U7EdPj
	q6UGij0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4CgB-00000000jZV-0KsI;
	Mon, 14 Apr 2025 05:48:23 +0000
Date: Sun, 13 Apr 2025 22:48:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
Message-ID: <Z_yhpwBQz7Xs4WLI@infradead.org>
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 11, 2025 at 11:44:52PM +0530, Nirjhar Roy (IBM) wrote:
> mkfs.xfs -f /dev/loop0
> mount /dev/loop0 /mnt/scratch
> mount -o remount,noattr2 /dev/loop0 /mnt/scratch # This should fail but it doesn't

Please reflow your commit log to not exceed the standard 73 characters

> xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n and hence, the
> the following if condition in xfs_fs_validate_params() succeeds and returns -EINVAL:
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
> With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return false and hence no error
> is returned.

But that also means the mount time check is wrong as well.

> +	/* attr2 -> noattr2 */
> +	if (xfs_has_noattr2(new_mp)) {
> +		if (xfs_has_crc(mp)) {
> +			xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
> +			return -EINVAL;
> +		}

So this check should probably go into xfs_fs_validate_params, and
also have a more useful warning like:

	if (xfs_has_crc(mp) && xfs_has_noattr2(new_mp)) {
		xfs_warn(mp,
"noattr2 cannot be specified for v5 file systems.");
                return -EINVAL;
	}


> +		else {
> +			mp->m_features &= ~XFS_FEAT_ATTR2;
> +			mp->m_features |= XFS_FEAT_NOATTR2;
> +		}
> +
> +	} else if (xfs_has_attr2(new_mp)) {
> +			/* noattr2 -> attr2 */
> +			mp->m_features &= ~XFS_FEAT_NOATTR2;
> +			mp->m_features |= XFS_FEAT_ATTR2;
> +	}

Some of the indentation here looks broken.  Please always use one
tab per indentation level, places the closing brace before the else,
and don't use else after a return statement.

