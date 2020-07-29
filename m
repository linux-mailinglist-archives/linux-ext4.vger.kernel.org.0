Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA82325E1
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgG2UJL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgG2UJK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 16:09:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAAEC061794
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jul 2020 13:09:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 74so5324204pfx.13
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jul 2020 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=xWKolhp+xjYOfse+K3ZZ3CjsNTLKuThMe9fBfqxuG/0=;
        b=kISoZA1AVq38hPkUpNSVAMnEl8DsMuYz4aBFaaxDhfOvCfzBYLvsA3scgsIuCGmTXp
         Bnpy5BQlEUmPpP4l5qhNpT24SGlBqZwo4ECBh4D3cND/ikXXkgbqBwMpCYOHSBY0438f
         fGHFLDkOE9j0DsD1JkG+szjp6OIgynL4+j7kBbkTalsBsFQMFK/yAFU+szvwRs/LE1Xg
         ciLYvSEZT9B1cq/ptwmH7iPmM0eFt/DpyJp74W5IhQ2w1NzpD4I9SU99HhDcZWmvVftI
         /ncGcGMCSkqetkJv6IcW8n0/WESjdqnQGVtUxDnuGEud9gTZN3SdAyc1Uf15LaX1Uw77
         YXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=xWKolhp+xjYOfse+K3ZZ3CjsNTLKuThMe9fBfqxuG/0=;
        b=NW/YCYrQJrwuoaAF50f8ixA4Ieita6YcEuovXh4MhSFmRtVLoTxZpSgjWgobruIdmd
         FN6l0DP2XcfRWtq1nv4KOg5bGOG4Hdu0e+JfgmSz/v3gk/yn9sjNN83SUp4gJtNQ8or6
         du4NrxfQwzuOad2qJHlRvGOPFbaUvU/g7vkuihnHo2+Y+tsZ8oqN0E6i4NPbpWjV4YeE
         j9o1XKqBouGKCHzHiVML5gXC9bD0ADXMnbApocqnGk3YvVbF4gRfvA58S6tJdScpg+Po
         wjEsVGA1laQQ7TGbDQNyOqDepktHizy7VnQR2iK6Liyb//vbCmg9u+GOGn5y70QbYjxm
         Np6w==
X-Gm-Message-State: AOAM533lFkz9eDxBsODPt8M0OBxKCb/g0kEhE4Mn+UDOBTB08SkkQOBF
        Gqo+D12tQ6j3yU3jAlxdlq2k5LVvDWQ=
X-Google-Smtp-Source: ABdhPJwAS4p8mRU5xPMRmrAzAo40aBo6B83m72XVI3dOOTK+bafivrbee0AbXygA3nbW40NKTft+sw==
X-Received: by 2002:a63:cf49:: with SMTP id b9mr29840208pgj.31.1596053349863;
        Wed, 29 Jul 2020 13:09:09 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y65sm3267920pfb.155.2020.07.29.13.09.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:09:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F98B4E81-C4E7-4E0E-83B2-224AF7E72283@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_44D43FA3-A251-461F-A353-2D8D8D096051";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4/xfs: about switching underlying 512B sector devices to 4K
 ones
Date:   Wed, 29 Jul 2020 14:09:05 -0600
In-Reply-To: <CANR1yOpz9o9VcAiqo18aVO5ssmuSy18RxnMKR=Dz884Rj8_trg@mail.gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
To:     Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
References: <CANR1yOpz9o9VcAiqo18aVO5ssmuSy18RxnMKR=Dz884Rj8_trg@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_44D43FA3-A251-461F-A353-2D8D8D096051
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 29, 2020, at 4:38 AM, Takuya Yoshikawa =
<takuya.yoshikawa@gmail.com> wrote:
>=20
> I have a question: is it possible to make existing ext4/xfs =
filesystems
> formatted on 512B sector devices run as is on 4k sector devices?

For ext4 filesystems that are formatted with 4KB block size, there
is no problem to change the underlying sector size to 4KB.  It will
never access blocks that are not sized/aligned at 4KB.

Most ext4 filesystem are formatted with 4KB blocksize by default,
unless it is a tiny partition like /boot that *may* be formatted with
1KB block size to save space.  In such cases, it would be easy to
format a new /boot with 4KB blocksize and copy the file contents over,
since it would be a very small partition.

You can check with "dumpe2fs -h /dev/md127 | grep | grep 'Block size' "
to see what the filesystem block size is.

Cheers, Andreas

> Problem:
>=20
> We are maintaining some legacy servers whose data is stored on
> ext4/xfs filesystems formatted on lvm2 raid1 devices.
>=20
> These raid1 devices consist of a few iSCSI devices, so the
> remote storage servers running as iSCSI targets are the actual
> data storage.
>=20
>  /dev/md127 --  /dev/sda  --(iSCSI)-- remote storage server
>                 /dev/sdb  --(iSCSI)-- remote storage server
>=20
> A problem happened when we tried to add a new storage server with
> 4k sector disks as an iSCSI target. After lvm2 added that iSCSI
> device and started syncing the blocks from existing 512B sector
> storage servers to the new 4k sector ones, we got
> "Bad block number requested" messages, and soon after that,
> the new device was removed from the lvm2 raid1 device.
>=20
>  /dev/md127 --  /dev/sda  --(iSCSI)-- remote storage server(512)
>                 /dev/sdb  --(iSCSI)-- remote storage server(512)
>              *  /dev/sdc  --(iSCSI)-- remote storage server(4k)
>=20
>  The combined raid1 device had been recognized as a 4k device
>  as described in this article:
>    https://access.redhat.com/articles/3911611
>=20
> It seemed like 512B unaligned requests from the xfs filesystem
> were sent to the raid1 device, and mirrored requests caused
> the problem on the newly added 4k sector storage.
>=20
> The xfs was formatted with its sector_size_options set to the
> default (512).
> See https://www.man7.org/linux/man-pages/man8/mkfs.xfs.8.html
>=20
> In the case of ext4, the device continued to run, but I was not
> sure if there could be any problems.
>=20
>=20
> Question:
>=20
> Is it possible to change the underlying storage to 4k sector ones
> as written above without copying the data on the ext4/xfs
> filesystems to outside of the raid1 device?
>=20
> ext4: I am not seeing any apparent errors after adding the 4k
>  device. Is this an expected behavior?
>=20
> xfs: is it possible to change the filesystem sector size?
>=20
>  I read this explanation and thought if I could change the
>  journal related metadata, it might be possible.
>  https://www.spinics.net/lists/linux-xfs/msg14495.html
>=20
>=20
> Thanks,
>  Takuya


Cheers, Andreas






--Apple-Mail=_44D43FA3-A251-461F-A353-2D8D8D096051
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8h12IACgkQcqXauRfM
H+BrHg//RHLqCE/fuim4cDziFXn5eZ3zoF48M3q169atvDhZxsodSUD4AvOv/lWv
3qZiXlcTPGpjX8aQYCQQo2gurh+MHimGTTeihZbEEf8yqijfwJogPYvXL0Z7H5Ro
VgT05Iceo890rLjaLJz4db/i+ASfR+5J1nFQz7qam5Mq4rKTXEhN121v02Ua176U
xQS2XUOA60YeTK+nSgCRWrBZFavsfjpjKR+OqsvIRv77+HtmYFhuLpfO3wCHdCE9
LMGkAWY2qNc6/cdoiA/RCeLFphQPMg+Y0d+fBoTqfCtpkmNmNAagm6Zw0KQQ19dC
OoJY1lGq/Q1zIqL5lNJ/mbPGUi6eSBqN9MFKxsIjdBY6oAe5x+PUyBWyAaGwalsb
r+m7Lg6VbhtYBOSZn+nU+fe370f9C+98BQO7LteEW083LIvmbA4p6vxlIHwI+VX9
S6Yk5Q6uUD1PTZq6fvX1Bb6FFf9y9XAyuB39q2nJ71LCF8VlQfVYuNyPFqM5epCE
3rLpmP6CTTPB4ZUU2TNR3q8o4OX8/jv/2cqU0eCPvvIHrarh257PCGsLOzLbxlh/
jmXCrmYubugcPFbEXov7MXMudHpmoswGyaSBscDduqumPgqGLJi4IYw2PmAvGtz9
Ir+18WeLlYxyb2Jx1HjFK1iomR9Uf1yhQe81EW6uqsRZjQvSom4=
=2BxT
-----END PGP SIGNATURE-----

--Apple-Mail=_44D43FA3-A251-461F-A353-2D8D8D096051--
