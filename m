Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEA284437
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgJFDSv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 23:18:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47075 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgJFDSv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 23:18:51 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0963IYat000571
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Oct 2020 23:18:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C0AA420107; Mon,  5 Oct 2020 23:18:34 -0400 (EDT)
Date:   Mon, 5 Oct 2020 23:18:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201006031834.GA5797@mit.edu>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006025110.GJ49559@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 07:51:10PM -0700, Darrick J. Wong wrote:
> > > Could /somebody/ please document the ondisk format changes that are
> > > associated with this feature?
> > 
> > I pretty much had to sort it out by looking at a combination of
> > e2fsprogs and the kernel, and a lot of experimentation, until I ended up
> > with something that the kernel was completely happy with without a
> > single complaint.
> > 
> > I'd be happy to write up a summary of the format.
> 
> Seems like a good idea, particularly since you're asking for a format
> change that requires kernel support and the ondisk format documentation
> lives under Documentation/.  That said...

> > If you set up the rest of the metadata consistently with it (for
> > instance, 0 free blocks and 0 free inodes), you'll only get a single
> > complaint, from the e2fsck equivalent of block_validity. See
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=956509 for details on
> > that;
> 
> ...Ted shot down this whole thing six months ago.
> 
> The Debian bug database is /not/ the designated forum to discuss changes
> to the ondisk format; linux-ext4 is.

What Josh is proposing I'm pretty sure would also break "e2fsck -E
unshare_blocks", so that's another reason not to accept this as a
valid format change.

As far as I'm concerned, contrib/e2fsdroid is the canonical definition
of how to create valid file systems with shared_blocks.

					- Ted
