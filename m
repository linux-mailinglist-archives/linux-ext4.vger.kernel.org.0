Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68ADFCAD6C
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfJCRli (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 13:41:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33957 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfJCP6U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 11:58:20 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so6802395ion.1
        for <linux-ext4@vger.kernel.org>; Thu, 03 Oct 2019 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UXDFwG2s8ODcENgE5nC14uPOd2aRhVNEamIM8uw5Hyg=;
        b=awOu6Yi6TU4R6ET111fAsSSTTV6SEIQkcEq3yKbeZijJVwWFM4x22176oBSInBEt5l
         kQH880/0yQh0iLlOi9yiJp5oOMRGnU/uPsV9Snahe46AYaQiVWr4iJmFOtxviBvyPidn
         TBzH7KwOXMvCEFGumx1bAy4qAp8VpZgx9udDT7TO9iXxtefw8Sj6ooMYCzIgX7Na+rqL
         mlnYwmV6VkuDDWs5yiKertrGbQolLcoy1C9NE5TLR3GMZKRfjQFnoaptNPP0jjx8L4Un
         2GmfxW3h7PPIUzBqyfne5/t4MU9GjZ8NwRj3c+fa1CdHNEMss4F/9SuqGBfquvtR2s7N
         qvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UXDFwG2s8ODcENgE5nC14uPOd2aRhVNEamIM8uw5Hyg=;
        b=TSJn/Z1OjOvGsgXgG7YXtgGUW9qsFnwlHl79lxy6OugkT6q4cNLwYMV7WBaJmrpZRM
         ckIX/X+546qCS2o457cdYX/sMpdSD/QkmM8fy4iZjwHKtEhOKWH/z2Wgcsozn5Lc6J+j
         nV1mrCzSyPGm13XEqGUo49/K6Emjn+5Cgje1n8QpK/lFWRTT9uI5KTdj3xYb73NJ+hoP
         duEeiKTZPihI9AsqMqLEnu6F9E9xb2+hIP3l2WjObkDZhNQN7TPUr3JhgtNHOuS6BJQG
         PCJlscy4sjHy96hlaA5nrBkYrL0dPY7CVHkl5ANio0J7tTDWe+4H1JQZv5NR718IlBDK
         TGxw==
X-Gm-Message-State: APjAAAWbePC7Ly+tCdV/m0n5XA42VvpKhfNurz4nBAk2EBRC2LmaS/DU
        MJUux4+SZHw9APAKC6gWqINk3yUqDohwrQ==
X-Google-Smtp-Source: APXvYqyHXnNzUQCP6CMwnvImOlIFsFcNecyszojV2sUmHTHxmvWN7LEtraKXuJ0iTb8TOSc2Sk81kg==
X-Received: by 2002:a92:98d3:: with SMTP id a80mr10736904ill.194.1570118298855;
        Thu, 03 Oct 2019 08:58:18 -0700 (PDT)
Received: from [192.168.248.234] ([63.239.150.218])
        by smtp.gmail.com with ESMTPSA id d197sm1090454iog.15.2019.10.03.08.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 08:58:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <FED4628E-3B0D-45C7-92A6-FCBB71F187B0@dilger.ca>
Date:   Thu, 3 Oct 2019 18:58:12 +0300
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, adilger.kernel@dilger.ca
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CE33DD0-C911-4D3B-B46F-C19EAC34F9A9@gmail.com>
References: <20190905110110.32627-1-c17828@cray.com>
 <1B7DFCD4-F274-4A7A-B7FC-04566308322F@gmail.com>
 <FED4628E-3B0D-45C7-92A6-FCBB71F187B0@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks.

Sorry, not good new call time for me, but I can join occasionally.
I joined today, but too late.

Best regards,
Artem Blagodarenko.

> On 3 Oct 2019, at 18:55, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> We just discussed this on the ext4 developer concall today, and Ted is =
looking into it.=20
>=20
> Cheers, Andreas
>=20
>> On Oct 3, 2019, at 09:47, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=
=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC =
<artem.blagodarenko@gmail.com> wrote:
>>=20
>> Hello,
>>=20
>> Does anybody wants to give any feedback for this?
>> e2label became really faster on large partitions with this patch. =
Probably it can be useful.
>>=20
>> Ted, what do you think?
>>=20
>> Thanks,
>> Artem Blagodarenko.
>>=20
>>=20
>>=20
>>> On 5 Sep 2019, at 14:01, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>>>=20
>>> tune2fs is used to make e2label duties.  ext2fs_open2() reads group
>>> descriptors which are not used during disk label obtaining, but =
takes
>>> a lot of time on large partitions.
>>>=20
>>> This patch adds ext2fs_read_sb(), there only initialized superblock
>>> is returned This saves time dramatically.
>>>=20
>>> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
>>> Cray-bug-id: LUS-5777
>>> ---
>>> lib/ext2fs/ext2fs.h |  2 ++
>>> lib/ext2fs/openfs.c | 16 ++++++++++++++++
>>> misc/tune2fs.c      | 23 +++++++++++++++--------
>>> 3 files changed, 33 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
>>> index 59fd9742..3a63b74d 100644
>>> --- a/lib/ext2fs/ext2fs.h
>>> +++ b/lib/ext2fs/ext2fs.h
>>> @@ -1630,6 +1630,8 @@ extern int ext2fs_journal_sb_start(int =
blocksize);
>>> extern errcode_t ext2fs_open(const char *name, int flags, int =
superblock,
>>>                unsigned int block_size, io_manager manager,
>>>                ext2_filsys *ret_fs);
>>> +extern errcode_t ext2fs_read_sb(const char *name, io_manager =
manager,
>>> +                struct ext2_super_block * super);
>>> extern errcode_t ext2fs_open2(const char *name, const char =
*io_options,
>>>                 int flags, int superblock,
>>>                 unsigned int block_size, io_manager manager,
>>> diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
>>> index 51b54a44..95f45d84 100644
>>> --- a/lib/ext2fs/openfs.c
>>> +++ b/lib/ext2fs/openfs.c
>>> @@ -99,6 +99,22 @@ static void block_sha_map_free_entry(void *data)
>>>   return;
>>> }
>>>=20
>>> +errcode_t ext2fs_read_sb(const char *name, io_manager manager,
>>> +             struct ext2_super_block * super)
>>> +{
>>> +    io_channel    io;
>>> +    errcode_t    retval =3D 0;
>>> +
>>> +    retval =3D manager->open(name, 0, &io);
>>> +    if (!retval) {
>>> +        retval =3D io_channel_read_blk(io, 1, -SUPERBLOCK_SIZE,
>>> +                     super);
>>> +        io_channel_close(io);
>>> +    }
>>> +
>>> +    return retval;
>>> +}
>>> +
>>> /*
>>> *  Note: if superblock is non-zero, block-size must also be =
non-zero.
>>> *    Superblock and block_size can be zero to use the default size.
>>> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
>>> index 7d2d38d7..fea607e1 100644
>>> --- a/misc/tune2fs.c
>>> +++ b/misc/tune2fs.c
>>> @@ -2879,6 +2879,21 @@ int tune2fs_main(int argc, char **argv)
>>> #endif
>>>       io_ptr =3D unix_io_manager;
>>>=20
>>> +    if (print_label) {
>>> +        /* For e2label emulation */
>>> +        struct ext2_super_block sb;
>>> +
>>> +        /* Read only superblock. Nothing else metters.*/
>>> +        retval =3D ext2fs_read_sb(device_name, io_ptr, &sb);
>>> +        if (!retval) {
>>> +            printf("%.*s\n", (int) sizeof(sb.s_volume_name),
>>> +                   sb.s_volume_name);
>>> +        }
>>> +
>>> +        remove_error_table(&et_ext2_error_table);
>>> +        return retval;
>>> +    }
>>> +
>>> retry_open:
>>>   if ((open_flag & EXT2_FLAG_RW) =3D=3D 0 || f_flag)
>>>       open_flag |=3D EXT2_FLAG_SKIP_MMP;
>>> @@ -2972,14 +2987,6 @@ retry_open:
>>>   sb =3D fs->super;
>>>   fs->flags &=3D ~EXT2_FLAG_MASTER_SB_ONLY;
>>>=20
>>> -    if (print_label) {
>>> -        /* For e2label emulation */
>>> -        printf("%.*s\n", (int) sizeof(sb->s_volume_name),
>>> -               sb->s_volume_name);
>>> -        remove_error_table(&et_ext2_error_table);
>>> -        goto closefs;
>>> -    }
>>> -
>>>   retval =3D ext2fs_check_if_mounted(device_name, &mount_flags);
>>>   if (retval) {
>>>       com_err("ext2fs_check_if_mount", retval,
>>> --=20
>>> 2.14.3
>>>=20
>>=20

