Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D223672B34
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjARWUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 17:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjARWUJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 17:20:09 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEF654C3
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 14:20:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so2700436pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7G30v68Uf5xDJTsJP0hcUPxdEe8oGckFSCqLxtrsTE=;
        b=NHDcXA/8MheT7gQM61ipMapl33nTARVyAdgQa94K+Z7Q8J0JclkL6T04Fufy60wZ7w
         7X0wYA6h56uWBSzjwzLFU2niqJe3eKI4dGynD06B7m/rLWTz7GIRx1r5R+XPF4b/ioU7
         Xubb2HpdAPWpxjFem5UpST/Y0/0nW+SPp+pU88V+exCLPKiIgtTZJupuUMRZramkAUdW
         x3ZQjY4xu9Nv1O/Uv3ti8j6sdm8WLxtNvhBvnORHh7+0dOzSqiTNRo9NyDrR1bzlV/q8
         kaMPJU4O6aTg+DERlGHZDKKTbfLW2f0kPwNRo0FD5Vqu3vHojw0nN4tKCN07+uOSwNvt
         A68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7G30v68Uf5xDJTsJP0hcUPxdEe8oGckFSCqLxtrsTE=;
        b=0pSC/RJmaAi9fCQAbngIx8mrmEgk4B7bFHymYf+y0EOty31PsynDElxTuSAYjOJySg
         bdN+mHXPAdlxueAfbCclT6Q3cqQpg3ICTe/z4eL4Xu24PpldNfLW2lHw6eHSNcqHro5C
         T+iOO4w3k8CBbhTYy36YPqnGjUdxoB8yx9VxG0PncBSB5pCVv60Q3R4L0krZkE0xYWBO
         0K0g27oDAZkv/mbiaPpbZ1h05CqKhYYMrHGQ+wBzMJFP+DIz6/UZaJvcyyffKxWPVgbF
         Nj5O+XKmcUulmXyB1cZka4SaPkqKWXsFQepxK2HlzzRvaJHDBlfJTeh1GKihg9VVowiS
         ndCw==
X-Gm-Message-State: AFqh2kryO6oTl2SkyK5EdGcv4Hs5NNS7DgRkcRkCOIldKVhdMmxNZp0K
        6Pr3aw0XRYabGo6YKm3MPl+3oQ==
X-Google-Smtp-Source: AMrXdXv3/QnL7B+9wz5CwdebuWGk42FcwV28qO3kyeYg0A84PxuFeduZkV/Mnogj/y7/W8/bPg5ZYA==
X-Received: by 2002:a17:903:26c9:b0:194:9b68:aba4 with SMTP id jg9-20020a17090326c900b001949b68aba4mr8339690plb.69.1674080407451;
        Wed, 18 Jan 2023 14:20:07 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b001948ae7501asm7396851plb.298.2023.01.18.14.20.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 14:20:06 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3A9E6D2E-F98F-461C-834D-D4E269CC737F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F5CEB163-EA7D-4B9A-ABEA-18C72CE99631";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Date:   Wed, 18 Jan 2023 15:20:03 -0700
In-Reply-To: <Y8hpZRmHJwdutRr2@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain> <Y8hUCIVImjqCmEWv@mit.edu>
 <CAHk-=wiGdxWtHRZftcqyPf8WbenyjniesKyZ=o73UyxfK9BL-A@mail.gmail.com>
 <Y8hpZRmHJwdutRr2@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F5CEB163-EA7D-4B9A-ABEA-18C72CE99631
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 18, 2023, at 12:39 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>> Note that the reason I'm so laissez-faire about it is that "broken
>> test case" is something very different from "actually broken user
>> space".
>>=20
>> I haven't actually seen anybody _report_ this as a problem, I've only
>> seen the generic/454 xfstest failures.

That is likely because the number of 6.2+ kernel users who are using
Unicode xattr names is small, but they would likely come out of the
woodwork once Ubuntu/RHEL start using those kernels, and by then it
would be too late to fix this in a compatible manner.

> On Wed, Jan 18, 2023 at 03:14:04PM -0600, Linus Torvalds wrote:
>> You're missing the fact that 'char' gets expanded to 'int', and in =
the
>> process but #7 gets copied to bits 8-31 if it is signed.
>>=20
>> Then the xor and the later shifting will move those bits around..
>=20
> I agree with your analysis that in actual practice, almost no one
> actually uses non-ASCII characters for xattr names.  (Filenames, yes,
> but in general xattr names are set by programs, not by users.)  So
> besides xfstests generic/454, how likely is it that people would be
> using things like Octopus emoji's or Unicode characters such as <GREEK
> UPSILON WITH ACUTE AND HOOK SYMBOL>?  Very unlikely, I'd argue.  I
> might be a bit more worried about userspace applications written for,
> say, Red Flag Linux in China using chinese characters in xattrs, but
> I'd argue even there it's much more likely that this would be in the
> xattr values as opposed to the name.
>=20
> In terms of what should we do for next steps, if we only pick signed,
> then it's possible if there are some edge case users who actually did
> use non-ASCII characters in the xattr name on PowerPC, ARM, or S/390,
> they would be broken.  That's simpler, and if we think there are
> darned few of them, I guess we could do that.
>=20
> That being said, it's not that much more work to use a flag in the
> superblock to indicate whether or not we should be explicitly casting
> *name to either a signed or unsigned char, and then setting that flag
> automagically to avoid problems on people who started the file system
> on say, x86 before the signed to unsigned char transition, and who
> started natively on a PowerPC, ARM, or S/390.
>=20
> The one bit which makes this a bit more complex is either way, we need
> to change both the kernel and e2fsprogs, which is why if we do the
> signed/unsigned xattr hash flag, it's important to set the flag value
> to be whatever the "default" signeded would be on that architecture
> pre 6.2-rc1.

It makes sense to use the existing UNSIGNED/SIGNED flag in the =
superblock
for the dir hash also for the xattr hash.  That would give the =
historical
value for the xattr hashes prior to the 6.2 unsigned char change, and is
correct for all filesystems and xattrs *except* non-ASCII xattr names
created on 6.2+ kernels (which should indeed be relatively few cases).

e2fsck could do the same, and would again be correct for all xattrs =
names
except those created with kernel 6.2+.  It could check both the signed
and unsigned forms and correct those few that are reversed compared to
the superblock flag, which should be rare, but isn't much work and =
avoids
incorrectly clearing the "corrupted" xattrs.

Cheers, Andreas






--Apple-Mail=_F5CEB163-EA7D-4B9A-ABEA-18C72CE99631
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPIcJQACgkQcqXauRfM
H+DgYBAAioolu1HjArjRqCPToB/HV1wErzLCZXbd0rGyA99KJABUXqxOv9UXJ6L6
BgoPb2xFM4OE+8Z5gMMD644AKL0WS2Wl67v/OKsS71f0dZ5v6F51ywEQVafx4GaC
LBodsJsyb+6aTPFUK8v6EMh/3fM7Com5sPJge10Wdy8+k8y58cE8QWUD2/NgOdyw
8GA2n2UYKpcRGYAoaJbhn8QVe1aUXVHJ3xHkja3IPdBENokUAmaaK1+uSfZxj5FR
OQpW03mjdVbzAqssZjcRHFBcbvRwdq0WP+WEjieY84Q0pcOrWMio4UIzd4JAmUT5
A1q9730Epc0noWrxjs7kvOweDw3MzDWuUiSHbvnmq91RK1ruA0OMrLqlSJIv3807
zHvb2gmD+IOmXCIIGTPYS/XLIMnFh/eNGHzhwC37DdIA7nXFUt2BAUTYJC/8sw/w
2aOgt7DTcUpMiGJBayh0WAsZv/TMDB/Tqy53I3GtingF50HXmvrRZFiq6lJgqIzx
txaXMiDvwQL/JL+MD/dtKTVryN43WeLpboTIH2Xsz2LJ9azXUKDuel1ptFU6vPLP
UZ5iemJrKzOF4RJd9tGYR2MFocmho08a8R3/USMdSnYVKuDkQ7RpMuOjGYiKoPxH
i5lOAwb3sORs8CwFnWEQmsZdPvKSk40DcpskX1dEgYsVAVjqlss=
=uEc0
-----END PGP SIGNATURE-----

--Apple-Mail=_F5CEB163-EA7D-4B9A-ABEA-18C72CE99631--
