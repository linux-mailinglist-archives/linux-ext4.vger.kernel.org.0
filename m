Return-Path: <linux-ext4+bounces-8336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F433AD2396
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E216C6CD
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD13219A89;
	Mon,  9 Jun 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyFTXEtS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46620C480;
	Mon,  9 Jun 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485921; cv=none; b=W9Tq8ASGuKpS7InMItJwav2390XPZoxOLI8QwgF4Ci4c+ECJkyeZP68Na/ZNs1yb/LEOyZ50gzZj7V2QNJ4tuCmq+ZEqGVg1iJfBVn6WiFBsPIKe2R1RtR0MONeRXh4/098IUXKvL5AaaDtXmaLAYTrPAL5ZGIhT7XF/VnykHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485921; c=relaxed/simple;
	bh=I08VS2sCuxaPZ61wFIVmhy2F970WAmigVwS39xU192Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccBUF2FPcADjQYJl+wSyT1oc3LygnIBmAOewU3j/wW0I1uQw1oWMXyx2OVMEYnFdadCNH1zoM/TTRFGyQKLgrrpH+Oj7Vsvwg9Kh8G3aWH0fuTAlmRo5yZsj6b0RsvIwE6ZAWYxLxmY6E2S0YVIJRcNCa1yny3y0VuOkIjGA2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyFTXEtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33357C4CEEB;
	Mon,  9 Jun 2025 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485921;
	bh=I08VS2sCuxaPZ61wFIVmhy2F970WAmigVwS39xU192Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyFTXEtSYPSUhf3jFHAR58zVA/Gxi1UHvTbX68zisFVNIHFwyCOcNIAilfeKoLV4c
	 HwYKLDoVD0ov2Vvt+EsFYQ/jnOh8+JC2E58dJ7H1AWnpJ6OI7ubkJ/BybmIJ55NTdG
	 2cKE/wY9joo1+Bt+7Q8QaWah4gBpIrWSmB8EEx5V/yvPaTuIDlccIFhZGt+cIn29Vw
	 ORAPmdfiG9tfWsaR3+bPRXXQzFr30fyjfGGBpAriU0J69ijWqqSF9pQUp8GFClVgc3
	 icok9QP3M9Y5B6qoloJ0IydX1n07iaw11A9YHggjWK6du9DIMNASKdDXxxZ469ELmG
	 B5rpVOC0aDgWA==
Date: Mon, 9 Jun 2025 09:18:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@kernel.org>, hch <hch@lst.de>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] xfs: add mount test for read only rt devices
Message-ID: <20250609161840.GG6156@frogsfrogsfrogs>
References: <20250609110307.17455-1-hans.holmberg@wdc.com>
 <20250609110307.17455-2-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609110307.17455-2-hans.holmberg@wdc.com>

On Mon, Jun 09, 2025 at 11:03:53AM +0000, Hans Holmberg wrote:
> Make sure that we can mount rt devices read-only if them themselves
> are marked as read-only.
> 
> Also make sure that rw re-mounts are not allowed if the device is
> marked as read-only.
> 
> Based on generic/050.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/837     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/837.out | 10 ++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tests/xfs/837
>  create mode 100644 tests/xfs/837.out
> 
> diff --git a/tests/xfs/837 b/tests/xfs/837
> new file mode 100755
> index 000000000000..61e51d3a7d0e
> --- /dev/null
> +++ b/tests/xfs/837
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2009 Christoph Hellwig.
> +# Copyright (c) 2025 Western Digital Corporation
> +#
> +# FS QA Test No. 837
> +#
> +# Check out various mount/remount/unmount scenarious on a read-only rtdev
> +# Based on generic/050
> +#
> +. ./common/preamble
> +_begin_fstest mount auto quick
> +
> +_cleanup_setrw()
> +{
> +	cd /
> +	blockdev --setrw $SCRATCH_RTDEV
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_fixed_by_kernel_commit bfecc4091e07 \
> +	"xfs: allow ro mounts if rtdev or logdev are read-only"
> +
> +_require_realtime
> +_require_scratch
> +
> +if [ -z "$SCRATCH_RTDEV" ]; then
> +	_notrun "requires external scratch rt device"
> +else
> +	_require_local_device $SCRATCH_RTDEV
> +fi
> +
> +_register_cleanup "_cleanup_setrw"
> +
> +_scratch_mkfs "-d rtinherit" > /dev/null 2>&1
> +
> +#
> +# Mark the rt device read-only.
> +#
> +echo "setting device read-only"
> +blockdev --setro $SCRATCH_RTDEV
> +
> +#
> +# Mount it and make sure it can't be written to.
> +#
> +echo "mounting read-only rt block device:"
> +_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
> +if [ "${PIPESTATUS[0]}" -eq 0 ]; then
> +	echo "writing to file on read-only filesystem:"
> +	dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 oflag=direct 2>&1 | _filter_scratch
> +else
> +	_fail "failed to mount"
> +fi
> +
> +echo "remounting read-write:"
> +_scratch_remount rw 2>&1 | _filter_scratch | _filter_ro_mount
> +
> +echo "unmounting read-only filesystem"
> +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> +
> +# success, all done
> +echo "*** done"
> +status=0
> diff --git a/tests/xfs/837.out b/tests/xfs/837.out
> new file mode 100644
> index 000000000000..0a843a0ba398
> --- /dev/null
> +++ b/tests/xfs/837.out
> @@ -0,0 +1,10 @@
> +QA output created by 837
> +setting device read-only
> +mounting read-only rt block device:
> +mount: device write-protected, mounting read-only
> +writing to file on read-only filesystem:
> +dd: failed to open 'SCRATCH_MNT/foo': Read-only file system
> +remounting read-write:
> +mount: cannot remount device read-write, is write-protected
> +unmounting read-only filesystem
> +*** done
> -- 
> 2.34.1
> 

