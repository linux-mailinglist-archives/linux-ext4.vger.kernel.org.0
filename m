Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061E15388F0
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbiE3W3Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 18:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiE3W3X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 18:29:23 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D93E0443E4;
        Mon, 30 May 2022 15:29:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0EF48534941;
        Tue, 31 May 2022 08:29:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvnt1-000lxB-Uq; Tue, 31 May 2022 08:29:19 +1000
Date:   Tue, 31 May 2022 08:29:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: Potential regression on kernel 5.19-rc0: kernel BUG at
 mm/page_table_check.c:51!
Message-ID: <20220530222919.GA1098723@dread.disaster.area>
References: <20220530080616.6h77ppymilyvjqus@zlang-mailbox>
 <20220530183908.vi7u37a6irji4gnf@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530183908.vi7u37a6irji4gnf@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62954542
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=cQWRpaAU1W1mfraSisIA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 31, 2022 at 02:39:08AM +0800, Zorro Lang wrote:
> On Mon, May 30, 2022 at 04:06:16PM +0800, Zorro Lang wrote:
> > Hi mm folks:
> > 
> > I reported a regression bug on latest upstream linux:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216047
> > 
> > It's about xfs/ext4 + DAX, panic at mm/page_table_check.c:51!
> > 
> >   static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
> >   {
> > ==>     BUG_ON(!page_ext);
> >         return (void *)(page_ext) + page_table_check_ops.offset;
> >   }
> > 
> > It's 100% reproducible for me, by running fstests generic/623:
> >   https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/623
> > on xfs or ext4 with DAX enabled.
> > 
> > It doesn't look like a xfs or ext4 issue, so send to linux-mm to get more
> > reviewing. More details please refer to above bug link. I changed its Pruduct
> > to mm, but the Assignee isn't changed by default.
> 
> It's not a regression *recently* at least, I still can reproduce this bug on
> linux v5.16.
> 
> But I found it's related with someone kernel configuration (sorry I haven't
> figured out which one config is). I've upload two kernel config files, one[1]
> can build a kernel which reproduce this bug, the other[2] can't. Hope that
> helps.
> 
> Thanks,
> Zorro
> 
> [1]
> https://bugzilla.kernel.org/attachment.cgi?id=301076
> 
> [2]
> https://bugzilla.kernel.org/attachment.cgi?id=301077

Rather than make anyone looking at this download multiple files and
run diff, perhaps you could just post the output of 'diff -u
config.good config.bad'?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
