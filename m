Return-Path: <linux-ext4+bounces-7535-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC852AA0B60
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 14:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B920467923
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250D2C17A7;
	Tue, 29 Apr 2025 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xl66CVQZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99C2C1097;
	Tue, 29 Apr 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929116; cv=none; b=VSPXyVNy09ER6BMLNIbywvgf2q6wcLLa3zNUtX+ISEP09O1XQdLIHjycLvXLGLxSqmXUO8JnzQdkPUlotemzCdcFTcTRhZplUptBdY/TPQQxlJagnV9mcSpXECRMxOfePOM5smDChH8D4GNfWTnWFZ4tAA3R5qKM1McKwEbPrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929116; c=relaxed/simple;
	bh=8P/pGG645Uw2xUwBTv/A6+XX8ErrJPccIQZV++iygVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLalN6eG/RXymPDeKnwbkvgRBAiCWYpWxaeGhEsGAsp8mBlCEdnoU1ZyWcAPxxqfpB0z/Ex/dsFQ3tG9KAjgETT33dD/t96MNJuahyuHRkKK10bT0QM6av+CLSSgprqceTOeVDNutaJV9k0CIza71fqtf+RaMAcVI90MLK8o+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xl66CVQZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2PPbZDLluvDRsJ3p7U9l8wGawZPJMNdcXZGjCT7fEu4=; b=xl66CVQZLNFsaR6ereTbas9UF3
	6VNH1w6c9Lhd4KCgsSCOfhBMUTgkNECNsFCs8DsYo7HTY/ojKPXKmKoNDDhPCpY+tNwUsZZvSvUV9
	RpG2AraaDdyrAVOLEzruGJ+6Yv2eyUbrd1HUx5bxl+7xLtRvIKtGsvlzYuWRRuWbSCPL/2Miu+HzA
	dMCozBtz52wpaF6h6A98lZycx34qWYt2/fJLFePqAKHKo/RYR4LBJjdenTLiBaL1TWbmuJeUMptBB
	3qrMy5g7KY/pTyvVIH0eGi8WIlQZn2coxHub8vIDWm2gt9Q6z9vHlEjIdlQUWyFaE4sFvGpoVE1Cz
	ZDGajc4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9juy-00000009csx-40UK;
	Tue, 29 Apr 2025 12:18:32 +0000
Date: Tue, 29 Apr 2025 05:18:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v2 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Message-ID: <aBDDmDymL8yMxloN@infradead.org>
References: <cover.1745916682.git.nirjhar.roy.lists@gmail.com>
 <94a5d92139aef3a42929325bc61584437957190e.1745916682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a5d92139aef3a42929325bc61584437957190e.1745916682.git.nirjhar.roy.lists@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 29, 2025 at 02:32:08PM +0530, Nirjhar Roy (IBM) wrote:
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
> and hence, the the following if condition in
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
> ---
>  fs/xfs/xfs_super.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b2dd0c0bf509..1fd45567ae00 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2114,6 +2114,22 @@ xfs_fs_reconfigure(
>  	if (error)
>  		return error;
>  
> +	/* attr2 -> noattr2 */
> +	if (xfs_has_noattr2(new_mp)) {
> +		if (xfs_has_crc(mp)) {
> +			xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");

Nit: normal xfs style is to move the message to a new line when іt
overflows 80 characters:

		if (xfs_has_crc(mp)) {
			xfs_warn(mp,
	"attr2 and noattr2 cannot both be specified.");

> +			return -EINVAL;
> +		}
> +		else {

No need for an else after a return.  And for cases where there is an
else the kernel coding style keeps it on the same line as the closing
brace.

> +	/* Now that mp has been modified according to the remount options, we do a
> +	 * final option validation with xfs_finish_flags() just like it is done
> +	 * during mount. We cannot use xfs_finish_flags() on new_mp as it contains
> +	 * only the user given options.
> +	 */

Please keep comments to 80 characters.  Also the kernel coding style
keeps the

	/*

at the beginning of a comment on a separate line.


