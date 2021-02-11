Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD8318BC6
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 14:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBKNQh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 08:16:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:54404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhBKNO2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 08:14:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99560AD29;
        Thu, 11 Feb 2021 13:13:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3F01D1E14B2; Thu, 11 Feb 2021 14:13:42 +0100 (CET)
Date:   Thu, 11 Feb 2021 14:13:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Updated locking documentation for transaction_t
Message-ID: <20210211131342.GQ19070@quack2.suse.cz>
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
 <20210211093027.GI19070@quack2.suse.cz>
 <1803ac43-d6fc-4de8-78a0-7fc807f9c036@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1803ac43-d6fc-4de8-78a0-7fc807f9c036@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 10:53:51, Alexander Lochmann wrote:
> 
> 
> On 11.02.21 10:30, Jan Kara wrote:
> > >   	 */
> > >   	unsigned long		t_log_start;
> > > -	/* Number of buffers on the t_buffers list [j_list_lock] */
> > > +	/* Number of buffers on the t_buffers list [j_list_lock, no lock for quick racy checks] */
> > >   	int			t_nr_buffers;
> > 
> > So this case is actually somewhat different now that I audited the uses.
> > There are two types of users - commit code (fs/jbd2/commit.c) and others.
> > Other users properly use j_list_lock to access t_nr_buffers. Commit code
> > does not use any locks because committing transaction is fully in
> > ownership of the jbd2 thread and all other users need to check & wait for
> > commit to be finished before doing anything with the transaction's buffers.
> Mhm I see.
> What about '[..., no locks needed for jbd2 thread]'?

Sounds good to me.

> How do the others wait for the commit to be finished?

Well, usually they just don't touch buffers belonging to the committing
transation, they just store in b_next_transaction that after commit is
done, buffer should be added to the currently running transaction. There
are some exceptions though - e.g. jbd2_journal_invalidatepage() (called
from truncate code) which returns EBUSY in some rare cases and we use
jbd2_log_wait_commit() in ext4_wait_for_tail_page_commit() to wait for
commit to be done before we know it is safe to destroy the buffer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
