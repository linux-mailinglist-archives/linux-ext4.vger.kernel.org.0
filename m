Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF127DE3C
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Sep 2020 04:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgI3CGv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Sep 2020 22:06:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46131 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729322AbgI3CGv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Sep 2020 22:06:51 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08U26kr9004756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 22:06:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 888F442003C; Tue, 29 Sep 2020 22:06:46 -0400 (EDT)
Date:   Tue, 29 Sep 2020 22:06:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: State of dump utility
Message-ID: <20200930020646.GD23474@mit.edu>
References: <20200929143713.ttu2vvhq22ulslwf@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929143713.ttu2vvhq22ulslwf@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 29, 2020 at 04:37:13PM +0200, Lukas Czerner wrote:
> 
> lately we've had couple of bugs against dump utility and a after a quick
> look at the code I realized that it is very much outdated at least on
> the extN side of things and would need some work and attention to make it
> work reliably with modern ext4 features.
> 
> However the code has been neglected for a while and talking to the
> maintainer he is pretty much done with it. At this point I am ready to
> pull the plug on dump/restore in Fedora, but before I do I was wondering
> whether there is any interest in moving dump/restore, or part of it, into
> e2fsprogs ?
> 
> I have not looked at the code close enought to say whether it's worth it
> or whether it would be better to write something from scratch. There is
> also a question about what to do with the tape code - that's not
> something I have any interest in digging into.
> 
> In my eyes dump had a good run and I would be happy just dumping it, but
> it is worth asking here on the list. Is there anyone interested in
> maintaining dump/restore, or is there interest in or objections agains
> merging it into e2fsprogs ?

One of the interesting questions is how reliable the dump utility
really is; that's because it works by reading the metadata directly
--- while the file system is mounted.  So it's quite possible for the
metadata to be changing out from under the dump/restore process.
Especially with metadata checksums, I suspect dump/restore is going
much more unreliable in terms of the libext2fs returning checksum
failures.

In the future, if we ever try to bypass the use of the buffer cache,
and instead have jbd2 write out directly to the bio layer so we cant
get better write error codes.  There was a discussion about this
recently, and there are two problems.  First, we need to worry about
programs like tune2fs and e2label that need to be able to read and
modify the superblock while the file system is modified.  We'd want to
add ioctl's to set and get the superblock, and update e2fsprogs to try
to use those system calls first.  And then.... there is dump/restore.i

I could imagine adding ioctl's which allow safe read-only access to
all metadata blocks, and not just for the superblock.  The question,
though is... is it worth it, especially if it's only to make
dump/restore work?

On the other hand, if we want to try to implement some kind of on-line
fsck work, then -perhaps safe metadata reading would be part of that
interface.  So I'd never say never, but I do wonder if it's time to
pull the plug on dump/restore --- especially if we want to allow it to
support not just inline files/directories, but also things like
extended attributes and ACL's.

						- Ted
