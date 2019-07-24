Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6267335D
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2019 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfGXQIA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 12:08:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52127 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726099AbfGXQH7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jul 2019 12:07:59 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6OG7nte005051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jul 2019 12:07:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1A6EB4202F5; Wed, 24 Jul 2019 12:07:49 -0400 (EDT)
Date:   Wed, 24 Jul 2019 12:07:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Message-ID: <20190724160749.GF4565@mit.edu>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
 <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
 <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
 <20190724061231.GA7074@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724061231.GA7074@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 23, 2019 at 11:12:31PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 23, 2019 at 11:03:54PM -0700, harshad shirwadkar wrote:
> > Before I respond to your questions, I would like to explain how fast
> > commits differ from ijournal in a few key aspects (I will make sure to
> > explain it in detail in patch 00/11 and documentation):
> 
> Please do; I hadn't realized there were also journal ondisk format
> changes, and these must be recorded in the ext4 disk format
> documentation.

Actually, the changes are almost entirely in the on-disk journal
layer.  The addition of the feature flag is really a UI issue, and
worth some discussion.

One of the goals was to make it easy to allow kernels which didn't
understand fast commit to be able to mount a file system which had
been cleanly unmounted --- but of course, if the file system needs
recovery, and fast commits are in the journal, we can't allow a fast
commit oblivious kernel (or e2fsck) from trying to replay the journal.

One way to do this would be with a mount option, but that's a bit ugly
--- and a mount option in /etc/fstab will cause a failure if a kernel
which doesn't understand that mount option is booted.

So the basic idea is to have a compat feature which means, "please use
fast commits if present", and then when the file system is mounted on
a fast-commit capable kernel, the incompat feature meaning "we're
using the fast commit feature".  (This is same design pattern used
with the HAS_JOURNAL compat feature and the NEEDS_RECOVERY incompat
feature.)

The next question is whether to use the compat and incompat feature
flags in the jbd2 superblock, or ext4-specific compat flags.  For the
incompat flag, there's no reason not to use the journal incompat flag.
But for the compat flag, we have better infrastructure for setting and
clearing ext4-level compat feature flags.  Aside from that, though,
there's no reason why we couldn't use the s_feature_compat field in
the journal superblock --- in which case, *all* of the on-diks format
changes would purely be on the jbd2 side of the ledger.

> Every feature flag you add doubles the size of the testing matrix.
> If I were you I'd only want to test the (fastcommit) and (!fastcommit)
> scenarios.

Sure, absolutely.  On the other hand, as the saying goes, "there comes
a time in any project where it's time to shoot the engineers and put
the d*mned thing into production".  One of the reasons why we're super
interested in this feature is to claw back the performance hit of
fde872682e17 ("ext4: force inode writes when nfsd calls
commit_metadata").  I fully expect that this feature is going to make
big difference to a number of customer workloads, so there is some
urgency to getting this feature into production.

On the flip side, if we leave some performance wins on the table, it's
absolutely true that it makes it harder to add those optimizations
later, and it increases the testing load, not to mention the forwards
and backwards compatibility issues.  It's an engineering trade-off.

    	      		    	     	     - Ted
