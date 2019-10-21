Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A31DF7B0
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfJUVsB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 17:48:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39800 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbfJUVsB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 17:48:01 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LLltSP000324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 17:47:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D2023420456; Mon, 21 Oct 2019 17:47:54 -0400 (EDT)
Date:   Mon, 21 Oct 2019 17:47:54 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 18/22] jbd2: Reserve space for revoke descriptor blocks
Message-ID: <20191021214754.GC24015@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-18-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-18-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:06:04AM +0200, Jan Kara wrote:
> Extend functions for starting, extending, and restarting transaction
> handles to take number of revoke records handle must be able to
> accommodate. These functions then make sure transaction has enough
> credits to be able to store resulting revoke descriptor blocks. Also
> revoke code tracks number of revoke records created by a handle to catch
> situation where some place didn't reserve enough space for revoke
> records. Similarly to standard transaction credits, space for unused
> reserved revoke records is released when the handle is stopped.
> 
> On the ext4 side we currently take a simplistic approach of reserving
> space for 1024 revoke records for any transaction. This grows amount of
> credits reserved for each handle only by a few and is enough for any
> normal workload so that we don't hit warnings in jbd2. We will refine
> the logic in following commits.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

So let me summarize the way I think this commit is handling things.

1) When a handle is created, the caller specifies how many revokes it
plans to do.  If during the life of the handle, more than this number
of revokes are done, a warning will be emited.

2) For the purposes of reserving transaction credits, when we start
the handle we assume the worst case number of number of revoke
descriptors necessary, and we reserve that much space, and we add it
to t_oustanding_credits.

3) When we stop the handle, we decrement t_outstanding_credits by the
number of blocks that were originally reserved for this handle --- but
*not* the number of worst case revoke descriptor blocks needed.  Which
means that after the handle is started and then closed,
t_outstanding_credits will be increased by ROUND_UP((max # of revoked
blocks) / # of revoke blocks per block group descriptor).

If we delete a large number of files which are but a single 4k block
in data=journal mode, each deleted file will increase
t_outstanding_credits by one block, even though we won't be using
anywhere *near* that number of blocks for revoke blocks.  So we will
end up closing the transactions *much* earlier than we would have.

It also means that t_outstanding_credits will be a much higher number
that we would ever need, so it's not clear to me why it's worth it to
decrement t_outstanding_credits in jbd2_journal_get_descriptor_buffer()
and warn if it is less than zero.    And it goes back to the question
I had asked earler: "so what is the formal definition of 
t_outstanding_credits after this patch series, anyway"?

						- Ted
