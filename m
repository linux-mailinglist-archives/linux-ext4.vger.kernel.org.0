Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1A4310B
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 22:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbfFLUkX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 16:40:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41739 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbfFLUkW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 16:40:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so9835181pff.8
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jun 2019 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VlPEcmst0CYRlRshN2RIWjTTM4YgbYOdNEM+OJeaprA=;
        b=sxTZjPEeGlJ8Se8Oi8Y1wsNVHbsxski8YIb57diaSefr0ZKJqgDVmR6GWn38LAaIaV
         dXgcbz4Afqb0KaxifNG6DECqHHVgg+HgTO2LeSBu7zhfg79hIl8uJuunQPX8/Y2ZZb/g
         DSAPt859PP2GCXx0HORJ5Cf38FoBaIHQAnioLDXZRhoGahcu8b2PrnLWiLt5ginBMB6u
         HhfoH1Fw13Sog21WcHpv3+gtzynyuxgbS4c6wJ9gxiSP6J8Curjmqu/STvwuIK2/9CuH
         xC6sEiym/4b7J5kJ6PvEPQih5c7sbbHksAWullMPRrU2HZxVFIaVc/AYkZ33wMeMH0ji
         ehrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VlPEcmst0CYRlRshN2RIWjTTM4YgbYOdNEM+OJeaprA=;
        b=EyUlM4q2qNQqxCUESUv/+ywA6VPjVXK8oExujzYJwaksv2zwoKlp7sTgGMKcQn7Izm
         Z2AXLqETPyJim4KrY1uW1aXGpBTofA0RTjmCZIa0hs2yQ7yTf9DUndmDRkY4kcf7mw1h
         q6OXojE9jRTilBg6L7WXtFG8rAMpBY0uhaOXNbJN9CJu1BcpAoO1lu1gbFS5PjeAttbe
         5ZrXIuSkTeWjcIuggAqhicWg+SltpK0nlvEZhY9twbqw0NlyreqbWO4PsQy5asw0Sc3n
         iLWl53NJ6vwphbMJUyJaeTHF5B0MlW5FrMacsFNrtSFMNenV4Vcd1zpUITBkbLmBm0Jl
         tACQ==
X-Gm-Message-State: APjAAAX+ImpiFMpHKBfJFUjrjhwc8hGv9doLxFe001bSJAZYqllJ4SZL
        RuaspfzAWvM2xczqj1Htc1L5Qdthz13QqQ==
X-Google-Smtp-Source: APXvYqzRo/swIjA5qvicIUHq9st+Arak9v/IEFTj4ALgQYBP+lbTa9T66i4vrnAWc9sjD/dWaE9zwg==
X-Received: by 2002:a63:c508:: with SMTP id f8mr27214665pgd.48.1560372021547;
        Wed, 12 Jun 2019 13:40:21 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z11sm90727pjn.2.2019.06.12.13.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:40:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <044ADDD7-D7C0-4E27-B9E7-E576CDEDD1C4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_018AF451-3F80-4D65-B644-31EBD05EFA25";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: fsck doesn't seem to understand inline directories
Date:   Wed, 12 Jun 2019 14:40:18 -0600
In-Reply-To: <ee4ad9f4-6706-136d-4cd8-dcf1b58e4229@rasmusvillemoes.dk>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Li Dongyang <dongyangli@ddn.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <ee4ad9f4-6706-136d-4cd8-dcf1b58e4229@rasmusvillemoes.dk>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_018AF451-3F80-4D65-B644-31EBD05EFA25
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 12, 2019, at 8:07 AM, Rasmus Villemoes <linux@rasmusvillemoes.dk> =
wrote:
>=20
> Doing a forced check on an ext4 file system with inline_data results =
in
> lots of warnings - and I think answering yes to "fixing" those would
> actually corrupt the fs.

Rasmus,
This definitely seems like a bug in e2fsck.  It isn't totally =
surprising, since
the inline_data feature is not widely used.  We are currently =
investigating using
it for regular files, but it doesn't seem worthwhile for directories to =
me.

Would you be interested to take a look at fixing this?  It seems like it =
would be
mostly a matter of adding checks for the EXT2_INLINE_DATA_FL in the =
various parts
of e2fsck that are generating the errors, then encapsulating the test =
script below
into a new test case for e2fsck.

While there are a few test cases for inline_data =
(tests/f_inline{data,dir}_*),
it seems they are all checking for corrupted inline files or =
directories, and
not for "valid" inline directories.

It _may_ also be that this is a recent regression, so it wouldn't hurt =
to try
your test case with an older version (e.g. 1.43.1 or 1.42.13) to see if =
it was
working, and if yes use "git bisect" to track it down.  That would make =
it pretty
urgent to fix, since the new e2fsck-1.45.2 release would suddenly =
corrupt any
existing inline_data filesystems.

If this didn't work in 1.43.1 or 1.42.13 then it seems unlikely that =
anyone is
using inline_data at all, so while it would be good to fix this bug it =
isn't
nearly as urgent.

Cheers, Andreas

> To reproduce:
>=20
> truncate -s 100000000 ext4.img
> misc/mke2fs -t ext4 -b 4096 -I 512 -O
> =
'^dir_nlink,extra_isize,filetype,^huge_file,inline_data,large_file,large_d=
ir,^meta_bg,^project,^quota,^resize_inode,sparse_super,64bit,metadata_csum=
_seed,metadata_csum'
> -U random -v ext4.img
> mkdir m
> sudo mount ext4.img m
> sudo chown $USER:$USER m
> mkdir m/aa
> echo 123 > m/aa/123
> touch m/aa/empty
> seq 10000 > m/aa/largefile
> mkdir m/aa/bb
> mkdir m/cc
> sudo umount m
> e2fsck/e2fsck -f -n ext4.img
>=20
> The last command gives this output:
>=20
> -----
> e2fsck 1.45.2 (27-May-2019)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> '..' in /aa (12) is <The NULL inode> (0), should be / (2).
> Fix? no
>=20
> Unconnected directory inode 16 (/aa/bb)
> Connect to /lost+found? no
>=20
> '..' in /cc (17) is <The NULL inode> (0), should be / (2).
> Fix? no
>=20
> Pass 4: Checking reference counts
> Inode 2 ref count is 5, should be 3.  Fix? no
>=20
> Inode 12 ref count is 3, should be 1.  Fix? no
>=20
> Unattached inode 13
> Connect to /lost+found? no
>=20
> Unattached zero-length inode 14.  Clear? no
>=20
> Unattached inode 14
> Connect to /lost+found? no
>=20
> Unattached inode 15
> Connect to /lost+found? no
>=20
> Unattached inode 16
> Connect to /lost+found? no
>=20
> Inode 17 ref count is 2, should be 1.  Fix? no
>=20
> Pass 5: Checking group summary information
>=20
> ext4.img: ********** WARNING: Filesystem still has errors **********
>=20
> ext4.img: 17/24416 files (5.9% non-contiguous), 4096/24414 blocks
> -----
>=20
> Am I doing something wrong? The kernel mounting the fs above is 4.15, =
in
> case that matters.
>=20
> Rasmus


Cheers, Andreas






--Apple-Mail=_018AF451-3F80-4D65-B644-31EBD05EFA25
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0BYzIACgkQcqXauRfM
H+Av8xAAl1g8fGXNQ1VGziWN4R+NarkYblEa3+TUCPMN98kZQx0S+2LrTV4Ty/5/
1DbSPZOOV5CKlAztBjwCBIwece6icRTB2cvQGXXxbtJG2gtz4mfKYsN3rH4NeVEk
ztnjqYNjiBxpBbPEYbjKOAzHreGmD/KdgAqr1SsCR0HIaQSSxv2pBmW1KY07lboO
Pl6Y5Tks7bKQE/xmBSwilnG6ogedLSOk3ljPcoRcXVtEW1yTZwFiVPY5hJz4pJOW
B8EzRMTluI3aThhzi7VDs5R3T7i2f8UMJNQM1F0j7bF3R+7tG5RNVW7obXOUA99U
WToh+S2Q/G1SCYHR87O+mgRBgzUifmflxLDlQYoFrDc/QEd5K8CEY6gZ9REvwcol
AiL9uhTEENTrEFgibTe8s+n4CDjpNda4wcXcMJjsCcXFy7U+kOXDAZrtkKfmdQWZ
VTCKLlpL14g3qRDEKUlyHnHw2/j4Q2BX5nMqfkIj+s3ERMCnazEWN/JyOfDQY1sh
ukaw+KknlfX1iB3Fo0D5jl5jGH5mdOWq/ncL71NMJAxv3JgjK8fnMHYdrZ1UGwk1
TwEdrBt+4yowQcRLl6ZamDzVl8xCoRzpmLAL6xAD2YgKLd1Jj7CuLT+MblPE5TH6
BCXi9Q9TDW81bbvHr/U3DOZ6poL81waljLGzq8iErC4rKze7pFk=
=0Rlg
-----END PGP SIGNATURE-----

--Apple-Mail=_018AF451-3F80-4D65-B644-31EBD05EFA25--
