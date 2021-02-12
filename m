Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C60319FA0
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBLNO0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 08:14:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:34716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhBLNNp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Feb 2021 08:13:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613135577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbvD0ELrznZKPnNNl0HUBrOi1DWu0bvse8JkNJGdDRo=;
        b=iWUAxj11LEJ71+1Jag+ZMLi0QF45zOUDT+PkV4hrxnef9ep1y/LwWZWm2puQMPzZWSVzQq
        /vESrx8fUz0lfk0F/DuHhwbqCmyzVXJwX4ivVfs/FH9vPX4eJeUixvkVAXkVzkJs1C70LC
        9dbq8ImgPU9oxPHscKoH9+GaohBvX9Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2C86AC90;
        Fri, 12 Feb 2021 13:12:57 +0000 (UTC)
Date:   Fri, 12 Feb 2021 14:12:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <YCZ+2ZStwTbApo5E@dhcp22.suse.cz>
References: <20210211125717.GH308988@casper.infradead.org>
 <YCUr99//z8hJmnDH@dhcp22.suse.cz>
 <20210211132533.GI308988@casper.infradead.org>
 <YCU9OR7SfRpwl4+4@dhcp22.suse.cz>
 <20210211142630.GK308988@casper.infradead.org>
 <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
 <9cff0fbf-b6e7-1166-e4ba-d4573aef0c82@i-love.sakura.ne.jp>
 <20210212122207.GM308988@casper.infradead.org>
 <YCZ056SJDGrgXCss@dhcp22.suse.cz>
 <2b90c488-a6b9-2565-bd3a-e4f8bf8404e9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b90c488-a6b9-2565-bd3a-e4f8bf8404e9@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 12-02-21 21:58:15, Tetsuo Handa wrote:
> On 2021/02/12 21:30, Michal Hocko wrote:
> > On Fri 12-02-21 12:22:07, Matthew Wilcox wrote:
> >> On Fri, Feb 12, 2021 at 08:18:11PM +0900, Tetsuo Handa wrote:
> >>> On 2021/02/12 1:41, Michal Hocko wrote:
> >>>> But I suspect we have drifted away from the original issue. I thought
> >>>> that a simple check would help us narrow down this particular case and
> >>>> somebody messing up from the IRQ context didn't sound like a completely
> >>>> off.
> >>>>
> >>>
> >>>  From my experience at https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
> >>> I think we can replace direct PF_* manipulation with macros which do not receive "struct task_struct *" argument.
> >>> Since TASK_PFA_TEST()/TASK_PFA_SET()/TASK_PFA_CLEAR() are for manipulating PFA_* flags on a remote thread, we can
> >>> define similar ones for manipulating PF_* flags on current thread. Then, auditing dangerous users becomes easier.
> >>
> >> No, nobody is manipulating another task's GFP flags.
> > 
> > Agreed. And nobody should be manipulating PF flags on remote tasks
> > either.
> > 
> 
> No. You are misunderstanding. The bug report above is an example of manipulating PF flags on remote tasks.

Could you be more specific? I do not remember there was any theory that
somebody is manipulating flags on a remote task. A very vague theory was
that an interrupt context might be doing that on the _current_ context
but even that is not based on any real evidence. It is a pure
speculation.
-- 
Michal Hocko
SUSE Labs
