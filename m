Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF4B2D56
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 01:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfINX2G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 19:28:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53292 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725795AbfINX2G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 19:28:06 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8ENS1ST015477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 19:28:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1985F420811; Sat, 14 Sep 2019 19:28:01 -0400 (EDT)
Date:   Sat, 14 Sep 2019 19:28:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Pas <pas@zomg.hu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: inline_data status (e2fsprogs)
Message-ID: <20190914232801.GD19710@mit.edu>
References: <CAF1H-TADHtpDtdL++Vk1FLAL7jJbOOifnN+7taDXpVkjYrbsgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1H-TADHtpDtdL++Vk1FLAL7jJbOOifnN+7taDXpVkjYrbsgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 08:06:04PM +0200, Pas wrote:
> 
> I hope this is the correct forum to ask these questions. (If not, then
> sorry for the noise! Though then could you recommend where to ask
> them?)

There are some known issues with with the inline_data feature; in
particular, it violates some of the jbd2 rules about how to jorunal
data blocks.  As such, bad things(tm) can happen on crash recovery.
For the most part it works OK for the original intended use case, was
for bigalloc file systems where there was a desire to handle small
directories more efficiently, which was how the developer who created
the feature used said feature.  I didn't realize this particular
rather serious bug until after the feature went into the kernel, and
it's been on my todo list to fix; I just haven't had the time.

It doesn't happen all that often; you need to start files that are
small enough such that they can fit in an inline_data file, and then
grow them via an appending write so that they need to be shifted to an
block allocated file, and then force an unclean shutdown at an
inopportune time.

But yeah, there is a good reason why it's not a default-enabled
feature.  It also generally doesn't buy you much for most file system
workloads, so it hasn't been high on my priority list to fix.

Regards,

					- Ted
