Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBC3420B1
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSPRY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 11:17:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50564 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229978AbhCSPQ5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Mar 2021 11:16:57 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12JFGrIB019344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 11:16:54 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 526B815C39CA; Fri, 19 Mar 2021 11:16:53 -0400 (EDT)
Date:   Fri, 19 Mar 2021 11:16:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shashidhar Patil <shashidhar.patil@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
Message-ID: <YFTAZdfbKUsMmb9A@mit.edu>
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
 <YEtjuGZCfD+7vCFd@mit.edu>
 <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
 <YE2FOTpWOaidmT52@mit.edu>
 <CADve3d4h7QmxJUCe8ggHtSb41PbDnvZoj4_m74hHgYD96xjZNw@mail.gmail.com>
 <YFI299oMXylsG9kB@mit.edu>
 <CADve3d7gZVP_wzuRFymox9EEU05jbsTGdf=nGOAHeouBuR1jog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADve3d7gZVP_wzuRFymox9EEU05jbsTGdf=nGOAHeouBuR1jog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 18, 2021 at 12:27:44PM +0530, Shashidhar Patil wrote:
> Hi Theodore,
>     I forgot to include two important  details , the stack trace of
> loop0 driver and sar output, which clearly nail  the problem.
> The losetup with Ubuntu16.05 does not have O_DIRECT support  and we
> were not aware of bypassing of journalling if
> O_DIRECT combined with preallocated file scenario.

Which version of the kernel are you using?  The use of O_DIRECT for
loop devices requires kernel and losetup support.  (Also note that
upstream developers really generally don't pay attention --- or
support --- distribution kernels unless they work for the company for
which you are paying $$$ for support, and Ubuntu 16.05 isn't even a
Long-Term Support distribution.)

My suggestion is to see if you can replicate the problem on a modern
userspace with the latest kernel.  And if not, then that's an object
lesson about why using a antediluvian is not a great life choice.  :-)

Cheers,

						- Ted
