Return-Path: <linux-ext4+bounces-7578-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4FAA4AD1
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B272316890C
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EC025A2AF;
	Wed, 30 Apr 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq/gmPMX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA3259CA9;
	Wed, 30 Apr 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015244; cv=none; b=sW/lSxu2o7h7z4TkMaLxQSgb/xqG2id2n2B+j6eNz/HjOoXinn7jEwYW7ybojRFXwg8nivIu2h9YHB9L/jV+BMZGZRiKU6oUXE+XqfebVgkh6YyJ+9NsJdhMfpzU0J5wdSsmcD8InB+RvcFfj+L8JALj+DzJ+uUROSqqM8i/g8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015244; c=relaxed/simple;
	bh=TG+77IxrzSzVGINZq8oXRIc3CRCuepxZJTYFhz13zDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERe/B0nyUcjCtPFm5u4lscYZoaZtF4eKWoBUWFshsyxIR37CJU5eyzcLhPDZLIvp14cUUz8LoVn68uYcq0xEd3DZlK/xn2TrLTg9BgJqqSSwoL0C6F6fkKTS4+FFAdM62lah1P7LW1PZFaoxMHh49BIIdjHdjKF9uMarBrQ845Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq/gmPMX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22da3b26532so61473865ad.0;
        Wed, 30 Apr 2025 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746015242; x=1746620042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niyi1msOlm1iqBtrWqF3E8xQLxdg81yPDg6rhW5d5uM=;
        b=lq/gmPMXcSMp9CJBetNE3nL3brTL7YsNM89nzrLecjwItwEECHAMb808okhunZIFvz
         rUVaOkFHKmLtGzn8Dk9wPnMCTsnEhLU51Ve4RhTdFiE0+iU+/LoXvSDNrFtm9q8Mj6jH
         HWmOYjy8D+TbKW1EzrCsbVjm7EeqmRdukjTXA/SvTrnrC4Ux4XvzQTYK//s6QQ9e9ysJ
         1LIHWOLUaEpjTxShvDlTqMgka5S/Kf8v3Db60oI8JGNmsLJoJeRTe/Ae/Yu36PFkOwdr
         5+GMzGnkjxxSgajYQNzzEkqWsDumkamJyxx06xFwUoE0hcmNELVH5uKzpGC9Eziuy/P8
         /ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746015242; x=1746620042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niyi1msOlm1iqBtrWqF3E8xQLxdg81yPDg6rhW5d5uM=;
        b=mJh4zU5RtsY4l8U/7MNZUh1anvJ7zEzFylA3PfyPvBwaqW1sK8jTtJNiOVtc+s2gzt
         dvSbIpI1wpsl0YCc44gHlsFK4EOwuNik5Y4IbDLDOWfvO1hBUw3A5BzVoiJ2EniyqYAX
         ztBulOOXiAbozCJMkZb0W7E5ATozyP41s0tLXFkuEgKadxQRaAVtw/lQ+jeG18L6hwRF
         RmoSP6rXxuoBCImQ/lx4TDylbRo9+UwnxDOSrYXzPFQp2S78Y319fnNRhilKqxF402Km
         EvBq/LgKq70mbrJ5aK4+ZgCJBxWzYDGTIVs4K1XX7KWNwRB4a5ywHRBKETrUbiYbRuoO
         BQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUE3sA88pfFbBGnJ8Ymigk9VuuZ2UBNtNHX+tId+xigWCNATn7/Nla2kPedHIK950vyhokxHifmulXJ@vger.kernel.org, AJvYcCVCAjMh0vOP+etweEGzPlMJxTpxl9lidlFrwKRko85LwCNxOUFJqfXLk+9/wbYofygVh0deusbZLQa1@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaJRUa98f2bH5/qprzfo0B73qi8IYNvAJyI5jdFjSWxt+5GPy
	tknlC95rc5uErWqXIZwJIJjQ4Oh3MzKUajfUJM+7J2/Z/dWUQNJq
X-Gm-Gg: ASbGncvuWszA5DBUYG+/d2cWW2dm8yZKmf6uAJC20/JRvjrxyl642LmHDjOEpQWbO+K
	D7PKXYoHgXI+o+M9O3bdfF8F4cj4Ky7XG2Qb0HOKVgBEMOqINfTsA6JTspL4Dev+G97HlzEto81
	Ltq8vBEKsoTUzpYuk9aRBS9OI8gOOnNg4Jl7WwI/yupyKiOVwq0V5VDpC2oX8O1M4mLUwmvT9b+
	DckA+MfnWJTddfgBhmZOhsxY/hvInvpes75ton6FObYAbNj7fFvc6bRcTZlpUH2GsJxV2uFZaHR
	gK+t5EgDKYYll1FYBMZJ9P/BJQB8xWoJljKIzerMdVjnKZFuSDo=
X-Google-Smtp-Source: AGHT+IF8Mt64Gv+gBImpZqSan37Rceo2pB+gHcUk4jwD45vKqf3/G1OSHiiF+knL9R+lvYGkYuzLFg==
X-Received: by 2002:a17:902:f68c:b0:220:ea90:191e with SMTP id d9443c01a7336-22df34aa368mr48039815ad.4.1746015241718;
        Wed, 30 Apr 2025 05:14:01 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100ab2sm120345985ad.183.2025.04.30.05.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 05:14:01 -0700 (PDT)
Message-ID: <7a8369d3-bed9-42a6-988e-5b9032cbe8a8@gmail.com>
Date: Wed, 30 Apr 2025 17:43:56 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] check: Replace exit with _exit in check
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
 <de352e171003ab91fab2328652f8b1990a2d8cce.1745908976.git.nirjhar.roy.lists@gmail.com>
 <aBFn6YL3vHpb09yB@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aBFn6YL3vHpb09yB@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/30/25 05:29, Dave Chinner wrote:
> On Tue, Apr 29, 2025 at 06:52:54AM +0000, Nirjhar Roy (IBM) wrote:
>> Some of the "status=<val>;exit" and "exit <val>" were not
>> replace with _exit <val>. Doing it now.
>>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   check | 44 ++++++++++++++++++--------------------------
>>   1 file changed, 18 insertions(+), 26 deletions(-)
>>
>> diff --git a/check b/check
>> index 9451c350..99d38492 100755
>> --- a/check
>> +++ b/check
>> @@ -47,6 +47,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>>   # by default don't output timestamps
>>   timestamp=${TIMESTAMP:=false}
>>   
>> +. common/exit
>>   rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>>   
>>   SRC_GROUPS="generic"
>> @@ -121,7 +122,7 @@ examples:
>>    check -X .exclude -g auto
>>    check -E ~/.xfstests.exclude
>>   '
>> -	    exit 1
>> +	    _exit 1
>>   }
>>   
>>   get_sub_group_list()
>> @@ -231,7 +232,7 @@ _prepare_test_list()
>>   			list=$(get_group_list $group)
>>   			if [ -z "$list" ]; then
>>   				echo "Group \"$group\" is empty or not defined?"
>> -				exit 1
>> +				_exit 1
>>   			fi
>>   
>>   			for t in $list; do
> This is now:
>
> 	_fatal "Group \"$group\" is empty or not defined?"
Noted.
>
>> @@ -316,14 +317,14 @@ while [ $# -gt 0 ]; do
>>   	-r)
>>   		if $exact_order; then
>>   			echo "Cannot specify -r and --exact-order."
>> -			exit 1
>> +			_exit 1
>>   		fi
>>   		randomize=true
>>   		;;
>>   	--exact-order)
>>   		if $randomize; then
>>   			echo "Cannnot specify --exact-order and -r."
>> -			exit 1
>> +			_exit 1
>>   		fi
>>   		exact_order=true
>>   		;;
> Same.
Noted.
>
>> @@ -361,7 +362,7 @@ done
>>   # after processing args, overlay needs FSTYP set before sourcing common/config
>>   if ! . ./common/rc; then
>>   	echo "check: failed to source common/rc"
>> -	exit 1
>> +	_exit 1
>>   fi
>>   
>>   init_rc
> Same.

Noted.

>
>> @@ -373,8 +374,7 @@ if [ -n "$SOAK_DURATION" ]; then
>>   		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
>>   		$AWK_PROG -f $here/src/soak_duration.awk)"
>>   	if [ $? -ne 0 ]; then
>> -		status=1
>> -		exit 1
>> +		_exit 1
>>   	fi
>>   fi
>>   
>> @@ -385,8 +385,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
>>   		sed -e 's/^\([.0-9]*\)\([a-z]\)*/\1 \2/g' | \
>>   		$AWK_PROG -f $here/src/soak_duration.awk)"
>>   	if [ $? -ne 0 ]; then
>> -		status=1
>> -		exit 1
>> +		_exit 1
>>   	fi
>>   fi
>>   
>> @@ -404,8 +403,7 @@ if $have_test_arg; then
>>   	while [ $# -gt 0 ]; do
>>   		case "$1" in
>>   		-*)	echo "Arguments before tests, please!"
>> -			status=1
>> -			exit $status
>> +			_exit 1
> _fatal
Noted.
>
>>   			;;
>>   		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
>>   			list=$(cd $SRC_DIR; echo $1)
>> @@ -438,7 +436,7 @@ fi
>>   if [ `id -u` -ne 0 ]
>>   then
>>       echo "check: QA must be run as root"
>> -    exit 1
>> +    _exit 1
>>   fi
> Same
Noted.
>
>>   
>>   _wipe_counters()
>> @@ -721,9 +719,9 @@ _prepare_test_list
>>   fstests_start_time="$(date +"%F %T")"
>>   
>>   if $OPTIONS_HAVE_SECTIONS; then
>> -	trap "_summary; exit \$status" 0 1 2 3 15
>> +	trap "_summary; _exit" 0 1 2 3 15
>>   else
>> -	trap "_wrapup; exit \$status" 0 1 2 3 15
>> +	trap "_wrapup; _exit" 0 1 2 3 15
>>   fi
> Please add a comment explaining that _exit will capture $status
> that has been previously set as the exit value.
>
> Realistically, though, I think 'exit $status' is much better here
> because it clearly documents that we are capturing $status as the
> exit value from the trap rather than having to add a comment to make
> it clear that $status is the exit value of the trap...

Yeah, I will use "exit \$status" and mention in comments as to why we 
aren't using _exit(), although we can.

>
>>   function run_section()
>> @@ -767,8 +765,7 @@ function run_section()
>>   	mkdir -p $RESULT_BASE
>>   	if [ ! -d $RESULT_BASE ]; then
>>   		echo "failed to create results directory $RESULT_BASE"
>> -		status=1
>> -		exit
>> +		_exit 1
>>   	fi
> _fatal
Noted.
>
>>   	if $OPTIONS_HAVE_SECTIONS; then
>> @@ -784,8 +781,7 @@ function run_section()
>>   			echo "our local _test_mkfs routine ..."
>>   			cat $tmp.err
>>   			echo "check: failed to mkfs \$TEST_DEV using specified options"
>> -			status=1
>> -			exit
>> +			_exit 1
>>   		fi
>>   		# Previous FSTYP derived from TEST_DEV could be changed, source
>>   		# common/rc again with correct FSTYP to get FSTYP specific configs,
>> @@ -829,8 +825,7 @@ function run_section()
>>   	      echo "our local _scratch_mkfs routine ..."
>>   	      cat $tmp.err
>>   	      echo "check: failed to mkfs \$SCRATCH_DEV using specified options"
>> -	      status=1
>> -	      exit
>> +	      _exit 1
>>   	  fi
>>   
>>   	  # call the overridden mount - make sure the FS mounts with
>> @@ -840,8 +835,7 @@ function run_section()
>>   	      echo "our local mount routine ..."
>>   	      cat $tmp.err
>>   	      echo "check: failed to mount \$SCRATCH_DEV using specified options"
>> -	      status=1
>> -	      exit
>> +	      _exit 1
>>   	  else
>>   	      _scratch_unmount
>>   	  fi
> Same for all these.
Noted.
>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


