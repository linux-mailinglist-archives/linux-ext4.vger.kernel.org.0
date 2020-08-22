Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37E24E7EB
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgHVOdb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 10:33:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37199 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbgHVOdb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Aug 2020 10:33:31 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07MEXR2U014993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 10:33:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DDDB442010C; Sat, 22 Aug 2020 10:33:26 -0400 (EDT)
Date:   Sat, 22 Aug 2020 10:33:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
Message-ID: <20200822143326.GC199705@mit.edu>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
> >>> Resending this one, as I've been carrying it privately since May. The
> >>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
> >>> please consider this one for 5.9. Thanks!
> >>
> >> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
> >> missing something?  It's on my queue to send to Linus once I get my
> >> (late) ext4 primary pull request for 5.9.
> > 
> > Right, it went in at the start of the merge window for 5.9. Thanks Ted!
> 
> Didn't see it in the queue that just sent in, is it still queued up?

It wasn't in the queue which I queued up because that was based on
5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
that's totally on me.

He has said that he's going to start ignoring pull requests that
aren't fixes only if this becomes a pattern, so while I can send him
another pull request which will just have that one change, there are
no guarantees he's going to take it at this late date.

Sorry, when you sent me the commit saying that the changes that were
needed were already upstream on August 3rd, I thought that meant that
they were aready in Linus's tree.  I should have checked and noticed
that that in fact "ext4: flag as supporting buffered async reads"
wasn't compiling against Linus's upstream tree, so I didn't realize
this needed to be handled as a special case during the merge window.

Cheers,

					- Ted
