Return-Path: <linux-ext4+bounces-10435-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71CBA4FCA
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 21:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98E4626A72
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE025E47D;
	Fri, 26 Sep 2025 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="oTy2/g7Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF9216E24
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916041; cv=none; b=H6cwq8EWlBF36amjgUiY8AWchE9gibeBEblc8CKGixjg/rCH60Ts4jl4vXlzdNnuwXPRBW2rwOWHw/iRLlWUwaQh0P7+Rr9ccs/Er5jbuGhlhOwJyNgm4GwE6OZmIxYZFUhBMAb4qbcm1zmt+VVA6fc63IIobF87tNd336okA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916041; c=relaxed/simple;
	bh=HPaVAuRuTJswVN45TXy83sLBIGhAZB8tTH7PmUuFjnI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ZXTimsCx58Diyq5AIr9n5P0zT8SNVwxMUb3NRcfFYtDJm1jkfPEog2+iDNgjYxXE7YbLGChVd5PBztWqaFwUp2aC9bVqAuAPIXMamHu2Sz6SIVh5Cnj8JImyIOjj9gy7hCZBTHX74MBAHn9ZLdQqjvW8MSBMcCOF7NjYcrsYLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=oTy2/g7Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78104c8cbb4so2494004b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758916038; x=1759520838; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vKbLv7mEVI0OYALWiwuznAmzQk1XbRr/AfUiG9oWD0=;
        b=oTy2/g7YyVlvJe0nFjK9vYLn3mk6W2nZ6xJVUiGNCFypVb5tyXnC9++5urxZMtugkx
         3jy4YvpsrDIDDbqRmQqERZtTytnqKe2Z+PsU65vJ/d6JWtJpwd9gnFcwVDtLSrShR2ks
         LzrPogB13YTNg4p88J+MBRul8ntSmO1BOCRorfYef/59gyABTlvk34qS8Xguq4g3M/fa
         h+aFDY0lLD9CHC70FnZ9u6iYDO7lYuvUi8i8VwsDm+G1i/ERvtYZA0YggHO3RGjIjnYc
         KIebBlSli2pkcjpKY6MiauSOQ80jGFeGw+CRpogqw9vCIxm2zJZM3Q0rzGmIXVyX7MmH
         kPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916038; x=1759520838;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vKbLv7mEVI0OYALWiwuznAmzQk1XbRr/AfUiG9oWD0=;
        b=Ld5dM1xFltXtGJN+IoPeSxQvuVQoUU+tROQispWKfApFyoyW+S9ZiBbQhZbq0y04Gj
         j2y2KvSmgFZejU52Z6L02tRsGOHc/DmThCWHrzHSHHthEZ9bK8TMr+bviGwmh/3OScpd
         DBpMPguvVhAj9TO47FQwcIA0hGmaMXs/BZ35bTHmBB3nNcuY1n+xbTToY+UtBFbtli1r
         kRujfQMXiEh6fC+kI1NC2j2x5qbPBeZSPYuUeRsOoszpHe6Ch0v1iJHiUZxGDiUeEve0
         qq6BWQZ6Y0WLcufKMnqvBT7+bDuruzqc2xJcSW+OwhyvvZ9WGOBuH5B7661F9aUxzR1z
         i1xg==
X-Forwarded-Encrypted: i=1; AJvYcCVWrvBAePX614zOvOg5eaDS7oY02+EB2uUHRIGhWNMYBSZFgiq5rD+EsmDDOwwvC7x7NJ7gQK5ID2KI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4PjL5Pyd97/CXGIicja9pOQDxxSTcvqrL738/AwZoIveqeptd
	gY6aJ2hZ8Xtwejdp/DG/UyfLXS8YWTVk+2H7OS3oxPmtZKAjSEXEhSdYKljqsclK08VH/exHT/k
	f9vv3O/M=
X-Gm-Gg: ASbGncu9YFNxX/yPrzhIbp+MS+1hT45YUjuqixTlb157MYw1JTEHpv8asTrg0keyJqp
	73MFOyF7BjKNAjqdxqAjVfUgG6uIag7Uw5uSWK6/8lUm6DPFaCu+ULLwkWTi9EfRo368UswbbP1
	vSnI4W/NRK2q97QdQhEuL1RpZGTA0NZe/uA79HZuZTx+Gmfw1DaM3hlA834uTw+HWzNWWpKT7pA
	bLQaH4RE2bBOIx9gsAkRikuliXEN37vFIpWptHlLNfkKv9j/yXbp6cHjwcxnCB8DnJoks6NHEjg
	fkKgCZTOGWA2mdq3XN7MGrX4JhkJQSuMznvGAOcX0NLskplT+4abmT4ckmLy3VdIcnWV10stDwt
	M2+gbeHFRKNM22EL9R71rn53AMgL4hPcDQhFR6IOPdodAQwitL9gUMi57Vi8LtKBwD84xsOQ=
X-Google-Smtp-Source: AGHT+IFDZU0EFE6H1tvLitbzjqzBNnMPB8Axk2FM9jlZW1MmBU1qz0A4i/mnJHPrqzJByLB8sSIXyg==
X-Received: by 2002:a05:6a20:958e:b0:2c8:1ab8:596b with SMTP id adf61e73a8af0-2e7d7363bfdmr8917706637.60.1758916036892;
        Fri, 26 Sep 2025 12:47:16 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e7e7sm5206470b3a.16.2025.09.26.12.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 12:47:16 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <0093DAF4-7036-40EA-9051-082D3CD2115A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FC48A6DB-9915-4E71-905D-37D00589C192";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Date: Fri, 26 Sep 2025 13:47:14 -0600
In-Reply-To: <CADhLXY5mSwFEXo3BdupqycA-VC96WqKfmqNDq7MYM-_SRFKWxg@mail.gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
References: <20250923133245.1091761-1-kartikey406@gmail.com>
 <AB6112E6-A3CE-4232-83C6-9099463A7AA4@dilger.ca>
 <CADhLXY5mSwFEXo3BdupqycA-VC96WqKfmqNDq7MYM-_SRFKWxg@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_FC48A6DB-9915-4E71-905D-37D00589C192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 23, 2025, at 7:10 PM, Deepanshu Kartikey <kartikey406@gmail.com> =
wrote:
>=20
> Thank you for the feedback on the e2fsck coordination.
>=20
> You raise a valid point about the complete repair workflow. I'm happy
> to work on a corresponding e2fsck patch if that would be helpful,
> though I'd appreciate guidance on the preferred approach:
>=20
> 	=E2=80=A2 Should I proceed with the kernel patch first and then =
work
>           on e2fsck, or would you prefer coordinated patches?

Coordinated patches would be best.  My concern is that the check in
this patch is essentially causing the filesystem to be aborted, then
there may be no way to repair it before remount, repeat.

*NOTE* I haven't tested whether e2fsck already handles this scenario
correctly, but it is definitely worthwhile to test this with your
reproducer image to see if e2fsck already fixes the issue. If that is
already the case, then there is nothing more to be done.

A quick look through the users of e_value_inum in the e2fsck code
doesn't show anywhere that is checking e_value_size > 0, but the
e2fsprogs xattr  handling is spread over a few different parts of
the code so I might have missed something.

If e2fsck does *not* repair this error, then the right workflow is to
make a *minimal* filesystem image with this corruption and use it for
a new test case.  There is a "make testnew" target in tests/ that
creates a "f_testnew" subdirectory with an image file, then you can
mount this with loopback and/or use debugfs to create a large xattr
inode and zero e_value_size (not sure if in xattr header or the xattr
inode size, or maybe do some combinations of inconsistencies.

> 	=E2=80=A2 For the e2fsck side, would the appropriate fix be to:
> 		=E2=80=A2 Clear e_value_inum when e_value_size is zero, =
or
> 		=E2=80=A2 Remove the entire corrupted xattr entry?

Probably there is no benefit to remove e_value_inum and have an xattr =
without
any value, so it would be best to just remove this xattr completely.  =
The ext4
code should never (AFAIK) create a zero-length xattr in an external =
inode, as
this is totally pointless.

> I'm new to e2fsprogs development but willing to learn the codebase if =
you
> think it's valuable to have matching fixes. Alternatively, if there =
are
> others typically handling the e2fsck side of ext4 corruption fixes, =
I'm
> happy to focus on the kernel patch and coordinate with them.

The ext4 developers are typically handling both sides of the story =
together.

Cheers, Andreas

> Thanks for considering the broader user experience - I hadn't fully =
thought
> through the repair workflow.
>=20
>=20
> On Tue, Sep 23, 2025 at 11:34=E2=80=AFPM Andreas Dilger =
<adilger@dilger.ca> wrote:
> On Sep 23, 2025, at 7:32 AM, Deepanshu Kartikey =
<kartikey406@gmail.com> wrote:
> >
> > During xattr block validation, check_xattrs() processes xattr =
entries
> > without validating that entries claiming to use EA inodes have =
non-zero
> > sizes. Corrupted filesystems may contain xattr entries where =
e_value_size
> > is zero but e_value_inum is non-zero, indicating invalid xattr data.
> >
> > Add validation in check_xattrs() to detect this corruption pattern =
early
> > and return -EFSCORRUPTED, preventing invalid xattr entries from =
causing
> > issues throughout the ext4 codebase.
>=20
> This should also have a corresponding check and fix in e2fsck, =
otherwise
> the kernel will fail but there is no way to repair such a filesystem.
>=20
> Cheers, Andreas
>=20
> > Suggested-by: Theodore Ts'o <tytso@mit.edu>
> > Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3D4c9d23743a2409b80293
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> > ---
> > Changes in v2:
> > - Moved validation from ext4_xattr_move_to_block() to check_xattrs() =
as suggested by Theodore Ts'o
> > - This provides broader coverage and may address other similar =
syzbot reports
> >
> > fs/ext4/xattr.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 5a6fe1513fd2..d621e77c8c4d 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -251,6 +251,10 @@ check_xattrs(struct inode *inode, struct =
buffer_head *bh,
> >                       err_str =3D "invalid ea_ino";
> >                       goto errout;
> >               }
> > +             if (ea_ino && !size) {
> > +                     err_str =3D "invalid size in ea xattr";
> > +                     goto errout;
> > +             }
> >               if (size > EXT4_XATTR_SIZE_MAX) {
> >                       err_str =3D "e_value size too large";
> >                       goto errout;
> > --
> > 2.43.0
> >
>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20


Cheers, Andreas






--Apple-Mail=_FC48A6DB-9915-4E71-905D-37D00589C192
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjW7cIACgkQcqXauRfM
H+ANERAAmVNzDAEi9+A4aq0Rs5x3afVlq3YuH7BsFgNrlKJCRik8kSaajCQHj3ne
vAuUMRsPR5Usc3n7aqxKLCO97adBCqKFVCrYX83jXrXeE14jhSfhL8mZDfueGXVF
G/w9fh/wNEnrp6VYJM2wab86aTWDgvCQJMGQxZw0wvZ3vlWcUf1NH8xKsA0Gei9I
mPPKFIQ3KNXgEdejCS7StDotjQtMWnuTbScAuwolp5XeTyIBO96F1EonOcNFNlop
Ywy9qYaykDFlvL4MWkmQUiM3d8lZ9XEyC3NQRZJ3ONSZjoqdrGRtaQgoFam+nrZQ
XAH2jOju68ia1HEnk+e67UKir+Iu4IcoWkrlalagF4DPDdZCkMm7fKzqfQn3hw/b
sv0YnUNcLIFyQMEMg9KQ1spoSvOKJ/V6PvLshqsR8c0lv5nN9QYbFIFTgwHqWJrA
BaYMMKhZnh0I9RpYzugZnIjLQOQdk//H24n8Hb6dz4sikd5El6GLDpGjh660SsEw
2/5w8LsF5TR3WkpfuOKQN7DuImP8x5pUpxs6vwVMYhwdAxJcmg5MfEnfc0vB881P
/iEdRNjb8O+1ysCO7/o3iwowihyEeRKos/QrqzpJmYP96/7+axnGcESGnFO3ZTVO
5X3BiPB2YbKa9ScUiCW6mpROLkbTj2XHTWBkgQ/FWFYVxEft3WA=
=O++U
-----END PGP SIGNATURE-----

--Apple-Mail=_FC48A6DB-9915-4E71-905D-37D00589C192--

