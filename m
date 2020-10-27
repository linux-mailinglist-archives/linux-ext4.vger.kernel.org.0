Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7F29C7AE
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 19:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829022AbgJ0SqG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 14:46:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37885 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1824035AbgJ0SpV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 14:45:21 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09RIj7Ie008005
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 14:45:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 862BB420107; Tue, 27 Oct 2020 14:45:07 -0400 (EDT)
Date:   Tue, 27 Oct 2020 14:45:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jayashree <jaya@cs.utexas.edu>, vijay@cs.utexas.edu
Subject: Re: [PATCH v10 5/9] ext4: main fast-commit commit path
Message-ID: <20201027184507.GD5691@mit.edu>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-6-harshadshirwadkar@gmail.com>
 <20201023103013.GF25702@quack2.suse.cz>
 <CAD+ocbws2J0boxfNA+gahWwTAqm8-Pef9_WkcwwKFjpiJhvJKw@mail.gmail.com>
 <20201027142910.GB16090@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027142910.GB16090@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 27, 2020 at 03:29:10PM +0100, Jan Kara wrote:
> 
> OK, I see. Maybe add a paragraph about this to fastcommit doc? I agree that
> we can leave these optimizations for later, I was just wondering whether
> there isn't some fundamental reason why global flush would be required and
> I'm happy to hear that there isn't.
> 
> The advantage of soft_consistency as you call it would be IMO most seen if
> there's relatively heavy non-fsync IO load in parallel with frequent fsyncs
> of a tiny file. And such load is not infrequent in practice. I agree that
> benchmarks like dbench are unlikely to benefit from soft_consistency since
> all IO the benchmark does is in fact forced by fsync.
> 
> I also think that with soft_consistency we could benefit (e.g. on SSD
> storage) from having several fast-commit areas in the journal so multiple
> fastcommits can run in parallel. But that's also for some later
> experimentation...

Right, so this is the reason why I wasn't super-excited by the
proposal to document crash recovery semantics in Linux file systems
proposed by Jayashree Mohan and Prof. Vijay Chidambaram last year[1].  I
knew that we were planning the Fast Commit work (Jayashree and Vijay,
this is a simplified version of the proposal made by Park and Shin in
their iJournaling paper[2]) and having something document that an
fsync(2) to one file guarantees that changes made to some other file
that were made "earlier" would disallow this particular optimization.

[1] http://lore.kernel.org/r/1552418820-18102-1-git-send-email-jaya@cs.utexas.edu
[2] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park

That being said, I was afraid that there *were* applications that
might be (wrongly) making this assumption, even though it wasn't
guaranteed by POSIX.  So when it didn't make much difference for
benchmarks, and given that our original goal was to speed up NFS file
serving, where every single NFS RPC has to be synchronous before an
acknowledgement is sent back to the client, we decided to take the
conservative path --- at least for now.

I do agree with you that I can certainly think of workloads where not
requiring entanglement of unrelated file writes via fsync(2) could be
a huge performance win.

One of the things that I did discuss with Harshad was using some
hueristics, where if there are two "unrelated" applications (e.g.,
different session id, or process group leader, or different uid,
etc. --- details to be determined layer), we would not entangele
writes to unrelated files via fsync(2), while forcing files written by
the same application to share fate with one another even if only file
is fsync'ed.  Hopefully, this would head off the possibility of
another O_PONIES[3] controversy while still giving most of the
benefits of not making fsync(2) a global file system barrier.  It
would be hell to document in a standards specification, so the
official rule would still be "fsync(2) only applies to the single
file, and anything else is an accident of the implementation", per
POSIX.

[3] https://lwn.net/Articles/322823/

I still think the right answer is a new system call which takes an
array of file descriptors, so the application can explicitly declare
which set of files can be reliably fsync'ed in the same transaction
commit.  The downside is that this would require applications to
change what they are doing, and it would take the better part of a
decade before we could assume well-written applications are explicitly
declaring their crash recovery needs.

					- Ted
