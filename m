Return-Path: <linux-ext4+bounces-12268-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6794CB3DED
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A760930F48F1
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FAE30AD05;
	Wed, 10 Dec 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGgWQrSe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A44329E77;
	Wed, 10 Dec 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395147; cv=none; b=ARIzuMWo3diwlQYnZKYzwFU1U1HVuPCn0N9Ke18Hpo/IIFaaRA/WkA8k4CBAtx8e7IXn84nvcF7obKx6+7f4GgnNrFVmGNAf+YJicDOBSFIYwBv5yignwfQimoDjIpI2FSZCSVh9ENoCPJM+/UlQB08TbEdQnEcT9G8lbN7mjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395147; c=relaxed/simple;
	bh=WQMXNj24kGlHy1vHQK1q8lQWUdVKt86XUBICJh2ZTWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/ptsfWPLQpQpJjaC4T+vSQyAWg5UMSedaJCcg7WYJ2bgaC4BId3GrdLCOCjoYStqVvA0GPlCZilhXN/UzWBpYAcHS/qAg75UhyoguiEkzAw5zyCMf9p/jCuMsT4vL0mCfUc5rR40oFCg3RqIi3I9SBdpqrEWPUongz8auZGHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGgWQrSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B851DC4CEF1;
	Wed, 10 Dec 2025 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765395146;
	bh=WQMXNj24kGlHy1vHQK1q8lQWUdVKt86XUBICJh2ZTWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGgWQrSeDbT6BgYt/O5SJuqgXekLhjbsMhoBoRTt3wewfRUDU1H7hIqGf0fghsIxO
	 egC4QRypLjlpEvpUA7B+aZfK8Nf5QcAM5PJT06D/nxhQjF/6Eq+kHLtpJh2Tmu10ZU
	 CrCe5lnioztPyNJpaZufJf+Upj3S4uyOXfAXD7tdn8lJzi3eyKe7r5JEt83HG/w3BD
	 /R06ZlHydiih6KAmmyQTuyOFvmYDLzEqWSqbjglbvMPnvxwKEI0YarIxqNT3H9g2ep
	 gLo9BxmCdd+MwHngYV0W0q1DufHSrIrtcDRpPL6a9y+u2ViITbSjb2Kp4ES5wlPrrW
	 Nl9ySG83LsdWA==
Date: Wed, 10 Dec 2025 11:32:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/12] ext4/006: call e2fsck directly
Message-ID: <20251210193226.GA94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-3-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:48AM +0100, Christoph Hellwig wrote:
> _check_scratch_fs takes an optional device name, but no optional
> arguments.  Call e2fsck directly for this extN-specific test instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/ext4/006 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 2ece22a4bd1e..07dcf356b0bc 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -44,7 +44,7 @@ repair_scratch() {
>  	res=$?
>  	if [ "${res}" -eq 0 ]; then
>  		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> +		e2fsck -n >> "${FSCK_LOG}" 2>&1

Doesn't this need a device name?  e.g. e2fsck -n $SCRATCH_DEV ?

--D

>  		res=$?
>  	fi
>  	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"
> -- 
> 2.47.3
> 
> 

