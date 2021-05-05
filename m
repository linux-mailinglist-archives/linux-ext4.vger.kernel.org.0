Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC692374AFB
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 00:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhEEWJq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 May 2021 18:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhEEWJp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 May 2021 18:09:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD37C611AD;
        Wed,  5 May 2021 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620252529;
        bh=wm8+fAV1I/2UML6rP10P+60NPKPWr630TVGF0NOCNSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orBUX5814TjF2uNG0YJKXBTj7bNZuNytJDTngC1VQT9SSPFLMJUmK0jB+KDSjR3u1
         7/gZdGovKzYGuzUnuWnRxNczDeKvUo+wvhARwwzS4wh7WNEehAO9iWQDF/PZ8VJLjo
         hl+Jf+q/OfmSCB/ksezrzhae0llso8IURa657HX127pJ5n1uyzuzfPMHvIhjs3wdSr
         IKT9LYZ8zo5usJMnc2PXtAQEGCM7u5Y9T7RhQpV/1VRPUWRsK/olpSH3FOybwjI9mJ
         AofTqWOoor+ihg31Mh9OREeryx3Iws01HkE+HqnvCxAzCBBPZnhhhrTpdqvgPBu06f
         UiDqd0layI4Og==
Date:   Wed, 5 May 2021 15:08:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 3/3] ext4: update journal documentation
Message-ID: <20210505220848.GA8606@magnolia>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210504163550.1486337-3-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504163550.1486337-3-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 04:35:50PM +0000, Leah Rumancik wrote:
> Add a section about journal checkpointing, including information about
> the ioctl EXT4_IOC_CHECKPOINT which can be used to trigger a journal
> checkpoint from userspace.
> 
> Also, update the journal allocation information to reflect that up to
> 1GB is used for the journal and that the journal is not necessarily
> contiguous.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  Documentation/filesystems/ext4/journal.rst | 26 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> index cdbfec473167..0404e99f9988 100644
> --- a/Documentation/filesystems/ext4/journal.rst
> +++ b/Documentation/filesystems/ext4/journal.rst
> @@ -4,12 +4,11 @@ Journal (jbd2)
>  --------------
>  
>  Introduced in ext3, the ext4 filesystem employs a journal to protect the
> -filesystem against corruption in the case of a system crash. A small
> -continuous region of disk (default 128MiB) is reserved inside the
> -filesystem as a place to land “important” data writes on-disk as quickly
> -as possible. Once the important data transaction is fully written to the
> -disk and flushed from the disk write cache, a record of the data being
> -committed is also written to the journal. At some later point in time,
> +filesystem against corruption in the case of a system crash. Up to 1GB is

Hair-splitting nit: Journals and logs don't protect against corruption,
they protect against inconsistency in the application of metadata
updates if the system crashes.

Also, the "up to 1GB" part isn't true -- journals can be up to 1024000
blocks or half the size of the fs, whichever is smaller.  You might
refer readers to the mke2fs manpage for details about exact size limits.

> +reserved inside the filesystem as a place to land “important” data writes
> +on-disk as quickly as possible. Once the important data transaction is fully
> +written to the disk and flushed from the disk write cache, a record of the data
> +being committed is also written to the journal. At some later point in time,
>  the journal code writes the transactions to their final locations on
>  disk (this could involve a lot of seeking or a lot of small
>  read-write-erases) before erasing the commit record. Should the system
> @@ -731,3 +730,18 @@ point, the refcount for inode 11 is not reliable, but that gets fixed by the
>  replay of last inode 11 tag. Thus, by converting a non-idempotent procedure
>  into a series of idempotent outcomes, fast commits ensured idempotence during
>  the replay.
> +
> +Journal Checkpoint
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Checkpointing the journal ensures all transactions and their associated buffers
> +are submitted to the disk. This is used internally during critical updates to
> +the filesystem including journal recovery, filesystem resizing, and freeing
> +of the journal_t structure.

Er... if I'm reading patch 2 correctly, jbd2_journal_flush checkpoints
two things: first it checkpoints the journal itself ("Force everything
buffered...wait for the log commit to complete...") to disk so that we
can recover if we crash; and second it checkpoints the /filesystem/
("...and flush everything in the log out to disk") to move the journal
tail up to the head (which means it's now empty).  Once the journal is
empty, you're clear to zap the blocks.

Right?  It's been a while since I was reading ext4 code every day.

The new functionality in EXT4_IOC_CHECKPOINT is that it checkpoints the
journal and the filesystem, whereas the venerable fsync/syncfs calls
only checkpoint the journal.  Checkpointing the journal is sufficient
for guaranteeing persistence, whereas checkpointing the fs is necessary
to be able to discard the journal blocks.

(Oh hey, I don't see where EXT4_IOC_CHECKPOINT flushes any dirty data to
disk -- if a syncfs() call is a pre-requisite, that needs to be made
abundantly clear here.)

--D

> +
> +A journal checkpoint can be triggered from userspace via the ioctl
> +EXT4_IOC_CHECKPOINT. This ioctl takes a single, u64 argument for flags.
> +Currently, the only flag supported is EXT4_IOC_CHECKPOINT_FLAG_DISCARD. When
> +this flag is set, the journal blocks are discarded after the journal checkpoint
> +is complete. The ioctl may be useful when snapshotting a system or for complying
> +with content deletion SLOs (when discard is supported and the discard flag is set).
> -- 
> 2.31.1.527.g47e6f16901-goog
> 
