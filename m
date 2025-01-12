Return-Path: <linux-ext4+bounces-6046-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF9A0ABB1
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Jan 2025 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AEB165B40
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Jan 2025 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D91C1F15;
	Sun, 12 Jan 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAW3DkCd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA42CAB;
	Sun, 12 Jan 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736711281; cv=none; b=eTnX+u68wr6yx/xadrfZm9gscDdvvuY6uv3oRQ5KierIF7EQ0C4hmw6Dsi35VPELLzwUmgbX42W2NJ2TvvrTj8m8Rcu6SOTxqBsXUR2jNSe/q1l/qv1nKYT5pNC1xW6PB/spK8NTuctP4j6SVid93IUuk8InJA6Pm9n9+ZP+FvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736711281; c=relaxed/simple;
	bh=aUQFksT7SugV/H0FdFicU63wK0fuHZ0b42IYikLMGrE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=owbuVsGaIMf1O2NWKPd9yOMmdxtjMWVNUfCJeGkILSR70KI4AuYyUizbs2QOH9KL8UQGNVeL/YFXj8Nb8W3Zgb5RUcIk4L+P6bjApXVDBTCWPUmdR8jEsfo7ncXKEjc/D/agsVgVxF4Qh4rAVQV1T6GZ++GQsbg+MpBASSCrpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAW3DkCd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so57091335ad.0;
        Sun, 12 Jan 2025 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736711279; x=1737316079; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e0zq4j8AZK04xz38pt4eI3IFrNwO5oCsXkbchpKMzho=;
        b=FAW3DkCdKedYSujd1A4IC2s61Zfv2Y6WDLIKNZgVDSZ7OLiRv5yBxvleuCpHv3M6Fq
         lfcRpLUCb95VThmBIYFK5iFD+xoqrt7BdacEUJDjE0+nNA5SiaCjVWMdxUz4vnlDD0Ev
         ztU36zXGcJLtYhPMr2xefcoYoauYzU2exLI+mSP+2uug3FZ2ob3LuHX9Pg1P5E/O3gHj
         hmaqDI7JMyv5CfeN9/2UWgE7qI4fTKU4H/PVg60Sn8cwia4xycwbTiC2X86R5NKjwNMm
         hl2X3+4ABLsS88KfzieYkECwvpf4LEAQ1J/uFGIjs4H2sJlTOiELrein7KD4zhOSFyz/
         6Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736711279; x=1737316079;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0zq4j8AZK04xz38pt4eI3IFrNwO5oCsXkbchpKMzho=;
        b=W7oHeMToQZij9aI+73MOXnRlXSMkOwTtZBLozosZbcTmnzYJgAuQduAXtWmr90J2B5
         DxD6rCc0jWLrFby9gVcOaGJLG9YqJ/U5zeTx3Q1h0XEnohhbeSvcl75IjtqpOEJncHFW
         C7N1XkEUlwtnp3LXTK59U1/9Rn6gbsgaBrLSpGYXjXI2OrhIQnlDMxDukIEa3vbuUg6j
         lvWJOJcSu370jbF8zrWsBA1vOYfaWZ2AV/Pn+qMt1/o//PXAKO9y4/zq0kcrxYPWxcPt
         fVWzRYjjfqPeeca2YXlM5LGmHSRaBy5732JBIiNPO+5lzjTJABmBStSqRx9lUF1KI/Sv
         g45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI3G1mCaAQRALMvsu43UhQsU9f/vihf080nxycYxSqDuVVXIv8RGqV+gc5d72ejDU0+IeHpkmz@vger.kernel.org, AJvYcCWrs0z1B1k7Xp68LKjSxFsT2/OCHxuyqVMfloU1ug9L/txbua/tDUQUWKZ3fVCGoSRWbkM2Bie4BdIM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OCNn8qozz/HBjEHV/iEiJOOO8oMjoOr6eqFh9BdcteRo4dsd
	5al+yFmDuPvY3vrjNz3xqNAWpScb/U6zvJ4Sg4clT3rYNkRoGp0k
X-Gm-Gg: ASbGncvWeZqYVYFhznxiSy+yMKFBBAMhHntGp2Uzo3rQLXqzFNkMWZ3JFs/r0p1g9fM
	FyHjeXYXWLyHN50STKhH4xikaQKqMkxFX+keXOyoseMtl7Obi5+AoryXpyW/cvL2+TEQizUQxQe
	14dXsHkJrRsiA641NlG4Rrn1/mIYQFN1uk2dReTizLHi+7cpLKl2LyZCjcMQ4p0DybKh3/r29eK
	9UKHojzCPWylYbhdX8VyGWnVdIMnNfBW/UHBjLruZMziUZx
X-Google-Smtp-Source: AGHT+IG/UFr+MKl0GMussw8Ee7UX5NBbLECYJCbyEFMpeidItwV1LeNov0LPn1GKL4LuZI64m2iLCQ==
X-Received: by 2002:a05:6a21:6da0:b0:1e8:becc:5771 with SMTP id adf61e73a8af0-1e8becc5859mr12780997637.30.1736711279419;
        Sun, 12 Jan 2025 11:47:59 -0800 (PST)
Received: from dw-tp ([171.76.81.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658bb4sm4604671b3a.86.2025.01.12.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 11:47:58 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
In-Reply-To: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
Date: Mon, 13 Jan 2025 01:11:22 +0530
Message-ID: <87jzazvmzh.fsf@gmail.com>
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> Bug Description:
>
> _test_mount function is failing with the following error:
> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
> check: failed to mount /dev/loop0 on /mnt1/test
>
> when the second section in local.config file is xfs and the first section
> is non-xfs.
>
> It can be easily reproduced with the following local.config file
>
> [s2]
> export FSTYP=ext4
> export TEST_DEV=/dev/loop0
> export TEST_DIR=/mnt1/test
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=/mnt1/scratch
>
> [s1]
> export FSTYP=xfs
> export TEST_DEV=/dev/loop0
> export TEST_DIR=/mnt1/test
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=/mnt1/scratch
>
> ./check selftest/001
>
> Root cause:
> When _test_mount() is executed for the second section, the FSTYPE has
> already changed but the new fs specific common/$FSTYP has not yet
> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
> the test run fails.
>
> Fix:
> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>

You should add the Fixes: tag too. Based on your description I guess
this should be the tag?

Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")

I agree with today the problem was in _test_mount(), tomorrow it could
be _test_mkfs, hence we could source the new FSTYP config file before
calling _test_mkfs().

With the fixes tag added, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/check b/check
> index 607d2456..8cdbb68f 100755
> --- a/check
> +++ b/check
> @@ -776,6 +776,7 @@ function run_section()
>  	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>  		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>  		_test_unmount 2> /dev/null
> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
>  		if ! _test_mkfs >$tmp.err 2>&1
>  		then
>  			echo "our local _test_mkfs routine ..."
> -- 
> 2.34.1

