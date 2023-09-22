Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF07F7AA7E2
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 06:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjIVEiy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 00:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVEix (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 00:38:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D12122
        for <linux-ext4@vger.kernel.org>; Thu, 21 Sep 2023 21:38:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso14013955ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Sep 2023 21:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695357523; x=1695962323; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSpMZmMgjPlbL/qvsrX9q/gkQBC8NBxJMPdhAuj2O+c=;
        b=hyQb3V5V3vkLZstbCVdkhEoVLJ9UQioLyK3MT7KUOgQ0fOjwucFJu626VnKHbzlhxa
         2VPqrKroEEZ3JPS81Pr+K7HNYUlq9I70yHWqeUBavYuBpMv5MGS7Whdx6GNubg6A+t+x
         cLoXhbu6DA/esi0YimAagdzIgp5xvihhig0iTFZkMyyuv5mKSXBqTA9rGvE3WgsyKYpy
         RomjYmBNUDNZGYQpU2iEzfMjKsMd1wbs16lWKUWMj9qO0LX8KEwxfWz+cwt1B+NeAJuD
         F4DCrNqdfDzdgvwd5TgI8cmpEF4naQewQxF3Te4DfdK/O/MbYenGmdgZmVK6YXqMv+m8
         kWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357523; x=1695962323;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSpMZmMgjPlbL/qvsrX9q/gkQBC8NBxJMPdhAuj2O+c=;
        b=ZEPAQYgwyR45iOg8X8SsTapjKUzIGK/Y+FOdFlBaMj6LJBHnK/2q0XvhfRIMml88xj
         titdJmwM6nPnuoQ4PV9eqdCSOMumUdDIANDKtXFeB4JlMUpJtpT+Co/2pa7qfF3c71QC
         gm/GCaUoOBlvbvecykf12oZWw8C0NSfjvkIN5OK5JG5WGhkSq3QoDhc0/C9Y3CgQs5cV
         HJBBXmeJUb6mnSaF82AMAuNMVb/M5WVWoxayVslfKx6Aa7bbWHsHPApzLfdBDsnm492C
         +BQsRsB/ncaVqTqFjLcayy5jDJ/q2vv/wakWe4TGJMJ+Dswl9obGYjU4OfUgI46US2qg
         IIpw==
X-Gm-Message-State: AOJu0YzSJllkrjIuXLt+uBuUKLqTMiQe5NRO0YUgR46YqcKwwHSqNS4w
        4GXNB2cpWnmI2BADsHAx5wJv/245jZJ53M2N+Sw=
X-Google-Smtp-Source: AGHT+IHv6R7kcRKlMQFah1oGG1gc5TcqRMCoRW9qrCFwcdrF2gKcf2mmANtZzhYblTPQO1SKubsFJA==
X-Received: by 2002:a17:903:120b:b0:1bf:70be:ca8b with SMTP id l11-20020a170903120b00b001bf70beca8bmr8057599plh.43.1695357523426;
        Thu, 21 Sep 2023 21:38:43 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id p22-20020a170902a41600b001ae0152d280sm2396806plq.193.2023.09.21.21.38.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 21:38:42 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FFAD9C6B-B0A0-4CD3-BEE8-B62D702BBEC8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7B21D0C6-4461-4DC8-9246-51756970F0B0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
Date:   Thu, 21 Sep 2023 22:38:39 -0600
In-Reply-To: <874jjp768n.fsf@doe.com>
Cc:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <874jjp768n.fsf@doe.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7B21D0C6-4461-4DC8-9246-51756970F0B0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 19, 2023, at 11:39 PM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Bobi Jam <bobijam@hotmail.com> writes:
>=20
>> With LVM it is possible to create an LV with SSD storage at the
>> beginning of the LV and HDD storage at the end of the LV, and use =
that
>> to separate ext4 metadata allocations (that need small random IOs)
>> from data allocations (that are better suited for large sequential
>> IOs) depending on the type of underlying storage.  Between 0.5-1.0% =
of
>> the filesystem capacity would need to be high-IOPS storage in order =
to
>> hold all of the internal metadata.
>>=20
>> This would improve performance for inode and other metadata access,
>> such as ls, find, e2fsck, and in general improve file access latency,
>> modification, truncate, unlink, transaction commit, etc.
>>=20
>> This patch split largest free order group lists and average fragment
>> size lists into other two lists for IOPS/fast storage groups, and
>> cr 0 / cr 1 group scanning for metadata block allocation in following
>> order:
>>=20
>> if (allocate metadata blocks)
>>      if (cr =3D=3D 0)
>>              try to find group in largest free order IOPS group list
>>      if (cr =3D=3D 1)
>>              try to find group in fragment size IOPS group list
>>      if (above two find failed)
>>              fall through normal group lists as before
>=20
> Ok, so we are agreeing that if the iops groups are full, we will
> fallback to non-iops group for metadata.
>=20
>=20
>> if (allocate data blocks)
>>      try to find group in normal group lists as before
>>      if (failed to find group in normal group && mb_enable_iops_data)
>>              try to find group in IOPS groups
>=20
> same here but with mb_enable_iops_data.

Hi Ritesh,
thanks for your review.

Yes, this is in the case of allocating data blocks.

>> Non-metadata block allocation does not allocate from the IOPS groups
>> if non-IOPS groups are not used up.
>=20
> Sure. At least ENOSPC use case can be handled once mb_enable_iops_data
> is enabled. (for users who might end up using large iops disk)
>=20
>> Add for mke2fs an option to mark which blocks are in the IOPS region
>> of storage at format time:
>>=20
>>  -E iops=3D0-1024G,4096-8192G
>>=20
>> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
>> group descriptors to decide which groups to allocate dynamic
>> filesystem metadata.
>>=20
>> Signed-off-by: Bobi Jam <bobijam@hotmail.com
>>=20
>> --
>> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
>>        from IOPS groups.
>> v1->v2: for metadata block allocation, search in IOPS list then =
normal
>>        list.
>> ---
>>=20
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 8104a21b001a..a8f21f63f5ff 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -382,6 +382,7 @@ struct flex_groups {
>> #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use =
*/
>> #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
>> #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to =
zero */
>> +#define EXT4_BG_IOPS		0x0010 /* In IOPS/fast storage =
*/
>=20
> Not related to this patch. But why not 0x0008? Is it reserved for
> anything else?

That is being used by the patches to add persistent TRIM support:

+#define EXT4_BG_TRIMMED		0x0008 /* block group was =
trimmed */

=
https://patchwork.ozlabs.org/project/linux-ext4/patch/20230829054309.68453=
0-1-dongyangli@ddn.com/ ("[V2] e2fsprogs: support EXT2_FLAG_BG_TRIMMED =
and EXT2_FLAGS_TRACK_TRIM")
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/20230817003504.45892=
0-1-dongyangli@ddn.com/ ("[V2] ext4: introduce EXT4_BG_TRIMMED to =
optimize fstrim")

>> /*
>>  * Macro-instructions used to manage group descriptors
>> @@ -1112,6 +1113,8 @@ struct ext4_inode_info {
>> #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in =
use */
>> #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test =
development code */
>>=20
>> +#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
>> +
>=20
> same here. Are the flag values in between 0x0004 and 0x0080 are =
reserved?

+#define EXT2_FLAGS_TRACK_TRIM		0x0008  /* Track trim status in =
bg */

The 0x10/20/40 flags are reserved in e2fsprogs but are not used by ext4.

>> @@ -1009,11 +1108,37 @@ static void ext4_mb_choose_next_group(struct =
ext4_allocation_context *ac,
>> 		return;
>> 	}
>>=20
>> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) =
{
>> +		if (*new_cr =3D=3D 0)
>> +			ret =3D ext4_mb_choose_next_iops_group_cr0(ac, =
group);
>> +		if (!ret && *new_cr < 2)
>> +			ret =3D ext4_mb_choose_next_iops_group_cr1(ac, =
group);

It looks like this patch is a bit stale since Ojaswin's renaming of the
cr0/cr1 phases to "p2_aligned" and "goal_fast" and "best_avail" names.

> This is a bit confusing here. Say if *new_cr =3D 0 fails, then we =
return
> ret =3D false and fallback to choosing xx_iops_group_cr1(). And say if =
we
> were able to find a group which satisfies this allocation request we
> return. But the caller never knows that we allocated using cr1 and not
> cr0. Because we never updated *new_cr inside xx_iops_group_crX()

I guess it is a bit messy, since updating new_cr might interfere with =
the
use of new_cr in the fallthrough to the non-IOPS groups below?  In the
"1% IOPS groups" case, doing this extra scan for metadata blocks should
be very fast, since the metadata allocations are almost always one block
(excluding large xattrs), so the only time this would fail is if no IOPS
blocks are free, in which case it is fast since the group lists are =
empty.

We _could_ have a separate (in effect) cr0_3 and cr0_6 phases before the
non-IOPS group allocation starts to be able to distinguish these cases
(i.e. skip IOPS group scans if they are full) and the fallthrough search
is also having trouble to find a single free block for the metadata, but
I think that is pretty unlikely.

>=20
>> +		if (ret)
>> +			return;
>> +		/*
>> +		 * Cannot get metadata group from IOPS storage, fall =
through
>> +		 * to slow storage.
>> +		 */
>> +		cond_resched();
>=20
> Not sure after you fix above case, do we still require cond_resched()
> here. Note we already have one in the for loop which iterates over all
> the groups for a given ac_criteria.

The cond_resched() was here because it calls two "choose_next_groups()"
functions above without returning to the outer loop.  However, you are
right that the group search is probably not the CPU heavy part here, so
this could probably be dropped?

>> +	}
>> +
>> 	if (*new_cr =3D=3D 0) {
>> 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, =
ngroups);
>> 	} else if (*new_cr =3D=3D 1) {
>> 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, =
ngroups);
>> 	} else {
>> +		/*
>> +		 * Cannot get data group from slow storage, try IOPS =
storage
>> +		 */
>> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
>> +		    *new_cr =3D=3D 3) {
>> +			if (ac->ac_2order)
>> +				ret =3D =
ext4_mb_choose_next_iops_group_cr0(ac,
>> +									 =
group);
>> +			if (!ret)
>> +				ext4_mb_choose_next_iops_group_cr1(ac, =
group);
>> +		}
>=20
> We might never come here in this else case because
> should_optimize_scan() which we check in the beginning of this =
function
> will return 0 and we will chose a next linear group for CR >=3D 2.

Hmm, you are right.  Just off the bottom of this hunk is a "WARN_ON(1)"
that this code block should never be entered.

Really, the fallback to IOPS groups for regular files should only happen
in case of if *new_cr >=3D CR_GOAL_ANY_FREE.  We don't want "normal" =
block
allocation to fill up the IOPS groups just because the filesystem is
fragmented and low on space, but only if out of non-IOPS space.

>> 		/*
>> 		 * TODO: For CR=3D2, we can arrange groups in an rb tree =
sorted by
>> 		 * bb_free. But until that happens, we should never come =
here.
>> @@ -1030,6 +1155,8 @@ static void
>> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
>> {
>> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>> +	rwlock_t *lfo_locks;
>> +	struct list_head *lfo_list;
>> 	int i;
>>=20
>> 	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--)
>> @@ -1042,21 +1169,25 @@ mb_set_largest_free_order(struct super_block =
*sb, struct ext4_group_info *grp)
>> 		return;
>> 	}
>>=20
>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>> +	    EXT4_MB_GRP_TEST_IOPS(grp)) {
>> +		lfo_locks =3D sbi->s_largest_free_orders_locks_iops;
>> +		lfo_list =3D sbi->s_largest_free_orders_list_iops;
>> +	} else {
>> +		lfo_locks =3D sbi->s_mb_largest_free_orders_locks;
>> +		lfo_list =3D sbi->s_mb_largest_free_orders;
>> +	}
>> +
>> 	if (grp->bb_largest_free_order >=3D 0) {
>> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
>> -					      =
grp->bb_largest_free_order]);
>> +		write_lock(&lfo_locks[grp->bb_largest_free_order]);
>> 		list_del_init(&grp->bb_largest_free_order_node);
>> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>> -					      =
grp->bb_largest_free_order]);
>> +		write_unlock(&lfo_locks[grp->bb_largest_free_order]);
>> 	}
>> 	grp->bb_largest_free_order =3D i;
>> 	if (grp->bb_largest_free_order >=3D 0 && grp->bb_free) {
>> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
>> -					      =
grp->bb_largest_free_order]);
>> -		list_add_tail(&grp->bb_largest_free_order_node,
>> -		      =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
>> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>> -					      =
grp->bb_largest_free_order]);
>> +		write_lock(&lfo_locks[i]);
>> +		list_add_tail(&grp->bb_largest_free_order_node, =
&lfo_list[i]);
>> +		write_unlock(&lfo_locks[i]);
>> 	}
>> }
>>=20
>> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>> 		goto out;
>> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>> 		goto out;
>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && =
EXT4_MB_GRP_TEST_IOPS(grp) &&
>> +	    !sbi->s_mb_enable_iops_data)
>> +		goto out;
>=20
> since we already have a grp information here. Then checking for =
s_flags
> and is redundant here right?

This is intended to stop regular data allocations in IOPS groups that =
are
found by next_linear_group().

With the change to allow regular data to be allocated in IOPS groups,
there might need to be an extra check added here to see what allocation
phase this is.  Should we add *higher* CR_ phases above CR_ANY_FREE to
allow distinguishing between IOPS->regular fallback and regular->IOPS
fallback?


It seems like most of the complexity/issues here have crept in since the
addition of the fallback for regular data allocations in IOPS groups...
I'm not sure if we want to defer that functionality to a separate patch,
or if you have any suggestions on how to clarify this without adding a
lot of complexity?

Cheers, Andreas






--Apple-Mail=_7B21D0C6-4461-4DC8-9246-51756970F0B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUNGk8ACgkQcqXauRfM
H+BjQBAAvUKF8lNpLGzQv4xRGCECTbrhpQqM6ihEutfbq92DuKitLqS43HJqfAYo
/Pi4zDvYWtD2lWugSpzI1mggUFmBk3HmrIzu9N+pvPfDqSudQKrrmcswMUhwW0Tp
gNlNIFCKhcm+3lDPvLxnzQatznb9Lq91/qogdyDp7ceoOgVLuexa3lfnJUjiI0kR
tlAYmc6GmxC5LmL+2bzyS+9zc2W5posl+uu7EYOTtb2IAIufMl55vbP9/R+8zZcG
Y1m9JWIfgFDPTBz/jLHSkFhFQhbquLhLxL53089UNfFCjVPkAzVlYE2rHFykV2gw
UIqJ10VTpUxEofCC0zGROxfmv+bd/dQEVK7Orjg/Oqtl20Yizss/V2I+xyhpuFcH
Cpk4uNHvCN/x2lUao0bFGsubOkhvszKRCHOVnoUvzvJZ7TaW/5DewArO2/oiXTc8
zl266bXzZZLMMucJ6uDtsozNsTnAmSH7Xiiem3uKsv+/k4AHFGUxKgsQNvnLxfz1
J2NfU7YwfWi361y9eIPJ4O8TS7jVFJx2IlYnBzRJAQJSb8fyj5cQ+M94VQAYdO/g
JaxbNcibAhWVKxroPdLlcH5AjP18Kq+nmrKPH+zYV+hyZzZoNy10AWG01QagsBIU
AYPZu3BCzvfKxtOJokcqMPKHqDNFI4xy3B0mjL9cnoWUCfWoZVw=
=1N7w
-----END PGP SIGNATURE-----

--Apple-Mail=_7B21D0C6-4461-4DC8-9246-51756970F0B0--
