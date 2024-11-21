Return-Path: <linux-ext4+bounces-5289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E549D486C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 09:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD55B21C42
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670B1C9B8C;
	Thu, 21 Nov 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdc/vY1z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E4B1B3727;
	Thu, 21 Nov 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176061; cv=none; b=awze+0DG75QKogupEu7RYeROp02/gp/B7AYweVkLixsqj8w6HonXtz8Fak++tYpy6r/bovvUfdP9ltTA82Xt62XYYn/u2xIOWEwxVBwEg4tQx+tE6Kz7qYk0xCvIeYvy7lxoJtJP+Eha0gTNee0Tgjn0WerAn5h4zW/QH/tNyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176061; c=relaxed/simple;
	bh=rIzz8FbKU2TPtMlV2MBdmlmhRAwAySgidMeq07IMOGU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=T8Rqvaa675I6yiWh4FEBWAm/xKd34FpZ3638m/VUvgItkPD7jAr0G66i+lOCTYu263UIIwoetYxzyLXQMqvG4go8KXkgPO93fZhRC861HqDF/P1YGntTCtda5O0tdymutX1AL5Uws/8492cBmNcajjpLoCXKVup7wvoDHB09Xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdc/vY1z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea39638194so574910a91.2;
        Thu, 21 Nov 2024 00:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732176059; x=1732780859; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rp80vCnQlg63XAa5ls6wMXiws/r3Up6qJ6hz8K9MIvU=;
        b=Pdc/vY1zjHEeeDQqsKLt0WublFeJZStQaKRLyagKN2/iR5OfThl1CLct9sPthnzlbI
         CEOaLRCvFO47kuqG9umhZq/UaeeKk1Yj36QqaUtxiV/+Sa3Of050l46I/hq9B9gCLjwM
         L66eNvXVr+GQf5hS3eghoxXpwxMu/konMsZ0rhcVQble8+Y0lFZbETFvQASGGKL/HK2F
         whBOBdyUb4wuJPwBk/mXewXp2eOFfMgMzBwQyAi581fDlwJEdBA5sbUAv8ChQgI/BEQJ
         cIwPTeLGEi1WiprE+yj3Lzjt+8mLEq4t/HAAkBfxaBNFAICuMjwmHvCo+RNSy3sy6S98
         cloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176059; x=1732780859;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp80vCnQlg63XAa5ls6wMXiws/r3Up6qJ6hz8K9MIvU=;
        b=csdygtz5Ip/zqvfuN3CYleq+Gw3Eo+d58NUiwqDsbIRQkKLUXpjElSm7fGoPk5rJ/u
         h7mpta1jKq1D9VFHi+ngHlriReAhJ/9K1M3VajHZwDNCsSBSBBDfuqr9zWu3wrBm0IZJ
         LxTeLt+K6uVnjtwxktlSRM8FMcYDsWF1gF5zlmC54TurIxU1wj/lzh1zhd9zo9KlGhYL
         YvlbanJ52sFVj7GMafWCVXz5cHRBSFV3TduBsNuGXtLyiUNWgCm1ihuUQSXU3o52gvOY
         rCjPusz6IIDhtYMPEABx/i0Rj9/kWtrTbYzya6AGAquV7xoMfRhbMN0QqccI2fPqWWGi
         WvMg==
X-Forwarded-Encrypted: i=1; AJvYcCVaw0DUsb16hERLlfoxxCSPa0bgkj/F9P6dHLmYtGaJm7T0Ud6Td3UYYyLWhWCw7GwaU1JAuLL5@vger.kernel.org, AJvYcCWvYoXa44kCIKmuvjAzjhqvc9cELXt2RMi47BWX+IXzXFHcHgEgz3ZUMz0st1ue7mZ3V6T5oIpmXeKw@vger.kernel.org
X-Gm-Message-State: AOJu0YynTIpklDdWKXoWuRX6Dn/R6P6G+kBXUNAflFf/kZe6GcOPMQzE
	tKz5tqGOEHVV0XhElAGdmcLhCfCGlz30XJA0lFe34nR5d+2XJ76SZaDVgkad
X-Google-Smtp-Source: AGHT+IEhVIBfS0wfCrhWfMdCQkS5WiMlAWT3G/p0WLmpKeGVGIMU/65q+oBbwoUZ/nyJ/q21RdJCrQ==
X-Received: by 2002:a17:90b:48ca:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2eaca7ca917mr6956832a91.29.1732176058809;
        Thu, 21 Nov 2024 00:00:58 -0800 (PST)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212878bd8f9sm7732705ad.109.2024.11.21.00.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:00:58 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, nirjhar@linux.ibm.com
Subject: Re: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize helper function
In-Reply-To: <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
Date: Thu, 21 Nov 2024 13:23:45 +0530
Message-ID: <87plmp81km.fsf@gmail.com>
References: <cover.1732126365.git.nirjhar@linux.ibm.com> <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Nirjhar Roy <nirjhar@linux.ibm.com> writes:

> _require_scratch_extsize helper function will be used in the
> the next patch to make the test run only on filesystems with
> extsize support.
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> ---
>  common/rc | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index cccc98f5..995979e9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
>  	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>  }
>  
> +# This test requires extsize support on the  filesystem
> +_require_scratch_extsize()
> +{
> +	_require_scratch

_require_xfs_io_command "extsize"

^^^ Don't we need this too?

> +	_scratch_mkfs > /dev/null
> +	_scratch_mount
> +	local filename=$SCRATCH_MNT/$RANDOM
> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> +	local extsz=$(( blksz*2 ))
> +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
> +		-c "extsize")
> +	_scratch_unmount
> +	grep -q "\[$extsz\] $filename" <(echo $res) || \
> +		_notrun "this test requires extsize support on the filesystem"

Why grep when we can simply just check the return value of previous xfs_io command?

> +}
> +
> +

^^ Extra newline.

>  # Write a byte into a range of a file
>  _pwrite_byte() {
>  	local pattern="$1"
> -- 
> 2.43.5

