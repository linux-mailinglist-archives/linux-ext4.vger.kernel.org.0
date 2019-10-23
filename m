Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAAE2044
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404540AbfJWQNR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 12:13:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404449AbfJWQNR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 12:13:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FDA1B722;
        Wed, 23 Oct 2019 16:13:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A47B61E4A99; Wed, 23 Oct 2019 18:13:14 +0200 (CEST)
Date:   Wed, 23 Oct 2019 18:13:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 21/22] ext4: Reserve revoke credits for freed blocks
Message-ID: <20191023161314.GD31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-21-jack@suse.cz>
 <20191021231818.GF24015@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021231818.GF24015@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 19:18:18, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:06:07AM +0200, Jan Kara wrote:
> > +static inline int ext4_free_data_revoke_credits(struct inode *inode, int blocks)
> > +{
> > +	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> > +		return 0;
> > +	if (!ext4_should_journal_data(inode))
> > +		return 0;
> > +	/*
> > +	 * Data blocks in one extent are contiguous, just account for partial
> > +	 * clusters at extent boundaries
> > +	 */
> > +	return blocks + 2*EXT4_SB(inode->i_sb)->s_cluster_ratio;
> > +}
> 
> This looks *way* too conservative.  At the very least, this should be:
> 
> 
> 	return blocks + 2*(EXT4_SB(inode->i_sb)->s_cluster_ratio - 1);
> 
> Since when the cluster ratio is 1, there is no partial clusters at the
> extent boundaries, and if bigalloc is enabled, and the cluster ratio
> is 16, the worst case of "extra" blocks" at the boundaries would be 15.

OK, I will update that. Thanks for correction.

> It would probably be better to push this up to the callers, since we
> can get the exact number by calculating
> 
> 	(EXT4_B2C(sbi, last) - EXT4_B2C(sbi, first) + 1) * sbi->s_cluster_ratio
> 
> This is a bit more complicated in fs/ext4/indirect.c, where we
> probably will need to do a min of the these two formulas.

Is it worth the complexity at the callers? If we don't use some reserved
revoke credits, we'll just return them back. And the truncate code
generally works one extent at a time so in the end we may have just asked
for 1 more descriptor block than strictly necessary while the handle is
running...

> The other thing which I wonder, looking at these, is whether it's
> worth it to add a new revoke table format which uses 8 or 12 bytes,
> where there is a block number followed by a 32-bit count field (e.g.,
> a revoke extent).
> 
> I actually suspect that if made the format change, with the revoke
> code using the revoke extent table if (a) a new journal feature flag
> allows it, and (b) using the revoke extent table would be beneficial,
> in the vast majority of cases, that might have addressed the problem
> that you saw without having to do the strict tracking of revoke
> blocks.  Of course, I'm sure it's still possible to create a worst
> case file system and workload where the revoke blocks could still
> overflow the journal --- but it would probably be very hard to do and
> would only show up in a malicious workload.
> 
> What do you think?

Yes, I was thinking about the same. Extent format of revoke blocks would
certainly reduce the number of revoke descriptor blocks in the average
case. On the other hand I think that especially large directories can be
pretty fragmented so it isn't clear how big the average win would be. And
as you say the worst case estimate would not really change substantially
with the different format so to make the filesystem resistent to malicious
attacker we need some form of reservation of revoke descriptor blocks
anyway. So in the end I've decided to go without on-disk format change for
now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
