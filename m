Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE9319D47
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 12:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhBLLUl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 06:20:41 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60765 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhBLLUS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 06:20:18 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11CBIE5c098656;
        Fri, 12 Feb 2021 20:18:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Fri, 12 Feb 2021 20:18:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11CBIEE2098653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Feb 2021 20:18:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in start_this_handle (2)
To:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
References: <20210211104947.GL19070@quack2.suse.cz>
 <CACT4Y+b5gSAAtX3DUf-H3aRxbir44MTO6BCC3XYvN=6DniT+jw@mail.gmail.com>
 <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
 <20210211121020.GO19070@quack2.suse.cz> <YCUkaJFoPkl7ZvKE@dhcp22.suse.cz>
 <20210211125717.GH308988@casper.infradead.org>
 <YCUr99//z8hJmnDH@dhcp22.suse.cz>
 <20210211132533.GI308988@casper.infradead.org>
 <YCU9OR7SfRpwl4+4@dhcp22.suse.cz>
 <20210211142630.GK308988@casper.infradead.org>
 <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9cff0fbf-b6e7-1166-e4ba-d4573aef0c82@i-love.sakura.ne.jp>
Date:   Fri, 12 Feb 2021 20:18:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/02/12 1:41, Michal Hocko wrote:
> But I suspect we have drifted away from the original issue. I thought
> that a simple check would help us narrow down this particular case and
> somebody messing up from the IRQ context didn't sound like a completely
> off.
> 

 From my experience at https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
I think we can replace direct PF_* manipulation with macros which do not receive "struct task_struct *" argument.
Since TASK_PFA_TEST()/TASK_PFA_SET()/TASK_PFA_CLEAR() are for manipulating PFA_* flags on a remote thread, we can
define similar ones for manipulating PF_* flags on current thread. Then, auditing dangerous users becomes easier.
