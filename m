Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E8196A2B
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 01:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgC2AKP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 20:10:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41591 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgC2AKP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 20:10:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so1276261pll.8
        for <linux-ext4@vger.kernel.org>; Sat, 28 Mar 2020 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vxJbPwA8dn/KP4vFKPLIlIiqHMusiErlAxUBEJjgiMo=;
        b=mDpWYevu7fHR9ahQLIPqBxHgZaN5j8dtF+UWxYIbRXwec/MXpGlaDRKC0LNwFuDDKK
         oEYVRZ7gouW5W8M6IT2AzBu+RB1LrK+HNQaebpQ1P3FtKAxGH69hEhEoX+vKGB5WNIY1
         /jcQjRrD5qCowuM6C0GdO6L+YM9US2aojqRHWqtQdaA8lmYT0N6Ilxzmp07v5tpHivsb
         SlIk6duVfRaQixfrPaADpVWNbMkeG6ZiOotxjEEJGjgOZJDsfCBgWCKRRkzHo7vEgt41
         Vjzal9cvPqWH/u0FP3XPbHybg/UMNMKgEE+lcAwzcqkP9xivlJX/IoO7i8kZxE529kvy
         tHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vxJbPwA8dn/KP4vFKPLIlIiqHMusiErlAxUBEJjgiMo=;
        b=TUdYcJfJDxcC8eRrtnA34+Qc5f+eycss235MGQDi/XhO5ETjYcwmtHnBPW7YLO4clb
         8nUVDS6pT6zfq/WxZnxePESq7J0Wcxbl2kqtZ+WgVp8xCyiEL+jjgt6KqHbFfAT5E/P2
         Npvsj2Lgvkbemab+hV3YNC3mtEJcCDS3a80eZqeyiWhzZHseOMmOPaZBzCTzBySzL06c
         rLuiE0BME73Bmhhbx2g8Vex707V+1sh92RcmaE6tb0qRI6tm5dMcwX//m/DQ84GsUm1Q
         Oe1PwuHsoxLjOROgDQ6uYSlAldqg/0BRvaHKZSSEUyF4uVD0LbSusAMzWbaYqhmSoo4b
         u0nQ==
X-Gm-Message-State: ANhLgQ04uLcvbJGn52cpeZs4+iawiCJHCCZ/As3BOPZrxsPGlRkCG6Pf
        dVqTuYxS82z6Gdl9dUtjDgYCGQ==
X-Google-Smtp-Source: ADFU+vvwkoIjRAVqjofdqaROQEZ/oY9wC5pkRltbDAAb+28mQ1hbBAvoHf4IhGmIiUwxO398uZpTdA==
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr6829273pjb.186.1585440614201;
        Sat, 28 Mar 2020 17:10:14 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q80sm4325780pfc.17.2020.03.28.17.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 17:10:13 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EC88E8EB-7303-45FB-85B9-A007FBE5F5A0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_98918D26-6166-4EBB-A347-3496E7D1D550";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v1 08/50] fs/ext4/ialloc.c: Replace % with
 reciprocal_scale() TO BE VERIFIED
Date:   Sat, 28 Mar 2020 18:10:11 -0600
In-Reply-To: <20200328231536.GA11951@SDF.ORG>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
To:     George Spelvin <lkml@SDF.ORG>
References: <202003281643.02SGh9vH007105@sdf.org>
 <9A60C390-349E-4A90-A812-F04EB5A82136@dilger.ca>
 <20200328231536.GA11951@SDF.ORG>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_98918D26-6166-4EBB-A347-3496E7D1D550
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 28, 2020, at 5:15 PM, George Spelvin <lkml@SDF.ORG> wrote:
>=20
> On Sat, Mar 28, 2020 at 04:56:17PM -0600, Andreas Dilger wrote:
>>=20
>> So I think the current patch is fine.  The for-loop construct of
>> using "++g =3D=3D ngroups && (g =3D 0)" to wrap "g" around is new to =
me,
>> but looks correct.
>>=20
>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>=20
> Thank you.  Standing back and looking from higher altitude, I missed
> a second modulo at fallback_retry: which should be made consistent,
> so I need a one re-spin.
>=20
> Also, we could, if desired, eliminate the i variable entirely
> using the fact that we have a copy of the starting position cached
> in parent_group.  I.e.
>=20
> 		g =3D parent_group =3D reciprocal_scale(grp, ngroups);
> -		for (i =3D 0; i < ngroups; i++, ++g =3D=3D ngroups && (g =
=3D 0)) {
> +		do {
> 			...
> -		}
> +			if (++g =3D=3D ngroups)
> +				g =3D 0;
> +		} while (g !=3D parent_group);
>=20
> Or perhaps the following would be simpler, replacing the modulo
> with a conditional subtract:
>=20
> -		g =3D parent_group =3D reciprocal_scale(grp, ngroups);
> +		parent_group =3D reciprocal_scale(grp, ngroups);
> -		for (i =3D 0; i < ngroups; i++, ++g =3D=3D ngroups && (g =
=3D 0)) {
> +		for (i =3D 0; i < ngroups; i++) {
> +			g =3D parent_group + i;
> +			if (g >=3D ngroups)
> +				g -=3D ngroups;
>=20
> The conditional branch starts out always false, and ends up always =
true,
> but except for a few bobbles when it switches, branch prediction =
should
> handle it very well.
>=20
> Any preference?

I was looking at whether we could use a for-loop without "i"?  Something =
like:

	for (g =3D parent_group + 1; g !=3D parent_group; ++g >=3D =
ngroups && (g =3D 0))

The initial group is parent_group + 1, to avoid special-casing when the
initial parent_group =3D 0 (which would prevent the loop from =
terminating).

Cheers, Andreas






--Apple-Mail=_98918D26-6166-4EBB-A347-3496E7D1D550
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/52MACgkQcqXauRfM
H+D/LhAAidMTHxiYEIscM4C0DDkX5We7BDxxtxI66C8RWtGjHFkEkpaQiIPpc+Ck
wuJG92tkWRU/9ntXF+NqDPGwWZ78twhAtxDcLNztIqWhcJ53pdgrXZ4ReTL2S9m/
81M96JMwTngpojH+CZbsrEfq64YzY0ASLZsTG67hXHl8Nb/ZXdEXYdwXegl/biHh
e2tq4BBvmdgUztxEnOncAi4WyzUU/xVPU+YYLWhgHCTwG29HHN+130VkSibZYKTt
j8X0/1xAtaOlt/KdKXJMm+rdaWHkYee2PqCvLhjUUwv4drUHjCZ8eo7D4ZbJZaX9
TQHaVpEyvlqG6ZdTAafr0sONK0Ep6Xb66ZuQDj6zjlm6Nn6/rG42dLPhT+SMftWy
/juaAu1JohzqV108Elzp5eNuEJEJWczsMKUAmVnQ5K2LaASpZRWWmLC3lrmledKH
G0XWwc/FPV6H2pzWdi/EbHmkF9zna5uZEDCul62iDMsdsRK9h0sxmdP9H20jrrXi
rXK9WdwKsJYngJFDAa1nRi0Iux4OJ/5lZvLUzJNGZGnAnbnGNZKYFcBu5fJr/ent
JJZyLeWr7QiAgwqZX3Sk16/6KPBZfslrcHhFeBZY9KPVAorXRGM+XDEQy5+CwaDq
xAaWC3KN26fDWN1BjSZTf/MjmDBmGxtLdqnotTOrrh6qJSTeHvs=
=1bvk
-----END PGP SIGNATURE-----

--Apple-Mail=_98918D26-6166-4EBB-A347-3496E7D1D550--
