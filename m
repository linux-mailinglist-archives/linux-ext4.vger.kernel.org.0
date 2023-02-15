Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1D697572
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 05:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBOEcY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Feb 2023 23:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBOEcX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Feb 2023 23:32:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFEA12F14
        for <linux-ext4@vger.kernel.org>; Tue, 14 Feb 2023 20:32:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31F4W2n2024070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676435524; bh=Slxn5EcyKlO/e4jjGmn2OEMdak43DUPqnB9cJlEH0Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TzSQdNZdbGJyOw6zSkVD2jS4zdqXYZKxMXS0WqUiOGIXtta+6OQowLkuS9Udwc9Z0
         tMO/xbQiQBFiODFXaVw8nkjt7eOMl2Wt5szWa0FZqnSZlERRpdUsltOUsfl4/bh9Vl
         EFNtICfwucfjKIFDxSj8yhsTofhEiK8EZTqP7qNuz9IXJYaNqj+AtZYOpCzmsVsxr1
         NzSf85x6lFLtApMiC7nHLnmhX3cXIuqViKOcBwNSpR+J/8R2oGtKVPNLnWPBJlU6vB
         0qoCZMigrCmHfo1aVOaPXQMDprz1dBbo3Zch1AiZXwS8zFvH4ihwtvZqd/xnfiPGP6
         wVbUwnQbTrjsw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0F5E315C3587; Tue, 14 Feb 2023 23:32:02 -0500 (EST)
Date:   Tue, 14 Feb 2023 23:32:02 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tudor.ambarus@linaro.org
Subject: Re: [PATCH] ext4: reject 1k block fs on the first block of disk
Message-ID: <Y+xgQklC81XCB+q4@mit.edu>
References: <20221229014502.2322727-1-jun.nie@linaro.org>
 <Y7R/QKIbYQ2TCP+W@magnolia>
 <CABymUCPCT9KbMQDUTxwf6A+Cg9fWJNkefbMHD7SZD3Fc7FMFHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCPCT9KbMQDUTxwf6A+Cg9fWJNkefbMHD7SZD3Fc7FMFHg@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 09:58:03AM +0800, Jun Nie wrote:
> Darrick J. Wong <djwong@kernel.org> 于2023年1月4日周三 03:17写道：
> >
> > On Thu, Dec 29, 2022 at 09:45:02AM +0800, Jun Nie wrote:
> > > For 1k-block filesystems, the filesystem starts at block 1, not block 0.
> > > If start_fsb is 0, it will be bump up to s_first_data_block. Then
> > > ext4_get_group_no_and_offset don't know what to do and return garbage
> > > results (blockgroup 2^32-1). The underflow make index
> > > exceed es->s_groups_count in ext4_get_group_info() and trigger the BUG_ON.
> > >
> > > Fixes: 4a4956249dac0 ("ext4: fix off-by-one fsmap error on 1k block filesystems")
> > > Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
> > > Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  fs/ext4/fsmap.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> > > index 4493ef0c715e..1aef127b0634 100644
> > > --- a/fs/ext4/fsmap.c
> > > +++ b/fs/ext4/fsmap.c
> > > @@ -702,6 +702,12 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
> > >               if (handlers[i].gfd_dev > head->fmh_keys[0].fmr_device)
> > >                       memset(&dkeys[0], 0, sizeof(struct ext4_fsmap));
> > >
> > > +             /*
> > > +              * Re-check the range after above limit operation and reject
> > > +              * 1K fs on block 0 as fs should start block 1. */
> > > +             if (dkeys[0].fmr_physical ==0 && dkeys[1].fmr_physical == 0)
> > > +                     continue;
> >
> > ...and if this filesystem has 4k blocks, and therefore *does* define a
> > block 0?
> 
> Yes, this is a real corner case test :-)

So I'm really nervous about this change.  I don't understand the code;
and I don't understand how the reproducer works.  I can certainly
reproduce it using the reproducer found here[1], but it seems to
require running multiple processes all creating loop devices and then
running FS_IOC_GETMAP.

[1] https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002

If I change the reproducer to just run the execute_one() once, it
doesn't trigger the bug.  It seems to only trigger when you have
multiple processes all racing to create a loop device, mount the file
system, try running FS_IOC_GETMAP --- and then delete the loop device
without actually unmounting the file system.  Which is **weird***.

I've tried taking the image, and just running "xfs_io -c fsmap /mnt",
and that doesn't trigger it either.

And I don't understand the reply to Darrick's question about why it's
safe to add the check since for 4k block file systems, block 0 *is*
valid.

So if someone can explain to me what is going on here with this code
(there are too many abstractions and what's going on with keys is just
making my head hurt), *and* what the change actually does, and how to
reproduce the problem with a ***simple*** reproducer -- the syzbot
mess doesn't count, that would be great.  But applying a change that I
don't understand to code I don't understand, to fix a reproducer which
I also doesn't understand, just doesn't make me feel comfortable.

Regards,

					- Ted
