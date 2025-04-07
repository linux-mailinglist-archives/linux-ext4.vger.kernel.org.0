Return-Path: <linux-ext4+bounces-7093-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9964A7ECD6
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E35B426D89
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CA25A64E;
	Mon,  7 Apr 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWRk3hyR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CE25A634;
	Mon,  7 Apr 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052415; cv=none; b=YSpRRlUJZnCKLAO74siQHOBTg9KQsMVkyME8uDf7HW+T5K2S2YpIggPxPmWGevk0oUmaXPucnkfzLYjEbGyRUkyWwHAW6Ej3MTShv629K7qMnjWhRr6JRV+1ng0ryyR991e5LoANlO94zvASCAP7YiReFl4e8fwkKlCoZNiffpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052415; c=relaxed/simple;
	bh=q2vJ5LHi9sAGQljA18jvS4I+fbbWMadIC3ojc4C9fBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU/pWZieXr4/H5oSn1WJQEx9L2DPmColWWqEBiAep5WU+1ZGFF/aGQmYxTXJZZ4smwq5GPCoWoX1xiIL0t8JQRHqNdsZ9sh0NQoPR9HqCNYjBwLHKaQV0+oa5lDJJryleyT3AumxDq2G7kayjbmTViWzHATmhq2KyAOJ0C2AXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWRk3hyR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224171d6826so65116265ad.3;
        Mon, 07 Apr 2025 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052404; x=1744657204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzv4hlb3/QvyR2ujdMno9gzZ54PY/5ymBUC6TN7jUqM=;
        b=WWRk3hyRMAQBFWhPabBjJDGqGr8j6KtgFaaQrc6G41m06A4r5nqTaO4IerQwPE3pE9
         1N0zYUuFDKggBmE2i0AkXLmVsGHhyQ1uKOj89e+9/32PX/YQLbPk5oHgF7jHalnhV68F
         ePtmLG1mHZlguzH+VMgrHAH2jznQjLvSCtO9bQtYBoeYQWGcEp/RKGK1JsVrSOKIVhi9
         bqIxvoBFiBtM8VMUIK0heggXxo03FmNujBAo+c5WOFaIxh4WmRwpFcj/lsuESnqyB/Ei
         ZyvasMOcksj06iTmlB8DF7rgfK786PChsgXxvRvxjiJAiBpxNbYPc+2x0dSPp6peav8z
         ifHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052404; x=1744657204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzv4hlb3/QvyR2ujdMno9gzZ54PY/5ymBUC6TN7jUqM=;
        b=EbPGCEcuyl0fy5sNcO08C4Eh4ukKurqvWJeXVer89f7tXeJSOCZ5Rbl2SLEG5MwigU
         1/08w3Xi/GsIB2K394w3DHWKW+38QUvsnGJO39OHwkppNq6AtQ9Eg6MYMRBJxIT6wBJ7
         nQkQJDNpaZLwLlDeW6q3vb665GCyZlubCQ2PeICBaCRplJBHIZr5kWq1pDljGkQ0IRd0
         QCWeWRPUoccZUyBS1ZmHLOvy/a12jBO06VL+nXc4xOPRZwSZlZHMvTCTV9MAq1Lacvgn
         lpRpt9loHqTcH05z3K9vabzIIJsmCKmdgsTVZU4yIjYXDxueYYefpDNfLhHQvtIh1VRg
         46mg==
X-Forwarded-Encrypted: i=1; AJvYcCW5/O/XI0THSoEJdV+tII+RgudRwj8iwwcbDzwvVnjsvoFq/lqosvVOEMAeWTh/MRluN4WjMCB/ifFg@vger.kernel.org, AJvYcCWOjfGvzogDJ0kyQnEw6QMH/mSKH7SgJR+/C7NjY1DVwTQWjASUzo6bdXig7K1QI1rNKm3MJUB5URe6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcjg5xCLdi5ev+vaAD1SoFCkVzBoi2fQshKSaclCHUXAD8WZrI
	NbL8yTOyTuhSbVWXkP137xZfX9DYPsYCTOZ/0E+/Ak7etfX5XrjyJhI8zA==
X-Gm-Gg: ASbGncvIkhEOYylsP8JyxQoh2Tbln05x51dJGsYnNCyCIXbXZ/2LTPiB/6bR/tsiTRE
	lXcNUxXfYy0GxrnBUg2mOQX1B0aBX6s5kq7YvY+PHwWTO/56eG3j6z+0JxA5f4aAizwl3jSSVJU
	vK19oAaiMispHvOu/u65hvg1cX0exVyccfvAmHRJ0xlndbehsV1nXaI1W93y7ZEZQB7emLKkAOM
	rm1D35dWfFD0Nc4HOJhbvTXcMTAc3ZHbZZ+rGjpl8zJZltxaYQg3vPr/xt9ahpcGkc12AVFor2I
	EWSS1dVtxUQhQya/rYlRBgUaFaf5k2v/EAzDYbMJjcM28Cs3pMjD5dE=
X-Google-Smtp-Source: AGHT+IFUrYwsd6en5sy5M07jYJNpjE2bDj/lHgYzbIjP70XS7s/JGAniVE7afZEJ18Uq43ZFsQx3oQ==
X-Received: by 2002:a17:903:1a2f:b0:224:191d:8a79 with SMTP id d9443c01a7336-22a8a065a9emr176926685ad.27.1744052404208;
        Mon, 07 Apr 2025 12:00:04 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1fesm84654005ad.184.2025.04.07.12.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 12:00:03 -0700 (PDT)
Message-ID: <ee2234d0-d27d-45ad-b19d-419ac9126dee@gmail.com>
Date: Tue, 8 Apr 2025 00:29:59 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
To: Zorro Lang <zlang@redhat.com>, Ritesh Harjani <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/7/25 21:49, Zorro Lang wrote:
> On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>
>>> Replace exit <return-val> with _exit <return-val> which
>>> is introduced in the previous patch.
>>>
>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>> ---
>>>   common/btrfs    |   6 +--
>>>   common/ceph     |   2 +-
>>>   common/config   |   7 ++--
>>>   common/ext4     |   2 +-
>>>   common/populate |   2 +-
>>>   common/preamble |   2 +-
>>>   common/punch    |  12 +++---
>>>   common/rc       | 103 +++++++++++++++++++++++-------------------------
>>>   common/xfs      |   8 ++--
>>>   9 files changed, 70 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/common/btrfs b/common/btrfs
>>> index a3b9c12f..3725632c 100644
>>> --- a/common/btrfs
>>> +++ b/common/btrfs
>>> @@ -80,7 +80,7 @@ _require_btrfs_mkfs_feature()
>>>   {
>>>   	if [ -z $1 ]; then
>>>   		echo "Missing feature name argument for _require_btrfs_mkfs_feature"
>>> -		exit 1
>>> +		_exit 1
>>>   	fi
>>>   	feat=$1
>>>   	$MKFS_BTRFS_PROG -O list-all 2>&1 | \
>>> @@ -104,7 +104,7 @@ _require_btrfs_fs_feature()
>>>   {
>>>   	if [ -z $1 ]; then
>>>   		echo "Missing feature name argument for _require_btrfs_fs_feature"
>>> -		exit 1
>>> +		_exit 1
>>>   	fi
>>>   	feat=$1
>>>   	modprobe btrfs > /dev/null 2>&1
>>> @@ -214,7 +214,7 @@ _check_btrfs_filesystem()
>>>   	if [ $ok -eq 0 ]; then
>>>   		status=1
>>>   		if [ "$iam" != "check" ]; then
>>> -			exit 1
>>> +			_exit 1
>>>   		fi
>>>   		return 1
>>>   	fi
>>> diff --git a/common/ceph b/common/ceph
>>> index d6f24df1..df7a6814 100644
>>> --- a/common/ceph
>>> +++ b/common/ceph
>>> @@ -14,7 +14,7 @@ _ceph_create_file_layout()
>>>   
>>>   	if [ -e $fname ]; then
>>>   		echo "File $fname already exists."
>>> -		exit 1
>>> +		_exit 1
>>>   	fi
>>>   	touch $fname
>>>   	$SETFATTR_PROG -n ceph.file.layout \
>>> diff --git a/common/config b/common/config
>>> index eb6af35a..4c5435b7 100644
>>> --- a/common/config
>>> +++ b/common/config
>>> @@ -123,8 +123,7 @@ set_mkfs_prog_path_with_opts()
>>>   _fatal()
>>>   {
>>>       echo "$*"
>>> -    status=1
>>> -    exit 1
>>> +    _exit 1
>>>   }
>>>   
>>>   export MKFS_PROG="$(type -P mkfs)"
>>> @@ -868,7 +867,7 @@ get_next_config() {
>>>   		echo "Warning: need to define parameters for host $HOST"
>>>   		echo "       or set variables:"
>>>   		echo "       $MC"
>>> -		exit 1
>>> +		_exit 1
>>>   	fi
>>>   
>>>   	_check_device TEST_DEV required $TEST_DEV
>>> @@ -879,7 +878,7 @@ get_next_config() {
>>>   	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
>>>   		if [ ! -z "$SCRATCH_DEV" ]; then
>>>   			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
>>> -			exit 1
>>> +			_exit 1
>>>   		fi
>>>   		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
>>>   		export SCRATCH_DEV
>>> diff --git a/common/ext4 b/common/ext4
>>> index e1b336d3..f88fa532 100644
>>> --- a/common/ext4
>>> +++ b/common/ext4
>>> @@ -182,7 +182,7 @@ _require_scratch_ext4_feature()
>>>   {
>>>       if [ -z "$1" ]; then
>>>           echo "Usage: _require_scratch_ext4_feature feature"
>>> -        exit 1
>>> +        _exit 1
>>>       fi
>>>       $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
>>>   		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
>>> diff --git a/common/populate b/common/populate
>>> index 7352f598..50dc75d3 100644
>>> --- a/common/populate
>>> +++ b/common/populate
>>> @@ -1003,7 +1003,7 @@ _fill_fs()
>>>   
>>>   	if [ $# -ne 4 ]; then
>>>   		echo "Usage: _fill_fs filesize dir blocksize switch_user"
>>> -		exit 1
>>> +		_exit 1
>>>   	fi
>>>   
>>>   	if [ $switch_user -eq 0 ]; then
>>> diff --git a/common/preamble b/common/preamble
>>> index c92e55bb..ba029a34 100644
>>> --- a/common/preamble
>>> +++ b/common/preamble
>>> @@ -35,7 +35,7 @@ _begin_fstest()
>>>   {
>>>   	if [ -n "$seq" ]; then
>>>   		echo "_begin_fstest can only be called once!"
>>> -		exit 1
>>> +		_exit 1
>>>   	fi
>>>   
>>>   	seq=`basename $0`
>>> diff --git a/common/punch b/common/punch
>>> index 43ccab69..6567b9d1 100644
>>> --- a/common/punch
>>> +++ b/common/punch
>>> @@ -172,16 +172,16 @@ _filter_fiemap_flags()
>>>   	$AWK_PROG -e "$awk_script" | _coalesce_extents
>>>   }
>>>   
>>> -# Filters fiemap output to only print the
>>> +# Filters fiemap output to only print the
>>>   # file offset column and whether or not
>>>   # it is an extent or a hole
>>>   _filter_hole_fiemap()
>>>   {
>>>   	$AWK_PROG '
>>>   		$3 ~ /hole/ {
>>> -			print $1, $2, $3;
>>> +			print $1, $2, $3;
>>>   			next;
>>> -		}
>>> +		}
>>>   		$5 ~ /0x[[:xdigit:]]+/ {
>>>   			print $1, $2, "extent";
>>>   		}' |
>>> @@ -225,7 +225,7 @@ _filter_bmap()
>>>   die_now()
>>>   {
>>>   	status=1
>>> -	exit
>>> +	_exit
>> Why not remove status=1 too and just do _exit 1 here too?
>> Like how we have done at other places?
> Yeah, nice catch! As the defination of _exit:
>
>    _exit()
>    {
>         status="$1"
>         exit "$status"
>    }
>
> The
>    "
>    status=1
>    exit
>    "
> should be equal to:
>    "
>    _exit 1
>    "
>
> And "_exit" looks not make sense, due to it gives null to status.
>
> Same problem likes below:
>
>
> @@ -3776,7 +3773,7 @@ _get_os_name()
>                  echo 'linux'
>          else
>                  echo Unknown operating system: `uname`
> -               exit
> +               _exit
>
>
> The "_exit" without argument looks not make sense.

Yes, thank you Ritesh and Zorro. Yes it should have been "_exit 1". I 
missed it while making the changes. I will make the changes in v3 and 
add RBs from Dave[1] and Ritesh.

[1] https://lore.kernel.org/all/Z-xcne3f5Klvuxcq@dread.disaster.area/

>
> Thanks,
> Zorro
>
>> Rest looks good to me.
>>
>> -ritesh
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


