Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B53E1F15
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 00:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhHEW7v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 18:59:51 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:39251 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhHEW7u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 18:59:50 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 9372580BA06;
        Fri,  6 Aug 2021 08:59:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mBmKk-00Exmn-ED; Fri, 06 Aug 2021 08:59:26 +1000
Date:   Fri, 6 Aug 2021 08:59:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        johann@whamcloud.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: avoid huge mmp update interval value
Message-ID: <20210805225926.GB2566745@dread.disaster.area>
References: <20210805151418.30659-1-paskripkin@gmail.com>
 <YQw/2PuZ8z22Qice@mit.edu>
 <2e940500-6d77-2871-407b-201ca29f24fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e940500-6d77-2871-407b-201ca29f24fc@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=MhDmnRu9jo8A:10 a=7-415B0cAAAA:8
        a=znp41cB1dSf8sDBhxX4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 05, 2021 at 11:12:42PM +0300, Pavel Skripkin wrote:
> On 8/5/21 10:45 PM, Theodore Ts'o wrote:
> > On Thu, Aug 05, 2021 at 06:14:18PM +0300, Pavel Skripkin wrote:
> > > Syzbot reported task hung bug in ext4_fill_super(). The problem was in
> > > too huge mmp update interval.
> > > 
> > > Syzkaller reproducer setted s_mmp_update_interval to 39785 seconds. This
> > > update interaval is unreasonable huge and it can cause tasks to hung on
> > > kthread_stop() call, since it will wait until timeout timer expires.
> > 
> > I must be missing something.  kthread_stop() should wake up the
> > kmmpd() thread, which should see kthread_should_stop(), and then it
> > should exit.  What is causing it to wait until the timeout timer
> > expires?
> > 
> > 					- Ted
> > 
> 
> 
> Hi, Ted!
> 
> I guess, I've explained my idea badly, sorry :)
> 
> I mean, that there is a chance to hit this situation:
> 
> CPU0				CPU1
> 				kthread_should_stop()  <-- false
> kthread_stop()
> set_bit(KTHREAD_SHOULD_STOP)				
> wake_up_process()
> wait_for_completion()
> 				schedule_timeout_interruptible()
> 
> *waits until timer expires*

Yeah, so the bug here is checking kthread_should_stop() while
the task state is TASK_RUNNING.

What you need to do here is:

while (run) {

	....
	set_current_state(TASK_INTERRUPTIBLE);
	if (kthread_should_stop()) {
		__set_current_state(TASK_RUNNING);
		break;
	}
	schedule_timeout(tout);

	.....
}


That means in the case above where schedule() occurs after the
kthread_should_stop() check has raced with kthread_stop(), then
wake_up_process() will handle any races with schedule() correctly.

i.e.  wake_up_process() will set the task state to TASK_RUNNING and
schedule() will not sleep if it is called after wake_up_process().
Or if schedule() runs first then wake_up_process() will wake it
correctly after setting the state to TASK_RUNNING.

Either way, the loop then runs around again straight away to the next
kthread_should_stop() call, at which point it breaks out.

I note that the "wait_to_exit:" code in the same function does this
properly....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
