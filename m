Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35B7326B0C
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Feb 2021 02:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhB0Bah (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 20:30:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57861 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229999AbhB0Bag (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 20:30:36 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11R1Tj2H003419
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:29:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 20FCB15C39D2; Fri, 26 Feb 2021 20:29:45 -0500 (EST)
Date:   Fri, 26 Feb 2021 20:29:45 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     bugzilla-daemon@bugzilla.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [Bug 211971] New: Incorrect fix by e2fsck for blocks_count
 corruption
Message-ID: <YDmgiV+IMF7SLtrW@mit.edu>
References: <bug-211971-13602@https.bugzilla.kernel.org/>
 <CAE1WUT6NueggML9Kf+JxB-dX=fyKrOhDszAnbt7UvFhQqwm3Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT6NueggML9Kf+JxB-dX=fyKrOhDszAnbt7UvFhQqwm3Gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 26, 2021 at 04:58:23PM -0800, Amy Parker wrote:
> Can you replicate this on modern 5.4 from kernel.org? -generic kernels
> are from Canonical and are sometimes broken compared to upstream. If
> you can't replicate this on mainline, you'll need to contact
> Canonical. We can't do anything if the problem only persists on
> distribution kernels.

This has nothing to do with the kernel.  What the user is complaining
about is that e2fsck trusts the blocks count field in the superblock
as to be a source of truth.  If that field is artificially changed to
be a smaller value, e2fsck will assume the file system size indicated
by that changed size.

That's an intentional design choice of e2fsck.  Given that with modern
ext4 file systems, we have metadata checksums, if the superblock has
been accidentally corrupted, the checksum will fail, and then e2fsck
will try using the backup superblock instead.

For older file systems that don't have metadata checksums enabled, we
could check to see if certain "fundamental constants" in the primary
superblock is different from the secondary superblock, but...

> > debugfs -w image
> > debugfs:  ssv blocks_count 4000
> > debugfs:  q

This will update the blocks_count in the primary and all secondary
backups.  So that's not going to really help the user.  Effectively,
the complaint is "I pointed the gun at my foot, and pulled the
triggered, and now my foot hurts!"

> > # Expected that e2fsck would fix the blocks count corruption instead of
> > changing other fields (e.g.,free blocks_count)

The problem is that e2fsck can't really determine that the blocks
count field has been corrupted.  We could warn the user if the
blocks_count is smaller than the reported size of the device,
but.... that's actually something that can happen in real life, and
it's not necessarily a file system "corruption", but rather an
intentional choice by the system administrator.  If we were to give a
warning, or worse, assume that blocks count should be adjusted to be
the size of the deivce, we'd be getting complaints from users who
deliberately chose to set the file system size to be something smaller
than the block device.

So this is a case of e2fsck is working as intended.

Cheers,

					- Ted
					
