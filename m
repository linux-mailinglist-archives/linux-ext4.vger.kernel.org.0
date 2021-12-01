Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA319465039
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Dec 2021 15:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhLAOqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Dec 2021 09:46:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56034 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239125AbhLAOnO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Dec 2021 09:43:14 -0500
Received: from callcc.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B1EdhZk022409
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Dec 2021 09:39:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6E74842004A; Wed,  1 Dec 2021 09:39:43 -0500 (EST)
Date:   Wed, 1 Dec 2021 09:39:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: implement support for get/set fs label
Message-ID: <YaeJL8bOsGqBWR7P@mit.edu>
References: <20211111215904.21237-1-lczerner@redhat.com>
 <20211112082019.22078-1-lczerner@redhat.com>
 <YaWTuCoIyaDBsUWF@mit.edu>
 <20211130094950.ixqkxrjne6ldryeg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130094950.ixqkxrjne6ldryeg@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 30, 2021 at 10:49:50AM +0100, Lukas Czerner wrote:
> > But after that?  I'd suggest not running the updates for the rest
> > through the journal at all, and just write them out directly.  Nothing
> > else will try to read or write the backup superblock blocks, so
> > there's no reason why we have to be super careful writing out the
> > rest.  If we crash after we've only updated the first 20 backup
> > superblocks --- that's probably 18 more than a user will actually use
> > in the first place.
> > 
> > That allows us to simply reserve 3 credits, and we won't need to try
> > to extend the handle, which means we don't have to implement some kind
> > of fallback logic in case the handle extension fails.
> 
> I think I agree. But in this case should we at least attempt to check
> and update the backup superblocks in fsck? Not sure if we do that
> already.

Well, after a successful file system check by fsck, we'll update all
of the backup superblocks.  If we've done a full file system check we
know that the primary superblock is consistent with the rest of the
file system, so at that point it's safe to write it to all of the
backup superblocks in the file system.

But if we haven't done the full file system check, we won't know
whether it is the primary or the backup superblock which is incorrect.
I guess we could do the basic superblock checks, and if there are at
least two additional superblocks, we see if we have do a 2 out of 3
voting check.  Or if there are differences between the primary and the
backup we could force a full check.

I think in practice though, so long as the primary and two backup
superblocks are part of the jbd2 transaction, that should be good
enough in terms of recovery since usually most users only use the
first backup superblock to recover if the primary is damaged.  Whether
we update the rest of the backup superblocks improves things, but it's
not really going to make a difference 99.99% of the time.

    	   	    	   	      	     - Ted
