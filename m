Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1281473CC9D
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jun 2023 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjFXTkJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jun 2023 15:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFXTkI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jun 2023 15:40:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E24510C9
        for <linux-ext4@vger.kernel.org>; Sat, 24 Jun 2023 12:40:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35OJdO4o013225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 15:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687635569; bh=1YC4/ncstssRHOG8z3j8Cee2TMGjfDhXuHmQtvTDZVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SUGsHC/pyGCwMdsKREBdyz18U4bonF6NCQTcAYJdVrQ1uLyP2uaPeeh8yxYWKAM+C
         nm321uri1rRhUsrhuddodAip0/0ItgJYGH7gPN7W3O6BrQX+XjgV+6pxgIUG64OE2t
         qmPOwhVMYyIg6wYMRrDDKqGJR0PcAQIKcLtxoTM7BheePrRCVzY/PEqByY6ksDMQwU
         HTGA7LDTPulaJX4zt6SR5Kl2qX0Hxhh/iiuBBuoDPYLhuzzOr7kcfHR/gheO5egMcW
         9SbYDgbs5ZMpbMA/aBSVtybZUKQW+NGlzg78SfMcBn3Yc6P2jZ+992fN3f3bY+AUOs
         qO0ypJeJLl6kw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 788DE15C027E; Sat, 24 Jun 2023 15:39:24 -0400 (EDT)
Date:   Sat, 24 Jun 2023 15:39:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Sean Greenslade <sean@seangreenslade.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <20230624193924.GD8954@mit.edu>
References: <20230623143411.GF34229@mit.edu>
 <87leganq82.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leganq82.fsf@doe.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 23, 2023 at 09:08:37PM +0530, Ritesh Harjani wrote:
> It seems in the original code what we were trying to do was to preseve
> the error information area of superblock across journal load (which I am
> not sure why though?)
> 
> In the new code we see if the journal load changed that area and if yes
> we change that back to original log but we also marked changed = true. Why?

That's a good question; thanks for asking it.  The first part of this
code was introduced by commit 1c13d5c08728 ("ext4: Save error
information to the superblock for analysis") in 2010.  So that part of
the code is not "new", but very, very, old. 

The basic idea here was that back then, when a file system error was
detected, it was always written directly to the superblock, by passing
the journal.  So that's why the original code saved the error
information, replayed the journal and then restored it.

Of course, this changed with commit 2d01ddc86606 ("ext4: save error
info to sb through journal if available") in 2020.  But the problem is
"if available".  If the jbd2 layer has shut down, then we can't route
the superblock error updates through the journal, at which point ext4
will do a direct update of the superlbock.

This was the rational behind commit eee00237fa5e ("ext4: commit super
block if fs record error when journal record without error").
Sometimes the error bit EXT4_ERROR_FS is set via a direct write to the
superblock; but other times the error bit might be set via the
journal.  In the former case, after we do a journal replay, the error
bit will be cleared.  However, since the kernel never clears the
EXT4_ERROR_FS bit, it's pretty easy for commit eee00237fa5e to handle
things.

So what we need to for that first part of the code, introduced in
commit 1c13d5c08728 and made invalid in commit 2d01ddc86606 is we need
to add code to examine s_last_error_time.  If the version that was
originally in the superblock is newer than the version found after the
journal replay, then presumably an error happened but ext4 wasn't able
to write the error information out through the journal, and we need to
replace it after the the call to jbd2_journal_load().

Cheers,

						- Ted
