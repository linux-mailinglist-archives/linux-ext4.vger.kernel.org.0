Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACD33E2877
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244988AbhHFKUv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbhHFKUt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 06:20:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A9C061798;
        Fri,  6 Aug 2021 03:20:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g30so12666835lfv.4;
        Fri, 06 Aug 2021 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NY0Eayk+JVPoPj6yQpr6EnQIT+9fwphAtZ6SL7sbftM=;
        b=K/IMcSsbtVvm9aSTtPzfZj1lAbdjoXGfto9+VNfwypQfNzzSO0FyIYU9Z08orgDR8C
         Te3Da14Kqs6LT6i4CFJ9VgkeUQImqRNHbOX1MqrosK1Xb7DfYsJ2/G9Lo2II2hpdSLhQ
         zSE3RJTcKkvGB0DreH4/t3Q0pxewPrM7vIQsGsU8t0ObsCFppe++OP3igytkrVXcQI8d
         b8Uqc5voG1jzwmqJgl0YTF3jcRqq5alOnLvSELd8JouQNdFWze4P4TvgquYRvKvVnZ7e
         l6kk3YU2jU1NOnWNIW3irESflUP5Jm0+lAkuuZAZ8jJDaQZB8XCC3r8QYsr8SWoPAqT9
         F5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NY0Eayk+JVPoPj6yQpr6EnQIT+9fwphAtZ6SL7sbftM=;
        b=rJ5U/nN+s7+DD/hvX66GLw46JZQhBXCw5zLpRc+hxX3jYqXNGDSCfBpvCMqfFl4dt4
         zym/V/R2t/tY4+6h5f5OU7XlD6Rv7bTPjyL20Xy7yqkEujwTIqBomyAW4LE613NylCtV
         0/PDC3pPKBxM5vh15wA9D2duFqX2lzLH6Y/9bntIWyYyqGzyd3ROFsEzAjh7pI3E6quj
         4JDD+EksHba9RvQw4gR/aiknZief9nIQTNhrroKJvfL3T8NHTSW0oOeRy1Pt6veTFFHe
         9V72iv4lLOlpFq1j/ehyHBVZkN+730IIPcuUzS/2o2J0aXTDII2G2FTZbgvqjNaoxtop
         w3jg==
X-Gm-Message-State: AOAM533Ftw/cZFw9VvQPL+MuKCsxDMBSRI4XPqpqcboZCyFYhD462d3v
        T4aQaN5Ksi6oqvoKm8ibSKg=
X-Google-Smtp-Source: ABdhPJyBpq58EGxTOc3Jv/UMTeDr/bXUBPegjAk71jyWtaWU8DZ9bNXDkYAsv2nVFuwCAsnIztaIPg==
X-Received: by 2002:a05:6512:114a:: with SMTP id m10mr7054762lfg.15.1628245230754;
        Fri, 06 Aug 2021 03:20:30 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.226.235])
        by smtp.gmail.com with ESMTPSA id u7sm650700lja.58.2021.08.06.03.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:20:30 -0700 (PDT)
Subject: Re: [PATCH] ext4: avoid huge mmp update interval value
To:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, johann@whamcloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
References: <20210805151418.30659-1-paskripkin@gmail.com>
 <YQw/2PuZ8z22Qice@mit.edu> <2e940500-6d77-2871-407b-201ca29f24fc@gmail.com>
 <20210805225926.GB2566745@dread.disaster.area>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <6a3a2390-b350-f723-8293-1658264f22c3@gmail.com>
Date:   Fri, 6 Aug 2021 13:20:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805225926.GB2566745@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/6/21 1:59 AM, Dave Chinner wrote:
> On Thu, Aug 05, 2021 at 11:12:42PM +0300, Pavel Skripkin wrote:
>> On 8/5/21 10:45 PM, Theodore Ts'o wrote:
>> > On Thu, Aug 05, 2021 at 06:14:18PM +0300, Pavel Skripkin wrote:
>> > > Syzbot reported task hung bug in ext4_fill_super(). The problem was in
>> > > too huge mmp update interval.
>> > > 
>> > > Syzkaller reproducer setted s_mmp_update_interval to 39785 seconds. This
>> > > update interaval is unreasonable huge and it can cause tasks to hung on
>> > > kthread_stop() call, since it will wait until timeout timer expires.
>> > 
>> > I must be missing something.  kthread_stop() should wake up the
>> > kmmpd() thread, which should see kthread_should_stop(), and then it
>> > should exit.  What is causing it to wait until the timeout timer
>> > expires?
>> > 
>> > 					- Ted
>> > 
>> 
>> 
>> Hi, Ted!
>> 
>> I guess, I've explained my idea badly, sorry :)
>> 
>> I mean, that there is a chance to hit this situation:
>> 
>> CPU0				CPU1
>> 				kthread_should_stop()  <-- false
>> kthread_stop()
>> set_bit(KTHREAD_SHOULD_STOP)				
>> wake_up_process()
>> wait_for_completion()
>> 				schedule_timeout_interruptible()
>> 
>> *waits until timer expires*
> 
> Yeah, so the bug here is checking kthread_should_stop() while
> the task state is TASK_RUNNING.
> 
> What you need to do here is:
> 
> while (run) {
> 
> 	....
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	if (kthread_should_stop()) {
> 		__set_current_state(TASK_RUNNING);
> 		break;
> 	}
> 	schedule_timeout(tout);
> 
> 	.....
> }
> 
> 
> That means in the case above where schedule() occurs after the
> kthread_should_stop() check has raced with kthread_stop(), then
> wake_up_process() will handle any races with schedule() correctly.
> 
> i.e.  wake_up_process() will set the task state to TASK_RUNNING and
> schedule() will not sleep if it is called after wake_up_process().
> Or if schedule() runs first then wake_up_process() will wake it
> correctly after setting the state to TASK_RUNNING.
> 
> Either way, the loop then runs around again straight away to the next
> kthread_should_stop() call, at which point it breaks out.
> 
> I note that the "wait_to_exit:" code in the same function does this
> properly....
> 

Hi, Dave!

I've tested your suggestion with syzbot and it works, thank you!


Anyway, @Ted, does it make sense to add boundaries for 
s_mmp_update_interval? I think, too big update interval for mmp isn't 
reasonable. I can send patch series with Dave's suggestion and previous 
patch. What do you think?




With regards,
Pavel Skripkin
