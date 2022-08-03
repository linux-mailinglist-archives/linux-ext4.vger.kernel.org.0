Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758EA5890DF
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiHCRA6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiHCRA5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 13:00:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659B95AE
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 10:00:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r17so2323585lfm.11
        for <linux-ext4@vger.kernel.org>; Wed, 03 Aug 2022 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=s1dSskhq1OKrvjneD9jxBhptnn5XLSgXqSIBQdpy3BM=;
        b=KD9ykqk5BOYiAs2TV9EMWetbWFCFKggX2+freK8nZmpO//ZPJnygyQEilzJeXqG3qk
         7ySqbru+WG7kawUyh3pz08J4Y9/SOHpheY0DStgI6MecEPO5lt0Jpy3F4yxlTCbhoq9z
         j1WwCfda3F1uQSFmjqFU9oZ1TCl6gG/hhWNk2hxgSK6wssR3G3apl+O6u6xp0f4zGUml
         MG8qf354RpVDC2KmZHwUVOVtWw7XwaS2TnyqiIMutOFDMXyXRLVf2n6zAgP3sn7bm7vK
         fTESVUvTQH1dyujkkjDC39Xvwzt/dQ7A4hvV3zDFRjPju1aKB8mWXcRnu2cUXHriBFsS
         Oa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=s1dSskhq1OKrvjneD9jxBhptnn5XLSgXqSIBQdpy3BM=;
        b=towkNWqZC9i61W+jus54Vt4GAcKLWqKEx8n+j63kWGCFZTgi0QOYgSQ5yRdWdC0hTa
         UHXLTV6gRbdQpILS+P7RkXIuCmeWgiID0BD5c7pXBaWOgMzt1PRX6ytWYsX/xIFfoAHU
         uijph0IC6q8j4x7+lQpbz5uyDEoWaQtSnvdZPQgu1WlOcrSrG7IpZzJtzt5Wj7N1kMPU
         xw10SOlh1gpxrGoDMtzOpsOkiWz9UEmNscti1s0/TtIbOVhD99vKvKrs4wTtLlo1N72K
         UH7qmC9MWc5cMBvyiApMme4xsnHuT2mlbmaEJB5HOFWxyp7DsoG72Y1hSZQBoEzvChHJ
         Qjcg==
X-Gm-Message-State: ACgBeo1PFvMofKr1WVGCDnQ6YtZ1HvNNce8Y0MRnQMQe95lHIwfqWejV
        xyypfNh/RFM+i5GA27jZXlebOeN4gkzCHMkmXgE=
X-Google-Smtp-Source: AA6agR6TOp1gnHJ0UIHTWDr7EsBU/zMTeuC/fu3pEb6dec3KFu0MWljO9exVePyW8gGTrcDRt7sQbA==
X-Received: by 2002:a05:6512:24b:b0:48a:f3f6:dfd7 with SMTP id b11-20020a056512024b00b0048af3f6dfd7mr6481645lfo.157.1659546053646;
        Wed, 03 Aug 2022 10:00:53 -0700 (PDT)
Received: from smtpclient.apple ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b0048b12c4c7e6sm555489lfg.12.2022.08.03.10.00.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:00:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] e2fsprogs: avoid code duplication
From:   Alexey Lyahkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20220803163927.ugc7qdxfsehsks3b@fedora>
Date:   Wed, 3 Aug 2022 20:00:50 +0300
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39DA7EBB-8155-4557-83EC-BB6BFBBDB72E@gmail.com>
References: <20220803075407.538398-1-alexey.lyashkov@gmail.com>
 <20220803163927.ugc7qdxfsehsks3b@fedora>
To:     Lukas Czerner <lczerner@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Lukas,

It don=E2=80=99t have any improvement. It have changes a prototype in =
the e2fsck to use a generic types,
instead of home coded as similar as debugfs does. Removing ctx->journal =
needs for same reason.
(as generic code have work with ext2fs
=20
I started this work to make debugfs work fine with journal dump and =
modifications.
Originally, I found tag v3 isn=E2=80=99t work well with journal dump =
(large block numbers truncated),
checksums isn=E2=80=99t checked well with dump, =E2=80=A6 etc.
Loading journal have a lack init for structures related to the fast =
commit.
=20

> On 3 Aug 2022, at 19:39, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Hi Alexey,
>=20
> I assume this change is based on the maint branch?
>=20
> On Wed, Aug 03, 2022 at 10:54:07AM +0300, Alexey Lyashkov wrote:
>> debugfs and e2fsck have a so much code duplication in journal =
handing.
>> debugfs have lack a many journal features handing also.
>> Let's start code merging to avoid code duplication and lack features.
>>=20
>> userspace buffer head emulation moved into library.
>=20
> I can see that this is a little bit more involved than just moving the
> code, can you describe a little bit more what has to be done in order =
to
> move and deduplicate the code? I have not done a proper review but I =
can
> already see that the function prototypes are changing as well as some
> structures. I think it would be nice to get some idea from the commit
> description what to expect from this change.
>=20
> I've done some limited testing on this and I see no regression.
>=20
>>=20
>> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
>> ---
>> debugfs/Makefile.in               |  14 +-
>> debugfs/debugfs.c                 |   2 +-
>> debugfs/journal.c                 | 251 ---------------------------
>> debugfs/journal.h                 |   2 +-
>> debugfs/logdump.c                 |   2 +-
>> e2fsck/Makefile.in                |   8 +-
>> e2fsck/e2fsck.c                   |   5 -
>> e2fsck/e2fsck.h                   |   1 -
>> e2fsck/journal.c                  | 278 =
++----------------------------
>> e2fsck/logfile.c                  |   2 +-
>> e2fsck/recovery.c                 |   2 +-
>> e2fsck/revoke.c                   |   2 +-
>> e2fsck/unix.c                     |   4 +-
>> e2fsck/util.c                     |   2 +-
>> lib/ext2fs/Android.bp             |   1 +
>> lib/ext2fs/Makefile.in            |  23 +--
>> lib/ext2fs/jfs_user.c             | 255 +++++++++++++++++++++++++++
>> {e2fsck =3D> lib/ext2fs}/jfs_user.h |  55 +++---
>=20
> Can we perhaps take the opportunity to rename jfs_user to journal? I
> know it was historically this way, but it can we a bit confusing these
> days, especially when we actually have jfs file system.

I do it originally but=E2=80=A6 it conflicts with journal.c from e2fsck.
And this code handle just kernel API emulation now.


>=20
> More below...
>>=20
>> -
>> -}
>> -
>> /*
>>  * This function makes sure that the superblock fields regarding the
>>  * journal are consistent.
>> @@ -1525,7 +1285,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t =
ctx)
>> 		    (!fix_problem(ctx, PR_0_JOURNAL_UNSUPP_VERSION, =
&pctx))))
>> 			retval =3D e2fsck_journal_fix_corrupt_super(ctx, =
journal,
>> 								  =
&pctx);
>> -		e2fsck_journal_release(ctx, journal, 0, 1);
>> +		ext2fs_journal_release(ctx->fs, journal, 0, 1);
>> 		return retval;
>> 	}
>>=20
>> @@ -1552,7 +1312,7 @@ no_has_journal:
>> 			sb->s_journal_dev =3D 0;
>> 			memset(sb->s_journal_uuid, 0,
>> 			       sizeof(sb->s_journal_uuid));
>> -			e2fsck_clear_recover(ctx, force_fsck);
>> +			ext2fs_clear_recover(ctx->fs, force_fsck);
>=20
> This is the kind of function prototype change I'd like to be mentioned
> in the description. Just to make it easier for reviewer today and for
> the future.
>=20
I may put a wrappers who just call ext2fs_* functions if it will be help =
with review.
It will have just ctx->fs call inside.
>>=20
>>=20
>> /* Command line options */
>> @@ -66,7 +66,7 @@ static int replace_bad_blocks;
>> static int keep_bad_blocks;
>> static char *bad_blocks_file;
>>=20
>> -e2fsck_t e2fsck_global_ctx;	/* Try your very best not to use this! =
*/
>> +struct e2fsck_struct *e2fsck_global_ctx;	/* Try your very best =
not to use this! */
>=20
> Why is this necessary? I am just curious.
>=20
Using a pointer to structure make a full structure definition =
unnecessary.
So I can do

extern struct data *ptr;
some_call(ptr);=20

Without teach source about struct data itself.
It=E2=80=99s a specially for the jfs_user.h and J_ASSERT() =
implementation.

>> diff --git a/e2fsck/jfs_user.h b/lib/ext2fs/jfs_user.h
>> similarity index 89%
>> rename from e2fsck/jfs_user.h
>> rename to lib/ext2fs/jfs_user.h
>> index 4ad2005a..ed75c4a5 100644
>> --- a/e2fsck/jfs_user.h
>> +++ b/lib/ext2fs/jfs_user.h
>> @@ -11,7 +11,6 @@
>> #ifndef _JFS_USER_H
>> #define _JFS_USER_H
>>=20
>> -#ifdef DEBUGFS
>> #include <stdio.h>
>> #include <stdlib.h>
>> #if EXT2_FLAT_INCLUDES
>> @@ -23,13 +22,8 @@
>> #include "ext2fs/ext2fs.h"
>> #include "blkid/blkid.h"
>> #endif
>> -#else
>> -/*
>> - * Pull in the definition of the e2fsck context structure
>> - */
>> -#include "config.h"
>> -#include "e2fsck.h"
>> -#endif
>> +
>> +struct e2fsck_struct;
>>=20
>> #if __STDC_VERSION__ < 199901L
>> # if __GNUC__ >=3D 2 || _MSC_VER >=3D 1300
>> @@ -40,11 +34,8 @@
>> #endif
>>=20
>> struct buffer_head {
>> -#ifdef DEBUGFS
>> 	ext2_filsys	b_fs;
>> -#else
>> -	e2fsck_t	b_ctx;
>> -#endif
>> +	struct e2fsck_struct *b_ctx;
>=20
> Do we need to have both k_ctx and k_fs? Can we use union instead, or =
is
> not worth it?
>=20
I think better to have both, in some cases e2fsck looks to the own =
context attached to these structures.
I=E2=80=99m not a very understand this part - and probably it will be =
removed in future.

>=20
>>=20
>> # This nastiness is needed because of jfs_user.h hackery; when we =
finally
>> # clean up this mess, we should be able to drop it
>> -JOURNAL_CFLAGS =3D -I$(srcdir)/../e2fsck $(ALL_CFLAGS) -DDEBUGFS
>> -DEPEND_CFLAGS =3D -I$(top_srcdir)/e2fsck
>> +JOURNAL_CFLAGS =3D $(ALL_CFLAGS) -DDEBUGFS
>> +DEPEND_CFLAGS =3D=20
>                  ^
> You have a trailing whitespace here.

Thanks! Will fix it. It looks comment can removed also.

Alex

>=20
> Thanks!
> -Lukas
>=20
>>=20
>> .
>> --=20
>> 2.31.1
>>=20
>=20

