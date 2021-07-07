Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C53BF2A1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGGXz0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 19:55:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55056 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229519AbhGGXz0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 19:55:26 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 167NqfuW015376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jul 2021 19:52:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2ED0115C3CC6; Wed,  7 Jul 2021 19:52:41 -0400 (EDT)
Date:   Wed, 7 Jul 2021 19:52:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ivan Zahariev <famzah@famzah.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: jbd2: fix deadlock while checkpoint thread waits commit thread
 to finish (backport to 4.14)
Message-ID: <YOY+SXgPShxGzyJO@mit.edu>
References: <3221ced0-e8f3-53da-3474-28367272f35d@famzah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3221ced0-e8f3-53da-3474-28367272f35d@famzah.net>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 07, 2021 at 09:42:25PM +0300, Ivan Zahariev wrote:
> Hello,
> 
> We're running Linux kernel 4.14.x and our systems occasionally suffer a bug
> which is already fixed: https://github.com/torvalds/linux/commit/53cf978457325d8fb2cdecd7981b31a8229e446e
> 
> This bugfix hasn't been ported to Linux kernels 4.14 or 4.19. The patch
> applies cleanly. The two files "fs/jbd2/checkpoint.c" and
> "fs/jbd2/journal.c" seem pretty identical in the affected sections compared
> to kernel 5.4 where we have this bugfix already applied.
> 
> Is it on purpose that this bugfix hasn't been ported to 4.14? Is it safe
> that we backport it manually in our kernel 4.14 builds? Or is the "ext4"
> system in 4.14 and 5.4 fundamentally different and this would lead to data
> loss or other problems?

The commit was over two years ago, so my memory is not going to be
perfect.  However, Jan had made a comment suggesting the approach in
this commit because it should be easier to backport into older stble
kernels[1].

   "Since proper locking change is going to be a bit more involved, can you
    perhaps fix this deadlock by just dropping j_checkpoint_mutex in
    log_do_checkpoint() when we are going to wait for transaction commit. I've
    checked and that should be fine and that is going to be much easier change
    to backport into stable kernels..."

[1] https://marc.info/?l=linux-ext4&m=154212553014669&w=2

So I suspect it was just that I failed to remember to add a "Cc:
stable@kernel.org" and so it was never automatically backported into
4.14 or 4.19.

Do you have a reliable reproduction which is triggering the deadlock
on your kernels?  If so, have you tried applying the patch and does it
make the problem go away for you?

Cheers,

						- Ted
