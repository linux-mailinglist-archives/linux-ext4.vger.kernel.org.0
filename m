Return-Path: <linux-ext4+bounces-6771-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DAA5D5B1
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 06:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3739E7AA464
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97971DF73B;
	Wed, 12 Mar 2025 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTBjgNeP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AE1D515A;
	Wed, 12 Mar 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758373; cv=none; b=PsdlebmWGng8N5lxqmNUtRadSSGhy47SaYNLua1ctlQ/K0PiMBQygrJ0iIKyDGWM4XwMbOT2jTf3RFzIMhwb9vJeawhq9LRBmbDcVYmKwSS78Xl4Lo1m2o8kgYJQjy9dTtZKuQ8SnckCuWsKbJxY2RWI/xRh05pGNHd369nTaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758373; c=relaxed/simple;
	bh=xW7+cPjAm/tVj24NTwfEsKZ0cJqxJrjhbCR2zSbDnIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhFL+lxhlWQAlRfovaq/hBp0FhtB9mSRzb/HMvQ29QXSVp7zmYonLyFUW9KD2WYDtVBaKe3QKjIg+3R2koD4UTbpvQCvPj2VSQRFE4yeejEKnian6Hpdl7JeJBo2QtET6HtqrKerzsfiqMqvjsCLbzrMUP4Aw4Owpec/mkJNQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTBjgNeP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so8641433a91.1;
        Tue, 11 Mar 2025 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741758371; x=1742363171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYzLREHJnRZB4MLC2JrKkCyZzbYuqUOvfim43MDHqyE=;
        b=BTBjgNePWt5Ckoq8eJtcmAdwqhrC0lK4ucYf525ZSakTePDfVIqtPRSHSe+PCxn49Y
         yeieueG9CWZB5qbXNMd6srf3hwy8EnzLoIw2oSumt5IWHaWti6cNiKF2BeYl00mzBrHz
         ToecXUfu6YmYaxPbNBGrAXNlG4/dcXNuBM0bcbQiyYC2S19xln1oYYC1r3aHmwLJ0NUM
         xAclIVKLA9ylK19aZOYH92jJ2Vu05YHkZJWCBaxfandAvLrZvby7PtBgp5Risn0KNOKi
         1AdaB/Dp/mYmrApCx87p9q5oYxsnu+JuaVIjChwcbZIao5oyd5Wj0DJF4/fPvWHtoA1h
         wofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741758371; x=1742363171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYzLREHJnRZB4MLC2JrKkCyZzbYuqUOvfim43MDHqyE=;
        b=wr5xmAjr0eER0Lx5Bbu961SvaF0LL+tF5FKY7O2M1U3YfRE6o6JNRtHfxXdOph2jRi
         PUQCv4ilhZ47AwW4brMtDUymB0CU0HjBTmJeYfYtygCt7Podmw3LrjO/XFOt4Ufek46y
         /6pHw06x6j/4F90SBPSFUmBLs8bpKU2KJzG5V2iP9yRgRCcYmr+yfSkV3QXep7YHb10G
         D6G0uMc+SX74jWMFhNM9eajlIyzLEnyCerr/370UunNqyQU9H5lyzeTdrgHhzVKdsMOS
         vf5p/U6CgHBGacknMLemRRsONVAvMev0yykEaM5DKLbYVqqJEgsg1qA8g81xOQo0IIVh
         U93Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdiLNs6Q+7PXx4zicncaumM06Ek7MChX7w4g+kMSF4XYt68ZX9trzv954P/vASNrQeYwFLQRZkZ8w1@vger.kernel.org, AJvYcCXej9U/5eHqzjE+b9fT4PgNXaKbWMA6sefEnER55Ry4bm+lsAcqYKswSGPIbSk15kYoslG16pAt6h4d@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkUdVXDH0IigARvlKD8TLNkKvhCvOfUeP4igxMVfRCBIAI6Yp
	ecS749oKA2j4yDLL3SCM/tHkGuw/s6WSk81WGfAabRgmfZhhQYkF
X-Gm-Gg: ASbGncuSrBOagaMSpGWIumWKEszigQph7E87DurE0S4l5qRi/B+XyetaCv8M75cGCxk
	3uwdeDKkPwB1921v9xnTac9fbq9OuE7d/W13H/H1DbG6tDjnNjD8PWBxnlspP37GaFHDP9dBxG8
	ja2GIM/EjE03/X52YcI5NDxmuiFGm62fvBhdfqikTXJIsph5HazOHdBJ32bcjJelgIwC20+NQNK
	HD2bz1IcO949QrqsA7jqB0h8RgMolrqcmtQ54oykTPGj/v2G+Ck/eLMMFhOO1gZs8Sy34jdW9JD
	JHEvQlHpepmr3IkRzD6CGWjKmKi7PYiusTLDZOfeThJbo6jloBB5n+KFpwIhq/8ejw==
X-Google-Smtp-Source: AGHT+IHmwg+T5NmAx4Y/baHahvr/JD0gIHB98kE1N6Y9gUrduQDQ9DHtIW9eyYKNAQuGsq2GsDTL+A==
X-Received: by 2002:a17:90b:3b86:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-300ff0d4986mr8535354a91.11.1741758370993;
        Tue, 11 Mar 2025 22:46:10 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.39.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109fefa6sm107755715ad.106.2025.03.11.22.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:46:10 -0700 (PDT)
Message-ID: <61e3d66b-7cb0-4392-af96-10c2b011738f@gmail.com>
Date: Wed, 12 Mar 2025 11:16:06 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <20250306174653.GP2803749@frogsfrogsfrogs>
 <716e0d26-7728-42bb-981d-aae89ef50d7f@gmail.com>
 <20250307174045.GR2803749@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250307174045.GR2803749@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/25 23:10, Darrick J. Wong wrote:
> On Fri, Mar 07, 2025 at 11:21:15AM +0530, Nirjhar Roy (IBM) wrote:
>> On 3/6/25 23:16, Darrick J. Wong wrote:
>>> On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
>>>> Silently executing scripts during sourcing common/rc doesn't look good
>>>> and also causes unnecessary script execution. Decouple init_rc() call
>>>> and call init_rc() explicitly where required.
>>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    check           | 10 ++--------
>>>>    common/preamble |  1 +
>>>>    common/rc       |  2 --
>>>>    soak            |  1 +
>>>>    4 files changed, 4 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/check b/check
>>>> index ea92b0d6..d30af1ba 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -840,16 +840,8 @@ function run_section()
>>>>    		_prepare_test_list
>>>>    	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>>>>    		_test_unmount 2> /dev/null
>>>> -		if ! _test_mount
>>>> -		then
>>>> -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>> -			status=1
>>>> -			exit
>>>> -		fi
>>> Unrelated change?  I was expecting a mechanical ". ./common/rc" =>
>>> ". ./common/rc ; init_rc" change in this patch.
>> This patch adds an init_rc() call to _begin_fstests() in common/preamble and
>> hence the above _test_mount() will be executed during that call. So this
>> _test_mount isn't necessary here, right? _test_mount() will be executed (as
>> a part of init_rc() call) before every test run. Please let me know if my
>> understanding isn't correct.
> It's true that in terms of getting the test filesystem mounted, the
> _test_mount here and in init_rc are redundant.  But look at what happens
> on error here -- we print "check: failed to mount..." to signal that the
> new section's TEST_FS_MOUNT_OPTS are not valid, and exit the ./check
> process.
>
> By deferring the mount to the init_rc in _preamble, that means that
> we'll run the whole section with bad mount options, most likely
> resulting in every test spewing "common/rc: could not mount..." and
> appearing to fail.
Aah, right. The exit should be at the check level if some parameter is 
not correct in a section. I will make the change in v2.
>
> I think.  I'm not sure what "status=1; exit" does as compared to
> "exit 1"; AFAICT the former actually results in an exit code of 0
> because the (otherwise pointless) assignment succeeds.

I think "status=0; exit" has a reason. If we see the following trap 
handler registration in the check script:

if $OPTIONS_HAVE_SECTIONS; then
     trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
else
     trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
fi

So, "exit 1" will exit the check script without setting the correct 
return value. I ran with the following local.config file:

[xfs_4k_valid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/test
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

[xfs_4k_invalid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/invalid_dir
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

This caused the init_rc() to catch the case of invalid _test_mount 
options. Although the check script correctly failed during the execution 
of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?" 
returned 0. This is because init_rc exits with "exit 1" without 
correctly setting the value of "status".

However, when I executed with the following local.config file:

[xfs_4k_valid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/test
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

[xfs_4k_invalid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/invalid_dir
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch
TEST_FS_MOUNT_OPTS="-o invalidss"

This caused the "elif [ "$OLD_TEST_FS_MOUNT_OPTS" != 
"$TEST_FS_MOUNT_OPTS" ]; then" to be executed. Now, when I checked the 
value of "echo $?", it showed 1. IMO, this is the correct behavior, and 
we should always use "status=<value>; exit" and NOT "exit 1" directly. 
Even if 1 section fails,   "./check <test-list>" command should return a 
non-zero value. Can you please let me know if my understanding is 
correct? If yes, maybe we can have a function like

_set_status_and_exit()
{

     status="$1"
     exit
}

and replace all the "status <value>; exit" and "exit <value>" with 
"_set_status_and_exit <value>"

--NR


>
> Granted, the init_rc that you remove below would also catch that case
> and exit ./check
Yes. init_rc can catch that case with an additional difference that it 
will attempt another mount "retrying test device mount with external set"
>
>>>>    	fi
>>>> -	init_rc
>>> Why remove init_rc here?
>> Same reason as above.
> But that's an additional change in behavior.  If there's no reason for
> calling init_rc() from run_section() then that should be a separate
> patch with a separate justification.

Since the check for _test_mount should be at the check script level and 
not at the _begin_fstest(), maybe we should

1. Keep the init_rc call here

2. Remove the _test_mount above (the one with "elif [ 
"$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then" ) and have a 
separate patch for it with proper justification.

3. NOT have any init_rc call in _begin_fstest(), since the _test_mount 
related checks would already been done by the time _begin_fstests() gets 
executed.

The above changes will also not change any existing behavior. Can you 
please let me know your thoughts and I can send a V2 accordingly?

--NR

>
> --D
>
>>>> -
>>>>    	seq="check.$$"
>>>>    	check="$RESULT_BASE/check"
>>>> @@ -870,6 +862,8 @@ function run_section()
>>>>    	needwrap=true
>>>>    	if [ ! -z "$SCRATCH_DEV" ]; then
>>>> +		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
>>>> +		[ $? -le 1 ] || exit 1
>>>>    	  _scratch_unmount 2> /dev/null
>>>>    	  # call the overridden mkfs - make sure the FS is built
>>>>    	  # the same as we'll create it later.
>>>> diff --git a/common/preamble b/common/preamble
>>>> index 0c9ee2e0..c92e55bb 100644
>>>> --- a/common/preamble
>>>> +++ b/common/preamble
>>>> @@ -50,6 +50,7 @@ _begin_fstest()
>>>>    	_register_cleanup _cleanup
>>>>    	. ./common/rc
>>>> +	init_rc
>>>>    	# remove previous $seqres.full before test
>>>>    	rm -f $seqres.full $seqres.hints
>>>> diff --git a/common/rc b/common/rc
>>>> index d2de8588..f153ad81 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -5754,8 +5754,6 @@ _require_program() {
>>>>    	_have_program "$1" || _notrun "$tag required"
>>>>    }
>>>> -init_rc
>>>> -
>>>>    ################################################################################
>>>>    # make sure this script returns success
>>>>    /bin/true
>>>> diff --git a/soak b/soak
>>>> index d5c4229a..5734d854 100755
>>>> --- a/soak
>>>> +++ b/soak
>>>> @@ -5,6 +5,7 @@
>>>>    # get standard environment, filters and checks
>>>>    . ./common/rc
>>>> +# ToDo: Do we need an init_rc() here? How is soak used?
>>> I have no idea what soak does and have never used it, but I think for
>>> continuity's sake you should call init_rc here.
>> Okay. I think Dave has suggested removing this file[1]. This doesn't seem to
>> used anymore.
>>
>> [1] https://lore.kernel.org/all/Z8oT_tBYG-a79CjA@dread.disaster.area/
>>
>> --NR
>>
>>> --D
>>>
>>>>    . ./common/filter
>>>>    tmp=/tmp/$$
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


