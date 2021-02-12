Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8B319E72
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 13:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBLMbV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 07:31:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhBLMbT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Feb 2021 07:31:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613133032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qj3DCkH6KSXjLCqZi9x6XmR8kpK5XSIPuFj/6qx+Dk=;
        b=GJdLO7vNuHU5kY/jx531qhdurR1ot+bvUV9wWhO8u2XWIGldELlfyLJidkMmSdnPn3rWEg
        Moy4uqup9gTrdN6ugKLmIc1sLfAdJJavfJxHaFkN9mXOkRRLSo/w7zH5E4LOqpxOq0yXKc
        iha7zSMFZfbcfuMcpheYvZOAM7Sqf1M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B501AC69;
        Fri, 12 Feb 2021 12:30:32 +0000 (UTC)
Date:   Fri, 12 Feb 2021 13:30:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Theodore Ts'o <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
Subject: Re: possible deadlock in start_this_handle (2)
Message-ID: <YCZ056SJDGrgXCss@dhcp22.suse.cz>
References: <20210211121020.GO19070@quack2.suse.cz>
 <YCUkaJFoPkl7ZvKE@dhcp22.suse.cz>
 <20210211125717.GH308988@casper.infradead.org>
 <YCUr99//z8hJmnDH@dhcp22.suse.cz>
 <20210211132533.GI308988@casper.infradead.org>
 <YCU9OR7SfRpwl4+4@dhcp22.suse.cz>
 <20210211142630.GK308988@casper.infradead.org>
 <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
 <9cff0fbf-b6e7-1166-e4ba-d4573aef0c82@i-love.sakura.ne.jp>
 <20210212122207.GM308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212122207.GM308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 12-02-21 12:22:07, Matthew Wilcox wrote:
> On Fri, Feb 12, 2021 at 08:18:11PM +0900, Tetsuo Handa wrote:
> > On 2021/02/12 1:41, Michal Hocko wrote:
> > > But I suspect we have drifted away from the original issue. I thought
> > > that a simple check would help us narrow down this particular case and
> > > somebody messing up from the IRQ context didn't sound like a completely
> > > off.
> > > 
> > 
> >  From my experience at https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
> > I think we can replace direct PF_* manipulation with macros which do not receive "struct task_struct *" argument.
> > Since TASK_PFA_TEST()/TASK_PFA_SET()/TASK_PFA_CLEAR() are for manipulating PFA_* flags on a remote thread, we can
> > define similar ones for manipulating PF_* flags on current thread. Then, auditing dangerous users becomes easier.
> 
> No, nobody is manipulating another task's GFP flags.

Agreed. And nobody should be manipulating PF flags on remote tasks
either.

-- 
Michal Hocko
SUSE Labs
