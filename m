Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D817D1F65C8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFKKhM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jun 2020 06:37:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgFKKhL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Jun 2020 06:37:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9656BAC46;
        Thu, 11 Jun 2020 10:37:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 70CEE1E1283; Thu, 11 Jun 2020 12:37:09 +0200 (CEST)
Date:   Thu, 11 Jun 2020 12:37:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: jbd2: can b_transaction be NULL in refile_buffer ?
Message-ID: <20200611103709.GB19132@quack2.suse.cz>
References: <20200611083417.4akdykeubd7kfuuh@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611083417.4akdykeubd7kfuuh@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Thu 11-06-20 10:34:17, Lukas Czerner wrote:
> I am tracking a rare and very hard to reproduce bug that ends up hittng
> 
> J_ASSERT_JH(jh, jh->b_transaction == NULL)
> 
> in __journal_remove_journal_head(). In fact we can get there with
> b_next_transaction set and b_jlist == BJ_Forget so it's clear that we
> should not have dropped the last JH reference at that point.
> 
> Most of the time that I've seen we get there from
> __jbd2_journal_remove_checkpoint() called from
> jbd2_journal_commit_transaction().
> 
> The locking in and around grabbing and putting the journal head
> reference (b_jcount) looks solid as well as the use of j_list_lock. But
> I have noticed a problem in logic of __jbd2_journal_refile_buffer().

Yeah, the trouble with refcounting bugs is that if *any* of the users
releases a reference it should not, we will (much later) hit the problem you
describe.

> The idea is that b_next_transaction will inherit the reference from
> b_transaction so that we do not need to grab a new reference of
> journal_head. However this will only be true if b_transaction is set.
>
> But if it is indeed NULL, then we will do
> 
> WRITE_ONCE(jh->b_transaction, jh->b_next_transaction);
> 
> and __jbd2_journal_file_buffer() will not grab the jh reference. AFAICT
> the b_next_transaction is not holding it's own jh reference. This will
> result in b_transaction _not_ holding it's own jh reference and we will
> be able to drop the last jh reference at unexpected places - hence we can
> hit the asserts in __journal_remove_journal_head().
>
> However I am not really sure if it is indeed possible to get into
> __jbd2_journal_refile_buffer() with b_transaction == NULL and
> b_next_transaction set. Jan do you have any idea if that's possible and
> what would be the circumstances to lead us there ?

__jbd2_journal_refile_buffer() should always be called with b_transaction
!= NULL and as I've checked (all three) callers, that indeed seems to be
the case. Feel free to add assert along those lines to
__jbd2_journal_refile_buffer() to see whether it triggers...

> Regardless I still think this is a bug in the logic and we should either
> make sure that b_transaction is _not_ NULL in
> __jbd2_journal_refile_buffer(), or let __jbd2_journal_file_buffer() grab
> the jh reference if b_transaction was indeen NULL. How about something
> like the following untested patch ?

I'd rather got for the assert. It makes things simpler, also the "meaning"
of __jbd2_journal_refile_buffer() is "jh is done in its current
transaction, deal with it" and that doesn't have a great meaning if
b_transaction is NULL.

And when you're adding asserts, then adding one in
__jbd2_journal_unfile_buffer() checking b_transaction != NULL and
b_next_transaction == NULL would be good as well because lot of callers
assume this. I've checked the code and I didn't find any problematic one
but that code is complex enough that I could have missed something.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
