Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BC41573F
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Sep 2021 05:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhIWD7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Sep 2021 23:59:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42680 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237798AbhIWD7M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Sep 2021 23:59:12 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18N3vZI2001360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 23:57:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B2B9315C3756; Wed, 22 Sep 2021 23:57:35 -0400 (EDT)
Date:   Wed, 22 Sep 2021 23:57:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] mke2fs: Add extended option for prezeroed storage devices
Message-ID: <YUv7LzBIOodL6xyW@mit.edu>
References: <20210921034203.323950-1-sarthakkukreti@google.com>
 <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
 <0A4B11C1-A119-4733-A841-683889E9DC7B@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A4B11C1-A119-4733-A841-683889E9DC7B@amazon.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 23, 2021 at 03:31:00AM +0000, Kiselev, Oleg wrote:
> Wouldn't it make more sense to use "write-same" of 0 instead of
> writing a page of zeros and task the layers that do thin
> provisioning and return 0 on read from unallocated blocks to check
> if a block exists before writing zeros to it?

The problem is we have absolutely no idea what "write-same" of 0 will
actually do in terms of whether it will consume storage for various
thinly provisioned devices.  We also have no idea what the performance
might be.  It might be the same speed as explicitly passing in
zero-filled buffers and sending DMA requests to a hard drive.  (e.g.,
potentially very S-L-O-W.)

That's technically true for "discard" as well, except there's a vague
understanding that discard will generally be faster than writing all
zeros --- it's just that it might also be a no-op, or it might
randomly be a no-op, depending on the phase of the moon, or anything
other random variable, including whether "the storage device feels
like it or not".

Bottom line --- unfortunately, the SATA/SCSI standards authors were
mealy-mouthed and made discard something which is completely useless
for our purposes.  And since we don't know anything about the
performance of write same and what it might do from the perspective of
thin-provisioned storage, we can't really depend on it either.

The problem is mke2fs really does need to care about the performance
of discard or write same.  Users want mke2fs to be fast, especially
during the distro installation process.  That's why we implemented the
lazy inode table initialization feature in the first place.  So
reading all each block from the inode table to see if it's zero might
be slow, and so we might be better off just doing the lazy itable init
instead.

Hence, I think Sarthak's approach of giving an explicit hint is a good
approach.

The other approach we can use is to depend on metadata checksums, and
the fact that a new file system will use a different UUID for the seed
for the checksum.  Unfortunately, in order to make this work well, we
need to change e2fsck so that if the checksum doesn't work out ---
especially if all of the checksums in an inode table block are
incorrect --- we need to assume that it means we should just presume
that the inode table block is from an old instance of the file system,
and return a zero-filled block when reading that inode table block.
(Right now, e2fsck still offers the chance to just fix the checksum,
back when we were worried there might be bugs in the metadata checksum
code.)

But I don't think the two approaches are mutually exclusive.  The
approach of an explicit hint is a "safe" and a lot easier to review.

Cheers,

					- Ted
