Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A773F131D
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhHSGKW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 02:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230016AbhHSGKV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Aug 2021 02:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629353385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bftUwMn67t07VNHKcAxxGtkkSNCtgiuM69e3eUcq0wA=;
        b=cT1IHN0egQMoDto55fhCNiHeblCjulpHfUeJZuRakMsdlGxqKvg237dyHgQY2ikfJpP/2e
        L/0E7hIr3yH+i49M4TJcFoAHXEknskfGazg6ffofXVlPqUlgA6c96Y8547mNszRxW25max
        NS0CIqhFdQpLOefmP35FPMJZIGt9nGw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-UYm9rKSENzmfOT6Or2FoUw-1; Thu, 19 Aug 2021 02:09:43 -0400
X-MC-Unique: UYm9rKSENzmfOT6Or2FoUw-1
Received: by mail-pg1-f199.google.com with SMTP id q23-20020a6562570000b029023cbfb4fd73so2876657pgv.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Aug 2021 23:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bftUwMn67t07VNHKcAxxGtkkSNCtgiuM69e3eUcq0wA=;
        b=KhSQWte1eDSwkP31vQioKGrfvX4cBVDe9h8eSN94+TBkbHG+Dyv34uJYh3BT9+sqjw
         sDwUXlslhBMaYGpAvxoOixwRwmifTgfd/PK6wkPL0T1EW/NsLRdiaBKFKHUdbDN5MCeo
         R09y5P3I3sVfLUi+DiVJLrn3+cX5wEvYqKy7xAY6WRO2CLT8ZMF+8S70IpxRz5ACQ34b
         cBeARz/cehVhMApW3+AnTagnTme46rwCDEvKJBKHrMqhFSxjfORcHA9I6LsTPY+aCKqd
         oHIWJCHbJIZvFnMFyzvThzQGh0h5dhi32GqdRhxeUFNzilkWuEIX+F0Jbt8E66Dd0IDo
         /ItA==
X-Gm-Message-State: AOAM530GkJYGaC/9RlHrYPY89LwvtUyzA9/f6xIAoAeWMNRVr6Orh92N
        V940lbN02e09UtFW5Hh5ypqGmTvpgDKD1C+zQGg1xKmMu1LqEr5p50swYAaCDUSpGCFZyRf6snt
        Rj9S0QaBokaBG+14+Jr9hfA==
X-Received: by 2002:a17:902:c40d:b0:12d:97e1:e19b with SMTP id k13-20020a170902c40d00b0012d97e1e19bmr10537211plk.45.1629353382081;
        Wed, 18 Aug 2021 23:09:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyidW8kzpyvAeNsKSbqw0BIbk5FhYmExrRIRTgXU35VykW5Q38jXCg8b4fOoaC4nXFzv42nTQ==
X-Received: by 2002:a17:902:c40d:b0:12d:97e1:e19b with SMTP id k13-20020a170902c40d00b0012d97e1e19bmr10537187plk.45.1629353381745;
        Wed, 18 Aug 2021 23:09:41 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b190sm2143212pgc.91.2021.08.18.23.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 23:09:41 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:30:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boyang Xue <bxue@redhat.com>
Cc:     fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: regression test for "tune2fs -l" after ext4
 shutdown
Message-ID: <20210819063019.4kzimy3q5rkusql6@fedora>
Mail-Followup-To: Boyang Xue <bxue@redhat.com>, fstests@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
References: <20210818084126.4167799-1-bxue@redhat.com>
 <20210818114517.kqvfzu2vd45vuhze@fedora>
 <CAHLe9YZcuo2K6ELT0p1c6sfzwkSgikeiyNect4phEoCt8vTPXw@mail.gmail.com>
 <20210818165942.cdse6punqcawqmft@fedora>
 <CAHLe9YbdZrYH3E4U60KufrVKvcDf9O4Ow1ugg2HPgSSw6NvctA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YbdZrYH3E4U60KufrVKvcDf9O4Ow1ugg2HPgSSw6NvctA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 19, 2021 at 01:48:55PM +0800, Boyang Xue wrote:
> Zorro,
> 
> Please check my reply inline below.
> 
> On Thu, Aug 19, 2021 at 12:47 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 09:20:44PM +0800, Boyang Xue wrote:
> > > Hi Zorro,
> > >
> > > On Wed, Aug 18, 2021 at 7:32 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Wed, Aug 18, 2021 at 04:40:56PM +0800, bxue@redhat.com wrote:
> > > > > From: Boyang Xue <bxue@redhat.com>
> > > > >
> > > > > Regression test for:
> > > > >
> > > > > ext4: Fix tune2fs checksum failure for mounted filesystem
> > > >
> > > > Better to specify the commit id number. I saw Ted has applied that patch:
> > > >
> > > > https://lore.kernel.org/linux-ext4/162895105421.460437.8931255765382647790.b4-ty@mit.edu/
> > >
> > > Thanks. I see the commit id e905fbe3fd0fdb90052f6efdf88f50a78833cfe7
> > > in the above URL. I didn't add it since I'm not sure if this id will
> > > be the final id when the commit is finally merged to the mainline
> > > kernel (Linus tree)?
> > >
> > > >
> > > > And maybe you can describe *a little* more in commit log.
> > >
> > > Yes I can add a few words in the commit log, but actually I expect the
> > > reader of this test reads the commit message of the mentioned commit
> > > "ext4: Fix tune2fs checksum failure for mounted filesystem", which I
> > > think is more precise.
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > > > > ---
> > > > > Hi,
> > > > >
> > > > > This is a new regression test for the patch
> > > > >
> > > > > ```
> > > > > ext4: Fix tune2fs checksum failure for mounted filesystem
> > > > >
> > > > > Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
> > > > > removed checksum recalculation after updating superblock free space /
> > > > > inode counters in ext4_fill_super() based on the fact that we will
> > > > > recalculate the checksum on superblock writeout. That is correct
> > > > > assumption but until the writeout happens (which can take a long time)
> > > > > the checksum is incorrect in the buffer cache and if tune2fs is called
> > > > > in that time window it will complain. So return back the checksum
> > > > > recalculation and add a comment explaining the tune2fs peculiarity.
> > > > >
> > > > > Fixes: 81414b4dd48f ("ext4: remove redundant sb checksum recomputation")
> > > > > Reported-by: Boyang Xue <bxue@xxxxxxxxxx>
> > > > > Signed-off-by: Jan Kara <jack@xxxxxxx>
> > > > > ```
> > > > >
> > > > > It's expected to fail on kernels from the kernel-5.11-rc1 to the latest
> > > > > version, where tune2fs fails with:
> > > > >
> > > > > ```
> > > > > tune2fs 1.46.2 (28-Feb-2021)
> > > > > tune2fs: Superblock checksum does not match superblock while trying to
> > > > > open /dev/loop0
> > > > > Couldn't find valid filesystem superblock.
> > > > > ```
> > > > >
> > > > > Please help review this test, Thanks!
> > > > >
> > > > > -Boyang
> > > > >
> > > > >  tests/ext4/309     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/ext4/309.out |  2 ++
> > > > >  2 files changed, 44 insertions(+)
> > > > >  create mode 100755 tests/ext4/309
> > > > >  create mode 100644 tests/ext4/309.out
> > > > >
> > > > > diff --git a/tests/ext4/309 b/tests/ext4/309
> > > > > new file mode 100755
> > > > > index 00000000..ae335617
> > > > > --- /dev/null
> > > > > +++ b/tests/ext4/309
> > > > > @@ -0,0 +1,42 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2021 YOUR NAME HERE.  All Rights Reserved.
> > > >                         ^^^^^^^^^^^^^^
> > > >                        Write your copyright
> > >
> > > I will correct it in the next version. Thanks.
> > >
> > > >
> > > > > +#
> > > > > +# FS QA Test 309
> > > > > +#
> > > > > +# Test that tune2fs doesn't fail after ext4 shutdown
> > > > > +# Regression test for commit:
> > > > > +# ext4: Fix tune2fs checksum failure for mounted filesystem
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto rw quick
> > > > > +
> > > > > +_cleanup()
> > > > > +{
> > > > > +     _scratch_unmount
> > > > > +}
> > > >
> > > > I think the umount isn't necessary, so the specific _cleanup isn't
> > > > needed either.
> > >
> > > The $SCRATCH_DEV was still mounted before this _cleanup(), so I'm
> > > wondering why we shouldn't do _scratch_unmount here? And I see at
> > > least another similar structured test ext4/306 do _scratch_unmount in
> > > _cleanup().
> >
> > The SCRATCH_DEV will be umounted, don't need to do that in the end of each
> > test cases, except you need to do something on the unmounted SCRATCH_DEV
> > in the end.
> >
> > I don't know why ext4/306 has that, maybe due to old reason, or we didn't
> > notice/care that when we reviewed it? And it's not worth sending a patch
> > just for removing this "not wrong but just redundant" line now. Except a
> > patch trys to cleanup all _cleanup().
> 
> OK. I will remove the _cleanup() in my next version, unless someone
> else has other opinions.
> 
> >
> > >
> > > >
> > > > > +
> > > > > +# Import common functions.
> > > > > +. ./common/filter
> > > >
> > > > Do you use any filter helpers below?
> > >
> > > No. I will remove this line in my next version.
> > >
> > > >
> > > > > +
> > > > > +# real QA test starts here
> > > > > +_supported_fs ext4
> > > >
> > > > I'm wondering if this case can be a generic case, there's nothing
> > > > ext4 specified operations, except this line:
> > > >
> > > > "$TUNE2FS_PROG -l $SCRATCH_DEV"
> > > >
> > > > Hmm... if we can change this line to something likes _get_fs_super(),
> > > > it might help to make this test to be a generic test.
> > >
> > > I think this bug is heavily related to "tune2fs", ext4 only. So I
> > > guess an ext4 only test is enough?
> >
> > Just checking. That's fine for me to keep this case as an ext4 only case.
> >
> > >
> > > >
> > > > > +_require_scratch
> > > > > +_require_scratch_shutdown
> > > > > +_require_command "$TUNE2FS_PROG" tune2fs
> > > > > +
> > > > > +echo "Silence is golden"
> > > > > +
> > > > > +_scratch_mkfs >/dev/null 2>&1
> > > > > +_scratch_mount
> > > > > +echo "ext4/309" > $SCRATCH_MNT/309.tmp
> > > >
> > > > It's sure this case will be "ext4/309", although you use "309" won't
> > > > affect anything.
> > >
> > > Yes I can rename it to something like ext4-309.tmp if it looks better.
> >
> > I think something likes: echo "This is a test" > $SCRATCH_MNT/testfile
> > is good enough, don't need the "ext4" or "309" things.
> 
> OK. I will modify it to
> 
> echo "This is a test" > $SCRATCH_MNT/testfile
> 
> Unless someone else has other preferences.
> 
> >
> > >
> > > >
> > > > > +_scratch_shutdown
> > > > > +_scratch_cycle_mount
> > > > > +$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
> > > > > +if [ $? -eq 0 ]; then
> > > > > +     status=0
> > > > > +else
> > > > > +     status=1
> > > > > +fi
> > > >
> > > > Don't need to change the status value, how about write as:
> > > >
> > > > $TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null
> > > >
> > > > The error output will break the golden image directly.
> > >
> > > How did you test that? The error output didn't break the "golden
> > > image" in my test.
> >
> > [root@xx-xxxx-xx xfstests-dev]# ./check ext4/309
> > FSTYP         -- ext4
> > PLATFORM      -- Linux/x86_64 xx-xxxx-xx 5.14.0-rc4-xfs #14 SMP Thu Aug 12 00:56:07 CST 2021
> > MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
> > MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch
> >
> > ext4/309 5s ... - output mismatch (see /root/git/xfstests-dev/results//ext4/309.out.bad)
> >     --- tests/ext4/309.out      2021-08-18 18:17:15.925427714 +0800
> >     +++ /root/git/xfstests-dev/results//ext4/309.out.bad        2021-08-19 00:17:57.001648868 +0800
> >     @@ -1,2 +1,4 @@
> >      QA output created by 309
> >      Silence is golden
> >     +/usr/sbin/tune2fs: Superblock checksum does not match superblock while trying to open /dev/mapper/testvg-scratchdev
> >     +Couldn't find valid filesystem superblock.
> >     ...
> >     (Run 'diff -u /root/git/xfstests-dev/tests/ext4/309.out /root/git/xfstests-dev/results//ext4/309.out.bad'  to see the entire diff)
> > Ran: ext4/309
> > Failures: ext4/309
> > Failed 1 of 1 tests
> >
> > [root@xx-xxxx-xx xfstests-dev]# git diff
> > ...
> >  _scratch_mkfs >/dev/null 2>&1
> >  _scratch_mount
> > -echo "ext4/309" > $SCRATCH_MNT/309.tmp
> > +echo "This is a test" > $SCRATCH_MNT/testfile
> >  _scratch_shutdown
> > -_scratch_cycle_mount
> > -$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
> > -if [ $? -eq 0 ]; then
> > -       status=0
> > -else
> > -       status=1
> > -fi
> > +_scratch_cycle_mount
> > +$TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null
> >
> > +status=0
> >  exit
> 
> Unless I missed something, I would say that, tune2fs' error output
> went to .out.bad just because you had modified the tune2fs line from
> mine:
> 
> $TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
> 
> to yours:
> 
> $TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null

Yes, I've metioned that in my first reply above.

> 
> My original version redirecting stderr and stdout both to $seqres.full
> doesn't break the "golden output". Test log:
> ```
> [root@kvm102 repo_xfstests]# ./check ext4/309
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 kvm102 5.14.0-0.rc4.35.xx.x86_64 #1 SMP
> Tue Aug 3 13:02:44 EDT 2021
> MKFS_OPTIONS  -- -b 1024 /dev/vda3
> MOUNT_OPTIONS -- -o acl,user_xattr -o
> context=system_u:object_r:root_t:s0 /dev/vda3 /scratch
> 
> ext4/309        [failed, exit status 1]
> Ran: ext4/309
> Failures: ext4/309
> Failed 1 of 1 tests
> [root@kvm102 repo_xfstests]# cat results/ext4/309.full
> /usr/sbin/tune2fs: Superblock checksum does not match superblock while
> trying to open /dev/vda3
> Couldn't find valid filesystem superblock.
> tune2fs 1.46.2 (28-Feb-2021)
> [root@kvm102 repo_xfstests]# ls results/ext4/309.out.bad
> ls: cannot access 'results/ext4/309.out.bad': No such file or directory
> ```
> 
> As far as I can understand, there're at least two approaches to mark a
> test pass or fail in xfstests:
> 1) Compare the output of the test with the "golden output" (i.e.
> 309.out), I guess this is the approach you mentioned.
> 2) Exit the test with the value of $status (i.e. status=0 - pass,
> status=non-zero - fail)
> 
> I'm using the 2) here, not using 1) with the output of tune2fs
> compared with the 309.out, because the output of tune2fs can be
> different in different runs. An example output of a successful tune2fs
> run is like (sorry for this long paste):
> ```

You can
[1]
$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full
status=0
exit

Or:
[2]
$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
if [ $? -ne 0 ];then
	echo "Fail to get superblock from SCRATCH_DEV"
fi
status=0
exit

Or:
[3]
$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1 || exit
status=0
exit

Or:
[4]
$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1 && status=0
exit

I perfer the 1st one, most xfstests cases fail by breaking golden image.
I just showed my review points, anyway I don't mind if maintainer would like
to choose anyone else :)

Thanks,
Zorro


> [root@kvm101 repo_xfstests]# cat results/ext4/309.full
> tune2fs 1.45.6 (20-Mar-2020)
> Filesystem volume name:   <none>
> Last mounted on:          /scratch
> Filesystem UUID:          22975090-96d7-49ee-9b4f-ee6afe046219
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index
> filetype needs_recovery extent 64bit flex_bg sparse_super large_file
> huge_file dir_nlink extra_isize metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              720896
> Block count:              11534336
> Reserved block count:     576716
> Free blocks:              11280570
> Free inodes:              720884
> First block:              1
> Block size:               1024
> Fragment size:            1024
> Group descriptor size:    64
> Reserved GDT blocks:      256
> Blocks per group:         8192
> Fragments per group:      8192
> Inodes per group:         512
> Inode blocks per group:   128
> Flex block group size:    16
> Filesystem created:       Thu Aug 19 05:45:26 2021
> Last mount time:          Thu Aug 19 05:45:26 2021
> Last write time:          Thu Aug 19 05:45:26 2021
> Mount count:              2
> Maximum mount count:      -1
> Last checked:             Thu Aug 19 05:45:26 2021
> Check interval:           0 (<none>)
> Lifetime writes:          462 kB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               256
> Required extra isize:     32
> Desired extra isize:      32
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      f5af5862-d415-460b-9a6b-97584578600f
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0x0f5b9c13
> ```
> 
> Thanks,
> Boyang
> 
> >
> >
> > Thanks,
> > Zorro
> >
> > >
> > > >
> > > > ( cc ext4 mailist, to get more review)
> > > >
> > > > Thanks,
> > > > Zorro
> > >
> > > Thanks for review!
> > >
> > > -Boyang
> > >
> > > >
> > > > > +
> > > > > +exit
> > > > > diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> > > > > new file mode 100644
> > > > > index 00000000..56330d65
> > > > > --- /dev/null
> > > > > +++ b/tests/ext4/309.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 309
> > > > > +Silence is golden
> > > > > --
> > > > > 2.27.0
> > > > >
> > > >
> > >
> >
> 

