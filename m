Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0D5F4BC0
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Oct 2022 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiJDWTl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJDWSm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 18:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA369F55;
        Tue,  4 Oct 2022 15:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D029C614B2;
        Tue,  4 Oct 2022 22:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353ABC433D6;
        Tue,  4 Oct 2022 22:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664921920;
        bh=3OSNGb6eczbbTEHdSyw0AJmcW1Gd0forZ+L7hKDOImU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g96s3fHsBQiMBtHOiWUWkcF04ehUH4sAH28zokPRfYfJfiW+vupPchlaH2EO0P704
         IYJbqbC86ttuyYpH4dKLCDVmY6NnkGSQ8VGGaz/AzsGnM9YiiH7IaD2o/7baYYCOU3
         K8txGUWfwz7mcUr0xbZIBt4qmTdV9w3OlCmOY9zq4hd0p0k/QZQcwYUEP+ECI3gkU8
         xnFLs7iR3XPoeKgYfU977ceRc6V/zXQhSaoy6gLyTOV4XvXhD4emLns2oSO/qh5K9e
         PrV1U+3oMv0o/8ic7bQitPusSsuRG38ajwFhbtGYgpcENrRoPE4Yr1iiK5voX/7WEa
         Fv2/Kj1Awfg8g==
Date:   Tue, 4 Oct 2022 15:18:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     zhanchengbin <zhanchengbin1@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>,
        kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [bug report] misc/fsck.c: Processes may kill other processes.
Message-ID: <YzyxP8o7V7Q6xaS7@magnolia>
References: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
 <20220929112813.6aqtktwaff2m7fh2@fedora>
 <470ea2ee-54fd-3dd5-2500-36fb82665c11@huawei.com>
 <20220930072042.dwakvbnefctk2jyd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930072042.dwakvbnefctk2jyd@fedora>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[cc util-linux and karel zak]

TLDR: util-linux's fsck program has an interesting bug in it where if
someone runs "fsck -N", it will set up a fsck_instance context for each
filesystem with inst->pid = -1.  If someone sends the fsck process a
SIGINT/SIGTERM before it finishes enumerating filesystems, it will try
to kill all the fsck instances via "kill(inst->pid, ...);" which will
terminate every process on the system.

On Fri, Sep 30, 2022 at 09:20:42AM +0200, Lukas Czerner wrote:
> On Fri, Sep 30, 2022 at 09:42:52AM +0800, zhanchengbin wrote:
> > 
> > 
> > On 2022/9/29 19:28, Lukas Czerner wrote:
> > > Hi,
> > > 
> > > indeed we'd like to avoid killing the instance that was not ran because
> > > of noexecute. Can you try the following patch?
> > > 
> > > Thanks!
> > > -Lukas
> > 
> > Yes, you're right, I think we can fix it in this way.
> > 
> > diff --git a/misc/fsck.c b/misc/fsck.c
> > index 1f6ec7d9..91edbf17 100644
> > --- a/misc/fsck.c
> > +++ b/misc/fsck.c
> > @@ -547,6 +547,8 @@ static int kill_all(int signum)
> >         for (inst = instance_list; inst; inst = inst->next) {
> >                 if (inst->flags & FLAG_DONE)
> >                         continue;
> > +               if (inst->pid == -1)
> > +                       continue;
> 
> Yeah, that works as well although I find the "if (noexecute)" condition
> more obvious. We can do both. Also rather than checking for -1 we can
> check for <= 0 since anything other than real pid at this point is a bug.
> 
> Feel free to send a proper patch.

I was about to ask why we even care about misc/fsck.c because it's
clearly a weird old program that has been bitrotting for years and
likely replaced by some other code in util-linux.  Then I thought I had
better check util-linux, and...

https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/disk-utils/fsck.c

/*
 * fsck --- A generic, parallelizing front-end for the fsck program.
 * It will automatically try to run fsck programs in parallel if the
 * devices are on separate spindles.  It is based on the same ideas as
 * the generic front end for fsck by David Engel and Fred van Kempen,
 * but it has been completely rewritten from scratch to support
 * parallel execution.
 *
 * Written by Theodore Ts'o, <tytso@mit.edu>

LOL, it's the same source code, and I think it has the same bug, since
"noexecute" mode sets pid = -1 at like 688:

	/* Fork and execute the correct program. */
	if (noexecute)
		pid = -1;

and then sets inst->pid = pid at line 703:

	inst->pid = pid;

and kill_all() passes that to kill() at line 733:

	for (inst = instance_list; inst; inst = inst->next) {
		if (inst->flags & FLAG_DONE)
			continue;
		kill(inst->pid, signum);
		n++;
	}

From that I conclude that this is a real bug in util-linux, and we
ought to be talking to them about this.  Evidently this has been broken
since e2fsprogs commit 33922999 in January 1999, though it was only
added to util-linux in commit 607c2a72952f in February 2009.

--D

> Thanks!
> -Lukas
> 
> >                 kill(inst->pid, signum);
> >                 n++;
> >         }
> > > 
> > > 
> > > diff --git a/misc/fsck.c b/misc/fsck.c
> > > index 1f6ec7d9..8fae7730 100644
> > > --- a/misc/fsck.c
> > > +++ b/misc/fsck.c
> > > @@ -497,9 +497,10 @@ static int execute(const char *type, const char *device, const char *mntpt,
> > >   	}
> > >   	/* Fork and execute the correct program. */
> > > -	if (noexecute)
> > > +	if (noexecute) {
> > >   		pid = -1;
> > > -	else if ((pid = fork()) < 0) {
> > > +		inst->flags |= FLAG_DONE;
> > > +	} else if ((pid = fork()) < 0) {
> > >   		perror("fork");
> > >   		free(inst);
> > >   		return errno;
> > > @@ -544,6 +545,9 @@ static int kill_all(int signum)
> > >   	struct fsck_instance *inst;
> > >   	int	n = 0;
> > > +	if (noexecute)
> > > +		return 0;
> > > +
> > >   	for (inst = instance_list; inst; inst = inst->next) {
> > >   		if (inst->flags & FLAG_DONE)
> > >   			continue;
> > regards,
> > Zhan Chengbin
> > 
> 
