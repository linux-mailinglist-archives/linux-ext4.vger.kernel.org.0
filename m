Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2A357BC7
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDHFWK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 01:22:10 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:56006 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhDHFWK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 01:22:10 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B22AD82A2C6;
        Thu,  8 Apr 2021 15:21:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lUN75-00FTEE-Nj; Thu, 08 Apr 2021 15:21:55 +1000
Date:   Thu, 8 Apr 2021 15:21:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Message-ID: <20210408052155.GK1990290@dread.disaster.area>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-2-leah.rumancik@gmail.com>
 <YG4lG2B9Wf4t6IfA@gmail.com>
 <YG59GE+8bhtVLOQr@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG59GE+8bhtVLOQr@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=pwG_6AaPxDBl9Fnz-X8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 11:48:40PM -0400, Theodore Ts'o wrote:
> On Wed, Apr 07, 2021 at 02:33:15PM -0700, Eric Biggers wrote:
> > On Wed, Apr 07, 2021 at 03:42:01PM +0000, Leah Rumancik wrote:
> > > Zero out filename and file type fields when file is deleted.
> > 
> > Why?
> 
> Eric is right that we need to have a better explanation in the commit
> description.
> 
> In answer to Eric's question, the problem that is trying to be solved
> here is that if a customer happens to be storing PII in filenames

"if"

Is this purely a hypothetical "if", or is it "we have a customer
that actaully does this"? Because if this is just hypothetical, then
future customers should already be advised and know not to store PII
information in clear text *anywhere* in their systems.

> (e-mail addresses, SSN's, etc.) that they might want to have a
> guarantee that if a file is deleted, the filename and the file's
> contents can be considered as *gone* after some wipeout time period
> has elapsed.  So the use case is every N hours, some system daemon
> will execute FITRIM and FS_IOC_CHKPT_JRNL with the CHKPT_JRNL_DISCARD
> flag set, in order to meet this particular guarantee.

This seems like a better fit for FITRIM than anything else.

Ooohh. We sure do suck at APIs, don't we? FITRIM has no flags field,
so we can't extend that.

But it still makes more sense to me to have something like:

int fstrim(int fd, struct fstrim_range *r, int flags)

syscall where the flags field can indicate that the journal should
be trimmed.

At that point, the "journal checkpoint and flush" is implied by the
fact userspace is asking for the journal to be discarded....

> P.S.  By the way, this is a guarantee that we're going to eventually
> want to care about for XFS as well, since as of COS-85
> (Container-Optimized OS), XFS is supported in Preview Mode.  This
> means that eventually we're going to want submit patches so as to be
> able to support the CHKPT_JRNL_DISCARD flag for FS_IOC_CHKPT_JRNL in
> XFS as well.

Oh, that won't be fun. XFS places a whiteout over the dirent to
indicate that it has been freed, and it does not actually log
anything other than the 4 byte whiteout at the start of the dirent
and the 2 byte XFS_DIR2_DATA_FREE_TAG tag at the end of the dirent.
So zeroing dirents is going to require changing the size and shape
of dirent logging during unlinks...

This will have to be done correclty for all the node merge, split
and compaction cases, too, not just the "remove name" code.

> P.P.S.  We'll also want to have a mount option which supresses file
> names (for example, from ext4_error() messages) from showing up in
> kernel logs, to ease potential privacy concerns with respect to serial
> console and kernel logs.  But that's for another patch set....

This sounds more and more like "Don't encode PII in clear text
anywhere" is a best practice that should be enforced with a big
hammer. Filenames get everywhere and there's no easy way to prevent
that because path lookups can be done by anyone in the kernel. This
so much sounds like you're starting a game of whack-a-mole that can
never be won.

From a security perspective, this is just bad design. Storing PII in
clear text filenames pretty much guarantees that the PII will leak
because it can't be scrubbed/contained within application controlled
boundaries. Trying to contain the spread of filenames within random
kernel subsystems sounds like a fool's errand to me, especially
given how few kernel developers will even know that filenames are
considered sensitive information from a security perspective...

Fundamentally, applications should *never* place PII in clear text
in potentially leaky environments.  The environment for storing PII
should be designed to be secure and free of data leaks from the
ground up. And ext4 has already got this with fscrypt support.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
