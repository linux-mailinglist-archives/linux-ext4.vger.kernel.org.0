Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA434231F
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 18:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCSRXt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 13:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhCSRXe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Mar 2021 13:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5229D61974;
        Fri, 19 Mar 2021 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616174614;
        bh=hNX+LrkMfSM0iqEf9EP/S+4IJ0fzrmsW7oiN9xVuizM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DUAJvP/1PLsmXsxmv4ro/UftGandWMqTqawyUoeg7wqxec7qSCZV3rlQWrUr50Mm5
         EtvuyhavZERplHcVJGiX4+dHAG7aw+/0VjCTD9Qdb9cpN4Q3iC4bHXykdl4mC4hcvy
         SVewctdKDZiUeIxHyZSQ0fUbO77yIy/z1PTZOmOGof3Ok7zdWax/PdFhXwdBm5hJRX
         n6n4kFx4TIOs/rEAbGePhTBL7bkyyWO8vmyea+c+KRAjQ0YgjXzNINLCHQ5msqCgO3
         ZY9FktO66JKCpOcJ3IMBhPo3F1Dup8wKqd9rTs7Yss4Oyoc9BB7LNygltiSQbFxKn2
         wO11hCfam1KTg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2538835239E5; Fri, 19 Mar 2021 10:23:34 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:23:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marco Elver <elver@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [syzbot] KCSAN: data-race in start_this_handle /
 start_this_handle
Message-ID: <20210319172334.GN2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0000000000008de88005bd40ac36@google.com>
 <20210311142503.GA31816@quack2.suse.cz>
 <CACT4Y+ZtBwv1aXUumTXnWzAi7LEpJ6CZemGyVR2FC6_YO2E4EQ@mail.gmail.com>
 <YEoybjJpCQzNx15r@elver.google.com>
 <YEo3gYOU/VnmHCeV@mit.edu>
 <CANpmjNNwvDDcDnfDtwCKKpGVnHEuwhn5tP+eK0CH7R_FgQgCtA@mail.gmail.com>
 <9dd08907-654c-bc38-fd9f-4324304152af@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd08907-654c-bc38-fd9f-4324304152af@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 19, 2021 at 11:15:42PM +0900, Tetsuo Handa wrote:
> On 2021/03/12 0:54, Marco Elver wrote:
> >> But the more we could have the compiler automatically figure out
> >> things without needing an explicit tag, it would seem to me that this
> >> would be better, since manual tagging is going to be more error-prone.
> > 
> > What you're alluding to here would go much further than a data race
> > detector ("data race" is still just defined by the memory model). The
> > wish that there was a static analysis tool that would automatically
> > understand the "concurrency semantics as intended by the developer" is
> > something that'd be nice to have, but just doesn't seem realistic.
> > Because how can a tool tell what the developer intended, without input
> > from that developer?
> 
> Input from developers is very important for not only compilers and tools
> but also allowing bug-explorers to understand what is happening.
> ext4 currently has
> 
>   possible deadlock in start_this_handle (2)
>   https://syzkaller.appspot.com/bug?id=38c060d5757cbc13fdffd46e80557c645fbe79ba
> 
> which even maintainers cannot understand what is happening.
> How can bug-explorers know implicit logic which maintainers believe safe and correct?
> It is possible that some oversight in implicit logic is the cause of
> "possible deadlock in start_this_handle (2)".
> Making implicit assumptions clear helps understanding.

Just to be clear, the above diagnostic is from lockdep rather than KCSAN.

According to the sample crash result, different code paths acquire
jdb2_handle and the __fs_reclaim_map in different orders.  It looks
to me that __fs_reclaim_map isn't really a lock, but rather a mode
indicator.  If so, lockdep should set it up accordingly, perhaps
in a manner similar to rcu_lock_map.

> Will "KCSAN: data-race in start_this_handle / start_this_handle" be addressed by marking?
> syzbot is already waiting for
> "KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata" at
> https://syzkaller.appspot.com/bug?id=5eb10023f53097f003e72c6a7c1a6f14b7c22929 .

The first thing is to work out what the code should be doing.  What KCSAN
is saying is that a variable is being locklessly updated.  Is it really
OK for that variable to be locklessly updated?  If not, a larger fix
is required.

For more information, please see Marco's LWN series:
https://lwn.net/Articles/816850/ and https://lwn.net/Articles/816854/

Alternatively, you can refer to the documentation being proposed for
the Linux kernel tree:

https://lore.kernel.org/lkml/20210304004543.25364-3-paulmck@kernel.org/

> > If there's worry marking accesses is error-prone, then that might be a
> > signal that the concurrency design is too complex (or the developer
> > hasn't considered all cases).
> > 
> > For that reason, we need to mark accesses to tell the compiler and
> > tooling where to expect concurrency, so that 1) the compiler generates
> > correct code, and 2) tooling such as KCSAN can double-check what the
> > developer intended is actually what's happening.
> 
> and 3) bug-explorers can understand what the developers are assuming/missing.

If the above information doesn't help the bug explorers, please let me
know.

							Thanx, Paul
