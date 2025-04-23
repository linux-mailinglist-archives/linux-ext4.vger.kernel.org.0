Return-Path: <linux-ext4+bounces-7430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF290A98CA0
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284291B64B59
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF027D780;
	Wed, 23 Apr 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTqR8zqw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A627CCF6
	for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417901; cv=none; b=ZLgy4U8N794lx0CYJN54bBYSJDVVzzpCssnnOATfrN/BqJJLsTzW7aKUNhttX40/DUNVC0bZBdfCNGcGRP/tNxamPcN6NvJLSIOSZEji8h+CvmMzQ0VSGJeR9m1svQb4YlJP36oAOl99vMX9FbD/sudVi+iHQamsDeDxhOz/tx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417901; c=relaxed/simple;
	bh=TUvg4ARG4Smble6Dlvk2B5zrYTtTh7sKlkaZQNiowYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l265XzBZaStkvxIFhWLDNsHCbzQqXZF9I686TfOgQV6pMLUDtPm2XFW9I081z0dZ49pVmxgVfhT/imMzl6y0jNHFqv8GaB2gklNenPH/aoIxWO/YZNe4FaapApB1PcpKJmu4MDdTWF2BRENQBDp1vo3IHPF3Y2JfQRgoR84qFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTqR8zqw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745417897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsn9CH6/nAt1LGWpd4X879LvaqHmIn9XeRJNFLaTOx0=;
	b=jTqR8zqw+j/ILMEIVkHf4MU5nl8SPESdImS4z3JYXgLBOF4l64QQWAYBFhbAhaUoOgr6Xo
	438QcdmSi0FCb4YDCGXhRlsHwA0b/n+iTOODmwh/g5tIpw3Unce+xt7JWzpY2RWy3flWOJ
	zcc5IG0gbgWWq13E6OdJv+2ATY4Ekok=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-5NkiC0J8PF6MmYKt-6vAEw-1; Wed, 23 Apr 2025 10:18:16 -0400
X-MC-Unique: 5NkiC0J8PF6MmYKt-6vAEw-1
X-Mimecast-MFC-AGG-ID: 5NkiC0J8PF6MmYKt-6vAEw_1745417895
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241e7e3addso57979015ad.1
        for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 07:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745417895; x=1746022695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsn9CH6/nAt1LGWpd4X879LvaqHmIn9XeRJNFLaTOx0=;
        b=cGjSTJi9LY9ESIigWj/kZ/INfk/QzORDfK+Zcw/oRmGoqHH7c2vcA3y3BI8/Cb8Xei
         Q5wmrqPb05ovSiPWKoil5Ah4FETIAL/1F47/c+z2ypcPJyMPS2kPqrZ4qUoJhkxXW/yy
         MBHVil7y9aRyjPrtGBoFJ5cK6acUIpxkTMjX/NYsugGfSInA3yGHs1duWdqLAymtcGeS
         x8lWNgkj9L7gCvmAGPn4QaExggCCudWL0F2cfLfXHhekxv40MPijnjLfEwBjd8vBovzg
         ko4+vMKKHu7Kr0vxIAgurSjSMOFq8mgHwRmfiDs9S7SAj072YJCJQD1ccSpg/XfWwIxU
         I6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX2+h5kgZpI443qzCbaCesc+8YGK4YhNT3Lk6FNQWOHrbpBqi0cNMdiSx+V7TRdvgXVwqD4QRGygOW5@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZS8PRqCa2MdU48S3lHZiR4CuDYU9IKjVX+bIzTSUQ72/itvQ
	BIv/5lkf74aiRJvTWsAzJdMApJ2XHyQbdUrLy6mzRAorpWo1Vn+avsDZttkPfKuskWgo4+AZ+E4
	aMjfXdF8PjX5dhmDtHl8TfSD+4mLNRh/DNv0JCviTyGa40C1UFZrRH+l6OOA=
X-Gm-Gg: ASbGncs4cxhy8qgyL6UjiFbG9zXzJeIQALiG7gw/zdId37oPAcAaamcfkoK6esb+uAC
	//JSuVwU8Cui7GcRA6uH7onxmQOEQpOKcz4eXXoNe/KmrWgiIrlbTm8IXy4ASic/rR1BCz0JhLA
	f17cIgOHNagrm7BruGdc62VLf3FxmtGF8w6kaj6Tri4/Wx5AklLE+Mn3r13dtI5eZCv6x3DniiX
	/5RUMmMn2LAzOTiydqXL2YkA5atrNwL1sq4ET+NWcIKQph0ZOZQoTQM4hJMMCTNg5zNwpJ0ahgF
	/AtNLvQrZ9oYf9sznMMIjDy2ehfME710SToKO/S//gvXHIeimr3q
X-Received: by 2002:a17:903:240a:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22c535aeb6fmr295249315ad.23.1745417894965;
        Wed, 23 Apr 2025 07:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw6u37V2Z+2+2l2vO45PELpooTb5LqcTRommPQW7L9w0GU7xJdUSOARAAAm2RWryDIBd3qiw==
X-Received: by 2002:a17:903:240a:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22c535aeb6fmr295248825ad.23.1745417894570;
        Wed, 23 Apr 2025 07:18:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4b58sm104596435ad.109.2025.04.23.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:18:14 -0700 (PDT)
Date: Wed, 23 Apr 2025 22:18:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 1/2] common: Move exit related functions to a
 common/exit
Message-ID: <20250423141808.2qdmacsyxu3rtrwh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
 <d0b7939a277e8a16566f04e449e9a1f97da28b9d.1745390030.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b7939a277e8a16566f04e449e9a1f97da28b9d.1745390030.git.nirjhar.roy.lists@gmail.com>

On Wed, Apr 23, 2025 at 06:41:34AM +0000, Nirjhar Roy (IBM) wrote:
> Introduce a new file common/exit that will contain all the exit
> related functions. This will remove the dependencies these functions
> have on other non-related helper files and they can be indepedently
> sourced. This was suggested by Dave Chinner[1].
> 
> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  check           |  1 +
>  common/btrfs    |  2 +-
>  common/ceph     |  2 ++
>  common/config   | 17 +----------------
>  common/dump     |  1 +
>  common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>  common/ext4     |  2 +-
>  common/populate |  2 +-
>  common/preamble |  1 +
>  common/punch    |  6 +-----
>  common/rc       | 29 +---------------------------
>  common/repair   |  1 +
>  common/xfs      |  1 +

I think if you define exit helpers in common/exit, and import common/exit
in common/config, then you don't need to source it(common/exit) in other
common files (.e.g common/xfs, common/rc, etc). Due to when we call the
helpers in these common files, the process should already imported
common/rc -> common/config -> common/exit. right?

Thanks,
Zorro

>  13 files changed, 63 insertions(+), 52 deletions(-)
>  create mode 100644 common/exit
> 
> diff --git a/check b/check
> index 9451c350..67355c52 100755
> --- a/check
> +++ b/check
> @@ -51,6 +51,7 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
>  SRC_GROUPS="generic"
>  export SRC_DIR="tests"
> +. common/exit
>  
>  usage()
>  {
> diff --git a/common/btrfs b/common/btrfs
> index 3725632c..9e91ee71 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -1,7 +1,7 @@
>  #
>  # Common btrfs specific functions
>  #
> -
> +. common/exit
>  . common/module
>  
>  # The recommended way to execute simple "btrfs" command.
> diff --git a/common/ceph b/common/ceph
> index df7a6814..89e36403 100644
> --- a/common/ceph
> +++ b/common/ceph
> @@ -2,6 +2,8 @@
>  # CephFS specific common functions.
>  #
>  
> +. common/exit
> +
>  # _ceph_create_file_layout <filename> <stripe unit> <stripe count> <object size>
>  # This function creates a new empty file and sets the file layout according to
>  # parameters.  It will exit if the file already exists.
> diff --git a/common/config b/common/config
> index eada3971..6a60d144 100644
> --- a/common/config
> +++ b/common/config
> @@ -38,7 +38,7 @@
>  # - this script shouldn't make any assertions about filesystem
>  #   validity or mountedness.
>  #
> -
> +. common/exit
>  . common/test_names
>  
>  # all tests should use a common language setting to prevent golden
> @@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
>  export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>  
> -# This functions sets the exit code to status and then exits. Don't use
> -# exit directly, as it might not set the value of "$status" correctly, which is
> -# used as an exit code in the trap handler routine set up by the check script.
> -_exit()
> -{
> -	test -n "$1" && status="$1"
> -	exit "$status"
> -}
> -
>  # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>  set_mkfs_prog_path_with_opts()
>  {
> @@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
>  	fi
>  }
>  
> -_fatal()
> -{
> -    echo "$*"
> -    _exit 1
> -}
> -
>  export MKFS_PROG="$(type -P mkfs)"
>  [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
>  
> diff --git a/common/dump b/common/dump
> index 09859006..4701a956 100644
> --- a/common/dump
> +++ b/common/dump
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
>  #
>  # Functions useful for xfsdump/xfsrestore tests
> +. common/exit
>  
>  # --- initializations ---
>  rm -f $seqres.full
> diff --git a/common/exit b/common/exit
> new file mode 100644
> index 00000000..ad7e7498
> --- /dev/null
> +++ b/common/exit
> @@ -0,0 +1,50 @@
> +##/bin/bash
> +
> +# This functions sets the exit code to status and then exits. Don't use
> +# exit directly, as it might not set the value of "$status" correctly, which is
> +# used as an exit code in the trap handler routine set up by the check script.
> +_exit()
> +{
> +	test -n "$1" && status="$1"
> +	exit "$status"
> +}
> +
> +_fatal()
> +{
> +    echo "$*"
> +    _exit 1
> +}
> +
> +_die()
> +{
> +        echo $@
> +        _exit 1
> +}
> +
> +die_now()
> +{
> +	_exit 1
> +}
> +
> +# just plain bail out
> +#
> +_fail()
> +{
> +    echo "$*" | tee -a $seqres.full
> +    echo "(see $seqres.full for details)"
> +    _exit 1
> +}
> +
> +# bail out, setting up .notrun file. Need to kill the filesystem check files
> +# here, otherwise they are set incorrectly for the next test.
> +#
> +_notrun()
> +{
> +    echo "$*" > $seqres.notrun
> +    echo "$seq not run: $*"
> +    rm -f ${RESULT_DIR}/require_test*
> +    rm -f ${RESULT_DIR}/require_scratch*
> +
> +    _exit 0
> +}
> +
> diff --git a/common/ext4 b/common/ext4
> index f88fa532..ab566c41 100644
> --- a/common/ext4
> +++ b/common/ext4
> @@ -1,7 +1,7 @@
>  #
>  # ext4 specific common functions
>  #
> -
> +. common/exit
>  __generate_ext4_report_vars() {
>  	__generate_blockdev_report_vars TEST_LOGDEV
>  	__generate_blockdev_report_vars SCRATCH_LOGDEV
> diff --git a/common/populate b/common/populate
> index 50dc75d3..a17acc9e 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -4,7 +4,7 @@
>  #
>  # Routines for populating a scratch fs, and helpers to exercise an FS
>  # once it's been fuzzed.
> -
> +. common/exit
>  . ./common/quota
>  
>  _require_populate_commands() {
> diff --git a/common/preamble b/common/preamble
> index ba029a34..0f306412 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2021 Oracle.  All Rights Reserved.
>  
>  # Boilerplate fstests functionality
> +. common/exit
>  
>  # Standard cleanup function.  Individual tests can override this.
>  _cleanup()
> diff --git a/common/punch b/common/punch
> index 64d665d8..637f463f 100644
> --- a/common/punch
> +++ b/common/punch
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
>  #
>  # common functions for excersizing hole punches with extent size hints etc.
> +. common/exit
>  
>  _spawn_test_file() {
>  	echo "# spawning test file with $*"
> @@ -222,11 +223,6 @@ _filter_bmap()
>  	_coalesce_extents
>  }
>  
> -die_now()
> -{
> -	_exit 1
> -}
> -
>  # test the different corner cases for zeroing a range:
>  #
>  #	1. into a hole
> diff --git a/common/rc b/common/rc
> index 9bed6dad..945f5134 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2,6 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>  
> +. common/exit
>  . common/config
>  
>  BC="$(type -P bc)" || BC=
> @@ -1798,28 +1799,6 @@ _do()
>      return $ret
>  }
>  
> -# bail out, setting up .notrun file. Need to kill the filesystem check files
> -# here, otherwise they are set incorrectly for the next test.
> -#
> -_notrun()
> -{
> -    echo "$*" > $seqres.notrun
> -    echo "$seq not run: $*"
> -    rm -f ${RESULT_DIR}/require_test*
> -    rm -f ${RESULT_DIR}/require_scratch*
> -
> -    _exit 0
> -}
> -
> -# just plain bail out
> -#
> -_fail()
> -{
> -    echo "$*" | tee -a $seqres.full
> -    echo "(see $seqres.full for details)"
> -    _exit 1
> -}
> -
>  #
>  # Tests whether $FSTYP should be exclude from this test.
>  #
> @@ -3835,12 +3814,6 @@ _link_out_file()
>  	_link_out_file_named $seqfull.out "$features"
>  }
>  
> -_die()
> -{
> -        echo $@
> -        _exit 1
> -}
> -
>  # convert urandom incompressible data to compressible text data
>  _ddt()
>  {
> diff --git a/common/repair b/common/repair
> index fd206f8e..db6a1b5c 100644
> --- a/common/repair
> +++ b/common/repair
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
>  #
>  # Functions useful for xfs_repair tests
> +. common/exit
>  
>  _zero_position()
>  {
> diff --git a/common/xfs b/common/xfs
> index 96c15f3c..c236146c 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -1,6 +1,7 @@
>  #
>  # XFS specific common functions.
>  #
> +. common/exit
>  
>  __generate_xfs_report_vars() {
>  	__generate_blockdev_report_vars TEST_RTDEV
> -- 
> 2.34.1
> 


