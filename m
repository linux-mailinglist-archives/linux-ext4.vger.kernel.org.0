Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F14B2D50F
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 07:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfE2FXn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 01:23:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58919 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbfE2FXm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 01:23:42 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4T5NWrr009418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:23:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40ECE420481; Wed, 29 May 2019 01:23:32 -0400 (EDT)
Date:   Wed, 29 May 2019 01:23:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190529052332.GB6210@mit.edu>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
 <20190528034830.GH10043@codeaurora.org>
 <20190528131356.GB19149@mit.edu>
 <20190529040757.GI10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529040757.GI10043@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 09:37:58AM +0530, Sahitya Tummala wrote:
> 
> Here is what I think on these mount options. Please correct me if my
> understanding is wrong.
> 
> The nobarrier mount option poses risk even if there is a battery
> protection against sudden power down, as it doesn't guarantee the ordering
> of important data such as journal writes on the disk. On the storage
> devices with internal cache, if the cache flush policy is out-of-order,
> then the places where FS is trying to enforce barriers will be at risk,
> causing FS to be inconsistent.

If you have protection against sudden shutdown, then nobarrier is
perfectly safe --- which is to say, if it is guaranteed that any
writes sent to device will be persisted after a crash, then nobarrier
is perfectly safe.  So for example, if you are using ext4 connected to
a million dollar EMC Storage Array, which has battery backup, using
nobarrier is perfectly safe.

That's because we still send writes to the device in an appropriate
order in nobarrier mode --- in particular, we send the journal updates
to the device in order.  The cache flush policy on the HDD is
out-of-order, but so long as they all make it out to persistant store
in the end, it'll be fine.

> But whereas with fsync_mode=nobarrier, FS is not trying to enforce
> any ordering of data on the disk except to ensure the data is flushed
> from the internal cache to non-volatile memory. Thus, I see this
> fsync_mode=nobarrier is much better than a general nobarrier. And it
> provides better performance too as with nobarrier but without
> compromising much on FS consistency.

"without compomising much on FS consistency" doesn't have any meaning.
If you care about FS consistency, and you don't have power fail
protection, then at least for ext4, you *must* send a CACHE FLUSH
after any time that you modify any file system metadata block --- and
that's true for 99% of all fsync(2)'s.

I suppose you could do something where if there are times when no
metadata updates are necessary, but just data block writes, the CACHE
FLUSH could be suppressed.  But (a) this won't actually provide much
performance improvements for the vast majority of workloads,
especially on an Android system, and (b) you're making a value
judgement that FS consistency is more important than application data
consistency.


You didn't answer my question directly --- exactly what is your goal
that you are trying to achieve, and what assumptions you are willing
to make?  If you have power fail protection (this might require making
some adjustments to the EC), then you can use nobarrier and just not
worry about it.

If you don't have power fail protection, and you care about FS
consistency, then you pretty much have to leave the CACHE FLUSH
commands in.

If the problem is that some applications are fsync-happy, then I'd
suggest fixing the applications.  Or if you really don't care about
the applications working correctly or users suffering application data
loss after a crash, you could hack in a mode, so that for non-root
users, or maybe certain specific users, fsync is turned into a no-op,
or a background, asynchronous (non-integrity) writeback.

Are you trying to hit some benchmark target?  I'm really confused why
you would want to be so cavalier with application data safety.

    	       	     		      - Ted
