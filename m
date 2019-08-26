Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC509D403
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfHZQaX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 12:30:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729951AbfHZQaX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 12:30:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DB38B03B;
        Mon, 26 Aug 2019 16:30:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 00D791E3DA1; Mon, 26 Aug 2019 18:30:20 +0200 (CEST)
Date:   Mon, 26 Aug 2019 18:30:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: JBD2 transaction running out of space
Message-ID: <20190826163020.GL10614@quack2.suse.cz>
References: <20190819085759.GB2491@quack2.suse.cz>
 <20190819161705.GB15175@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819161705.GB15175@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 19-08-19 09:17:05, Darrick J. Wong wrote:
> On Mon, Aug 19, 2019 at 10:57:59AM +0200, Jan Kara wrote:
> > Hello,
> > 
> > I've recently got a bug report where JBD2 assertion failed due to
> > transaction commit running out of journal space. After closer inspection of
> > the crash dump it seems that the problem is that there were too many
> > journal descriptor blocks (more that max_transaction_size >> 5 + 32 we
> > estimate in jbd2_log_space_left()) due to descriptor blocks with revoke
> > records. In fact the estimate on the number of descriptor blocks looks
> > pretty arbitrary and there can be much more descriptor blocks needed for
> > revoke records. We need one revoke record for every metadata block freed.
> > So in the worst case (1k blocksize, 64-bit journal feature enabled,
> > checksumming enabled) we fit 125 revoke record in one descriptor block.  In
> > common cases its about 500 revoke records per descriptor block. Now when
> > we free large directories or large file with data journalling enabled, we can
> > have *lots* of blocks to revoke - with extent mapped files easily millions
> > in a single transaction which can mean 10k descriptor blocks - clearly more
> > than the estimate of 128 descriptor blocks per transaction ;)
> 
> Can jbd2 make the jbd2_journal_revoke caller wait until it has
> checkpointed the @blocknr block if it has run out of revoke record
> space?

That would be really hard to implement without introducing deadlocks
(checkpoint of a transaction may need to wait for currently committing
transaction to finish commit in some cases). Also as you mention below, it
isn't even guaranteed revoke descriptor blocks fit into a journal if we
don't limit them in some way.

> > Now users clearly don't hit this problem frequently so this is not common
> > case but still it is possible and malicious user could use this to DoS the
> > machine so I think we need to get even the weird corner-cases fixed. The
> > question is how because as sketched above the worst case is too bad to
> > account for in the common case. I have considered three options:
> > 
> > 1) Count number of revoke records currently in the transaction and add
> > needed revoke descriptor blocks to the expected transaction size. This is
> > easy enough but does not solve all the corner cases - single handle
> > can add lot of revoke blocks which may overflow the space we reserve for
> > descriptor blocks.
> > 
> > 2) Add argument to jbd2_journal_start() telling how many metadata blocks we
> > are going to free and we would account necessary revoke descriptor blocks
> > into reserved credits. This could work, we would generally need to pass
> > inode->i_blocks / blocksize as the estimate of metadata blocks to free (for
> > inodes to which this applies) as we don't have better estimate but I guess
> > that's bearable. It would require some changes on ext4 side but not too
> > intrusive.
> 
> What happens if iblocks / blocksize revoke records exceeds the size of
> the journal?

That's a good point. Doing some math this could happen when we have e.g. a
file with journalled data that is couple GB large. However looking into the
code we could use the fact that we actually truncate file
one-extent-at-a-time, thus we in fact know exactly how many blocks we are
going to free and maximum number of blocks in an extent (65535) generates
~524 revoke descriptor blocks in the worst case which still reasonably fits
within a transaction. So this seems fixable. Thanks for input!

								Honza

> > 3) Use the fact that we need to revoke only blocks that are currently in
> > the journal. Thus the number of revoke records we really may need to store
> > is well bound (by the journal size). What is a bit painful is tracking of
> > which blocks are journalled. We could use a variant of counting Bloom
> > filters to store that information with low memory consumption (say 64k of
> > memory in common case) and high-enough accuracy but still that will be some
> > work to write. On the plus side it would reduce the amount revoke records
> > we have to store even in common case.
> > 
> > Overall I'm probably leaning towards 2) but I'm happy to hear more opinions
> > or ideas :)
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
