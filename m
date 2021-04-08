Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E432F358D76
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhDHTZu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 15:25:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48232 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231940AbhDHTZt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 15:25:49 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 138JPU1Y005174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Apr 2021 15:25:31 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C81315C3B12; Thu,  8 Apr 2021 15:25:30 -0400 (EDT)
Date:   Thu, 8 Apr 2021 15:25:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Message-ID: <YG9YqkHfslwAdh2/@mit.edu>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-2-leah.rumancik@gmail.com>
 <YG4lG2B9Wf4t6IfA@gmail.com>
 <YG59GE+8bhtVLOQr@mit.edu>
 <20210408052155.GK1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408052155.GK1990290@dread.disaster.area>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 03:21:55PM +1000, Dave Chinner wrote:
> "if"
> 
> Is this purely a hypothetical "if", or is it "we have a customer
> that actaully does this"? Because if this is just hypothetical, then
> future customers should already be advised and know not to store PII
> information in clear text *anywhere* in their systems.

Customers might not even know if they are doing this.  The concern
they have is that when they are doing "lift and shift", and moving
their workloads from their private data center to the cloud, they
would have no idea what might be lurking in their legacy workloads.

Heck, in a previous job, I visited a major customer who had lost their
sources to a critical bit of their software and they were changing
pathnames by running a hex editor on the binary.  Enterprise customers
do the darnedest things... (OTOH, they pay $$$ to our companies :-)

In the ideal world, sure, all or most of them would agree that they
*shouldn't* be storing any kind of PII at rest unencrypted, but they
can't be sure, and so from the perspective of keeping their audit and
I/T compliance committees happy, this requirement is desirable from a
"belt and suspenders" perspective.

> This seems like a better fit for FITRIM than anything else.
> 
> Ooohh. We sure do suck at APIs, don't we? FITRIM has no flags field,
> so we can't extend that.

I don't have any serious objections to defining FITRIM2; OTOH, for
Darrick's use case of wanting to make XFS work reliably with the GRUB
bootloader (which doesn't replay file system journals) and a certain
Enterprise Linux distribution (cough, cough) can't be bothered to do a
clean shutdown at the end of doing an install, using a hypothetical
FITRIM2 seems... wierd, whereas it might be cleaner to define
semantics in terms of FS_IOC_CHKPT_JRNL.  But I don't have a dog in
that particular fight, since I'm not responsible of maintaining either
XFS or RHEL.  :-)

Yet another possible solution might be to define a new system call,
syncfs2(), which takes a flag option.  That might be a bit more
heavyweight, and we would still have to figure out how to define what
a "journal checkpoint means" from the standpoint of an API definition.
It would presumably be something like "allows a non-kernel
implementation accessing the file system (e.g., from bootloaders like
grub) to be able to access files on the file sytstem as easily as
unmounting the file system", or perhaps defining it in terms of doing
a FIFREEZE/FITHAW, without having to actually freeze the file system.

> Oh, that won't be fun. XFS places a whiteout over the dirent to
> indicate that it has been freed, and it does not actually log
> anything other than the 4 byte whiteout at the start of the dirent
> and the 2 byte XFS_DIR2_DATA_FREE_TAG tag at the end of the dirent.
> So zeroing dirents is going to require changing the size and shape
> of dirent logging during unlinks...

So I'm not an expert on XFS, but XFS does logical logging, so what is
in the log is "we're going to white out this dirent", right?  So
couldn't the replay code be taught to look at the dirent's reclen, and
zero out the full directory entry at journal replay time?  If the
directory entry has already been reused, that's a case which the XFS
replay code has to handle already.  Or is there something subtle which
makes this hard to do.

> This will have to be done correclty for all the node merge, split
> and compaction cases, too, not just the "remove name" code.

Agreed this is going to be a lot more complicated for XFS.

> > P.P.S.  We'll also want to have a mount option which supresses file
> > names (for example, from ext4_error() messages) from showing up in
> > kernel logs, to ease potential privacy concerns with respect to serial
> > console and kernel logs.  But that's for another patch set....
> 
> This sounds more and more like "Don't encode PII in clear text
> anywhere" is a best practice that should be enforced with a big
> hammer. Filenames get everywhere and there's no easy way to prevent
> that because path lookups can be done by anyone in the kernel. This
> so much sounds like you're starting a game of whack-a-mole that can
> never be won.
> 
> From a security perspective, this is just bad design. Storing PII in
> clear text filenames pretty much guarantees that the PII will leak
> because it can't be scrubbed/contained within application controlled
> boundaries. Trying to contain the spread of filenames within random
> kernel subsystems sounds like a fool's errand to me, especially
> given how few kernel developers will even know that filenames are
> considered sensitive information from a security perspective...

The problem is that the company that the Cloud SRE's work for is
different from the enterprise customer owning the VM.  If a customer
stores PII in a filename, and the Cloud SRE places the log in some
place where it could leak out, Google gets blamed, not the enterprise
customer.

So the Cloud SRE's *have* to treat the logs as if they might contain
sensitive information, which means it can't be made available in bug
trackers without a manual (human-drive) scrubbing to make sure the log
doesn't have anything that might appear to contain PII.

By the way, MySQL puts table names into file names, and even though
table names normally aren't PII, it's still considered "customer
data", and we need to treat any kind of customer data super-carefully.

> Fundamentally, applications should *never* place PII in clear text
> in potentially leaky environments.  The environment for storing PII
> should be designed to be secure and free of data leaks from the
> ground up. And ext4 has already got this with fscrypt support.....

Cloud disks (no matter which cloud vendor) do tend to be encrypted at
rest, and in the case of Google, we even give customers the option to
Bring Your Own Key, which means when the VM isn't running, no one at
Google has access to the encryption key.  But that doesn't change the
fact that if we need to debug a system, the logs might contain file
names, and file names might be customer-owned data.  Using encryption
at rest doesn't solve that problem.

					- Ted
