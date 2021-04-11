Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094735B183
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Apr 2021 06:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhDKEZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Apr 2021 00:25:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51209 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229452AbhDKEZi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Apr 2021 00:25:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13B4P4f6013673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Apr 2021 00:25:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DE76B15C3B12; Sun, 11 Apr 2021 00:25:03 -0400 (EDT)
Date:   Sun, 11 Apr 2021 00:25:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     riteshh <riteshh@linux.ibm.com>, adilger@dilger.ca,
        linux-ext4@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, baoyou.xie@alibaba-inc.com
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
Message-ID: <YHJ6H8hClqlrAouQ@mit.edu>
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
 <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
 <0e0c2283-5eb9-e121-35b2-61dbccc8203b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0c2283-5eb9-e121-35b2-61dbccc8203b@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 11, 2021 at 03:45:01AM +0800, Wen Yang wrote:
> At this time, some logs are lost. It is suspected that the hard disk itself
> is faulty.

If you have a kernel crash dump, that means you can extract out the
dmesg buffer, correct?  Is there any I/O error messages in the kernel
log?

What is the basis of the suspicion that the hard drive is faulty?
Kernel dmesg output?  Error reporting from smartctl?

> There are many hard disks on our server. Maybe we should not occupy 100% CPU
> for a long time just because one hard disk fails.

It depends on the nature of the hard drive failure.  How is it
failing?

One thing which we do need to be careful about is when focusing on how
to prevent a failure caused by some particular (potentially extreme)
scenarios, that we don't cause problems on more common scenarios (for
example a heavily loaded server, and/or a case where the file system
is almost full where we have multiple files "fighting" over a small
number of free blocks).

In general, my attitude is that the best way to protect against hard
drive failures is to have processes which are monitoring the health of
the system, and if there is evidence of a failed drive, that we
immediately kill all jobs which are relying on that drive (which we
call "draining" a particular drive), and/or if a sufficiently large
percentage of the drives have failed, or the machine can no longer do
its job, to automatically move all of those jobs to other servers
(e.g., "drain" the server), and then send the machine to some kind of
data center repair service, where the failed hard drives can be
replaced.

I'm skeptical of attempts to try to make the file system to somehow
continue to be able to "work" in the face of hard drive failures,
since failures can be highly atypical, and what might work well in one
failure scenario might be catastrophic in another.  It's especially
problematic if the HDD is not explcitly signalling an error condition,
but rather being slow (because it's doing a huge number of retries),
or the HDD is returning data which is simply different from what was
previously written.  The best we can do in that case is to detect that
something is wrong (this is where metadata checksums would be very
helpful), and then either remount the file system r/o, or panic the
machine, and/or signal to userspace that some particular file system
should be drained.

Cheers,

						- Ted
