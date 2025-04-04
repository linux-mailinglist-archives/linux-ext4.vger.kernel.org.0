Return-Path: <linux-ext4+bounces-7075-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630FBA7B704
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 07:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07F01896D50
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 05:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D3E14A09C;
	Fri,  4 Apr 2025 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUx+Idcb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC22E62B2;
	Fri,  4 Apr 2025 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743085; cv=none; b=Zm4TgF8L4dKy9o077bBz+nIoGc/hGJbI6CJVjmml4etLLHq9HeyaX9HKqNTF9fUN7kpJVWeF0iQDTojtiVD1RDAmvLyc2YX8PDiRje4XFVu43xcOVHOnMRQE01Z4TpJb1xYUTU8kzsgdnQKc4qugh61XzipY9Pw1ioiSFrUAXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743085; c=relaxed/simple;
	bh=0WCwqHOCH8AhxxzL1Htg8MbdFk0LBTBk7sDYAfvnDvY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jBqkKp/YXGCgyrTHTjFmvtw+SSV4Gkfo5zt8PxVLDUnlhSaKFKiwrILh1uwcDhTXENtRBrIvfRg7N2NrGS2eqmB6nOtnOVIe+KupFa+OuZzYfbTyvGiWW9Y2lW/8J9dRi8A+OsYooq50bRVpxD2qx6Zgk0y17GK2w9VXz8s+FuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUx+Idcb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22580c9ee0aso19208395ad.2;
        Thu, 03 Apr 2025 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743743083; x=1744347883; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ys34Rctit4lSM2OLO6pPdUrNIvl8DddVLt2M8jRWbo8=;
        b=BUx+Idcb0ygs38ExDttDuw/IJPCK+MdsDswBZUcVoQ3p/DKTsZ7eMnbfoUhyVK+gSe
         ntDDmSwAvF0X0WxKfkRhODDeUWhqz4BdgjI41gkJ++j1VPeFf3S9oLGwOBVwPtPQCPAI
         YmPkel1ALzqLZK4ySEV/kLF5gFxKSBaHTJ93Qj39+Hh/8C2hrzu/1gD4V0EZwNk5Dro6
         ekT8rKmtfxsjR5XQko5dYGESW0okIzG/6Vqw2OOL5r6eIhrBzWO/u9wK3PM+bfkuR86Q
         rOnJxTWYmTCHT+TSPjEgl1o5i6KevpwA5mtgFb2VVxnZJyi36lHQPXqTWTgr/2V6L8wo
         ibuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743743083; x=1744347883;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys34Rctit4lSM2OLO6pPdUrNIvl8DddVLt2M8jRWbo8=;
        b=N4gQbHbJq9F2Tt9He+yvDKc7ya1YSiiFrXXmcVVwW+rQrJGeReQscjPkgT+3gHLwr8
         98cHhLYAIvCNuWX0HWZEIHKae+HkPmZLueQRxMp/IqiVkK1md1U2DNNf46O0rtIrWCfd
         L2PBFvLXOmi7oe4YOrZtr7vI7W3npBfaWbYE6nTsG00IsiwzR6eBOBmttW3QqszEbkgs
         NDsGqzRxf3cGzZbXLh0c8NHrn5crNixjH7smtUgsm3RROdupksYeMDXOfJRh/ASelx7s
         /ZzFyzZeD1S7XT7GtP3Cc0DDVvrA5PO/E6jYigqTyt09Hl+N2GsiN+QctS9jgdOVh84/
         ya8g==
X-Forwarded-Encrypted: i=1; AJvYcCUryZNUjfMi2sbSyG7c1xJvLkzCF4AepkYk4AzD8v1VCApljf+Q21G1bLgmnntnrRk0eEmPqwcjW8Zy@vger.kernel.org, AJvYcCWTDkxhc03G8xMCwpJZCEfXVPaDpDgo9xirhv2l7+b9kz5CjbbXsehIFrp8ttDJkvhS9rf0gedc@vger.kernel.org
X-Gm-Message-State: AOJu0YypleKLSsuy9g7zoKHHFfACOYBvNseERQBpmEdAgqAwjKDEK6K6
	mZR5m/xlQWv1T2eGyFeYbyVAzIZfCyVP+lD7wRi2IJ+1IgTNSB7Xq6gYlADX
X-Gm-Gg: ASbGncvfDfB6IwUoJb1Bz3mJWFdsjAQ+2ELc461wmYDJeNbECrneRpOQ1lDQGtxN96D
	d5tlaQ8EU2SASdaxA8/3HDgrmvZvhaylxmkxR00jTilNSMR64eEKY3LaCk6L47zAEqs5xvwSrej
	yat3dhytDFAlJf/8qlXMgSR78jSA4Xf0sChhW5gVrSWWC2eDTS9xbkQKkq0QAptJZ4jO8waGKuL
	q0T9kLE0HS0UEjjMs813/zeKxnSXI8sTZ5S44+ADKykCQVFc73zNWWhnkBU5sqIXJhIhxh7hSRu
	e4PHzRaQgx0fRmBBUmRRHXTD/d5JqV/080i7
X-Google-Smtp-Source: AGHT+IEeoLmp6XVA1YDLkarGNQ8TwsKaxLLvF+i8isJRogSj38zFXBzxS01S/zijEYQjx7g2ZS+80w==
X-Received: by 2002:a17:903:285:b0:220:e392:c73 with SMTP id d9443c01a7336-22a8a867e79mr24955535ad.22.1743743083390;
        Thu, 03 Apr 2025 22:04:43 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e4b7sm23567185ad.194.2025.04.03.22.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:04:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 4/5] common/config: Introduce _exit wrapper around exit command
In-Reply-To: <80bb7e56ff00101c6bad6c882da631a20b09b6ad.1743487913.git.nirjhar.roy.lists@gmail.com>
Date: Fri, 04 Apr 2025 10:33:46 +0530
Message-ID: <87o6xcv7pp.fsf@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com> <80bb7e56ff00101c6bad6c882da631a20b09b6ad.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> We should always set the value of status correctly when we are exiting.
> Else, "$?" might not give us the correct value.
> If we see the following trap
> handler registration in the check script:
>
> if $OPTIONS_HAVE_SECTIONS; then
>      trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
> else
>      trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
> fi
>
> So, "exit 1" will exit the check script without setting the correct
> return value. I ran with the following local.config file:
>
> [xfs_4k_valid]
> FSTYP=xfs
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/test
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
>
> [xfs_4k_invalid]
> FSTYP=xfs
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/invalid_dir
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
>
> This caused the init_rc() to catch the case of invalid _test_mount
> options. Although the check script correctly failed during the execution
> of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
> returned 0. This is because init_rc exits with "exit 1" without
> correctly setting the value of "status". IMO, the correct behavior
> should have been that "$?" should have been non-zero.

Nice catch. Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> The next patch will replace exit with _exit.
>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  common/config | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/common/config b/common/config
> index 79bec87f..eb6af35a 100644
> --- a/common/config
> +++ b/common/config
> @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
>  export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>  
> +# This functions sets the exit code to status and then exits. Don't use
> +# exit directly, as it might not set the value of "status" correctly.
> +_exit()
> +{
> +	status="$1"
> +	exit "$status"
> +}
> +
>  # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>  set_mkfs_prog_path_with_opts()
>  {
> -- 
> 2.34.1

