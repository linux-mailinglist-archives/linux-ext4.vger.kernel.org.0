Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96AE446DB
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfFMQzD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:55:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46624 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfFMCWZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 22:22:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so10769301pfy.13
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jun 2019 19:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=zU2n0N0/t9kv4ObudgO4R33NHBrij+YDzTMHpRNMpuQ=;
        b=gcb6BqukwbaFIllCeQ8Ifucr7BKDQ7aGWH/ETYF8U1sKNcaGJ5cJqAcwT94TrK0ICw
         w78vSF0RVG4HoxfRI2xQ+kAJNO3pRAgVgepXOBYbWgLnbQBRhMp1dFWN89q+UzSEPrLP
         NNuB9E+AaKUx43SUZa6l+5qnA0GOqKLh+tPK22PQ06oTprFiezNG8rJDkXkNAbGn080q
         d7BmHslYD2hAToJaujx53q9ztSeKIt0QbhXYsL9FS8BfApUye6i5vSt/Bey9hC13UE0c
         sJm/BnzTUtr0yKjEQyh1HOVpSO09ECT4/csUJjrPM7SQGSTYdwpiLY+57ZC1VVo9MJHr
         0GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=zU2n0N0/t9kv4ObudgO4R33NHBrij+YDzTMHpRNMpuQ=;
        b=VvQXQVKFoLNWg76M7nWD0pMeLdfYnYMLGLY6NsMj8hEd2sudotgGtp1W8Ry+beyAW/
         RMuBJsIKQbwnKKN0KOWGV9nVXkKQASNejFNZcj9UuLGpuYtVkaPohTKrlhD7I2jVsHV+
         Y80mr4VTX3xXEsWZW/kdlamyaS6Z4FLDk1fOG7DHU9qKP+uEGJ/mB6ww5IAlb4AlW935
         5EXXG/h2MKCYylQ3/2F82N0YJa9KQy+bnlNy1WkL8huFBGQhbRgTjbUFal5zpl4c2UTu
         cdq/19tT3S70HtK873PMTEZwbV/CXISg0IShIld6sfwy7JWtN8kxMiOgD+oxQg6pAcxf
         bJNw==
X-Gm-Message-State: APjAAAXPil0R4s8DbzTkBNd1f4YdOFVXawjS4tCtMVWCWoBepolMRjbM
        97dBGvtj03oclHMMyNYBpbRhLg==
X-Google-Smtp-Source: APXvYqwJNUbfP2m3hTuUAktlsM7bxrdJkWqfyNMfEu9icihy8Jeq3fVnO9uJqwC6oiOvLbPH9H5DYg==
X-Received: by 2002:a63:52:: with SMTP id 79mr27649573pga.381.1560392543628;
        Wed, 12 Jun 2019 19:22:23 -0700 (PDT)
Received: from ?IPv6:2605:8d80:4a0:413d:1867:1e8:50bf:35d0? ([2605:8d80:4a0:413d:1867:1e8:50bf:35d0])
        by smtp.gmail.com with ESMTPSA id 128sm869732pff.16.2019.06.12.19.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 19:22:22 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AC3B5A45-B5AB-461B-82BD-DDEB0FF6BF3A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_19761DF3-B4FC-46ED-8855-85F052F5B1AE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: fsck doesn't seem to understand inline directories
Date:   Wed, 12 Jun 2019 20:22:18 -0600
In-Reply-To: <20190613015056.GA2956@mit.edu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Li Dongyang <dongyangli@ddn.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <ee4ad9f4-6706-136d-4cd8-dcf1b58e4229@rasmusvillemoes.dk>
 <044ADDD7-D7C0-4E27-B9E7-E576CDEDD1C4@dilger.ca>
 <20190613015056.GA2956@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_19761DF3-B4FC-46ED-8855-85F052F5B1AE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 12, 2019, at 7:50 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Wed, Jun 12, 2019 at 02:40:18PM -0600, Andreas Dilger wrote:
>> On Jun 12, 2019, at 8:07 AM, Rasmus Villemoes =
<linux@rasmusvillemoes.dk> wrote:
>>>=20
>>> Doing a forced check on an ext4 file system with inline_data results =
in
>>> lots of warnings - and I think answering yes to "fixing" those would
>>> actually corrupt the fs.
>>=20
>> Rasmus,
>> This definitely seems like a bug in e2fsck.  It isn't totally =
surprising, since
>> the inline_data feature is not widely used.  We are currently =
investigating using
>> it for regular files, but it doesn't seem worthwhile for directories =
to me.
>=20
> It looks like the problem is the combination of large_dir and
> inline_data, and it does look like the problem is in e2fsck (as
> opposed to the kernel).
>=20
> Large_dir is a new feature (even newer than inline_data, and it looks
> like the support for large_dir didn't handle the combination with
> inline_data correctly).

Strange.

Artem, any chance you could look into this?

Cheers, Andreas

> # mke2fs -t ext4 -O inline_data -Fq /tmp/ext4.img 1G
> /tmp/ext4.img contains a ext4 file system
> 	last mounted on Wed Jun 12 21:47:25 2019
> # mount /tmp/ext4.img /mnt ; mkdir /mnt/aa ; umount /mnt
> # e2fsck -fn /tmp/ext4.img
> e2fsck 1.45.2 (27-May-2019)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /tmp/ext4.img: 12/65536 files (0.0% non-contiguous), 12954/262144 =
blocks
>=20
> ### So everything is fine with just inline_data, but when you
> ### enable the large_dir features, and rerun e2fsck....
>=20
> # debugfs -w -R "features large_dir" /tmp/ext4.img
> debugfs 1.45.2 (27-May-2019)
> Filesystem features: has_journal ext_attr resize_inode dir_index =
filetype extent 64bit flex_bg large_dir inline_data sparse_super =
large_file huge_file dir_nlink extra_isize metadata_csum
> # e2fsck -fn /tmp/ext4.img
> e2fsck 1.45.2 (27-May-2019)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> '..' in /aa (12) is <The NULL inode> (0), should be / (2).
> Fix? no
>=20
> Pass 4: Checking reference counts
> Inode 2 ref count is 4, should be 3.  Fix? no
>=20
> Inode 12 ref count is 2, should be 1.  Fix? no
>=20
> Pass 5: Checking group summary information
>=20
> /tmp/ext4.img: ********** WARNING: Filesystem still has errors =
**********
>=20
> /tmp/ext4.img: 12/65536 files (0.0% non-contiguous), 12954/262144 =
blocks
>=20
>=20


Cheers, Andreas






--Apple-Mail=_19761DF3-B4FC-46ED-8855-85F052F5B1AE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0Bs1oACgkQcqXauRfM
H+BX4A/9EVEfKHnLFlwA3e/26mUPXCdXCPvHi7FWVHolwOyj5DRItRhxGCYEg331
gRx7hSsaXQNcArGmrswtRbeqQB8NS5q4gny4h1NB2PrHM+eR76tLiOwd2+JJpb7F
svWrnJ9bV9YZDXESrxAbXCnz7Fgmp4b8Sb4De3yfayvoeCa86qmF/EweE8yWuJCt
xUR2xQPppMsII6zuEdPu1ySx8iBU0zsk2X2Zf0zER4JyPHirEewJkXyzAEf2O2kv
8jQDC0ZjG2URb45NwBl4KvpFVkVN8ORhgLHzAinwq8JRCbkzi8I8/q/wTd4FQaqo
Hv0J3ZoQdL0soEUz7g1/MjJ+yVcdiQpoWjZmCRQAW+MYN2g/ZhfVRx2RoqdM+dkO
0JMN4z4TYIGSSdvLZgS/tNM/QZJtwjn4Mp39GOVD8PpIud+0LuB/Ipd01bbw9MEL
RynYqqkymuUMzH5zwxKhdvhiIpUr03rC9SV8pkQMnqTFSTGqdCQ4UlJOg78vr+Ti
Zo87JyYzFsCCXWTrxNODwf65yyBLcLkT4Cm31ZhfGSR4tUrwh94+Z/nVkv+xzd+S
+kRIJemy/GzpnJU0t2RQ1aTP9bRvTCA9OgtJnboHefYsiKNCnAlVNdXM7XXfpSg4
tdiqgw13BUIQonTV3EJ1D20AOsJAWgZUOsrj6IL2UYaAyWerRtk=
=3fFR
-----END PGP SIGNATURE-----

--Apple-Mail=_19761DF3-B4FC-46ED-8855-85F052F5B1AE--
