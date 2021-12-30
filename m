Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A8481827
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Dec 2021 02:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhL3Bh3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Dec 2021 20:37:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55429 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232036AbhL3Bh3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Dec 2021 20:37:29 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BU1bLWG010574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 20:37:22 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9153C15C33A3; Wed, 29 Dec 2021 20:37:21 -0500 (EST)
Date:   Wed, 29 Dec 2021 20:37:21 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 1vier1@web.de
Subject: Re: JBD2: journal transaction 6943 on loop0-8 is corrupt.
Message-ID: <Yc0NUYyRhLdtapq+@mit.edu>
References: <baa3101d-e2f7-823e-040f-8739ab610419@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa3101d-e2f7-823e-040f-8739ab610419@colorfullife.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 28, 2021 at 09:36:22PM +0100, Manfred Spraul wrote:
> Hi,
> 
> with simulated power failures, I see a corrupted journal
> 
> [39056.200845] JBD2: journal transaction 6943 on loop0-8 is corrupt.
> [39056.200851] EXT4-fs (loop0): error loading journal

This means that the journal replay found a commit which was *not* the
last commit, and which contained a CRC error.  If it's the last commit
(e.g., there is no valid subsequent commit block), then it's possible
that the journal commit was never completed before the system crashed
--- e.g., it was an interrupted commit.

Your test is aborting the commit at various points in the write I/O
stream, so it should be simulating an interrupted commit (assuming
that it's not corrupting any I/O.  So the jbd2 layer should have
understood it was the last commit in the journal, and been OK with the
checksum failure.

But what can happen is that if there is a commit block in the right
place at the end of the transaction, left over from the previous
journalling session, this can confuse the jbd2 layer into thinking
that it is *not* the last transaction, and then it will make the
"journal transaction is corrupt" report.

How does the jbd2 layer determine whether there is a valid "subsequent
commit", well if the subsequent commit block meets the following two
criteria:

	* the commit id is the correct, expected one (n+1 the previous
          commit id).
	* the commit time (seconds since January 1, 1970) in the
	  commit block is greater than the comit time in the previous
	  commit block.

So if your test setup doesn't correctly set the time (say, it always
leaves the bootup time to January 1, 1970), and the workload is
extremely regular, it's possible that the replay interrupted a journal
commit, but there was left-over commit block that *looked* valid, and
it triggered the failure.

If this is what happened, it's not a disaster --- the journal replay
will have correctly stopped where it should have, but it thought it
was an exceptional abort, as opposed to a normal journal replay
commpletion.  So the "file system is corrupted flag" will be set,
forcing an fsck, but the fsck shouldn't find any problems with the
file system.

Does this explanation seem to fit with how your test setup is
arranged?

     	  	      	      	       - Ted
