Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C6B2E0BA
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfE2PNK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 11:13:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40620 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725936AbfE2PNJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 11:13:09 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4TFD332021738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 11:13:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8B75A420481; Wed, 29 May 2019 11:13:03 -0400 (EDT)
Date:   Wed, 29 May 2019 11:13:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: fsync_mode mount option for ext4
Message-ID: <20190529151303.GC6210@mit.edu>
References: <20190528032257.GF10043@codeaurora.org>
 <20190528034007.GA19149@mit.edu>
 <20190528034830.GH10043@codeaurora.org>
 <20190528131356.GB19149@mit.edu>
 <20190529040757.GI10043@codeaurora.org>
 <20190529052332.GB6210@mit.edu>
 <20190529104809.GJ10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529104809.GJ10043@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 04:18:09PM +0530, Sahitya Tummala wrote:
> Yes, benchmarks for random write/fsync show huge improvement.
> For ex, without issuing flush in the ext4 fsync() the
> random write score improves from 13MB/s to 62MB/s on eMMC,
> using Androbench.
> 
> And fsync_mode=nobarrier is enabled by default on pixel phones
> where f2fs is used.
> 
> https://android.googlesource.com/device/google/crosshatch/+/e02e4813256e51bacdecb93ffd8340f6efbe68e0
> 
> We have been getting requests to evaluate the same for EXT4 and
> hence, I was checking with the community on its feasibility.

Have you run some tests to see how much power fail robustness was
impacted with f2fs's fsync_mode=nobarrier?  Say, run fsstress on real
hardware then yank the power 100 times; how many times is the file
system corrupted?  And is of those corruptions do they result in:

* Unrecoverable failures --- e.g., requires a factory reset losing all
  user data?  (Possibly because f2fs's fsck crashes or refuses to fix things?)

* Failures which corrupts the data, but can be fixed by fsck?  (And in
  how many cases with data loss?)

I'll note that for a long time in the early days of linux, we ran with
ext2 w/o a journal and without CACHE FLUSH, and it was very surprising
how often the corruption could be fixed with fsck (due to those very
early days, we did a lot of work to make e2fsck do as good of a job as
possible at not losing data, and if you run with -y, it will try to
automatically recover even if accepting some data loss.)

So if your goal is, "some file system corruptions and some complete
user data loss is OK, feel free to use nobarrier".  After all, all the
user's data that we should care about is sync'ed to the cloud, right?  :-)
And winning the benchmarketing game can mean millions and millions of dollars
to companies, and that's _obviously_ more important that user data.... :-/

Also, for people who are wondering how reliable/robust f2fs in the
ftace of corruption / SSD failures, I call your attention to this
Usenix paper, which will be presented at the upcoming Usenix ATC
conference in July:

   https://www.usenix.org/conference/atc19/presentation/jaffer

It's not available yet, but in a week or two, it should be available
to people who have registered for Usenix ATC 2019, and if you care
about user data, and you are using f2fs, it's worth the price of
admission all by itself IMHO.

					- Ted

P.S.  I have considered adding tuning knobs to make fsync/fdatasync be
tunable perhaps on a per-uid basis, maybe on a root vs non-root basis,
mostly to protect systems against hostile, mutually suspicious Docker
users from each other.  The problem is that it can also be used for
benchmarketing wars, which I really dislike, and I know there are
enterprise distros who hate these features because clueless sysadmins
turn them on, and then they lose data, and then they turn up at the
Distribution's Help Desk asking for help / complaining.

So if you really want a patch which does something like
fsync_mode=nobarrier, it's really not hard.  To quote Shakespeare
(when Hamlet was pondering how easy it would be to commit suicide), it
can be done "with a bare bodkin".  The question is whether it is a
*good* thing to do, not whether it can be done.  And a lot of this
depends on your morals --- after all, companies have been known to
disable the CPU thermal safeties in order to win benchmarketing
wars....
