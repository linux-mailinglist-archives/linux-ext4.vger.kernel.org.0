Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED775E1C89
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390056AbfJWN1W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 09:27:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfJWN1W (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 09:27:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A880CB88E;
        Wed, 23 Oct 2019 13:27:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 415D11E4A89; Wed, 23 Oct 2019 15:27:19 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:27:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 18/22] jbd2: Reserve space for revoke descriptor blocks
Message-ID: <20191023132719.GB31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-18-jack@suse.cz>
 <20191021214754.GC24015@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021214754.GC24015@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 17:47:54, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:06:04AM +0200, Jan Kara wrote:
> > Extend functions for starting, extending, and restarting transaction
> > handles to take number of revoke records handle must be able to
> > accommodate. These functions then make sure transaction has enough
> > credits to be able to store resulting revoke descriptor blocks. Also
> > revoke code tracks number of revoke records created by a handle to catch
> > situation where some place didn't reserve enough space for revoke
> > records. Similarly to standard transaction credits, space for unused
> > reserved revoke records is released when the handle is stopped.
> > 
> > On the ext4 side we currently take a simplistic approach of reserving
> > space for 1024 revoke records for any transaction. This grows amount of
> > credits reserved for each handle only by a few and is enough for any
> > normal workload so that we don't hit warnings in jbd2. We will refine
> > the logic in following commits.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> So let me summarize the way I think this commit is handling things.
> 
> 1) When a handle is created, the caller specifies how many revokes it
> plans to do.  If during the life of the handle, more than this number
> of revokes are done, a warning will be emited.

Correct.

> 2) For the purposes of reserving transaction credits, when we start
> the handle we assume the worst case number of number of revoke
> descriptors necessary, and we reserve that much space, and we add it
> to t_oustanding_credits.

Again correct.

> 3) When we stop the handle, we decrement t_outstanding_credits by the
> number of blocks that were originally reserved for this handle --- but
> *not* the number of worst case revoke descriptor blocks needed.  Which
> means that after the handle is started and then closed,
> t_outstanding_credits will be increased by ROUND_UP((max # of revoked
> blocks) / # of revoke blocks per block group descriptor).
> 
> If we delete a large number of files which are but a single 4k block
> in data=journal mode, each deleted file will increase
> t_outstanding_credits by one block, even though we won't be using
> anywhere *near* that number of blocks for revoke blocks.  So we will
> end up closing the transactions *much* earlier than we would have.

Right. Any handle that revokes at least one block will reserve at least one
block for revoke descriptor. I agree that will overestimate number of
necessary revoke blocks heavily in some cases. If you think that's
problematic, I can refine the logic so that rounding errors don't
accumulate that much (probably by tracking exact number of revokes in the
transaction).

> It also means that t_outstanding_credits will be a much higher number
> that we would ever need, so it's not clear to me why it's worth it to
> decrement t_outstanding_credits in jbd2_journal_get_descriptor_buffer()
> and warn if it is less than zero. 

Well, that tracking is a sanity check that we did reserve enough descriptor
blocks for each transaction.

> And it goes back to the question I had asked earler: "so what is the
> formal definition of t_outstanding_credits after this patch series,
> anyway"?

That should be answered in my previous answer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
