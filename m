Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9B23A088
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Aug 2020 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHCH5s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Aug 2020 03:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHCH5s (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Aug 2020 03:57:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5F2BAD36;
        Mon,  3 Aug 2020 07:58:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82F241E12CB; Mon,  3 Aug 2020 09:57:46 +0200 (CEST)
Date:   Mon, 3 Aug 2020 09:57:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ext4 <linux-ext4@vger.kernel.org>,
        rebello.anthony@gmail.com
Subject: Re: Data exposure on IO error
Message-ID: <20200803075746.GA27707@quack2.suse.cz>
References: <20200731225621.GA7126@quack2.suse.cz>
 <CAOQ4uxgovoBjs5BnYdPyV6K9AP17fCaeVgZ=wQMfx4hAuAf5RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgovoBjs5BnYdPyV6K9AP17fCaeVgZ=wQMfx4hAuAf5RQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Amir!

On Sat 01-08-20 10:32:53, Amir Goldstein wrote:
> On Sat, Aug 1, 2020 at 1:59 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > In bug 207729, Anthony reported a bug that can actually lead to a stale
> > data exposure on IO error. The problem is relatively simple: Suppose we
> > do:
> >
> >   fd = open("file", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> >   write(fd, buf, 4096);
> >   fsync(fd);
> >
> > And IO error happens when fsync writes the block of "file". The IO error
> > gets properly reported to userspace but otherwise the filesystem keeps
> > running. So the transaction creating "file" and allocating block to it can
> > commit. Then when page cache of "file" gets evicted, the user can read
> > stale block contents (provided the IO error was just temporary or involving
> > only writes).
> >
> > Now I understand in face of IO errors the behavior is really undefined but
> > potential exposure of stale data seems worse than strictly necessary. Also
> > if we run in data=ordered mode, especially if also data_err=abort is set,
> > user would rightfully expect that the filesystem gets aborted when such IO
> > error happens but that's not the case. Generally data_err=abort seems a bit
> > misnamed (and the manpage is wrong about this mount option) since what it
> > really does is that if jbd2 thread encounters error when writing back
> > ordered data, the filesystem is aborted. However the ordered data can be
> > written back by other processes as well and in that case the error is just
> > lost / reported to userspace but the filesystem doesn't get aborted.
> >
> > As I was thinking about it, it seems to me that in data=ordered mode, we
> > should just always abort the filesystem when writeback of newly allocated
> > block fails to avoid the stale data exposure mentioned above. And then, we
> > could just deprecate data_err= mount option because it wouldn't be any
> > useful anymore... What do people think?
> >
> 
> It sounds worse than strictly necessary.
> 
> In what way is that use case different from writing into a punched hole
> in the middle of the file and getting an IO error on writeback?

This is exactly the same.

> It looks like ext4 already goes into a great deal of trouble to handle
> extent conversion to init at io end.

So ext4 has currently two modes of operation controlled by dioread_nolock
mount option. Since about two kernel releases, ext4 defaults to actually
creating extents as unwritten and converting them on IO end. In this mode
ext4 actually doesn't have an issue because when IO error happens, we just
don't convert extents to written ones and so stale data is not exposed. But
we still do support the "legacy" mode of operation where extents are
created as written ones from the start and we just make sure the commit
with block allocation waits for data writeback to complete. And in this
mode there's this possibility of stale data exposure on IO error.

> So couldn't the described case be handled as a private case of
> filling a hole at the end of the file?
> 
> Am I missing something beyond the fact that traditionally, extending
> a file enjoyed the protection of i_disksize, so did not need to worry
> about unwritten extents?

The question really is what to do with the legacy mode of operation...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
