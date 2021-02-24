Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782C632406E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Feb 2021 16:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBXPDA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Feb 2021 10:03:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52463 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235395AbhBXOyV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Feb 2021 09:54:21 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11OErTgL012902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 09:53:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 81CB215C342C; Wed, 24 Feb 2021 09:53:29 -0500 (EST)
Date:   Wed, 24 Feb 2021 09:53:29 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Seamus Connor <seamus@tinfoilwizard.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: reproducible corruption in journal
Message-ID: <YDZoaacIYStFQT8g@mit.edu>
References: <dccc26c4-19be-4f07-a593-bec842500d09@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dccc26c4-19be-4f07-a593-bec842500d09@www.fastmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 23, 2021 at 04:41:20PM -0800, Seamus Connor wrote:
> Hello All,
> 
> I am investigating an issue on our system where a filesystem is becoming corrupt.

So I'm not 100% sure, but it sounds to me like what is going on is
caused by the following:

*) The jbd/jbd2 layer relies on finding an invalid block (a block
which is missing the jbd/jbd2 "magic number", or where the sequence
number is unexpected) to indicate the end of the journal.

*) We reset to the (4 byte) sequence number to zero on a freshly
mounted file system.

*) It appears that your test is generating a large number of very
small transactions, and you are then "crashing" the file system by
disconnecting the file system from further updates, and running e2fsck
to replay the journal, throwing away the block writes after the
"disconnection", and then remounting the file system.  I'm going to
further guess that size of the small transactions are very similar,
and the amount of time between when the file system is mounted, and
when the file system is forcibly disconnected, is highly predictable
(e.g., always N seconds, plus or minus a small delta).

Is that last point correct?  If so, that's a perfect storm where it's
possible for the journal replay to get confused, and mistake previous
blocks in the journal as ones part of the last valid file system
mount.  It's something which probably never happens in practice in
production, since users are generally not running a super-fixed
workload, and then causing the system to repeatedly crash after a
fixed interval, such that the mistake described above could happen.
That being said, it's arguably still a bug.

Does this hypothesis consistent with what you are seeing?

If so, I can see two possible solutions to avoid this:

1) When we initialize the journal, after replaying the journal and
writing a new journal superblock, we issue a discard for the rest of
the journal.  This won't help for block devices that don't support
discard, but it should slightly reduce work for the FTL, and perhaps
slightly improve the write endurance for flash.

2) We should stop resetting the sequence number to zero, but instead,
keep the sequence number at the last used number.  For testing
purposes, we should have an option where the sequence number is forced
to (0U - 300) so that we test what happens when the 4 byte unsigned
integer wraps.

Cheers,

						- Ted
