Return-Path: <linux-ext4+bounces-6061-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EBA0BC37
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 16:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1237B1632F6
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A91FBBDE;
	Mon, 13 Jan 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlkYCRiv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FD29D19;
	Mon, 13 Jan 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782704; cv=none; b=QsL3kgQ72SDHZRVXfgWwf9jCsngomw/Ya0TBb82tOOBaE6r+XcKpB+MtIzKNdRbT0+YRF14UvGNm7IjVaSZVXoDL7UB8jwIXkbeoGUNQ8PTCayuQ99jZqqE21tY/FIzesxmxNJHqpfzoTF5OnuLab+uEha9FfuzaOr3iKPFNLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782704; c=relaxed/simple;
	bh=HS64Zf+ACDVGxpAALcWpS2MM6ZlxtcSEpMPFd07xJD0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=uAB7FnHBKkvgQKlqmeOG//HVtuXUfOe+04OQwmQq89OX4iYJ/Vif7KMi9Q1BkHZHCGA1uRWEzb/N781CTFaQua554ClN5VihN/1aStKHyBbmdumn7KMM05DOiDqwo6aPoe2K5rGohDLlqqblROvJU/RFPXQfbxkzH841E0PDfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlkYCRiv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21675fd60feso101255545ad.2;
        Mon, 13 Jan 2025 07:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736782702; x=1737387502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVDj5BSvw68HHe0mdJojZFhAGNqs9BvOt2kbeI/tfZg=;
        b=IlkYCRiv0NEygqg8JhrSyiOCeqWzYgDlC3TMtYd+wIH9wm/Un0Zxk2UR+PkmS1CL0/
         hmLcYtT7RT9q0+m744PTnkki2OOLmory0fUXGxaaaMMxglgXm0rYfALkstzv/i+vZhd7
         a+2RvMtrikFBNfsU+e5g2+0avINuFLSiHj4XdmIQPOOKXTsmMmBgdgtosMbcZADLVHpU
         8wLrA+L4AXjNiAY2RZx4pZLO0ZwnbFx8j6UQUWMUso/uCCQK7VXBcEvTq0D4Q9D1FTqC
         z09jav55eTdg+ZgaBu3WrELZ0Ld8yZIhjlrXHRQN2/KNVcss6WTuFNOBgTee+qGUTLiJ
         qDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782702; x=1737387502;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVDj5BSvw68HHe0mdJojZFhAGNqs9BvOt2kbeI/tfZg=;
        b=TOI5dbowkgKGh5TPHbdNbf02ccz3xYaOouMHCidOl4TkCbofvUlTfUkutVnJksF3T0
         NIXHhmIN3YI/oRyFRZ1O93nxlSI+v0Aai/6uzsDFfdM0xXdBqrgH6kZYlUAsAKg6ESzZ
         erZa+nWaYA1BnK8KenqFqEv930259TYILo2HVHRMQ7lhx8TFf1iHgQrntgTdehsl1OYw
         znT91QQSjsPk3gxuJ3fNe5zMy7lS9JG0wYDlA5PkQLeovWMt6Ypj8TaVpzmiPRgR47q3
         GAqrrznNgEoDyKArFMgYzuBAB/FmhCo/s3KqVHU2ycvajOyuTl9HUhym9UIYSmqSmdUI
         rl7A==
X-Forwarded-Encrypted: i=1; AJvYcCV0S36hwVH0Pv71tbFh9uRDAuCIjj33g0HoD4O/ki+Xu/HX5SHCmi7G9qb/nT+oeVqPyTvgAUT2tx/d@vger.kernel.org, AJvYcCWx2I9hDktr9AebBwX0wYyOqi4c7zMaj2AZfbBhYPzFuUHN+mLX6eNpdkrl8+aiVJrPe9RID7UsujOT@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGbhzydLLUPavNs9dkmHgv1pQ1bIzXym7yIDeUNINI2HH6hyd
	VZuRcc+H0n5bY3XzYkP9w6mWTFrIKxJOwZgLWaQPjGMb/eD0Yk0t
X-Gm-Gg: ASbGncsAwjwxaMFAHpKgBj5dvpkEsAYE4l5A9d9la3WOCQUHF6DsP6hXtJH3KXEs0/Z
	s0+29JxsWcMSjbpTGo4UOEpCqJeSdUlTzNcpS4uNkZn/UoFEh4fKXAcop9MxD7bzvMt+TFDxThj
	72ij+Jgw0s4UBdYBW4nL6rqC8XYpQSrzgTfqUfh8eY72CVUXHnuMzieb64s4CgO2/RE3MdeeePU
	IMqeoGE+NneQK+BD40/5ksUTHNb5E9QRgCtjW2MMEb7f2Iu
X-Google-Smtp-Source: AGHT+IFb4E9ACs+TO6NMybuXbjXDkpOYeR4AHUYtBzAUA4g6bjcP84o9+VVcgMDbGmo9nWnDFcQ7ZQ==
X-Received: by 2002:a05:6a00:92a3:b0:725:eb85:f7ef with SMTP id d2e1a72fcca58-72d21f5066dmr29921007b3a.14.1736782702349;
        Mon, 13 Jan 2025 07:38:22 -0800 (PST)
Received: from dw-tp ([171.76.81.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405491b8sm6036336b3a.9.2025.01.13.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:38:21 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zorro Lang <zlang@redhat.com>, "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
In-Reply-To: <20250113131103.tb25jtgkepw4xreo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Mon, 13 Jan 2025 21:03:49 +0530
Message-ID: <87h662vici.fsf@gmail.com>
References: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com> <20250113055901.u5e5ghzi3t45hdha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <4afe80a4-ac6b-4796-b466-c42a95f7225a@gmail.com> <20250113131103.tb25jtgkepw4xreo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Zorro Lang <zlang@redhat.com> writes:

> On Mon, Jan 13, 2025 at 02:22:20PM +0530, Nirjhar Roy (IBM) wrote:
>> 
>> On 1/13/25 11:29, Zorro Lang wrote:
>> > On Sun, Jan 12, 2025 at 03:21:51PM +0000, Nirjhar Roy (IBM) wrote:
>> > > Bug Description:
>> > > 
>> > > _test_mount function is failing with the following error:
>> > > ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
>> > > check: failed to mount /dev/loop0 on /mnt1/test
>> > > 
>> > > when the second section in local.config file is xfs and the first section
>> > > is non-xfs.
>> > > 
>> > > It can be easily reproduced with the following local.config file
>> > > 
>> > > [s2]
>> > > export FSTYP=ext4
>> > > export TEST_DEV=/dev/loop0
>> > > export TEST_DIR=/mnt1/test
>> > > export SCRATCH_DEV=/dev/loop1
>> > > export SCRATCH_MNT=/mnt1/scratch
>> > > 
>> > > [s1]
>> > > export FSTYP=xfs
>> > > export TEST_DEV=/dev/loop0
>> > > export TEST_DIR=/mnt1/test
>> > > export SCRATCH_DEV=/dev/loop1
>> > > export SCRATCH_MNT=/mnt1/scratch
>> > > 
>> > > ./check selftest/001
>> > > 
>> > > Root cause:
>> > > When _test_mount() is executed for the second section, the FSTYPE has
>> > > already changed but the new fs specific common/$FSTYP has not yet
>> > > been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
>> > > the test run fails.
>> > > 
>> > > Fix:
>> > > call _source_specific_fs $FSTYP at the correct call site of  _test_mount()
>> > > 
>> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> > > ---
>> > >   check | 1 +
>> > >   1 file changed, 1 insertion(+)
>> > > 
>> > > diff --git a/check b/check
>> > > index 607d2456..8cdbb68f 100755
>> > > --- a/check
>> > > +++ b/check
>> > > @@ -776,6 +776,7 @@ function run_section()
>> > >   	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>> > >   		echo "RECREATING    -- $FSTYP on $TEST_DEV"
>> > >   		_test_unmount 2> /dev/null
>> > > +		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
>> > The _source_specific_fs is called when importing common/rc file:
>> > 
>> >    # check for correct setup and source the $FSTYP specific functions now
>> >    _source_specific_fs $FSTYP
>> > 
>> >  From the code logic of check script:
>> > 
>> >          if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>> >                  echo "RECREATING    -- $FSTYP on $TEST_DEV"
>> >                  _test_unmount 2> /dev/null
>> >                  if ! _test_mkfs >$tmp.err 2>&1
>> >                  then
>> >                          echo "our local _test_mkfs routine ..."
>> >                          cat $tmp.err
>> >                          echo "check: failed to mkfs \$TEST_DEV using specified options"
>> >                          status=1
>> >                          exit
>> >                  fi
>> >                  if ! _test_mount
>> >                  then
>> >                          echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>> >                          status=1
>> >                          exit
>> >                  fi
>> >                  # TEST_DEV has been recreated, previous FSTYP derived from
>> >                  # TEST_DEV could be changed, source common/rc again with
>> >                  # correct FSTYP to get FSTYP specific configs, e.g. common/xfs
>> >                  . common/rc
>> >                  ^^^^^^^^^^^
>> > we import common/rc at here.
>> > 
>> > So I'm wondering if we can move this line upward, to fix the problem you
>> > hit (and don't bring in regression :) Does that help?
>> > 
>> > Thanks,
>> > Zorro
>> 
>> Okay so we can move ". common/rc" upward and then remove the following from
>> "check" file:
>> 
>>         if ! _test_mount
>>         then
>>             echo "check: failed to mount $TEST_DEV on $TEST_DIR"
>>             status=1
>>             exit
>>         fi
>> 
>> since . common/rc will call init_rc() in the end, which does a
>> _test_mount(). Do you agree with this (Zorro and Ritesh)?
>> 
>> I can make the changes and send a v2?
>
> Hmm... the _init_rc doesn't do _test_mkfs,

Yes, I had noticed that problem. So I felt sourcing fs specific file
before _test_mkfs should be ok.

> so you might need to do ". common/rc" after "_test_mkfs", rather than "_test_unmount".
>
> By checking the _init_rc, I think it can replace the _test_mount you metioned
> above. Some details might need more testing, to make sure we didn't miss
> anything wrong:)

If moving . common/rc above _test_mount works, than that is a better
approach than sourcing fs specific config file twice.


-ritesh

>
> Any review points from others?
>
> Thanks,
> Zorro
>
>> 
>> --NR
>> 
>> > 
>> > 
>> > >   		if ! _test_mkfs >$tmp.err 2>&1
>> > >   		then
>> > >   			echo "our local _test_mkfs routine ..."
>> > > -- 
>> > > 2.34.1
>> > > 
>> > > 
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>> 

