Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B022E93D
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgG0JkW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 05:40:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgG0JkW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jul 2020 05:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595842820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eGNKVSaWBsryr+mw9Gv4VOI3pjdDzqJvaMvODmtoIc=;
        b=WsrYJnsmg2Ymmsl8o9LEKDF9DJ4kmC3KczAgYxFT/ksR7XJMOlaXPUScnZCcs06xeTW+3G
        Ciq1qCPNGYKI/pd1dCtoBFuc65GL/ZCzQL4UUOEcvkEw+gMxxUbEOcxAIJCRpJsyCNlEmZ
        aCxZBMGCXh/4yXbe/Rq9Upc8WaxVgkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Ft3MquGqPsKIUiwN9g-gGw-1; Mon, 27 Jul 2020 05:40:17 -0400
X-MC-Unique: Ft3MquGqPsKIUiwN9g-gGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A295C89CD1C;
        Mon, 27 Jul 2020 09:40:05 +0000 (UTC)
Received: from work (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BEDC5C1D3;
        Mon, 27 Jul 2020 09:40:04 +0000 (UTC)
Date:   Mon, 27 Jul 2020 11:40:00 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/309: Test read-only external journal device
Message-ID: <20200727094000.zy3k2x47iy5phvwd@work>
References: <20200717105544.3201-1-lczerner@redhat.com>
 <20200726150208.GI2557159@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726150208.GI2557159@desktop>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jul 26, 2020 at 11:02:08PM +0800, Eryu Guan wrote:
> [cc ext4 list for ext4 specific test]
> 
> On Fri, Jul 17, 2020 at 12:55:44PM +0200, Lukas Czerner wrote:
> > We should never be able to mount ext4 file system read-write with
> > read-only external journal device. Test it.
> > 
> > The test was based on generic/050.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> Is there a patch or kernel commit that fixes this test failure? I'd be
> better to mention the patch in either commit log or test description, so
> others could know where is the fix easily.
> 
> > ---
> >  tests/ext4/309     | 135 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/309.out |  32 +++++++++++
> 
> And use next available seq slot under ext4 dir, use
> "./tools/nextid ext4" to get the next available slot, which is 002 at
> this point.
> 
> >  tests/ext4/group   |   1 +
> >  3 files changed, 168 insertions(+)
> >  create mode 100755 tests/ext4/309
> >  create mode 100644 tests/ext4/309.out
> > 
> > diff --git a/tests/ext4/309 b/tests/ext4/309
> > new file mode 100755
> > index 00000000..356044c4
> > --- /dev/null
> > +++ b/tests/ext4/309
> > @@ -0,0 +1,135 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2009 Christoph Hellwig.
> > +# Copyright (c) 2020 Lukas Czerner.
> > +#
> > +# FS QA Test No. 309
> > +#
> > +# Copied from tests generic/050 and adjusted to support testing
> > +# read-only external journal device on ext4.
> > +#
> > +# Check out various mount/remount/unmount scenarious on a read-only
> > +# logdev blockdev.
> > +#
> > +seqfull=$0
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	blockdev --setrw $SCRATCH_LOGDEV
> 
> Do 'blockdev --setrw $SCRATCH_DEV' here as well to make sure both LOGDEV
> and SCRATCH_DEV are set back to rw mode.
> 
> > +}
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> 
> _supported_fs ext4
> 
> Otherwise looks fine to me.

Thans Eryu,

I'll resend with the changes you pointed out.

-Lukas

> 
> Thanks,
> Eryu
> 
> > +_supported_os Linux
> > +
> > +_require_scratch_nocheck
> > +_require_scratch_shutdown
> > +_require_logdev
> > +_require_local_device $SCRATCH_DEV
> > +_require_local_device $SCRATCH_LOGDEV
> > +_require_norecovery
> > +
> > +_scratch_mkfs >/dev/null 2>&1
> > +_require_metadata_journaling $SCRATCH_DEV
> > +
> > +#
> > +# Mark the log device read-only
> > +#
> > +echo "setting log device read-only"
> > +blockdev --setro $SCRATCH_LOGDEV
> > +
> > +#
> > +# Mount it, and make sure we can't write to it, and we can unmount it again
> > +#
> > +echo "mounting with read-only log device:"
> > +_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
> > +if [ "${PIPESTATUS[0]}" -eq 0 ]; then
> > +	echo "touching file on read-only filesystem (should fail)"
> > +	touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> > +fi
> > +
> > +echo "unmounting read-only filesystem"
> > +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> > +
> > +echo "setting log device read-write"
> > +blockdev --setrw $SCRATCH_LOGDEV
> > +
> > +echo "mounting with read-write log device:"
> > +_try_scratch_mount 2>&1 | _filter_scratch
> > +
> > +echo "touch files"
> > +touch $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
> > +
> > +echo "going down:"
> > +_scratch_shutdown -f
> > +
> > +echo "unmounting shutdown filesystem:"
> > +_scratch_unmount 2>&1 | _filter_scratch
> > +
> > +echo "setting log device read-only"
> > +blockdev --setro $SCRATCH_LOGDEV
> > +
> > +#
> > +# Mounting a filesystem that requires log-recovery fails even with
> > +# -o norecovery unless the fs device is read only or it's mounted
> > +# read only
> > +#
> > +echo "mounting filesystem that needs recovery with a read-only log device:"
> > +_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
> > +
> > +echo "unmounting read-only filesystem"
> > +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> > +
> > +
> > +echo "mounting filesystem with -o norecovery with a read-only log device:"
> > +_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount | _filter_scratch
> > +echo "unmounting read-only filesystem"
> > +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> > +
> > +#
> > +# This is the way out if the log device really is read-only.
> > +# Doesn't mean it's a good idea in practice, more a last resort
> > +# data recovery hack. Either the underlying fs device needs
> > +# to be read only as well, or we mount the file system read only
> > +#
> > +echo "setting fs device read-only"
> > +blockdev --setro $SCRATCH_DEV
> > +echo "mounting filesystem with -o norecovery with a read-only fs and log device:"
> > +_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount | _filter_scratch
> > +echo "unmounting read-only filesystem"
> > +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> > +echo "setting fs device read-write"
> > +blockdev --setrw $SCRATCH_DEV
> > +
> > +echo "mounting filesystem with -o norecovery,ro with a read-only log device:"
> > +_try_scratch_mount -o norecovery,ro 2>&1 | _filter_ro_mount | _filter_scratch
> > +echo "unmounting read-only filesystem"
> > +_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
> > +
> > +echo "setting log device read-write"
> > +blockdev --setrw $SCRATCH_LOGDEV
> > +
> > +#
> > +# But log recovery is performed when mount with -o ro as long as
> > +# the underlying device is not write protected.
> > +#
> > +echo "mounting filesystem that needs recovery with -o ro:"
> > +_try_scratch_mount -o ro 2>&1 | _filter_scratch
> > +
> > +# success, all done
> > +echo "*** done"
> > +rm -f $seqres.full
> > +status=0
> > diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> > new file mode 100644
> > index 00000000..4b7e136a
> > --- /dev/null
> > +++ b/tests/ext4/309.out
> > @@ -0,0 +1,32 @@
> > +QA output created by 309
> > +setting log device read-only
> > +mounting with read-only log device:
> > +mount: device write-protected, mounting read-only
> > +touching file on read-only filesystem (should fail)
> > +touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
> > +unmounting read-only filesystem
> > +setting log device read-write
> > +mounting with read-write log device:
> > +touch files
> > +going down:
> > +unmounting shutdown filesystem:
> > +setting log device read-only
> > +mounting filesystem that needs recovery with a read-only log device:
> > +mount: device write-protected, mounting read-only
> > +mount: cannot mount device read-only
> > +unmounting read-only filesystem
> > +umount: SCRATCH_DEV: not mounted
> > +mounting filesystem with -o norecovery with a read-only log device:
> > +mount: SCRATCH_MNT: wrong fs type, bad option, bad superblock on SCRATCH_DEV, missing codepage or helper program, or other error
> > +unmounting read-only filesystem
> > +umount: SCRATCH_DEV: not mounted
> > +setting fs device read-only
> > +mounting filesystem with -o norecovery with a read-only fs and log device:
> > +mount: device write-protected, mounting read-only
> > +unmounting read-only filesystem
> > +setting fs device read-write
> > +mounting filesystem with -o norecovery,ro with a read-only log device:
> > +unmounting read-only filesystem
> > +setting log device read-write
> > +mounting filesystem that needs recovery with -o ro:
> > +*** done
> > diff --git a/tests/ext4/group b/tests/ext4/group
> > index a1adc553..5e80e480 100644
> > --- a/tests/ext4/group
> > +++ b/tests/ext4/group
> > @@ -56,3 +56,4 @@
> >  306 auto rw resize quick
> >  307 auto ioctl rw defrag
> >  308 auto ioctl rw prealloc quick defrag
> > +309 shutdown mount auto quick
> > -- 
> > 2.21.3
> 

