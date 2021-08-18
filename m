Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0C3F0984
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 18:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhHRQro (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 12:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhHRQrm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Aug 2021 12:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629305227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5EMDaBSS5HzmiNPWEKc0iOPORvOXEl3+TZF63XoNJAo=;
        b=Pf1hMfCpzdQX9RDSmY1KmEl3axxDt5HKBziNVRe9QS/N9tyhqcVqorz78I+xxYDTQCDjnE
        R1EoL1OsAv9TQBcdQ9778XF3N9XHkXiK1tPJFKKCjQC3tkePcwVZZ3uGFbyXR4w1b90LGq
        CXN67kOKTMqtdWjT/SXQTe6NdbmuFOc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-nwGdO6iAOUq7cjH0p5-v8A-1; Wed, 18 Aug 2021 12:47:06 -0400
X-MC-Unique: nwGdO6iAOUq7cjH0p5-v8A-1
Received: by mail-pj1-f69.google.com with SMTP id s1-20020a17090a948100b001795fab0f86so4934130pjo.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Aug 2021 09:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5EMDaBSS5HzmiNPWEKc0iOPORvOXEl3+TZF63XoNJAo=;
        b=VxfprTdpCN2s7MPkn4w+2sOFjkn1OBcGBd4WRn+j9QLeCifTEZDT4dP5l8rw4heseZ
         2Y1ANxLgJkysLlIJrC/HEFlBrWMSo1w5nFMB7K+XIMAlTnBr72ORqzFwWFiaOvs86mqP
         k6Mnj30zTBnh7AAlADFz5JycXenZVAu2qeG7Vuzr8hUBWfifXyB/yoiis3CGk8cCw1Lp
         +VO38lwSoEpDLgdEgynk96b3+8hqVg6G1Mun0L97GO3XrEuxmcDs9MTjpCn4RjXSIC8Y
         QGZLuTSLqUjRqP+BGgbuHYUe+YRD+heSr+VR5cmwaGBOnc5yCIKtKm6LUWu4R7lYFrVH
         C9ww==
X-Gm-Message-State: AOAM531U8GCi7CkHWzhE76e7EsW3HR545ZiTtSdFonzUFKilirCrApSG
        RDzOY//ltLD3u1fXyOGnO1aQLQiPXHwWXWg5NVEZEfGZ8DcJDumj5NHR3VdFfUHootjSW2APJJB
        MwKLK2DmTlPrbjKtXLNiSgQ==
X-Received: by 2002:a17:90a:ce16:: with SMTP id f22mr10438399pju.90.1629305225109;
        Wed, 18 Aug 2021 09:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCuI3PJut6Eb/buRKPP5ycb6HPQI40y40bIPTZSqFkwKmy2DRY3bjesThG21eezItP+gT5uA==
X-Received: by 2002:a17:90a:ce16:: with SMTP id f22mr10438375pju.90.1629305224876;
        Wed, 18 Aug 2021 09:47:04 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y19sm288935pfe.71.2021.08.18.09.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:47:04 -0700 (PDT)
Date:   Thu, 19 Aug 2021 00:59:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boyang Xue <bxue@redhat.com>
Cc:     fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: regression test for "tune2fs -l" after ext4
 shutdown
Message-ID: <20210818165942.cdse6punqcawqmft@fedora>
Mail-Followup-To: Boyang Xue <bxue@redhat.com>, fstests@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
References: <20210818084126.4167799-1-bxue@redhat.com>
 <20210818114517.kqvfzu2vd45vuhze@fedora>
 <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 18, 2021 at 09:20:44PM +0800, Boyang Xue wrote:
> Hi Zorro,
> 
> On Wed, Aug 18, 2021 at 7:32 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 04:40:56PM +0800, bxue@redhat.com wrote:
> > > From: Boyang Xue <bxue@redhat.com>
> > >
> > > Regression test for:
> > >
> > > ext4: Fix tune2fs checksum failure for mounted filesystem
> >
> > Better to specify the commit id number. I saw Ted has applied that patch:
> >
> > https://lore.kernel.org/linux-ext4/162895105421.460437.8931255765382647790.b4-ty@mit.edu/
> 
> Thanks. I see the commit id e905fbe3fd0fdb90052f6efdf88f50a78833cfe7
> in the above URL. I didn't add it since I'm not sure if this id will
> be the final id when the commit is finally merged to the mainline
> kernel (Linus tree)?
> 
> >
> > And maybe you can describe *a little* more in commit log.
> 
> Yes I can add a few words in the commit log, but actually I expect the
> reader of this test reads the commit message of the mentioned commit
> "ext4: Fix tune2fs checksum failure for mounted filesystem", which I
> think is more precise.
> 
> >
> > >
> > > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > > ---
> > > Hi,
> > >
> > > This is a new regression test for the patch
> > >
> > > ```
> > > ext4: Fix tune2fs checksum failure for mounted filesystem
> > >
> > > Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
> > > removed checksum recalculation after updating superblock free space /
> > > inode counters in ext4_fill_super() based on the fact that we will
> > > recalculate the checksum on superblock writeout. That is correct
> > > assumption but until the writeout happens (which can take a long time)
> > > the checksum is incorrect in the buffer cache and if tune2fs is called
> > > in that time window it will complain. So return back the checksum
> > > recalculation and add a comment explaining the tune2fs peculiarity.
> > >
> > > Fixes: 81414b4dd48f ("ext4: remove redundant sb checksum recomputation")
> > > Reported-by: Boyang Xue <bxue@xxxxxxxxxx>
> > > Signed-off-by: Jan Kara <jack@xxxxxxx>
> > > ```
> > >
> > > It's expected to fail on kernels from the kernel-5.11-rc1 to the latest
> > > version, where tune2fs fails with:
> > >
> > > ```
> > > tune2fs 1.46.2 (28-Feb-2021)
> > > tune2fs: Superblock checksum does not match superblock while trying to
> > > open /dev/loop0
> > > Couldn't find valid filesystem superblock.
> > > ```
> > >
> > > Please help review this test, Thanks!
> > >
> > > -Boyang
> > >
> > >  tests/ext4/309     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/309.out |  2 ++
> > >  2 files changed, 44 insertions(+)
> > >  create mode 100755 tests/ext4/309
> > >  create mode 100644 tests/ext4/309.out
> > >
> > > diff --git a/tests/ext4/309 b/tests/ext4/309
> > > new file mode 100755
> > > index 00000000..ae335617
> > > --- /dev/null
> > > +++ b/tests/ext4/309
> > > @@ -0,0 +1,42 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 YOUR NAME HERE.  All Rights Reserved.
> >                         ^^^^^^^^^^^^^^
> >                        Write your copyright
> 
> I will correct it in the next version. Thanks.
> 
> >
> > > +#
> > > +# FS QA Test 309
> > > +#
> > > +# Test that tune2fs doesn't fail after ext4 shutdown
> > > +# Regression test for commit:
> > > +# ext4: Fix tune2fs checksum failure for mounted filesystem
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto rw quick
> > > +
> > > +_cleanup()
> > > +{
> > > +     _scratch_unmount
> > > +}
> >
> > I think the umount isn't necessary, so the specific _cleanup isn't
> > needed either.
> 
> The $SCRATCH_DEV was still mounted before this _cleanup(), so I'm
> wondering why we shouldn't do _scratch_unmount here? And I see at
> least another similar structured test ext4/306 do _scratch_unmount in
> _cleanup().

The SCRATCH_DEV will be umounted, don't need to do that in the end of each
test cases, except you need to do something on the unmounted SCRATCH_DEV
in the end.

I don't know why ext4/306 has that, maybe due to old reason, or we didn't
notice/care that when we reviewed it? And it's not worth sending a patch
just for removing this "not wrong but just redundant" line now. Except a
patch trys to cleanup all _cleanup().

> 
> >
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> >
> > Do you use any filter helpers below?
> 
> No. I will remove this line in my next version.
> 
> >
> > > +
> > > +# real QA test starts here
> > > +_supported_fs ext4
> >
> > I'm wondering if this case can be a generic case, there's nothing
> > ext4 specified operations, except this line:
> >
> > "$TUNE2FS_PROG -l $SCRATCH_DEV"
> >
> > Hmm... if we can change this line to something likes _get_fs_super(),
> > it might help to make this test to be a generic test.
> 
> I think this bug is heavily related to "tune2fs", ext4 only. So I
> guess an ext4 only test is enough?

Just checking. That's fine for me to keep this case as an ext4 only case.

> 
> >
> > > +_require_scratch
> > > +_require_scratch_shutdown
> > > +_require_command "$TUNE2FS_PROG" tune2fs
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +_scratch_mkfs >/dev/null 2>&1
> > > +_scratch_mount
> > > +echo "ext4/309" > $SCRATCH_MNT/309.tmp
> >
> > It's sure this case will be "ext4/309", although you use "309" won't
> > affect anything.
> 
> Yes I can rename it to something like ext4-309.tmp if it looks better.

I think something likes: echo "This is a test" > $SCRATCH_MNT/testfile
is good enough, don't need the "ext4" or "309" things.

> 
> >
> > > +_scratch_shutdown
> > > +_scratch_cycle_mount
> > > +$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
> > > +if [ $? -eq 0 ]; then
> > > +     status=0
> > > +else
> > > +     status=1
> > > +fi
> >
> > Don't need to change the status value, how about write as:
> >
> > $TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null
> >
> > The error output will break the golden image directly.
> 
> How did you test that? The error output didn't break the "golden
> image" in my test.

[root@xx-xxxx-xx xfstests-dev]# ./check ext4/309
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 xx-xxxx-xx 5.14.0-rc4-xfs #14 SMP Thu Aug 12 00:56:07 CST 2021
MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch

ext4/309 5s ... - output mismatch (see /root/git/xfstests-dev/results//ext4/309.out.bad)
    --- tests/ext4/309.out      2021-08-18 18:17:15.925427714 +0800
    +++ /root/git/xfstests-dev/results//ext4/309.out.bad        2021-08-19 00:17:57.001648868 +0800
    @@ -1,2 +1,4 @@
     QA output created by 309
     Silence is golden
    +/usr/sbin/tune2fs: Superblock checksum does not match superblock while trying to open /dev/mapper/testvg-scratchdev
    +Couldn't find valid filesystem superblock.
    ...
    (Run 'diff -u /root/git/xfstests-dev/tests/ext4/309.out /root/git/xfstests-dev/results//ext4/309.out.bad'  to see the entire diff)
Ran: ext4/309
Failures: ext4/309
Failed 1 of 1 tests

[root@xx-xxxx-xx xfstests-dev]# git diff
...
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
-echo "ext4/309" > $SCRATCH_MNT/309.tmp
+echo "This is a test" > $SCRATCH_MNT/testfile
 _scratch_shutdown
-_scratch_cycle_mount
-$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
-if [ $? -eq 0 ]; then
-       status=0
-else
-       status=1
-fi
+_scratch_cycle_mount 
+$TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null
 
+status=0
 exit


Thanks,
Zorro

> 
> >
> > ( cc ext4 mailist, to get more review)
> >
> > Thanks,
> > Zorro
> 
> Thanks for review!
> 
> -Boyang
> 
> >
> > > +
> > > +exit
> > > diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> > > new file mode 100644
> > > index 00000000..56330d65
> > > --- /dev/null
> > > +++ b/tests/ext4/309.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 309
> > > +Silence is golden
> > > --
> > > 2.27.0
> > >
> >
> 

