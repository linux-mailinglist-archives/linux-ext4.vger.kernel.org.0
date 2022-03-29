Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4538E4EAE23
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiC2NJ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiC2NJz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 09:09:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D8EFABD3
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 06:08:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22TD84Jg011551
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 09:08:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 658BB15C3ECA; Tue, 29 Mar 2022 09:08:04 -0400 (EDT)
Date:   Tue, 29 Mar 2022 09:08:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Fariya F <fariya.fatima03@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: df returns incorrect size of partition due to huge overhead
 block count in ext4 partition
Message-ID: <YkMEtJkiR2Qktq9s@mit.edu>
References: <CACA3K+i8nZRBxeTfdy7Uq5LHAsbZEHTNati7-RRybsj_4ckUyw@mail.gmail.com>
 <Yj4+IqC6FPzEOhcW@mit.edu>
 <CACA3K+hAnJESkkm9q6wHQLHRkML_8D1pMKquqqW7gfLH_QpXng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACA3K+hAnJESkkm9q6wHQLHRkML_8D1pMKquqqW7gfLH_QpXng@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Removing linux-fsdevel from the cc list since this is an ext4
specific issue.)

On Mon, Mar 28, 2022 at 09:38:18PM +0530, Fariya F wrote:
> Hi Ted,
> 
> Thanks for the response. Really appreciate it. Some questions:
> 
> a) This issue is observed on one of the customer board and hence a fix
> is a must for us or at least I will need to do a work-around so other
> customer boards do not face this issue. As I mentioned my script
> relies on df -h output of used percentage. In the case of the board
> reporting 16Z of used space and size, the available space is somehow
> reported correctly. Should my script rely on available space and not
> on the used space% output of df. Will that be a reliable work-around?
> Do you see any issue in using the partition from then or some where
> down the line the overhead blocks number would create a problem and my
> partition would end up misbehaving or any sort of data loss could
> occur? Data loss would be a concern for us. Please guide.

I'm guessing that the problem was caused by a bit-flip in the
superblock, so it was just a matter of hardware error.  What version
of e2fsprogs are using, and did you have metadata checksum (meta_csum)
feature enabled?  Depending on where the bit-flip happened --- e.g.,
whether it was in memory and then superblock was written out, or on
the eMMC or other storage device --- if the metadata checksum feature
caught the superblock error, it would have detected the issue, and
while it would have required a manual fsck to fix it, at that point it
would have fallen back to use the backup superblock version.

> b) Any other suggestions of a work-around so even if the overhead
> blocks reports more blocks than actual blocks on the partition, i am
> able to use the partition reliably or do you think it would be a
> better suggestion to wait for the fix in e2fsprogs?
> 
> I think apart from the fix in e2fsprogs tool, a kernel fix is also
> required, wherein it performs check that the overhead blocks should
> not be greater than the actual blocks on the partition.

Yes, we can certainly have the kernel check to see if the overhead
value is completely insane, and if so, recalculate it (even though it
would slow down the mount).

Another thing we could do is to always recaluclate the overhead amount
if the file system is smaller than some arbitrary size, on the theory
that (a) for small file systems, the increased time to mount the file
system will not be noticeable, and (b) embedded and mobile devices are
often where "cost optimized" (my polite way of saying crappy quality
to save a pentty or two in Bill of Materials costs) are most likely,
and so those are where bit flips are more likely.

Cheers,

						- Ted
