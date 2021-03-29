Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8062F34CDCB
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhC2KOy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 06:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:59204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhC2KOa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Mar 2021 06:14:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B271B3DF;
        Mon, 29 Mar 2021 10:14:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0EFC01E4353; Mon, 29 Mar 2021 12:14:29 +0200 (CEST)
Date:   Mon, 29 Mar 2021 12:14:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Jan Kara <jack@suse.cz>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Updated locking documentation for transaction_t
Message-ID: <20210329101429.GA4283@quack2.suse.cz>
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
 <20210211093027.GI19070@quack2.suse.cz>
 <ec682a4c-f4f7-35fe-dc35-6c0b53d6ecda@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec682a4c-f4f7-35fe-dc35-6c0b53d6ecda@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 26-03-21 09:18:45, Alexander Lochmann wrote:
> On 11.02.21 10:30, Jan Kara wrote:
> >> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> >> index 99d3cd051ac3..18f77d9b1745 100644
> >> --- a/include/linux/jbd2.h
> >> +++ b/include/linux/jbd2.h
> >> @@ -594,18 +594,18 @@ struct transaction_s
> >>  	 */
> >>  	unsigned long		t_log_start;
> >>  
> >> -	/* Number of buffers on the t_buffers list [j_list_lock] */
> >> +	/* Number of buffers on the t_buffers list [j_list_lock, no lock for quick racy checks] */
> >>  	int			t_nr_buffers;
> > 
> > So this case is actually somewhat different now that I audited the uses.
> > There are two types of users - commit code (fs/jbd2/commit.c) and others.
> > Other users properly use j_list_lock to access t_nr_buffers. Commit code
> > does not use any locks because committing transaction is fully in
> > ownership of the jbd2 thread and all other users need to check & wait for
> > commit to be finished before doing anything with the transaction's buffers.
> 
> I'm still trying understand how thinks work:
> Accesses to transaction_t might occur from different contexts. Thus,
> locks are necessary. If it comes to the commit phase, every other
> context has to wait until jbd2 thread has done its work. Therefore, jbd2
> thread does not need any locks to access a transaction_t (or just parts
> of it?) during commit phase.
> Is that correct?

Yes, that is correct.

> If so: I was thinking whether it make sense to ignore all memory
> accesses to a transaction_t (or parts of it) that happen in the commit
> phase. They deliberately ignore the locking policy, and would confuse
> our approach.
> 
> Is the commit phase performed by jbd2_journal_commit_transaction()?
> We would add this function to our blacklist for transaction_t.

Yes, commit phase is implemented by jbd2_journal_commit_transaction() and
the functions it calls.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
