Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83179F3BD
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfH0UGN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 16:06:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41173 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfH0UGM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Aug 2019 16:06:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so100248pfz.8
        for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2019 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=UxDzRqet4xGkXwyOMvmgCDlcz9NVQfVcrC4XdN9w8WI=;
        b=MkENEddknHBlrjLv0lc9osuNctsFAEAi17t9pYfINVd+F2+Wl/x+l767ONiyn25mhz
         D+bp/wtWEyJVaA1+qRaq1NFIvCnRxahKwbM9f+mELFhyQorfpzDdxQbBfxk1lQymSEZB
         L6K8bSHTIPm3Q0HwsLsefTOMkMNsW4bTiMTXB35gd17NfDdoi0CJD4hfWLdW3wMJ8cC7
         KkfqJ1WR5ocP2mBLI8+M3a2CI38DYdFJlcKkpaq7Gj7VIOXMiA/C2nMKprbu8YT/T5j+
         ntHulrkTGxBlz+Zg6LqDKE79/EDlYlC8JTcxSXocn+XVQAGanGPYP6iKPAsoYth3kEUv
         oLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=UxDzRqet4xGkXwyOMvmgCDlcz9NVQfVcrC4XdN9w8WI=;
        b=qbUrC33gTPQAKeDla3PbH8dAHMzAHc5nbQWqPdt5CeVmtBC3B2vN2sL3iaJpZ3m/H3
         PlvtMOCqgyf3kLwr3gbLmIJok4vuEqLspye6xcupozAjQOhpOBJM1JtqYP2745GAmCnc
         D3txftcNJvvj2H+eABpCs8CEiDolGtFefBYqQWwbk/oYaCSr1mJHNV6ypVbvVk1y+3X9
         Ek/rg9xhOCFQCPRbsFY/QIZb4lSpYJVA4jlTwQUkwQvT4P4RQ4W1O1/JNlriEr7ADYNV
         hk15/wHVmqCFcVM6SYUHdHZKpVF35429j5wdsElbB5sLxP6b36E3POg4Y6ofc8cwPOus
         p2UQ==
X-Gm-Message-State: APjAAAVrAGij/DX7JY4frTEEfaJ+Ed7zhIRgFkx7vcJit2zq8TiENS7v
        vv03Y7VpxymIWT6YYgSWdwu0XQ==
X-Google-Smtp-Source: APXvYqwhQW/ZgrzVp4r5OaJXdTvzlcWy0Umgrh/Kn1+o/BPOKnLG3xP8DyP9TMXeLT4MuGbaxLvvYw==
X-Received: by 2002:a62:5207:: with SMTP id g7mr236513pfb.152.1566936372246;
        Tue, 27 Aug 2019 13:06:12 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g19sm144185pfh.27.2019.08.27.13.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:06:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <CD177117-8F37-4435-8163-9C5E65AEF743@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A7A6F338-20C9-4389-8338-A189B3A87420";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: question about jbd2 checksum v2 and v3 flag
Date:   Tue, 27 Aug 2019 14:06:07 -0600
In-Reply-To: <20190826183107.GA1037476@magnolia>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <CAPLK-i8xE4n8BJ-Beu0f80PC2W6b-A30nwcz+V_bCb_iAyB++Q@mail.gmail.com>
 <FF31C738-6B87-434B-9736-76286ED0F8E3@dilger.ca>
 <20190826165106.GF4918@mit.edu> <20190826183107.GA1037476@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A7A6F338-20C9-4389-8338-A189B3A87420
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 26, 2019, at 12:31 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
>=20
> On Mon, Aug 26, 2019 at 12:51:06PM -0400, Theodore Y. Ts'o wrote:
>> On Sun, Aug 25, 2019 at 09:05:36PM -0600, Andreas Dilger wrote:
>>> See description of the compat/incompat/ro_compat fields at:
>>>=20
>>> =
https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#The_Super_Block
>>>=20
>>=20
>> Hey Andreas,
>>=20
>> As an aside, thanks for puting the above wiki page.  Any chance you
>> could also send a patch to update =
Documentation/filesystems/ext4/super.rst?
>=20
> Huh?  That wiki page was ported to the ^^^^^ rst file.

My bad, I see that there *IS* a comment at the start of this page
indicating that the documentation is old.  Unfortunately, I entered
the middle of this via search and started editing when I saw there
was outdated information and didn't see the note at the top.

I'll try to submit a patch.

Cheers, Andreas






--Apple-Mail=_A7A6F338-20C9-4389-8338-A189B3A87420
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1ljTAACgkQcqXauRfM
H+D57hAAm+S47uFzUWT/40nAbtFZPfBe9c/tHemNtp4Kd7II9Zn2SsPLsHyJGeck
sTAuMEEMcb4G+/tJWmZjtcuB0/BCWbjA5N6ADZ3yxCR2jxkIAOwCpWpmADx4Fd07
7pmOr00qBglsWyOTb40c2CDjRLlT2O1cOr5m8nxWOqg4o2rSS+K7BkR9i3i7BzJu
TkWAEJIBnusTphX3PAnI4MTuCtGriPw+TqkvaInIlvT1y3fv9RzNAp7zip6aZpI4
EfCDPhj2q2EAC2kW/C0XS9uUnpv9qD5Zc5Bq0jZOZe83bstpvhLm483jW+3+8a3H
9DdGLlZJ0LzHO/6QN7n1D02kRggHaTlXmx82VIyrw35g2EqxrT9TToQ2AwqYDSZm
4XNqY8J/bzAE4Hk4DfZqNeMj+nUz5WwF8Vy+nFd9TATNX2oETkG8kiu4A4iHemHG
NiKAw/IIrQpI1go/im3Bd1ZQc8j3dIvrhylVrcgI1W+5AmW4Ewzp2zefKIEahLQI
QRf+hecT6DU/eRfwdxgVtNyi/DroIawu628VYOQLkAcZiuw6xesvyEFOhoQcbm6j
53Ay2p+QXuJ4rOvwWKADyFkfy3cRXszhDnGN3EIXAgfPvcM0RQQWOM1nKzMTlSkj
1IAYTyYq5KfhVYpqmZ4R+eTYxOW6g27S8XJq2q/1t9tk3P7fS1w=
=oDH6
-----END PGP SIGNATURE-----

--Apple-Mail=_A7A6F338-20C9-4389-8338-A189B3A87420--
