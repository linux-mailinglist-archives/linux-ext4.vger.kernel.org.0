Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE57589DDA
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiHDOqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiHDOqA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 10:46:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD8E1A82A
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 07:45:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 274EjjYZ012421
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Aug 2022 10:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659624346; bh=pRmSUd1EoEFpb3TNDL28gZctGYf5YR6L//sWKjJLihE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VHPn/vp4NkkVLR0/1oy5MmWSa1MQikEjGmbwJuV51jgkr7peGy7rvAAqqwv56H6U8
         MeXOKwEgROBxiVEBZFWhov+A9zcfJQRZUrfft8PWFL4VqgtBzRu9WAuWzstInTlq1V
         owYkn/E9JR98tYp4uPSuUaBmws39LdPmeTDDMkS/kfT6Oz696+e6kAhe0rmI/nXEk7
         uUSU4DsSzDF1kBiNUQtV0pz5dWhwhUpK8YFCKX1VA32DdObGyxUHr8zVyZx838UJ+O
         LoARp/FfUToM+EPcpm1HT0iQJ0tAK1+1tCxkKrstiJx1vqZhBGx5/JN4t882UPXwBU
         UeVFl5DTBqa5Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E6CE815C00E4; Thu,  4 Aug 2022 10:45:44 -0400 (EDT)
Date:   Thu, 4 Aug 2022 10:45:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1
 tasks refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Message-ID: <YuvbmJRRUcemgPhp@mit.edu>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
 <bug-216322-13602-2MvUDlAfJU@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216322-13602-2MvUDlAfJU@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 04, 2022 at 11:47:47AM +0000, bugzilla-daemon@kernel.org wrote:
> 
> I agree that the FITRIM interface is flawed in this way. But
> ext4_try_to_trim_range() actually does have fatal_signal_pending() and
> will return -ERESTARTSYS if that's true. Or did you have something else in
> mind?

The fatal_signal_pending() only checks for SIGKILL.  I'm not sure why
it returns ERESTARTSYS, since that's not applicable for a kill -9
signal.  The fake_signal_wake_up() function in kernel/freezer.c
doesn't send a fatal signal, so the fatal_signal_pending() check isn't
going to help here.

> Also in that case, I see no reason why we would not be able to adjust
> the fstrim_range to make it easier to re-start where we left off if
> we're going to return -ERESTARTSYS. I am missing something?

Well, we could adjust fstrim_range.start and fstrim_range.len to make
it easier to restart --- but that's only if we know for sure that
we're going to be restarting the system call.  So we need to break
some abstraction barriers since if the signal is one where based on
the sigaction flags, the system all is *not* restarted, then
fstrim_range.len is supposed to contain the number of bytes trimmed.

And even if the system call is restarted, there's no place to stash
the number of bytes trimmed so far, since fstrim_range.len is
overloaded.   This why the interface is so horrible...

> I have not had time to look deeply into the traces, but are you actually
> sure that we're not stuck in blkdev_issue_discard() instead?

I'm not 100% certain, but unless the block device has been put to
sleep first (in which case I think we would have noticed much sooner
since lots of other suspend-to-ram use cases would be failling --- in
writeback threads, for example), I'd be really surprised if we're
getting stuck there.

Even when we need to wait for the queue to be drained so there is
space to send the next discard, that shouldn't take 60+ seconds.

      	      	       		     	       - Ted
