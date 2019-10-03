Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA23CA16C
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfJCPzh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 11:55:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45910 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJCPzh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 11:55:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so1709439pls.12
        for <linux-ext4@vger.kernel.org>; Thu, 03 Oct 2019 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4SyPYr4pY4Ac76mXpPy+xaC7buFj6xPsp1jfOhUjYHw=;
        b=wk2C0Vmqd/QjIwWi2AaqLI5mgwQuec2StpPZybdxipttm752awQHGNOu2u/k5xRB8S
         5PuXUXk9Gzz0E1vXfXRDAQNkl/bahFX6h8DeC7S1aE3AMidlB0v52r0TYEaDjP2720V4
         EtAOSnqsmimy2UHwQfeXfcqgd4se0JWsWz85bMWUFzJiGQLPdCKX5egMwIe5Qy4sOobz
         2loWr1ok/Pb6rvqd+AD3yeoWC7bQrl0iY4z4U0vrSsYHOjOcWRjLhne4jTFSNJs3OX9B
         WQ+xR9ImVQd7uEgs9aDF93d3P9c11cMjZjldqzPgKtp1i3G5fCCqKkra8f05395C17Cb
         ewCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4SyPYr4pY4Ac76mXpPy+xaC7buFj6xPsp1jfOhUjYHw=;
        b=H64MsBZyrua5jupkSG8HLaHtXNnV/9IiEDKeH1f+YjjTjvYnRR/dZBAJ50cvb8WXNT
         nl4t3WZYHt6g1c/s/uldVcWCiI7NZTEwqHsbwnCj79HQFyFXKhCGayvNel1cwYL70GJb
         yfXP3udpgoy+Bdohfhg48c8i+mwhauIK9NgpUi8Hcv4tX1FY5UUtjJCNLXI09mF8OzJE
         xOVDJlMPX1EWW1boUCv++Gw1dBYsVASFBMpL2HdSc57jD3PawMK+5L48Iz5fpkzb4I2Y
         a/9xutwdhTS3dJJBKGBCV6aDknCsGW5ICLchMnIPVaKCijgs7gmwi2Kuq3LqVM5fANAY
         1iCw==
X-Gm-Message-State: APjAAAXarSxPsSbVpetH3IYv7RN5waUdzUoX3jug9v2VYOSmfCv7h1ui
        0Ky/9aBJEqCQvQecQ98c/zDJ6w==
X-Google-Smtp-Source: APXvYqyPqla/j+9qHJiXnERwp+ZAxNXmZzj4hHfNVUZq0Vl8j6LcxP8noj5zcdAw5U0n3rnX3DEgAA==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr10055715plr.48.1570118136069;
        Thu, 03 Oct 2019 08:55:36 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id m68sm3430620pfb.122.2019.10.03.08.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 08:55:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <1B7DFCD4-F274-4A7A-B7FC-04566308322F@gmail.com>
Date:   Thu, 3 Oct 2019 09:55:34 -0600
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, adilger.kernel@dilger.ca
Content-Transfer-Encoding: quoted-printable
Message-Id: <FED4628E-3B0D-45C7-92A6-FCBB71F187B0@dilger.ca>
References: <20190905110110.32627-1-c17828@cray.com> <1B7DFCD4-F274-4A7A-B7FC-04566308322F@gmail.com>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We just discussed this on the ext4 developer concall today, and Ted is looki=
ng into it.=20

Cheers, Andreas

> On Oct 3, 2019, at 09:47, =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=D1=80=
=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC <artem.blagodarenko@=
gmail.com> wrote:
>=20
> Hello,
>=20
> Does anybody wants to give any feedback for this?
> e2label became really faster on large partitions with this patch. Probably=
 it can be useful.
>=20
> Ted, what do you think?
>=20
> Thanks,
> Artem Blagodarenko.
>=20
>=20
>=20
>> On 5 Sep 2019, at 14:01, Artem Blagodarenko <artem.blagodarenko@gmail.com=
> wrote:
>>=20
>> tune2fs is used to make e2label duties.  ext2fs_open2() reads group
>> descriptors which are not used during disk label obtaining, but takes
>> a lot of time on large partitions.
>>=20
>> This patch adds ext2fs_read_sb(), there only initialized superblock
>> is returned This saves time dramatically.
>>=20
>> Signed-off-by: Artem Blagodarenko <c17828@cray.com>
>> Cray-bug-id: LUS-5777
>> ---
>> lib/ext2fs/ext2fs.h |  2 ++
>> lib/ext2fs/openfs.c | 16 ++++++++++++++++
>> misc/tune2fs.c      | 23 +++++++++++++++--------
>> 3 files changed, 33 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
>> index 59fd9742..3a63b74d 100644
>> --- a/lib/ext2fs/ext2fs.h
>> +++ b/lib/ext2fs/ext2fs.h
>> @@ -1630,6 +1630,8 @@ extern int ext2fs_journal_sb_start(int blocksize);
>> extern errcode_t ext2fs_open(const char *name, int flags, int superblock,=

>>                 unsigned int block_size, io_manager manager,
>>                 ext2_filsys *ret_fs);
>> +extern errcode_t ext2fs_read_sb(const char *name, io_manager manager,
>> +                struct ext2_super_block * super);
>> extern errcode_t ext2fs_open2(const char *name, const char *io_options,
>>                  int flags, int superblock,
>>                  unsigned int block_size, io_manager manager,
>> diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
>> index 51b54a44..95f45d84 100644
>> --- a/lib/ext2fs/openfs.c
>> +++ b/lib/ext2fs/openfs.c
>> @@ -99,6 +99,22 @@ static void block_sha_map_free_entry(void *data)
>>    return;
>> }
>>=20
>> +errcode_t ext2fs_read_sb(const char *name, io_manager manager,
>> +             struct ext2_super_block * super)
>> +{
>> +    io_channel    io;
>> +    errcode_t    retval =3D 0;
>> +
>> +    retval =3D manager->open(name, 0, &io);
>> +    if (!retval) {
>> +        retval =3D io_channel_read_blk(io, 1, -SUPERBLOCK_SIZE,
>> +                     super);
>> +        io_channel_close(io);
>> +    }
>> +
>> +    return retval;
>> +}
>> +
>> /*
>> *  Note: if superblock is non-zero, block-size must also be non-zero.
>> *    Superblock and block_size can be zero to use the default size.
>> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
>> index 7d2d38d7..fea607e1 100644
>> --- a/misc/tune2fs.c
>> +++ b/misc/tune2fs.c
>> @@ -2879,6 +2879,21 @@ int tune2fs_main(int argc, char **argv)
>> #endif
>>        io_ptr =3D unix_io_manager;
>>=20
>> +    if (print_label) {
>> +        /* For e2label emulation */
>> +        struct ext2_super_block sb;
>> +
>> +        /* Read only superblock. Nothing else metters.*/
>> +        retval =3D ext2fs_read_sb(device_name, io_ptr, &sb);
>> +        if (!retval) {
>> +            printf("%.*s\n", (int) sizeof(sb.s_volume_name),
>> +                   sb.s_volume_name);
>> +        }
>> +
>> +        remove_error_table(&et_ext2_error_table);
>> +        return retval;
>> +    }
>> +
>> retry_open:
>>    if ((open_flag & EXT2_FLAG_RW) =3D=3D 0 || f_flag)
>>        open_flag |=3D EXT2_FLAG_SKIP_MMP;
>> @@ -2972,14 +2987,6 @@ retry_open:
>>    sb =3D fs->super;
>>    fs->flags &=3D ~EXT2_FLAG_MASTER_SB_ONLY;
>>=20
>> -    if (print_label) {
>> -        /* For e2label emulation */
>> -        printf("%.*s\n", (int) sizeof(sb->s_volume_name),
>> -               sb->s_volume_name);
>> -        remove_error_table(&et_ext2_error_table);
>> -        goto closefs;
>> -    }
>> -
>>    retval =3D ext2fs_check_if_mounted(device_name, &mount_flags);
>>    if (retval) {
>>        com_err("ext2fs_check_if_mount", retval,
>> --=20
>> 2.14.3
>>=20
>=20
