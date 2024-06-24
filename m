Return-Path: <linux-ext4+bounces-2935-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7491533F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174122854C0
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 16:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64319D8BB;
	Mon, 24 Jun 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eos5qtAJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EB1EA87;
	Mon, 24 Jun 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245766; cv=none; b=gliLmzqjqSBI8DoSxRnSNhmKv+z34E75uGm/rHzhRg54Nln6Y0F7cOmTnCxE3DGundtlWV8ELwiRvgfwgygLcC03BuY96m/mRAEg36LrIawL0M6cC+FykbtZQuxeQqwSrU+A0S9KyjSF8pICTEgT2IMInc1K3B3sbwpGbV4SBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245766; c=relaxed/simple;
	bh=oGTVNmWTNtEXSLwV8sXYrvhDQ6RyP26mE26HUqC56l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPBDXtnrA/UeZ8kKkYsmbRy740kYQ/YK9lTc1ktEYLAZ0/ihbCCNxxE/ditgDd6SFd7hHqUCOliQUDyhgTDlxHRw3Nt8mPQiHJ++gyhogMc6SLy+bdeJm2AGv2I29jlQFUaN4HWRgpYjnkfTKVW9SPTsVhqT/9939fuY8Jz6ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eos5qtAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2616BC2BBFC;
	Mon, 24 Jun 2024 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719245766;
	bh=oGTVNmWTNtEXSLwV8sXYrvhDQ6RyP26mE26HUqC56l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eos5qtAJjMx2W5Hg2cojrfXWoZnmGIJVLywxi4+GWQRaoAzxusHutapQh9e5emuHf
	 BpYW4uSWuwylmdHTTiAfk4E7qZMTP5s3YPhOxeRfnXVviSBpyyXmqMzjm6iWpBRM4E
	 DPUWYQG4/PDMkhQcmVvKsWdCpgw4pVGF8RiXipRzpbORYv8v7CWHJe1YhlAVTHQ9JU
	 vOwxyIFeMEIDsl/QQX1kl9HiVXzdm+tmdSJxr1i5N4XoWmVZm6IsRFLIU479fVXv10
	 mTjfaN2WCwTuxIhFXhHOL8T5hJrJ9e9ALbMC2kFJVzE0zXDoTdOb5u0FHVQzpL+U/C
	 4/QY0U8B7o9nw==
Date: Mon, 24 Jun 2024 09:16:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/740: enable by default
Message-ID: <20240624161605.GF103020@frogsfrogsfrogs>
References: <20240623121103.974270-1-hch@lst.de>
 <20240623121103.974270-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623121103.974270-6-hch@lst.de>

On Sun, Jun 23, 2024 at 02:10:34PM +0200, Christoph Hellwig wrote:
> Instead of limiting this test to a few file systems, opt out the
> file systems supported in common/rc that don't support overwrite
> checking at all, and those like extN that support it, but only when
> run interactively.

If script(1) is installed, can we use it to run mkfs.extX in a sub-pty?

Or is that not worth the trouble?

(This is really more of a question for Ted...)

--D

> Also remove support for really old mkfs.btrfs versions that lack
> the overwrite check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/740 | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/generic/740 b/tests/generic/740
> index bac927227..903e891db 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -12,19 +12,16 @@ _begin_fstest mkfs auto quick
>  # Import common functions.
>  . ./common/filter
>  
> -# real QA test starts here
> -_supported_fs xfs btrfs
> +# a bunch of file systems don't support foreign fs detection
> +# ext* do support it, but disable the feature when called non-interactively
> +_supported_fs ^ext2 ^ext3 ^ext4 ^jfs ^ocfs2 ^udf
>  
> -_require_scratch_nocheck
> -_require_no_large_scratch_dev
> +_require_block_device "${SCRATCH_DEV}"
>  # not all the FS support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  
> -# mkfs.btrfs did not have overwrite detection at first
> -if [ "$FSTYP" == "btrfs" ]; then
> -	grep -q 'force overwrite' `echo $MKFS_BTRFS_PROG | awk '{print $1}'` || \
> -		_notrun "Installed mkfs.btrfs does not support -f option"
> -fi
> +_require_scratch_nocheck
> +_require_no_large_scratch_dev
>  
>  echo "Silence is golden."
>  for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
> -- 
> 2.43.0
> 
> 

