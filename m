Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B99673426
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 10:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjASJFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjASJFh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 04:05:37 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BC66689DC
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 01:05:25 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 19 Jan 2023 18:05:24 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 19 Jan 2023 18:05:24 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Date:   Thu, 19 Jan 2023 18:05:11 +0900
Message-Id: <1674119111-12759-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <873588j92x.ffs@tglx>
References: <873588j92x.ffs@tglx>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thomas wrote:
> On Tue, Jan 17 2023 at 10:18, Boqun Feng wrote:
> > On Mon, Jan 16, 2023 at 10:00:52AM -0800, Linus Torvalds wrote:
> > > I also recall this giving a fair amount of false positives, are they all fixed?
> >
> > From the following part in the cover letter, I guess the answer is no?
> >	...
> >       6. Multiple reports are allowed.
> >       7. Deduplication control on multiple reports.
> >       8. Withstand false positives thanks to 6.
> >	...
> >
> > seems to me that the logic is since DEPT allows multiple reports so that
> > false positives are fitlerable by users?
> 
> I really do not know what's so valuable about multiple reports. They
> produce a flood of information which needs to be filtered, while a
> single report ensures that the first detected issue is dumped, which
> increases the probability that it can be recorded and acted upon.

Assuming the following 2 assumptions, you are right.

Assumption 1. There will be too many reports with the multi-report
	      support, like all the combination of dependencies between
	      e.g. in-irq and irq-enabled-context.

Assumption 2. The detection is matured enough so that it barely happens
	      to fix false onces to see true one which is not a big deal.

However, DEPT doesn't generate all the combination of irq things as
Lockdep does so we only see a few multi-reports even with the support,
and I admit DEPT hasn't matured enough yet because fine classification
is required anyway to suppress false alarms. That's why I introduced
multi-report support at least for now. IMHO, it'd be still useful even
if it's gonna report a few true ones at once w/o false ones some day.

> Filtering out false positives is just the wrong approach. Decoding
> dependency issues from any tracker is complex enough given the nature of
> the problem, so adding the burden of filtering out issues from a stream
> of dumps is not helpful at all. It's just a marketing gag.
> 
> > *	Instead of introducing a brand new detector/dependency tracker,
> >	could we first improve the lockdep's dependency tracker? I think
> >	Byungchul also agrees that DEPT and lockdep should share the
> >	same dependency tracker and the benefit of improving the
> >	existing one is that we can always use the self test to catch
> >	any regression. Thoughts?
> 
> Ack. If the internal implementation of lockdep has shortcomings, then we
> can expand and/or replace it instead of having yet another
> infrastructure which is not even remotely as mature.

Ultimately, yes. We should expand or replace it instead of having
another ultimately.

	Byungchul
> 
> Thanks,
> 
>         tglx
