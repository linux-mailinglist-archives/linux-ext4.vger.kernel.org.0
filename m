Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11940319FF8
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 14:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBLNhb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 08:37:31 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64817 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhBLNh2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Feb 2021 08:37:28 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11CDYQpr053608;
        Fri, 12 Feb 2021 22:34:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Fri, 12 Feb 2021 22:34:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11CDYPIM053602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Feb 2021 22:34:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in start_this_handle (2)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
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
 <YCZ+2ZStwTbApo5E@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a47ec496-f9ed-763b-5c66-b8423d65ec82@i-love.sakura.ne.jp>
Date:   Fri, 12 Feb 2021 22:34:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCZ+2ZStwTbApo5E@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/02/12 22:12, Michal Hocko wrote:
> On Fri 12-02-21 21:58:15, Tetsuo Handa wrote:
>> On 2021/02/12 21:30, Michal Hocko wrote:
>>> On Fri 12-02-21 12:22:07, Matthew Wilcox wrote:
>>>> On Fri, Feb 12, 2021 at 08:18:11PM +0900, Tetsuo Handa wrote:
>>>>> On 2021/02/12 1:41, Michal Hocko wrote:
>>>>>> But I suspect we have drifted away from the original issue. I thought
>>>>>> that a simple check would help us narrow down this particular case and
>>>>>> somebody messing up from the IRQ context didn't sound like a completely
>>>>>> off.
>>>>>>
>>>>>
>>>>>  From my experience at https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
>>>>> I think we can replace direct PF_* manipulation with macros which do not receive "struct task_struct *" argument.
>>>>> Since TASK_PFA_TEST()/TASK_PFA_SET()/TASK_PFA_CLEAR() are for manipulating PFA_* flags on a remote thread, we can
>>>>> define similar ones for manipulating PF_* flags on current thread. Then, auditing dangerous users becomes easier.
>>>>
>>>> No, nobody is manipulating another task's GFP flags.
>>>
>>> Agreed. And nobody should be manipulating PF flags on remote tasks
>>> either.
>>>
>>
>> No. You are misunderstanding. The bug report above is an example of manipulating PF flags on remote tasks.
> 
> Could you be more specific? I do not remember there was any theory that
> somebody is manipulating flags on a remote task. A very vague theory was
> that an interrupt context might be doing that on the _current_ context
> but even that is not based on any real evidence. It is a pure
> speculation.
> 

Please read the link above. The report is an example of manipulating PF flags on a remote task.
You are thinking interrupt context as the only possible culprit, but you should also think
concurrent access as the other possible culprit.
