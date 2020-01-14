Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6389513B3B7
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 21:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANUfs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 15:35:48 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39968 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANUfs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 15:35:48 -0500
Received: by mail-pf1-f177.google.com with SMTP id q8so7128862pfh.7
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=SUujCNjmdhgzfvbavJWyd4ILjMzzDK6CMcgdmmxn0Yw=;
        b=k8OcQbDzrIcyJ6gLd4RjZRS+TncrlPe9fK3a/mlH07n1vseapCAXxnbsQrbkmdjkpQ
         T1LQ/QdgLpjLdEAFQZz0wAZp/q8iMEjlrB9wTBTgEcGOCCBvCZ7p6ftL035jJ7ccbA9d
         HRDA5GRhX2wKPkiCyU233LW8nHqvGpGByJWzkks7TBNroEK8yN2sjXvz/NAq/1svl4SH
         Y1kkDPYRTE4KV53p2u7RrfxhE+lqeq9D6P2lJ+c13m17MwsA0219PZD3y5kXZGnunhHn
         +kt/vBKKkvAp5DFctHGCHbvE/o1qT3GpDdxALfVjlb9lzl1drUUbeUJIT8nEPL8iGXEb
         qUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=SUujCNjmdhgzfvbavJWyd4ILjMzzDK6CMcgdmmxn0Yw=;
        b=hwBeL+Z1/j/MIavvIhj22MZhgr0iuxhFtAeEh3PBAvgU3fMBF/ztbfkjX8o2+SGVFC
         SSUW8lNNcNVILwsV2gYZGGgGK52V/lBHxaWnEQuJdEwLJkGP2A1RdXM+IaIo65GJSltc
         EwtrxJJqr0PAttis2sCsq+vJWFuFRIWmelsAcgHMmoCVqvJ1qifLklRfi8FlRsRcLc0M
         yflcs/iQTfc5i6L1I2MWxAU0/hLcTImfx4qjs/Mw0w0acMnE7SWlCaSnC7EWYJXpHrDE
         Z8ti+l4LFSJ+6pCsxkY4iiinfirPZzX5rXXwTBAg4mz/3vgiZ1uQ6vzc1OQbbCDQrzWN
         O9ng==
X-Gm-Message-State: APjAAAVjWjdYowz3PTqV+hoko56FEaKsfZkfv6GkX9Go1qhWv4a1K1Ti
        7sw9iBHBW8ENDYhFnoqL7c1YzBWrZ4E=
X-Google-Smtp-Source: APXvYqw36xmg+wHmp9o3FtnGOay31AnD5ZkjpqjiXfGDgiVvsgnprOrK9p0rgkU1duow9Yq2OXdikQ==
X-Received: by 2002:aa7:95a3:: with SMTP id a3mr28039586pfk.193.1579034147563;
        Tue, 14 Jan 2020 12:35:47 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a17sm17960486pjv.6.2020.01.14.12.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 12:35:46 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FB71CEC8-E563-49DC-B39C-5DC1C002E5A9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_482474B9-C778-48AD-B6CC-F27614DF0F81";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 recovery
Date:   Tue, 14 Jan 2020 13:35:42 -0700
In-Reply-To: <CAAMvbhFjLCLiLKhu5s7QtLdUY29h8eZ2pHd120o94gDduo+BLw@mail.gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     James Courtier-Dutton <james.dutton@gmail.com>
References: <CAAMvbhFjLCLiLKhu5s7QtLdUY29h8eZ2pHd120o94gDduo+BLw@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_482474B9-C778-48AD-B6CC-F27614DF0F81
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 14, 2020, at 9:03 AM, James Courtier-Dutton =
<james.dutton@gmail.com> wrote:
>=20
> Hi,
>=20
> Say I started with 1 disk using LVM with an ext4 partition.
> I then added another disk. Added it to the LVM group, expanded the
> ext4 partition to then fill 2 disks.
> I then added another disk. Added it to the LVM group, expanded the
> ext4 partition to then fill 3 disks.
>=20
> One of the disk has now failed.
> Are there any tools available for ext4 that could help recover this?
> Note, I am a single user, not a company, so there is no money to give
> to a data recovery company, so I wish to try myself.
>=20
> Is there a mount option that will mount an ext4 partition even if
> there are lots of sector errors, or a missing disk. So, at least some
> of the files will be recoverable.
> Or a tool that will scan the disk for super blocks, then find inodes
> and then find the sector location of the files, even if they don't
> have filenames.

The first thing I would do is get new disk(s) to make a full backup of
the existing disks, so that whatever you do for recovery doesn't cause
further data loss.

There are two approaches to recovering the data:
- add in a replacement disk and re-add the missing LVs that fill in the
  lost space of the failed disk, then run e2fsck to rebuild the metadata
  for the missing disk.  I'm not sure how easy/hard this is with LVM.
- use a block-level scanner to recover files on disk, which is useful =
for
  e.g. .jpg images, or other files with good magic signatures and =
internal
  data integrity checks.

You didn't mention whether it was the first, second, or third disk that
failed.  If it is the third disk, that may not even need to be replaced,
since you could set the filesystem size to be the end of the second disk
and then e2fsck will repair the bad block/inode references.  If it is =
the
first or second disk then it is more complex.


Cheers, Andreas






--Apple-Mail=_482474B9-C778-48AD-B6CC-F27614DF0F81
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4eJh4ACgkQcqXauRfM
H+DLiBAAl7ZH96Q129Lm6W21JFdC+EWK+DkHDMk8HimMzdiERuchr5mfxuCQb7dX
nWMO6pBqf7kHFYxYum/4Gqsl2WFovchtuOihHu2MUIUPmGVTsqKRnvAQKo8iSNY+
BPyi2LeJwRgvUxAnTt4q/kr4dNwtjzWMB6SG7HLzxovEjwAXsr0RuwX8Zu6T+rwg
vDFuaVxy+A0c4UqFl/wkk767qjZIDQVqSybkwpjjcOQEl9az4TPhmD9kzoKafYwh
gjYEhJ79g3e40GBco15UQSgne5CQHk7s2e30tvOgsgNPnCwTj+xZ0pVsQjrXGM7O
GnziEAPSBs0frqOds6kpqCH2ZrHa0pPOoC6waYqdpPPtmra9UgVE5zQ3C8tHmT6f
kZFbmsjkQPSyhcNVzz+r66IFdi+nkiZKwPUqJqUjMujc4XpJblq5FnHwsKKEwZ+2
e8NzAJjrpdRPVsKsIsBKMww87YXSSTX5mvCqyVgvpnQ+RhcaL59ryN4+uELtj211
LldI48eQpqxjigw/fJKdlsEZQPfMqkMOtezixwXu0IxtzjJ63uIKd/CXODn+BkO5
2yGCyl33MlXGwhGaIhQgG9PJiHidqhUf13zJPMzFNvX3gd8Jm+v89em2+b2QNFfq
5upflDg/Hb0bR604wq87S7eAPiRvKVdw4Uu4FM0uFeWk9mIbCA4=
=3EYt
-----END PGP SIGNATURE-----

--Apple-Mail=_482474B9-C778-48AD-B6CC-F27614DF0F81--
