Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19CAEE09F
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 14:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfKDNIc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 08:08:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37383 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727454AbfKDNIc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 08:08:32 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4D8QxB004393
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 08:08:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F4160420311; Mon,  4 Nov 2019 08:08:23 -0500 (EST)
Date:   Mon, 4 Nov 2019 08:08:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 21/22] ext4: Reserve revoke credits for freed blocks
Message-ID: <20191104130823.GC28764@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-21-jack@suse.cz>
 <20191021231818.GF24015@mit.edu>
 <20191023161314.GD31271@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023161314.GD31271@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 06:13:14PM +0200, Jan Kara wrote:
> > It would probably be better to push this up to the callers, since we
> > can get the exact number by calculating
> > 
> > 	(EXT4_B2C(sbi, last) - EXT4_B2C(sbi, first) + 1) * sbi->s_cluster_ratio
> > 
> > This is a bit more complicated in fs/ext4/indirect.c, where we
> > probably will need to do a min of the these two formulas.
> 
> Is it worth the complexity at the callers? If we don't use some reserved
> revoke credits, we'll just return them back. And the truncate code
> generally works one extent at a time so in the end we may have just asked
> for 1 more descriptor block than strictly necessary while the handle is
> running...

Sure, this is a change we can make later if we think it's necessary.
Bigalloc file systems aren't that common, and when they are used, most
of the time people aren't creating large numbers of small files and/or
directories.

> Yes, I was thinking about the same. Extent format of revoke blocks would
> certainly reduce the number of revoke descriptor blocks in the average
> case. On the other hand I think that especially large directories can be
> pretty fragmented so it isn't clear how big the average win would be. And
> as you say the worst case estimate would not really change substantially
> with the different format so to make the filesystem resistent to malicious
> attacker we need some form of reservation of revoke descriptor blocks
> anyway. So in the end I've decided to go without on-disk format change for
> now.

Adding a new on-disk journal format is easier than making other ext4
format changes, since the journal is transient, and the case where the
user is simultaneously (a) rolling back to an older kernel which might
not support the new journal feature, and (b) crashes so that journal
replay is necessary, and (c) it's the root file system, so e2fsck
can't take care of the journal replay is a pretty rare / edge case.

That being said, we can set that aside as a possible later
enhancement.  I suspect the main place we would have the large
contiguous range fo blocks to be revoked is the data=journal case, and
one of the things I keep wondering about how much is it worth it to
keep that code.  So long as it's not posing a code maintenance burden,
I don't mind that much; but I also wonder how many people are actually
using it in practice.

Out of curiosity, how easily were you able to trigger the revoke
overflow situation using normal directories?  I would have expected it
would have been fairly difficult to do, except for large file
deletions with data=journal?

						- Ted
