Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC28A2D8
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfHLQEv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 12:04:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58923 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbfHLQEv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 12:04:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CG4kft028475
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 12:04:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A2EDD4218EF; Mon, 12 Aug 2019 12:04:45 -0400 (EDT)
Date:   Mon, 12 Aug 2019 12:04:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
Message-ID: <20190812160445.GA28705@mit.edu>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809034552.148629-6-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 08, 2019 at 08:45:45PM -0700, Harshad Shirwadkar wrote:
> This patch adds new helper APIs that ext4 needs for fast
> commits. These new fast commit APIs are used by subsequent fast commit
> patches to implement fast commits. Following new APIs are added:
> 
> /*
>  * Returns when either a full commit or a fast commit
>  * completes
>  */
> int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
> 			    tid_t tid, tid_t subtid)

I think there is an opportunity to do something more efficient.

Right now, the ext4_fsync() calls this function, and the file system
can only do a "fast commit" if all of the modifications made to the
file system to date are "fast commit eligible".  Otherwise, we have to
fall back to a normal, slow commit.

We can make this decision on a much more granular level.  Suppose that
so far during the life of the current transaction, inodes A, B, and C
have been modified.  The modification to inode A is not fast commit
eligible (maybe the inode is deleted, or it is involved in a directory
rename, etc.).  The modification to inode B is fast commit eligible,
but an fsync was not requested for it.  And the modification to inode
C *is* fast commit eligble, *and* fsync() has been requested for it.

We only need to write the information for inode C to the fast commit
area.  The fact that inode A is not fast commit eligible isn't a
problem.  It will get committed when the normal transaction closes,
perhaps when the 5 second commit transaction timer expires.  And inode
B, even though its changes might be fast commit eligible, might
require writing a large number of data blocks if it were included in
the fast commit.  So excluding inodes A and B from the fast commit,
and only writing the logical changes corresponding to the those made
to inode C, will allow a fast commit to take place.

In order to do that, though, the ext4's fast commit machinery needs to
know which inode we actually need to do the fast commit for.  And so
for that reason, it's actually probably better not to run the changes
through the commit thread.  That makes it harder to plumb the file
system specific information through, and it also requires waking up
the commit thread and waiting for it to get scheduled.

Instead, ext4_fsync() could just call the fast commit machinery, and
the only thing we need to expose is a way for the fast commit
machinery to attempt to grab a mutex preventing the normal commit
thread from starting a normal commit.  If it loses the race, and the
normal commit takes place before we manage to do the fast commit; then
we don't need to do any thing more.  Otherwise the fast commit
machinery can do its thing, writing inode changes to the journal, and
once it is done, it can release the mutex and ext4 fsync can return.

Does that make sense?

					- Ted
