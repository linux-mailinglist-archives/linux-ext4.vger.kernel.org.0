Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3353F0480
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhHRNVe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 09:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235943AbhHRNVe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Aug 2021 09:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629292859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fpd/qhuqLuzBNJ/l6Gouwz4h0M+7ZmbZ5TcMD4eH/jc=;
        b=BQcBwpTLFOViR9uo41Wl+NCII0mIN1ho6rUpCoLsxJ7yML3D5VEm5RS2yAmEeafQdVnVUi
        kZzCRHnLJkVKjoWtpl03cxRsBVT59yy/iUVeUCn/Xgdmhzb8jjDNW5LKHaAxBntTne4vkK
        pFRYaMZzE4AixHpqQYubaD63wlJcrhw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-r9eYXkkAMLerBovLNmQNLA-1; Wed, 18 Aug 2021 09:20:57 -0400
X-MC-Unique: r9eYXkkAMLerBovLNmQNLA-1
Received: by mail-pf1-f197.google.com with SMTP id f22-20020a056a0022d6b02903c1c4cac83cso1269953pfj.16
        for <linux-ext4@vger.kernel.org>; Wed, 18 Aug 2021 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fpd/qhuqLuzBNJ/l6Gouwz4h0M+7ZmbZ5TcMD4eH/jc=;
        b=moUwuOLGquAtTmydmtqCe+Qi5+AO2QW9XSIy/M1Qr3wUuUvBNkda0s2qF4czAXKkV3
         mB+p4Pj4GaI2ziGUxvNEA9sVEfQI61VohxrmtqVDY/BZ62zz+ZzDaprG0R6zKDQfspIX
         8lZ+hRTKCCcND9by93u6xDfzh6cx6sBYs93dlW6vzzKF+y3Zd2G+J26lRi9cqYpjHD6J
         m2HeCvMtReLpvoCC5SHjR5KVRSxEiFNLMtFDdTX2YI0IO/vQPPusbS2nAdjFRGVyosog
         vyAP5n7vWEZfVCZKT5CFcWoHeoB36fOwkY5BzcSyfeffHtj80zAIAaZzuU00eR13sYd+
         xxfw==
X-Gm-Message-State: AOAM532UAvkFZlXnxXqWI9Tgb4oRVHHFBRxevD+XwuL+3+/3wfNAfhHB
        10EU4bC6l5zjsuujiuI2aR49pOPbMJNf0G5yP3fOpnMTh0KK63KIdXszG56CZvoaehpvbc5Y+K/
        +TzwMKRTS4CBKUnvE68ZkDgJLPp9icbdVIMBdMg==
X-Received: by 2002:a62:dd57:0:b029:3cd:c96e:625e with SMTP id w84-20020a62dd570000b02903cdc96e625emr9057641pff.45.1629292856782;
        Wed, 18 Aug 2021 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOf/yeN6fmMy3ojw0Gt/dB/rAodO6SVNLIyrMx3WVEI1zQepTBie1+IAg83tgwD45aGvIu5GBO0xR8XgzPIjI=
X-Received: by 2002:a62:dd57:0:b029:3cd:c96e:625e with SMTP id
 w84-20020a62dd570000b02903cdc96e625emr9057617pff.45.1629292856498; Wed, 18
 Aug 2021 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210818084126.4167799-1-bxue@redhat.com> <20210818114517.kqvfzu2vd45vuhze@fedora>
In-Reply-To: <20210818114517.kqvfzu2vd45vuhze@fedora>
From:   Boyang Xue <bxue@redhat.com>
Date:   Wed, 18 Aug 2021 21:20:44 +0800
Message-ID: <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
Subject: Re: [PATCH] ext4: regression test for "tune2fs -l" after ext4 shutdown
To:     Boyang Xue <bxue@redhat.com>, fstests@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Zorro,

On Wed, Aug 18, 2021 at 7:32 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Aug 18, 2021 at 04:40:56PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > Regression test for:
> >
> > ext4: Fix tune2fs checksum failure for mounted filesystem
>
> Better to specify the commit id number. I saw Ted has applied that patch:
>
> https://lore.kernel.org/linux-ext4/162895105421.460437.8931255765382647790.b4-ty@mit.edu/

Thanks. I see the commit id e905fbe3fd0fdb90052f6efdf88f50a78833cfe7
in the above URL. I didn't add it since I'm not sure if this id will
be the final id when the commit is finally merged to the mainline
kernel (Linus tree)?

>
> And maybe you can describe *a little* more in commit log.

Yes I can add a few words in the commit log, but actually I expect the
reader of this test reads the commit message of the mentioned commit
"ext4: Fix tune2fs checksum failure for mounted filesystem", which I
think is more precise.

>
> >
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> > Hi,
> >
> > This is a new regression test for the patch
> >
> > ```
> > ext4: Fix tune2fs checksum failure for mounted filesystem
> >
> > Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
> > removed checksum recalculation after updating superblock free space /
> > inode counters in ext4_fill_super() based on the fact that we will
> > recalculate the checksum on superblock writeout. That is correct
> > assumption but until the writeout happens (which can take a long time)
> > the checksum is incorrect in the buffer cache and if tune2fs is called
> > in that time window it will complain. So return back the checksum
> > recalculation and add a comment explaining the tune2fs peculiarity.
> >
> > Fixes: 81414b4dd48f ("ext4: remove redundant sb checksum recomputation")
> > Reported-by: Boyang Xue <bxue@xxxxxxxxxx>
> > Signed-off-by: Jan Kara <jack@xxxxxxx>
> > ```
> >
> > It's expected to fail on kernels from the kernel-5.11-rc1 to the latest
> > version, where tune2fs fails with:
> >
> > ```
> > tune2fs 1.46.2 (28-Feb-2021)
> > tune2fs: Superblock checksum does not match superblock while trying to
> > open /dev/loop0
> > Couldn't find valid filesystem superblock.
> > ```
> >
> > Please help review this test, Thanks!
> >
> > -Boyang
> >
> >  tests/ext4/309     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/309.out |  2 ++
> >  2 files changed, 44 insertions(+)
> >  create mode 100755 tests/ext4/309
> >  create mode 100644 tests/ext4/309.out
> >
> > diff --git a/tests/ext4/309 b/tests/ext4/309
> > new file mode 100755
> > index 00000000..ae335617
> > --- /dev/null
> > +++ b/tests/ext4/309
> > @@ -0,0 +1,42 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 YOUR NAME HERE.  All Rights Reserved.
>                         ^^^^^^^^^^^^^^
>                        Write your copyright

I will correct it in the next version. Thanks.

>
> > +#
> > +# FS QA Test 309
> > +#
> > +# Test that tune2fs doesn't fail after ext4 shutdown
> > +# Regression test for commit:
> > +# ext4: Fix tune2fs checksum failure for mounted filesystem
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto rw quick
> > +
> > +_cleanup()
> > +{
> > +     _scratch_unmount
> > +}
>
> I think the umount isn't necessary, so the specific _cleanup isn't
> needed either.

The $SCRATCH_DEV was still mounted before this _cleanup(), so I'm
wondering why we shouldn't do _scratch_unmount here? And I see at
least another similar structured test ext4/306 do _scratch_unmount in
_cleanup().

>
> > +
> > +# Import common functions.
> > +. ./common/filter
>
> Do you use any filter helpers below?

No. I will remove this line in my next version.

>
> > +
> > +# real QA test starts here
> > +_supported_fs ext4
>
> I'm wondering if this case can be a generic case, there's nothing
> ext4 specified operations, except this line:
>
> "$TUNE2FS_PROG -l $SCRATCH_DEV"
>
> Hmm... if we can change this line to something likes _get_fs_super(),
> it might help to make this test to be a generic test.

I think this bug is heavily related to "tune2fs", ext4 only. So I
guess an ext4 only test is enough?

>
> > +_require_scratch
> > +_require_scratch_shutdown
> > +_require_command "$TUNE2FS_PROG" tune2fs
> > +
> > +echo "Silence is golden"
> > +
> > +_scratch_mkfs >/dev/null 2>&1
> > +_scratch_mount
> > +echo "ext4/309" > $SCRATCH_MNT/309.tmp
>
> It's sure this case will be "ext4/309", although you use "309" won't
> affect anything.

Yes I can rename it to something like ext4-309.tmp if it looks better.

>
> > +_scratch_shutdown
> > +_scratch_cycle_mount
> > +$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
> > +if [ $? -eq 0 ]; then
> > +     status=0
> > +else
> > +     status=1
> > +fi
>
> Don't need to change the status value, how about write as:
>
> $TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null
>
> The error output will break the golden image directly.

How did you test that? The error output didn't break the "golden
image" in my test.

>
> ( cc ext4 mailist, to get more review)
>
> Thanks,
> Zorro

Thanks for review!

-Boyang

>
> > +
> > +exit
> > diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> > new file mode 100644
> > index 00000000..56330d65
> > --- /dev/null
> > +++ b/tests/ext4/309.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 309
> > +Silence is golden
> > --
> > 2.27.0
> >
>

