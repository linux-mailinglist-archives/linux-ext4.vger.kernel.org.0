Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC0F6737
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2019 05:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKJEwU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Nov 2019 23:52:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54769 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726560AbfKJEwU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Nov 2019 23:52:20 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAA4q68V022627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Nov 2019 23:52:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7BC474202FD; Sat,  9 Nov 2019 23:52:06 -0500 (EST)
Date:   Sat, 9 Nov 2019 23:52:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-ext4@vger.kernel.org, harshads@google.com
Subject: How much do we care about building e2fsprogs on Solaris?
Message-ID: <20191110045206.GG23325@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Darrick,

I'm thinking about reverting the following commit, which was
introduced over a decade ago for better Solaris portability.

commit 1911bf113ef0f9c71090f26279e4a4082fae0abc
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun Jul 13 08:04:36 2008 -0400

    e2fsck: Change kmem_cache_t to lkmem_cache_t for Solaris

    Solaris polutes the C namespace with kmem_cache_t when
        you include in/netinet.h is included, so rename kmem_cache_t
	    to lkmem_cache_t.

    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

I've been working on getting e2fsck/{recovery.c,revoke.c} better
sync'ed up with the kernel versions of these files.  See the next
branch on e2fsprogs.git for my work in this area, in particular
commits 71030cf8^..46e1286a

One of the last remaining deltas is a hack to rename kmem_cache_t to
lkmem_cache_t, to work around the above described a Solaris bug.
There is a shell script, contrib/jbd2-resync.sh which we use to try to
things in sync, but it is a bit of a pain.

So this brings up two questions, which I suspect you're uniquely
qualified to answer:

(a) Does Solaris still have this namespace leakage bug in
<in/netinet.h>, such that e2fsprogs would fail to compile on Solaris
if we were to revert this commit?

(b) If Solaris still has this bug, after a over decade, do we care?
These days, Solaris doesn't seem to have much salience other than
being a program loader for a certain enterprise database, and I'm very
interested in trying to reduce the maintenance burden of keeping these
two files from fs/jbd2 in sync with the kernel, without having to put
some awful hacks on the kernel side.

					- Ted

P.S.  There are some changes that were made on the e2fsprogs side,
mostly to clean up some UBSan issues, but there's a spelling fix in a
comment and a few other miscellaneous things where the right fix is to
migrate the patch from e2fsprogs to the kernel.  Harshad is going to
work on that, in preparation for his next version of the fast commit
patches, and then getting those changes supported in e2fsprogs.

I believe I've migrated all of the improvements from the kernel's
versions of fs/jbd2/{recovery,revoke}.c to e2fsprogs, to make
Harshad's job simpler.
