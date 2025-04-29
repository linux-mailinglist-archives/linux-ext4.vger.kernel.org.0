Return-Path: <linux-ext4+bounces-7539-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E77AA0E2F
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 16:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308355A43A5
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0D2D1928;
	Tue, 29 Apr 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpG+VVU3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1021129D;
	Tue, 29 Apr 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935652; cv=none; b=QQeHa+lwkFDFLPjf2glD47RtNX73I95o9hR4RcMfua8c08hwXOS+Xs8MZlpyD/+qrl9Ply0VSNxuJcZD1bStf/yo3vQfQFxxv8TeajwmL5Rzmn1S6pBpz+x4u/UlkqaSpT1qnvHSsFjJptiyriAgHAE4AC8J51LabnZOfF+nPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935652; c=relaxed/simple;
	bh=OSFeR2Osvl154bb5RdM3rq+d0/EYI4VooRWh7HAVyGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvnhrVgcW1MfVhBKu+8Xpbx6tiLUVUhh/hUvu0zt2zwhjIMIkzB8UH5+76YpVN6RPNwNBiZWIrUaprYBwc90jI8x5iKbEh2qSWUA2n5lHnFScj+J5qaDHiTZuAp9DLIoefUcr7fGJEweKIs6g9i9xA2tzd76IuGErQzwjD2GzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpG+VVU3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c3407a87aso88682415ad.3;
        Tue, 29 Apr 2025 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745935650; x=1746540450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXjQwHkLsHAE8bHmciYnBANbOGisgmLKw+l8KfO7/NU=;
        b=GpG+VVU3YOBL4ulT2oA3AFpDYhilKOSYNx5sq5iioqg0ND8yVOBCCCMZhbo4Plpzix
         tN07MxzBrWlBcTtz3x75MLopb+UY8NU0kzoMhbq15lM/q7F5stUb8PZbUWKW3GEUmvUA
         Xf372ywY++bvpgBm0NAa/nKXDVCohl/SCc8YY4APiJ0lr5iIiQsSb4aTYojr5dOXpfqW
         kMy3Hy2es9El73aGiBk+ukkDlD4mSONVFlMn4hri/Lt1GlpdELKaiLPHn7vDFFcQ6mP9
         qhBwAHNmd+QHnw1MNuryvsYIFWibgd+1zP628FiPHKQVvuVfV3qR64zYkZ4TbKTdIy5d
         RZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935650; x=1746540450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXjQwHkLsHAE8bHmciYnBANbOGisgmLKw+l8KfO7/NU=;
        b=UulrgXxI5GFlclK2xKMbJwWyfR/mLvPTSiC32y0szBco9N6V0nM7kC/TxtF3mWhBhB
         4nCGaKgILBeb8UZrQO9N0rHcZWXK4gIyr5xKXLjSGJyg9P1jAvatSzLBQF9O3DcRCUyg
         u/pVbZEzTs58vztQ+Di3HvgAPSWvicikvnYsv/t8nfVYx9+FfZXld3BnO8OSLGgEL4zM
         jl9LABViV2L9m4WiAZnQIZ9pkVneIyHAx2G/WHzveikXUBnO5oVry3wPja5FTgYYICAx
         Mvka6EaK/Jl4hzsRiatdNDNdZacLugVWK1gz+FV35ekudw+SX0tjmR728QYL+AVLS+SS
         8VNA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9FdokYlVQFp9j+T11uIfJaWJNrf1UJ9AGNtqyKeHa0tNtJ4ofOHlHjQ6onjgd4BNOYqSgghZTNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28eHrhfYZ9q+8X6YrtQejW7xNyyptdctB8NlSiZ7IC2ToDOFh
	e2dM2KBn+zbClgtQI7BPRMx+kXC0V0wknI0C8Ffx+Lp5AeyZhUtzvjs96w==
X-Gm-Gg: ASbGncuRTXhIXL/CqPXQZtKc8aBjSFxNfC893nc17Pxj9V+O+Rj5TvdVf4BPVPyBV2l
	cTeHEEanCZRIdKWWIIY08SKupF6Mm3w7L2AN6NsmOxbJ+/PgaZCaLt8kfvz7XNXSaHqye2aJq04
	Dx7T1+rfH84NjnsLCIAzeeSzelr/OYNgc0WIrtVKB3pucLAoxZKZDXMVXTx6Xag+LAPA5e6ovfZ
	DyxtXEqeTApNP8gjnkpUfjPisqdpIAYGUwc9Gn6RTFOlkNCB4PQMnTAK9XBPc9xbY3rWDhXWE++
	K53zyttuYNFaZT6PaJDu3usS0PjIeJl4nDBSU8JnuxKEPCES5do=
X-Google-Smtp-Source: AGHT+IFHKi3jHaYyEeFOXoXiMpK7zg8P98SDWPEnpLrZwmuchBBI2jBheokCfLLp1+PgTEmrg5x2GQ==
X-Received: by 2002:a17:903:40ca:b0:224:24d5:f20a with SMTP id d9443c01a7336-22de60702f0mr59646295ad.48.1745935649606;
        Tue, 29 Apr 2025 07:07:29 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a9fsm102404005ad.111.2025.04.29.07.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:07:29 -0700 (PDT)
Message-ID: <4132df90-a2d6-4d2e-a5e9-5ff893a25025@gmail.com>
Date: Tue, 29 Apr 2025 19:37:24 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] common: Move exit related functions to a
 common/exit
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
 <a2e20e1d74360a76fd2a1ef553cac6094897bff2.1745908976.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <a2e20e1d74360a76fd2a1ef553cac6094897bff2.1745908976.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/29/25 12:22, Nirjhar Roy (IBM) wrote:
> Introduce a new file common/exit that will contain all the exit
> related functions. This will remove the dependencies these functions
> have on other non-related helper files and they can be indepedently
> sourced. This was suggested by Dave Chinner[1].

Sorry, I didn't notice this earlier. A similar change[c1] was already 
posted by Dave.

[c1] 
https://lore.kernel.org/all/20250417031208.1852171-4-david@fromorbit.com/

--NR

>
> [1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   common/config   | 17 +----------------
>   common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>   common/preamble |  1 +
>   common/punch    |  5 -----
>   common/rc       | 28 ---------------------------
>   5 files changed, 52 insertions(+), 49 deletions(-)
>   create mode 100644 common/exit
>
> diff --git a/common/config b/common/config
> index eada3971..6a60d144 100644
> --- a/common/config
> +++ b/common/config
> @@ -38,7 +38,7 @@
>   # - this script shouldn't make any assertions about filesystem
>   #   validity or mountedness.
>   #
> -
> +. common/exit
>   . common/test_names
>   
>   # all tests should use a common language setting to prevent golden
> @@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>   
>   export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
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
>   # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>   set_mkfs_prog_path_with_opts()
>   {
> @@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
>   	fi
>   }
>   
> -_fatal()
> -{
> -    echo "$*"
> -    _exit 1
> -}
> -
>   export MKFS_PROG="$(type -P mkfs)"
>   [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
>   
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
> diff --git a/common/preamble b/common/preamble
> index ba029a34..9b6b4b26 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -33,6 +33,7 @@ _register_cleanup()
>   # explicitly as a member of the 'all' group.
>   _begin_fstest()
>   {
> +	. common/exit
>   	if [ -n "$seq" ]; then
>   		echo "_begin_fstest can only be called once!"
>   		_exit 1
> diff --git a/common/punch b/common/punch
> index 64d665d8..4e8ebcd7 100644
> --- a/common/punch
> +++ b/common/punch
> @@ -222,11 +222,6 @@ _filter_bmap()
>   	_coalesce_extents
>   }
>   
> -die_now()
> -{
> -	_exit 1
> -}
> -
>   # test the different corner cases for zeroing a range:
>   #
>   #	1. into a hole
> diff --git a/common/rc b/common/rc
> index 9bed6dad..fac9b6da 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1798,28 +1798,6 @@ _do()
>       return $ret
>   }
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
>   #
>   # Tests whether $FSTYP should be exclude from this test.
>   #
> @@ -3835,12 +3813,6 @@ _link_out_file()
>   	_link_out_file_named $seqfull.out "$features"
>   }
>   
> -_die()
> -{
> -        echo $@
> -        _exit 1
> -}
> -
>   # convert urandom incompressible data to compressible text data
>   _ddt()
>   {

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


