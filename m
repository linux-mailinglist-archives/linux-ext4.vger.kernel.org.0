Return-Path: <linux-ext4+bounces-1372-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522D8604C7
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 22:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BA51C2492B
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93912D1F6;
	Thu, 22 Feb 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="l7jCn3SQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4473F17
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637170; cv=none; b=Y1NzfemvvJ2FsFqtTX5KMFaeZvcQGLAJ2fF/HEnlN7n/2Fsyrhr3G0Snd8shmT97Hk0JQyR/T3KkIrAyOD/Yl7pkXRJW5KpKTjIh05nLLCzBabwRE4P0m2jnr3z9ycFU80uXhqzHSiuEmxrvvqjx3VgMe/cdOK4NBWCI02VShGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637170; c=relaxed/simple;
	bh=MHsc9y9o0S6pYXsQnrQZFSFCOgC+plX2o/Ziuz9ZErg=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=XbWAV0RQllwYwdhbzBysYY6P/i6Vo4LNBRr4B9nH6XHgSOBo/yWJu0gWC88sAdBLx/yxu3cGMAw13Q6dxLRPVA4xcUMLLNJQCeX3HeH50CauetFOLwFXwHyiib4V5eeydrEaiNWWHBy7vasF+qsSXmYEYtgLhvhregxg82yOe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=l7jCn3SQ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso5564139f.1
        for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 13:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1708637165; x=1709241965; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQaXoJ7Pi0NM1BkRHWeLKUVXz4mEOBpyYSOVpQgU8WU=;
        b=l7jCn3SQBIjEbFQXEiS1ZOzmD2FhGMuF7+/jsEXmR+s+zi6LuDIv4/T9uLIOxzfWxf
         2cVq3YPAHBnsSnheDluYoc2L7L9msY2sEeDzWyMDGjiNGPvD32GW6s7u2nK8/4DxQBcH
         YdYRD5KejKUwgVS0KQPhPms6oFiVDDR8BrH5Fwcuta2Foy3ny4H3sssKdLKi9mGcDpzf
         WK4MxcXGWEdqUb6pgmhoKs7nvUIcfWafZIyl8YuifICHCbYoIit2vkXMP2jn1MVXnjs9
         JJlH5r4WxUnIP931VWJNFNAWwvw3rgcx7wfUA9J/T3dRqD/kGSM4E7Tlt2wOagXD/0oO
         aNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637165; x=1709241965;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQaXoJ7Pi0NM1BkRHWeLKUVXz4mEOBpyYSOVpQgU8WU=;
        b=l5+sF79ywoPGCQm+85eoVLju1B3iOrLRgkfz2o3PtbCRzzsTNO2ZfhXMVD5pYE6309
         dJHC7czrw2AM08olswWJ1fJmaAy4oMuc/Sz8m6zpnRbBk6dtEZVKTmRo3nNSyNffsmK9
         gOX5+0GOBDw7vYbDAhg0sqmI6GA3XTKd5M2rlwO0yALLiJLNVY+b6vUYtg8oPORp1N69
         3AfbdAj8s2tkf0+uWWlppjaxqFulGiuACVJ9bxJRAzd5s10DfPHS42BQCKag48k4Zqey
         Jy+Q4dfp2OuC/aFqzqOYPeS6R8FDGubTYrVXEpJLSO4YF/WoeN2dmQrMoNsi7GMwtvLF
         IUlw==
X-Forwarded-Encrypted: i=1; AJvYcCU+VbSUiLstguQ36wcvEPKKR2vGrEOUtqREDHiJhs3zGpko0AK34SWw128J7VYHFN8uzmAwkAKGXmtXFkstgnBEp1HmtrU0jREznw==
X-Gm-Message-State: AOJu0YxbTsDG5ESHvKgAZgHH506CCVLNKemyEBSEXRSOdG97dxaNIpUo
	IT0PBBpQvq6pUTmUK2pR0e11Fx8DM6VWACIOPy3jS+KlLDYqmdwktaV5KbQ+g+WLE2yYv6dWmsn
	y
X-Google-Smtp-Source: AGHT+IGepzcbipaYvaC6DXBgQbMo8zCiQ0Jy3GJluG4MhU1SKbfqsr8ZvfFgJXVszksWQTzrOok/jQ==
X-Received: by 2002:a05:6e02:1a02:b0:365:245c:6c9b with SMTP id s2-20020a056e021a0200b00365245c6c9bmr199043ild.13.1708637165178;
        Thu, 22 Feb 2024 13:26:05 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id s22-20020a63af56000000b005dc507e8d13sm10998155pgo.91.2024.02.22.13.26.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2024 13:26:04 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <AF20B4C9-57F1-40B6-B095-621B59D9B2E7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8E572A28-6950-4690-8384-ABC81C02BA86";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Don't report EOPNOTSUPP errors from discard
Date: Thu, 22 Feb 2024 14:23:38 -0700
In-Reply-To: <20240215094635.p5anw5w36snmqwsh@quack3>
Cc: Ted Tso <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
To: Jan Kara <jack@suse.cz>
References: <20240213101601.17463-1-jack@suse.cz>
 <4AC7AEC3-25FC-4147-9C62-2CE5A1686199@dilger.ca>
 <20240215094635.p5anw5w36snmqwsh@quack3>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_8E572A28-6950-4690-8384-ABC81C02BA86
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 15, 2024, at 2:46 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Wed 14-02-24 16:01:57, Andreas Dilger wrote:
>> On Feb 13, 2024, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
>>>=20
>>> When ext4 is mounted without journal, with discard mount option, and =
on
>>> a device not supporting trim, we print error for each and every =
freed
>>> extent. This is not only useless but actively harmful. Instead =
ignore
>>> the EOPNOTSUPP error. Trim is only advisory anyway and when the
>>> filesystem has journal we silently ignore trim error as well.
>>>=20
>>=20
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>> fs/ext4/mballoc.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index e4f7cf9d89c4..aed620cf4d40 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -6488,7 +6488,13 @@ static void ext4_mb_clear_bb(handle_t =
*handle, struct inode *inode,
>>> 		if (test_opt(sb, DISCARD)) {
>>> 			err =3D ext4_issue_discard(sb, block_group, bit,
>>> 						 count_clusters, NULL);
>>> -			if (err && err !=3D -EOPNOTSUPP)
>>> +			/*
>>> +			 * Ignore EOPNOTSUPP error. This is consistent =
with
>>> +			 * what happens when using journal.
>>> +			 */
>>> +			if (err =3D=3D -EOPNOTSUPP)
>>> +				err =3D 0;
>>> +			if (err)
>>=20
>> I don't see how this patch is actually changing whether the error =
message
>> is printed?  Previously, if "err" was set and err was -EOPNOTSUPP the
>> message was skipped.  Now it is doing the same thing in a different =
way?
>>=20
>> The "err" value is overwritten 50 lines later on without being used:
>>=20
>>        err =3D ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>>=20
>> so the setting "err =3D 0" doesn't really affect the later code =
either.
>> What am I missing?
>=20
> Yeah, the code flow is a bit contrived. The error message gets printed =
by
> ext4_std_error() at the end of ext4_mb_clear_bb(). I don't think =
there's
> any ext4_handle_dirty_metadata() call in the current version of
> ext4_mb_clear_bb()...

I had meant to reply on this thread sooner...

Does this mean that no error will be returned at all from FSTRIM?
That means userspace will just keep pounding this ioctl indefinitely
and never get a notification that it is the wrong thing to do.

I'd think it would instead be better to also skip the ext4_std_error()
in case of -EOPNOTSUPP but still return the error code to the caller
so that they can make a better decision next time.

A patch recently landed to lib/ext2fs/unix_io.c to do exactly that[1] -
skip calling ioctl(BLKDISCARD) a million times if formatting a =
filesystem
where the underlying storage doesn't support it, but I could imagine the
same is true for other applications that want the error to be returned.

[1] =
https://patchwork.ozlabs.org/project/linux-ext4/patch/1683695929-26972-1-g=
it-send-email-adilger@dilger.ca/

Cheers, Andreas






--Apple-Mail=_8E572A28-6950-4690-8384-ABC81C02BA86
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmXXu1oACgkQcqXauRfM
H+C2tA//XspdwACyIsMa0ByNXZjjGXTv7h2jiMrz7SMN1nF9xFQAHhfsi5GA5w3E
wa/4XxLB1FiLsgFTISIEt6+RRL/5C38CKrNvLyL8SR/GDOht6DZVLF6fpV7yfFF0
XLQtoeM7mEL05i/xvVriLIeRgtahcdswmnzL66UhC0WZ/0YxeVTgZVvSA21gAGWY
DRAgXcwaeMgoqCp9S/0IrZV6TyFdJhf79Q2wHLuPcGwAbMFaCuAKCbJ6sN75IEWK
Hcob+56o6vKjZf8ihlzPg4b86Pu8TpLfINYk/GOTAujYpXHCRZlcGdi2TapNTGZJ
PmRLv9gOmyWXaFSGepXK6hAY4MgYTc4/COqYp9oqKWeiCG9pe23MBt+nR1JKWpcJ
o1caj0AyRlkBNqEhctCH7p/UnXtYKMLi250Q0YSH8fpIAdG03enIGZYN647yxyhU
/ldehyZ1W4OrhlmdYIKd8nvfL39iyAqIZk+gCh7zrvHuFcnK94Fgdpb1ZaFeKWR/
PA6DrEzgxQziYJrOyq6pz9uRymyMDLPvq9oMDfo1XNG3ZuwdJDsdmRMmgh6wm/1k
AMGzqC0lh5ohJC8s7yKSH2wp0jj7J75L1lc+SDnmq+s+oVnneKiAv9a/h6tMTOmt
zYgOoNRYx04KSzwou0/aPc+IxBL3tGqklswZkDEI0KGsvmD8OxA=
=FZeN
-----END PGP SIGNATURE-----

--Apple-Mail=_8E572A28-6950-4690-8384-ABC81C02BA86--

