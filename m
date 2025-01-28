Return-Path: <linux-ext4+bounces-6264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B6A2120F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 20:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4497E166FDD
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AF81DED64;
	Tue, 28 Jan 2025 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCTHWjN8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C619ABB6;
	Tue, 28 Jan 2025 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091826; cv=none; b=Jkeydkpr3C+CfR/38Llzc51qF9RhqIJdaN3fhIGubkYmHk4436xI3PmheZkIDLY0PcRHVTZ7pOyhlnzAnND27M52epAO0MdPHb1YG8P6xZB2ckHWImjlenIejMPRm0oJrjs0M3gHl2FSMfcEs8gIMjBWlhwmwHlRxSXTv+b+Ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091826; c=relaxed/simple;
	bh=DfjTjfSy3oOvPON9YbjE3BrQNfka9zAP1UEfPpVzvmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnqAlIqn/kJV4xchQ9DiyKdQHl4jGBTind9nJ77OeAMtlfuhifhJZ89PLh6jWIGQESbv+Y8OCOTCkrg6F1cVzPU3yCyE+fb6nO5IztcHSMf80ydUMupvDdl6PjxVWZg249OYx9M1WZeOP6W785mJT4TGnfQOdNlvtg98ODbDLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCTHWjN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2FC4CED3;
	Tue, 28 Jan 2025 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738091826;
	bh=DfjTjfSy3oOvPON9YbjE3BrQNfka9zAP1UEfPpVzvmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCTHWjN8C2WVb1DU1nTmLUXs8bBOUbjE4FetYz+NFcrdK58owiLQvVUDi8lGQcaq5
	 zFfB+RGOlQdusTxWFt6p0dMzgbiuLpsdFAySKp/0QMK6hMv1Dj5/xYL0yeyY2Gy+Dt
	 HZRzKylG6GoutvGX5bUmS6e16pRDLCYEuA082Fysvluo8dqyj0JfSpZ7lcE4iWbD2F
	 wcjeqfqgdA6E7oIb2T7DCQZdNK3fcMwMsige0q4l1UH4hJbeDVFXGv7Iv4HS3APSIA
	 aj0VmxGTIDDSuPRsAZDQLfruzbjH3PGIGmCr0HudleuSAvUSBKqnfTL/tetpoWOQIl
	 BNbxAXjnBe1kg==
Date: Tue, 28 Jan 2025 11:17:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] generic/363: remove _supported_fs xfs
Message-ID: <20250128191706.GQ3557695@frogsfrogsfrogs>
References: <20250128071315.676272-1-hch@lst.de>
 <20250128071315.676272-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128071315.676272-2-hch@lst.de>

On Tue, Jan 28, 2025 at 08:12:58AM +0100, Christoph Hellwig wrote:
> Run this test for all file systems.  Just because they are broken doesn't
> mean that zeroing should not be tested.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Brian Foster <bfoster@redhat.com>

/me notes that this fails on btrfs, though it seems ext4 is ok.....

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/363 | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tests/generic/363 b/tests/generic/363
> index 477c111ccb60..74226a458427 100755
> --- a/tests/generic/363
> +++ b/tests/generic/363
> @@ -13,9 +13,6 @@ _begin_fstest rw auto
>  
>  _require_test
>  
> -# currently only xfs performs enough zeroing to satisfy fsx
> -_supported_fs xfs
> -
>  # on failure, replace -q with -d to see post-eof writes in the dump output
>  run_fsx "-q -S 0 -e 1 -N 100000"
>  
> -- 
> 2.45.2
> 
> 

