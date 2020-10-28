Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D439329D770
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbgJ1WYU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 18:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732909AbgJ1WYT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 18:24:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0876C0613CF;
        Wed, 28 Oct 2020 15:24:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x1so1169995eds.1;
        Wed, 28 Oct 2020 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsmTh3EY4PlXa0ncerE94aAQcFnKZIBIojGnStqQXyU=;
        b=QHjnktl8YmRQstpwq4nVhZJ5MIynb9jtS0Lt70XNKDx041dxoG+Zp8hcZ8q1iUi9Kl
         LvSTjuci6R+A8eyB6u6RgiFlV7TNsdtXskzJHg+Zw+3YI3cRBvyehWFPrpTmlhARWa17
         mtcF3We28lh3Oe7zVeTlOMO6K9oljAR3JSDCh75C3eN9u7tluabznRsKUGppkci5GmgT
         QkPt+VELV3DiNm0fs6O4wZmqFuRrY1IOTERz+y619MagoZFqTGdgnSkiD6saSkM9Szn7
         2L7BhV5vVu7v12na9QzkWO9byC1vpAx4+USDzZa2WBrvbkTdVykblB+1Xv134VfvGZaj
         Gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsmTh3EY4PlXa0ncerE94aAQcFnKZIBIojGnStqQXyU=;
        b=bxZpsuX8SXpd1uV1APiRVJGXDtFufjFMSAE9OIwD9K9BpPGXoQZPZ7Pr9a8cwIbhqF
         /6NLeFxrk0r57kjCLwzjoljERvogalhNmozsd35/r1PV9uffOc6tbk/a/yi7dmgJwkLq
         L4BPWgOTbS9D8vicceLe/O3l8/5B9EWcTEiDRDq9S7qzc6PiF+we8ATQfUnckDrVK5rs
         G6R+KvE9Fkc12D1QV2WBJnbQG5GyxvRJ7X9gjwqQz8U27/2G5wj8JYblbzlXOC/PZsjy
         R8l0jecpSlgU5GDrjzfPhcZ8cZo59NQFfQJ5hu0haxcfVWVq9SweMIpBzkwVohGTaH1T
         DGzA==
X-Gm-Message-State: AOAM531IAoOtAfwLpYFcMSgTZ3/8H+HFvgjgZkLfS8dYh3CuotqYq0Ws
        lk4Zt1814pkQCT61OET6uyeuiUODFqDZa9ksV3VNd9+gxSz3yg==
X-Google-Smtp-Source: ABdhPJzUCOEMW6hJ2BHhA6WBRm/TWu/t+HxGpNCZ71HTo6aPJUmWKvuHmkUhbJiOi5UKR+I/w3WwDylDM/FOMuLt0bk=
X-Received: by 2002:a50:9ec6:: with SMTP id a64mr5478708edf.382.1603856918746;
 Tue, 27 Oct 2020 20:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201024140115.GA35973@xps-13-7390> <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
 <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
In-Reply-To: <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 27 Oct 2020 20:48:27 -0700
Message-ID: <CAD+ocbz0NpXYK9fCxpEYGz6fvWJ_SLw+rYQ2yo3UbKJbbEX8hg@mail.gmail.com>
Subject: Re: [PATCH] ext4: properly check for dirty state in ext4_inode_datasync_dirty()
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Actually the simpler fix for this in case of fast commits is to check
if the inode is on the fast commit list or not. Since we clear the
fast commit list after every fast and / or full commit, it's always
true that if the inode is not on the list, that means it isn't dirty.
This will simplify the logic here and then we can probably get rid of
i_fc_committed_subtid field altogether. I'll test this and send out a
patch.

Thanks,
Harshad

On Tue, Oct 27, 2020 at 8:27 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 10/27/20 3:58 AM, harshad shirwadkar wrote:
> > Thanks Andrea for catching and sending out a fix for this.
> >
> > On Sat, Oct 24, 2020 at 7:01 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >>
> >> ext4_inode_datasync_dirty() needs to return 'true' if the inode is
> >> dirty, 'false' otherwise, but the logic seems to be incorrectly changed
> >> by commit aa75f4d3daae ("ext4: main fast-commit commit path").
> >>
> >> This introduces a problem with swap files that are always failing to be
> >> activated, showing this error in dmesg:
> >>
> >>   [   34.406479] swapon: file is not committed
> >>
>
> Well, I too noticed this yesterday while I was testing xfstests -g swap.
> Those tests were returning _notrun, hence that could be the reason why
> it didn't get notice in XFSTESTing from Ted.
>
> - I did notice that this code was introduced in v10 only.
> This wasn't there in v9 though.
>
>
> >> Simple test case to reproduce the problem:
> >>
> >>    # fallocate -l 8G swapfile
> >>    # chmod 0600 swapfile
> >>    # mkswap swapfile
> >>    # swapon swapfile
> >>
> >> Fix the logic to return the proper state of the inode.
> >>
> >> Link: https://lore.kernel.org/lkml/20201024131333.GA32124@xps-13-7390
> >> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
> >> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> >> ---
> >>   fs/ext4/inode.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 03c2253005f0..a890a17ab7e1 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -3308,8 +3308,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
> >>          if (journal) {
> >>                  if (jbd2_transaction_committed(journal,
> >>                                          EXT4_I(inode)->i_datasync_tid))
> >> -                       return true;
> >> -               return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) >=
> >> +                       return false;
> >> +               return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
> >>                          EXT4_I(inode)->i_fc_committed_subtid;
> > In addition, the above condition should only be checked if fast
> > commits are enabled. So, in effect this overall condition will look
> > like this:
> >
> > if (journal) {
> >      if (jbd2_transaction_committed(journal, EXT4_I(inode)->i_datasync_tid))
> >          return false;
> >      if (test_opt2(sb, JOURNAL_FAST_COMMIT))
> >          return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
> > EXT4_I(inode)->i_fc_committed_subtid;
> >      return true;
> > }
>
> Yup - I too had made a similar patch. But then I also noticed that below
> condition will always remain false. Since we never update
> "i_fc_committed_subtid" other than at these 2 places
> (one during init where we set it to 0 and other during ext4_fc_commit()
> where we set it to sbi->s_fc_subtid).
>
> <condition>
> atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid <
> EXT4_I(inode)->i_fc_committed_subtid
>
>
> Maybe I need more reading around this.
>
> -ritesh
>
>
>
>
>
> >
> > Thanks,
> > Harshad
> >
> >>          }
> >>
> >> --
> >> 2.27.0
> >>
