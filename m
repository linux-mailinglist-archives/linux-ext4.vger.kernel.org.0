Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DF352E92
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhDBRj5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBRj5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 13:39:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB337C0613E6
        for <linux-ext4@vger.kernel.org>; Fri,  2 Apr 2021 10:39:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y3so1197995pgi.0
        for <linux-ext4@vger.kernel.org>; Fri, 02 Apr 2021 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HewEVT/hw4MYnIwCKcwvEx03U0ucUZSw/C6TUa9A1KQ=;
        b=aPNUIqTyxG8Mq3tJOaNX0u0bnmEcBcV2uWdG70PkbZonDkpW7G9pKguv1ogT3i2OW6
         /WWtDw7zgk4q9+geE23qdoViMVtS6SjceCpXTIvMyBCzXImuaE6kWxtMM/hSGe2WkE+u
         ot/MBHN8WF0TBUnBCulb0e/6vxOr1he6/h7jsky/oPTWxHtTtTCbmjGOvuRbuD+UNKqL
         AzPfPSfsduUFic5f76LyrLS/NRrB+3ZSj/KSsO1UB1POOmtbrKsbQjfzZBWcZSbBPkc/
         NwV4o0PGjzxZl6ijNRlm7GbeiU1GszRt8uR8EaW0ttUQenlE4txXN4XS5J+HUN+PIV24
         KmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HewEVT/hw4MYnIwCKcwvEx03U0ucUZSw/C6TUa9A1KQ=;
        b=HMGus1M+UYSCQfE5cmucMy12hW1JkeozvGsSQF5XMcywItdAKePGrXbQnXl4gOp48B
         Pcvuc/TCLq1X0ztqY0XJIqW5qtE82pv1BovJVvkbCo09gU9VctHto8hOqOlWiG883w27
         4BMVZO8zy3ipeWR3JtoWLzIPMcbXI+rSx5m/0SR/WkpIGtiP+FTCjDO82lSJoou4hBqn
         /DLoQ4MkVkuFQVPCjB/EX5N7fUpZh4fQsGhIYV1WB/sU8WbuqQPva4j1ScAoO1JJpVfy
         Qzws86YGOlbh1KFUV2j6gFfGxL2QwceyaQ4IROVf2s/ccPesggaHLS6qfv8e9tgFO3RL
         32kA==
X-Gm-Message-State: AOAM531tgz9MLEnbFmZB3+L/YnbnOmszghxMzjYIUIBBVumChtxsvKAc
        RU53vSnyjphjZYjM8mvVCsdPVxw+6iL2oYGP
X-Google-Smtp-Source: ABdhPJyEJ3aSRioPlkcgN0qloJUDyZebKaaE29K0gK+EjOVjwmWCNgFSbFJQ11fhJ4u+8hh9EUp5lQ==
X-Received: by 2002:a65:5bca:: with SMTP id o10mr13213414pgr.248.1617385193884;
        Fri, 02 Apr 2021 10:39:53 -0700 (PDT)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c2sm8765527pfb.121.2021.04.02.10.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:39:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 7/7] ext4: make prefetch_block_bitmaps default
Date:   Fri, 2 Apr 2021 11:39:51 -0600
Message-Id: <4CA7B7B0-BC40-43D3-A34F-38C92EDB38A4@dilger.ca>
References: <CAD+ocbwhQva2d7H2E=67_aSSzr0VkR+xiBjEmBTb4ENggvU6Hw@mail.gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
In-Reply-To: <CAD+ocbwhQva2d7H2E=67_aSSzr0VkR+xiBjEmBTb4ENggvU6Hw@mail.gmail.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Apr 2, 2021, at 10:46, harshad shirwadkar <harshadshirwadkar@gmail.com> w=
rote:
>=20
> =EF=BB=BFThanks for taking a look!
>=20
>> On Thu, Apr 1, 2021 at 10:16 PM Andreas Dilger <adilger@dilger.ca> wrote:=

>>=20
>>> On Apr 1, 2021, at 11:45, Harshad Shirwadkar <harshadshirwadkar@gmail.co=
m> wrote:
>>>=20
>>> =EF=BB=BFBlock bitmap prefetching is needed for these allocator optimiza=
tion
>>> data structures to get populated and provide better group scanning
>>> order. So, turn it on bu default. prefetch_block_bitmaps mount option
>>> is now marked as removed and a new option no_prefetch_block_bitmaps is
>>> added to disable block bitmap prefetching.
>>=20
>> This makes it more difficult to change between an old kernel and a new on=
e
>> using this option. It would be better to keep prefetch_block_bitmaps to t=
urn
>> the option on (not harmful if it is already on), and no_* turn it off.
> How so? This patch doesn't get rid of the prefetch_block_bitmaps mount
> option, it just marks it as "removed". So, you can still pass
> "prefetch_block_bitmaps" mount option and get the prefetching
> behavior, the only difference is that you'll get an additional kernel
> message saying that "ignoring removed mount option
> prefetch_block_bitmaps", which I thought is good since looking at that
> message, users will eventually remove that mount option from their
> mount arguments.

Sorry, I guess I was reading too quickly, and wasn't familiar with the
Opt_removed mechanism. It seems OK as-is, you can add:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas

>>> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>>> ---
>>> fs/ext4/ext4.h  |  2 +-
>>> fs/ext4/super.c | 15 ++++++++-------
>>> 2 files changed, 9 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>> index 9a5afe9d2310..20c757f711e7 100644
>>> --- a/fs/ext4/ext4.h
>>> +++ b/fs/ext4/ext4.h
>>> @@ -1227,7 +1227,7 @@ struct ext4_inode_info {
>>> #define EXT4_MOUNT_JOURNAL_CHECKSUM    0x800000 /* Journal checksums */
>>> #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT    0x1000000 /* Journal Async Co=
mmit */
>>> #define EXT4_MOUNT_WARN_ON_ERROR    0x2000000 /* Trigger WARN_ON on erro=
r */
>>> -#define EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS 0x4000000
>>> +#define EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS 0x4000000
>>> #define EXT4_MOUNT_DELALLOC        0x8000000 /* Delalloc support */
>>> #define EXT4_MOUNT_DATA_ERR_ABORT    0x10000000 /* Abort on file data wr=
ite */
>>> #define EXT4_MOUNT_BLOCK_VALIDITY    0x20000000 /* Block validity checki=
ng */
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index 6116640081c0..cec0fb07916b 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -1687,7 +1687,7 @@ enum {
>>>   Opt_dioread_nolock, Opt_dioread_lock,
>>>   Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
>>>   Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
>>> -    Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
>>> +    Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
>>> #ifdef CONFIG_EXT4_DEBUG
>>>   Opt_fc_debug_max_replay, Opt_fc_debug_force
>>> #endif
>>> @@ -1787,7 +1787,8 @@ static const match_table_t tokens =3D {
>>>   {Opt_inlinecrypt, "inlinecrypt"},
>>>   {Opt_nombcache, "nombcache"},
>>>   {Opt_nombcache, "no_mbcache"},    /* for backward compatibility */
>>> -    {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
>>> +    {Opt_removed, "prefetch_block_bitmaps"},
>>> +    {Opt_no_prefetch_block_bitmaps, "no_prefetch_block_bitmaps"},
>>>   {Opt_mb_optimize_scan, "mb_optimize_scan=3D%d"},
>>>   {Opt_removed, "check=3Dnone"},    /* mount option from ext2/3 */
>>>   {Opt_removed, "nocheck"},    /* mount option from ext2/3 */
>>> @@ -2009,7 +2010,7 @@ static const struct mount_opts {
>>>   {Opt_max_dir_size_kb, 0, MOPT_GTE0},
>>>   {Opt_test_dummy_encryption, 0, MOPT_STRING},
>>>   {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
>>> -    {Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
>>> +    {Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAP=
S,
>>>    MOPT_SET},
>>>   {Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
>>> #ifdef CONFIG_EXT4_DEBUG
>>> @@ -3706,11 +3707,11 @@ static struct ext4_li_request *ext4_li_request_n=
ew(struct super_block *sb,
>>>=20
>>>   elr->lr_super =3D sb;
>>>   elr->lr_first_not_zeroed =3D start;
>>> -    if (test_opt(sb, PREFETCH_BLOCK_BITMAPS))
>>> -        elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
>>> -    else {
>>> +    if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS)) {
>>>       elr->lr_mode =3D EXT4_LI_MODE_ITABLE;
>>>       elr->lr_next_group =3D start;
>>> +    } else {
>>> +        elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
>>>   }
>>>=20
>>>   /*
>>> @@ -3741,7 +3742,7 @@ int ext4_register_li_request(struct super_block *s=
b,
>>>       goto out;
>>>   }
>>>=20
>>> -    if (!test_opt(sb, PREFETCH_BLOCK_BITMAPS) &&
>>> +    if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
>>>       (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
>>>        !test_opt(sb, INIT_INODE_TABLE)))
>>>       goto out;
>>> --
>>> 2.31.0.291.g576ba9dcdaf-goog
>>>=20
