Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D03319E57
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 13:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhBLMYd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 07:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhBLMXC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 07:23:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B4C061788;
        Fri, 12 Feb 2021 04:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLQApXb/sXTlVKThMOmNrm1a3iojPyy3XpzYg3wntEM=; b=AXzAzBHBMaxVXDuzdJwA9TnNM/
        mTeOFL4n1b2MA6IriNolnXZG/icgCZ5CstHAW1nylSPSYPiVdkQRjGN0Y82gRq/5Qdd25fzGhc6od
        y/7PijcW2oAn0B97MkTOO+Tp/b8vjvmRGzn5sqW1XKIHlPeBGVIMSeU3d2c0EObnPikHdGAjtOu6O
        t5JYjQSGamvNLtgWPwyeFeqGIxOYUyx6mPFYwldFyY/vYzUIlMY817dpaJ7z6GJ6f/2tTcVnmVFaV
        WZFaptjwAeGmpSjOXRFqEHGwjjPowbDt5P1rxc5oYwan2cfis3qWvTpEhBkQY5b2W7xTl07KBsjcn
        RGyYUyNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAXSZ-00Ba2u-Fq; Fri, 12 Feb 2021 12:22:09 +0000
Date:   Fri, 12 Feb 2021 12:22:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <20210212122207.GM308988@casper.infradead.org>
References: <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
 <20210211121020.GO19070@quack2.suse.cz>
 <YCUkaJFoPkl7ZvKE@dhcp22.suse.cz>
 <20210211125717.GH308988@casper.infradead.org>
 <YCUr99//z8hJmnDH@dhcp22.suse.cz>
 <20210211132533.GI308988@casper.infradead.org>
 <YCU9OR7SfRpwl4+4@dhcp22.suse.cz>
 <20210211142630.GK308988@casper.infradead.org>
 <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
 <9cff0fbf-b6e7-1166-e4ba-d4573aef0c82@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cff0fbf-b6e7-1166-e4ba-d4573aef0c82@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 12, 2021 at 08:18:11PM +0900, Tetsuo Handa wrote:
> On 2021/02/12 1:41, Michal Hocko wrote:
> > But I suspect we have drifted away from the original issue. I thought
> > that a simple check would help us narrow down this particular case and
> > somebody messing up from the IRQ context didn't sound like a completely
> > off.
> > 
> 
>  From my experience at https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
> I think we can replace direct PF_* manipulation with macros which do not receive "struct task_struct *" argument.
> Since TASK_PFA_TEST()/TASK_PFA_SET()/TASK_PFA_CLEAR() are for manipulating PFA_* flags on a remote thread, we can
> define similar ones for manipulating PF_* flags on current thread. Then, auditing dangerous users becomes easier.

No, nobody is manipulating another task's GFP flags.
