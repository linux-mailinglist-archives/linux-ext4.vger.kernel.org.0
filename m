Return-Path: <linux-ext4+bounces-1231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3948556D4
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Feb 2024 00:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1751C20D20
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Feb 2024 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDD128378;
	Wed, 14 Feb 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="EW+PAO8w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB084502D
	for <linux-ext4@vger.kernel.org>; Wed, 14 Feb 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951787; cv=none; b=H5ssKx7H9aCdQsmTl4sBsvjwYFIJKfyEkiGJGuGB9vKYnyK70O/q0A7w81tzCGgD2hnuYSXA2RG6AqZLBM3rieXNDSd+VH0ga0+TkhG918L82v3JQCwH3dsF5VvNmAHnPY8GhX1BLjOp7X8aKk5GYiAxeehpxf82GUy/fyfyLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951787; c=relaxed/simple;
	bh=i+Ad/00mN9dOyBean527HT2Uzd4VmZRyOlvkxqF9GHg=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=tRWDGSSnb+9OsgLXiI+3Bimouom3pfKBBPS4h3kIsBTgDFWc18M5BpzbLUbEvXP07swFJrspk8RPDgGQ07DLCNheiVqqWO5TpJbwA/uWQSlSerjeh9PV42oguB+n/E9B4uiUQKw7cSJe5mlYakenudWc1Hd8rtRtkZTllzMJmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=EW+PAO8w; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a31c14100so112043eaf.0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Feb 2024 15:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1707951783; x=1708556583; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3DFzFU68c6gu5CpuxPYUGTqf5vyth9/IogRH8pIwYg=;
        b=EW+PAO8wr32sLgHPn2PJHXhmagM29Vhi6emubf9ccxejsf+ZWPsgixVuGd3xc3alsR
         QAMmWSHpsy4JwsWssCWxDz4Mx8E651tRWPvQYe4I3PwVAhIYessRLecXFqESekOHfGY0
         JvyyfKPxlBoXm+/OOWX3LjSUq+zcYArJMh+d4ihSVlsnrncry7i/JU5CidTaEGsXh3OO
         QviqlxG6eT/lB/4hPADrfrBDQJrZIWYPoYc9b/GLpfs/FoZlHGFvY6c9lMi7XDcYYUJ+
         E+CHh3wIJHB8iUAi+M/T12AC8BKrWHZh8qnYpgD2w7NMZfcB9xX+TJHHIMTwXErs+jsE
         igYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951783; x=1708556583;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3DFzFU68c6gu5CpuxPYUGTqf5vyth9/IogRH8pIwYg=;
        b=fxMsWQUBh6fgNhKStoITglA2evdM7A9w/NExgixDjxD6LZveROK4vEEGx7jaghygtv
         QTFLQ4uCuhG3l67kM7lfufsPxzU2/jSLsFsDwQN03DxeT//zVQYhV0G0n5MilQnv5d5e
         9x/dUjTbTl6Rb7xp7SZs8F7t6fDiirZbV9XFMlmoc0pXABOeHf18A/l5k1cCqhjS+tUN
         Ww6yQps7s73/haf8g32B2c5AKQkte4U0HstLNaiwBGM7o8+VhZ15i3Qa4P8vYMidE/7T
         7RoJf8Gk9itNBZiNG7S46BLyUz46qaHJXv9+wLrNvqHUDDa2jbrMgqee2KvdMpkwO8gt
         MvSg==
X-Forwarded-Encrypted: i=1; AJvYcCUp2CEF6hJltk4hMg3bpGpfE1pWroNwpHvdzp7aCUbno06hNUIydvOy444vQRv0tuSwIDNvTFQbwER1stoHzSMagWUFitpewcwvpw==
X-Gm-Message-State: AOJu0Yxe/olh6cGDp1W9nV8AovOeBw7kcScPEE/zdMb9f9Trs/wBLf4P
	mnzvyit7qELwMwX5LqTmVxgHS10ZamcaQd8ux9xh3jxgmX0xgYwhUyOqD/UBwBP6aJ33uG8k8Ft
	d
X-Google-Smtp-Source: AGHT+IEYPZupQVY1eRYHpqj7a65VaqXPFhx3JkwFGc754Cs/QpbzGyu8NBED0f5oIMc8cFuJ91BzKA==
X-Received: by 2002:a05:6358:e497:b0:178:7d98:f7ab with SMTP id by23-20020a056358e49700b001787d98f7abmr4447563rwb.15.1707951782833;
        Wed, 14 Feb 2024 15:03:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcasXtaRydyLK8Nk00xICmt/jYHwzDZIRB2OKdSHUtYPS1Ss00zV/GCRvCCdbYo9/CGiOgN42H3xEQLJziMfokA7Cil374MphEoA==
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id it18-20020a056a00459200b006e118d2db93sm712785pfb.125.2024.02.14.15.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:03:02 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <4AC7AEC3-25FC-4147-9C62-2CE5A1686199@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B704EF62-C594-4F51-9EC4-2B34EFFEB9F3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Don't report EOPNOTSUPP errors from discard
Date: Wed, 14 Feb 2024 16:01:57 -0700
In-Reply-To: <20240213101601.17463-1-jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
To: Jan Kara <jack@suse.cz>
References: <20240213101601.17463-1-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_B704EF62-C594-4F51-9EC4-2B34EFFEB9F3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2024, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> When ext4 is mounted without journal, with discard mount option, and =
on
> a device not supporting trim, we print error for each and every freed
> extent. This is not only useless but actively harmful. Instead ignore
> the EOPNOTSUPP error. Trim is only advisory anyway and when the
> filesystem has journal we silently ignore trim error as well.
>=20

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> fs/ext4/mballoc.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e4f7cf9d89c4..aed620cf4d40 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6488,7 +6488,13 @@ static void ext4_mb_clear_bb(handle_t *handle, =
struct inode *inode,
> 		if (test_opt(sb, DISCARD)) {
> 			err =3D ext4_issue_discard(sb, block_group, bit,
> 						 count_clusters, NULL);
> -			if (err && err !=3D -EOPNOTSUPP)
> +			/*
> +			 * Ignore EOPNOTSUPP error. This is consistent =
with
> +			 * what happens when using journal.
> +			 */
> +			if (err =3D=3D -EOPNOTSUPP)
> +				err =3D 0;
> +			if (err)

I don't see how this patch is actually changing whether the error =
message
is printed?  Previously, if "err" was set and err was -EOPNOTSUPP the
message was skipped.  Now it is doing the same thing in a different way?

The "err" value is overwritten 50 lines later on without being used:

        err =3D ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);

so the setting "err =3D 0" doesn't really affect the later code either.
What am I missing?

Cheers, Andreas



--Apple-Mail=_B704EF62-C594-4F51-9EC4-2B34EFFEB9F3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmXNRmUACgkQcqXauRfM
H+C8eRAAjGZln6nX+nfX3THOmJ6QSNO4b9k8MmbFYKbY0FRXroS9b1S4zjOSYVy5
JODdoeBEWnYwqH2Gtz7KaQAn/SsGnSYhlFfwB61H85sLD6Vw0zggOCySByRHx+HP
bLoJuMmCGcA0SZSv/l94/zsHXjrnMhIrDd2DU+hLimcee8X71u9ExwE2DuR/44jK
7NQIWJ+cKwBDNvZx2ioV3J/Oz9kvARc5gssM5jKCIkiCFmPBZs14uBxgEKTjwdqt
VHQVYrBj3YruLZt6MLASkHAMrVAwMwfium8VqOrii/hAgQfPHOIg17fP7m+2mCER
Lj94CL40nGfzGKLmfqXOE3uDPLz7NAFb48l9uVQGWoR7H2FSpp/YITa0KCGNTF+X
lwCBtVGPESs9HxeiO9XCy/Dgj1ZFLq36kNTcQhkWcOr+pAHJdKlnZIWP2U++1yCW
w3DVEDea8XCOkrnXIJ8LGM4B3/RTWp/khcRKfV7AfBTGqzKFxUfq0Yl4k5fZwf71
AyCxYyjXF3Am3pG8LzNCyGpYW58vuhgWK6uVVyMGVkl80VDnF7Q7lYY7do9eo3x/
W6i7vW9JoevIF7AiZ8FNjHRQ+KNwZl7YFUWVWjAVgRvftgpUHefaHI9LpR7S5/jb
qImY6Am6YxFMtwIRcuy3075Gs0H4fshkKj/1dUIMLI91ub3ngTA=
=4z1W
-----END PGP SIGNATURE-----

--Apple-Mail=_B704EF62-C594-4F51-9EC4-2B34EFFEB9F3--

