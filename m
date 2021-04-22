Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEE368629
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Apr 2021 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhDVRpa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Apr 2021 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVRp3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Apr 2021 13:45:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C0C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 22 Apr 2021 10:44:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p12so33352327pgj.10
        for <linux-ext4@vger.kernel.org>; Thu, 22 Apr 2021 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DXB9/1gfzB4mXkS7lrJzmLcN0nyNt/zX7a3aSitap88=;
        b=TqN2pVyPhFDQ6uANH3E9TM/hQKLil2TU1kJ8uNroBT0SpJv0wquKoKYuAl2KLRI61G
         ppfkWULs1u9efxyWcSn0vpFoLSuyW7iUtf+0RA2e1sdVWmEle+fHxNmfn+gTlifXLQoq
         4hCq/r2YZ+MSVGprK5wU54p39TwD8YK7muabJJ/8cY8IHPMoxJa8ytkCS8sOIKZKiET5
         QWbZIAghYNbB635eqW+cMp9c2kYjhU8dSi1A/nKpA5goOsLkCTktvwkihe9QB+Ewy8r7
         CNyMZmQYWQB2YB8wnsk+o3s4BwF1n+fou8/pOSNPfjcJT4hrS9VnwaaD7orKUjb8Fqs+
         mwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DXB9/1gfzB4mXkS7lrJzmLcN0nyNt/zX7a3aSitap88=;
        b=V4asHrJQ8RkSoLcoHN5KY37f+Itwj0e4j7CANA+jw6jhK840jxU5GbAWUVkVkEGoO8
         QaTsQX3PTtwKUSW/uShy9cMr2dwrlxKPKsMTemeptPxnGnySLioN8UAURMU5leK/fWbx
         MVtQj2nY1TV0Oldd6rtTPNTyNcPm3OnKHe71IirB2IWnra0v7EGzor59tohOhqthD0qv
         l3cQ10jAtao0JZnupLggmlfCZExBjGt4v7ic7LbwlfDK0wnZL50J4DHYltXedPEFrfgZ
         AfiA1yFN++MdV1zMfs2FKqQsZWvsB/nFgb0gu/qQhO3crkXkWxbK9X7DusfF/VNGdO/g
         CNFw==
X-Gm-Message-State: AOAM533OBONGc9vhdhn5ZuZ3iE496em3F8BpIqZZ5htQ5+A/krUcVWxR
        1LDx5CXz9UEiu8Y6UX06K1Dn0eUHbnjhE3W8
X-Google-Smtp-Source: ABdhPJzOm7+fV74RhPfcF2nm1eCu/H1d9XZBi9JLWnX52nxi/SDmsPc5ioMrqKmkNml+TCwMahLG8Q==
X-Received: by 2002:aa7:8c47:0:b029:25c:8bbd:908 with SMTP id e7-20020aa78c470000b029025c8bbd0908mr4533229pfd.54.1619113492733;
        Thu, 22 Apr 2021 10:44:52 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id ft3sm5527262pjb.54.2021.04.22.10.44.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:44:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3D2D6626-DF0A-4476-AD2D-8E43477A6176@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1C9A64EB-EA0F-4624-A214-6889C2DD6972";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: wipe filename upon file deletion
Date:   Thu, 22 Apr 2021 11:44:49 -0600
In-Reply-To: <YH41aghszkzcwdDx@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <20210419162100.1284475-1-leah.rumancik@gmail.com>
 <YH4KAHWphO+0xubA@gmail.com> <YH41aghszkzcwdDx@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1C9A64EB-EA0F-4624-A214-6889C2DD6972
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 19, 2021, at 7:59 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Mon, Apr 19, 2021 at 03:53:52PM -0700, Eric Biggers wrote:
>> On Mon, Apr 19, 2021 at 04:21:00PM +0000, Leah Rumancik wrote:
>>> Upon file deletion, zero out all fields in ext4_dir_entry2 besides =
inode
>>> and rec_len. In case sensitive data is stored in filenames, this =
ensures
>>> no potentially sensitive data is left in the directory entry upon =
deletion.
>>> Also, wipe these fields upon moving a directory entry during the =
conversion
>>> to an htree and when splitting htree nodes.
>>=20
>> This should include more explanation about why this is useful, and =
what its
>> limitations are (e.g. how do the properties of the storage device =
affect whether
>> the filename is *really* deleted)...
>=20
> Well, it might be useful to talk about how this is not a complete
> solution on its own (acknowledge that more changes to make sure
> filenames aren't leaked in the journal will be forthcoming).
>=20
> However, there is a limit to how much we can put in a commit
> description, and I'd argue that the people for whom caveats about
> flash devices having old copies of directory blocks which could be
> extracted by a nation-state intelligence angency, etc., are not likely
> going to be the people reading the git commit description.  :-)  =
That's
> the sort of thing that is best placed in a presentation given at a
> conference, or in a white paper, or in LWN article.
>=20
> Commit descriptions are targetted at developers, so a note that "more
> commits to follow" would be appropriate.

Since the "delete-after-the-fact" method of security is always going
to have holes in terms of recovering data from the journal, from the
flash device, etc. why not use fscrypt for this kind of workload, if
the data actually needs to be secure?

Cheers, Andreas






--Apple-Mail=_1C9A64EB-EA0F-4624-A214-6889C2DD6972
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCBthEACgkQcqXauRfM
H+Akfw//ae7W/tZsqKaDflklgNwe8+yYL1UQrAKEd1VU4oX1iGjguGDuYrfbF6jK
cmYkdias+kobarmM7QUqORl1Rqh6mF2gxf8+sNMamHf4FJXQAc+xlHLT4mTaUnS1
lWAVeakEIWZsZPThPY/WaGC/O9VU/fJ0ZFK0PerPG371EunGYAKF67lBY5y6z4Ac
cmBF6FHfqvvs8M4cU0OqKzdLokhJfUrTVQTZqz7TcDImlEd3Rlbt6hT3b/CaoY7w
cfkPNdcRjWxOMM/2ntdipjQp4TuzXymVMTOA+f2NOFvdohOHhdJZvDeAfib8W2wp
YZfpQKe3Dz9ryFAm41oFjO5LT4GlOGdhvDxGay0musVPSkkaGRS5GgLsk744JTKT
TcGdG7bcQUSP26mrjRS4wqwu8vncCSfQLazdyLx7BkNVjMESdtRWqLkeQMwHmeFs
0YnjUGoIgvbX8fnez99ixViv97eRCfCNiEkK7FGhuAR/ZE2AvHP5zoxwDPUf0M51
eTAV+36xdmpilTn+4ve78/OjSraB/NUSiyV24bPsWoIvQBrPdBfc2tU476nnqmUc
+PdCfhKS+n4cVI/BNZv6+LRJe1T6MBG9eiJrhFMV0xnJUvwV6dPZXakRdZArNPMj
xCyppVV4+0nhMzrJoqOj3NOF72WiOuD0KVHFvMtPC84pJT1LKdg=
=9De0
-----END PGP SIGNATURE-----

--Apple-Mail=_1C9A64EB-EA0F-4624-A214-6889C2DD6972--
