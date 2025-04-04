Return-Path: <linux-ext4+bounces-7076-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706ABA7B708
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 07:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E0175888
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A414D283;
	Fri,  4 Apr 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3NmV6Bu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BCE57D;
	Fri,  4 Apr 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743307; cv=none; b=r1wWpUJlEIYG4MMldmCHmG8BBa1CAO6Qlzkx9AvVJoIqZQAAMEeA+85HfQBXXNdb8usrcNspRDznAtKAm8ZUfhNTjDdduIsLPn/qZY/WfMlz1+2mOHMZ+ddpofgYhGs3vn8v6I69l8xEfenwwp10Gu2fjAyBUgJEdF8Z53vToxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743307; c=relaxed/simple;
	bh=1nTuoXpO30BpG/aa65LHJVX9Oc403iiDhd4ezj2ySAI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=uH4TkJx3UPSzhSQ6i39/ui67j6MzYYHoez8/k370uBBkeVjVcAeUGRJwhqFS3p+DAVGg8sBkvLh4YSmYo7sl8/+76zwyxIzvq5o+aA1rf+EnmexXN0ca3TUuStlNZkdHAvvtSnoo/t+ABcOTUXEisClOGfdJVz7TBhAPyWuARpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3NmV6Bu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227c7e57da2so15188025ad.0;
        Thu, 03 Apr 2025 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743743305; x=1744348105; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=772E1roxM/IB0spnTqOAR5CEfQBPMpms6russKCPGNg=;
        b=G3NmV6BuoakGqdyhJUBU1J6zxNVDaxxuHhcWocoE0Pn1VCKfT1TGmhVuPe09jRBwMm
         x5Bbw6mDAA46YPFAq4vLmio7oM6jBYqZJphavoxrQ4qGsUuviPH3iSLSAOjQiD6acTdb
         w3akMNg549dPTw7FKUhcKEmL6KEZGKmO56WNTt/yCfzVMfoiuihGutkcPufBmM+NqnUw
         p84m3qkxdrzPl+MOZy0JrYwx87SeKFA6/WPaYEnlvBcMC/zNtChuJGJfMvf8/rsjiqNs
         EqHFan5Dfu4Q7AAnxlXWNVX7NSwMSgtl+uBPiqI0CYN1P36cmpNmvHhFWGP2TwBycFEO
         A38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743743305; x=1744348105;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=772E1roxM/IB0spnTqOAR5CEfQBPMpms6russKCPGNg=;
        b=pmhPHSbJ4PSpscp/2Oq5fqzLicC4FKxZmJV21Bd7xlsC2nWFzBAgVwLqwy7LFsnJQe
         NiVvCvi9fycZysYViSr1Df2K8ssHlxXUnm7XB5lDgR7gTkSeSXmLsp5WteqBvBHGPENt
         DKUFusyF0LS7bH0W+I/xIifssVRqZRwO3fikGulDtKvSaQ8MbSagx0luLCrh6QcK5uwJ
         YlqOdnohmuNOgE68UR+ZKs0OeogSi4yGIPneXsUPI7PTAKLP8Upjc1W2dai3NVaTiNjA
         3UrimDo2BM4QXylfVqExAoFMl+97ufv2z5KTo+4Jyy1fdGic3iwFNtJBFAhO7eMG8Xyb
         M4lA==
X-Forwarded-Encrypted: i=1; AJvYcCUUEM3s6v8FxdCMWkZEgeck98usuIy2L+oo3PZyCE6xj52OxqNCD/3Yc1VS2hVDQ1NrY4aGmLNA@vger.kernel.org, AJvYcCW3djh5j+ogIVndwfGNz0Wg/xx7p0JAJEdwbBfheuM35wU812CXnbnrHS6nvuvFmniGLGJDs/jWdoWq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbl4fU6gLaKxBCJ/wHdC/c5neOXVSA7H5JfVRrTtaCBmo7Ce7c
	GGTe/FCLOuwW99/0c8k8zSbTKkw0RoV7wfW5HzdKqjy9T2wdG6fN
X-Gm-Gg: ASbGncu9HYi97XH7V1VBuU9svbGyllRfWiEBqyaO8dSfQLcc2ZZbNiReub98CQ8yEF6
	R0Irry31EBEHgxwEp4kW5ua0InbhMLwr6FOx0qmRV5JSM0x2rgI43e9Z325LgQJ6jqLHqGPWnnQ
	WJ6uLKIcPTmydlCpYTHar3aIPBshVZVSEqOmkiftUYUTnp1NesPNy/jDpVCItaQMC+tvKtrt0me
	n83GvPvoWuJhWAaYop5BOpFLT23VxIjkjVE/qhBTIUKsz8+5ZhsBqSBk8y+S6LCaS/jSt1OzmaE
	IPzmO484KsuS7uWV5DJthDUEZ+sOq7655b8m
X-Google-Smtp-Source: AGHT+IHGIPBt+AUwdKhX7yUAn7GNDvmi2zMUhpV4dabBoE0G2ws2wYQDVEWp3Cn9hHA5je6StCTF4g==
X-Received: by 2002:a17:903:124a:b0:224:2384:5b40 with SMTP id d9443c01a7336-22a8a06a057mr27097715ad.24.1743743304791;
        Thu, 03 Apr 2025 22:08:24 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee713sm2510888b3a.51.2025.04.03.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:08:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
In-Reply-To: <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
Date: Fri, 04 Apr 2025 10:34:47 +0530
Message-ID: <87mscwv7o0.fsf@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com> <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> Replace exit <return-val> with _exit <return-val> which
> is introduced in the previous patch.
>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  common/btrfs    |   6 +--
>  common/ceph     |   2 +-
>  common/config   |   7 ++--
>  common/ext4     |   2 +-
>  common/populate |   2 +-
>  common/preamble |   2 +-
>  common/punch    |  12 +++---
>  common/rc       | 103 +++++++++++++++++++++++-------------------------
>  common/xfs      |   8 ++--
>  9 files changed, 70 insertions(+), 74 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index a3b9c12f..3725632c 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -80,7 +80,7 @@ _require_btrfs_mkfs_feature()
>  {
>  	if [ -z $1 ]; then
>  		echo "Missing feature name argument for _require_btrfs_mkfs_feature"
> -		exit 1
> +		_exit 1
>  	fi
>  	feat=$1
>  	$MKFS_BTRFS_PROG -O list-all 2>&1 | \
> @@ -104,7 +104,7 @@ _require_btrfs_fs_feature()
>  {
>  	if [ -z $1 ]; then
>  		echo "Missing feature name argument for _require_btrfs_fs_feature"
> -		exit 1
> +		_exit 1
>  	fi
>  	feat=$1
>  	modprobe btrfs > /dev/null 2>&1
> @@ -214,7 +214,7 @@ _check_btrfs_filesystem()
>  	if [ $ok -eq 0 ]; then
>  		status=1
>  		if [ "$iam" != "check" ]; then
> -			exit 1
> +			_exit 1
>  		fi
>  		return 1
>  	fi
> diff --git a/common/ceph b/common/ceph
> index d6f24df1..df7a6814 100644
> --- a/common/ceph
> +++ b/common/ceph
> @@ -14,7 +14,7 @@ _ceph_create_file_layout()
>  
>  	if [ -e $fname ]; then
>  		echo "File $fname already exists."
> -		exit 1
> +		_exit 1
>  	fi
>  	touch $fname
>  	$SETFATTR_PROG -n ceph.file.layout \
> diff --git a/common/config b/common/config
> index eb6af35a..4c5435b7 100644
> --- a/common/config
> +++ b/common/config
> @@ -123,8 +123,7 @@ set_mkfs_prog_path_with_opts()
>  _fatal()
>  {
>      echo "$*"
> -    status=1
> -    exit 1
> +    _exit 1
>  }
>  
>  export MKFS_PROG="$(type -P mkfs)"
> @@ -868,7 +867,7 @@ get_next_config() {
>  		echo "Warning: need to define parameters for host $HOST"
>  		echo "       or set variables:"
>  		echo "       $MC"
> -		exit 1
> +		_exit 1
>  	fi
>  
>  	_check_device TEST_DEV required $TEST_DEV
> @@ -879,7 +878,7 @@ get_next_config() {
>  	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
>  		if [ ! -z "$SCRATCH_DEV" ]; then
>  			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
> -			exit 1
> +			_exit 1
>  		fi
>  		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
>  		export SCRATCH_DEV
> diff --git a/common/ext4 b/common/ext4
> index e1b336d3..f88fa532 100644
> --- a/common/ext4
> +++ b/common/ext4
> @@ -182,7 +182,7 @@ _require_scratch_ext4_feature()
>  {
>      if [ -z "$1" ]; then
>          echo "Usage: _require_scratch_ext4_feature feature"
> -        exit 1
> +        _exit 1
>      fi
>      $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
>  		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
> diff --git a/common/populate b/common/populate
> index 7352f598..50dc75d3 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -1003,7 +1003,7 @@ _fill_fs()
>  
>  	if [ $# -ne 4 ]; then
>  		echo "Usage: _fill_fs filesize dir blocksize switch_user"
> -		exit 1
> +		_exit 1
>  	fi
>  
>  	if [ $switch_user -eq 0 ]; then
> diff --git a/common/preamble b/common/preamble
> index c92e55bb..ba029a34 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -35,7 +35,7 @@ _begin_fstest()
>  {
>  	if [ -n "$seq" ]; then
>  		echo "_begin_fstest can only be called once!"
> -		exit 1
> +		_exit 1
>  	fi
>  
>  	seq=`basename $0`
> diff --git a/common/punch b/common/punch
> index 43ccab69..6567b9d1 100644
> --- a/common/punch
> +++ b/common/punch
> @@ -172,16 +172,16 @@ _filter_fiemap_flags()
>  	$AWK_PROG -e "$awk_script" | _coalesce_extents
>  }
>  
> -# Filters fiemap output to only print the 
> +# Filters fiemap output to only print the
>  # file offset column and whether or not
>  # it is an extent or a hole
>  _filter_hole_fiemap()
>  {
>  	$AWK_PROG '
>  		$3 ~ /hole/ {
> -			print $1, $2, $3; 
> +			print $1, $2, $3;
>  			next;
> -		}   
> +		}
>  		$5 ~ /0x[[:xdigit:]]+/ {
>  			print $1, $2, "extent";
>  		}' |
> @@ -225,7 +225,7 @@ _filter_bmap()
>  die_now()
>  {
>  	status=1
> -	exit
> +	_exit

Why not remove status=1 too and just do _exit 1 here too?
Like how we have done at other places?

Rest looks good to me. 

-ritesh

