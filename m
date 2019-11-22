Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809F8105DE4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2019 02:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKVBAf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 20:00:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38732 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726038AbfKVBAf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Nov 2019 20:00:35 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAM10RVK030247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 20:00:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 90BC94202FD; Thu, 21 Nov 2019 20:00:26 -0500 (EST)
Date:   Thu, 21 Nov 2019 20:00:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: simulate various I/O and checksum errors when
 reading metadata
Message-ID: <20191122010026.GK4262@mit.edu>
References: <20191121183036.29385-1-tytso@mit.edu>
 <20191121183036.29385-2-tytso@mit.edu>
 <20191122000933.GG6213@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122000933.GG6213@magnolia>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 21, 2019 at 04:09:33PM -0800, Darrick J. Wong wrote:
> > +static inline int ext4_simulate_fail(struct super_block *sb,
> > +				     unsigned long flag)
> 
> Nit: bool?

Sure, I'll do this for the next version.

> If I'm reading this correctly, this means that userspace sets a
> s_simulate_fail bit via sysfs knob, and the next time the filesystem
> calls ext4_simulate_fail with the same bit set in @flag we'll return
> true to say "simulate the failure" and clear the bit in s_simulate_fail?
> 
> IOWs, the simulated failures have to be re-armed every time?

Yes, that's correct.

> Seems reasonable, but consider the possibility that in the future it
> might be useful if you could set up periodic failures (e.g. directory
> lookups fail 10% of the time) so that you can see how something like
> fsstress reacts to less-predictable failures?

So in theory, we could do that with dm_flakey --- but that's a pain in
the tuckus, since you have to specify the LBA for the directory blocks
that you might want to have fail.  I implemented this so I could have
a quick and dirty way of testing the first patch in this series (and
in fact, I found a bug in the first version of the previous patch, so
I'm glad I spent the time to implement the test patch :-).

What might be interesting to do is some kind of eBPF hook where we
pass in the block #, inode #, and metadata type, and the ePBF program
could do use a much more complex set of criteria in terms of whether
or not to trigger an EIO, or how to fuzz a particular block to either
force a CRC failure, or to try to find bugs ala Hydra[1] (funded via a
Google Faculty Research Award grant), but using a much more glass-box
style test approach.

[1] https://gts3.org/~sanidhya/pubs/2019/hydra.pdf

This would be a lot more work, and I'm not sufficiently up to speed
with eBPF, and I just needed a quick and dirty testing scheme.

The reason why I think it's worthwhile to land this patch (as opposed
to throwing it away after doing the development work for the previous
patch) is that it's a relatively small set of changes, and all of the
code disappears if CONFIG_DEBUG_EXT4 is not enabled.  So it has no
performance cost on production kernels, and it's highly unlikely that
users would have a reason to use this feature on production use cases,
so ripping this out if and when we have a more functional eBPF testing
infrastructure to replace it shouldn't really be a problem.

					- Ted

P.S.  A fascinating question is whether we could make the hooks for
this hypothetical eBPF hook general enough that it could work for more
than just ext4, but for other file systems.  The problem is that the
fs metadata types are not going to be same across different file
systems, so that makes the API design quite tricky; and perhaps not
worth it?

