Return-Path: <linux-ext4+bounces-5963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C43A04D81
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 00:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C904B7A21F3
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35BA1E5707;
	Tue,  7 Jan 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvqqPFRT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DF192598
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292448; cv=none; b=XXpgt5gpW/VCZ6eDDk3js76VJXD/oQws6sZFTZkAizETylxcSNaZcE3MIprhvmsiHI2TVJ3q4idTeOQxhaMtFv2iR8sxcWbWNO0PfgvBDo/la6iJ2+1BOIceAyoS+m0pjWYlooui5fVtK03K3jagwWMWsU45xIOvPuj+jbkeKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292448; c=relaxed/simple;
	bh=/Gz7p1wuDpctamCF97ntcAHxazO+j3BFnndH3bTiHfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj+jxY6pyAMZ/RuQGaT9dSngfYPXVJSM5RDw0N88SiEtpVkX4cnd4v8q5SLsREGr0uVd/FyMTvW/6x62DDYtSp2sYRx/aLVURcAopGpS4ePrpxmaaxtg7sMAMvg3grlyIP3sIcSJ+NdNlaV/o3mbEccWW5M9VmcJn4wZdYsVBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvqqPFRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3381AC4CED6;
	Tue,  7 Jan 2025 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736292448;
	bh=/Gz7p1wuDpctamCF97ntcAHxazO+j3BFnndH3bTiHfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvqqPFRTXErYwqqoM8tHchPydLFt3j+JOa1llTYfwQCZTAxn2uGuUCSKV1kB9qUmb
	 NSuQ7y9HWdJJcdoxJW2JmUSPSSyXblIaPtGRrQP2DEuSplFdeYjtinIgdNQGO4eAPN
	 spJNWu0w/UGzriXZNvcnp2TjmKmlipi09cFAnojAazbi6Ml3BEQs0rL2VOWFlLZmGF
	 wgVcfeo3e+FI4JLvXElO+LMBXvzgTMvGKHt2Lh9VFZxy6qae5qhptfYZtGHDP3851v
	 jFt2MD7HcJsooH09+oRb1i3S20ftNUv4Wo485JQoWsOZ/23hF0zPEsKQpGlCZhGZfr
	 QrM+vlKTbfPSg==
Date: Tue, 7 Jan 2025 15:27:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jakub Wilk <jwilk@jwilk.net>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH e2fsprogs] e2image.8: add missing comma
Message-ID: <20250107232727.GB6152@frogsfrogsfrogs>
References: <20250107070724.6375-1-jwilk@jwilk.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107070724.6375-1-jwilk@jwilk.net>

On Tue, Jan 07, 2025 at 08:07:24AM +0100, Jakub Wilk wrote:
> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  misc/e2image.8.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc/e2image.8.in b/misc/e2image.8.in
> index 384ef302..0be1c751 100644
> --- a/misc/e2image.8.in
> +++ b/misc/e2image.8.in
> @@ -326,5 +326,5 @@ http://e2fsprogs.sourceforge.net.
>  
>  .SH SEE ALSO
>  .BR dumpe2fs (8),
> -.BR debugfs (8)
> +.BR debugfs (8),
>  .BR e2fsck (8)
> -- 
> 2.39.5
> 
> 

