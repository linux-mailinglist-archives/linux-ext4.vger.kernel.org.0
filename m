Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF7EAAAB
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 07:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfJaGlZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 02:41:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45732 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJaGlZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Oct 2019 02:41:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id k2so4215812oij.12
        for <linux-ext4@vger.kernel.org>; Wed, 30 Oct 2019 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwoxp1OPUpD4td4QlzI0r8BQgmS3rwuIAJjzxwtUkck=;
        b=T2e/vvJXA7MEOel/w6C4kdyzZzxu7NEuur9UYx5hzhceBwg3H1RZ7tfeWIboKXvJ05
         Nce3j7YtXidjiGIW3BjDhNQZjOL1tRWOrKVjwvhD1vyargOVxaaWmnZa7SdmcKaMiuyb
         1IvIYJBOD9I26xNiPg2W/h7ClilnycMNAqRW3MVz+jfmVcdPhnDDJSMeSFozuV/W6PJv
         czguo+rWhlIe+u0ORQ5G4H2ErW3w26B0u5QH0LXf2vhfpqb5XA6fOxIXxJKGkwNlLwhM
         fNnzXxroW0tsIRVpDxXkeh1y0srkeRV3DtR59YwmA+GUAnVs6Yrz6q8KXlnb5ZpgDCRL
         mymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwoxp1OPUpD4td4QlzI0r8BQgmS3rwuIAJjzxwtUkck=;
        b=a4jWcJnShOTFs3ffRXSV5PZeOI6yLK83iiPb5QvCWVCwmnqflhjshZXC/+Jsed0bsw
         po2t+Yjpm/GwJvHjy8wz2DQnuLpbNxrc00RudY70FMBEeOSFfHR5f5WsXmlnjs8moHPE
         POgKZ2CYFaH50ZD74OJdIVBM5mpvKHBrcgZtVHtbGqbcYrDIeRBaUFN2tl8yV3MBn48z
         /lCCWBfFAq3azSwDZRmE5qS/1pcJgg2zvmI3woAZyjDH4kZ6+L1skYgiAIRlaoksJXna
         +FbK6uGOQZ6IAgipF8NjV+gW4wJXE4I+P4ucccFldGbazuMXIlkUC5Rna7PEK803RXBZ
         ffIg==
X-Gm-Message-State: APjAAAWCT1rfXPGYkMqt2IhkdBK5X0FzPpZ7WG8VCuMh3Y33A/IdUVgz
        IL6SuZsSu3gTHNuJAZv3GgsmTbhe27rZf0ZiOiM=
X-Google-Smtp-Source: APXvYqxpbUyd3nNvjK9gSI24gpZROZFn/TmO9sHaVZdoJFEkgtVRgU02oMus4Oo9VecepxsmHjKtlSjm3Zg0PXOP7qk=
X-Received: by 2002:aca:4a84:: with SMTP id x126mr2656601oia.47.1572504083989;
 Wed, 30 Oct 2019 23:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-13-harshadshirwadkar@gmail.com> <20191018015655.GB21137@mit.edu>
 <CAD+ocbwV+f_sp9-oJyaX=9xvj_DXgLzcXu3CohVEaLDuOSx0hA@mail.gmail.com>
In-Reply-To: <CAD+ocbwV+f_sp9-oJyaX=9xvj_DXgLzcXu3CohVEaLDuOSx0hA@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 30 Oct 2019 23:41:13 -0700
Message-ID: <CAD+ocbz55DYWEJDVNcV_tU1BpN_-Vd04YiwgtCaMDMGqkVdL1g@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] docs: Add fast commit documentation
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Also, at high level I realized that in order to allow fast commits
being invoked from kjournald thread, the whole patch set has become
more complicated that it needs to be. In other words, if we only
support "asynchronous fast commits" in this patch set and worry about
integrating it with journald thread later, we can simplify this series
a whole lot and yet retain mostly all the functionality. Besides that
adding support of fast commits in kjournald thread would just be an in
memory change. So, just to summarize on this, 1) we will have fsync()
result in only the inode in question being fast committed in async
fashion. 2) ext4_nfs_commit_metadata() would result in all the changed
inodes result in fast commit in async fashion as well. 3) We could
very well use fast commits for normal jbd2 periodic commits as well.
But it's not clear if that will add any value, so we'll leave it out
from this patch series. Do you agree with this?

On Wed, Oct 30, 2019 at 10:34 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks good point. I was trying to imitate how a jbd2 commit I guess.
> There's no reason really to do this in atomic way. I'll fix this in
> next version.
>
> On Thu, Oct 17, 2019 at 6:56 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Tue, Oct 01, 2019 at 12:41:01AM -0700, Harshad Shirwadkar wrote:
> > > +
> > > +Multiple fast commit blocks are a part of one sub-transaction. To
> > > +indicate the last block in a fast commit transaction, fc_flags field
> > > +in the last block in every subtransaction is marked with "LAST" (0x1)
> > > +flag. A subtransaction is valid only if all the following conditions
> > > +are met:
> > > +
> > > +1) SUBTID of all blocks is either equal to or greater than SUBTID of
> > > +   the previous fast commit block.
> > > +2) For every sub-transaction, last block is marked with LAST flag.
> > > +3) There are no invalid blocks in between.
> >
> > I'm wondering why we need to support multiple inodes being modified in
> > a single transaction.  As we currently have defined what can be done,
> > all updates to an inode should be free standing and not dependent on a
> > change to another inode, right?  And today, one block only modifies
> > one inode.
> >
> > The only reason why we might want to define a sub-transaction as being
> > composed of multiple inodes, which must all be updated in an
> > all-or-nothing fashion, is the swap boot inode ioctl, and if that's
> > the only one, I wonder if it's worth the extra complexity.
> >
> > Am I missing anything?
> >
> >                                         - Ted
