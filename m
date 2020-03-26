Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0551949C0
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Mar 2020 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCZVH3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Mar 2020 17:07:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43539 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZVH3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Mar 2020 17:07:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so3510826pgb.10
        for <linux-ext4@vger.kernel.org>; Thu, 26 Mar 2020 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=uqxKqz/WZg79L0iSSmJTjhmdGyfqkue9xuQvNDFHmZ0=;
        b=sOY9g95zLLKtwwhwBncKo+kElcrQA+gPeSbYs23+wFbtFdtTnnFexDS+MdALx/3Czx
         dhhHnjQwK+UMInFET5uSGh5ZFscp8X3v/Izdl7fNggjInCR2lzBSVg4dweJBIuDwCgHS
         LrTeGO4jOws1sYd3d4oxVfAPpvq8ThYcA6MRgJnxsmVe5pQNBBuk0oaBjAMhzqeDCmMj
         m0EY0eCMDcu1vDM6th0XjObIH9YzQ4JT7mRKce+Jdit25LFI/0M7F9j3+mtLLdhN9bfx
         oiIT9yVy8dJOnWG1ELtDbgelDXERClEh879vFs9rkQjmSAlI4p1rbZE+1XGvS6EWYB/f
         3N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=uqxKqz/WZg79L0iSSmJTjhmdGyfqkue9xuQvNDFHmZ0=;
        b=hRmqGXDlzGpWSFT2hv6kkYcNkpnA4pHKkG1hvwulNFqs4uP2w/87EA6GWHl7MWl2jq
         RRksWjzgB88yLqGa0JbivWrqCWsR7tzA2qkEJGvsB78P2OlfX16d9vr3tl0K+kBPL0B9
         1xaRV3lUQjbPvZjac1bbM5QTWXuQZwCgEmqcbnnsR774XIh00o76ZHjpbnkvOY0EmQlr
         x2RswEVGR14rEWTIW1u8ACOUkEBO1wZGbNF261UdjBh+IHR5U95/Vh2QRKrpmp2+eLYY
         1XglXMjS/w2deOv3Uz0XZOw/JEM1r2KKDrsogoV3sfYLZ1XzOQvGRWzPPvvIkr+riuR/
         xAqQ==
X-Gm-Message-State: ANhLgQ0viUBFksR/j8wcV2fYi4Q0AN5HK2Od/DSnDD2vQeEjXUvIJ+Io
        REjaFJ2kLFeWnNtClCOSzeVkSg==
X-Google-Smtp-Source: ADFU+vsusUm7OQIsDkuLe0J3ulMwskTcxzLKT0OdnSkDCMUgM5B3OZXk8VPuHoMLR1VeM0A2z1si6g==
X-Received: by 2002:a62:4ec4:: with SMTP id c187mr11270763pfb.223.1585256847917;
        Thu, 26 Mar 2020 14:07:27 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id b24sm2413077pfi.52.2020.03.26.14.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 14:07:26 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EAD1A1FC-DCF5-4B2B-BDE9-38E593691E23@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_10416016-6F18-4F89-9D9B-DADE8F7C9A2E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: shrink directories on dentry delete
Date:   Thu, 26 Mar 2020 15:07:23 -0600
In-Reply-To: <CAD+ocbxt5E+v8=zWQGuAPwtJMe_Qa8q9BhP1es05unaQ50ckkQ@mail.gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
 <20200325093728.204211-2-harshadshirwadkar@gmail.com>
 <04F44879-15DE-42EE-B87A-0690E9B13BB2@dilger.ca>
 <CAD+ocbxt5E+v8=zWQGuAPwtJMe_Qa8q9BhP1es05unaQ50ckkQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_10416016-6F18-4F89-9D9B-DADE8F7C9A2E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 26, 2020, at 1:49 PM, harshad shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> On Wed, Mar 25, 2020 at 3:06 AM Andreas Dilger <adilger@dilger.ca> =
wrote:
>>=20
>> On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>>> But note that most of the shrinking happens during last 1-2% =
deletions
>>> in an average case. Therefore, the next step here is to merge dx =
nodes
>>> when possible. That can be achieved by storing the fullness index in
>>> htree nodes. But that's an on-disk format change. We can instead =
build
>>> on tooling added by this patch to perform reverse lookup on a dx
>>> node and then reading adjacent nodes to check their fullness.
>>=20
>> Thank you for updating these patches again.  I haven't had a chance =
to look
>> at them yet, but I hope to review the patches in the near future.
>>=20
>> As for storing the fullness on disk changing the on-disk format...  =
That is
>> true, but the original htree implementation anticipated this and =
reserved
>> space in the htree index to store the fullness, so it would not break =
the
>> ability of older kernels to access directories with the fullness =
information.
>>=20
> Yeah, you are right, good to know that we have bits reserved already
> and that wouldn't break older kernels if we use these in future.
>> I think if you used just a few bits (maybe just 2) to store:
>> 0 =3D unset (every directory today)
>> 1 =3D under 20% full
>> 2 =3D under 40% full
>> 3 =3D under 60% full
>>=20
>> or similar.  It doesn't matter if they are more full since they won't =
be
>> candidates for merging, and then lazily update the htree index =
fullness
>> as entries are removed, this will simplify the shrinking process, and =
will
>> avoid the need to repeatedly scan the leaf blocks to see if they are =
empty
>> enough for merging.  It wouldn't be any worse *not* to store these =
values
>> on disk after the first time a "0 =3D unset" entry was found and not =
merged,
>> or setting the fullness on the merged block if it is merged, and =
running
>> "e2fsck -D" can easily update the fullness values.
>>=20
>> The benefit of using 20%, 40%, and 60% as the fullness markers is =
that it
>> is possible to either merge adjacent 60% and 40% blocks or =
alternately a
>> 60% and two adjacent 20% blocks.  Also, since these values are very =
coarse
>> they would not need to be updated frequently.  If the values are =
slightly
>> outdated, then it is again not worse than the "always scan" model =
(one scan
>> and the fullness would be updated), but more efficient than repeat =
scanning.
>>=20
>> Using only two bits for fullness also leaves two bits free for future =
use.
>=20
> Thanks Andreas, that makes sense. This kind of merging will require
> lot of tooling provided in this patch - for example swapping out freed
> block with last block to not leave any holes. So, my hope is that we
> get this patch in first and thereby get a step closer to coalescing
> solution.

Definitely I *do not* want to block the landing of these initial patches
until a "full featured" directory shrinking is complete.  These patches
at least provide some basic functionality, and will at least shrink a
large directory if it becomes totally empty so I'm in favour of that.

Cheers, Andreas






--Apple-Mail=_10416016-6F18-4F89-9D9B-DADE8F7C9A2E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl59GYwACgkQcqXauRfM
H+Dt+A//f7ZPz0S+KTgHIwMEEiVt0aRdnAxDajHVvJgKzrCG8xg5fk87vOVBTK5z
jmpnvyIwp/Srnrv18aGZ31u5LPCgqhGTrWSiMcETv/2vYFd3ZGLbkFc1whIW6DSA
wURdVQvgWI6ST3J8M2h+6YpA5N3vXBMcIJMhgRt89bN+/OEz0KfOPtnu5McDBNZV
G75nXo4yCD+8hAui/aFmP2y2M+Y4ywv33HyBdrw30bvvTZQBxDp/5HAUPN7kftd9
5R4YfchCXPiUpQGNPgYgJjyulZ0qIdtkCyiRN7gvmWrx7Wi6mIouBgDoNctusLL/
F1AxKOLlendy4A6atkN5UmwjY+TQS6oKyBxKMeKBHdrUahbid7esgfwTnWomYP7Q
CzDA+rg5SeA5WGo5mFN7y/+JmOQDALiNpBbDIeQgjsUEcGvepVvlpnCMPJYMs2ig
ae9eUeus8VqqjnmsGaAC/LN5B0AJyVLJGeXnY3fQsHOvsXlYOWE4oRDHRR0EjsHO
Ua448FkuBrqGt5J4d4vyxdl8W90z7WwHq+r9DdhqhWZnz0ksGHk1ACwTy3NlqxVl
KXfBXczubzZgIrB4Ar+xxOsQ/5Xl5whXwzXAnp69HiEZQ/d/TG2o161/LZvGuoLs
XsyHLEfUMglAykdXXffitbXpZniRAAVHMRbOD0rJq26FMfHqjck=
=5q8a
-----END PGP SIGNATURE-----

--Apple-Mail=_10416016-6F18-4F89-9D9B-DADE8F7C9A2E--
