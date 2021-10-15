Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15A042FD01
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhJOUck (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 16:32:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60811 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242451AbhJOUcj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 16:32:39 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19FKUSeW022631
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 16:30:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5E5DA15C00CA; Fri, 15 Oct 2021 16:30:28 -0400 (EDT)
Date:   Fri, 15 Oct 2021 16:30:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Avi Deitcher <avi@deitcher.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: algorithm for half-md4 used in htree directories
Message-ID: <YWnk5K5+h/Ddd4Rr@mit.edu>
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
 <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu>
 <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu>
 <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
 <YWnSMXcR5anaYTEU@mit.edu>
 <CAF1vpki7HqHgXxWsTwMEo4yz592agzZ9c=F09o-1py+jtJpLSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1vpki7HqHgXxWsTwMEo4yz592agzZ9c=F09o-1py+jtJpLSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 15, 2021 at 12:43:33PM -0700, Avi Deitcher wrote:
> Thanks, Ted, I will try yours and step through it to figure out what is off.
> 
> You ask a fair question: other than madness, why would someone want to
> recreate the exact algorithm?
> 
> I have had a number of cases where I have needed to manipulate disks,
> filesystems, partition tables, etc. from within a non-C-source
> program. The options have been: fork/exec to some external program;
> run a VM where I can mount the fs and manipulate content as needed.
> Those both work, but have had issues in various environments.
> 
> I made the mistake of saying, "well, all of this is just manipulating
> bytes on a disk image or block device; how hard could it be?" :-)
> So understanding the algorithm actually becomes important.

I think once you take a look at all of the "byte manipulation" that is
needed for any kind of non-trivial file system operation, you're
probably better off trying to figure out how to link the library in.

> I probably could link the library in if I am working on languages that
> support it (go, rust), but not all do, and there are reasons that is
> more difficult for the target use case.

Have you looked at SWIG?  SWIG suppotrs a *lot* of lanaguages,
including Tcl, Python, Perl, Guile, Java, Ruby, Mzscheme, PHP, OCaml,
C#, Lua, R, Octave, Go, D, Javascript, Scilab, etc.  If you end up
writing the equivalent of libext2fs for one language, it's really not
going to help you all that much for another language.

I also note you've not really been specific about "the target use
case".  Is that something you'd be willing to say more about?

In any case, if you're interested in implementing SWIG bindings for
libext2fs, that is certainly something we could discuss integrating
into e2fsprogs, so that other people could also benefit from that
work.  Let me know if you're interested!

						- Ted
