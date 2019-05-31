Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A7316B3
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2019 23:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfEaVn5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 May 2019 17:43:57 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41584 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaVn5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 May 2019 17:43:57 -0400
Received: by mail-pf1-f181.google.com with SMTP id q17so6958302pfq.8
        for <linux-ext4@vger.kernel.org>; Fri, 31 May 2019 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OqPSb0m2mrEyE30ZZdo4WWYoY9S6C4+fBQiUIBj9XMM=;
        b=GRMX/JJaS2Zz4zfKme+cZ34zxaVRLXg+LV9KNBEYGDks7tcNHqLjYSO6ugWrlMzC2K
         upMwR52a0bbw2MOY9a4Ztw57hB/WinZmVNoEzGvkzqvvptzT9JYPib/gj8pEScz5M2o+
         JxE+QOT9d7C8ha5u3SIaA/bkCDb0VN4KG09OIPi2FvK2WzniRYumewVi8qt7S3zXpUvd
         bhRNDROpFiya3tINsed1YZ0QHyZH509ly2Xo7IysbvtgpbSBV0tzIxGMfZRIbfmb+cV3
         vSyeIZB455c8TuV809s5UJ7422zkRlkChoVymYBo/PPqjGajMdX31Zc0E3QIZW4aayty
         iGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OqPSb0m2mrEyE30ZZdo4WWYoY9S6C4+fBQiUIBj9XMM=;
        b=cNCJtZfmlB5bIR3bUAcPXSDev24/z/yF8hdrmcSpXsmI+vZdgolHcAOloXxiHOEHSY
         kdjlSCrOCi4dOoqFvQycon2+4KuR3jlpmK9Vt96YDlXhK/f5eJTlfJSo98tU5IxKVLrZ
         wolFNgmzzkbCLobu4Qb2WuFckNKWnRWQnvfHEzBS/zl36iuHrnxxGNIkdmx6oonL4A+s
         9OV56LtjVE/6ajcbbXj8l80rbGcJrtLJ0tEFdxq8qFSdNH2Kuu3RRh1PEYWKHwkveKIY
         LupkZ7dkBfiYAL/ot9v8HduX0JAmUETHWIJtvKEIzcOAQjADZU+xoCqyionTecar8JH0
         Ahcg==
X-Gm-Message-State: APjAAAV1eluC3aTviUoUC0LOdyVW8ydyk2fSgXauEt24Bl5sMeByDnzI
        NrImQ3htPBGPOsI/tq2hydcUTQ==
X-Google-Smtp-Source: APXvYqzrpnTDvhFbBCT1ZHVpWDO9I83nB4xvi47VXwIkjw01QGxg8OldfbXlWJHi8qIPa5DBnggyew==
X-Received: by 2002:a17:90a:cb10:: with SMTP id z16mr11716721pjt.81.1559339036052;
        Fri, 31 May 2019 14:43:56 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u20sm11969207pfm.145.2019.05.31.14.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:43:55 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FDA5DE5F-41AE-4B56-9BD7-462E344ECD1A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_41B88020-7AB4-4155-890B-6AF2391D0737";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: How to package e2scrub
Date:   Fri, 31 May 2019 15:43:53 -0600
In-Reply-To: <20190531141019.GC8123@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu> <20190530095907.GA29237@quack2.suse.cz>
 <20190530135155.GD2751@mit.edu> <20190531100713.GA14773@quack2.suse.cz>
 <20190531141019.GC8123@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_41B88020-7AB4-4155-890B-6AF2391D0737
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 31, 2019, at 8:10 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Fri, May 31, 2019 at 12:07:13PM +0200, Jan Kara wrote:
>> On Thu 30-05-19 09:51:55, Theodore Ts'o wrote:
>>> On Thu, May 30, 2019 at 11:59:07AM +0200, Jan Kara wrote:
>>>> Yeah, my plan is to just not package cron bits at all since =
openSUSE / SLES
>>>> support only systemd init anyway these days (and in fact our distro =
people
>>>> want to deprecate cron in favor of systemd). I guess I'll split off =
the
>>>> scrub bits into a separate sub-package (likely e2fsprogs will =
suggest
>>>> installation of this sub-package) and the service will be disabled =
by
>>>> default.
>>>=20
>>> I'm not super-fond of extra sub-packages for their own sake, and the
>>> extra e2scrub bits are small enough (about 32k?) that I don't =
believe
>>> it justifies an extra sub-package; but that's a distribution-level
>>> packaging decision, so it's certainly fine if we're not completely =
aligned.
>>=20
>> Yes, size is not a big concern but the scrub bits require util-linux, =
lvm,
>> and mailer to work correctly and I don't want to add these =
dependencies to
>> stock e2fsprogs package because some minimal installations do not =
want e.g.
>> lvm at all. Granted these are just scripts so I could get away with =
not
>> requiring e.g. lvm at all but it seems user-unfriendly to leave it up =
to
>> user to determine that his systemd-service fails due to missing =
packages.
>=20
> So you're using an extra package to force the installation of the
> necessary prerequisite packages, instead of the current approach where
> we don't require them, but we just skip running the scrub if lvm and
> util-linux are not present.  I think both approaches makes sense.
>=20
> It's also a good point that we need to handle the case of a missing
> sendmail intelligently.  It looks like we currently skip sending mail
> at all in the cron case, and in the case systemd case, we'll spew a
> warning (which won't get mailed since there's no sendmail, but it does
> mean some extra lines in the logfile).  All of this being said, it's
> not _completely_ useless to scrub without an mailer; we still mark the
> file system as needing to be checked on the next boot.  But it's
> another argument that we shouldn't enable the service by default.
>=20
> For that reason, I'm not sure I'd want to force the installation of a
> mailer, since someone might want to run e2scrub by hand, and
> e2scrub_all every week w/o isn't a completely insane thing.  But we
> certainly should handle that case gracefully.

If sendmail is unavailable (and maybe even if it *is* available), =
e2scrub
can use logger to write a short message to syslog if there is an error.
Something like:

    e2scrub: $device errors detected, needs offline e2fsck to correct
    e2scrub: $device logs in /var/log/e2scrub....

in mark_corrupt() or from e2scrub_fail.

Cheers, Andreas






--Apple-Mail=_41B88020-7AB4-4155-890B-6AF2391D0737
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlzxoBkACgkQcqXauRfM
H+Cyrw/8ClmvfJvUmZcQY1hR2YHksW6R2IqvieYmQ9GO69AkV7UenqOh2y44GSDA
SDf5uweb3+M6NMhlJlaH8AD7uGBt7EY3sm1LR3jyyMLw3aNibdM13y24I4gilGzc
KTQWECwbjFiiz7AUOnN+EBD4u2OHljmaS9o0+UUaGM1t5+LnWM3clUB4jLwDHntp
9AVQaoh322mxIHgjUX+xOthnmk6MvjLH+iPJwrdlh2xZpm1ALKb6QE5yBYlhqNBs
OoRpK0yb2VFi6TssA8cokh6BRcvct39a0Mf6gw0Zjlywuk0bM6nkEUN9bcI75Jj3
qlcGf+iF2RrJeVsUNT8q/b5AjsfIfN5wuhNWErBvQ8L30O0nXIXjpBuEE+CJfAkn
r/z5L+zyb/YYXE4mjePoI1jPS9Jk/5I26g6LWFR6tNRzhRyCV3VYPw3BFfyeMCWf
g1zC0B8IVXWEywkWFBFd88+Ms096ZsDrFf/P5Le0pV/T7HLzlducguKiu4+biwa5
sBlsw2r2yM83Xinx9D7NsTNZqdGX7tSHuAXpSrrzDFZqXR2XeL4dv7t1FLRJzyog
ynsl3hgrnuNBXc8/YnIFf6Q6KadCe0camQH30caxxjt7hu2soIGE/iSBl9porBZ8
lAGeSGxaL+1EedGLHwUM6zT5485ADAvUfuK1bA2RYYUsGAglJg4=
=DBie
-----END PGP SIGNATURE-----

--Apple-Mail=_41B88020-7AB4-4155-890B-6AF2391D0737--
