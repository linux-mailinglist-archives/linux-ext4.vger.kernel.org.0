Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860671384AE
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Jan 2020 04:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbgALDpb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Jan 2020 22:45:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38864 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732096AbgALDpb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Jan 2020 22:45:31 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00C3jQaI020231
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Jan 2020 22:45:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CEB634207DF; Sat, 11 Jan 2020 22:45:26 -0500 (EST)
Date:   Sat, 11 Jan 2020 22:45:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v4 01/20] ext4: update docs for fast commit feature
Message-ID: <20200112034526.GB359630@mit.edu>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
 <CAAJeciV7bVN9HKz=FTQ1eSLXX_7E2ccuH9Za3vzBWHsgHuZEiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJeciV7bVN9HKz=FTQ1eSLXX_7E2ccuH9Za3vzBWHsgHuZEiw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 09, 2020 at 12:29:01PM +0800, xiaohui li wrote:
> maybe i have not understand the difficulty of the fast commit coding work.
> so I appreciate it very much if you give some more detailed
> descriptions about the patches correlationship of v4 fast commit,
> especially the reason why need have so many patches.
> 
> from my viewpoint, the purpose of doing this fast commit function is
> to resolve the ext4 fsync time-cost-so-much problem.
> firstly we need to resolve some actual customer problems which exist
> in ext4 filesystems when doing this fast commit function.
> 
> so the first release version of fast commit is just only to accomplish
> the goal of reducing the time cost of fsync because of jbd2 order
> shortcoming described in ijournal paper from my opinion.
> it need not do so many other unnecessary things.

As Harshad has mentioned, one of the reasons why an incremental
approach does not make sense is that once we release a version of fast
commit into a mainline kernel, we have to worry about what happens if
users start trying to use it, and we have to provide backwards
compatibility for it.  So if we were to break up fast commit into 5
parts, then we would have to allocate 5 feature bits, and we would
have to support each version of fast commit --- essentially forever.

As far as why are we doing this, we absolutely have a specific use
case in mind, and that's to improve ext4's performance when used on a
NFS server.  The NFS protocol requires that any file system operation
requested by a client is persisted before the server sends an
acknowledgement back to the client.  For the workloads that are heavy
with metadata updates, avoiding the need to do a full jbd2 commit for
every NFS RPC request which modifies metadata will a big difference to
the NFS server's performance.

This is why we are interested in making things like renames to be fast
commit eligible, and not just the smaller set of system calls needed
by (for example) SQLite.

Regards,

						- Ted
