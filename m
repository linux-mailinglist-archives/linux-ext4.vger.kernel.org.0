Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F56280F13
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 10:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgJBIjf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 04:39:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:60794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBIjb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Oct 2020 04:39:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD2A9AC82;
        Fri,  2 Oct 2020 08:39:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 91BE51E12EF; Fri,  2 Oct 2020 10:39:29 +0200 (CEST)
Date:   Fri, 2 Oct 2020 10:39:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Ted Tso <tytso@mit.edu>
Subject: Re: [RFC PATCH v4 0/4] ext4/jbd2: data=journal: write-protect pages
 on transaction commit
Message-ID: <20201002083929.GB17963@quack2.suse.cz>
References: <20200928194103.244692-1-mfo@canonical.com>
 <20200929113727.GK10896@quack2.suse.cz>
 <CAO9xwp3fy1p7+J2ag8PbtTGb5R5-tNuko77j-w4yG=zp+QdkZQ@mail.gmail.com>
 <20201001073433.GB17860@quack2.suse.cz>
 <CAO9xwp3LqWy7tEEevfeuFTgi230q9jBhiVpAra=XAiP+wtCVGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp3LqWy7tEEevfeuFTgi230q9jBhiVpAra=XAiP+wtCVGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-10-20 09:46:32, Mauricio Faria de Oliveira wrote:
> On Thu, Oct 1, 2020 at 4:34 AM Jan Kara <jack@suse.cz> wrote:
> > On Wed 30-09-20 19:59:44, Mauricio Faria de Oliveira wrote:
> > > 3) Now, the mixed-feelings news.
> > >
> > > The synthetic test-case/patches I had written clearly show that the
> > > patchset works:
> > > - In the original kernel, userspace can write to buffers during
> > > commit; and it moves on.
> > > - In the patched kernel, userspace cannot write to buffers during
> > > commit; it blocks.
> > >
> > > However, the heavy-hammer testing with 'stress-ng --mmap 4xNCPUs --mmap-file'
> > > then crashing the kernel via sysrq-trigger, and trying to mount the
> > > filesystem again,
> > > sometimes still can find invalid checksums, thus journal recovery/mount fails.
> > >
> > >     [   98.194809] JBD2: Invalid checksum recovering data block 109704 in log
> > >     [   98.201853] JBD2: Invalid checksum recovering data block 69959 in log
> > >     [   98.339859] JBD2: recovery failed
> > >     [   98.340581] EXT4-fs (vdc): error loading journal
> > >
> > > So, despite the test exercising mmap() and the patchset being for mmap(),
> > > apparently there is more happening that also needs changes. (Weird; but
> > > I will try to debug that test-case behavior deeper, to find what's going on.)
> > >
> > > This patchset does address a problem, so should we move on with this one,
> > > and as you mentioned, "that would be something for another patch series :)" ?
> >
> > Thanks for the really throughout testing! If you can debug where the
> > problem is still lurking fast, then cool, we can still fix it in this patch
> > series. If not, then I'm fine with just pushing what we have because
> > conceptually that seems like a sane thing to do anyway and we can fix the
> > remaining problem afterwards.
> 
> Understood. I'll be able to look at this next week, which should be rc8 [1].
> Would it be good enough, timing wise, to send a non-RFC series with
> what we have (this other issue fixed or not) by the end of next week?

This is more a question for Ted as a maintainer (CCed) but end of next week
is probably too late because Ted needs time to merge the patches in his
tree, run his battery of tests, push changes to linux-next and let them
simmer there for a while before sending them to Linus. So I'd say submit
what you have on Monday / Tuesday and we can always add fixes on top as we
find them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
