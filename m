Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6031F89D
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBSLuE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 06:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBSLuC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 06:50:02 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C3C061574
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 03:49:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r23so18717834ljh.1
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QcsAf8sF/An4nFkoeX2qUC5D1sFZHqcyDgBRBYOczl4=;
        b=KTjKyHlfiio5nZ/ydtTlLCcM5EEYdh+D9Ea3XaALNXKVtU/ukZ1H/YdFemzqHQiCDN
         mkMl7IrDNhcAPAifNNyT1uDaTziFK16sqECrCGFbWB9Kaxvxjk9PAYX/Z9NNm2tWH2D2
         XdUxbgoY7aCje8d0emQIG+94KGm59KJEyFX66MnCcFlHRIxRI+nFZlCRV7azHabzZVeN
         We41/SlggqHhYW8eRsHaR8Fk2dgmUWxLwdmwoBGtbZ9EFQ23t4jlmjdHuxLD/J3oKXiV
         o7ZlGftnTk1ynRvSg3C+wJT8cf3eK/83utAs+rhqlO2YY8L8cI3n//C1fYbC5Rvl+Ypb
         xshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QcsAf8sF/An4nFkoeX2qUC5D1sFZHqcyDgBRBYOczl4=;
        b=n+1+OdY57Ecrmk50ppZaXqY2212JbSbEzFmgwJvUuCGLWKjGo3KTYWkyhIJcYMwR+t
         CyT0rafEsmMvpaE2h/ZyM5CYiOm6Wzojpi7a47h5onEhxGAStkkXgNgOL+L1sv0JXB4T
         A6qvDvwsdBbPc6YpWYVCwlGKjx7JWsyArjjd3m6VhAPwwfU2dxWn1ozsBgpD5nSelYro
         b9Oqrs3YpGyMggQa2BshxO96pxFJNLllMXOz6veiB0JoZANl8yIr4Wge9yKTcwKfuWwI
         LYFF3ovk2fTJZ5HM9e/tZtXJpZAZr00v81uOtEHp1rSJxulMNZ/GAi4UIeGJKDm5EFr/
         6Scg==
X-Gm-Message-State: AOAM530YDwXAaQLQVwdLZNQpDA1BxMe1op1JKipxei7kGIHX7sVD2sTl
        gACGltO4iqz9dAeaCJorpjY=
X-Google-Smtp-Source: ABdhPJwXceC5tVAzbzj8vHNe4vcuo3fGVshYthEsq92vB1iJj3RwDy/8zpcr1yjNAWFMuMlIwwongw==
X-Received: by 2002:a05:651c:155:: with SMTP id c21mr5604887ljd.250.1613735358564;
        Fri, 19 Feb 2021 03:49:18 -0800 (PST)
Received: from [192.168.1.5] ([5.8.48.45])
        by smtp.gmail.com with ESMTPSA id z20sm904848lfj.178.2021.02.19.03.49.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 03:49:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20210219105713.uu2mywenytfd2e5j@work>
Date:   Fri, 19 Feb 2021 14:49:16 +0300
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E16FB371-5DFC-4A10-A9E2-36541FCF7D30@gmail.com>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
 <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
 <20210219105713.uu2mywenytfd2e5j@work>
To:     Lukas Czerner <lczerner@redhat.com>
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Lukas,

because e2fsprogs have an bad assumption about IO size for the O_DIRECT =
case.
and because library uses a code like
>>
set_block_size(1k);
seek(fs, 1);
read_block();
>>>
which caused an 1k read inside of 4k disk block size not aligned by =
block size, which is prohibited and caused an error report.

Reference to patch.
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/20201023112659.1559-=
1-artem.blagodarenko@gmail.com/

Alex

> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 13:57, Lukas Czerner =
<lczerner@redhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> On Fri, Feb 19, 2021 at 01:08:17PM +0300, Alexey Lyashkov wrote:
>> Andreas,
>>=20
>> What about to disable a O_DIRECT global on any block devices in the =
e2fsprogs library as this don=E2=80=99t work on 4k disk drives at all ?
>> Instead of fixing an O_DIRECT access with patches sends early.
>=20
> Why would it not work at all ? This is a fix for a specific problem =
and
> I am not currently aware of ony other problems e2fsprogs should have
> with 4k sector size drives. Do you have a specific problem in mind ?
>=20
> Thanks!
> -Lukas
>=20
>>=20
>>=20
>> Alex
>>=20
>>> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 1:20, Andreas =
Dilger <adilger@dilger.ca> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>>>=20
>>> On Feb 18, 2021, at 2:51 AM, Lukas Czerner <lczerner@redhat.com> =
wrote:
>>>>=20
>>>> Currently the mmp block is read using O_DIRECT to avoid any caching =
that
>>>> may be done by the VM. However when working with regular files this
>>>> creates alignment issues when the device of the host file system =
has
>>>> sector size larger than the blocksize of the file system in the =
file
>>>> we're working with.
>>>>=20
>>>> This can be reproduced with t_mmp_fail test when run on the device =
with
>>>> 4k sector size because the mke2fs fails when trying to read the mmp
>>>> block.
>>>>=20
>>>> Fix it by disabling O_DIRECT when working with regular files. I =
don't
>>>> think there is any risk of doing so since the file system layer, =
unlike
>>>> shared block device, should guarantee cache consistency.
>>>>=20
>>>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>>>> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
>>>=20
>>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>>>=20
>>>> ---
>>>> v2: Fix comment - it avoids problems when the sector size is larger =
not
>>>>  smaller than blocksize
>>>>=20
>>>> lib/ext2fs/mmp.c | 22 +++++++++++-----------
>>>> 1 file changed, 11 insertions(+), 11 deletions(-)
>>>>=20
>>>> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
>>>> index c21ae272..cca2873b 100644
>>>> --- a/lib/ext2fs/mmp.c
>>>> +++ b/lib/ext2fs/mmp.c
>>>> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, =
blk64_t mmp_blk, void *buf)
>>>> 	 * regardless of how the io_manager is doing reads, to avoid =
caching of
>>>> 	 * the MMP block by the io_manager or the VM.  It needs to be =
fresh. */
>>>> 	if (fs->mmp_fd <=3D 0) {
>>>> +		struct stat st;
>>>> 		int flags =3D O_RDWR | O_DIRECT;
>>>>=20
>>>> -retry:
>>>> +		/*
>>>> +		 * There is no reason for using O_DIRECT if we're =
working with
>>>> +		 * regular file. Disabling it also avoids problems with
>>>> +		 * alignment when the device of the host file system has =
sector
>>>> +		 * size larger than blocksize of the fs we're working =
with.
>>>> +		 */
>>>> +		if (stat(fs->device_name, &st) =3D=3D 0 &&
>>>> +		    S_ISREG(st.st_mode))
>>>> +			flags &=3D ~O_DIRECT;
>>>> +
>>>> 		fs->mmp_fd =3D open(fs->device_name, flags);
>>>> 		if (fs->mmp_fd < 0) {
>>>> -			struct stat st;
>>>> -
>>>> -			/* Avoid O_DIRECT for filesystem image files if =
open
>>>> -			 * fails, since it breaks when running on tmpfs. =
*/
>>>> -			if (errno =3D=3D EINVAL && (flags & O_DIRECT) &&
>>>> -			    stat(fs->device_name, &st) =3D=3D 0 &&
>>>> -			    S_ISREG(st.st_mode)) {
>>>> -				flags &=3D ~O_DIRECT;
>>>> -				goto retry;
>>>> -			}
>>>> 			retval =3D EXT2_ET_MMP_OPEN_DIRECT;
>>>> 			goto out;
>>>> 		}
>>>> --
>>>> 2.26.2
>>>>=20
>>>=20
>>>=20
>>> Cheers, Andreas
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>=20

