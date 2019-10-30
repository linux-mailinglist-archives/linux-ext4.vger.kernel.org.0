Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3BE9D6F
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfJ3O0e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 10:26:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44393 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726137AbfJ3O0e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Oct 2019 10:26:34 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9UEQTCs024646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 10:26:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F0B02420456; Wed, 30 Oct 2019 10:26:28 -0400 (EDT)
Date:   Wed, 30 Oct 2019 10:26:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiaohui1 Li =?utf-8?B?5p2O5pmT6L6J?= <lixiaohui1@xiaomi.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFp?= =?utf-8?B?bF1SZTo=?=
 [PATCH v3 09/13] ext4: fast-commit commit path changes
Message-ID: <20191030142628.GA16197@mit.edu>
References: <1571900042725.99617@xiaomi.com>
 <20191024201800.GE1124@mit.edu>
 <1572349386604.43878@xiaomi.com>
 <20191029213553.GD4404@mit.edu>
 <1572409673853.43507@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572409673853.43507@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 30, 2019 at 04:28:42AM +0000, Xiaohui1 Li 李晓辉 wrote:
> the problem of file' data wating in jbd2 order mode is also a
> serious problem which case a long-latency fsync call.

Yes, this is a separate problem, although note that if the file with a
large amount of data is the file which is being fsync'ed, you have to
write it out at fsync time no matter what.

You could try to write out dirty data earlier (e.g., by decreasing the
30 second writeback window), but there are tradeoffs.  For one thing,
if the file ends up being deleted anyway, it's better not to write out
the data at all.  For another, if we know how big the file is at the
time when we do the writeout, we can do a better job allocating space
for the file, and it improves the file layout by making it more likely
it will be contiguous, or at least mostly contiguous.

Also, files that tend to be fsync'ed a lot tend to be database files
(e.g., SQLite files), and they tend to write small amounts of data and
then fsync them.  So the problem described below happens when there
are unrelated files that happen to be downloaded in parallel.  An
example of this in the Android case mgiht be when the user is
downloading a large video file, such as a movie, to be watched offline
later (such as when they are on a plane).

> as pointed out in this iJournaling paper, when three conditions turn up at the same time,
> 1: order mode must be applied, not the writeback mode.
> 2: The delayed block allocation technique of ext4 must be  applied.
> 3: backgroud buffer writes are too many.

(1) and (2) are the default.  (3) may or may not be a frequent
occurrence, depending on the workload.  In practice though, users
aren't downloading large files all *that* often.

> we have no choice as the order mode need to do this work, so the
> waiting inode-data-flushed-disk time is too long in some extreme
> conditions.  so it cause the appearance of long-latency fsync call.
> 
> thank you for your reply, i will try to fix this problem in my free time.

So there is a solution; it's just a bit tricky to do, and it's not
been a huge enough deal that anyone has allocated time to fix it.

The idea is to allocate space, but not actually update the metadata
blocks at the time when the data blocks are allocated.  Instead, we
reserve them so they won't get allocated for use by another file, and
we note where they are in the extent status cache.  We then issue the
writes of the data block, and only after they are complete, only
*then* do we update the metadata blocks (which then gets updated via
the journal, using either a commit or a fast commit).

This is similar to the dioread_nolock case, where we update the
metadata blocks first, but mark them as unwritten, then we let the
data blocks get written, and only finally do we update the metadata
blocks so they are marked as written (e.g., initialized).  This avoids
the stale data problem as well, but we end up modifying the metadata
blocks twice, and it has resulted other performance problems since in
increases overhead on the i_data_sem lock.  See for example some of
the posts by Liu Bo from Alibaba last year:

If we can allocate space, write the data blocks, and only *then*
update the extent tree metadata blocks, it solves a lot of problems.
We can get rid of the dioread_nolock option; we can get rid of the
data=ordered vs data=writeback distinction; and we can avoid the need
to force data blocks to be written out at commit time.  So it improves
performance, and it will reduce code complexity, making it a win-win
approach.

The problem is that this means significantly changing how we do block
allocation and block reservation, so it's a fairly large and invasive
set of changes.  But it's the right long-term direction, and we'll get
there eventually.

Cheers,

						- Ted
