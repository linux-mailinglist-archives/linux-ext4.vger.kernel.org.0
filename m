Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF5EF74D
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfKEIbE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 03:31:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:46508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387686AbfKEIbE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 03:31:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08080B1DD;
        Tue,  5 Nov 2019 08:31:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BFF081E4407; Tue,  5 Nov 2019 09:31:02 +0100 (CET)
Date:   Tue, 5 Nov 2019 09:31:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 21/22] ext4: Reserve revoke credits for freed blocks
Message-ID: <20191105083102.GG22379@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-21-jack@suse.cz>
 <20191021231818.GF24015@mit.edu>
 <20191023161314.GD31271@quack2.suse.cz>
 <20191104130823.GC28764@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104130823.GC28764@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 04-11-19 08:08:23, Theodore Y. Ts'o wrote:
> On Wed, Oct 23, 2019 at 06:13:14PM +0200, Jan Kara wrote:
> > Yes, I was thinking about the same. Extent format of revoke blocks would
> > certainly reduce the number of revoke descriptor blocks in the average
> > case. On the other hand I think that especially large directories can be
> > pretty fragmented so it isn't clear how big the average win would be. And
> > as you say the worst case estimate would not really change substantially
> > with the different format so to make the filesystem resistent to malicious
> > attacker we need some form of reservation of revoke descriptor blocks
> > anyway. So in the end I've decided to go without on-disk format change for
> > now.
> 
> Adding a new on-disk journal format is easier than making other ext4
> format changes, since the journal is transient, and the case where the
> user is simultaneously (a) rolling back to an older kernel which might
> not support the new journal feature, and (b) crashes so that journal
> replay is necessary, and (c) it's the root file system, so e2fsck
> can't take care of the journal replay is a pretty rare / edge case.

Yeah, agreed.

> That being said, we can set that aside as a possible later
> enhancement.  I suspect the main place we would have the large
> contiguous range fo blocks to be revoked is the data=journal case, and
> one of the things I keep wondering about how much is it worth it to
> keep that code.  So long as it's not posing a code maintenance burden,
> I don't mind that much; but I also wonder how many people are actually
> using it in practice.

Agreed as well. From time to time I spot some data=journal users but they
are really rare.

> Out of curiosity, how easily were you able to trigger the revoke
> overflow situation using normal directories?  I would have expected it
> would have been fairly difficult to do, except for large file
> deletions with data=journal?

Yes, triggering the situation with normal directories is not easy. Although
with 1k blocksize, already deleting 32MB worth of directories, which isn't
that huge, overruns the default reserve we have for descriptor blocks by
quite a bit. Now if that happens in a situation where the transaction was
just about to fit in the free space in the journal, you get the assertion
failure. I didn't try to reproduce this since triggering the assertion with
data=journal is much faster and easier (so that's what I used for testing)
but our customer accidentally hit this so it's certainly possible (although
he was the first one in all those years).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
