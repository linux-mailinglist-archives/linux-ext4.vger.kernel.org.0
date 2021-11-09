Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7C44A53E
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Nov 2021 04:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhKIDRZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 22:17:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44610 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231910AbhKIDRY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Nov 2021 22:17:24 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A93EX4F009672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Nov 2021 22:14:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 89E9315C00C2; Mon,  8 Nov 2021 22:14:33 -0500 (EST)
Date:   Mon, 8 Nov 2021 22:14:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Samuel Mendoza-Jonas <samjonas@amazon.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        benh@amazon.com
Subject: Re: Debugging ext4 corruption with nojournal & extents
Message-ID: <YYnnmQjrYii0dOYH@mit.edu>
References: <20211108173520.xp6xphodfhcen2sy@u87e72aa3c6c25c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108173520.xp6xphodfhcen2sy@u87e72aa3c6c25c.ant.amazon.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 08, 2021 at 09:35:20AM -0800, Samuel Mendoza-Jonas wrote:
> Based on that what I think is happening is
> - A file with separate (i.e. non-inline) extents is synced / written to disk
>   (in this case, one of the large "compound" files)
> - ext4_end_io_end() kicks off writeback of extent metadata
>   - AIUI this marks the related buffers dirty but does not wait on them in the
>     no-journal case
> - The file is deleted, causing the extents to be "removed" and the blocks where
>   they were stored are marked unused
> - A new file is created (any file, separate extents not required)
> - The new file is allocated the block that was just freed (the physical block
>   where the old extents were located)
> 
> Some time between this point and when the file is next read, the dirty extent
> buffer hits the disk instead of the intended data for the new file.
> A big-hammer hack in __ext4_handle_dirty_metadata() to always sync metadata
> blocks appears to avoid the issue but isn't ideal - most likely a better
> solution would be to ensure any dirty metadata buffers are synced before the
> inode is dropped.
> 
> Overall does this summary sound valid, or have I wandered into the
> weeds somewhere?

Hmm... well, I can tell you what's *supposed* to happen.  When the
extent block is freed, ext4_free_blocks() gets called with the
EXT4_FREE_BLOCKS_FORGET flag set.  ext4_free_blocks() calls
ext4_forget() in two places; one when bh passed to ext4_free_blocks()
is NULL, and one where it is non-NULL.  And then ext4_free_blocks()
calls bforget(), which should cause the dirty extent block to get
thrown away.

This *should* have prevented your failure scenario from taking place,
since after the call to bforget() the dirty extent buffer *shouldn't*
have hit the disk.  If your theory is correct, the somehow either (a)
the bforget() wasn't called, or (b) the bforget() didn't work, and
then the page writeback for the new page happened first, and then
buffer cache writeback happened second, overwriting the intended data
for the new file.

Have you tried enabling the blktrace tracer in combination with some
of the ext4 tracepoints, to see if you can catch the double write
happening?  Another thing to try would be enabling some tracepoints,
such as ext4_forget and ext4_free_blocks.  Unfortunately we don't have
any tracepoints in fs/ext4/page-io.c to get a tracepoint which
includes the physical block ranges coming from the writeback path.
And the tracepoints in fs/fs-writeback.c won't have the physical block
number (just the inode and logical block numbers).

       	     	       	   	   	 - Ted
