Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B0341F30
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCSOQn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Mar 2021 10:16:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56063 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhCSOQP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Mar 2021 10:16:15 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12JEFlYg085436;
        Fri, 19 Mar 2021 23:15:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Fri, 19 Mar 2021 23:15:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12JEFkPv085433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Mar 2021 23:15:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] KCSAN: data-race in start_this_handle /
 start_this_handle
To:     Marco Elver <elver@google.com>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Jan Kara <jack@suse.cz>
References: <0000000000008de88005bd40ac36@google.com>
 <20210311142503.GA31816@quack2.suse.cz>
 <CACT4Y+ZtBwv1aXUumTXnWzAi7LEpJ6CZemGyVR2FC6_YO2E4EQ@mail.gmail.com>
 <YEoybjJpCQzNx15r@elver.google.com> <YEo3gYOU/VnmHCeV@mit.edu>
 <CANpmjNNwvDDcDnfDtwCKKpGVnHEuwhn5tP+eK0CH7R_FgQgCtA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9dd08907-654c-bc38-fd9f-4324304152af@i-love.sakura.ne.jp>
Date:   Fri, 19 Mar 2021 23:15:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNNwvDDcDnfDtwCKKpGVnHEuwhn5tP+eK0CH7R_FgQgCtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/03/12 0:54, Marco Elver wrote:
>> But the more we could have the compiler automatically figure out
>> things without needing an explicit tag, it would seem to me that this
>> would be better, since manual tagging is going to be more error-prone.
> 
> What you're alluding to here would go much further than a data race
> detector ("data race" is still just defined by the memory model). The
> wish that there was a static analysis tool that would automatically
> understand the "concurrency semantics as intended by the developer" is
> something that'd be nice to have, but just doesn't seem realistic.
> Because how can a tool tell what the developer intended, without input
> from that developer?

Input from developers is very important for not only compilers and tools
but also allowing bug-explorers to understand what is happening.
ext4 currently has

  possible deadlock in start_this_handle (2)
  https://syzkaller.appspot.com/bug?id=38c060d5757cbc13fdffd46e80557c645fbe79ba

which even maintainers cannot understand what is happening.
How can bug-explorers know implicit logic which maintainers believe safe and correct?
It is possible that some oversight in implicit logic is the cause of
"possible deadlock in start_this_handle (2)".
Making implicit assumptions clear helps understanding.

Will "KCSAN: data-race in start_this_handle / start_this_handle" be addressed by marking?
syzbot is already waiting for
"KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata" at
https://syzkaller.appspot.com/bug?id=5eb10023f53097f003e72c6a7c1a6f14b7c22929 .

> 
> If there's worry marking accesses is error-prone, then that might be a
> signal that the concurrency design is too complex (or the developer
> hasn't considered all cases).
> 
> For that reason, we need to mark accesses to tell the compiler and
> tooling where to expect concurrency, so that 1) the compiler generates
> correct code, and 2) tooling such as KCSAN can double-check what the
> developer intended is actually what's happening.

and 3) bug-explorers can understand what the developers are assuming/missing.

