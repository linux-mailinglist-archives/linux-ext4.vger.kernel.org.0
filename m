Return-Path: <linux-ext4+bounces-3649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB6E949DB8
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 04:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49644B23C03
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D618FDAA;
	Wed,  7 Aug 2024 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpZ24afH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52C1A288;
	Wed,  7 Aug 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722997254; cv=none; b=oz0lXP9rdv5+kPupDoo7hbniIjdi3F235HWrlhnx9tVnXMVwrVyABZFDCMiqlv5xRJHL1MliKqaSREhOkVjxg+3pW0oQ9fiKneqJxdSfD2Clj10R9fIuNAMOPWdjqpT1wAIkiZPzU4gCOdY02j7Pok6lmD5yr8boSQPuYxaUlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722997254; c=relaxed/simple;
	bh=iVPMyh7XC8IApwKW4VgtbuBA7H8TTp4PRxujFe+p0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhKZjWbUvXf6lAEak+iXXaTYff+bi5JajTVRduu+swi+petIAw7GxIVZgiWhKkG1FTpxirfUxXTdOaFwwuvQtubPrc3OkzQfO6DSpxOKdprYdKki8HCB1w3Zbdqln1f8jKnpoOhG9TiNy1+jKpneOY+YH5byTrDirdF7aPdCpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpZ24afH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d42da3baso73145285a.1;
        Tue, 06 Aug 2024 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722997252; x=1723602052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjPrUZGfj22iahOm+dDJ0cgNV2eFfCVEfwCrhq8bOEk=;
        b=fpZ24afHwfY3sXCrdRr1yBfnmH0b2hx6utEQnIXDqILUd03hY18ntMzVmlVjGNkYVd
         BgNjPjPzmO1x6/lay3lJy0atI7uCJmsbSa0ar3U5a32l8iuPm5fYe/TWOk12R6670d6D
         OA4ckbfZQ0cJQ8DozzyLQjhfs99/VlLfR9NPG3+yZ8wArai7EDNSi1AWodN6wrcscESt
         rJHs/s+W73jMpVs1XnlO9xY6jG26zfIgi6F60kqTWD2XdRMsjGiSlXknEkYzab3p5qiO
         kDKaOrpRL1AWLRpGhmaNfarAB2EaZcs4dN3HqF6FgD4nM5tK2vUPfF0RhvzDdgj133Wa
         oJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722997252; x=1723602052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjPrUZGfj22iahOm+dDJ0cgNV2eFfCVEfwCrhq8bOEk=;
        b=stW76f/Vdut7YPAUfATE6TaA9h6myUi0qF70o8flcQv4JBtEvOH/lnGlW78fQnHA6g
         p0+C2CNEJ3f2Je2/M02WO5DZaKYRJCDG2qwadb6PGxYiw7qcmUUWUf/NuhFrQ1jMU8qk
         g4/KsS4IyT2SnaQ5avWhyuhbgtR7mIRlxsXgrN16RsNlkouIhM+0E3VByFqvHJ+kdS1k
         SY+eAKaSVI+wD2Yqr96NbrkypkMKvY/b4pDA/rn9xCnYktXBGdPiO4S+XWmNK79mRrVM
         wEiK4/dQ0hof8CvSSlDsb1n3clsHKv+meq2U5SFgGMPsixZn2iAHXaofdPWnJbq1T0J1
         n1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOOniwQrlzShP01c32bcv5hHlesQIB+GL0P/btXwddzSOC1NYOY9NOASDzozjC+SpOQ5X/D2o0Qp/5RVy90Jy+oXlJCs09ZmcZoihQfUVHYlHQ7CUnEcSQKxNs5XxQ8aBQNg==
X-Gm-Message-State: AOJu0YzSYd4s9AhlMBcU1HKkJc/dffxsynRVi3G9XCF2DaC3kWVTASKh
	GT5z8wUoeaF47FiOLzibspercZMur9V319PB9kXKrGk4ej4e9GIFLNujug==
X-Google-Smtp-Source: AGHT+IHYvlA6QQz3GuXKZIYToj1njGWRgkiR+EuB+8puJVLHEUxcvPBgV10/Jc89/VvXc74lZ070Iw==
X-Received: by 2002:a05:620a:370c:b0:79d:62c4:d636 with SMTP id af79cd13be357-7a34ef3c3a3mr2268377685a.26.1722997251735;
        Tue, 06 Aug 2024 19:20:51 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d2b56sm17809785a.17.2024.08.06.19.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:20:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6F2811200043;
	Tue,  6 Aug 2024 22:20:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 22:20:50 -0400
X-ME-Sender: <xms:AtqyZsYbHAhbvzTeQVG-jqfjMWORntuGzIja9o7kbkI8B0NoGRw-lg>
    <xme:AtqyZnbTaUtYkNS8Xaa_d6B0OqPx9DyH1UVSg6AHVVPZDL6rbJvvlD4f4Ehq-attJ
    d2p1XpID1NTOYA48Q>
X-ME-Received: <xmr:AtqyZm9lM2xr4mOcW4IPnN7gpcVZOND1kg9ZO0aYm8EmIK6RUAtODaRt1S7NN28py6gfSDdFPLo1QNZR7YopiYx_fORBVXaD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveehfeehgfeuueffieeffeevteeigfdtkefhgefgleeufefgtdegfeekkeel
    gfejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuggvphgpmhgrphdrnhgrmhgvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:AtqyZmpWO0h8TRXGtUkEzKFPPCZ0t7AAyqzzZ1OIwzmvFYdsuF-1XQ>
    <xmx:AtqyZnrL4uL6EDLCEUuwJx2NmAcxTgjaAvq5e20eP8NSCAjeMNDrzQ>
    <xmx:AtqyZkTbvj4jeBHZVRZePyQVB_7V1aCqiB6MzrlVJ7RuQVS5puKEVg>
    <xmx:AtqyZnoFkL15li3UF_hHRujD8L6ThN2Mq-fOIWEfqFomycjDcorDSQ>
    <xmx:AtqyZs69ZvyZrvAeoOG4AQeHwWHIInWM6mxLZpQFhx4weF5d5QSHiJOS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 22:20:49 -0400 (EDT)
Date: Tue, 6 Aug 2024 19:21:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: ahmed Ehab <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] locking/lockdep: Testing lock class and subclass
 got the same name pointer
Message-ID: <ZrLaKCEJc8FqI38I@tardis>
References: <20240715132638.3141-1-bottaawesome633@gmail.com>
 <20240715132638.3141-2-bottaawesome633@gmail.com>
 <Zq1-3bClxgBlhnoq@boqun-archlinux>
 <CA+6bSatQkwonesz4Pa3S7E-GAWHCwq=xuo_E9e3gXfJwV5_-jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QvzP0FT4f5Il3vXZ"
Content-Disposition: inline
In-Reply-To: <CA+6bSatQkwonesz4Pa3S7E-GAWHCwq=xuo_E9e3gXfJwV5_-jw@mail.gmail.com>


--QvzP0FT4f5Il3vXZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 06:00:11AM +0300, ahmed Ehab wrote:
> On Sat, Aug 3, 2024 at 3:51=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>=20
> > On Mon, Jul 15, 2024 at 04:26:38PM +0300, botta633 wrote:
> > > From: Ahmed Ehab <bottaawesome633@gmail.com>
> > >
> > > Checking if the lockdep_map->name will change when setting the subcla=
ss.
> > > It shouldn't change so that the lock class and subclass will have the
> > same
> > > name
> > >
> > > Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> > > Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
> > > Cc: <stable@vger.kernel.org>
> >
> > You seems to miss my comment at v2:
> >
> >         https://lore.kernel.org/lkml/ZpRKcHNZfsMuACRG@boqun-archlinux/
> >
> > , i.e. you don't need the Reported-by, Fixes and Cc tag for the patch
> > that adds a test case.
> >
> > > Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> > > ---
> > > v3->v4:
> > >     - Fixed subject line truncation.
> > >
> > >  lib/locking-selftest.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> > > index 6f6a5fc85b42..aeed613799ca 100644
> > > --- a/lib/locking-selftest.c
> > > +++ b/lib/locking-selftest.c
> > > @@ -2710,6 +2710,25 @@ static void local_lock_3B(void)
> > >
> > >  }
> > >
> > > + /**
> >
> > ^ there is a tailing space here, next time you can detect this by using
> > checkpatch. Also "/**" style is especially for function signature
> > comment, you could just use a "/*" here.
> >
> > > +  * after setting the subclass the lockdep_map.name changes
> > > +  * if we initialize a new string literal for the subclass
> > > +  * we will have a new name pointer
> > > +  */
> > > +static void class_subclass_X1_name_test(void)
> > > +{
> > > +     printk("
> > -----------------------------------------------------------------------=
---\n");
> > > +     printk("  | class and subclass name test|\n");
> > > +     printk("  ---------------------\n");
> > > +     const char *name_before_setting_subclass =3D rwsem_X1.dep_map.n=
ame;
> > > +     const char *name_after_setting_subclass;
> > > +
> > > +     WARN_ON(!rwsem_X1.dep_map.name);
> > > +     lockdep_set_subclass(&rwsem_X1, 1);
> > > +     name_after_setting_subclass =3D rwsem_X1.dep_map.name;
> > > +     WARN_ON(name_before_setting_subclass !=3D
> > name_after_setting_subclass);
> > > +}
> > > +
> > >  static void local_lock_tests(void)
> > >  {
> > >       printk("
> > -----------------------------------------------------------------------=
---\n");
> > > @@ -2916,6 +2935,8 @@ void locking_selftest(void)
> > >
> > >       local_lock_tests();
> > >
> > > +     class_subclass_X1_name_test();
> > > +
> >
> > I got this in the serial log:
> >
> > [    0.619454]
> >  ----------------------------------------------------------------------=
----
> > [    0.621463]   | local_lock tests |
> > [    0.622326]   ---------------------
> > [    0.623211]           local_lock inversion  2:  ok  |
> > [    0.624904]           local_lock inversion 3A:  ok  |
> > [    0.626740]           local_lock inversion 3B:  ok  |
> > [    0.628492]
> >  ----------------------------------------------------------------------=
----
> > [    0.630513]   | class and subclass name test|
> > [    0.631614]   ---------------------
> > [    0.632502]       hardirq_unsafe_softirq_safe:  ok  |
> >
> > two problems here:
> >
> > 1)      The "class and subclass name test" line interrupts the output of
> >         testsuite "local_lock tests".
> >
> > 2)      Instead of a WARN_ON(), could you look into using dotest() to
> >         print "ok" if the test passes, which is consistent with other
> >
>         tests.
> >
>=20
> I wrote it this way:
> static void lock_class_subclass_X1(void)
> {
> const char *name_before_setting_subclass =3D rwsem_X1.dep_map.name;
> const char *name_after_setting_subclass;
>=20
> lockdep_set_subclass(&rwsem_X1, 1);
> name_after_setting_subclass =3D rwsem_X1.dep_map.name;
> debug_locks =3D name_before_setting_subclass =3D=3D name_after_setting_su=
bclass;

I think you could use:

	DEBUG_LOCK_WARN_ON(name_before_setting_subclass !=3D name_after_setting_su=
bclass);

here.

Regards,
Boqun

> }
> ...
> static void class_subclass_X1_name_test(void)
> {
> printk("
>  ------------------------------------------------------------------------=
--\n");
> printk("  | class and subclass name test|\n");
> printk("  ---------------------\n");
>=20
> print_testname("lock class and subclass same name");
> dotest(lock_class_subclass_X1, SUCCESS, LOCKTYPE_RWSEM);
> pr_cont("\n");
> }
> However, assigning a value to debug_locks seems very uncommon. I tried to
> check other test cases; however, they seem to rely on the method they are
> testing. Do you have a suggestion for my scenario if I want to compare the
> names before and after setting the subclass?
> Or you suggest that I follow a different approach other than comparing the
> names such as checking debug_locks in lockdep_init_map_type and returning
> when we have multiple instantiations for lock->name?
>=20
> >
> > Could you please fix all above problems and send another version of this
> > patch (no need to resend the first one)? Thanks!
> >
> > Regards,
> > Boqun
> >
> > >       print_testname("hardirq_unsafe_softirq_safe");
> > >       dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE,
> > LOCKTYPE_SPECIAL);
> > >       pr_cont("\n");
> > > --
> > > 2.45.2
> > >
> >
>=20
> Regards,
> Ahmed

--QvzP0FT4f5Il3vXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmay2iMACgkQSXnow7UH
+rh9KAgAgxt99jXPVUQ5w0twp59iLAkmKHY1HdWm1NUriAyoA2DB8QFe3wgyKHN4
9M4g1FoBdhLR06zPRwJNLl/yaf7YJFmYeDt5gDoC7pSHi01goClgHpn77FV5P3Ol
WJFVk+7w3Mf2RYMM3BcBJJfPFHXMK2t3M0Umeq7iyaOFzdvNgML7aLhPjYWO3f6Q
4Y0GtKrEcCSYhW4/LP41uSydCwHQSV68aNc1NyW80tRO7hrBQag0fn7RM6eJfW3P
E00n1Ebp4Kbzozk0LeD7e7Tr4UtigMG1pJXTvsX3AwEJVBV7UeGm7B9AKlbobVbx
ZGkVdbpE/9LB13bOWjlqN/bncWoedg==
=zXSC
-----END PGP SIGNATURE-----

--QvzP0FT4f5Il3vXZ--

