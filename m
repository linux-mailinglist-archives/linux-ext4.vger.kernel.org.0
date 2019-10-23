Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71382E1B07
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfJWMoI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 08:44:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51424 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391648AbfJWMoI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Oct 2019 08:44:08 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9NCi2PB012503
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 08:44:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 90FE2420456; Wed, 23 Oct 2019 08:44:02 -0400 (EDT)
Date:   Wed, 23 Oct 2019 08:44:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 09/13] ext4: fast-commit commit path changes
Message-ID: <20191023124402.GA31059@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-10-harshadshirwadkar@gmail.com>
 <20191016224511.GI11103@mit.edu>
 <CAAJeciXQiE022GqcsTr35jSqjA6eH+zBS2KNvDPj5PovButdYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJeciXQiE022GqcsTr35jSqjA6eH+zBS2KNvDPj5PovButdYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 23, 2019 at 04:58:47PM +0800, xiaohui li wrote:
> why not let fsync handle enjoy one transaction exclusively ?
> that is to say, in this transaction, there is only one handle which is
> generated in one file's fsync path .

There is only one handle which is generated in one file's fsync path.
That isn't the problem.  (If it were that simple, we would have done
it a long time ago.)

The problem is that there may have been other handles that have been
started before the fsync transaction, and these handles will have
already made changes to the file system.  Worse, some of those handles
may have made changes in the same metadata blocks which the fsync
operation needs to modify.

For example, suppose we are three seconds into the current
transaction, with potentially hundreds of handles that have already
been started and finished --- but not yet committed, because the
current transaction hasn't closed.  All of those handles have already
been attached to the current transaction, and they can't be ignored.

The fast commit patch set deals with this by using part of the journal
for a "fast commit journal" where we essentially are doing a very
simplified logical journal.  It doesn't handle all cases, and there
will be situations where we will need to fall back to the physical
journalling techniques used in ext4 today.  For example, if the file
has been truncated, and then a single 4k block is written, and then
the file gets fsync'ed, we won't be able to use the fast commit
logical journal.  Fortunately, the common case which compromises well
over 99% of most workloads are much simpler to handle, and these can
be handled via the fast commit patch.

The fast commit approach is a simplified version of the idea proposed
by Daejun Park and Dungkun Shih from the Sungkyunkwan University in
Korea, and which were presented in the paper "iJournaling:
Fine-Grained Journaling for Improving the Latency of Fsync System
Call[1]", presented at the Usenix Annual Technical Conference in 2017.

[1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park

Cheers,

						- Ted
