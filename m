Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27AC72E9E5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjFMRao (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjFMR3u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 13:29:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E791BD0
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 10:29:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-50-124.bstnma.fios.verizon.net [108.7.50.124])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35DHRoY8026794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 13:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686677272; bh=Ay9GAPPFEWQrFHfZUmwoP9rrvtONEyVwOZ+9AVQQ9uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NltZ0pS5B6ZZ0BjgEvP/Ifm6yHCaFakEnYxhgzPBtYJruJk+G2I+x/18AHBhYC1Kk
         pUounihhUvCvNIUwHsFvQ6U3M8UFkjrA9zwUq+F3Yx/snrc6gMPRZNIo/nL/vaY9gr
         3oWd6Vw5iifRBQQDHw2pGrz80PaENfg7UPiZ5o0Tc3y4B8O4F49ez7kjUkC4sGw+gs
         VlGZB4e2D881OpeeHA1++1yfL/DZfJLsyB/2CFygEtwfrCzj2JsYwPG9NvKBtCg1+0
         j473jiHLAjNM0LCmi/m6Y4U0LldO2BI2Xu0VemGFThOSYtOqoAhR54UmlOqi3tHRN/
         PQsZ138YhhQhA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A49A515C00B0; Tue, 13 Jun 2023 13:27:49 -0400 (EDT)
Date:   Tue, 13 Jun 2023 13:27:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
Message-ID: <20230613172749.GA18303@mit.edu>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
 <20230613043120.GB1584772@mit.edu>
 <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 13, 2023 at 04:13:06PM +0800, Zhihao Cheng wrote:
> 
> Hi Ted, I tried to run './check generic/475' many rounds(1.47.0,
> 5-Feb-2023), and I cannot reproduce the problem with this patch.

What file system configuration (e.g., mke2fs options) were you using
when you ran generic/475?  I reproduced the problem with
CONFIG_LOCKDEP enabled, with the ext4/adv configuration[1], which
means that the file system was created using "mke2fs -t ext4 -O
inline_data,fast_commit".  The size of the test file system was 5 GiB.

[1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/cfg/adv

At this point, it looks like the problem is timing specific.  When I
built at patch 3/6 of your patch series, I was no longer able to
trigger the failure using the CONFIG_LOCKDEP kernel --- specifically
using a kernel config generated using install-kconfig[2] with the
--lockdep command-line-option.

[2] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/install-kconfig

However, when I built a kernel config without --lockdep, I was able to
trigger the problem for both the the ext4/adv and the ext4/ext3[1]
file system test scenario.  That is, doing a full regression test
suite using "gce-xfstests ltm -c ext4/all -g auto", the VM's for the
ext4/adv and ext4/ext3 VM's both hung while running generic/475.  And
using a non-lockdep kernel, the commands "gce-xfstests -c
ext4/adv,ext4/ext3 generic/475" would hang.  I ran this command twice,
to make sure there were no timing-related false negatives, and once we
hung while running generic/475 for ext4/adv, and once we hung while
running ext4/ext3:

% gce-xfstests ls -l
  ...
xfstests-tytso-20230613115748 34.172.36.63 - 6.4.0-rc5-xfstests-00057-ge86f802ab8d4 - 12:07 ext4/adv generic/475 - RUNNING
xfstests-tytso-20230613115802 34.133.66.61 - 6.4.0-rc5-xfstests-00057-ge86f802ab8d4 - 12:06 ext4/ext3 generic/475 - RUNNING

[3] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/cfg/ext3

Furthermore, when I rewond the git repo to just before this patch
series (which is currently at the end of the dev branch), the full
regression test suites ("-c ext4/all -g all") and the more specific
test run ("-C 5 -c ext4/adv,ext4/ext3 generic/475") did not hang.  I
am currently doing another bisect run using a non-lockdep kernel to
see if I can more detail.

> Could you send me a compressed image which can trigger the problem
> with 'fsck -fn'?

Sure.  I'll have to send that under a separate e-mail message, since
it's 15 megabytes.  It was created using "dd if=/dev/mapper/xt-vdc |
gzip -9 > broken-image-which-causes-e2fsck-to-segv.gz".
Unfortunately, I was not able to create a metadata-only dump because
the filesystem was too corrupted.  An attempt to run "e2image -Q
/dev/mapper/xt-vdc broken.qcow2" failed with:

e2image 1.47.0 (5-Feb-2023)
e2image: Corrupt extent header while iterating over inode 6016

I was able to run e2fsck compiled with clang's asan enabled, and
here's the ASAN report (this is against the master branch in
e2fsprogs's git repo, so it's a bit ahead of 1.47.0):

e2fsck 1.47.0 (5-Feb-2023)
=================================================================
==25033==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x625000009900 at pc 0x564bbf8ae405 bp 0x7ffdd82bf0e0 sp 0x7ffdd82be8b0
WRITE of size 4096 at 0x625000009900 thread T0
    #0 0x564bbf8ae404 in pread64 (/build/e2fsprogs-asan/e2fsck/e2fsck+0x24a404) (BuildId: e291b1c8655954ec4293b8635a561dc29c81a785)
    #1 0x564bbfd47532 in raw_read_blk /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/unix_io.c:240:12
    #2 0x564bbfd3965b in unix_read_blk64 /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/unix_io.c:1079:17
    #3 0x564bbfc6cecd in io_channel_read_blk64 /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/io_manager.c:78:10
    #4 0x564bbf9a3791 in e2fsck_pass1_check_symlink /usr/projects/e2fsprogs/e2fsprogs/e2fsck/pass1.c:241:7
    #5 0x564bbfa28a9f in e2fsck_process_bad_inode /usr/projects/e2fsprogs/e2fsprogs/e2fsck/pass2.c:1990:8
    #6 0x564bbfa21e9c in check_dir_block /usr/projects/e2fsprogs/e2fsprogs/e2fsck/pass2.c:1525:8
    #7 0x564bbfa18a3b in check_dir_block2 /usr/projects/e2fsprogs/e2fsprogs/e2fsck/pass2.c:1034:8
    #8 0x564bbfb9ee4a in ext2fs_dblist_iterate3 /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/dblist.c:216:9
    #9 0x564bbfb9ef79 in ext2fs_dblist_iterate2 /usr/projects/e2fsprogs/e2fsprogs/lib/ext2fs/dblist.c:229:9
    #10 0x564bbfa14529 in e2fsck_pass2 /usr/projects/e2fsprogs/e2fsprogs/e2fsck/pass2.c:190:20
    #11 0x564bbf980660 in e2fsck_run /usr/projects/e2fsprogs/e2fsprogs/e2fsck/e2fsck.c:262:3
    #12 0x564bbf95c774 in main /usr/projects/e2fsprogs/e2fsprogs/e2fsck/unix.c:1931:15
    #13 0x7f65d4e4e189 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #14 0x7f65d4e4e244 in __libc_start_main csu/../csu/libc-start.c:381:3
    #15 0x564bbf892840 in _start (/build/e2fsprogs-asan/e2fsck/e2fsck+0x22e840) (BuildId: e291b1c8655954ec4293b8635a561dc29c81a785)

I'm still digging into finding the root cause; I'll let you know if I
find more.

Cheers,

						- Ted



