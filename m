Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63179A26F8
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2019 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfH2TG1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Aug 2019 15:06:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfH2TG0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Aug 2019 15:06:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so2067859pgl.11
        for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2019 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=F2fZIv3BhZaFez+M9rVUEgAC9+iErdFX2lJCkO7e4+A=;
        b=J+1PMVyow3lFikmxRmNCll5uWGzB5OIgy98JZm5x3LWcmG11x/Bdupo6/P4nr7QQnf
         jqkDpR2rm+3VZMXp3kqzY/1DGNsOTyfY+3kTJfEhM5Jb7f4rqlQJm1qLQIcxjwae8MOx
         P1tqOA44frz+9kRjGd7e51jKHY57VTixdVCM5rh44UsKG5HhA0qx2sxMuOiXxDCt4xhn
         7pMeUTV90X4PmS+RHNd2xUiAw4XfhWTfW/Kes6qFzG/GOYt6V3azxwyrnlEGEY8mGl4k
         zfYv8ofdRlPlMKsY97q7Kgmwdbohz4yQzee/HVgwqRg7NRvtuZHcbj2aR6gjbkIbApL7
         ehnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=F2fZIv3BhZaFez+M9rVUEgAC9+iErdFX2lJCkO7e4+A=;
        b=jWu9oLasXxq8yiCuZlCM6I2GRUgAbhfPrd767xgwjQTgMUG+w48/PWfO2E/2c/bY7/
         Ck7GkLqKwnojdNXOsDDrYITf/gtppbdEPpNYzEGBRLM29mdV8HDkaVDEj6MI/51bE8eH
         aAqCjB3rlUBZ1YLaMdYglo2OvYNmnRKf/JI7t99okVGmAg+yPlkAag3vAysTahFW83bu
         4waecgqIuNxJ9TdcJCtiHApsOVRyxcmU/wvMwewhXBE81sNbyleOeci9wuTJ7B88qgct
         wOhCkzzqJW65pgrCgxKB1WsQgB+scSshT0lBreAGU8YnOjR7cuzXHV2puNV8Y8kF594h
         tdRQ==
X-Gm-Message-State: APjAAAUSIcBOYcG42ZJ2KDFpioQoNkOatxMMKmMbcbz3Ma9uAU9vRNzV
        m6Q4MBTyFCbfnOs1R4h+UDUbbw==
X-Google-Smtp-Source: APXvYqxrz7Q8bQCXSJFIEyR1MFwUkVStoEinG/0Ui7z92G79zJSQi83MYthyQ9Kk8wVG2W9nWc0T8g==
X-Received: by 2002:aa7:9609:: with SMTP id q9mr12968920pfg.232.1567105586079;
        Thu, 29 Aug 2019 12:06:26 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a13sm3652812pfn.104.2019.08.29.12.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 12:06:24 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8C1DC2C7-4389-446D-8233-EEDAAD38C398@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_592A6161-C825-4B2C-9BAF-636BE3FA930F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/3] Revert parallel dio reads
Date:   Thu, 29 Aug 2019 13:06:22 -0600
In-Reply-To: <20190829105858.GA22939@quack2.suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20190827115118.GY7777@dread.disaster.area>
 <20190829105858.GA22939@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_592A6161-C825-4B2C-9BAF-636BE3FA930F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 29, 2019, at 4:58 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Tue 27-08-19 21:51:18, Dave Chinner wrote:
>> On Tue, Aug 27, 2019 at 10:05:49AM +0800, Joseph Qi wrote:
>>> This patch set is trying to revert parallel dio reads feature at =
present
>>> since it causes significant performance regression in mixed random
>>> read/write scenario.
>>>=20
>>> Joseph Qi (3):
>>>  Revert "ext4: remove EXT4_STATE_DIOREAD_LOCK flag"
>>>  Revert "ext4: fix off-by-one error when writing back pages before =
dio
>>>    read"
>>>  Revert "ext4: Allow parallel DIO reads"
>>>=20
>>> fs/ext4/ext4.h        | 17 +++++++++++++++++
>>> fs/ext4/extents.c     | 19 ++++++++++++++-----
>>> fs/ext4/inode.c       | 47 =
+++++++++++++++++++++++++++++++----------------
>>> fs/ext4/ioctl.c       |  4 ++++
>>> fs/ext4/move_extent.c |  4 ++++
>>> fs/ext4/super.c       | 12 +++++++-----
>>> 6 files changed, 77 insertions(+), 26 deletions(-)
>>=20
>> Before doing this, you might want to have a chat and co-ordinate
>> with the folks that are currently trying to port the ext4 direct IO
>> code to use the iomap infrastructure:
>>=20
>> =
https://lore.kernel.org/linux-ext4/20190827095221.GA1568@poseidon.bobrowsk=
i.net/T/#t
>>=20
>> That is going to need the shared locking on read and will work just
>> fine with shared locking on write, too (it's the code that XFS uses
>> for direct IO). So it might be best here if you work towards shared
>> locking on the write side rather than just revert the shared locking
>> on the read side....
>=20
> Yeah, after converting ext4 DIO path to iomap infrastructure, using =
shared
> inode lock for all aligned non-extending DIO writes will be easy so =
I'd
> prefer if we didn't have to redo the iomap conversion patches due to =
these
> reverts.

But if the next kernel is LTS and the iomap implementation isn't in the
current merge window (very unlikely) then we're stuck with this =
performance
hit for LTS.  It is also unlikely that LTS will take the revert patches =
if
they have not been landed to master.

Cheers, Andreas






--Apple-Mail=_592A6161-C825-4B2C-9BAF-636BE3FA930F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1oIi4ACgkQcqXauRfM
H+AKuRAAkEpkGPQX4FiwgsuMAYtQQuyLKj3fIRw1ziq+G5Q4Y98g9Lv8u4dPTpao
PfOu14uAxekYtSx9avzsnhegGAMwCbYH7MT35VZ2yj4Zs59S1vWS67S2FWSRDnIk
UThMXGR2BVjADjDuHN6DOyWnZTfr+a7icrFOhYvIjDyDImqmSJp2akdNhwq4MGu2
yniILeZo4GrUnMUpyAh8iqWi9tP1f5/Ix8icr+95WhmcfX4qyqJCgTUBx2DssClz
G+AkgAe3rc8e9qRjehVR7vo4gGg9o6tW8IOR9dP0C1OTa9mi0qatSis+4+m+VAIU
1r8CNrXdhFSq4nza4+eahSZnZqE6BAi6yGpPdyvdYt+MzvOId0qoZaBDBCV1g0sW
vvajmTqnyKoG/AM2pmMEjOsygWvewwXhQVMUDPDVQ+GTH6T67TB9xTP+wJFqCIUI
3JWKkygEiT927BPf3LZ7aAp8hbFQDinnx26Ki8E+K9Cith/EJUmLhbTUA/w3sbJP
qknT2IHxJw/icTgXK7kU1N9pxKNg9xgXU9XeO63ED8PzJmdB50EjTuvfI68r+YVs
EJ3fLcylZnkL8JfUB7unTMRoccg8Bhq/L19c0o0kvMk6mHfITbIJlugaVSa0CBms
6KZVUx/n5bcgQLjIRmoq5DmleNCVjUuv8EGoZP/bEag7jDOZdgA=
=wBmG
-----END PGP SIGNATURE-----

--Apple-Mail=_592A6161-C825-4B2C-9BAF-636BE3FA930F--
