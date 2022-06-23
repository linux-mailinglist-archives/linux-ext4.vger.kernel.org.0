Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97499558985
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jun 2022 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiFWTry (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jun 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFWTrb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jun 2022 15:47:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743062BFE
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 12:43:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25NJheXo029956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 15:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656013422; bh=f9kP7d+LVtoJ9jdj2xgz38+cUOG4Nol9jHgTgXy6BUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Yj3cR3eK5jAlK/nW0KyHPCZCTvOxoeE4O2ydGn5fa+IN/KBg9nSVi9HMqEVnh8X0t
         MAv8AazG20waxZI2LdLY1F67Xddwbm/2WtuF95AQa69Oll5dz7mym0g262RRFQO0Jt
         e61rPyiq0f/jxFKPWEbhA4ZNlvZAi5Vg//Zgg3IqKPqaP7198FG9UxdhDdBv8KkqDA
         ilmtizIwXzwsFDQ/LafQw3cjuDQy7ty0V7KCYEQiTpkrZ8BZazqfpKuP8GVm1/2ce5
         Pyi2+oceDwIbH8bjJSiT+fxiT603ZC/LHFArAzJRq2FNEwlBxZUJKbI2O8GNkHMuvW
         GL7mAsuLXRtWg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D1BFD15C42F6; Thu, 23 Jun 2022 15:43:40 -0400 (EDT)
Date:   Thu, 23 Jun 2022 15:43:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Santosh S <santosh.letterz@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: Overwrite faster than fallocate
Message-ID: <YrTCbPK94Ejh4ei3@mit.edu>
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
 <Yqz8a0ggTjIU3h7T@mit.edu>
 <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
 <117682F9-5CEF-44F2-935E-E048C8A9D75D@dilger.ca>
 <CAGQ4T_LM9kYSHNWW+wJdXUzq7Ymf1+RGmot1Rqz9fChZBeRcAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGQ4T_LM9kYSHNWW+wJdXUzq7Ymf1+RGmot1Rqz9fChZBeRcAA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 23, 2022 at 02:28:47PM -0400, Santosh S wrote:
> 
> What kind of write will stop an uninitialized extent from splitting?
> For example, I want to create a file, fallocate 512MB, and zero-fill
> it. But I want the file system to only create 4 extents so they all
> reside in the inode itself, and each extent represents the entire
> 128MB (so no splitting).

If you write into an unitialized extent, it *has* to be split, since
we have to record what has been initialized, and what has not.  So for
example:

root@kvm-xfstests:/vdc# fallocate  -l 1M test-file
root@kvm-xfstests:/vdc# filefrag -vs test-file
Filesystem type is: ef53
File size of test-file is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     255:      68864..     69119:    256:             last,unwritten,eof
test-file: 1 extent found
root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=1 seek=10
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000252186 s, 16.2 MB/s
root@kvm-xfstests:/vdc# filefrag -vs test-file
Filesystem type is: ef53
File size of test-file is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       9:      68864..     68873:     10:             unwritten
   1:       10..      10:      68874..     68874:      1:            
   2:       11..     255:      68875..     69119:    245:             last,unwritten,eof
test-file: 1 extent found

However, if you write to an adjacent block, the extent will get split
--- and then we will merge it to the initialized block.  So for
example, if we write to block 9:

root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=1 seek=9
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000205357 s, 19.9 MB/s
root@kvm-xfstests:/vdc# filefrag -vs test-file
Filesystem type is: ef53
File size of test-file is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       8:      68864..     68872:      9:             unwritten
   1:        9..      10:      68873..     68874:      2:            
   2:       11..     255:      68875..     69119:    245:             last,unwritten,eof
test-file: 1 extent found

So if you eventually write all of the blocks, because of the split and
the merging behavior, eventually the extent tree will be put into an efficient state:

root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=9 seek=0
    ...
root@kvm-xfstests:/vdc# filefrag -vs test-file
Filesystem type is: ef53
File size of test-file is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      10:      68864..     68874:     11:            
   1:       11..     255:      68875..     69119:    245:             last,unwritten,eof
test-file: 1 extent found
root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=240 seek=11
    ...
root@kvm-xfstests:/vdc# filefrag -vs test-file
Filesystem type is: ef53
File size of test-file is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     250:      68864..     69114:    251:            
   1:      251..     255:      69115..     69119:      5:             last,unwritten,eof
test-file: 1 extent found
root@kvm-xfstests:/vdc# dd if=/dev/zero of=test-file bs=1k conv=notrunc bs=4k count=5 seek=251
    ...
root@kvm-xfstests:/vdc# filefrag -vs test-file
Filesystem type is: ef53
File size of test-file is 1048576 (256 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     255:      68864..     69119:    256:             last,eof
test-file: 1 extent found
root@kvm-xfstests:/vdc# 

Bottom-line, there isn't just splitting, but there is also merging
going on.  So it's not really something that you need to worry about.

Cheers,

						- Ted
