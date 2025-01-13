Return-Path: <linux-ext4+bounces-6062-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59401A0BCA4
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 16:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084F01885990
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60420AF64;
	Mon, 13 Jan 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELPKPY6c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19D25760;
	Mon, 13 Jan 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783556; cv=none; b=cZRC6FpA+712235IEc7qiaFc7WTGWrQ/7ELql3Kg63JMj8tlwYhfX4LriRp5Zsd9kZMBwaWBow8NJvf2W9JMJOFqYFuGGbep1IBjMNJIWIK7WzahPb+93/6WFjwKk2rREpiPHYThm+b9f95N8gKDgQrWjB/sRgaYuuj24YG9Pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783556; c=relaxed/simple;
	bh=KQGBGhXeAKerB/ZmQg6V+0zu677PPyFeiNo7a0yTUyo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=qoLxjKEu+qH4TEpqn3OfUK8kd9wbB+LW6iNt8mKeAeIFMiZk3989iH9XYF422F5/TJK8Up88/KLIYcPROVA3v3dN1mevqxFpqtmxJhLoisxmZ+adym5jYyrPETL8pF2Nlv19h2Uqy2sTG7LExsfrA0caUTZ6wxvQ+0AOA+7nSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELPKPY6c; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so6693238a91.0;
        Mon, 13 Jan 2025 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736783554; x=1737388354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1y/odhV1Y5lkits40FYXBT8gxSpQl7u3UnS0bDayd4=;
        b=ELPKPY6cPh4hwRcRP620Sl3pFaKXhh97lRUjxzjs+CxUvdiAtSei7SaqTH9DCqYMGa
         h08pkWpnyZF7BVxTYtc38U7zRdBMOsPDoEYCIlAof2Vd1F9DUSuecmhVIdU2MeXkQTtc
         j1+jeXFwqK0VHLXO+706YDZ7Bq+hWmKIzPEf1a/RsAy/A+eEzWkQs6r4KNxubqWZtmeA
         4fDDD9N9ypsnEQUtoZZgJ4fhbmjvMON5zRRSmC9qOch3/TQq/Y8/WmthyllYMC1l2WDB
         Ag9hzCzMiGeZ21/jXN3HUOWMBrnF5pbImSA28DA5MRsDJNIwAuC0hJavXXHA1Piy8Vtf
         5ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783554; x=1737388354;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1y/odhV1Y5lkits40FYXBT8gxSpQl7u3UnS0bDayd4=;
        b=naZBrmn1uTIplA5a3cKyCGKRLXgKCpqDJvWrrg/So7h6rwHSju75AKx0xAlojZsKNN
         2nobr5GXu4a3PiR8a0wcjwRwU0Z3FGIiYvLzix+KkoWIQ6sA4ZG077zSe+/drKuPLdNS
         0xDCBhGJvok9Gue/FXkoMvn8tY5Fkdw7W/IqiJB2bqXiiftvW+uHMUfxL3T1dpJV0LHH
         l7TOjIZ3aT3n3Favdb8OlGBbAz2B9CPGqMXl0nIGgMFbcxVbaiUu4SfdrWOgRmUImIxm
         /heuCgSbvuFHZ3BzvDhFj8DcppAN9rHYoclyoS69mHFBAzjDoWEbbHpEgX4Z3t3dQJ30
         a2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUEOPnsoFrX1Ol6ITEkvaoV9uaG+hvjXzv3w9Pfb4wNUgGWsRzuLCYRnrerChVPomozoi3tSbYi@vger.kernel.org, AJvYcCULPtjFuYBOedpdiPwEKeaHGZr37H7HkrZdM6+PWHPsdxIb5UyQrcKFIA61sPFZ0YU1cSqxCEuDISYW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SuyMrkWluJWPAElce8VhOdqF+TO+XPk7FZRc2kJOhJUi94JQ
	Jw+NVugqJ6ZIDoc+dwTqBeeOBcAB/DqcebRLAcCC78Jueh0ynHaw
X-Gm-Gg: ASbGncvqi6P8orVz4vn6DeA4q5sqNISx6LZQGYNRDzm0o5nd5ttWZqaB+alt2gdP5qp
	uqDx4VUSbADbRN7iUIawY2zsEvCaXicPmK/80meWvMiCsFIBsi5UusEey3TyLz8XU3qjBLbLdaS
	jGb18PH5iDXQTs5pok6gN1UxEfTV1+ERt5vYLF0TgkEXXvC592OaMjiO5CC7sqj+kvMLa4u4rU/
	axp9IJHri5PxHApvgfCuJL+52haw17ydktOkXaKcN7n5mEM
X-Google-Smtp-Source: AGHT+IGW8l3L8k3osuE/8UXobQu34qaX1xn0uWWszgfA0WkU3z5kQmcC4M1bch7vpBmQqHIbM1nkYA==
X-Received: by 2002:a17:90b:3b4f:b0:2f2:a974:fc11 with SMTP id 98e67ed59e1d1-2f554603e39mr25755060a91.17.1736783552681;
        Mon, 13 Jan 2025 07:52:32 -0800 (PST)
Received: from dw-tp ([171.76.81.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad2basm10214702a91.24.2025.01.13.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:52:31 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
In-Reply-To: <1efecce4-f051-40fc-8851-e9f9c057e844@gmail.com>
Date: Mon, 13 Jan 2025 21:09:37 +0530
Message-ID: <87frlmvi2u.fsf@gmail.com>
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com> <87jzazvmzh.fsf@gmail.com> <1efecce4-f051-40fc-8851-e9f9c057e844@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> On 1/13/25 01:11, Ritesh Harjani (IBM) wrote:
>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>>
>>> Bug Description:
>>>
>>> _test_mount function is failing with the following error:
>>> ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found

Please notice the error that you are seeing here ^^^ 

>>> check: failed to mount /dev/loop0 on /mnt1/test
>>>
>>> when the second section in local.config file is xfs and the first section
>>> is non-xfs.
>>>
>>> It can be easily reproduced with the following local.config file
>>>
>>> [s2]
>>> export FSTYP=ext4
>>> export TEST_DEV=/dev/loop0
>>> export TEST_DIR=/mnt1/test
>>> export SCRATCH_DEV=/dev/loop1
>>> export SCRATCH_MNT=/mnt1/scratch
>>>
>>> [s1]
>>> export FSTYP=xfs
>>> export TEST_DEV=/dev/loop0
>>> export TEST_DIR=/mnt1/test
>>> export SCRATCH_DEV=/dev/loop1
>>> export SCRATCH_MNT=/mnt1/scratch
>>>
>>> ./check selftest/001
>>>
>>> Root cause:
>>> When _test_mount() is executed for the second section, the FSTYPE has
>>> already changed but the new fs specific common/$FSTYP has not yet
>>> been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>>> the test run fails.
>>>
>>> Fix:
>>> call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>> You should add the Fixes: tag too. Based on your description I guess
>> this should be the tag?
>>
>> Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")

Please look into the above commit. The above patch introduced function
"_prepare_for_eio_shutdown()" in _test_mount(), which is what we are
getting the error for (for XFS i.e. _xfs_prepare_for_eio_shutdown()
command not found). Right? 

Ok, why don't revert the above commit and see if the revert fixes the
issue for you. 

https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

-ritesh

>
> Shouldn't this be the following?
>
> commit f8e4f532f18d7517430d9849bfc042305d7f7f4d (HEAD)
> Author: Lukas Czerner <lczerner@redhat.com>
> Date:   Fri Apr 4 17:18:15 2014 +1100
>
>      check: Allow to recreate TEST_DEV
>
>      Add config option RECREATE_TEST_DEV to allow to recreate file system on
>      the TEST_DEV device. Permitted values are true and false.
>
>      If RECREATE_TEST_DEV is set to true the TEST_DEV device will be
>      unmounted and FSTYP file system will be created on it. Afterwards it
>      will be mounted to TEST_DIR again with the default, or specified mount
>      options.
>
>      Also recreate the file system if FSTYP differs from the previous
>      section.
>
>>
>> I agree with today the problem was in _test_mount(), tomorrow it could
>> be _test_mkfs, hence we could source the new FSTYP config file before
>> calling _test_mkfs().
>>
>> With the fixes tag added, please feel free to add:
>>
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>
>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>> ---
>>>   check | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/check b/check
>>> index 607d2456..8cdbb68f 100755
>>> --- a/check
>>> +++ b/check
>>> @@ -776,6 +776,7 @@ function run_section()
>>>   	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>>>   		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>>>   		_test_unmount 2> /dev/null
>>> +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
>>>   		if ! _test_mkfs >$tmp.err 2>&1
>>>   		then
>>>   			echo "our local _test_mkfs routine ..."
>>> -- 
>>> 2.34.1
>
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore

