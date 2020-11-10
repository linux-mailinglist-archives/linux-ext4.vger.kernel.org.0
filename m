Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00422AE009
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Nov 2020 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgKJTqa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Nov 2020 14:46:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55542 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbgKJTqa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Nov 2020 14:46:30 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AAJkNKv007881
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 14:46:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8D1D4420107; Tue, 10 Nov 2020 14:46:23 -0500 (EST)
Date:   Tue, 10 Nov 2020 14:46:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: looking for assistance with jbd2 (and other processes) hung
 trying to write to disk
Message-ID: <20201110194623.GC2951190@mit.edu>
References: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
 <20201110114202.GF20780@quack2.suse.cz>
 <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 10, 2020 at 09:57:39AM -0600, Chris Friesen wrote:
> No, there are quite a few of them.  I've included them below.  I agree, it's
> not clear who's holding the lock.  Is there a way to find that out?
> 
> Just to be sure, I'm looking for whoever has the BH_Lock bit set on the
> buffer_head "b_state" field, right?  I don't see any ownership field the way
> we have for mutexes.  Is there some way to find out who would have locked
> the buffer?

It's quite possible that the buffer was locked as part of doing I/O,
and we are just waiting for the I/O to complete.  An example of this
is in journal_submit_commit_record(), where we lock the buffer using
lock_buffer(), and then call submit_bh() to submit the buffer for I/O.
When the I/O is completed, the buffer head will be unlocked, and we
can check the buffer_uptodate flag to see if the I/O completed
successfully.  (See journal_wait_on_commit_record() for an example of
this.)

So the first thing I'd suggest doing is looking at the console output
or dmesg output from the crashdump to see if there are any clues in
terms of kernel messages from the device driver before things locked
up.  This could be as simple as the device falling off the bus, in
which case there might be some kernel error messages from the block
layer or device driver that would give some insight.

Good luck,

					- Ted
