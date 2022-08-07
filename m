Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15858BBD9
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Aug 2022 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiHGQad (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Aug 2022 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiHGQac (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Aug 2022 12:30:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE4384;
        Sun,  7 Aug 2022 09:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 289C4B80D3B;
        Sun,  7 Aug 2022 16:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E1C433C1;
        Sun,  7 Aug 2022 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659889828;
        bh=6iP6UIJeUhFilY+S9Fs+Z2tz+ZlUbKp9xmJtJ2lNI1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1ZcnRPsMP/+SSwHdbh2YS9oM2oeO87Y9oIahUQ9bubqJKSFl2g4L9xHEGSO3Nhgn
         6qhi13zR/UTk81RxOBsOCzmtt8rh9f5/9D2wuOC7Cx0IYhKRM6iq2atvU0z5INEH0f
         iTlhBv2NeO2Qvqo2JHLtJ0vJliMX40IhGZ2NJIX3FtY+rXobPf2xJsg7kHh43QNhwb
         giHJtdPMDNUVv+a4Ho/sV2C5WIhaatO+MnRrN6NZtPmXdeug4/6eZx/wkp7o49+lD7
         Oq9DgWg30LrSROUCJ8Jx0N87XcNzQE6YPM/t0m7UWKM7fKYrn1GTmrb+w1jS0y2nF2
         QMu1jtZySFcnQ==
Date:   Sun, 7 Aug 2022 09:30:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 0/3] fstests: refactor ext4-specific code
Message-ID: <Yu/opJBYTkgbiIPJ@magnolia>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
 <20220806143606.kd7ikbdjntugcpp4@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806143606.kd7ikbdjntugcpp4@zlang-mailbox>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 06, 2022 at 10:36:06PM +0800, Zorro Lang wrote:
> On Tue, Aug 02, 2022 at 09:21:40PM -0700, Darrick J. Wong wrote:
> > Hi all,
> > 
> > This series aims to make it so that fstests can install device mapper
> > filters for external log devices.  Before we can do that, however, we
> > need to change fstests to pass the device path of the jbd2 device to
> > mount and mkfs.  Before we can do /that/, refactor all the ext4-specific
> > code out of common/rc into a separate common/ext4 file.
> > 
> > If you're going to start using this mess, you probably ought to just
> > pull from my git trees, which are linked below.
> > 
> > This is an extraordinary way to destroy everything.  Enjoy!
> > Comments and questions are, as always, welcome.
> > 
> > --D
> > 
> > fstests git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-ext4-helpers
> > ---
> 
> Hi Darrick,
> 
> There're 3 failures[1] if test ext4 with external logdev, after merging this
> patchset.
> The g/629 is always failed with or without this patchset, it fails if test
> with external logdev.
> The g/250 and g/252 fail due to _scratch_mkfs_sized doesn't use common ext4
> mkfs helper, so can't deal with SCRATCH_LOGDEV well.

Totally different helper, but yes, I'll add that to my list if nothing
else than to get this patchset moving.

--D

> Thanks,
> Zorro
> 
> [1]
> SECTION       -- logdev
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 5.19.0-0.rc2.21.fc37.x86_64+debug #1 SMP PREEMPT_DYNAMIC Mon Jun 13 14:55:18 UTC 2022
> MKFS_OPTIONS  -- -F -J device=/dev/loop0 /dev/sda3
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 -o journal_path=/dev/loop0 /dev/sda3 /mnt/scratch
> 
> generic/250 2s ... - output mismatch (see /root/git/xfstests/results//logdev/generic/250.out.bad)
>     --- tests/generic/250.out   2022-04-29 23:07:23.262498285 +0800
>     +++ /root/git/xfstests/results//logdev/generic/250.out.bad  2022-08-06 22:26:45.179294149 +0800
>     @@ -1,9 +1,19 @@
>      QA output created by 250
>      Format and mount
>     +umount: /mnt/scratch: not mounted.
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/error-test, missing codepage or helper program, or other error.
>     +       dmesg(1) may have more information after failed mount system call.
>      Create the original files
>     +umount: /mnt/scratch: not mounted.
>     ...
>     (Run 'diff -u /root/git/xfstests/tests/generic/250.out /root/git/xfstests/results//logdev/generic/250.out.bad'  to see the entire diff)
> generic/252 2s ... - output mismatch (see /root/git/xfstests/results//logdev/generic/252.out.bad)
>     --- tests/generic/252.out   2022-04-29 23:07:23.264498308 +0800
>     +++ /root/git/xfstests/results//logdev/generic/252.out.bad  2022-08-06 22:26:48.495330525 +0800
>     @@ -1,10 +1,19 @@
>      QA output created by 252
>      Format and mount
>     +umount: /mnt/scratch: not mounted.
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/error-test, missing codepage or helper program, or other error.
>     +       dmesg(1) may have more information after failed mount system call.
>      Create the original files
>     +umount: /mnt/scratch: not mounted.
>     ...
>     (Run 'diff -u /root/git/xfstests/tests/generic/252.out /root/git/xfstests/results//logdev/generic/252.out.bad'  to see the entire diff)
> generic/629 3s ... - output mismatch (see /root/git/xfstests/results//logdev/generic/629.out.bad)
>     --- tests/generic/629.out   2022-04-29 23:07:23.545501491 +0800
>     +++ /root/git/xfstests/results//logdev/generic/629.out.bad  2022-08-06 22:26:50.810355920 +0800
>     @@ -1,4 +1,5 @@
>      QA output created by 629
>     +mke2fs 1.46.5 (30-Dec-2021)
>      test o_sync write
>      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/0
>      test unaligned copy range o_sync
>     ...
>     (Run 'diff -u /root/git/xfstests/tests/generic/629.out /root/git/xfstests/results//logdev/generic/629.out.bad'  to see the entire diff)
> Ran: generic/250 generic/252 generic/629
> Failures: generic/250 generic/252 generic/629
> Failed 3 of 3 tests
> 
> 
> >  common/config |    4 +
> >  common/ext4   |  176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  common/rc     |  177 ++-------------------------------------------------------
> >  common/xfs    |   23 +++++++
> >  4 files changed, 208 insertions(+), 172 deletions(-)
> >  create mode 100644 common/ext4
> > 
> 
