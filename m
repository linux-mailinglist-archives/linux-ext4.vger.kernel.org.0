Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC223798B0
	for <lists+linux-ext4@lfdr.de>; Mon, 10 May 2021 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhEJVAw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 May 2021 17:00:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36235 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232019AbhEJVAw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 May 2021 17:00:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14AKxchR022856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 16:59:39 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D204215C3CD9; Mon, 10 May 2021 16:59:38 -0400 (EDT)
Date:   Mon, 10 May 2021 16:59:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Haotian Li <lihaotian9@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] e2fsck: try write_primary_superblock() again when it
 failed
Message-ID: <YJmeuvBtGBIB9Uv7@mit.edu>
References: <7486f08c-7f14-9fac-fdb2-0fe78a799d90@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7486f08c-7f14-9fac-fdb2-0fe78a799d90@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 13, 2021 at 11:19:30AM +0800, Haotian Li wrote:
> Function write_primary_superblock() has two ways to flush
> superblock, byte-by-byte as default. It may use
> io_channel_write_byte() many times. If some errors occur
> during these funcs, the superblock may become inconsistent
> and produce checksum error.
> 
> Try write_primary_superblock() with whole-block way again
> when it failed on byte-by-byte way.

So unless you're using Direct I/O, this patch really shouldn't be
making any difference.  (And tune2fs doesn't actually support Direct
I/O access, and that's the only e2fsprogs program that should normally
be making changes to the superblock on a regular basis.)  That's
becuase with buffered I/O, we aren't going to be actually trying to
write to the device.  The byte-by-byte writes will only be to
in-memory buffer caches, and so write errors should be *very* rare.
Are you actually seeing this happen in actual practice?  If so, what
userspace program is trying to write the superblock, and under what
circumstances.

The problem with writing the whole superblock at one go is that this
can race with changes being made by the kernel --- for example, if we
are unlinking or truncating a file, and the kernel is updated the
first inode in the orphaned inode list, this can lead to other types
of inconsistencies / file system corruption if we get unlucky.  That's
why we switched the byte-by-byte update approach (at least for those
I/O managers which supported it; those that didn't were things like
the Windows I/O manager where concurrent update by the kernel wasn't
an issue).

It is true that since we have added metadata checksums, this can lead
to checksum inconsistencies.  In practice, since we don't validate the
superblock while the file system is mounted, this should only happen
in two cases if there is a race between tune2fs modifying the kernel
and the kernel trying to update the superblock, and we crash before a
subsequent attempt by the kernel to update the superblock; for
example, when the orphaned inode list is being modified, or when the
file system is unmounted.

What we should do fix this, at least for the long term, is to add new
generic ioctls for updating the label and UUID.  This is something I
had discussed with Darrick as something that multiple file systems
would find useful.  For the other use cases, what I think we should do
is to implement an ext4-specific ioctl which takes a pointer to an
in-memory 1k superblock, and a 32-bit flag word.  One bit in the flag
word might cause the ioctl to update the following fields:

	__le16	s_mnt_count;		/* Mount count */
	__le16	s_max_mnt_count;	/* Maximal mount count */
	__le32	s_lastcheck;		/* time of last check */
	__le32	s_checkinterval;	/* max. time between checks */

Another bit might mean updating these fields:

	__le16	s_errors;		/* Behaviour when detecting errors */
	__le32	s_r_blocks_count_lo;	/* Reserved blocks count */
	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */


Yet another bit might mean updating these fields: 

	__le32	s_default_mount_opts;
	__u8	s_mount_opts[64];

etc.  If the flag word is 0, then the ioctl will return success, and
the flag word will be updated with the set of flags supported by the
currently running kernel.

In that way, tune2fs could test and see if it is running on a kernel
which supports superblock updates via the ioctl mechanism.  If it
does, it will use this in preference to trying to update the
superblock via direct writes to the block device, and since the actual
commit is being done by the kernel, it can run those changes through
the journal.  The kernel can also make sure the superblock checksum is
updated in a completely consistent way and with appropriate locking
with other changes to the superblock.

Does that make sense?

					- Ted
