Return-Path: <linux-ext4+bounces-6106-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A322FA118C0
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 06:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A757B7A3150
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342322F3A2;
	Wed, 15 Jan 2025 05:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcik71Bl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CD2746D;
	Wed, 15 Jan 2025 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917673; cv=none; b=k/URA5Eay21xvCnugsxKBuCzoG/tBX4YHJ1j9ZZpLLqcb5Ztg0umgEN6gfFgjRJWvyKDEtUkiv/0Epkst6EBCH79ZeBU4WUeNL2jp2MwauQJqi1FElMTPNpACHba+5SqSZjsDIfAiBOh+So9k3GepHgpw+R4jjEQklfxdo55KRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917673; c=relaxed/simple;
	bh=JZiVL1dOyHG/aZgrI//uJc5Vaia9VY9uiTlrTi6wPAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pnh644A1a+7IQDADFJllJhw4A5Gm6vc3lT7bXs0l5z0zsED4HhBzmetKGCfbHOHi3TEMMaWyqx73T4DUKtIm6buFmsILjUf8WMf+4BgYb0T2EggrjZNASRYaqduerjJ8lzZRF+ycJCham6Y+M3OF6UOLUsYCMOdSvKifA+IjiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wcik71Bl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so8609257a91.2;
        Tue, 14 Jan 2025 21:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736917671; x=1737522471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJt1Zlx+9tq2zwTyf5i1SF7PChp1qjuCZs4lPsQKuYE=;
        b=Wcik71BleqSSREzqv7xy2ZYnaPFY0/JUxyumPq86GFRNME1/zN9NdmMoIdm5F57HON
         ITqTtaurV0hsvm9/NB2YSK+I4MYcU7TEEe/D155KZZQqNv6FAIfCUCWmNSm1YOJSBBQg
         hCajQc8OVoMqFYDx+MiHLg8lB55liuUwaYJOLMLYZ7VyXVkk5dqz1ZVtLFadpsxywFip
         EfHoRA63O9HbYntqrwV85DVGt71ol7k0B3bMIwvipUGf1zTdDF6+12qoGYJ8F1FK/+XN
         DfYvI39WjQajco0I1rJk8cgM9AvOM+H3Py/RTDFv1HjOLGPpCs+DZc+C/A9OjqwDJokw
         4GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917671; x=1737522471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJt1Zlx+9tq2zwTyf5i1SF7PChp1qjuCZs4lPsQKuYE=;
        b=ndkA69yn+nXZ4ntSxjDIBBMuuVCECG7T6hHLAlfqjXLIc+YCa9RBscYTzdnB9MwqTe
         F9zMs//LYe16f6YAoDJXfbEpHe2Z3fuJ9FNF4xlE7Fip1dWFrNgLzgdtWuE/cWihRHqz
         g47SZJPdXc8F14gOnwTrskEGvnEuYj98xtBq2YSkUO4XFpdNa5KW2hDn5jeIZLpyhcTS
         HNTBB6jfRc0/tgqMNXLFnf7tZ8xUb+6DKWIzrunPR0joy/GlUugt8OH46G67xy+ZmMfa
         5FfdpubCkWvLk1WoLejsb3jniQRrrPJ2GPobTt7Vr+Zq6wmw9aFVZGK9GA7sS5dBYjgq
         pRyg==
X-Forwarded-Encrypted: i=1; AJvYcCUYbBx5/lv8fyUzZ9KwQm7geFnivBYLe4aex3M80oZAtyM9RktRje0QGWGNTFzG/2kM5HnK5BQKaBoo@vger.kernel.org, AJvYcCWOcr0Q1bQD/PrIP3/GqkVD3UmEVnTkbM3HzZtx3Wzx0ol2+wgSKXb1ft+6y2tEZlf6FL5cbY4Hi4SN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5DL/0OH5cPBp+TgZxp27DJ+AwUORbGDveGKTe9evXVWJB0YS
	/qpFOp54llkWYOATocQQsxI2ZWe3M9mN2Yk483vPyR1LJ67HnJU/A69a0Q==
X-Gm-Gg: ASbGncuD2lBX1zmI/vvtqTOE+lGAQhD+5Pasxx6Nyq/BTdCWN0bu+c21k+9b5x508TZ
	UBWHVAMGvxikqjkdvbDPDi2/hFC1V9B8A03XCRRafNTy8+wRg3dMbfZbrjowjn0rweKyzBot0DM
	aJ+KxsqX+HKtihX8voF05L3zHZOicW+DJ0IBufbnDGHJt89NA8Fo8WLMOpXyPPOX9zDkVh+xuXH
	Eppz0kVP54/12noj6ph8hgjJFRQGGvilsbSdS5+qw6lFjsImq/3A2hHQqGRwkFi468=
X-Google-Smtp-Source: AGHT+IGRWzuJme8c6M/XXEB+tVsklzUvNHcQtMjbCjN4b+an9w0pkje+qSVh3HrvCOG2HLHgUnfJxg==
X-Received: by 2002:a17:90b:2dc5:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f548e9862amr36091358a91.5.1736917671285;
        Tue, 14 Jan 2025 21:07:51 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d2dasm75718645ad.172.2025.01.14.21.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:07:50 -0800 (PST)
Message-ID: <9eb05528-be55-42eb-af30-22cdc3dfe550@gmail.com>
Date: Wed, 15 Jan 2025 10:37:46 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
 <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <4afe80a4-ac6b-4796-b466-c42a95f7225a@gmail.com>
 <20250113131103.tb25jtgkepw4xreo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250113131103.tb25jtgkepw4xreo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/13/25 18:41, Zorro Lang wrote:
> On Mon, Jan 13, 2025 at 02:22:20PM +0530, Nirjhar Roy (IBM) wrote:
>> On 1/13/25 11:29, Zorro Lang wrote:
>>> On Sun, Jan 12, 2025 at 03:21:51PM +0000, Nirjhar Roy (IBM) wrote:
>>>> Bug Description:
>>>>
>>>> _test_mount function is failing with the following error:
>>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>>
>>>> when the second section in local.config file is xfs and the first section
>>>> is non-xfs.
>>>>
>>>> It can be easily reproduced with the following local.config file
>>>>
>>>> [s2]
>>>> export FSTYP=ext4
>>>> export TEST_DEV=/dev/loop0
>>>> export TEST_DIR=/mnt1/test
>>>> export SCRATCH_DEV=/dev/loop1
>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>
>>>> [s1]
>>>> export FSTYP=xfs
>>>> export TEST_DEV=/dev/loop0
>>>> export TEST_DIR=/mnt1/test
>>>> export SCRATCH_DEV=/dev/loop1
>>>> export SCRATCH_MNT=/mnt1/scratch
>>>>
>>>> ./check selftest/001
>>>>
>>>> Root cause:
>>>> When _test_mount() is executed for the second section, the FSTYPE has
>>>> already changed but the new fs specific common/$FSTYP has not yet
>>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>>> the test run fails.
>>>>
>>>> Fix:
>>>> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>>>>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    check | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/check b/check
>>>> index 607d2456..8cdbb68f 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -776,6 +776,7 @@ function run_section()
>>>>    	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>>    		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>>>    		_test_unmount 2> /dev/null
>>>> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
>>> The _source_specific_fs is called when importing common/rc file:
>>>
>>>     # check for correct setup and source the $FSTYP specific functions now
>>>     _source_specific_fs $FSTYP
>>>
>>>   From the code logic of check script:
>>>
>>>           if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>                   echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>>                   _test_unmount 2> /dev/null
>>>                   if ! _test_mkfs >$tmp.err 2>&1
>>>                   then
>>>                           echo "our local _test_mkfs routine ..."
>>>                           cat $tmp.err
>>>                           echo "check: failed to mkfs \$TEST_DEV using specified options"
>>>                           status=1
>>>                           exit
>>>                   fi
>>>                   if ! _test_mount
>>>                   then
>>>                           echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>>                           status=1
>>>                           exit
>>>                   fi
>>>                   # TEST_DEV has been recreated, previous FSTYP derived from
>>>                   # TEST_DEV could be changed, source common/rc again with
>>>                   # correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>>>                   . common/rc
>>>                   ^^^^^^^^^^^
>>> we import common/rc at here.
>>>
>>> So I'm wondering if we can move this line upward, to fix the problem you
>>> hit (and don't bring in regression :) Does that help?
>>>
>>> Thanks,
>>> Zorro
>> Okay so we can move ". common/rc" upward and then remove the following from
>> "check" file:
>>
>>          if ! _test_mount
>>          then
>>              echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>              status=1
>>              exit
>>          fi
>>
>> since . common/rc will call init_rc() in the end, which does a
>> _test_mount(). Do you agree with this (Zorro and Ritesh)?
>>
>> I can make the changes and send a v2?
> Hmm... the _init_rc doesn't do _test_mkfs, so you might need to do
> ". common/rc" after "_test_mkfs", rather than "_test_unmount".
Yes, we should place ". common/rc" after, _test_mkfs.
>
> By checking the _init_rc, I think it can replace the _test_mount you metioned
> above. Some details might need more testing, to make sure we didn't miss
> anything wrong:)
Yes, makes sense.
>
> Any review points from others?
>
> Thanks,
> Zorro
>
>> --NR
>>
>>>
>>>>    		if ! _test_mkfs >$tmp.err 2>&1
>>>>    		then
>>>>    			echo "our local _test_mkfs routine ..."
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


