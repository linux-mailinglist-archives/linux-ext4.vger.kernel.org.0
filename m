Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AB200038
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 04:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgFSCbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 22:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFSCbL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 22:31:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBB4C0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:31:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so3741137pfd.6
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pP39j/TyQZt962BeO/zkB9ZVC5jdvpfb8Y+HnDseHwA=;
        b=IpRp2PW5ozHb1S7GL/K/Srk0JZ1G7zyF08llr/X3MrlwDYeXYZ6vWbgiBI/vM5eunj
         U4qZVjiKrwBzhH8FHt118RN7Dc1PXdIgwnXlMoqvL5FsvmpAjoXiuxP1eteQQEFRx7cO
         1egJ8HlmnefYpqJ6o6DWqtGuqRbqKcQxWRuB7XopBD+1XtsowQL6eZvKpYjT6l71UlNS
         cfp3I3mraMGN5KJlYG4XPC/ytDXatQT0O6Da61d3ab8+FkoyJzk0/IfTFujCfWAgs3v3
         Xaz6qXRTIYAu7cQ1E61OOifB8HSSsYhmIlRwDypJbOoJGV3K7pq4A1XeFB7tHinHlZat
         EDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pP39j/TyQZt962BeO/zkB9ZVC5jdvpfb8Y+HnDseHwA=;
        b=FTEUO1gPHcxRLMMdjXqBV3mFjsn/DjaH8Knj+WHEKCiGOYFiF8hbFG3vtmsncxziJt
         1er+YNBVdZlxZqqsNxgrafz3j5xKdLAWGe8tY0+sVkKE9bY7Ro3zzxsuuHBRxFCaDjbn
         XIRRo1BzZP/GHawQUOLEuFuxxYytLFgvV6jv6PRVaJIZyNlOlDBt7INVgux6xQK1jBIj
         Hl1u0DMaMEp4/lEfMZounv4k/Q6p4bNxBjTLQrapjTSQIP2x9eipToVkkNRp6TuxnjNZ
         3RK5AE+Mk4bwLAOig7VuThUSIvJ/gubtttIF0hI5v+6B0xQMDXuOpdKCOIKT0p8pBvEp
         sZcA==
X-Gm-Message-State: AOAM532JBFdXM2IEH97bwbrabGfrfa4PGciTMPxSJ/9fwx55eGE0N9O7
        J+70sp+gt0HE/MQal85xs+261Q==
X-Google-Smtp-Source: ABdhPJzUG3m8+PRl8Nfte5L+vPNKXBA8oPCqD+EgMHIhPjszxHw+WgXbMJ0FNAg5WOePFWybAcsRzA==
X-Received: by 2002:a05:6a00:1592:: with SMTP id u18mr6119395pfk.26.1592533868886;
        Thu, 18 Jun 2020 19:31:08 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y7sm3714565pjm.54.2020.06.18.19.31.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 19:31:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B9A0A2A9-25B3-4238-A24D-4F77DD1FEABC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0E26836E-A3D2-4541-A52E-4DA3E4BD0F4B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/1] ext4: fix potential negative array index in do_split
Date:   Thu, 18 Jun 2020 20:31:05 -0600
In-Reply-To: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Eric Sandeen <sandeen@redhat.com>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0E26836E-A3D2-4541-A52E-4DA3E4BD0F4B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 17, 2020, at 1:01 PM, Eric Sandeen <sandeen@redhat.com> wrote:
>=20
> We recently had a report of a panic in do_split; the filesystem in =
question
> panicked a distribution kernel when trying to add a new directory =
entry;
> the behavior/bug persists upstream.
>=20
> The directory block in question had lots of unused and un-coalesced
> entries, like this, printed from the loop in ext4_insert_dentry():
>=20
> [32778.024654] reclen 44 for name len 36
> [32778.028745] start: de ffff9f4cb5309800 top ffff9f4cb5309bd4
> [32778.034971]  offset 0 nlen 28 rlen 40, rlen-nlen 12, reclen 44 name =
<empty>
> [32778.042744]  offset 40 nlen 28 rlen 28, rlen-nlen 0, reclen 44 name =
<empty>
> [32778.050521]  offset 68 nlen 32 rlen 32, rlen-nlen 0, reclen 44 name =
<empty>
> [32778.058294]  offset 100 nlen 28 rlen 28, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.066166]  offset 128 nlen 28 rlen 28, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.074035]  offset 156 nlen 28 rlen 28, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.081907]  offset 184 nlen 24 rlen 24, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.089779]  offset 208 nlen 36 rlen 36, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.097648]  offset 244 nlen 12 rlen 12, rlen-nlen 0, reclen 44 =
name REDACTED
> [32778.105227]  offset 256 nlen 24 rlen 24, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.113099]  offset 280 nlen 24 rlen 24, rlen-nlen 0, reclen 44 =
name REDACTED
> [32778.122134]  offset 304 nlen 20 rlen 20, rlen-nlen 0, reclen 44 =
name REDACTED
> [32778.130780]  offset 324 nlen 16 rlen 16, rlen-nlen 0, reclen 44 =
name REDACTED
> [32778.138746]  offset 340 nlen 24 rlen 24, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.146616]  offset 364 nlen 28 rlen 28, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.154487]  offset 392 nlen 24 rlen 24, rlen-nlen 0, reclen 44 =
name <empty>
> [32778.162362]  offset 416 nlen 16 rlen 16, rlen-nlen 0, reclen 44 =
name <empty>
> ...
>=20
> the file we were trying to insert needed a record length of 44, and =
none of the
> non-coalesced <empty> slots were big enough, so we failed and told =
do_split
> to get to work.
>=20
> However, the sum of the non-empty entries didn't exceed half the block =
size, so
> the loop in do_split() iterated over all of the entries, ended at =
"count," and
> told us to split at (count - move) which is zero, and eventually:
>=20
>        continued =3D hash2 =3D=3D map[split - 1].hash;
>=20
> exploded on the negative index.
>=20
> It's an open question as to how this directory got into this format; =
I'm not
> sure if this should ever happen or not.  But at a minimum, I think we =
should
> be defensive here, hence [PATCH 1/1] will do that as an expedient fix =
and
> backportable patch for this situation.  There may be some other =
underlying
> probem which led to this directory structure if it's unexpected, and =
maybe that
> can come as another patch if anyone can investigate.

I thought this might be a bit of a conundrum.  There is *supposed* to be
merging of adjacent entries, but in some quick testing on RHEL7 (kernel
3.10.0-957.12.1.el7, same with Debian 4.14.79) shows this to be broken
if the files are deleted in dirent order (which would seem to be the =
most
common order):

# mkdir tmp; cd tmp
# touch file{1..100}
# rm file{33,36,37,39,41,42,43,46,47}
# debugfs -c -R "ls -ld tmp" /dev/sda1
   366  100644 (1)      0      0       0 18-Jun-2020 18:43 file30
<   369>      0 (1)      0      0   <reclen=3D  16> <deleted> file33
<   372>      0 (1)      0      0   <reclen=3D  16> <deleted> file36
<   373>      0 (1)      0      0   <reclen=3D  16> <deleted> file37
<   375>      0 (1)      0      0   <reclen=3D  16> <deleted> file39
<   377>      0 (1)      0      0   <reclen=3D  16> <deleted> file41
<   378>      0 (1)      0      0   <reclen=3D  16> <deleted> file42
<   379>      0 (1)      0      0   <reclen=3D  16> <deleted> file43
<   382>      0 (1)      0      0   <reclen=3D  16> <deleted> file46
<   383>      0 (1)      0      0   <reclen=3D  16> <deleted> file47
    386  100644 (1)      0      0       0 18-Jun-2020 18:43 file50

Above shows (with modified debugfs to show reclen for deleted files)
that the dirents are *not* combined.  If the dirent *before* the
other entries is deleted, then they are merged:

# rm file30
<   366>      0 (1)      0      0   <reclen=3D 160> <deleted> file30
<   369>      0 (1)      0      0   <reclen=3D  16> <deleted> file33
<   372>      0 (1)      0      0   <reclen=3D  16> <deleted> file36
<   373>      0 (1)      0      0   <reclen=3D  16> <deleted> file37
<   375>      0 (1)      0      0   <reclen=3D  16> <deleted> file39
<   377>      0 (1)      0      0   <reclen=3D  16> <deleted> file41
<   378>      0 (1)      0      0   <reclen=3D  16> <deleted> file42
<   379>      0 (1)      0      0   <reclen=3D  16> <deleted> file43
<   382>      0 (1)      0      0   <reclen=3D  16> <deleted> file46
<   383>      0 (1)      0      0   <reclen=3D  16> <deleted> file47
    386  100644 (1)      0      0       0 18-Jun-2020 18:43 file50

Cheers, Andreas






--Apple-Mail=_0E26836E-A3D2-4541-A52E-4DA3E4BD0F4B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7sI2kACgkQcqXauRfM
H+BeRw//Vn8s8SPHaEuIrx1fN6UwJBCKeB5D893Yt6DHGaGULEd7Se7Irn0gi4NE
C6z+R5+Gkyg1i40Ov6iAzzR2twKLHJGZ2WkgqsN31uQ3H6BhEoCjQ/CtYcGXMXmX
RKl6IgspVM1AXueVbdi0o0OSNRHGLUfWKUIV0CE9qFhCXKrWlYOR9nFfhXd08UcG
8DsvWY2NDAKkBQBbd702JmIdJlumGysSqxVkg3oq7xl1NicEcOpdxsiwyyfxLSGV
GAHldFPFtft0F0IObC/g6jgrwO+MHnX1SwUjVWO+psy+92Q0N8Fb0HRIRsh/H9yZ
zo7qFUV4fxfkto6c4ojlkPJSolg/fEW5L+HX/CTUpbG7cSdrBsS7Mie7Q00n0Bfd
fjbps6NSTwTqEzdSnOGA5W0ZSfmR0GAvoVNicTOX+nWAEdgj5LOyl8uOH/gvIcWq
YGJiwxZ0tRm8RddDUtLp4RGtmNbkwWH0298/p0EBaLDQ5Q5SPqepxzsCgDSjPsMC
r2aMxNCPak7jw+xIzvoffwzagSkk9U31UpINIdHQgNtiJBZiYTe1JItNnNzb+GL5
9xtvWh2OZZbEO2dF8CdiO/N2v12mQ2BQliCo8tt7itQFY4ZZO/K2A+w5iANaFn6G
VyjGTjwz80vzzVvIYj0pLxob247zwER64JGw8vY6DIBep+kAK9o=
=5OrI
-----END PGP SIGNATURE-----

--Apple-Mail=_0E26836E-A3D2-4541-A52E-4DA3E4BD0F4B--
