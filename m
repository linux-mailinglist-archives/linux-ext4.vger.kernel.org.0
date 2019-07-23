Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB147721E4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2019 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392245AbfGWV7r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Jul 2019 17:59:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43052 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfGWV7r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Jul 2019 17:59:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so19804494pfg.10
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2019 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JvatPS91EAjLyYj/evZYqLCKU+WXleNOP+uX7IhZT3E=;
        b=xysqSpan6pE68yPtjQQZmIQ7Z/0rnSEAgh8FM7UOAyyTtUfqNdep5IQoHXe54Gdm8p
         7vK1cg2O8Fsyq/JoDNEyPovySOoqEU3pq4jhtgcp8vwIhMC26q80VGiMqTyS/4LDNKkI
         WOh7DyZhLaFPmKKQlVuIN+3oenpRDTwQO/GJHVgHuViBfoz7p95hO1ppz0wbSwoxeqav
         U5nhg/QYyKJQ4LBm3ED4VfRaYEb7SMSAFzgccZCfntbxXylGL3eLq97KHfkpishDuKor
         h9aC8rcHV/0X7+xsTWzOuFX6QI8CyOjfGV4a2iXOHXYLg5W6Bxf85+ukR1AfP2a9bYNW
         kN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JvatPS91EAjLyYj/evZYqLCKU+WXleNOP+uX7IhZT3E=;
        b=Jk+C6x3KwmeaqAL3ISN6ARxDj7Pe0qixiA4WR+3m/fIDhXOtjbmzflnuIkgEMTHzer
         wRHBf2BkxzDKCpvCHl68yIv6vSTVwCuTdtrV4SjorAwwdqbwtv83WbBCH8+4cKv2vuRu
         g+uRpFDIES2bZwjVnYGCpGyvV0Vi00wvQSKZ5EL8hSgn/prktJsTjXRxYWvNImLBxbDd
         y38AshfMq7bloCYoUczhNTSd7N8Hg974L7bSj903k6XQWLVis5i9+dvE6q3EZcZyIkvg
         Ejmv/7ZKUTu0cpqhkjJ8ZLP6mo0a8CLLgItpV5GtYetjKX3rqJ54zbJphCKDyH4hPsVw
         e9tA==
X-Gm-Message-State: APjAAAX8ml9us2o5nrFOt3SmhonAuw64s83mWKa8KDVucRHqjRhhfKRL
        UAqB9DFMRedutMOmjFQk2pI=
X-Google-Smtp-Source: APXvYqwINxUpi13XhdKCykVV3LHyGDHwGwbZWedRzzo4tXo9S+Cac4RsHWwpwPzm2LmVtTni3EU7xA==
X-Received: by 2002:a62:4d85:: with SMTP id a127mr7886299pfb.148.1563919186228;
        Tue, 23 Jul 2019 14:59:46 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a16sm46444855pfd.68.2019.07.23.14.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 14:59:45 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_ADF40E20-376C-457C-AF89-F9A9D489C316";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Date:   Tue, 23 Jul 2019 15:59:42 -0600
In-Reply-To: <20190722210235.GE16313@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
 <20190722210235.GE16313@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_ADF40E20-376C-457C-AF89-F9A9D489C316
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 22, 2019, at 3:02 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Mon, Jul 22, 2019 at 12:15:11PM -0600, Andreas Dilger wrote:
>> Unless I missed it, this patch series needs a 00/11 email that =
describes
>> *what* "fast commit" is, and why we want it.  This should include =
some
>> benchmark results, since (I'd assume) that the "fast" part of the =
feature
>> name implies a performance improvement?
>=20
> For background, it's a simplified version of the scheme proposed by
> Park and Shin, in their paper, "iJournaling: Fine-Grained Journaling
> for Improving the Latency of Fsync System Call"[1]
>=20
> [1] =
https://www.usenix.org/conference/atc17/technical-sessions/presentation/pa=
rk
>=20
> I agree we should have a cover letter for this patch series.  Also, we
> should add documentation to Documentation/filesystems/journaling.rst
> about this feature; what it does, how it works, its basic on-disk
> format changes, etc.

Thanks for the link, I hadn't read that paper previously.  =46rom =
reading the
paper, it seems there are some things that should be addressed before =
the
patch is committed to the tree in order to maintain proper disk format
compatibility:
- the ijournal header shows a 256-byte inode.  In Lustre today (and also
  Samba and other xattr-intensive workloads) 512- or 1024-byte inodes =
are used
  in order to store more xattrs within the inode, so the size of the =
inode
  data in the ijournal header needs to match the actual inode size of =
the
  filesystem and not be a fixed size.  What if the inode size =3D=3D =
blocksize?
- the ijournal header also shows a 4-byte inode number.  It would be =
prudent
  to reserve space for 64-bit inode numbers, or at least have some =
mechanism
  (flag) to indicate that a 64-bit inode is stored instead of a 32-bit =
inode.
- if there are many cores in a system, say 96, how much space will be =
used
  from the journal file by the per-core ijournal?
- what happens if multiple threads are writing to the same file with =
ijournal
  and per-core ijournal areas?  Will the same inode information be =
recorded
  in multiple ijournal areas?

Cheers, Andreas






--Apple-Mail=_ADF40E20-376C-457C-AF89-F9A9D489C316
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl03g04ACgkQcqXauRfM
H+AnBBAAqW4PcWWVoiKAbsD38Mh4JdOMlzg4IkfpbURTw5ZRw2ld1nZ4JKjn4WcH
9mPI8T4uwWM6JxU6PafjB12/8g30bD2VVSUStUuc9fUNvX2dxn0UxmPfphluVLwn
e38tN6O6r5QdADIvaIQ3EKEKD6bcfTqCEDzpFqwV2eGvcf87sxQIJT48pMiyjpp3
eT1ODzBkh32JIgZdemEv3sg6jPlhkxHj7Tyqhi0IyBsVafaKcEJijoMnAxaKDOpS
+Q2UvzAdh7nNcDXQ6f46n6Julps9km6EOccuAm7T+PMS7PAJM05McIWXo+mRbbyb
xpsOOLVD92ky7TWnhZlHW1xF7dIMvDiy5tlFRkvf9YdYztyIG7M031Q2+RWSlXlk
1XBZXorL+kHSGio3ZY6wKlITwbXSEx+/VfLBa+27d+UqrnkrqaFKubssLu0umzLh
62RiQeJQ/Rb2K1ztEMlxu0Ddgqh31TTpkKpn3dkpM0qb2Y5Z9/dJ3uWQ3aPh2E1o
D/SeRPpcMHnhptr6VNYO0+6Exufn0Elwu+b30yBdUATGbM/aPyrrhDcLhJFbeGZG
00l7bwKd3gD8f0PysHd/JnLTD7kUoUHeQjI3uJPJBPPzQ8PrYjpwcLx5RfxI+Ytu
jX7W1aHm2ZDhzPl8zJvD2o7Pk1rLS8AMFXZDq/Z2Yb+DRQDcb5A=
=ug/G
-----END PGP SIGNATURE-----

--Apple-Mail=_ADF40E20-376C-457C-AF89-F9A9D489C316--
