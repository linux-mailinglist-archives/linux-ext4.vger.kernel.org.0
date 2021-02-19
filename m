Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BCC31F715
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBSKJI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 05:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhBSKJE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 05:09:04 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC9C061756
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 02:08:22 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a22so17167669ljp.10
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gDMqIvxMkTAzaquBSdBIxPhNsL/Xhe78V+a35fM1QBM=;
        b=gfrr7LErjoquFdnWhifM9aCnOsqiKEb/wgZL0i/+t1qjNf+NXMbyE/HjuNxq8fO9q7
         wbAXWNjjkNOxNr+dZW7j0nGw2NRqcLs9oera8bCFyCMGTbb32QRf8Jc7yqMdKz6WH8cE
         niJPaA3bcoqTLkrwnIuhvpJ4yfZ5CVG9lDoU9PjTRYjXhn6cjWSz4pa2E7C6LyNfcZVb
         EcfF9fJu7pn3lFJ5ShU8d9mXyndYTl8oFz20k+IvHGHYkVEzt6Z1drg/aDadfDzRpjd3
         2bX4bZ9OQ3zARAQ8KDsS6r/SUoYABcZ86JtbKre1/B5yh89JmcDbd56oguEONR7es6y5
         UqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gDMqIvxMkTAzaquBSdBIxPhNsL/Xhe78V+a35fM1QBM=;
        b=fa0OjiowRXmwjUyWj0jpUYwMrhnUAqWTIFh30KsIR2BNJ1iVObhltZ2fvqHTiDYU+h
         pCOXx9f2gzEgWfFH0BIg76L/aGZyboD/CjAayayJHyXU5C/Nr/tx2OBmBbD0ki73v2yH
         sCcPuHXWITVlIKMi0PeFyZdiRzntfHCtRUTTc//ndeBhlB3pYHie4wTS40JI8Gx4OVuB
         J0kkrYB5smNAR12efJJ+rnOCt8cW1GkfZAn+beWTPXsG3hqj+DbOqx58kIO9vgViBXlV
         jzlQvbHbJ091ZdMCAqrK0VXYW8eiSbtTWcJq4yzifPKnXald1bs+ABershCxnDyhOfYF
         WkeA==
X-Gm-Message-State: AOAM531LqQ/c3cp+to2YssRFeoCGSjuuyklhYjGylGMnNYeVIwwPE14y
        /vMleTfb8PeUA9MuW58g1OM=
X-Google-Smtp-Source: ABdhPJx3rK7JXeffNIz8lk3cU/6mcJZOkL/svAJ4xAIjdTp63KbCPrYBwmOCq1SvUhYVaj/ARLpHvg==
X-Received: by 2002:a05:6512:11d1:: with SMTP id h17mr5049187lfr.116.1613729301425;
        Fri, 19 Feb 2021 02:08:21 -0800 (PST)
Received: from [192.168.1.5] ([5.8.48.45])
        by smtp.gmail.com with ESMTPSA id i21sm876460lfe.102.2021.02.19.02.08.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:08:20 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
Date:   Fri, 19 Feb 2021 13:08:17 +0300
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas,

What about to disable a O_DIRECT global on any block devices in the =
e2fsprogs library as this don=E2=80=99t work on 4k disk drives at all ?
Instead of fixing an O_DIRECT access with patches sends early.


Alex

> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 1:20, Andreas Dilger =
<adilger@dilger.ca> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> On Feb 18, 2021, at 2:51 AM, Lukas Czerner <lczerner@redhat.com> =
wrote:
>>=20
>> Currently the mmp block is read using O_DIRECT to avoid any caching =
that
>> may be done by the VM. However when working with regular files this
>> creates alignment issues when the device of the host file system has
>> sector size larger than the blocksize of the file system in the file
>> we're working with.
>>=20
>> This can be reproduced with t_mmp_fail test when run on the device =
with
>> 4k sector size because the mke2fs fails when trying to read the mmp
>> block.
>>=20
>> Fix it by disabling O_DIRECT when working with regular files. I don't
>> think there is any risk of doing so since the file system layer, =
unlike
>> shared block device, should guarantee cache consistency.
>>=20
>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
>=20
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>=20
>> ---
>> v2: Fix comment - it avoids problems when the sector size is larger =
not
>>   smaller than blocksize
>>=20
>> lib/ext2fs/mmp.c | 22 +++++++++++-----------
>> 1 file changed, 11 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
>> index c21ae272..cca2873b 100644
>> --- a/lib/ext2fs/mmp.c
>> +++ b/lib/ext2fs/mmp.c
>> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t =
mmp_blk, void *buf)
>> 	 * regardless of how the io_manager is doing reads, to avoid =
caching of
>> 	 * the MMP block by the io_manager or the VM.  It needs to be =
fresh. */
>> 	if (fs->mmp_fd <=3D 0) {
>> +		struct stat st;
>> 		int flags =3D O_RDWR | O_DIRECT;
>>=20
>> -retry:
>> +		/*
>> +		 * There is no reason for using O_DIRECT if we're =
working with
>> +		 * regular file. Disabling it also avoids problems with
>> +		 * alignment when the device of the host file system has =
sector
>> +		 * size larger than blocksize of the fs we're working =
with.
>> +		 */
>> +		if (stat(fs->device_name, &st) =3D=3D 0 &&
>> +		    S_ISREG(st.st_mode))
>> +			flags &=3D ~O_DIRECT;
>> +
>> 		fs->mmp_fd =3D open(fs->device_name, flags);
>> 		if (fs->mmp_fd < 0) {
>> -			struct stat st;
>> -
>> -			/* Avoid O_DIRECT for filesystem image files if =
open
>> -			 * fails, since it breaks when running on tmpfs. =
*/
>> -			if (errno =3D=3D EINVAL && (flags & O_DIRECT) &&
>> -			    stat(fs->device_name, &st) =3D=3D 0 &&
>> -			    S_ISREG(st.st_mode)) {
>> -				flags &=3D ~O_DIRECT;
>> -				goto retry;
>> -			}
>> 			retval =3D EXT2_ET_MMP_OPEN_DIRECT;
>> 			goto out;
>> 		}
>> --
>> 2.26.2
>>=20
>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20

