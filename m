Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94952D02A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiESKI7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 06:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiESKI6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 06:08:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38498A7747
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 03:08:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso4840504pjg.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGaD456U6tiUT4V7cnRxFxSZ3zNxsyIPGj+kxdKx5vI=;
        b=mPUgpNi8LG09zhUd/5Ku/8tgolONAJ0p1aEEUzauTNWlCIzd8VXtJ9MnwYYIDeRl5X
         SB4D3QtWCKyC0fb1agFDM7VVcW5fSDfTtyiineMYjGSHroSsk5e47BbHAD8pjH6jFyVa
         WjpIuSO6UloGgDtXvU2muUBwTw1jWf+7Yqv7X743hMxRL5YhN7FvWEV1yGW3Q+qaJhHH
         cTbPEhi83vScf2IDhYNu9/QGWsupRU4zNVJQa+I8EgnIfa85Xmvn48auoqXpVqRGdWiy
         5Eg90jEKPmw9TgfIpexkMrKjionHUPUNfaHfvRWM7URZo0IiCNW0TckbltGdI5GXaDNY
         0fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGaD456U6tiUT4V7cnRxFxSZ3zNxsyIPGj+kxdKx5vI=;
        b=Cw8IB4MCl1rn2iG10NOMrzf/BZCgdVhr6u9ws+Glbpc//LCohcXa/GpniX7AR6DsZr
         CT09RaI6hlzv6ZOeCwr53q8Yh1Apm8bzkNl2YeTXhL1f2ypVVKkAZJFYCf/xAQvCCmwr
         ilaz9yp0cXw6WMRpt+LyLN+lnK9rg8JWsSGsrmjrHOp0IbP6V2dO7As/lZWh8/e4KfCY
         akgKw53nZgU+XSbVpUR3Yd5kRdH6LkWES5oY35wiKd4+aT/gVwVWDwsWGWyqY6xEH/yH
         1bNcq14JeNr4q9QJyulZTW5/xrQIAqzbvjCmgbQeTwVamMMzrBqSYd2SaVOLuQyH/EFD
         76iQ==
X-Gm-Message-State: AOAM532UIIGduZNMk8ZDrlLiE2n30a5SBSkzuW6Yg7vdDTafq1rVi8ZN
        dXOOhZWJYkIsIfZBC9Fkp/HX0QdLTSc=
X-Google-Smtp-Source: ABdhPJwBZh3Y7XmPrJoAzrQ8dG45eRHfKYGnZs1uTQe8qIXiNptSBweoSFGzT6JYIF6MX/D1DDvYbg==
X-Received: by 2002:a17:90b:3e84:b0:1dc:5942:af0e with SMTP id rj4-20020a17090b3e8400b001dc5942af0emr4369705pjb.61.1652954936658;
        Thu, 19 May 2022 03:08:56 -0700 (PDT)
Received: from localhost ([2406:7400:63:532d:c4bb:97f7:b03d:2c53])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e21100b001616713999dsm1586111plb.74.2022.05.19.03.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:08:56 -0700 (PDT)
Date:   Thu, 19 May 2022 15:38:51 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix warning when submitting superblock in
 ext4_commit_super()
Message-ID: <20220519100851.7mwftkvjfigwo4jj@riteshh-domain>
References: <20220518141020.2432652-1-yi.zhang@huawei.com>
 <20220518170617.vooz4ycfe73xsszx@riteshh-domain>
 <94e7b5f7-54c8-d04a-3a3a-31768b630862@huawei.com>
 <20220519062929.i52y2mwonnrbvr64@riteshh-domain>
 <20220519093035.2kazqodrv4nqauwf@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519093035.2kazqodrv4nqauwf@quack3.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/19 11:30AM, Jan Kara wrote:
> On Thu 19-05-22 11:59:29, Ritesh Harjani wrote:
> > On 22/05/19 11:13AM, Zhang Yi wrote:
> > > On 2022/5/19 1:06, Ritesh Harjani wrote:
> > > > On 22/05/18 10:10PM, Zhang Yi wrote:
> > > >> We have already check the io_error and uptodate flag before submitting
> > > >> the superblock buffer, and re-set the uptodate flag if it has been
> > > >> failed to write out. But it was lockless and could be raced by another
> > > >> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> > > >> marking buffer dirty. Fix it by submit buffer directly.
> > > >
> > > > I agree that there could be a race with multiple processes trying to call
> > > > ext4_commit_super(). Do you have a easy reproducer for this issue?
> > > >
> > >
> > > Sorry, I don't have a easy reproducer, but we can always reproduce it through
> > > inject delay and add filters into the ext4_commit_super().
>
> ...
>
> > > > Also do you think something like below should fix the problem too?
> > > > So if you lock the buffer from checking until marking the buffer dirty, that
> > > > should avoid the race too that you are reporting.
> > > > Thoughts?
> > > >
> > >
> > > Thanks for your suggestion. I've thought about this solution and yes it's simpler
> > > to fix the race, but I think we lock and unlock the sbh several times just for
> > > calling standard buffer write helpers is not so good. Opencode the submit
> > > procedure looks more clear to me.
> >
> > I agree your solution was cleaner since it does not has a lot of lock/unlock.
> > My suggestion came in from looking at the history.
> > This lock was added here [1] and I think it somehow got removed in this patch[2]
> >
> > [1]: https://lore.kernel.org/linux-ext4/1467285150-15977-2-git-send-email-pranjas@gmail.com/
> > [2]: https://lore.kernel.org/linux-ext4/20201216101844.22917-5-jack@suse.cz/
>
> So the reason why I've move unlock_buffer() into ext4_update_super() was
> mostly so that the function does not return with buffer lock (which is an
> odd calling convention) when I was adding another user of it
> (flush_stashed_error_work()).
>
> > Rather then solutions, I had few queries :)
> > 1. What are the implications of not using
> > mark_buffer_dirty()/__sync_dirty_buffer()
>
> Not much. Using submit_bh() directly is fine. Just the duplication of the
> checks is somewhat unpleasant.

Ok.

>
> > 2. In your solution one thing which I was not clear of, was whether we
> > should call clear_buffer_dirty() before calling submit_bh(), in case if
> > somehow(?) the state of the buffer was already marked dirty? Not sure how
> > this can happen, but I see the logic in mark_buffer_dirty() which checks,
> > if the buffer is already marked dirty, it simply returns. Then
> > __sync_dirty_buffer() clears the buffer dirty state.
>
> It could happen e.g. if there was journalled update of the superblock
> before. I guess calling clear_buffer_dirty() before submit_bh() does no
> harm.

Makes sense.

>
> Otherwise I like Yi's solution.

I agree. Thanks for helping with the queries.

-ritesh
