Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41072750CE0
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jul 2023 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjGLPnp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jul 2023 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGLPno (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jul 2023 11:43:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD31BE4
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jul 2023 08:43:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36CFgnKr029953
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 11:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689176571; bh=xsSByqbmsyoJkMRqqgRv3PByRRncH+lqoJ2s5dNBnC8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=UVy94ReRlS5gg9SoabcTJpMMzShGL/9GHrmEqeC9c6/DvE1YH8bx8DqTlDDqHhnOY
         dZk9I4MZoh8xQEjiOKUCEBtO4O1oT2dnVHvBZleyGemPC8sv6kMkQ+71BXbP5JvRuu
         LBy7cQGweS+9ZgRIsaXPLTqKrKsCCw92FGcGGHJuohGvG/dNNSSekVtj9v3Bl1z04x
         n50DvWGBV+dA7FfdFe+TjzcjWEwFQ7CdfNSS7FhMbUacQJ2I0+qwEx0+TDbGsro51I
         YYFW8xz3Vnh7Kx/uiO7sLomLFi0dv3rsfceWYiN+u0xj0CsVFiDonJSipre8qBzMIa
         eOzG+VS3l96Ow==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0844915C0280; Wed, 12 Jul 2023 11:42:49 -0400 (EDT)
Date:   Wed, 12 Jul 2023 11:42:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
        linfeilong <linfeilong@huawei.com>, louhongxiang@huawei.com,
        liuzhiqiang26@huawei.com, Ye Bin <yebin@huaweicloud.com>
Subject: Re: [bug report] tune2fs: filesystem inconsistency occurs by
 concurrent write
Message-ID: <20230712154249.GA3675593@mit.edu>
References: <29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com>
 <20230626021758.GF8954@mit.edu>
 <4e647e9b-4f2f-b89f-6825-838f22c4bf2e@huawei.com>
 <20230704193357.GG1178919@mit.edu>
 <84a1a21a-be09-f70d-1d1b-234c706ddf14@huawei.com>
 <20230712000511.GA11427@frogsfrogsfrogs>
 <4a3ac0da-69cf-e282-dc56-aefaa0e90718@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3ac0da-69cf-e282-dc56-aefaa0e90718@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 12, 2023 at 05:06:31PM +0800, zhanchengbin wrote:
> > ...at a cost of racing with the mounted fs, which might be updating the
> > superblock at the same time; and prohibiting the kernel devs from
> > closing the "scribble on mounted bdev" attack surface.
> 
> Regardless of whether I am modifying a single byte or the entire
> buffer_head, there will always be a situation of contention with the kernel
> lock, You can take a look at ext4_update_superblocks_fn which calls
> lock_buffer.

Many/most of the fields that tune2fs will need to modify are ones
which the kernel never needs to modify.  So no locking will be
necessary, and so long as you are using the journal, we don't need to
worry about an invalid checksum getting written to the disk.

There might be races with buffered reads to the superblock, but those
races exist today.  E2fsprogs has a way of dealing this where if the
checksum is invalid, it will just sleep and retry.  Another way of
dealing with is to use an O_DIRECT read to the superblock.

Longer-term, we may want to have a EXT4_IOC_GET_SUPERBLOCK ioctl, at
which point we may need to have some kind of new kernel locking ----
or we can just take a snapshot of the superblock, and check to see the
checksum is valid; if not, it can just retry the snapshot.

> What I am more concerned about is that the superblock needs to be
> synchronized to the memory before being saved to the disk. Otherwise, during
> the ext4_commit_super process, outdated data may be saved to the disk.

As I've noted above, this is already not a problem if journalling is
enabled.  If journalling is not enabled, it's possible that an invalid
superblock is written to disk.  This can sort of happen already, if
you have an orphan list update racing with an ext4_error() update to
the superblock.  It's a debateable point how much we should care,
since if you don't have journalling enabled, on a crash the file
system may be corrupted in many situations, and so we will need to use
fsck.ext4 anyway.  If there is only a single superblock, then fsck
might not have a fallback superblock to use, but arguably that's a
corner case.

> The program perceives that the superblock has been modified
> successfully, and the value of the modified superblock is saved on
> disk in ext4_update_primary_sb, but there is no guarantee whether
> the super block is saved in journal on the disk or whether it is
> checkpointed.

So in actual practice, e2fsprogs will replay the journal and then
reread the superblock.  So if you change the max_mounts_count via
tune2fs -c (even though very few systems use that these days, and it's
largely a deprecated feature), so long as the transaction has been
committed, the superblock update will be honored by e2fsck.

I'm not sure we care *all* that much, but if we really want to make
sure things like tune2fs -c will always "take" after a crash, we can
simply have the ioctl force a journal commit before returning.

> If the super block has not been saved in journal on
> the disk and the system crashes, the modification of the super block
> may be overwritten when the journal recover; similarly, this problem
> will also occur for the translation that has not been checkpointed;
> Both of these scenarios are not perceptible to user process unless
> there is a backup mechanism implemented in user mode.

We now *always* update the superblock through the journal.  We only
fall back to a direct update of the superblock if the journal is not
present, or the journal has aborted due to some kind of fundamental
failure (so that the ext4_error can be written out before we reboot
the system or force the file system to be read-only).

> Moreover, the method of rerunning the program cannot resolve the conflicting
> racing condition between the two ioctls.

These ioctls are quite rarely used, and it's a problem we have today
if we have two racing tune2fs commands.  By having the kernel handle
it, so long as the two ioctls are modifying different superblock
fields, both ioctl updates will happen --- where as today, when we
have two racing tune2fs, one of the tune2fs updates could be
completely lost.  This has been true for decades in ext2, ext3, and
ext4, and no one has actually reported this as a problem.

Cheers,


