Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24990EBB98
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2019 02:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKABJs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 21:09:48 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:34569 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKABJs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Oct 2019 21:09:48 -0400
Received: by mail-pl1-f175.google.com with SMTP id k7so3585430pll.1
        for <linux-ext4@vger.kernel.org>; Thu, 31 Oct 2019 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VAilpGKqxZ7wkf95nY+jwjazO7P6wnwTebQPeXipwBM=;
        b=cS2acwPYx/ZbcvcpJOlpxGXMEu27M934jTrxmvW8JYb7sdPMXWKF0zlXh4lm6OFp4l
         bg0gAABiMPa1PA9/Qm04ZdnSEy0w7rWpEdkgp85ey9wT9y+81ddI3Tt5qf4aPkmfrJ6O
         bu8yazIVhSBWV41VCcYU5ZdX8QPIPqIYt646Apyw5dnbQy4DJiKP7fQzjtPJmzYmIqTz
         tDEyI2BWskUDpGuxzpJpIy0FNDXKhsAUOZhhcUY2rKwoLQt87/aJx0KNwe8NmFV8TK4N
         Fo+nyDjUNb4VS34KeeuJG8W+PVw8/aiyE9Fk9PSQOdZalPDWnCnj+KxvbqsmJvyNnXOE
         dcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VAilpGKqxZ7wkf95nY+jwjazO7P6wnwTebQPeXipwBM=;
        b=pBA9eVE8gLwhJnl5ra0XvbRMphCTWMll8Jq5m4sk0qlixaM6BEnRLa5mIp2t413SQr
         oSXfseQFjrsBLP0lXt7AWsCIja+q7X9zAR1Ms5Mg6QbTAD8j8Ywu995ysG4Do66TwzDK
         4y/eqxR5hUcUmg9H6If4LAFfKkIsw3RgWDk1A9rglEyWPD9Se4LLmCFK/I/2KFZaeCC4
         V70UvT2LRzxwrekDABRRR0K+5UCmSEpwUxwoNYoy8VetFXPY/Kij3s6l/tbzLtK/q2HN
         pD+4GXjrl1Nzg9dugqwrs6westDuymZxxnBHwEZDPHKvpjYOkgOwgH91S69LNNRzp+9u
         E5iA==
X-Gm-Message-State: APjAAAW/c1Qgh3L4TxSL2cG0zIbhP6rIHoUckformhsYmgI7xi5ioCGP
        3L3MiRT6bnvGtIGfAjpAsXTYkQ==
X-Google-Smtp-Source: APXvYqxHjNcUTuttQTzXmHPiX+zKSjxkD2Iw32WOkgrGJ0QRKmsmMFm7/vCY7fO2LAEdwe++EBLUKQ==
X-Received: by 2002:a17:902:7d97:: with SMTP id a23mr9447190plm.33.1572570585140;
        Thu, 31 Oct 2019 18:09:45 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a16sm5611835pfa.53.2019.10.31.18.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 18:09:44 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EFC6C1FD-2120-4346-8549-7C0A98505185@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0470A82A-84D2-4B11-9400-BD6F8F2C4941";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: 1024TB Ext4 partition
Date:   Thu, 31 Oct 2019 19:09:41 -0600
In-Reply-To: <8A6F6DF3-F920-4291-91C2-E4AAF1E63ADE@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
References: <8A6F6DF3-F920-4291-91C2-E4AAF1E63ADE@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0470A82A-84D2-4B11-9400-BD6F8F2C4941
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Oct 24, 2019, at 7:23 AM, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=
=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC =
<artem.blagodarenko@gmail.com> wrote:
>=20
> Lustre FS successfully uses LDISKFS(ext4) partitions with size near =
512TB.
> This 512TB is current "verified limit". This means that we do not =
expect
> any troubles in production with such large partitions.
>=20
> Our new challenge now is 1024TB because hardware allows to assemble =
such
> partition.  The question is: do you know any possible issues with EXT4
> (and e2fsprogs) for such large partitions?

Hi Artem, thanks for bringing this up on the list.  We've also seen that
with large declustered parity RAID arrays there is a need to have 40+
disks in the array to get good rebuild performance, and with 12TB disks
this will pushes LUN size to 430TB and next year beyond 512TB for 16TB
disks so this is an upcoming issue.

> I know about this possible problems:
> 1. E2fsck is too slow. But parallel e2fsck project is being developed =
by Li Xi

Right.  This is so far only adding parallelism to the pass1 inode table =
scan.
In our testing that is the majority of the time taken is in pass1 (3879s =
of
3959s for a 25% full 1PB fs, see =
https://jira.whamcloud.com/browse/LU-8465
for more details) so if this phase can most easily be optimized it will =
give
the most overall improvement as well.

> 2. Block groups reading takes a lot of time. We have fixes for special =
cases
> like e2label.  Bigalloc also allows to decrease metadata size, but =
sometimes
> meta_bg is preferable.

For large filesystems (over 256TB) I think meta_bg is always required, =
as the
GDT is larger than a single block group.  However, I guess with bigalloc =
it
is possible to avoid meta_bg since the block group size increases by a =
factor
of the chunk size as well.  That means a 1PiB filesystem could avoid =
meta_bg
if it is using a bigalloc chunk size of 16KB or larger.

> 3. Aged fs and allocator that process all groups to find good group. =
There
> is solution, but with some issues.

It would be nice to see this allocator work included into upstream ext4.

> 4. 32 bit inode counter. Not a problem for Lustre FS users, that =
prefer use
> DNE (distributed namespace) for inode scaling, but probably somebody =
wants
> to store a lot inodes on the same partition. Project was not finished.
>    Looks nobody require it now.
>=20
> Could you please, point me to other possible problems?

While it is not specifically a problem with ext4, as Lustre OSTs get =
larger
they will create a large number of objects in each directory, which will
hurt performance as each htree level is added (about 100k, 1M, and 10M).
To avoid the need for such large directories, it would be useful to =
reduce
the number of objects created per directory by the MDS, which can be =
done
in Lustre (https://jira.whamcloud.com/browse/LU-11912) by creating a =
series
of directories over time.

Splitting up object creation by age also has the benefit of segregating =
the
objects by age and allowing the whole directory to drop out of cache, =
rather
than just distributing all objects over a larger number of directories.  =
Using
a larger number of directories would just increase the cache footprint =
and
result in more random IO (i.e. one create/unlink per directory leaf =
block).


This would also benefit from the directory shrinking code that was =
posted
a couple of times to the list, but has not yet landed.  As old =
directories
have their objects deleted, then eventually shrink down from millions of
objects to a few hundreds, and with this feature the blocks will also =
shrink.

Cheers, Andreas






--Apple-Mail=_0470A82A-84D2-4B11-9400-BD6F8F2C4941
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl27hdUACgkQcqXauRfM
H+Cuag/6Aq+5CNNI/uvCtYI09Owat0WV5lEtWAo7QTAF683J6+CDoSmvvbdHW4eb
h3dt4ki7WWPhWHWBFPZ+Yl8jVseuCO8tupEOfi6IfdBFNaSHMxWJ6qa0QcNIEZPZ
YRi5D20nTo4oO+dJkWHcoKrM0PzUmpR1+t7Vj5KajFlV6g3X2l1kZXcuuPQI7MvI
8Lv4LWNXXZZGe9pBne6f8XQAXTK3xwbj8Vj1hFMD4qSuQHI9CNeTWOrZ4IBgidKm
HCkvhx8iZpcgLl2eQW0ZhSgTuFqhBI95zfbnNWfmlFzvk1g0+xM6uyuhnpRQU9lj
OuXh+z2HmWBq8bNtS9hktL+iOB7vZOaagbkvgynEmTxS92XZnI25ADWUyVTRb7yH
ILEIWhHZNIpP6c1uwj1PKTpEynIrjpcjOO1Z8eSTLPPBWnidt6FeVSTdI1g1m/56
rwfbCFsC2R+xAph6RTChCb4dal04Voc0J58oZ3qGQMaAvcp2LeEiCSCiEQT0+o01
zb1xrlViEkiOWfqD9kgURvTFjg0/Ns4XUcFkiG+dBipN1juMTE7Bx0locCFNSOiw
HYdvD47QimUsrkmk3uuiaSv8TIBRSRXjqKu8FFolXN0axnBuTvNn9tZR/xmGIZlG
KyqcpLJHWy4uiUhIEzZW5g31uL10FVVm/7D8V8ZEjk6xEPGes+4=
=YOrj
-----END PGP SIGNATURE-----

--Apple-Mail=_0470A82A-84D2-4B11-9400-BD6F8F2C4941--
