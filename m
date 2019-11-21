Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CD104F0D
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKUJSs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 04:18:48 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39598 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUJSs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Nov 2019 04:18:48 -0500
Received: by mail-il1-f196.google.com with SMTP id a7so2568294ild.6
        for <linux-ext4@vger.kernel.org>; Thu, 21 Nov 2019 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PnVSra4UoARhdb9UWaexbDqv7hjvezA0eH2trxDjt6c=;
        b=j+og/Bu6CiNifl2UtWDcUhKLYw9jh4B7s0JeVw7hXSKF0E1hayw5DVMsbp6Vk9uacN
         AMHFtbCeXFaz0TLSd+lahWZIHXn42iQwvc7ueNOK08N5Jxl4WBiXaqMqAAbgAImz25IE
         rW94q5XkTJTWIDUDic0+YJex2eRrtGSo52L3PH9SCqb8xNyiv9yTT+FMmGCrRQskkctA
         Bagarez2sedn2x5TKI7t7af0b7l7IHzCCg8z90b0i+hrQxP4gxvzVRAA4S5yHvyT4XEX
         JnhZlp5xDSzyVu8cJTch88Lis/nS5tSWxgetVLn2xCTLccHwVpPokqmb/5Q5C1QoQwMx
         nTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PnVSra4UoARhdb9UWaexbDqv7hjvezA0eH2trxDjt6c=;
        b=Re388vmoG8HREtgX8v2fwG27osySctG7qKyxbQiJ0C/M1AggAtu5tyVSgpfvVVeqn6
         oM//AbXd9c4iTcpZROsoPbDBm+ikuS26HpORysIy9o94wzGUdSafx+43FpHEgo7vTKN/
         0TKzNRCoyhn9dNx03dxd6ZUhh3ZnUHJoBaW9Wh6PzhOmSVSKif7yH6us1a/Om4yrKZaq
         7CAD/QZMmjVzZ5HU6K2PxINnKBg3+yzHxCLp1w4Xp0uswjvb/GdIvn72KltvvmL6KqAK
         AQcW3sFN4O+8BwLrxzcX3rKgv41MzHOtjzf9lzEvnQYYDGvT0WV1hlfVW2IGDCjRy5kl
         L5Hg==
X-Gm-Message-State: APjAAAXGYa6yGiiLHZhx3xUCQ7HvUN4YIxChYEj9frJYXTuZ5DF70clk
        KLxLULKDDnQBQqhAE/tIbDA=
X-Google-Smtp-Source: APXvYqzo3u7lg8KWJ+n6HT78qOqUXUDsypO5CoSGlS9wdPtvE8jOxYyDjj2UyQyDtIJOwDILAJvLMw==
X-Received: by 2002:a92:ce06:: with SMTP id b6mr8556004ilo.14.1574327927146;
        Thu, 21 Nov 2019 01:18:47 -0800 (PST)
Received: from [192.168.64.38] (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id d8sm845000ilr.82.2019.11.21.01.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 01:18:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] improve malloc for large filesystems
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
In-Reply-To: <9114E776-B44E-4CA5-BD49-C432A688C24E@whamcloud.com>
Date:   Thu, 21 Nov 2019 12:18:42 +0300
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43DA6456-AAF9-4225-A79F-CF632AC5241B@gmail.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
 <9E04C147-D878-45CE-8473-EF8C67FE4E86@whamcloud.com>
 <4EB2303A-01A3-49AC-B713-195126DB621B@gmail.com>
 <9114E776-B44E-4CA5-BD49-C432A688C24E@whamcloud.com>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


> On 21 Nov 2019, at 11:52, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>=20
>=20
>=20
>> On 21 Nov 2019, at 11:30, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>>=20
>> Hello Alex,
>>=20
>> Code looks good, but I have objections about the approach.
>>=20
>> 512TB disk with 4k block size have 4194304 groups. So 4k groups is =
only ~0.01% of whole disk.
>> Can we make decision to break search and get minimum blocks based on =
such limited data.
>> I am not sure that spending some time to find good group is worse =
then allocate blocks without=20
>> optimisation. Especially, if disk is quite free and there are a lot =
of free block groups.
>=20
> Exact number isn=E2=80=99t hardcoded and subject to discussion, but =
you don=E2=80=99t really want to scan 4M=20
> groups (especially uninitialised) to find =E2=80=9Cbest=E2=80=9D =
chunk.
>=20

Then it looks reasonable to make it disabled by default (set 0, that =
means =E2=80=9Cdo not limit=E2=80=9D) and enable it by passing number to =
attribute.

> This can be optimized further like =E2=80=9Cdon=E2=80=99t count =
initialized and/or empty groups=E2=80=9D, but still some limit
> Is required, IMO. Notice this limit doesn=E2=80=99t apply if once we =
tried to find =E2=80=9Cbest=E2=80=9D, i.e. it=E2=80=99s applied only
> with cr=3D0 and cr=3D1.

cr=3D0 and cr=3D1 are also important. They allow to accelerate =
allocator, by increasing allocation window.
Step by step from smallest to the biggest value in preallocation table.
Your optimisation can reset this allocation window grow.

Assume we have one fragmented part of disk and all other parts are quite =
free.
Allocator will spend a lot of time to go through this fragmented part, =
because  will brake cr0 and cr1 and get
range that satisfy c3.=20

c3 requirement is quite simple =E2=80=9Cget first group that have enough =
free blocks to allocate requested range=E2=80=9D.
With hight probability allocator find such group at the start of c3 =
loop, so goal (allocator starts its searching from goal) will not =
significantly changed.
Thus allocator go through this fragmented range using small steps.

Without suggested optimisation, allocator skips this fragmented range at =
moment and continue to allocate blocks.

Best regards,
Artem Blagodarenko.

>=20
> Thanks, Alex
>=20
>>=20
>> Best regards,
>> Artem Blagodarenko.
>>> On 21 Nov 2019, at 10:03, Alex Zhuravlev <azhuravlev@whamcloud.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On 20 Nov 2019, at 21:13, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>>>=20
>>>> Hi Alex,
>>>>=20
>>>> A couple of comments.  First, please separate this patch so that =
these
>>>> two separate pieces of functionality can be reviewed and tested
>>>> separately:
>>>>=20
>>>=20
>>> This is the first patch of the series.
>>>=20
>>> Thanks, Alex
>>>=20
>>> =46rom 81c4b3b5a17d94525bbc6d2d89b20f6618b05bc6 Mon Sep 17 00:00:00 =
2001
>>> From: Alex Zhuravlev <bzzz@whamcloud.com>
>>> Date: Thu, 21 Nov 2019 09:53:13 +0300
>>> Subject: [PATCH 1/2] ext4: limit scanning for a good group
>>>=20
>>> at first two rounds to prevent situation when 10x-100x thousand
>>> of groups are scanned, especially non-initialized groups.
>>>=20
>>> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
>>> ---
>>> fs/ext4/ext4.h    |  2 ++
>>> fs/ext4/mballoc.c | 14 ++++++++++++--
>>> fs/ext4/sysfs.c   |  4 ++++
>>> 3 files changed, 18 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>> index 03db3e71676c..d4e47fdad87c 100644
>>> --- a/fs/ext4/ext4.h
>>> +++ b/fs/ext4/ext4.h
>>> @@ -1480,6 +1480,8 @@ struct ext4_sb_info {
>>> 	/* where last allocation was done - for stream allocation */
>>> 	unsigned long s_mb_last_group;
>>> 	unsigned long s_mb_last_start;
>>> +	unsigned int s_mb_toscan0;
>>> +	unsigned int s_mb_toscan1;
>>>=20
>>> 	/* stats for buddy allocator */
>>> 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index a3e2767bdf2f..cebd7d8df0b8 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -2098,7 +2098,7 @@ static int ext4_mb_good_group(struct =
ext4_allocation_context *ac,
>>> static noinline_for_stack int
>>> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>> {
>>> -	ext4_group_t ngroups, group, i;
>>> +	ext4_group_t ngroups, toscan, group, i;
>>> 	int cr;
>>> 	int err =3D 0, first_err =3D 0;
>>> 	struct ext4_sb_info *sbi;
>>> @@ -2169,7 +2169,15 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
>>> 		 */
>>> 		group =3D ac->ac_g_ex.fe_group;
>>>=20
>>> -		for (i =3D 0; i < ngroups; group++, i++) {
>>> +		/* limit number of groups to scan at the first two =
rounds
>>> +		 * when we hope to find something really good */
>>> +		toscan =3D ngroups;
>>> +		if (cr =3D=3D 0)
>>> +			toscan =3D sbi->s_mb_toscan0;
>>> +		else if (cr =3D=3D 1)
>>> +			toscan =3D sbi->s_mb_toscan1;
>>> +
>>> +		for (i =3D 0; i < toscan; group++, i++) {
>>> 			int ret =3D 0;
>>> 			cond_resched();
>>> 			/*
>>> @@ -2872,6 +2880,8 @@ void ext4_process_freed_data(struct =
super_block *sb, tid_t commit_tid)
>>> 			bio_put(discard_bio);
>>> 		}
>>> 	}
>>> +	sbi->s_mb_toscan0 =3D 1024;
>>> +	sbi->s_mb_toscan1 =3D 4096;
>>>=20
>>> 	list_for_each_entry_safe(entry, tmp, &freed_data_list, efd_list)
>>> 		ext4_free_data_in_buddy(sb, entry);
>>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>>> index eb1efad0e20a..c96ee20f5487 100644
>>> --- a/fs/ext4/sysfs.c
>>> +++ b/fs/ext4/sysfs.c
>>> @@ -198,6 +198,8 @@ EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
>>> EXT4_ATTR(first_error_time, 0444, first_error_time);
>>> EXT4_ATTR(last_error_time, 0444, last_error_time);
>>> EXT4_ATTR(journal_task, 0444, journal_task);
>>> +EXT4_RW_ATTR_SBI_UI(mb_toscan0, s_mb_toscan0);
>>> +EXT4_RW_ATTR_SBI_UI(mb_toscan1, s_mb_toscan1);
>>>=20
>>> static unsigned int old_bump_val =3D 128;
>>> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, =
&old_bump_val);
>>> @@ -228,6 +230,8 @@ static struct attribute *ext4_attrs[] =3D {
>>> 	ATTR_LIST(first_error_time),
>>> 	ATTR_LIST(last_error_time),
>>> 	ATTR_LIST(journal_task),
>>> +	ATTR_LIST(mb_toscan0),
>>> +	ATTR_LIST(mb_toscan1),
>>> 	NULL,
>>> };
>>> ATTRIBUTE_GROUPS(ext4);
>>> --=20
>>> 2.20.1
>>>=20
>>>=20
>>=20
>=20

