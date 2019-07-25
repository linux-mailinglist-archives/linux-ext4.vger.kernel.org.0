Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3B7596E
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2019 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfGYVVF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Jul 2019 17:21:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfGYVVF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Jul 2019 17:21:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so23644435pgm.3
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jul 2019 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VLVGKiBftQ0aCi+NnOalXVzdMwfhS7tT34KvAwh67ok=;
        b=bJ8ydJNYerrVv0DsbAL0yfjGxcw4EiTllpPxQpCw1c0LC+FjQP18V3nBAY4h8iOQG1
         Pj+Jha5GyiqChx+cCv9ZGOtuncZG5IfW1HqH9ghUWCZm7YU9PAd4AHo5CBr6NrYVkmnh
         cKGfuLgAY6DzWFIpF2iHGMcWdIJmAIm1w1LyxAjjVA7OGtrrW3p04a5fQPnf2qIbd4J9
         ByucR9+jBubNvHgsXKfK0tRE+g/cwhhsovYJ9FpqftA8vMo5tt64M8+J9fEUJm5GbA4h
         i+PdhwPack5OzuhzVvmCw7/xjAcdpZwAXd2lDY6GMQ/R75jQQaO9f/Y2C8evYkaH8Jqx
         R2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VLVGKiBftQ0aCi+NnOalXVzdMwfhS7tT34KvAwh67ok=;
        b=X5t9i4JmfByFMLO1AnIXT8ixrvNNpe11UxO0nlx6har1RzfCfvbDPtwCatsxWdzIqw
         Jxvet0wA2+jGXtf6O3TFAVME/L/tkGuNvgkwjINYXJHwWZNsd5Mcu/iztaCBci8ncGeI
         dNQ6R11k24P4Gm6gDz6gdOfIrSMEArfcOKAYmMrWWAARRq1KSB0kjpwM7KcSgZmhN89v
         FKqcUGLirujqQxJyNw1GGZveZI3Ok0Z7ZBvM1WyPV8ai8w2Vu1jew4duAu4ETLqMpRMm
         MbglZhun1zFTT256oLNs2KffrPGbXMJL+uoDYLMeNugUzYjZdgDCmPcw8c20IGWe8/PY
         GrMw==
X-Gm-Message-State: APjAAAVFnspB+B5tLMnSL7VUFAPvlRGd9MZc/nMacCSBp7YVLCWPuZt5
        94Po1eWxmum+7LLAnC+Vhy9ivPJ+geg=
X-Google-Smtp-Source: APXvYqwV2U3s6BPCtul6W4rdC1j+1QFFWGaegufggbmMlHa7pUJjfJSur3/ta0+4VJY4PEqgvNh6hw==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr90102461pgt.365.1564089664031;
        Thu, 25 Jul 2019 14:21:04 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id l26sm47697466pgb.90.2019.07.25.14.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 14:21:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EA630A7D-A4D2-4B6C-ACEC-A0C9AE4106FD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Date:   Thu, 25 Jul 2019 15:20:57 -0600
In-Reply-To: <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
To:     Joseph Qi <jiangqi903@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
 <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_EA630A7D-A4D2-4B6C-ACEC-A0C9AE4106FD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
>=20
> Hi Ted & Jan,
> Could you please give your valuable comments?

It seems like the original patches should be reverted?  There is no data
in the original commit message that indicates there is an actual =
performance
improvement from that patch, but there is data here showing it hurts =
both
read and write performance quite significantly.

Cheers, Andreas

> On 19/7/19 17:22, Joseph Qi wrote:
>> Hi Ted & Jan,
>> I've observed an significant performance regression with the =
following
>> commit in my Intel P3600 NVMe SSD.
>> 16c54688592c ext4: Allow parallel DIO reads
>>=20
>> =46rom my initial investigation, it may be because of the
>> inode_lock_shared (down_read) consumes more than inode_lock =
(down_write)
>> in mixed random read write workload.
>>=20
>> Here is my test result.
>>=20
>> ioengine=3Dpsync
>> direct=3D1
>> rw=3Drandrw
>> iodepth=3D1
>> numjobs=3D8
>> size=3D20G
>> runtime=3D600
>>=20
>> w/ parallel dio reads : kernel 5.2.0
>> w/o parallel dio reads: kernel 5.2.0, then revert the following =
commits:
>>  1d39834fba99 ext4: remove EXT4_STATE_DIOREAD_LOCK flag (related)
>>  e5465795cac4 ext4: fix off-by-one error when writing back pages =
before dio read (related)
>>  16c54688592c ext4: Allow parallel DIO reads
>>=20
>> bs=3D4k:
>> =
--------------------------------------------------------------------------=
-----------------
>> w/ parallel dio reads | READ 30898KB/s, 7724, 555.00us   | WRITE =
30875KB/s, 7718, 479.70us
>> =
--------------------------------------------------------------------------=
-----------------
>> w/o parallel dio reads| READ 117915KB/s, 29478, 248.18us | WRITE =
117854KB/s=EF=BC=8C29463, 21.91us
>> =
--------------------------------------------------------------------------=
-----------------
>>=20
>> bs=3D16k:
>> =
--------------------------------------------------------------------------=
-----------------
>> w/ parallel dio reads | READ 58961KB/s, 3685, 835.28us   | WRITE =
58877KB/s, 3679, 1335.98us
>> =
--------------------------------------------------------------------------=
-----------------
>> w/o parallel dio reads| READ 218409KB/s, 13650, 554.46us | WRITE =
218257KB/s=EF=BC=8C13641, 29.22us
>> =
--------------------------------------------------------------------------=
-----------------
>>=20
>> bs=3D64k:
>> =
--------------------------------------------------------------------------=
-----------------
>> w/ parallel dio reads | READ 119396KB/s, 1865, 1759.38us | WRITE =
119159KB/s, 1861, 2532.26us
>> =
--------------------------------------------------------------------------=
-----------------
>> w/o parallel dio reads| READ 422815KB/s, 6606, 1146.05us | WRITE =
421619KB/s, 6587, 60.72us
>> =
--------------------------------------------------------------------------=
-----------------
>>=20
>> bs=3D512k:
>> =
--------------------------------------------------------------------------=
-----------------
>> w/ parallel dio reads | READ 392973KB/s, 767, 5046.35us  | WRITE =
393165KB/s, 767, 5359.86us
>> =
--------------------------------------------------------------------------=
-----------------
>> w/o parallel dio reads| READ 590266KB/s, 1152, 4312.01us | WRITE =
590554KB/s, 1153, 2606.82us
>> =
--------------------------------------------------------------------------=
-----------------
>>=20
>> bs=3D1M:
>> =
--------------------------------------------------------------------------=
-----------------
>> w/ parallel dio reads | READ 487779KB/s, 476, 8058.55us  | WRITE =
485592KB/s, 474, 8630.51us
>> =
--------------------------------------------------------------------------=
-----------------
>> w/o parallel dio reads| READ 593927KB/s, 580, 7623.63us  | WRITE =
591265KB/s, 577, 6163.42us
>> =
--------------------------------------------------------------------------=
-----------------
>>=20
>> Thanks,
>> Joseph
>>=20


Cheers, Andreas






--Apple-Mail=_EA630A7D-A4D2-4B6C-ACEC-A0C9AE4106FD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl06HToACgkQcqXauRfM
H+DOZxAAu47L3en/D7+MJjDiaVdhJtohMd4BQF2hC3FApOq3LIdl21DdVy+LoJPe
ehwuau+Ny2F+zVDGqYE2ZZZiUHBTNCLj74vvXq0IAtxqWA2iPFBKXZYXZnTEJ2+5
O20leaJncL4yu8AIRN+HiBBYESYKkDsCC23Vpyd0Afwaa2f7ZcpMYOa4+GFJuzcT
demcfRBe16EGbCzyqgh/cm+3rxboGlTclHYNhGSU0ITVvk/v1zQ7Py5yay7Igc6/
gTsTc/8eUPZ726PAHanQA+UzfMk8KL3W5+GRC0O+wBNDuQ9UaAVlOeGCxrS/0vtk
O3FfZiec8Bl7xvagtOHRPtEoKqAQHp4M2t29hdnP1yRvOzZ0YTDPn23DYlcbXSkW
ZFrTdZq8Gxw7+Y3XvExyJzTZdjJcN7Ntz3GbHZ9laYY2RAc834DELIv1WMz6dhZE
J3uSFHvn87LDKJwgJ4rg0Z7/qta5Id8Yu0Q4n/MFASt8Olj2WEswfbpAogNBpudr
v2rx4jNQ7HEd3YAmo4s62QmjCNO9WgxYJs/dQ/O1qbHxJesfoA9KKFPSb+klxPWx
AgKrqvqmozzu0awqkmbiU+SpefrpqLZneHZock/AqM2Dhc0M+TDmfhzLepy0M4Cg
hTFrvD3rdi+ttvhe3fY/heZzjbe005jHJR6qsbd84kUMKT/+lNg=
=XgX6
-----END PGP SIGNATURE-----

--Apple-Mail=_EA630A7D-A4D2-4B6C-ACEC-A0C9AE4106FD--
