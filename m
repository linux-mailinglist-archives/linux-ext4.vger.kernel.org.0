Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECADF73F
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfJUVE0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 17:04:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57189 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387407AbfJUVE0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 17:04:26 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LL4KZL018418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 17:04:21 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8DF28420456; Mon, 21 Oct 2019 17:04:20 -0400 (EDT)
Date:   Mon, 21 Oct 2019 17:04:20 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 16/22] jbd2: Account descriptor blocks into
 t_outstanding_credits
Message-ID: <20191021210420.GA24015@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-16-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-16-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:06:02AM +0200, Jan Kara wrote:
> Currently, journal descriptor blocks were not accounted in
> transaction->t_outstanding_credits and we were just leaving some slack
> space in the journal for them (in jbd2_log_space_left() and
> jbd2_space_needed()). This is making proper accounting (and reservation
> we want to add) of descriptor blocks difficult so switch to accounting
> descriptor blocks in transaction->t_outstanding_credits and just reserve
> the same amount of credits in t_outstanding credits for journal
> descriptor blocks when creating transaction.

This changes the meaning of t_oustanding credits; in particular the
documentation of t_outstanding_credits in include/linux/jbd2.h is no
longer correct, as it currently defines it has containing:

     Number of buffers reserved for use by all handles in this transaction
     handle but not yet modified. [none]

Previously, t_outstanding_credits would go to zero once all of the
handles attached to the transaction were closed.  Now, it is
initialized to j_max_transaction_buffers >> 32, and once all of the
handles are closed t_outstanding_credits will go back to that value.
It then gets decremented as we write each jbd descriptor block
(whether it is for a revoke block or a data block) during the commit
and we throw a warning if we ever write more than j_max_transaction_buffers >> 32
descriptor blocks.

Is that a fair summary of what happens after this commit?

The thing is, I don't see how this helps the rest of the patch series;
we account for space needed for the revoke blocks in later patches,
but I don't see that adjusting t_outstanding credits.  We reserve
extra space for the revoke blocks, and we then account for that space,
but the fact that we have accounted for all of the extra descriptor
blocks in t_outstanding_credits doesn't seem to be changed.  As a
result, we appear to be double-counting the space needed for the
revoke descriptor blocks.  Which is fine; I don't mind the accounting
being a bit more conservative, but I find myself being a bit puzzled
about why this change is necessary or adds value.

What am I missing?

						- Ted
