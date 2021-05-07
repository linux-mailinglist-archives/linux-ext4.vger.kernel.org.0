Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79EB376859
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhEGP5b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 May 2021 11:57:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47803 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231130AbhEGP53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 May 2021 11:57:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 147FuMnA007370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 May 2021 11:56:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 342B215C39BD; Fri,  7 May 2021 11:56:22 -0400 (EDT)
Date:   Fri, 7 May 2021 11:56:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJVjJoI8sX531AL2@mit.edu>
References: <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com>
 <YJGmTNIHixCLiKok@mit.edu>
 <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
 <YJGyTjYKcEkx+fQq@gmail.com>
 <YJG4SrJ/ZEjv3Ha0@mit.edu>
 <YJG9CjVXKkha57RU@gmail.com>
 <YJTh9T3sgdFFE7fM@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJTh9T3sgdFFE7fM@sol.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 06, 2021 at 11:45:09PM -0700, Eric Biggers wrote:
> Just to be clear (looking at the latest patches on the list which are copying
> whole structs), by "the memcpy() approach does get optimized properly", I meant
> that it gets optimized properly in implementations of get_unaligned_le16(),
> get_unaligned_le32(), put_unaligned_le32(), etc., where a single word (or less
> than a word) is loaded or stored.  I don't know how reliably the compilers will
> optimize out the copy if you memcpy() a whole struct instead of a single word.
> 
> Even if they don't optimize it out, I don't expect that it would be a
> performance problem in this context, so it's probably still fine to solve the
> problem.  But I just wanted to clarify what I meant here.

For the most recent patch that sent out, we really needed to copy out
the whole structure since we're then passing it to ext2fs library
functions.  I agree that it's not likely going to be a performance
problem, and at this point, I'm more concerned about code clarity and
correctness.

Especially since apparently the problems which Harshad's change and my
most recent commit addressed were not picked up by UBSAN (either using
gcc or clang), --- and IMHO they really should have.  So we can't
count on UBSAN to find all possible alignment problems.

Lesson learned, before I do future releases, I should do a build and
"make check" on a armhf chroot running on a arm-64 machine, as well as
on a sparc64 machine, since these seem to be the most sensitive to
alignment issues.  And if I miss anything, fortunately Debian's
autobuilders on a large cross-section of architectures will catch them
since we run the regression test suite as part of the package build.

					- Ted

P.S.  Harshad, could you prepare patches to kernel files in ext4 and
jbd2 to make similar alignment portability fixes?   Thanks!!
