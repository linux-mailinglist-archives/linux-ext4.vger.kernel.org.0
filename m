Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E11E4DEB
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 21:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgE0TMH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE0TME (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 15:12:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E0C08C5C1
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 12:12:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cx22so2043556pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=tbDR4Y1DFWahxOCDCekgP3BNBaPhddvRYiCol3purKY=;
        b=fU0ULxnHQCFWr/G6SvdRct8khiqyShnSJLqHnL06z9E+/II0eZ6rseZ/mO8Agwh+3Z
         NwMEnVct9A2SzJvJKRcHt8yhxZgVMd1yMKCK+A/40ZsTvwFPuV3zsye2Wfxji91T6PON
         86cDwBU+Abv0k5wGwlZtdw1TJdH9Jp6hFspAMzhuapXJW7ELkE2FwPJcKh6kuIQ67/md
         cxadpAnTq628isRDT8y7lExE6NrppLzPZEXhVBg+tvpPFEYDPmKQtYc3i6caMlCUrxXP
         AmuOOWMovhCsse2tmI/XtpGvNcJkqPI38TtmlZiqMkHmNPEZpiaHXdLzCeVesURs2OhZ
         p7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=tbDR4Y1DFWahxOCDCekgP3BNBaPhddvRYiCol3purKY=;
        b=TtqKi07J2W7h8zwP3heYXj+D4o5O1fZ/6sfMIr91eevfMkTN1z8VCZwgSnxCEkbve3
         6F3Jjc8XxJDszHGLukTEkA/tnZDzZxPftLqFHSWzVTn3Ajb8D8mY6TJbaF+0RYxsNqIz
         /gzdgHdQzyM6OW66V5sUxYcbquFQRG+DwwqOllfJkXHfBLPe4mlynl9yrNhdRMSXAYH5
         KxTvcKYQkEJa3eWcnwnhe4Nwp5Xm0xQ3yrFAbB3FpT7Wl/G2gl2PH+5hTRWUFFzJLL9O
         fkFGu2NsjXvwO93bPNYAD/QRXNeK57VKweiCBKS1INsDczgXUdl7bkMZAnw6T3JG0SIY
         H+ig==
X-Gm-Message-State: AOAM5330Y775v5mIaUgN0SPh/MdJHWhMoPt1SCEyFvn31cRQReGYJk0+
        RBEiWQ4HBrhe6Uozmt8b8/WGxg==
X-Google-Smtp-Source: ABdhPJwItto45UcbY2GKPfAD4L/YUZQCyUHypCYWib9te2pEu54gCTPbTxPy7MyOGN65I6P8L2ef7Q==
X-Received: by 2002:a17:902:b98c:: with SMTP id i12mr7467241pls.41.1590606722110;
        Wed, 27 May 2020 12:12:02 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 124sm2695064pfb.15.2020.05.27.12.11.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 12:12:00 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7ED9AC71-D768-44BE-A227-95F876A4C1DF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F72D2A94-AF2C-439C-8963-A9512254D2B7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
Date:   Wed, 27 May 2020 13:11:55 -0600
In-Reply-To: <ece9cd79-6d97-db36-66bb-f02bd6bf6573@thelounge.net>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>
To:     Reindl Harald <h.reindl@thelounge.net>
References: <1590565130-23773-1-git-send-email-wangshilong1991@gmail.com>
 <20200527091938.647363ekmnz7av7y@work>
 <520b260b-13e9-4c62-eaeb-c44215b14089@thelounge.net>
 <20200527095751.7vt74n7grfre6wit@work>
 <59df4f2f-f168-99a1-e929-82742693f8ee@thelounge.net>
 <20200527103214.knm2vmnwjt64j55l@work>
 <ece9cd79-6d97-db36-66bb-f02bd6bf6573@thelounge.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F72D2A94-AF2C-439C-8963-A9512254D2B7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On May 27, 2020, at 4:56 AM, Reindl Harald <h.reindl@thelounge.net> =
wrote:
> Am 27.05.20 um 12:32 schrieb Lukas Czerner:
>> On Wed, May 27, 2020 at 12:11:52PM +0200, Reindl Harald wrote:
>>>=20
>>> Am 27.05.20 um 11:57 schrieb Lukas Czerner:
>>>> On Wed, May 27, 2020 at 11:32:02AM +0200, Reindl Harald wrote:
>>>>> would that also fix the issue that *way too much* is trimmed all =
the
>>>>> time, no matter if it's a thin provisioned vmware disk or a =
phyiscal
>>>>> RAID10 with SSD
>>>>=20
>>>> no, the mechanism remains the same, but the proposal is to make it
>>>> pesisten across re-mounts.
>>>>=20
>>>>>=20
>>>>> no way of 315 MB deletes within 2 hours or so on a system with =
just 485M
>>>>> used
>>>>=20
>>>> The reason is that we're working on block group granularity. So if =
you
>>>> have almost free block group, and you free some blocks from it, the =
flag
>>>> gets freed and next time you run fstrim it'll trim all the free =
space in
>>>> the group. Then again if you free some blocks from the group, the =
flags
>>>> gets cleared again ...
>>>>=20
>>>> But I don't think this is a problem at all. Certainly not worth =
tracking
>>>> free/trimmed extents to solve it.
>>>=20
>>> it is a problem
>>>=20
>>> on a daily "fstrim -av" you trim gigabytes of alredy trimmed blocks
>>> which for example on a vmware thin provisioned vdisk makes it down =
to
>>> CBT (changed-block-tracking)
>>>=20
>>> so instead completly ignore that untouched space thanks to CBT it's
>>> considered as changed and verified in the follow up backup run which
>>> takes magnitutdes longer than needed
>>=20
>> Looks like you identified the problem then ;)
>=20
> well, in a perfect world.....
>=20
>> But seriously, trim/discard was always considered advisory and the
>> storage is completely free to do whatever it wants to do with the
>> information. I might even be the case that the discard requests are
>> ignored and we might not even need optimization like this. But
>> regardless it does take time to go through the block gropus and as a
>> result this optimization is useful in the fs itself.
>=20
> luckily at least fstrim is non-blocking in a vmware environment, on my
> physical box it takes ages
>=20
> this machine *does nothing* than wait to be cloned, 235 MB pretended
> deleted data within 50 minutes is absurd on a completly idle guest
>=20
> so even when i am all in for optimizations that=C3=84s way over top
>=20
> [root@master:~]$ fstrim -av
> /boot: 0 B (0 bytes) trimmed on /dev/sda1
> /: 235.8 MiB (247201792 bytes) trimmed on /dev/sdb1
>=20
> [root@master:~]$ df
> Filesystem     Type  Size  Used Avail Use% Mounted on
> /dev/sdb1      ext4  5.8G  502M  5.3G   9% /
> /dev/sda1      ext4  485M   39M  443M   9% /boot


I don't think that this patch will necessarily fix the problem you
are seeing, in the sense that WAS_TRIMMED was previously stored in
the group descriptor in memory, so repeated fstrim runs _shouldn't_
result in the group being trimmed unless it had some blocks freed.
If your image has even one block freed in any group, then fstrim will
result in all of the free blocks in that group being trimmed again.

That said, I think a follow-on optimization would be to limit *clearing*
the WAS_TRIMMED flag until at least some minimum number of blocks have
been freed (e.g. at least 1024 blocks freed, or the group is "empty", or
similar).  That would avoid excess TRIM calls down to the storage when
only a few blocks were freed that would be unlikely to actually result
in an erase blocks being freed.  This size could be dynamic based on
the minimum trim size passed by fstrim (e.g. min(1024 * minblocks, =
16MB)).

That would also fit in nicely with changing "-o discard" over to using
per-block group tracking of the trim state, and use the same mechanism
as fstrim, rather than using the per-extent tracking that is used today
and causes (IMHO) too many small trims to the storage to be useful.
Not only do many small trim requests cause overhead during IO, but they
can also miss actual trims because the individual extent are smaller
than the discard size of the storage, and it doesn't combine the trim
range with adjacent free blocks.

Doing the block-group-based trim in the background, when a group has had
a bunch of blocks freed, and when the filesystem is idle (maybe a percpu
counter that is incremented whenever user read/write requests are done,
that can be checked for idleness when there are groups to be trimmed)
doesn't have to be perfect or totally crash proof, since it will always
have another chance to trim the group the next time some blocks are =
freed,
or if manual "fstrim" is called on the group with a smaller minlen.

Cheers, Andreas






--Apple-Mail=_F72D2A94-AF2C-439C-8963-A9512254D2B7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7Ou3sACgkQcqXauRfM
H+CCcQ//bYKUH+AVVY/no0yyRqZuj3nDbqgCj8XBdldqYUJiw5af1c+YzIUNiZqa
IrwN+4Tp/1yjXsP7gQwu+Jg6G1KPnrDFndg/CR77Q2Ty6BOjprTl+lmO85yo1ThZ
pMYHmzrmHbP+uh9+LcF//smjTg+JBnXYk+DS2QhrZNv2sM/qYQgHdzrYM4i977sq
5p6B5dB5RjyVjEPzUqw+oOZwYxrRcTU6P+hEaAoaeO/EG2qB8jhY1TwEvc9w+qTw
EhvY6aPK1DgeMUpPkEbqcWEik97mnId7HNVlxJz4oXxVCjMTkwh7flrEcUbp5W/2
lvjjUh2v2vng50wl7STy3eNGsDPKDAgXu4kpwh5Z7mz/9v6fDGS5fkoiniY6UHHC
Wz1Ip2DlOEAP7wuNQEDYQtrF7jYnskDZ8U1ssG5SvpaMiHFjWU1UtJVp5HfK1xPw
DE8FraC0bRqM8tvp/+P6cmhpJ3nhWBPJ4GnKnETnbF7LwpF6qllC/Xrfb2FqLbCA
0gX+y41NIllt83t3AUcA1sPozVXuScnzBHeSPttJ9fd7DzYMY+pBo6aiMZhniSjK
NWzp3YCYCzePIJRkNfF/fd8+mrtJ3ZUmjZ1Y3hCpUpr74GqjojFVg5fD4Yd8NL9g
bcZMTYiJQ+aJbaPTSUjJknreFx0v3KeCFFUQYWfi4glrzSSCGqc=
=zIh5
-----END PGP SIGNATURE-----

--Apple-Mail=_F72D2A94-AF2C-439C-8963-A9512254D2B7--
