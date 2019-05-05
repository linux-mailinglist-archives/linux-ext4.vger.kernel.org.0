Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC413D10
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2019 06:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEEEM1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 May 2019 00:12:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49861 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727087AbfEEEM1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 May 2019 00:12:27 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x454CKSx003339
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 May 2019 00:12:21 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 93B99420024; Sun,  5 May 2019 00:12:20 -0400 (EDT)
Date:   Sun, 5 May 2019 00:12:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Alexey Lyashkov <c17817@cray.com>
Subject: Re: [PATCH] e2fsck: Do not to be quiet if verbose option used.
Message-ID: <20190505041220.GA10038@mit.edu>
References: <20190426130913.9288-1-c17828@cray.com>
 <20190428233847.GA31999@mit.edu>
 <5DF9A5AD-ADCA-452B-8242-FE43946002ED@gmail.com>
 <20190504214944.GA10073@mit.edu>
 <DE86FFC8-0D93-46CC-B465-F8603921AD62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DE86FFC8-0D93-46CC-B465-F8603921AD62@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 05, 2019 at 01:04:00AM +0300, Alexey Lyashkov wrote:
> > 
> > The -p option is only intended to be used when called from boot
> > scripts, where e2fsck is run in parallel
>
> It’s not a true.

It *is* true.  That was the original intent.  You may be wanting to
use -p for something else, but that is *not* how -p was originally
intended to be used.  As the author, I'm entitled to tell you how I
originally intended the option to be used.  :-)

> -p option is good enough in run to run automatic fixes, for minor
>  bugs, without relation to boot scripts.   -y option too soft,
>  -n option - too strict, -p is good enough in common case for initial fix.

You or your user want to use it for something else, but we should
discuss whether -p is really the right approach.  It sounds like the
user doesn't want to answer all of the questions by hand.  That's a
valid desire, but using -p means that after first problem which e2fsck
finds which it can't safely fix, it will abort.

As I understand things, the Lustre folks are interested in using
super, super big ext4 file systems.  Which is fine, but that means the
e2fsck run might take a long time.  To have it get half-way through
the run, only to have it abort, and then forcing the user to restart
the e2fsck might not be the user-friendly way to go, hmmm?

So *perhaps* the right answer is to add a new option which
automatically answers "yes" to all PR_PREEN_OK problems, but for
problems that are not PR_PREEN_OK, e2fsck should not abort, but stop
and ask the user for a yes/no confirmation about how to proceed.

Another potential answer would be to add two new "always" and "never"
answers, which gives e2fsck permission to proceed to fix (or skip
fixing) all future instances of that particular problem.  This isn't
as automatic, but it gives much finer-grain control to the user.
(These two proposals are not mutually exclusive, by the way; we might
want to do both.)

Using -p -v is a hack, and it's in my opinion not really the best
answer.

Finally, it's clear that this patch was never properly tested.  It
doesn't work right for PR_PREEN_NOMSG problems which previously had
been suppressed now get printed:

<tytso@lambda> {/build/e2fsprogs-maint/e2fsck}  
1077% gunzip < /usr/src/e2fsprogs/tests/f_bad_bbitmap/image.gz > /tmp/foo.img
<tytso@lambda> {/build/e2fsprogs-maint/e2fsck}  
1078% ./e2fsck /tmp/foo.img
e2fsck 1.45.0 (6-Mar-2019)
One or more block group descriptor checksums are invalid.  Fix<y>? yes
Group descriptor 0 checksum is 0x49ff, should be 0x4972.  FIXED.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(8--10) -(12--17) -(19--31)
Fix<y>? no
Free blocks count wrong for group #0 (494, counted=472).
Fix<y>? no
Free blocks count wrong (494, counted=472).
Fix<y>? no
Block bitmap differences: Group 0 block bitmap does not match checksum.
FIXED.

test_filesys: ***** FILE SYSTEM WAS MODIFIED *****

test_filesys: ********** WARNING: Filesystem still has errors **********

test_filesys: 11/128 files (0.0% non-contiguous), 18/512 blocks
<tytso@lambda> {/build/e2fsprogs-maint/e2fsck}  
1079% ./e2fsck -pv /tmp/foo.img
test_filesys was not cleanly unmounted, check forced.
test_filesys: Block bitmap differences: test_filesys:  -(8--10)test_filesys:  -(12--17)test_filesys:  -(19--31)test_filesys: 

Note how badly the "Bad bitmap differences" message was mangled with
the patch and -p -v.  That's because the PR_PREEN_NOMSG messages were
never intended to be printed in preen mode.  By definition.  :-)

So even if "e2fsck -p -v" is the best solution for this particular use
case (and I don't think it is); the patch as proposed is *definitely*
is not the best implementation of the design, and so it's not suitable
for upstream adoption.

Regards,

						- Ted
