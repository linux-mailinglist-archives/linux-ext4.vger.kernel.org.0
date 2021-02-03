Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F84E30D347
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 07:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBCGEt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 01:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhBCGEo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 01:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612332196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvpGsbkKZ5ZqBJhULce8QgNUCZOPStu186xjkvdKAHI=;
        b=SK3faJSVx9XWdPY6EtqkaMyB4BQnF3gtq5vuRi6b6p8Zp2laKd/N+IgNEjq3Yze2YLsFMW
        8EbAyWmdk+hdX8e/YmrZP5PGP4lEGoLTTos8dJ2g28yq2jAiIm2wXHHr/bxwcb/d1B0V1J
        5MC0uSKYrjhdOM36HSWH2Ovq2KWiNdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-tMFlCkl1NfmutGOlzA_hKQ-1; Wed, 03 Feb 2021 01:03:15 -0500
X-MC-Unique: tMFlCkl1NfmutGOlzA_hKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DE26107ACE3;
        Wed,  3 Feb 2021 06:03:13 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8E266EF45;
        Wed,  3 Feb 2021 06:03:12 +0000 (UTC)
Date:   Wed, 3 Feb 2021 14:20:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org,
        tytso@mit.edu, yangerkun@huawei.com
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH v3] ext4: Add a test for rename with
 RENAME_WHITEOUT
Message-ID: <20210203062019.GD14354@localhost.localdomain>
Mail-Followup-To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org,
        tytso@mit.edu, yangerkun@huawei.com, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20210202123956.3146761-1-sunke32@huawei.com>
 <20210202160527.GB14354@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202160527.GB14354@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 03, 2021 at 12:05:27AM +0800, Zorro Lang wrote:
> On Tue, Feb 02, 2021 at 08:39:56PM +0800, Sun Ke wrote:
> > Fill the disk space, try to create some files and rename a file, mount
> > again, list directory contents and triggers some errors. It is a
> > regression test for kernel commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for
> > rename with RENAME_WHITEOUT")
> > 
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > ---
> > v3: use _check_dmesg_for() and modify the group.
> > ---
> 
> I helped to re-write this case(without loopdev, dmesg check and ext4 specific
> things) as below[1]. It can reproduce that bug[2], and test passed on fixed
> kernel[3].
> 
> But I found another problem, we can't 100% make sure that renameat2 hit ENOSPC,
> even if we can't create any empty file. That renameat2 line still succeed on
> my XFS test. And Eric Sandeen even can't trigger that rename ENOSPC on his
> machine.
> 
> I think we still need to find a better(stable) way to trigger that rename ENOSPC.
> Let me think about that more. If I take all available inodes, not data space,
> can it help to reproduce this bug? Let's try.

No, looks like that doesn't help. Taking all available inodes can make sure the
renameat2 hit ENOSPC 100%, but can't trigger that ext4 bug. I think it might
return ENOSPC early before running into the code we want to test.

Hmm... is there another better idea to make sure renameat2(RENAME_WHITEOUT) a single
file hit ENOSPC? How about create and rename a chunk of inodes together? Maybe
that's better to trigger ENOSPC, refer to [1].

I can't be sure what's the best number, 64? 128? or bigger? I just tried 64,
it can trigger ENOSPC in my XFS and ext4 test.

CC some fs experts to get more suggestions.

Thanks,
Zorro

[1]
for ((i=0; i<128; i++));do
        touch $SCRATCH_MNT/srcfile$i
done
nr_free_ino=$(stat -f -c '%d' $SCRATCH_MNT)
nr_free=$(stat -f -c '%f' $SCRATCH_MNT)
blksz="$(_get_block_size $SCRATCH_MNT)"
_fill_fs $((nr_free * blksz)) $SCRATCH_MNT/fill_space $blksz 0 >> $seqres.full 2>&1
#for ((i=0; i<nr_free_ino; i++));do
#       touch $SCRATCH_MNT/fill_file$i
#done
for ((i=0; i<nr_free_ino; i++));do
        touch $SCRATCH_MNT/fill_file$i 2>/dev/null
        if [ $? -ne 0 ];then
                break
        fi
done
_scratch_cycle_mount

# ENOSPC is expected here
for ((i=0; i<128; i++));do
        $here/src/renameat2 -w $SCRATCH_MNT/srcfile$i $SCRATCH_MNT/dstfile$i 2>/dev/null
done
_scratch_cycle_mount
# Expect no error at here
for ((i=0; i<128; i++));do
        ls -l $SCRATCH_MNT/srcfile$i >/dev/null
done

> 
> Thanks,
> Zorro
> 
> 
> [1]
> # cat tests/generic/623
> ...
> ...
> # get standard environment, filters and checks
> . ./common/rc
> . ./common/filter
> . ./common/populate
> 
> # remove previous $seqres.full before test
> rm -f $seqres.full
> 
> # real QA test starts here
> 
> # Modify as appropriate.
> _supported_fs generic
> _require_scratch
> 
> _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> _scratch_mount
> 
> touch $SCRATCH_MNT/srcfile
> nr_free=$(stat -f -c '%f' $SCRATCH_MNT)
> blksz="$(_get_block_size $SCRATCH_MNT)"
> _fill_fs $((nr_free * blksz)) $SCRATCH_MNT/fill_space $blksz 0 >> $seqres.full 2>&1
> for ((i=0; i<10000; i++));do
>         touch $SCRATCH_MNT/fill_file$i 2>/dev/null
>         # Until no more files can be created
>         if [ $? -ne 0 ];then
>                 break
>         fi
> done
> # ENOSPC is expected here
> $here/src/renameat2 -w $SCRATCH_MNT/srcfile $SCRATCH_MNT/dstfile
> _scratch_cycle_mount
> # Expect no error at here
> ls -l $SCRATCH_MNT/srcfile >/dev/null
> 
> # success, all done
> status=0
> exit
> 
> # cat tests/generic/623.out
> QA output created by 623
> No space left on device
> 
> [2]
>  ./check generic/623
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 5.10.0-rc5-xfs+ #4 SMP Tue Jan 5 20:12:45 CST 2021
> MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch
> 
> generic/623     _check_generic_filesystem: filesystem on /dev/mapper/testvg-scratchdev is inconsistent
> (see /root/git/xfstests-dev/results//generic/623.full for details)
> - output mismatch (see /root/git/xfstests-dev/results//generic/623.out.bad)
>     --- tests/generic/623.out   2021-02-02 21:52:35.292886600 +0800
>     +++ /root/git/xfstests-dev/results//generic/623.out.bad     2021-02-02 21:52:45.866960245 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 623
>      No space left on device
>     +ls: cannot access '/mnt/scratch/srcfile': Structure needs cleaning
>     ...
>     (Run 'diff -u /root/git/xfstests-dev/tests/generic/623.out /root/git/xfstests-dev/results//generic/623.out.bad'  to see the entire diff)
> Ran: generic/623
> Failures: generic/623
> Failed 1 of 1 tests
> 
> [3]
> # ./check generic/623
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 localhost 5.11.0-0.rc5.20210128git76c057c84d28.137.fc34.x86_64 #1 SMP Thu Jan 28 21:10:47 UTC 2021
> MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch
> 
> generic/623 4s ...  4s
> Ran: generic/623
> Passed all 1 tests
> 
> >  tests/ext4/048     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/048.out |  3 +++
> >  tests/ext4/group   |  1 +
> >  3 files changed, 82 insertions(+)
> >  create mode 100755 tests/ext4/048
> >  create mode 100644 tests/ext4/048.out
> > 
> > diff --git a/tests/ext4/048 b/tests/ext4/048
> > new file mode 100755
> > index 00000000..b8e3ddee
> > --- /dev/null
> > +++ b/tests/ext4/048
> > @@ -0,0 +1,78 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
> > +#
> > +# FS QA Test 048
> > +#
> > +# This is a regression test for kernel patch:
> > +# commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for rename with RENAME_WHITEOUT")
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs ext4
> > +_require_scratch
> > +_require_xfs_io_command "falloc"
> > +
> > +dmesg -c > /dev/null
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_scratch_mount >> $seqres.full 2>&1
> > +
> > +testdir=$SCRATCH_MNT
> > +cd ${testdir}
> > +
> > +mkdir test
> > +$XFS_IO_PROG -f -c "falloc 0 128M" img >> $seqres.full
> > +$MKFS_EXT4_PROG  img > /dev/null 2>&1
> > +$MOUNT_PROG img test
> > +
> > +# fill the disk space
> > +dd if=/dev/zero of=test/foo bs=1M count=128 > /dev/null 2>&1
> > +
> > +# create 1000 files, not all the files will be created successfully
> > +mkdir test/dir
> > +cd test/dir
> > +for ((i = 0; i < 1000; i++))
> > +do
> > +	touch file$i > /dev/null 2>&1
> > +done
> > +
> > +# try to rename, but now no space left on device
> > +$here/src/renameat2 -w $testdir/test/dir/file1 $testdir/test/dir/dst_file
> > +
> > +cd $testdir
> > +$UMOUNT_PROG test
> > +$MOUNT_PROG img test
> > +ls -l test/dir/file1 > /dev/null 2>&1
> > +$UMOUNT_PROG test
> > +
> > +# Did we get the kernel warning?
> > +warn_str='deleted inode referenced'
> > +_check_dmesg_for "${warn_str}" || echo "Good! dmesg do not show \"${warn_str}\"."
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/ext4/048.out b/tests/ext4/048.out
> > new file mode 100644
> > index 00000000..db7ac373
> > --- /dev/null
> > +++ b/tests/ext4/048.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 048
> > +No space left on device
> > +Good! dmesg do not show "deleted inode referenced".
> > diff --git a/tests/ext4/group b/tests/ext4/group
> > index ceda2ba6..22a00f91 100644
> > --- a/tests/ext4/group
> > +++ b/tests/ext4/group
> > @@ -50,6 +50,7 @@
> >  045 auto dir
> >  046 auto prealloc quick
> >  047 auto quick dax
> > +048 auto rename quick
> >  271 auto rw quick
> >  301 aio auto ioctl rw stress defrag
> >  302 aio auto ioctl rw stress defrag
> > -- 
> > 2.13.6
> > 
> 

