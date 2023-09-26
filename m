Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0847AF408
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Sep 2023 21:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjIZTTg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Sep 2023 15:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjIZTTf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Sep 2023 15:19:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B192
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 12:19:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2773f776f49so4204000a91.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695755966; x=1696360766; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6f3dB4xPWzTQEI38vrGfw0/NLINXDoSFgEYeInhAGc=;
        b=uRRPuF12HjLXP//Fm6IDjLtV8TGOVaoRnoSn7EEPY4Du7ACrwiEMjxVkJbdIycVHr3
         9Vu3zBs0EAag/3pK8XfknNScrDoX+X0y6MCtP2KU8VX6llltNBaNjbKdPIRqq2i1gKiI
         A5XVE6yxDDmkNkKJNMBLPFpyJKZug9MLwp7zT4gj6+UtzfL+RI2q7TPSi3VeOLi7S1zM
         Q35OqhuzAb736V5c9wOsU30CoY/WtWjjaxZSpqoZl/FjdaGIkhEIZqyStQRigs9O0V66
         r197X1Pcn0cnSoEEUfApGxB4D+hvEMV3f9Xu9gEZWGvmBGiUJ4GKp8Qr1HSC9DmGNVid
         kBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755966; x=1696360766;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6f3dB4xPWzTQEI38vrGfw0/NLINXDoSFgEYeInhAGc=;
        b=LrCxdnvNPHkXkrfQNTBPLquK6FQVdJM+DDEwOpnGPWv2BkMx337+hohgYOC8fDA4lg
         UWAyJKy1sZGAvnUnqVOBk+vSznpk7CoXCN5MoCbQc9wNStipCTsBkBsxLwQr1PQHhKzD
         mviyaB9ttOYEEye1r1paZfuoTlTiK40fA5OFtuH0KotddEGYhHO/2bw78EqH1AdfxrS5
         o+pr9yhM0bZ+UrjT2nUxWg9LCaiUegzB3sVvy8zZfU1fSh3PU/17/0BAMFkbIwUlBqJz
         t/trLD3/1sbh86fPDp+C4oFZW94n12lpuO84Ve6BCEoRXCiN5qpP2fdPpBNl9Ls/xH3g
         76Lw==
X-Gm-Message-State: AOJu0YxGv7CRZePNT0TSXUxOppiKJdQVQBRmlgb3xgVtxXlyk6TzOuJj
        TSvgxTXiipDk7Qtp5lIk/P9zdA==
X-Google-Smtp-Source: AGHT+IEi/HsN5jcWgKacgqGHo5kLFX8V2eydY/SPfb4LRAL1H77pDm7yosBEVQKW1LW7MMMq7qFT3A==
X-Received: by 2002:a17:90b:1e4e:b0:276:6be8:8bfe with SMTP id pi14-20020a17090b1e4e00b002766be88bfemr5485872pjb.23.1695755966529;
        Tue, 26 Sep 2023 12:19:26 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0026971450601sm10284180pjb.7.2023.09.26.12.19.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:19:25 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A97D434D-8276-42D4-8402-4BA38B504D4F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5D9B53D5-298C-4289-BA0D-5F1E38DF933F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
Date:   Tue, 26 Sep 2023 13:19:22 -0600
In-Reply-To: <87msx961zm.fsf@doe.com>
Cc:     Bobi Jam <bobijam@hotmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
References: <87msx961zm.fsf@doe.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5D9B53D5-298C-4289-BA0D-5F1E38DF933F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 25, 2023, at 9:35 PM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Andreas Dilger <adilger@dilger.ca> writes:
>=20
>> On Sep 19, 2023, at 11:39 PM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>>>=20
>>> Bobi Jam <bobijam@hotmail.com> writes:
>>>=20
>>>> Non-metadata block allocation does not allocate from the IOPS =
groups
>>>> if non-IOPS groups are not used up.
>>>=20
>>>> Add for mke2fs an option to mark which blocks are in the IOPS =
region
>>>> of storage at format time:
>>>>=20
>>>> -E iops=3D0-1024G,4096-8192G
>>>>=20
>>>> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
>>>> group descriptors to decide which groups to allocate dynamic
>>>> filesystem metadata.
>>>>=20
>>>> Signed-off-by: Bobi Jam <bobijam@hotmail.com
>>>>=20
>>>> --
>>>> v2->v3: add sysfs mb_enable_iops_data to enable data block =
allocation
>>>>       from IOPS groups.
>>>> v1->v2: for metadata block allocation, search in IOPS list then =
normal
>>>>       list.
>>>> ---
>>>>=20
>=20
>>>> @@ -1009,11 +1108,37 @@ static void =
ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>>>> 		return;
>>>> 	}
>>>>=20
>>>> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) =
{
>>>> +		if (*new_cr =3D=3D 0)
>>>> +			ret =3D ext4_mb_choose_next_iops_group_cr0(ac, =
group);
>>>> +		if (!ret && *new_cr < 2)
>>>> +			ret =3D ext4_mb_choose_next_iops_group_cr1(ac, =
group);
>>=20
>> It looks like this patch is a bit stale since Ojaswin's renaming of =
the
>> cr0/cr1 phases to "p2_aligned" and "goal_fast" and "best_avail" =
names.
>>=20
>=20
> Yup. We should rebase our development effort to latest tree.
>=20
>>> This is a bit confusing here. Say if *new_cr =3D 0 fails, then we =
return
>>> ret =3D false and fallback to choosing xx_iops_group_cr1(). And say =
if we
>>> were able to find a group which satisfies this allocation request we
>>> return. But the caller never knows that we allocated using cr1 and =
not
>>> cr0. Because we never updated *new_cr inside xx_iops_group_crX()
>>=20
>> I guess it is a bit messy, since updating new_cr might interfere with =
the
>> use of new_cr in the fallthrough to the non-IOPS groups below? In the
>> "1% IOPS groups" case, doing this extra scan for metadata blocks =
should
>> be very fast, since the metadata allocations are almost always one =
block
>> (excluding large xattrs), so the only time this would fail is if no =
IOPS
>> blocks are free, in which case it is fast since the group lists are =
empty.
>>=20
>=20
> What I was suggesting was we never update *new_cr value when we were
> able to find a suitable group. That will confuse the two for loops we
> have in the caller. We might as well just update the *new_cr value =
once
> we have identified a suitable group in cr0 or cr1 before returning.
>=20
>> We _could_ have a separate (in effect) cr0_3 and cr0_6 phases before =
the
>> non-IOPS group allocation starts to be able to distinguish these =
cases
>> (i.e. skip IOPS group scans if they are full) and the fallthrough =
search
>> is also having trouble to find a single free block for the metadata, =
but
>> I think that is pretty unlikely.

I'm not clear which option you prefer here?
- update *new_cr based on the scan in the IOPS groups (in which case the
  fallback to non-IOPS groups would start at a higher CR than necessary)
- add new phases *before* CR_POWER2_ALIGNED, e.g. =
"CR_IOPS_POWER2_ALIGNED"
  "CR_IOPS_CR_GOAL_LEN_FAST" and "CR_IOPS_CR_GOAL_LEN_SLOW" to do either
  a fast scan or a slow scan on the IOPS groups, and then fall back to
  non-IOPS groups?  They would be skipped if no IOPS groups exist.

The second option allows preserving the CR value across the loops, in =
case
the group returned is not suitable for some reason, without confusing =
whether
the lookup is being done for IOPS groups or not.  Also, it makes sense =
to
have a "SLOW" pass on the IOPS groups, instead of just "FAST", to ensure
that all of the IOPS groups have been tried.  This should be very rare
since most allocations (excluding xattrs) are only one block long.

Ojaswin, do you have any input here?  You've been doing somework on the
mballoc code recently, and it would be good to get this aligned with =
what
you are doing/planning.

>>>> 	if (*new_cr =3D=3D 0) {
>>>> 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, =
ngroups);
>>>> 	} else if (*new_cr =3D=3D 1) {
>>>> 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, =
ngroups);
>>>> 	} else {
>>>> +		/*
>>>> +		 * Cannot get data group from slow storage, try IOPS =
storage
>>>> +		 */
>>>> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>>> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
>>>> +		    *new_cr =3D=3D 3) {
>>>> +			if (ac->ac_2order)
>>>> +				ret =3D =
ext4_mb_choose_next_iops_group_cr0(ac,
>>>> +									 =
group);
>>>> +			if (!ret)
>>>> +				ext4_mb_choose_next_iops_group_cr1(ac, =
group);
>>>> +		}
>>>=20
>>> We might never come here in this else case because
>>> should_optimize_scan() which we check in the beginning of this =
function
>>> will return 0 and we will chose a next linear group for CR >=3D 2.
>>=20
>> Hmm, you are right.  Just off the bottom of this hunk is a =
"WARN_ON(1)"
>> that this code block should never be entered.
>=20
> right.
>=20
>>=20
>> Really, the fallback to IOPS groups for regular files should only =
happen
>> in case of if *new_cr >=3D CR_GOAL_ANY_FREE.  We don't want "normal" =
block
>> allocation to fill up the IOPS groups just because the filesystem is
>> fragmented and low on space, but only if out of non-IOPS space.
>>=20
>=20
> Sure, I have added some comments later on this policy part...
>=20
>>>>=20
>>>> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>>>> 		goto out;
>>>> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>>>> 		goto out;
>>>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>>> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && =
EXT4_MB_GRP_TEST_IOPS(grp) &&
>>>> +	    !sbi->s_mb_enable_iops_data)
>>>> +		goto out;
>>>=20
>>> since we already have a grp information here. Then checking for =
s_flags
>>> and is redundant here right?
>>=20
>> This is intended to stop regular data allocations in IOPS groups that =
are
>> found by next_linear_group().
>=20
> What I meant is EXT4_MB_GRP_TEST_IOPS(grp), will only be true when we
> have sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS as true right?
> So do we still need to keep both conditions here?

Well, EXT2_FLAGS_HAS_IOPS determines whether this functionality is =
enabled
or not, while the GRP_TEST_IOPS check is for the individual group.  So =
if
the feature is totally disabled (no EXT2_FLAGS_HAS_IOPS) then the =
per-group
bit should be ignored.

>> With the change to allow regular data to be allocated in IOPS groups,
>> there might need to be an extra check added here to see what =
allocation
>> phase this is.  Should we add *higher* CR_ phases above CR_ANY_FREE =
to
>> allow distinguishing between IOPS->regular fallback and regular->IOPS
>> fallback?
>>=20
>>=20
>> It seems like most of the complexity/issues here have crept in since =
the
>> addition of the fallback for regular data allocations in IOPS =
groups...
>> I'm not sure if we want to defer that functionality to a separate =
patch,
>> or if you have any suggestions on how to clarify this without adding =
a
>> lot of complexity?
>=20
> I agree that the separation is not clear. I think it would have been
> better if we would have split that functionality in 2 separate =
patches.
> The 1st patch just adds the functionality that you intended i.e.
>=20
> 1. metadata allocations should happen via IOPS group and only if there
> is no space left in IOPS group it will fallback to non-IOPS group.
> This 1st patch also have data allocations coming only from non-iops =
group.
>=20
> and the second patch can have details of...
> 2. adding a knob which can allow users to fallback data allocations to =
IOPS group too.

Sure, I would be happy with that.  My main goal is to reserve these =
flags
and get this feature working in a basic fashion, and then more elaborate
policy decisions can be added once there is a demand for it.

> If you think you would like to defer the second patch to later to =
avoid
> the complexity, I am fine with that too. The reason is we should still
> think upon what should be the fallback critera for that. Should we do =
it
> when we absolutely have no space in non-IOPS group (cr >=3D =
CR_ANY_FREE)
> or is it ok to fallback even earlier. I guess it will also depend upon
> the information of how many groups are IOPS v/s non-IOPS.
>=20
> I don't think we are keeping that information anywhere on disk right?
> (no. of IOPS v/s non-IOPS groups). That means we might have to do that
> at runtime. Once we have that information, the filesystem can better
> decide on when should the fallback happen.

Mount already scans all of the groups at mount to set the IOPS flags in
the in-memory group_info, so the count of IOPS groups vs. non-IOPS could
be easily determined, if there is a use for this.

> So I agree, we need to more discussion and think it through. I guess =
Ted
> was also suggesting the same on the call. Feel free to defer the
> fallback of data allocations to non-IOPS group for a later time (If
> we don't have a strong objection from others on this).

Great, thanks for your review and feedback.


Cheers, Andreas






--Apple-Mail=_5D9B53D5-298C-4289-BA0D-5F1E38DF933F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUTLroACgkQcqXauRfM
H+DViRAAiWEG+QJrv7Hq31GSDLAqFk2pnHGe4hQK+Sq9/44heEJSTNjIe5Cwk8E2
nG9rgcYbbkH8x8C7lwINzKCb4GeTZKALNqSAtbeyFvh1ICBJOPukiXQjzoPh5MmH
lfIf3u7cvY3mnSneFfwaQGMtLF1Ed/vM+IpVMn9boPyIKWpDAIUxEjoM3prkrj+4
IK5nHiPlv86VdjiUOLqEanOrNWjddOmNQEVOOsATMsL4emxzz4W8L6tOwC/r5qt4
5YYGc4gETUODYWG1E1f7M1cDxZuR3vBcRzbbjCoC9cErH1vdYNxm3z0cZ1Lxdy/1
UgFFae0RZG9QXj2SQUA1wLZ91rLjSQ/X1p4IriQCjJ29nfyq2DYtYqK6cUEmsw7/
sK0HphsSioJ9OmR6pHoMFSlkhUvcaDpBaJAtUSZGJRcWZTcQ6+b35hzSERy5zpYM
c1fbxGVDBfepi5yOre/2I9/FNBrn1syC4+xAW9kIKkL+Fzp7yAYtcUZZepulCNOA
nBYA0X+eF5uA0wlIzBzADrpDPdT+iyGpPZypTStC34I+t/1AICFoGWfYtIf9cRNn
aw4ZdP0piPUZJcyghWgzRvY/Vjd7mjNTqjUxl5UnWJOsw1uurEO35EphdBvkMZXV
ZQY/08bPh8OrOa6M7d4skzPpUChmU8H7/laXTC5JFQt9rovWq4Q=
=9UgU
-----END PGP SIGNATURE-----

--Apple-Mail=_5D9B53D5-298C-4289-BA0D-5F1E38DF933F--
