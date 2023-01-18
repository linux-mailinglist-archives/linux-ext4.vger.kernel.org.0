Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A936712F8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 06:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjARFGN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 00:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjARFFo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 00:05:44 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288A53B1C
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 21:05:39 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30I55C9v024121
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 00:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674018314; bh=wi/Y0GbeFdOn5n2j1T9x8Z/B6dNDMoA1AdE3nQZCQxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cF/Sfm/QV8bzyELfAYlr3eDvCc5z70XBewB3YvHXo2HhCoG2AIINpJDdW/2tWTJv6
         N/q5FFaKRCWnuYke0A4rqkrlmo61sJDn3BkVNXQfMo/doGwSIa1Z4bnTZBhWOhYmTv
         eBgKF1tSv6YX1qY07KRAaA+f2l3TJ74S5HiE0WWgPL5sWjAcnF3B/amhRdYyHXfvZC
         q6g0cKMcABmwZZDOrp5slX4pCBCCFqZyCav0vDFJbwQev2d0bMdVr1yVFSvVDgoe/v
         xaMO1c3SClDIcOpPil1eRhS1mOAytCt1i7XcoxybtLV/n8cCM7T6jx1mL47Qhzaq05
         tvTMAOcsAsI0Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C62D815C469B; Wed, 18 Jan 2023 00:05:11 -0500 (EST)
Date:   Wed, 18 Jan 2023 00:05:11 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] resize2fs: resize2fs disk hardlinks will be error
Message-ID: <Y8d+B4RHTkqYpG4g@mit.edu>
References: <9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 04, 2022 at 10:23:52PM +0800, zhanchengbin wrote:
> Resize2fs disk hardlinks which mounting after the same name as tmpfs
>   filesystem it will be error. The items in /proc/mounts are traversed,
> when you get to tmpfs,file!=mnt->mnt_fsname, therefore, the
> stat(mnt->mnt_fsname, &st_buf) branch is used, however, the values of
>   file_rdev and st_buf.st_rdev are the same. As a result, the system
> mistakenly considers that disk is mounted to /root/tmp. As a result
> , resize2fs fails.

Apologies for the delay in getting to this patch.  The original
patch[1] was corrupted (looks like you used Mozilla Thunderbird as
your Mail User Agent, which line-wrapped the patch and thus confused
patchwork[2] as well making it impossible for b4 and git am to handle
the patch).  

[1] https://lore.kernel.org/all/9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com/
[2] http://patchwork.ozlabs.org/project/linux-ext4/patch/9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com/

I also rewrite the commit description to make it more clear:

    libext2fs: add extra checks to ext2fs_check_mount_point()
    
    A pseudo-filesystem, such as tmpfs, can have anything at all in its
    mnt_fsname entry.  Normally, it is just "tmpfs", like this:
    
    tmpfs /tmp tmpfs rw,relatime,inode64 0 0
    ^^^^^
    
    but in a pathological or malicious case, a system administrator can
    specify a block device as its mnt_fsname which is the same as some
    other block device.  For example:
    
    /dev/loop0 /tmp/test-tmpfs tmpfs rw,relatime,inode64 0 0
    ^^^^^^^^^^
    /dev/loop0 /tmp/test-mnt ext4 rw,relatime 0 0
    
    In this case, ext2fs_check_mount_point() may erroneously return
    that the mountpoint for the file system on /dev/loop0 is mounted on
    /tmp/test-tmpfs, instead of the correct /tmp/test-mnt.  This causes
    problems for resize2fs, since in order to do an online resize, it
    needs to open the directory where the file system is mounted, and
    trigger the online resize ioctl.  If it opens the incorrect directory,
    then resize2fs will fail.
    
    So we need to add some additional checking to make sure that
    directory's st_dev matches the block device's st_rdev field.
    
    An example shell script which reproduces the problem fixed by this
    commit is as follows:
    
       loop_file=/tmp/foo.img
       tmpfs_dir=/tmp/test-tmpfs
       mnt_dir=/tmp/test-mnt
    
       mkdir -p $tmpfs_dir $mnt_dir
       dd if=/dev/zero of=$loop_file bs=1k count=65536
       test_dev=$(losetup --show -f $loop_file)
       mke2fs -t ext4 -F -b 1024 $test_dev 32768
       mount -t tmpfs $test_dev $tmpfs_dir  # create the evil /proc/mounts entry
       mount -t ext4 $test_dev $mnt_dir
       ln -f ${test_dev} ${test_dev}-ln
       resize2fs ${test_dev}-ln
    
    [ Fixed up the corrupted patch and rewrote the commit description to
      be more clear -- tytso ]
    
    Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
    Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

As you can see, the best commit description describes *why* a
particular change is needed, and gives the background so the reader
can understand what problem is being fixed.  The one-line change makes
it clear that the change is to libext2fs's ismounted.c, and *not* to
resize2fs, although you were making this bug to fix resize2fs after a
system administrator did something non-standard and/or malicious.

Also note how I rewrote the reproducer to be simpler and more
portable.

Cheers,

						- Ted
