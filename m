Return-Path: <linux-ext4+bounces-12337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD69CB9B8D
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A0D6300857B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A965309F01;
	Fri, 12 Dec 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZG4Nr61"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6F27B34D;
	Fri, 12 Dec 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569769; cv=none; b=tWiUc9xocefaBgf5mDQDxTYpTiAmiwO0Z5m6B3EMq7MX7FJYQL2VmATHgZHbN7vVGMGOwUX47dG1Pm5fVEEW27X32BRbHwQ6ZKO2p/vPNKVuzul/s3tqhMANoi3WXCL0g3BeWoVhjX9Zff7nrTUIDzAtBq32ZRzM1qIZu0Oxy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569769; c=relaxed/simple;
	bh=E2SrUWciw4QRNY8reyJE57n71cfqDtlvoy2sdI9Fw+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MULZS2dZSdV7cct6Sr4q2D35dJTKVmVxdB9EaOQqf+Gh+S9unV5V/KLQWDHIZ/yxRfYWY6Tr6CxY40+W34IbCKppCYh7jx56tQS4RsHK4b4TQFo0NuZIPjJesXYSGPf+PewsEIQTvUfVVKAqU9FuVVALWj7C7WJ0vyvAvFRbNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZG4Nr61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C4C4CEF1;
	Fri, 12 Dec 2025 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765569767;
	bh=E2SrUWciw4QRNY8reyJE57n71cfqDtlvoy2sdI9Fw+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZG4Nr61/WxRQeciEHPGOSHb0CBTt87M9b5wX7LOl22e4cYXZsxSCegLZf17EhuCP
	 Qi553UGqLFByqiKdSpkqz6BrFTwZOkyfevUwptsAjLyJqDn7PDHMvsSI0p6D9Ex+Nu
	 Zu0mwRldY5JAkKcF/J5w1iuRmGngVtpyZkblk9qkwQXVh992it8adYUL7pZW8gVVvp
	 baVqbkPPWpavTrVEGkZ8cnFfd49quZchZzoU8b1eaEEEK0dV6YPALY2wvYAjeufvUK
	 Rz3uTDyixyOU6/mj97QxDNdK6CNttX8Rc3CKn8DTkHBDH12enx/uTAuqjeJYGGfWRc
	 fxawLN50E9JOQ==
Date: Fri, 12 Dec 2025 12:02:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] ext4/006: call e2fsck directly
Message-ID: <20251212200246.GE7716@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212082210.23401-3-hch@lst.de>

On Fri, Dec 12, 2025 at 09:21:50AM +0100, Christoph Hellwig wrote:
> _check_scratch_fs takes an optional device name, but no optional
> arguments.  Call e2fsck directly for this extN-specific test instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/ext4/006 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 2ece22a4bd1e..ab78e79d272d 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -44,7 +44,7 @@ repair_scratch() {
>  	res=$?
>  	if [ "${res}" -eq 0 ]; then
>  		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> +		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1

Minor nit: $E2FSCK_PROG, not e2fsck.

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		res=$?
>  	fi
>  	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"
> -- 
> 2.47.3
> 
> 

