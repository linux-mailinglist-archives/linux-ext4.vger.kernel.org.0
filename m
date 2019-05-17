Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5C2209A
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2019 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfEQXAE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 19:00:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41812 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbfEQXAE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 19:00:04 -0400
Received: from callcc.thunk.org (75-104-86-155.mobility.exede.net [75.104.86.155] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4HMxgTC030420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 18:59:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68209420027; Fri, 17 May 2019 18:59:40 -0400 (EDT)
Date:   Fri, 17 May 2019 18:59:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix entry corruption when disk online and offline
 frequently
Message-ID: <20190517225940.GC21961@mit.edu>
References: <1557807817-121893-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557807817-121893-1-git-send-email-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 14, 2019 at 12:23:37PM +0800, ZhangXiaoxu wrote:
> I got some errors when I repair an ext4 volume which stacked by an
> iscsi target:
>     Entry 'test60' in / (2) has deleted/unused inode 73750.  Clear?
> It can be reproduced when the network not good enough.
> 
> When I debug this I found ext4 will read entry buffer from disk and
> the buffer is marked with write_io_error.
> 
> If the buffer is marked with write_io_error, it means it already
> wroten to journal, and not checked out to disk. IOW, the journal
> is newer than the data in disk.
> If this journal record 'delete test60', it means the 'test60' still
> on the disk metadata.
> 
> In this case, if we read the buffer from disk successfully and create
> file continue, the new journal record will overwrite the journal
> which record 'delete test60', then the entry corruptioned.
> 
> So, use the buffer rather than read from disk if the buffer marked
> with write_io_error

You've raised a number of issues about how we handle write errors,
especially when they occur due to a flaky transport --- in your case,
due to iSCSI.  As such, your patch isn't wrong, so much as it is
incomplete.

For example, your assumption that if the buffer is marked
write_io_error, it's safe to clear write_io_error and reset
buffer_uptodate assumes that journalling is enabled.  If the file
system does not have the journal, there is no journal to fall back
upon.  For file systems which do have a journal, if you are using a
flaky iSCSI transport, there is no protection from write errors which
occur when the journal is replayed.  (fs/jbd2/recovery.c simply marks
the buffer dirty and allows the writeback code take care of writing
the buffer.)  This means that the buffer could have write_io_error set
due to a failure to write the buffer during recovery, in which case
relying on the journal having a uptodate copy block is invalid.

Also, this patch only patches the ex4_bread() path, which is only used
by directories.  It doesn't deal with metadata reads for allocation
bitmaps or extent tree blocks.  We are doing this hack for inode table
blocks, already; perhaps you got the idea to do this for ext4_bread()
from __ext4_get_inode_loc()?

We could add some kind of callback from the buffer cache layer when an
aysnchronous writeback fails --- or we could use a synchronous write
in the journal recovery code (which would be bad from a performance
perspective, but ignore that for the moment) --- however, what do we
do when we discover that there is an error?  Right now, we do nothing
until we try to read the inode table block (and after your patch,
reading a directory block).  Under memory pressure, though, the data
will get lost and we don't even mark the file system as needing to be
checked.  We could retry the write, but if it's due to a flaky iSCSI
or FC transport, this write could fail yet again --- and then what?

So while I could apply this patch, since it doesn't make things worse,
I want to make sure you are aware that if you have problems with your
iSCSI device, this patch is far from a complete solution.  At the very
least, we should handle reads for other metadata block.  

      	      	   	    	       		  - Ted
