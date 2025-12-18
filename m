Return-Path: <linux-ext4+bounces-12434-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E49CCAC7F
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 09:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0313C3049D3E
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857272EC558;
	Thu, 18 Dec 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="n2paRQNn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD32EA173
	for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045169; cv=none; b=P+NIIpZY2DmsGwCYUIkbIxlBahgBTawsfh4JVK7NqYXRc9j46ZvKKBvwHpRX6fwDx8JjnLUnpdqL88YSyEQm/SEUP9ttXYvGVDvtVB2msTtq+Kj89/CPIGXLRlF0L1FlyFaVraD5CUWLaS96P6Knw/J9w+gtEcVWhRhmYKuxa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045169; c=relaxed/simple;
	bh=0Ca0X7xiSJNTTUJL9ngIF8O+GCvGYayhW/Tvgi48XWk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a+dE6TbhYWjnJgG6d8DXUhQ9G/307P69lAdqSCq4pktXJc2Wcez8kEOoihMGhyFYs0Z1B0faL3MfKfKEePyOtMR7ay7grgNdCbt8jLEbYlsV2Z5kPDs5LCI9DX+W45zerDLSgEZO6h93vFIvjEPKDF3ZItU5/NsOLOunEzf3RPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=n2paRQNn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07fac8aa1so3720455ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 00:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1766045163; x=1766649963; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MBrCzjEtp+BhtnURcPCUz0JSUnLq/AVrW3L3b0Kla0=;
        b=n2paRQNnnvc9mABTtBGVMn0D6DGw/OYSWnUNQZ+YgvexwzZN1LpbSO48g5qu61fSjg
         bklH5mQZXHrsag2w36Xn/q+2ZMST9FYuQRfw3OmE53YjhDuhDkTmmvh6qnXwFynom220
         Baj5knnAx8anz2b9pHx6COK4pKdCHbJY+SF4D9Q98aVXBz7DnM++Wj9DG7LpWRYjsOCX
         CFh1nAQN4h3kJR152MQcU4c97pn0+FrtwphKaQK+KxEnv4LAZRiB/G8MAlcVDSy1GtFR
         gQnLv0CsTVGVDfd+dSvgjNkJYYBvgWD549Mjol9gPlSNWTC6FnaSe69nggxck38BDRbn
         tEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766045163; x=1766649963;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MBrCzjEtp+BhtnURcPCUz0JSUnLq/AVrW3L3b0Kla0=;
        b=g2nACFbQUZvxwJd+6nJRZPdJsObaTHkTQiqMsqyIwWDrBrAVbzp2vyY/sCVEryM0Ng
         tPsJ56z12FWRVk/luNBsMuf8OlQhqIQGlj63/Br2Sm0VAt3x4iGaGksEQqXP1xQpzzso
         UxUXf3G/xcZSoLFefILELGZ15FsQgVm53uMHQ6j2nKTaADGhlBieE4gRglLX9jrGHPn5
         yaq59SXnH4uV1JkJOyrCVtTcLl9UDpzsa1M01gA+k4w+V1TtbZwSHkrFj/WEnrCIuDMX
         woPePJ5ucfM8NrAnQ9MDYgFqva2DlV/xxnIb4mqVd2QkIDB+mS0tESyHgd2XJ486e5DQ
         Ulqw==
X-Gm-Message-State: AOJu0YxgY6IBv8Td2X0Nz0YQRXbPSgJHjXRE4AUCPx3eHk2DydL0U2wk
	5oUjaKxmjW90sJ7Kpc24Oh2Gf5iJkz00lGZ0AL3SDLs5Cd5yH2xSENzOIYxKJt+9Vzc=
X-Gm-Gg: AY/fxX5k8KetEOQ4XrnAj+2L7stX+XJ0h4bdzB9eQU/qk4O40D/jnbz+dudnFnFYLsO
	eyZC+ShHngUIN4gu64ZlrVa2ZebEAxaa3uVtex/4+IK6d5v4/EI5XweKLPUDXi47V8ErHmwYykh
	5Q/RixNtJLkrERzf4oHMJ/3o6IHagdAVXC76wZcZIF0Rf2e4CvrOYasjE2t9AK0JISuUQI0lUbY
	HxlyWcgltQI09B4TBE3ZMOpTZxz0C01FcTWMYEnhnlXLRB8mGqxF8OIVH7C/lTzQeQ1KH+3LxOR
	p4cqj+qnUJPlY7iuh3RId0BCVuWcvUGPQkz97/iUrBJY3Qv4gqoVe9svjfKjUjDCWTZSqM7jER0
	GmJD5jO18vdU+QNPQquTeBhX0GKJXmXvIrtyRuDILC8T8W1Nm9zaD97i72qbJVEY0RqxxZe9z6a
	jEnTqjT581nEyLZ17HEQaKwHKI46j0h/5F27cdRGun+awdd8MVoNTHmUZT/Lky8N9qfQ==
X-Google-Smtp-Source: AGHT+IHlXig4/u2YiOGF75Wt8mULhMCtyRqH8cNWWZlzdkL7dxPCyLOcb244F/HPGzDBZNT+gpO05A==
X-Received: by 2002:a17:903:3204:b0:29f:1bf:6424 with SMTP id d9443c01a7336-29f23b513c9mr203197355ad.18.1766045162639;
        Thu, 18 Dec 2025 00:06:02 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d0888e22sm16656075ad.30.2025.12.18.00.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Dec 2025 00:06:01 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: ext4: a tool to modify the inode count
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <PAsXqba23hYRwwgFsaneY7Hmxe8-AmdAhSAUH2CW_vtTAi0Y8wVch4QrmW-gU2KahqhsxpxHesEDBZSXlM70jazF0yC-DaPfWgFckG6uzXo=@proton.me>
Date: Thu, 18 Dec 2025 01:05:50 -0700
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB431D42-1CDA-4522-B365-8411801B684E@dilger.ca>
References: <PAsXqba23hYRwwgFsaneY7Hmxe8-AmdAhSAUH2CW_vtTAi0Y8wVch4QrmW-gU2KahqhsxpxHesEDBZSXlM70jazF0yC-DaPfWgFckG6uzXo=@proton.me>
To: Daniel Mazon <daniel.mazon@proton.me>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Dec 17, 2025, at 11:04, Daniel Mazon <daniel.mazon@proton.me> wrote:
>=20
> I wrote a small tool to modify the inode count of an existing ext4=20
> filesystem. It is largely based on the resize2fs tool from e2fsprogs.=20=

> Previously, the inode count was selected at filesystem creation and=20
> could not be modified afterwards.
>=20
> It provides a way to increase or reduce the inode count. I developed
> it because I had a 3.5 TiB ext4 partition created with a default
> 16384 bytes-per-inode ratio. This created over 200 million inodes,
> allocating over 50GiB to inode tables. However, I was using less than
> 0.1% of inodes, so I wanted to reallocate those unused GiB from inode
> tables to free space.
>=20
> To test the program, I created testcases trying to cover all possible=20=

> ext4 options that could be impacted by a change on the inode count.
> After some time, I think it works well: no fsck errors after the
> change, and all data is still there. Please bear in mind that this
> has only been tested by one person.
>=20
> I think this tool could be useful to someone else, as it adds
> flexibility on a parameter which was previouly unmodifiable. The code=20=

> can be found here: https://github.com/danim7/inode_count_modifier
>=20
> Please don't hesitate to let me know if you give it a try. I hope this =
mailing list is the right place to communicate this, if not,
> please excuse me for the noise.

Hi Daniel,
thank you for your contribution.  Changing the inode count of an
existing filesystem independently of the block count is definitely
something that I've wanted to do at various times in the past,
and I'm sure lots of other ext4 users have wanted to do the same.


IMHO, your development efforts would be far more utilized if this
functionality was included directly into the resize2fs utility
(which your README.md mentions was the foundation for your code).

This will not only ensure that this capability continues to be
maintained as e2fsprogs is updated (e.g. if new features are added
to ext4 and/or e2fsprogs), but it also allows a *much* larger number
of users to have access to it when they need it.  Otherwise, it
seems likely that most users will not know "inode_count_modifier"
exists, and they will not be able to change the inode count.
Even worse, someone else might spend a lot of time to re-implement
this due to a similar requirement as yours.

It makes sense to get an Ack from Ted before spending time to do
that work, but I think it would be best for all ext4 users... and
you'd have your code installed on millions of computers worldwide.



On a related note, I've wondered if it makes sense to allow some
semi-dynamic online inode bitmap/itable changes within ext4?  In the
old days, the inode bitmaps were closely tied to the block groups.
With flex_bg and sparse_super2, "mke2fs -E packed_meta_blocks"
available in new e2fsprogs/ext4 there is little correlation between
the location of the inode bitmap and the blocks in the inode table.
This means it would be possible to allocate inode tables anywhere
in the filesystem as needed.

A new "EXT4_BG_NOINODE 0x0100" flag would be needed to mark a block
group without any inode table/bitmap (to reduce the number of inodes
vs. blocks), and similarly a "EXT4_BG_NOBLOCK 0x0200" flag to mark a
"blockless block group" that only has an inode bitmap/table (to add
inodes to a filesystem without increasing the size).

The ext4/e2fsprogs code would need to store the number of group =
descriptor entries independently of the total block count to
add "blockless block groups", but only the flag would be needed for
"inodeless block groups".

Unlike your "inode_count_modifier" (that moves blocks and renumbers
inodes), it would be possible (with ext4/e2fsprogs changes) to add
add new/empty inode bitmap and itable blocks online to an existing
filesystem (which must have some significant number of free blocks
for this to be worthwhile to do).

It is _likely_ also possible to online remove inode tables/bitmaps
from an existing filesystem by marking block groups with unused
inodes by setting the EXT4_BG_NOINODE flag and freeing the blocks
for the inode bitmap and itable.  This would only be worthwhile to
do if there are tons of unused inodes (as in your 0.1% use case),
so the chance of completely unused inode tables is very high.

Something like patch =
https://patchwork.ozlabs.org/project/linux-ext4/patch/9ba7e5de79b8b25e3350=
26d57ec0640fc25e5ce0.1534905460.git.jaco@uls.co.za/ ("Add =
block_high_watermark sysfs tunable"), but as a
"inode_high_watermark sysfs tunable" could also be useful, to force
new inodes to be allocated below some cutoff.  That would avoid all
itable blocks at the end of the filesystem so they can be freed over
time (possibly after doing "cp -a FILE FILE.tmp && mv FILE.tmp FILE"
or similar to reallocate an in-use inode below the high watermark).

Cheers, Andreas






