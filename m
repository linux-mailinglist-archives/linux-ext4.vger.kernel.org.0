Return-Path: <linux-ext4+bounces-7128-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB5A801AF
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B50E882C93
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49675268C41;
	Tue,  8 Apr 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="idFiXEYI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3C224234
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112115; cv=none; b=ib4KAHgr97dv8q8PApzQU5DBnQ05H1gai5kSe+rlRc6muwVQXamKHSqkctyB/4Csvp8hNOrnKA7KnNyCc2N/781N1NPOmVqfLI0/zZT7o39sJ/uuXjHsyXV/AsKcEbdRe7vh+rR++O7EPrjCq0obTB7LQ0MuAFzfC4apcIXCDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112115; c=relaxed/simple;
	bh=C9YvH7XlcPYpjKw8uXimII7CBva/vXHgTIRSn2xqOl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXm9PVwUGso3tcYSwXNrpUvxrrTv6G5qlZSvozZBdUp6XHHBOt/n+qgYAuxY6KzxNqgdxBu3mOcXSk3tMjMPTj2EIoUKr5mhTqVmwvq7ROBgK6wV5K7Xc1/h0UNvGOAnQTnF2zg3/meIs1cSjLLt4F0bS8s9NtaFbm0a2UvSEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=idFiXEYI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22580c9ee0aso57443435ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744112113; x=1744716913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GP4lUn3SHwIRBNTqZq1gQk1IWBwcK7l2423XKWE6vK8=;
        b=idFiXEYI6TEwHHhtK4bHUdj5JZUIef+dbI+dzXToCrmJ6X3CpGQ9I35diy2Xe2LOkS
         f6yiwMIaar3rHMIHbiwvwdUnNS6sjJ6YzWkQ5BY6mQhIEeFnkNNGVnxpu5WlMe9xKqlD
         XYIyCGbY2GE391s8a0fhnJZHvU2vFkW2vZ53sb1Xgpb4dRMu1LPKT123ssyNxDkHzAo0
         OLWwwggAwrRTCRMtQFyFraX0qfu2pdrmYiwFQRSJ9xdAosKopEjemzvDexWl2KUssuTR
         2uTjubJOevoVc9kAbN5up+iiLxO2YwVGCN204mT6R/ApWZLgR2L1lm+bMUx1bbIlOk0H
         RAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112113; x=1744716913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP4lUn3SHwIRBNTqZq1gQk1IWBwcK7l2423XKWE6vK8=;
        b=uNa6z++5zGqCgX9A9mXSchx3gm0SVrF4K383waQ0a9tjRRZedS8qjuGLJnUJOe7dXZ
         JQZK16Wf+xpSFB6UFAPkUkjrxBZowqX2419JoHlqYAicYCR2vW/CPLHI/+dmYuxEIIe6
         7NYXS/+rzIbRcbj+UPpdNRKs94qLupcRQdkW+WrrDTj6xBLTvcAmghtlrTpLtge6lx1Y
         osyLBOnMVwxf1own60F8mD8iSSch0ltUpo2vkO/NACnjXN6sBdIP34JRqmHUoDhRF2vZ
         vJkWSZzJvaWYpsrTeOpQ5CiipCltamf6SJZTFRYKfzi1UmlKNIDnKQtR9I2bP8prOYbA
         R16A==
X-Forwarded-Encrypted: i=1; AJvYcCXYpMgLRrAI6DTF4tpUs6mt0dw+7NYk1rmOC7ft3D6+9bzbfa1U2rGLdfd/59Pt5VPXz/0OrFSswfWZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxTK1b0oSrNruMGiUHpY/lhuLqxoiHQWgslUtpm08o9oiGrzGRO
	S91taGlXybIFRL4/9eu49Ghb13S7PZjK2nAiPrkbRhUuBAX4lKp/2y5YgAaJBnA=
X-Gm-Gg: ASbGncvjUW2k0SSb0gNrKn2jCxM/6MumP3oAyWQYMaEvBphpv/5QMH1hVNOO7T9eOhL
	YytTAFo7f5F4TzQJhU7tOCU58FCpWsK9nNEX9k50hTXakjTpez9dUThV8R4ftETfw7T621y39T8
	tZ0bK9w1KrgWMKQx5s3S5DdA7gYFZqvqagB8Jw0Tx66u8FAvQR6YxgEW8chpnvnxNBE/yYKaSP1
	Ae6hFuBTpHlFL889O8OxrRZzMMbw3UKVr3dKkmn6EAiQ3VEdTZZN6w9jpJFXeVkyZXe24YDRDy5
	r1M36YcWBDahHqXb2EnYT5EXR8clHJu/EGq+2xRONcEmyTv1laOWm3Zp5tQbD3acaz2IrdQLNTR
	F1C6lZf3HwBwH35+KJQ==
X-Google-Smtp-Source: AGHT+IG28xARa2STv7WTLeZqoAmrW3aYGB5m4ixF3sGJZ82QXo1zrHqnT5gVctW2sDfM39GBKdLAVQ==
X-Received: by 2002:a17:902:e550:b0:223:5a6e:b20 with SMTP id d9443c01a7336-22a8a85a4c8mr211129605ad.7.1744112113464;
        Tue, 08 Apr 2025 04:35:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm98021815ad.11.2025.04.08.04.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:35:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u27ET-000000063AC-420h;
	Tue, 08 Apr 2025 21:35:09 +1000
Date: Tue, 8 Apr 2025 21:35:09 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around
 exit command
Message-ID: <Z_UJ7XcpmtkPRhTr@dread.disaster.area>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>

On Tue, Apr 08, 2025 at 05:37:21AM +0000, Nirjhar Roy (IBM) wrote:
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
> 
> The next patch will replace exit with _exit.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
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

The only issue with putting this helper in common/config is that
calling _exit() requires sourcing common/config from the shell
context that calls it.

This means every test must source common/config and re-execute the
environment setup, even though we already have all the environment
set up because it was exported from check when it sourced
common/config.

We have the same problem with _fatal() - it is defined in
common/config instead of an independent common file. If we put such
functions in their own common file, they can be sourced
without dependencies on any other common file being included first.

e.g. we create common/exit and place all the functions that
terminate tests in it - _fatal, _notrun, _exit, etc and source that
file once per shell context before we source common/config,
common/rc, etc. This means we can source and call those termination
functions from any context without having to worry about
dependencies...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

