Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959B4172223
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2020 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgB0PVJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Feb 2020 10:21:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:36788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbgB0PVJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 Feb 2020 10:21:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E427BAFB7;
        Thu, 27 Feb 2020 15:21:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A25D41E0E88; Thu, 27 Feb 2020 16:21:07 +0100 (CET)
Date:   Thu, 27 Feb 2020 16:21:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Red Swaqz <redswaqz@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [QUESTION] jbd2: how metadata blocks are checkpointed by the
 page-cache?
Message-ID: <20200227152107.GA7843@quack2.suse.cz>
References: <CACFo8TH_BPFdCiUZZXJY+VWcvy5reNXEd70PREFm4UCjPGghRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACFo8TH_BPFdCiUZZXJY+VWcvy5reNXEd70PREFm4UCjPGghRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

The reply is late but maybe it will be still useful.

On Mon 27-01-20 11:26:40, Red Swaqz wrote:
> I am studying the ext4/JBD2 internals and there is one thing that is missing
> in my understanding: the **Checkpoint** part for metadata blocks.
> 
> So far I understood that the JBD2 marks the metadata buffers as
> _bufer_jbddirty(bh)_, then during the commit, the buffers are shadowed,
> written to the journal area, and later they are marked as
> _buffer_dirty(bh)_ and left to the page-cache to writeback them to the
> original position at the disk. Later on, the JBD2 will check its
> checkpoint list and check if the _buffer_heads_ are clean, which
> indicates that they were written to the storage and the CP operation is
> complete, thus JBD2 can remove those _buffer_heads_ from its control.

Correct.

> So, this is the part I didn't catch in the code: where/when/how the
> page-cache writes the metadata blocks exactly? So far I could understand
> (not 100% sure) that the ext4 fills the _address_space_operations_
> structure with the _ext4_writepage()_, _ext4_writepages()_, and so on for
> the page-cache operations. But still, it is not clear to me when the
> metadata blocks are written back to cause the CP completion.

So metadata reside in "block device page cache" also sometimes called
"buffer cache" - that's page cache behind say /dev/sda. The kernel tracks
dirty block device inode like any other inodes and also schedules their
writeback using 'flush workers'. These flush workers will call ->writepage
/ ->writepages method for the inode - for block devices this is
blkdev_writepage(). And this sends dirty metadata to the disk.

Also there's another "synchronous" method how metadata can get
checkpointed. When we are running out of space in the journal, the process
starting transaction will call log_do_checkpoint() to writeback metadata
needing checkpoint.

Hope this helps.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
