Return-Path: <linux-ext4+bounces-12391-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C30ECC8FC7
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A0D63085B30
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82B217705;
	Wed, 17 Dec 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoqR9O3w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0DF221DAE
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990977; cv=none; b=OL/cd67N6g0ZM3dYIuHcd6J3FXgnfBi/ClkLt+Wdjavje/vU1iAmUiUJz6g1ttuJCWxKXA5GYSWnL/0Fw6tTkTTIRp7ymDr2MH4wiVnOEz0RIAjAL0wpRiEU1HCkiSnhjU4f3DAT7c0Dn5uLw/7NiiCAp2p1hVXlHQgqW6rnI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990977; c=relaxed/simple;
	bh=uHy78ltZLfP3vZAy+9dakrgZD+WHxMypGgmYocIc10A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpHHKuxRUirYFMcEaEub93Aaa9oO9c9unmSz+9L7SYuH5Lz26lqnqKGLJbmY5NBCbKQ3H+HpILuq7BNUbp3iOmeXLzMLjLlf0mUH+rtxulDqudgxOVjLOWKUAvDZusXKq90wCnaZBGOq8TwqvFbSkXArz8JmzE2oDI1aG4a3grg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoqR9O3w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7e2762ad850so6343551b3a.3
        for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990974; x=1766595774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmZkpXUu+2c71qcVZUC1Y31FhXycQNoQwCBPVwFSGN8=;
        b=GoqR9O3wWXj5Dz3yzzuMMNkSKjdlbLUOWdO+SWix0RqYTmr2XFoiPNG2JAnZINwIyz
         2qe0w8Wipk9kdF6LIqEVv7wyvLPRA/mYVtY3WEd/N/1QEVlmROKaNGh8QFJt2LHfxbVH
         AI5BCFeBRVNWV9dkEqDyxkGkG4S14zKvgYhW+Dvc7MoAn13IgaIRUX2fkg53aRuxSvJD
         kvzcsTERDenan7/GI8TbV12oDj/PYJKwBNO5TukNZKs6x2Os8rdT2oDziL7X33RLM67t
         697EEkTswuF//TTJi6lvXFur0YIyU1fl5GaHTlX0NJ86MtMt74/orp3CSoZmKv3H7gWW
         Vjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990974; x=1766595774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmZkpXUu+2c71qcVZUC1Y31FhXycQNoQwCBPVwFSGN8=;
        b=NLnhaW8mBgJWIzNVpxWWGQVn89g2JCQ7Fqq6kcPrTcma0LS6UEmJEbx90HHkph3KLE
         wFZ8prnXpO6l1Tfz5Sy1uPVFLLbBud+X2oPtQjS/B6RI8V5uAVLAZNiTv6Z6tYAuy2QK
         O2DJR7MK1AQFGEql/DBcqdbAHqBQie7TRTTQqNag1cNUsvrGQXemxCRW1EwTdOREfu76
         WuyaJqrwfmKJqTOBw8cn2ka4/AB+uMZzb1z3pvRGtXaegpbLNiNNJ4BR+VNDx7qK/hui
         eIZZjbyAyjxogSHOdlJNRP8XCkk/ijpe2eJrxcZiaPrfzAxuk6TANWmktBgMJDUHlySb
         C46g==
X-Forwarded-Encrypted: i=1; AJvYcCX3FGKZG1cOETfm96Z49ITwf+eE3AyHpE0HelEdhFrBNwOk7Z78MpeYfQqnZt9p7Yajyc0ABOBo5fe/@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYortrt3gKfLwHdnnFiv+6eJEayj8SehXH8OxbR7bGDhgdM8I
	Ga4KEdWRLAcfMxwt8bIlfjZV/tnpp191EWeu1PzeftnbfDMp6lhgIiU5
X-Gm-Gg: AY/fxX7lJ6otZlIEXcjuS0XlCDGykzLyGAU9AFsME1Ina932Tqs/WwaYOSCUBWqlwh2
	j+ylJqZgpD3hJNRpaEr9TO7WmOc555/wCropXbKrKb22fbb4gfvIl/IRDJomOxfoCf/ZlBsUlFA
	MTTRR12P7tkfuq4T9Pu8Ds9L+d9NJv5Jn1p+OXF88w10ySwlnSoC79I6ZcUUHqrOW0oXLyy9tOL
	ysirv6elXK3pbgd3QkH4/AC3B9M+Jrn2Do/AM5AjOyFgrAC8uUlEGwLbg1Cooe8uWPV1VABKWbM
	6KrckKE70rb2iL+eviJMfJ7J3/bYSixWa13yOeQW+IFEev7IpWSpSOfc7Ok3BUtO0QKd4zuw/0V
	+YE+MRNzIJSfMqSATitG71c0Vd9dJbTPsgCpekEsxygik1qtzABmm44Ixs8tpv5d17hjkM/W/aj
	XD8dqrdVMqvaFfDwY=
X-Google-Smtp-Source: AGHT+IES/QvdT35sIutV+Y6xroJ/V0XHB5MqKJMJkgKmO10jTRb2RdKRWgYqZwpFGOURoKjxaE9EUA==
X-Received: by 2002:a05:6a21:3383:b0:341:d537:f8bf with SMTP id adf61e73a8af0-369afc0038amr16517748637.38.1765990974164;
        Wed, 17 Dec 2025 09:02:54 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd9aaaf2csm1933817a91.5.2025.12.17.09.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:02:53 -0800 (PST)
Message-ID: <0556e82c-600d-4324-8cf0-6d11613d57cc@gmail.com>
Date: Thu, 18 Dec 2025 01:02:51 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] generic/590: split XFS RT specific bits out
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-6-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Looks good
Reviewed-by: Anand Jain <asj@kernel.org>

Thanks


On 12/12/25 16:21, Christoph Hellwig wrote:
> Currently generic/590 runs a very different test on XFS that creates
> a lot device and so on.  Split that out into a new XFS-specific test,
> and let generic/590 always run using the file system parameter specified
> in the config even for XFS.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>   tests/generic/590 |  68 ++-------------------------
>   tests/xfs/650     | 117 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/xfs/650.out |   2 +
>   3 files changed, 123 insertions(+), 64 deletions(-)
>   create mode 100755 tests/xfs/650
>   create mode 100644 tests/xfs/650.out
> 
> diff --git a/tests/generic/590 b/tests/generic/590
> index ba1337a856f1..54c26f2ae5ed 100755
> --- a/tests/generic/590
> +++ b/tests/generic/590
> @@ -4,27 +4,15 @@
>   #
>   # FS QA Test 590
>   #
> -# Test commit 0c4da70c83d4 ("xfs: fix realtime file data space leak") and
> -# 69ffe5960df1 ("xfs: don't check for AG deadlock for realtime files in
> -# bunmapi"). On XFS without the fixes, truncate will hang forever. On other
> -# filesystems, this just tests writing into big fallocates.
> +# Tests writing into big fallocates.
> +#
> +# Based on an XFS RT subvolume specific test now split into xfs/650.
>   #
>   . ./common/preamble
>   _begin_fstest auto prealloc preallocrw
>   
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	_scratch_unmount &>/dev/null
> -	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
> -	cd /
> -	rm -f $tmp.*
> -	rm -f "$TEST_DIR/$seq"
> -}
> -
>   . ./common/filter
>   
> -_require_scratch_nocheck
>   _require_xfs_io_command "falloc"
>   
>   maxextlen=$((0x1fffff))
> @@ -32,54 +20,7 @@ bs=4096
>   rextsize=4
>   filesz=$(((maxextlen + 1) * bs))
>   
> -must_disable_feature() {
> -	local feat="$1"
> -
> -	# If mkfs doesn't know about the feature, we don't need to disable it
> -	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
> -
> -	# If turning the feature on works, we don't need to disable it
> -	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
> -		> /dev/null 2>&1 && return 1
> -
> -	# Otherwise mkfs knows of the feature and formatting with it failed,
> -	# so we do need to mask it.
> -	return 0
> -}
> -
> -extra_options=""
> -# If we're testing XFS, set up the realtime device to reproduce the bug.
> -if [[ $FSTYP = xfs ]]; then
> -	# If we don't have a realtime device, set up a loop device on the test
> -	# filesystem.
> -	if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
> -		_require_test
> -		loopsz="$((filesz + (1 << 26)))"
> -		_require_fs_space "$TEST_DIR" $((loopsz / 1024))
> -		$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
> -		loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
> -		USE_EXTERNAL=yes
> -		SCRATCH_RTDEV="$loop_dev"
> -		disabled_features=()
> -
> -		# disable reflink if not supported by realtime devices
> -		must_disable_feature reflink &&
> -			disabled_features=(-m reflink=0)
> -
> -		# disable rmap if not supported by realtime devices
> -		must_disable_feature rmapbt &&
> -			disabled_features+=(-m rmapbt=0)
> -	fi
> -	extra_options="$extra_options -r extsize=$((bs * rextsize))"
> -	extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
> -
> -	_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
> -	_try_scratch_mount >>$seqres.full 2>&1 || \
> -		_notrun "mount failed, kernel doesn't support realtime?"
> -	_scratch_unmount
> -else
> -	_scratch_mkfs $extra_options >>$seqres.full 2>&1
> -fi
> +_scratch_mkfs >>$seqres.full 2>&1
>   _scratch_mount
>   _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
>   
> @@ -112,7 +53,6 @@ $XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
>   # Truncate the extents.
>   $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
>   
> -# We need to do this before the loop device gets torn down.
>   _scratch_unmount
>   _check_scratch_fs
>   
> diff --git a/tests/xfs/650 b/tests/xfs/650
> new file mode 100755
> index 000000000000..d8f70539665f
> --- /dev/null
> +++ b/tests/xfs/650
> @@ -0,0 +1,117 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 650
> +#
> +# Test commit 0c4da70c83d4 ("xfs: fix realtime file data space leak") and
> +# 69ffe5960df1 ("xfs: don't check for AG deadlock for realtime files in
> +# bunmapi"). On XFS without the fixes, truncate will hang forever.
> +#
> +. ./common/preamble
> +_begin_fstest auto prealloc preallocrw
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_scratch_unmount &>/dev/null
> +	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
> +	cd /
> +	rm -f $tmp.*
> +	rm -f "$TEST_DIR/$seq"
> +}
> +
> +. ./common/filter
> +
> +_require_scratch_nocheck
> +_require_xfs_io_command "falloc"
> +
> +maxextlen=$((0x1fffff))
> +bs=4096
> +rextsize=4
> +filesz=$(((maxextlen + 1) * bs))
> +
> +must_disable_feature() {
> +	local feat="$1"
> +
> +	# If mkfs doesn't know about the feature, we don't need to disable it
> +	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
> +
> +	# If turning the feature on works, we don't need to disable it
> +	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
> +		> /dev/null 2>&1 && return 1
> +
> +	# Otherwise mkfs knows of the feature and formatting with it failed,
> +	# so we do need to mask it.
> +	return 0
> +}
> +
> +extra_options=""
> +# Set up the realtime device to reproduce the bug.
> +
> +# If we don't have a realtime device, set up a loop device on the test
> +# filesystem.
> +if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
> +	_require_test
> +	loopsz="$((filesz + (1 << 26)))"
> +	_require_fs_space "$TEST_DIR" $((loopsz / 1024))
> +	$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
> +	loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
> +	USE_EXTERNAL=yes
> +	SCRATCH_RTDEV="$loop_dev"
> +	disabled_features=()
> +
> +	# disable reflink if not supported by realtime devices
> +	must_disable_feature reflink &&
> +		disabled_features=(-m reflink=0)
> +
> +	# disable rmap if not supported by realtime devices
> +	must_disable_feature rmapbt &&
> +		disabled_features+=(-m rmapbt=0)
> +fi
> +extra_options="$extra_options -r extsize=$((bs * rextsize))"
> +extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
> +
> +_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
> +_try_scratch_mount >>$seqres.full 2>&1 || \
> +	_notrun "mount failed, kernel doesn't support realtime?"
> +_scratch_unmount
> +_scratch_mount
> +_require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
> +
> +# Allocate maxextlen + 1 blocks. As long as the allocator does something sane,
> +# we should end up with two extents that look something like:
> +#
> +# u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
> +# 0:[0,0,2097148,1]
> +# 1:[2097148,2097148,4,1]
> +#
> +# Extent 0 has blockcount = ALIGN_DOWN(maxextlen, rextsize). Extent 1 is
> +# adjacent and has blockcount = rextsize. Both are unwritten.
> +$XFS_IO_PROG -c "falloc 0 $filesz" -c fsync -f "$SCRATCH_MNT/file"
> +
> +# Write extent 0 + one block of extent 1. Our extents should end up like so:
> +#
> +# u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
> +# 0:[0,0,2097149,0]
> +# 1:[2097149,2097149,3,1]
> +#
> +# Extent 0 is written and has blockcount = ALIGN_DOWN(maxextlen, rextsize) + 1,
> +# Extent 1 is adjacent, unwritten, and has blockcount = rextsize - 1 and
> +# startblock % rextsize = 1.
> +#
> +# The -b is just to speed things up (doing GBs of I/O in 4k chunks kind of
> +# sucks).
> +$XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
> +	"$SCRATCH_MNT/file" >> "$seqres.full"
> +
> +# Truncate the extents.
> +$XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
> +
> +# We need to do this before the loop device gets torn down.
> +_scratch_unmount
> +_check_scratch_fs
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/650.out b/tests/xfs/650.out
> new file mode 100644
> index 000000000000..d7a3e4b63483
> --- /dev/null
> +++ b/tests/xfs/650.out
> @@ -0,0 +1,2 @@
> +QA output created by 650
> +Silence is golden


