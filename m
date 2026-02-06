Return-Path: <linux-ext4+bounces-13610-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id isKlHQ1/hmmVOAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13610-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 00:53:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B5104309
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 00:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97342302A6E4
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 23:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713933148D5;
	Fri,  6 Feb 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="EtU8bFZE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917572FD7A3
	for <linux-ext4@vger.kernel.org>; Fri,  6 Feb 2026 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770422022; cv=none; b=cPKLsQFaXPaJ123CNGofQ+6kZgOjb7Chv2iM24K2EHU4jCdRx38Slh3arSQbylkxIr9WDyH+ZyL0GSJAJQHJrkqERav7JkjGGchahxh8Wr+06U2JACJ0Xete5CLXGQlB4n5ncYI1kXga6c/H8us19hbkciu70Hvys5M65wE+X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770422022; c=relaxed/simple;
	bh=5xNcRU03vytCiVa10lq2t9KfG5bUC2K6mgux2FYgZ/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TMnNB0MvUaXKyp9gubaMfCngZmUWTFCWFe25qon2OGcLnwml7GvyquujUwMJ4tSQpbJfNOFXBGWL/fqSyFoCyZuNdH/AxMAWIFG3xzr8AbTutFuaFf+0RBSJlaIHuIA3ew771I17Iluie7KUq5bA3IknUw+pV1b9ASm2IJbPl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=EtU8bFZE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a90055b9e9so12276445ad.1
        for <linux-ext4@vger.kernel.org>; Fri, 06 Feb 2026 15:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1770422021; x=1771026821; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHIiN7vv64vY+CFfkv1zhEc4LTxpyfrufPg1bW52hcg=;
        b=EtU8bFZENo8fgcxdhY2woF33euU15B4ptc1aTGSHD3j+NJX5xSKUjvyzLt3k2m1wP6
         iNS2fNiKAH+mWaFRHvVvfRlUQG7SNAQunEX4oi+3ikGMt1e65UHXpKoSBJXsUf7egNW3
         IB0FER5henDK51V2qykhOGqCkdcmR07VoeEVnV4elr3z1RIv/uNdIKx5MWVSeqeIrpwL
         /Bb5NaJLa9trBWSlE3LiGdMaRwgw7K5/YSEqO4trTVYelGy1W8A0ksTAt2rwaAVbDor9
         1G1Z+R64gQgjl0/xNym5Cq5vEtBw9WPyHISjxc/r7PtW69tzGsbpAjHXvL4ztPXHkmnR
         w9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770422021; x=1771026821;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHIiN7vv64vY+CFfkv1zhEc4LTxpyfrufPg1bW52hcg=;
        b=ssy7Jtw9xnfmpcj+aLnitHme2l1qrg7vVGvWHsTmjWcj/lt3LhdXJXFf4yJ9ayCGFY
         4trCcay/87p5BWVC2BExrnly5TgkM3NTyGYI+BgOg/g2TETD5Lw2Hx1eUQKX1OoPDb4Y
         HR/1O2lq0pmWa1ktdsRIpYyHSawHHSR7RVCYRhjQ7OodRxz/DZpPqmVxd6QFrvnGreas
         SYA0SqSktEj/KKUFU+4HD01/FxUjTMZWcarhJHAxYQyChmETcJmRSSlzi1rdFrCfiXG3
         NAj4be5pZBZw1J2hdK6qipxONN+54F1UvkLKoXTbF4Doyn/7k1wARDQ6nScNXD1YQ94C
         H05Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyFMVhmoVhrj0eMDsh7eVdLK8gHKkylvDrQhYZ2dliVbCU2wmaIods4t/6eaNtyTjqtg3S4p6tDuRi@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZdLZng6cCI9xC0Vfne5UjBiK8gXBe7P1Zg2yhl9AypeGXlOd
	vsUCv5nq/lsU3lQwOsZ380o3oOz5dzF10nJyuPpVkZyj7sOw0ObXJTgK4wHaWqcuVNQ=
X-Gm-Gg: AZuq6aJ48oqpKFZwMvifuSbgxZF07JjkNIxzI17OYnwFEcavo1nWBhG1qPR33pXtskt
	CA4UgKNI/6XCRFkEQ+m3hhs+LgqIvEiGU+hcZ58D3Tphk4xvjTJ06FiQ0jgnOAWJdolnxAjPzFg
	xEm+zYb9epsQDWutPPAs0VxQFihWvTQukel71YndpOVVRq2yr0u3mhcHvsFP7QW7yhb9CDTP9P2
	ekEUzsAWnABtXOubj0fphEii29/eF/iYrGVaCKyu24kCGuKitSHHy3RUH3NBlxUYrhiwprOjmmy
	2W9koXIj/d62+GYutEyIl+X5cEqoBa0ZqZId8aYYVKsiBgdverT7Sa0V/9yhTK+W3Zh5oBWRDg9
	9bXxzyuw5kwV6M6DzW4OMVAn0X6ixXcKcKxrCOmAnAcxevemH3ez0z9JC22JlrGcYIZ9E25HqDl
	9+dSXDvwwuWXuxQQy2yX2dTToFVEgjeO48oRFSK/+kdYO/1/cNGlht6KJH496vIbngnUckXUoq3
	IaO
X-Received: by 2002:a17:902:ecc6:b0:29f:2b9:6cca with SMTP id d9443c01a7336-2a952226efbmr42012195ad.44.1770422020672;
        Fri, 06 Feb 2026 15:53:40 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a95220af95sm34068185ad.82.2026.02.06.15.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Feb 2026 15:53:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
Date: Fri, 6 Feb 2026 16:53:28 -0700
Cc: Baokun Li <libaokun1@huawei.com>,
 tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Yang Erkun <yangerkun@huawei.com>,
 libaokun9@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E89B4B6-BF01-4B6B-94BA-8A44112F8A3A@dilger.ca>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[huawei.com,mit.edu,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13610-lists,linux-ext4=lfdr.de];
	FREEMAIL_TO(0.00)[rocketmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B42B5104309
X-Rspamd-Action: no action

On Feb 5, 2026, at 05:23, Mario Lohajner <mario_lohajner@rocketmail.com> =
wrote:
>=20
> Let me briefly restate the intent, focusing on the fundamentals.
>=20
> Rotalloc is not wear leveling (and is intentionally not named as =
such).
> It is a allocation policy whose goal is to reduce allocation hotspots =
by
> enforcing mount-wide sequential allocation. Wear leveling, if any,
> remains a device/firmware concern and is explicitly out of scope.
> While WL motivated part of this work,
>=20
> the main added value of this patch is allocator separation.
> The policy indirection (aka vectored allocator) allows allocation
> strategies that are orthogonal to the regular allocator to operate
> outside the hot path, preserving existing heuristics and improving
> maintainability. Rotalloc is one such case; when disabled (by =
default),
> there is literally no behavioral change.
>=20
> The cursor is global because the policy is global (KSS applied here =
:-).
> It operates at the mount level, not per inode, stream, or CPU.
> Splitting the cursor would still require keeping all cursors in sync;
> once any allocator diverges, it either has to scan more blocks or
> sequentiality collapses back into locality and hotspots reappear.
> A single cursor is therefore intentional.
>=20
> The rotating allocator itself is a working prototype.
> It was written with minimal diff and clarity in mind to make the =
policy
> reviewable. Refinements and simplifications are expected and welcome.
>=20
> Regarding discard/trim: while discard prepares blocks for reuse and
> signals that a block is free, it does not implement wear leveling by
> itself. Rotalloc operates at a higher layer; by promoting =
sequentiality,
> it reduces block/group allocation hotspots regardless of underlying
> device behavior.

I think there are two main reasons why a round-robin allocation policy =
is of
interest:
- maximizing the time between block group re-use also maximizes the time
  during which blocks can be freed in a group, reducing fragmentation
- this also improves the ability of fstrim to process larger segments
  of free storage compared to "-o discard" which is sub-optimal when
  processing recently-freed blocks (which may be small/unaligned =
compared
  to the erase blocks/RAID of the storage and not actually trim any =
space)

The latter is what motivated the "-o fstrim" feature[1] that we =
developed
for Lustre as a lighter-weight alternative to "-o discard" to use fstrim
infrastructure on an ongoing basis to trim whole groups that have freed
space recently, but not track all of the freed extents individually.

Cheers, Andreas

[1] Patches to implement persistent TRIMMED flag, stats, and "fstrim":
=
https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patche=
s/patches/rhel10.0/ext4-introduce-EXT4_BG_TRIMMED-to-optimize-fstrim.patch=

=
https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patche=
s/patches/rhel10.0/ext4-add-DISCARD-stats.patch
=
https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patche=
s/patches/rhel9.4/ext4-add-fstrim-mount-option.patch


> Since it is not in line with the current allocator goals, it is
> implemented as an optional policy.
>=20
> Best regards,
> Mario
>=20
> PS: thank you for acknowledging that there are workloads and scenarios
> where this method is worthwhile :-).
>=20
> On 05. 02. 2026. 04:52, Baokun Li wrote:
>> On 2026-02-04 19:06, Mario Lohajner wrote:
>>> Hello Baokun Li,
>>>=20
>>> This response was originally intended for Andreas.
>>> I'm sending you the full copy to provide context for your query,
>>> rather than writing a separate response.
>>>=20
>>> Yes, the main motive for this allocator is flash wear leveling,
>>> but it is not strictly a wear leveling mechanism, and it is not =
named
>>> as such for a reason.
>>> Wear leveling may (or may not) exist at the device/hardware level.
>>> The goal of this policy is not to "fix" that.
>>>=20
>> As Ted mentioned in another thread, wear leveling is media-dependent.
>> Most drivers can handle wear leveling effectively enough just via the
>> discard command.
>>=20
>> If you are using UFS, F2FS might be a solid choice. However, for raw
>> NAND flash, UBIFS (via UBI) or JFFS2 would be more appropriate.
>>=20
>> A single global goal would cause severe contention in multi-CPU
>> scenarios, which is precisely why the stream allocation goal was =
split
>> into multiple ones.
>>=20
>> Furthermore, constantly overriding the inode goal leads to =
significant
>> file fragmentation, as it often misses opportunities for extent =
merging.
>>=20
>> If we truly want to implement ext4_mb_rotating_allocator, we should =
strip
>> out inode goal, stream allocation, and optimize_scan, rather than =
simply
>> cloning ext4_mb_regular_allocator and forcing a goal setting.
>>=20
>>=20
>> Cheers,
>> Baokun
>>=20
>>> This policy helps avoid allocation hotspots at mount start by
>>> distributing allocations sequentially across the entire mount,
>>> not just a file or allocation stream.
>>>=20
>>> At the block/group allocation level, the file system is fairly =
stochastic
>>> and timing-sensitive. Rather than providing raw benchmark data, I =
prefer
>>> to explain the design analytically:
>>> The vectored separation of the new allocator ensures that the =
performance
>>> of the regular allocator is maintained (literally unchanged).
>>> The overhead of the new rotating allocator is minimal and occurs =
outside
>>> of the "hot loop":
>>> the cursor is retrieved early at the start, updated upon successful
>>> allocation,
>>> and is negligible with respect to IO latency.
>>> Because allocations proceed sequentially, latency is comparable to
>>> or better than the regular allocator.
>>> Having separated allocators increases maintainability and =
independence
>>> with minimal (virtually no) overhead.
>>>=20
>>> This policy benefits workloads with frequent large or small =
allocations,
>>> while keeping file fragmentation and slack space minimal.
>>> It is a conscious trade-off: sacrificing locality in favor of =
reinforced
>>> sequentiality.
>>> Of course, this is not optimal for classic HDDs, but NVMe drives =
behave
>>> differently.
>>> For this reason, the policy is optional per mount, turned off by =
default,
>>> and can be toggled at mount time.
>>>=20
>>> Best regards,
>>> Mario
>>>=20
>>> On 04. 02. 2026. 07:29, Baokun Li wrote:
>>>> On 2026-02-04 11:31, Mario Lohajner wrote:
>>>>> Add support for the rotalloc allocation policy as a new mount
>>>>> option. Policy rotates the starting block group for new =
allocations.
>>>>>=20
>>>>> Changes:
>>>>> - fs/ext4/ext4.h
>>>>>     rotalloc policy dedlared, extend sb with cursor, vector & lock
>>>>>=20
>>>>> - fs/ext4/mballoc.h
>>>>>     expose allocator functions for vectoring in super.c
>>>>>=20
>>>>> - fs/ext4/super.c
>>>>>     parse rotalloc mnt opt, init cursor, lock and allocator vector
>>>>>=20
>>>>> - fs/ext4/mballoc.c
>>>>>     add rotalloc allocator, vectored allocator call in new_blocks
>>>>>=20
>>>>> The policy is selected via a mount option and does not change the
>>>>> on-disk format or default allocation behavior. It preserves =
existing
>>>>> allocation heuristics within a block group while distributing
>>>>> allocations across block groups in a deterministic sequential =
manner.
>>>>>=20
>>>>> The rotating allocator is implemented as a separate allocation =
path
>>>>> selected at mount time. This avoids conditional branches in the =
regular
>>>>> allocator and keeps allocation policies isolated.
>>>>> This also allows the rotating allocator to evolve independently in =
the
>>>>> future without increasing complexity in the regular allocator.
>>>>>=20
>>>>> The policy was tested using v6.18.6 stable locally with the new =
mount
>>>>> option "rotalloc" enabled, confirmed working as desribed!
>>>>>=20
>>>>> Signed-off-by: Mario Lohajner <mario_lohajner@rocketmail.com>
>>>>> ---
>>>>>   fs/ext4/ext4.h    |   8 +++
>>>>>   fs/ext4/mballoc.c | 152 =
++++++++++++++++++++++++++++++++++++++++++++--
>>>>>   fs/ext4/mballoc.h |   3 +
>>>>>   fs/ext4/super.c   |  18 +++++-
>>>>>   4 files changed, 175 insertions(+), 6 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>>> index 56112f201cac..cbbb7c05d7a2 100644
>>>>> --- a/fs/ext4/ext4.h
>>>>> +++ b/fs/ext4/ext4.h
>>>>> @@ -229,6 +229,9 @@ struct ext4_allocation_request {
>>>>>       unsigned int flags;
>>>>>   };
>>>>>   +/* expose rotalloc allocator argument pointer type */
>>>>> +struct ext4_allocation_context;
>>>>> +
>>>>>   /*
>>>>>    * Logical to physical block mapping, used by ext4_map_blocks()
>>>>>    *
>>>>> @@ -1230,6 +1233,7 @@ struct ext4_inode_info {
>>>>>    * Mount flags set via mount options or defaults
>>>>>    */
>>>>>   #define EXT4_MOUNT_NO_MBCACHE        0x00001 /* Do not use =
mbcache */
>>>>> +#define EXT4_MOUNT_ROTALLOC            0x00002 /* Use rotalloc
>>>>> policy/allocator */
>>>>>   #define EXT4_MOUNT_GRPID        0x00004    /* Create files with
>>>>> directory's group */
>>>>>   #define EXT4_MOUNT_DEBUG        0x00008    /* Some debugging =
messages */
>>>>>   #define EXT4_MOUNT_ERRORS_CONT        0x00010    /* Continue on
>>>>> errors */
>>>>> @@ -1559,6 +1563,10 @@ struct ext4_sb_info {
>>>>>       unsigned long s_mount_flags;
>>>>>       unsigned int s_def_mount_opt;
>>>>>       unsigned int s_def_mount_opt2;
>>>>> +    /* Rotalloc cursor, lock & new_blocks allocator vector */
>>>>> +    unsigned int s_rotalloc_cursor;
>>>>> +    spinlock_t s_rotalloc_lock;
>>>>> +    int (*s_mb_new_blocks)(struct ext4_allocation_context *ac);
>>>>>       ext4_fsblk_t s_sb_block;
>>>>>       atomic64_t s_resv_clusters;
>>>>>       kuid_t s_resuid;
>>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>>> index 56d50fd3310b..74f79652c674 100644
>>>>> --- a/fs/ext4/mballoc.c
>>>>> +++ b/fs/ext4/mballoc.c
>>>>> @@ -2314,11 +2314,11 @@ static void ext4_mb_check_limits(struct
>>>>> ext4_allocation_context *ac,
>>>>>    *   stop the scan and use it immediately
>>>>>    *
>>>>>    * * If free extent found is smaller than goal, then keep =
retrying
>>>>> - *   upto a max of sbi->s_mb_max_to_scan times (default 200). =
After
>>>>> + *   up to a max of sbi->s_mb_max_to_scan times (default 200). =
After
>>>>>    *   that stop scanning and use whatever we have.
>>>>>    *
>>>>>    * * If free extent found is bigger than goal, then keep =
retrying
>>>>> - *   upto a max of sbi->s_mb_min_to_scan times (default 10) =
before
>>>>> + *   up to a max of sbi->s_mb_min_to_scan times (default 10) =
before
>>>>>    *   stopping the scan and using the extent.
>>>>>    *
>>>>>    *
>>>>> @@ -2981,7 +2981,7 @@ static int ext4_mb_scan_group(struct
>>>>> ext4_allocation_context *ac,
>>>>>       return ret;
>>>>>   }
>>>>>   -static noinline_for_stack int
>>>>> +noinline_for_stack int
>>>>>   ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>>>>   {
>>>>>       ext4_group_t i;
>>>>> @@ -3012,7 +3012,7 @@ ext4_mb_regular_allocator(struct
>>>>> ext4_allocation_context *ac)
>>>>>        * is greater than equal to the sbi_s_mb_order2_reqs
>>>>>        * You can tune it via =
/sys/fs/ext4/<partition>/mb_order2_req
>>>>>        * We also support searching for power-of-two requests only =
for
>>>>> -     * requests upto maximum buddy size we have constructed.
>>>>> +     * requests up to maximum buddy size we have constructed.
>>>>>        */
>>>>>       if (i >=3D sbi->s_mb_order2_reqs && i <=3D =
MB_NUM_ORDERS(sb)) {
>>>>>           if (is_power_of_2(ac->ac_g_ex.fe_len))
>>>>> @@ -3101,6 +3101,144 @@ ext4_mb_regular_allocator(struct
>>>>> ext4_allocation_context *ac)
>>>>>       return err;
>>>>>   }
>>>>>   +/* Rotating allocator (rotalloc mount option) */
>>>>> +noinline_for_stack int
>>>>> +ext4_mb_rotating_allocator(struct ext4_allocation_context *ac)
>>>>> +{
>>>>> +    ext4_group_t i, goal;
>>>>> +    int err =3D 0;
>>>>> +    struct super_block *sb =3D ac->ac_sb;
>>>>> +    struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>>>>> +    struct ext4_buddy e4b;
>>>>> +
>>>>> +    BUG_ON(ac->ac_status =3D=3D AC_STATUS_FOUND);
>>>>> +
>>>>> +    /* Set the goal from s_rotalloc_cursor */
>>>>> +    spin_lock(&sbi->s_rotalloc_lock);
>>>>> +    goal =3D sbi->s_rotalloc_cursor;
>>>>> +    spin_unlock(&sbi->s_rotalloc_lock);
>>>>> +    ac->ac_g_ex.fe_group =3D goal;
>>>>> +
>>>>> +    /* first, try the goal */
>>>>> +    err =3D ext4_mb_find_by_goal(ac, &e4b);
>>>>> +    if (err || ac->ac_status =3D=3D AC_STATUS_FOUND)
>>>>> +        goto out;
>>>>> +
>>>>> +    if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
>>>>> +        goto out;
>>>>> +
>>>>> +    /*
>>>>> +     * ac->ac_2order is set only if the fe_len is a power of 2
>>>>> +     * if ac->ac_2order is set we also set criteria to =
CR_POWER2_ALIGNED
>>>>> +     * so that we try exact allocation using buddy.
>>>>> +     */
>>>>> +    i =3D fls(ac->ac_g_ex.fe_len);
>>>>> +    ac->ac_2order =3D 0;
>>>>> +    /*
>>>>> +     * We search using buddy data only if the order of the =
request
>>>>> +     * is greater than equal to the sbi_s_mb_order2_reqs
>>>>> +     * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
>>>>> +     * We also support searching for power-of-two requests only =
for
>>>>> +     * requests up to maximum buddy size we have constructed.
>>>>> +     */
>>>>> +    if (i >=3D sbi->s_mb_order2_reqs && i <=3D MB_NUM_ORDERS(sb)) =
{
>>>>> +        if (is_power_of_2(ac->ac_g_ex.fe_len))
>>>>> +            ac->ac_2order =3D array_index_nospec(i - 1,
>>>>> +                               MB_NUM_ORDERS(sb));
>>>>> +    }
>>>>> +
>>>>> +    /* if stream allocation is enabled, use global goal */
>>>>> +    if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>>>>> +        int hash =3D ac->ac_inode->i_ino % =
sbi->s_mb_nr_global_goals;
>>>>> +
>>>>> +        ac->ac_g_ex.fe_group =3D =
READ_ONCE(sbi->s_mb_last_groups[hash]);
>>>>> +        ac->ac_g_ex.fe_start =3D -1;
>>>>> +        ac->ac_flags &=3D ~EXT4_MB_HINT_TRY_GOAL;
>>>> Rotating block allocation looks a lot like stream allocation=E2=80=94=
they both
>>>> pick up from where the last successful allocation left off.
>>>>=20
>>>> I noticed that the stream allocation's global goal is now split up.
>>>> Is there an advantage to keeping it as a single goal?
>>>> Alternatively, do you see any downsides to this split in your use =
case?
>>>>=20
>>>>=20


Cheers, Andreas






