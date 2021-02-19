Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70131FA1F
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBSNxu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 08:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBSNxt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 08:53:49 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D018C061574
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 05:53:09 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r23so20875905ljh.1
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CFhaWIUg+BBvXTgAVYiksHFQ8agoyhaI8+GJ+P/7FFY=;
        b=ZIILyrcFArCB1vQ5YFctolwmG33VpFu/NqL468PffU1o9UG7f0u+7InNvwFyNmbccL
         xZBrk4mN3TTMGNaMYmiNqVPfYCrSVFYAwU2/ZbCNjekjfmIyK+irPV6d+v3mEdehH2nJ
         0LTY/th6AnBsneriOO/psbzKCnjWLONokfSKhHDEEm3cudsdRthOzByK4j0LCfV+PAMV
         zlvIgKcJnv5XTRqTjpUz64DvI7o3bb/Yj5F1J9nA4eazRJdDvedq+ThrCiMFcfugIkYI
         E9XB6icDPRKdtbeOhCMpOk7matAjoTVr/htS3rXl3hjwkY6iEQKIC62ggeMa5+dcygbn
         WdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CFhaWIUg+BBvXTgAVYiksHFQ8agoyhaI8+GJ+P/7FFY=;
        b=emxMKlEx/yJmKj5JQWBUf9b1sbTGIZV5dagVkeMuEPt5l/irSZaJL2MKJ3iklBIOTq
         yaPvLLokSWUBczbLnQysjndDNVCHBJKrsKWs41ypEDn4BOa691tHZWM1Kd73PvQkYJpW
         0hshMEpdIBe9sA5ubny7X8huzP2RDNWYqXF4u+ODKHrqLPZ/vjG8oO1FQaAa5p/ppYz5
         y9OVf24IwcUYsoAhKnJPj0WRTSMDKJKcBAWz8ufP+dTwBW3hBiIEsZDCDwxEcwu9MP70
         EZgzHfK1iu+kIJYcXqLYDcEimvuI0vNyZ9rV9u7hvzOXF3NHum0TzGSIgnyY8eAqVeyy
         Rv5A==
X-Gm-Message-State: AOAM530YrjXttjZJCwItmJCk/xfSiuyZnkDlqn5van8BwXe0SsjCak7e
        yrCcpkC8Us6N0BmWcXDKfwo=
X-Google-Smtp-Source: ABdhPJzJG6eC7iHWpDKh53mI1PmTX3boMz7WLC6M/2zyx1ncVsIslFYsZtQGola7VBTxJ05yAQ1BHQ==
X-Received: by 2002:a2e:87cc:: with SMTP id v12mr5639681ljj.79.1613742787736;
        Fri, 19 Feb 2021 05:53:07 -0800 (PST)
Received: from [192.168.1.5] ([5.8.48.45])
        by smtp.gmail.com with ESMTPSA id u1sm932089lff.58.2021.02.19.05.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 05:53:07 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20210219133459.vezgrlkjpmaizvb4@work>
Date:   Fri, 19 Feb 2021 16:53:05 +0300
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB31D81D-F4A9-490E-8F9D-2BC6350CE6B0@gmail.com>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
 <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
 <20210219105713.uu2mywenytfd2e5j@work>
 <E16FB371-5DFC-4A10-A9E2-36541FCF7D30@gmail.com>
 <20210219133459.vezgrlkjpmaizvb4@work>
To:     Lukas Czerner <lczerner@redhat.com>
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 16:34, Lukas Czerner =
<lczerner@redhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> On Fri, Feb 19, 2021 at 02:49:16PM +0300, Alexey Lyashkov wrote:
>> Lukas,
>>=20
>> because e2fsprogs have an bad assumption about IO size for the =
O_DIRECT case.
>> and because library uses a code like
>>>>=20
>> set_block_size(1k);
>> seek(fs, 1);
>> read_block();
>>>>>=20
>> which caused an 1k read inside of 4k disk block size not aligned by =
block size, which is prohibited and caused an error report.
>>=20
>> Reference to patch.
>> =
https://patchwork.ozlabs.org/project/linux-ext4/patch/20201023112659.1559-=
1-artem.blagodarenko@gmail.com/
>=20
> Alright, I skimmed through your patch proposal and I am not sure I
> completely understand the problem because you have not provided the =
code
> adding O_DIRECT support for e2image.

debugfs -D =E2=80=A6 will hit same problem.

>=20
> However I think that it is a reasonable assumption to make that there =
is
> not going to be a file system on a block device such that the fs =
blocksize
> is smaller than device sector size. You can't create such fs with =
mke2fs
> and you can't mount such file system either.
>=20
This is don=E2=80=99t need to be create this FS, calling an ext2_open2 =
is enough.


> All that said I can now see that there is a problem in case of mke2fs
> and debugfs when used with O_DIRECT (-D) on a file system image with =
1k
> block size stored on a file in the host file system on the block =
device
> with sector size larger than 1k (...I am getting Inception flashbacks =
now)

if you have open a large (>256T) device with debugfs without -D you will =
be see a large swap.
once this FS want to consume a ~10G for bitmaps and other parts.
with cached read you memory consumption increased by two.

btw.
you can easy replicate it with losetup which able to specify a block =
size.

>=20
> In fact I can confirm that indeed, both mke2fs and debugfs will fail =
in
> such scenario. The question is whether we care enough to support
> O_DIRECT in such situations. Personally I don't care enough about =
this.
> However it would be nice to at least have a check (probably in
> ext2fs_open2, unix_open_channel or such) and notify user about the
> problem.

it=E2=80=99s not a tools problem. It=E2=80=99s problem of e2fsprogs =
library as ext2_open2 affected by this bug.
But this is not a single function where bug lives.


>=20
> Note that this conversation does not affect my patch since
> ext2fs_mmp_read() does not use the unix_io infrastructure.
>=20
It=E2=80=99s good to convert to use it.

Alex


> -Lukas
>=20
>>=20
>> Alex
>>=20
>>> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 13:57, Lukas =
Czerner <lczerner@redhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=
=B0):
>>>=20
>>> On Fri, Feb 19, 2021 at 01:08:17PM +0300, Alexey Lyashkov wrote:
>>>> Andreas,
>>>>=20
>>>> What about to disable a O_DIRECT global on any block devices in the =
e2fsprogs library as this don=E2=80=99t work on 4k disk drives at all ?
>>>> Instead of fixing an O_DIRECT access with patches sends early.
>>>=20
>>> Why would it not work at all ? This is a fix for a specific problem =
and
>>> I am not currently aware of ony other problems e2fsprogs should have
>>> with 4k sector size drives. Do you have a specific problem in mind ?
>>>=20
>>> Thanks!
>>> -Lukas
>>>=20
>>>>=20
>>>>=20
>>>> Alex
>>>>=20
>>>>> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 1:20, Andreas =
Dilger <adilger@dilger.ca> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>>>>>=20
>>>>> On Feb 18, 2021, at 2:51 AM, Lukas Czerner <lczerner@redhat.com> =
wrote:
>>>>>>=20
>>>>>> Currently the mmp block is read using O_DIRECT to avoid any =
caching that
>>>>>> may be done by the VM. However when working with regular files =
this
>>>>>> creates alignment issues when the device of the host file system =
has
>>>>>> sector size larger than the blocksize of the file system in the =
file
>>>>>> we're working with.
>>>>>>=20
>>>>>> This can be reproduced with t_mmp_fail test when run on the =
device with
>>>>>> 4k sector size because the mke2fs fails when trying to read the =
mmp
>>>>>> block.
>>>>>>=20
>>>>>> Fix it by disabling O_DIRECT when working with regular files. I =
don't
>>>>>> think there is any risk of doing so since the file system layer, =
unlike
>>>>>> shared block device, should guarantee cache consistency.
>>>>>>=20
>>>>>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>>>>>> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
>>>>>=20
>>>>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>>>>>=20
>>>>>> ---
>>>>>> v2: Fix comment - it avoids problems when the sector size is =
larger not
>>>>>> smaller than blocksize
>>>>>>=20
>>>>>> lib/ext2fs/mmp.c | 22 +++++++++++-----------
>>>>>> 1 file changed, 11 insertions(+), 11 deletions(-)
>>>>>>=20
>>>>>> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
>>>>>> index c21ae272..cca2873b 100644
>>>>>> --- a/lib/ext2fs/mmp.c
>>>>>> +++ b/lib/ext2fs/mmp.c
>>>>>> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, =
blk64_t mmp_blk, void *buf)
>>>>>> 	 * regardless of how the io_manager is doing reads, to avoid =
caching of
>>>>>> 	 * the MMP block by the io_manager or the VM.  It needs to be =
fresh. */
>>>>>> 	if (fs->mmp_fd <=3D 0) {
>>>>>> +		struct stat st;
>>>>>> 		int flags =3D O_RDWR | O_DIRECT;
>>>>>>=20
>>>>>> -retry:
>>>>>> +		/*
>>>>>> +		 * There is no reason for using O_DIRECT if =
we're working with
>>>>>> +		 * regular file. Disabling it also avoids =
problems with
>>>>>> +		 * alignment when the device of the host file =
system has sector
>>>>>> +		 * size larger than blocksize of the fs we're =
working with.
>>>>>> +		 */
>>>>>> +		if (stat(fs->device_name, &st) =3D=3D 0 &&
>>>>>> +		    S_ISREG(st.st_mode))
>>>>>> +			flags &=3D ~O_DIRECT;
>>>>>> +
>>>>>> 		fs->mmp_fd =3D open(fs->device_name, flags);
>>>>>> 		if (fs->mmp_fd < 0) {
>>>>>> -			struct stat st;
>>>>>> -
>>>>>> -			/* Avoid O_DIRECT for filesystem image =
files if open
>>>>>> -			 * fails, since it breaks when running =
on tmpfs. */
>>>>>> -			if (errno =3D=3D EINVAL && (flags & =
O_DIRECT) &&
>>>>>> -			    stat(fs->device_name, &st) =3D=3D 0 =
&&
>>>>>> -			    S_ISREG(st.st_mode)) {
>>>>>> -				flags &=3D ~O_DIRECT;
>>>>>> -				goto retry;
>>>>>> -			}
>>>>>> 			retval =3D EXT2_ET_MMP_OPEN_DIRECT;
>>>>>> 			goto out;
>>>>>> 		}
>>>>>> --
>>>>>> 2.26.2
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>> Cheers, Andreas
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>=20
>>>>=20
>>>=20
>>=20
>=20

