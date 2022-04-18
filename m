Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA2505FB5
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiDRWX7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 18:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRWX7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 18:23:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491A29CB4
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 15:21:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23IMKcZP026011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 18:20:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 02FEF15C3EB8; Mon, 18 Apr 2022 18:20:38 -0400 (EDT)
Date:   Mon, 18 Apr 2022 18:20:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Peter Urbanec <linux-ext4.vger.kernel.org@urbanec.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: resize2fs on ext4 leads to corruption
Message-ID: <Yl3kNRflNwH3n8/3@mit.edu>
References: <493bbaea-b0d3-4f8e-20fb-5fb330a128a3@urbanec.net>
 <YlniK5dd1wV2bCXi@mit.edu>
 <f398b938-c7bb-e1f7-2843-86b0adaff4e4@urbanec.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f398b938-c7bb-e1f7-2843-86b0adaff4e4@urbanec.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 18, 2022 at 07:33:38PM +1000, Peter Urbanec wrote:
> First I updated e2fsprogs to 1.46.5 and then tried:
> 
> # e2fsck -f -C 0 -b 32768 -n /dev/md0
> e2fsck 1.46.5 (30-Dec-2021)
> Pass 1: Checking inodes, blocks, and sizes
> Error reading block 32 (Attempt to read block from filesystem resulted in
> short read).  Ignore error? no
> 
> e2fsck: aborted
> 
> Initially things looked promising and there were no errors being reported
> even at 47% of the way through the check. The check terminated at
> approximately the 50% mark with what appears to be a 32-bit overflow issue.

The 32-bit overflow issue is in the reporting of the error.
struct_io_channel's read_error() callback function, which is set to
e2fsck_handle_read_error(), is only called when there is an I/O error
(that's the short read).

So it's not the cause of the failure, but because of that bug, we
don't know what the block number was where the apparently I/O error
was found.  Did you check the system logs to see if there was any
kernel messages that mgiht give us a hint?

Since you built e2fsprogs 1.42.6, can you build it making sure that
debugging symbols are included, and then run the binary out under a
debugger so when you get the error, you can ^C to escape out to the
debugger, and then print the stack trace and step up to see where in
the e2fsck prorgam we were trying to read the block, and what the
block number should have been.  So something like:

./configure CFLAGS=-g ; make ; gdb e2fsck/e2fsck

> Ideally, the `block` member of `struct_io_channel` would be of type
> `unsigned long long`, but changing this may introduce binary compatibility
> issues. As an alternative, it may be prudent to perform an early check for
> the total number of blocks in a file system and refuse to run e2fsck (and
> other tools) if that number would cause an overflow.

Well, what we can do is to add new callback functions which are 64-bit
clean, and new versions of e2fsck can provide both the 32-bit and
64-bit error functions.

Refusing to run is probably a bit extreme, since this merely is a
cosmetic issue, and only when there is an I/O error.

Creating 64-bit clean calllback functions io_channel's read_error()
and write_error() was always part of the plan, and I thought we had
done it already --- but because it was less critical since RAID arrays
never fail ("What never?  Well, hardly ever!"[1]) I just never got around
to it.  :-/

[1] https://gsarchive.net/pinafore/web_opera/pin04.html

> Once I transplant the drives to a 64-bit machine, is there a way I could use
> e2image to create a file that I can use to test whether an e2fsck run will
> work?

An alternative which might be easier would be to create a scratch test
file system, using dm-thin which will allow you to simulate a very
large file system with thin-provisioning[2].  It will only take
(roughly) as much space as you write into it.

[2] https://wiki.archlinux.org/title/LVM#Thin_provisioning

Linux will tend to spread the use of its block groups over the LBA
space, as you start filling it and create a bunch of directories.  So
if you, say, unpack a Linux kernel and then build it, and then unpack
a different Linux kernel version tree in to a different directory
hierarchy and build it, that should be enough to make sure that you
are using a variety of block groups spaced out through the block
device.  You could then try running e2fsck on a 32-bit platform, and
see if you can replicate the problem, and then do an off-line resize,
etc., without risking your data and without requiring a huge amount of
space.

Cheers,

						- Ted
