Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9343074F5
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jan 2021 12:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhA1LkX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jan 2021 06:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1LkV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Jan 2021 06:40:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5BAC061573;
        Thu, 28 Jan 2021 03:39:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q20so3819159pfu.8;
        Thu, 28 Jan 2021 03:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbwPSRtJGMbpcaJFwCrc5PppUMnPA2n+qmlmfHpLpcY=;
        b=aDLRNbuR4Lhm4B2P6/RAPOJgXisPSJ5+kPWZ/60HPx6G/r2uHwMbmtRBNNzj/D0Ydk
         oztzGZF5mOyZzy29JDa2e7Mjh5E+QHWEEkvmRMwsScwja5DlLxWn2M1mhA8NeooE6jLo
         x0xsqs1SQsY6Er82tU4kldSmbdNq8DZSPOnfRVQ0Kv4sLK9bFZc84tcSYUr8bqM8yL0m
         LjZIr4nD3BHu6IV34F/iduWUfuJ/AFwbZOff9PzBSYq6Nl7YvDWTj5pxQAQW9FSKlp35
         4xEjFcClbRpCQ283uvM5yxEzG8oMoyhf86qV8lYWL2rRts8Uls8NAP0JfB8GrpVTZE23
         663g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbwPSRtJGMbpcaJFwCrc5PppUMnPA2n+qmlmfHpLpcY=;
        b=jBQZM5x9Qf1OfG4XD0WZdq+3at+3zsiHHXG6PKlPjh7LOFSU16pRl3HFL88zkzPT6m
         lFiCNZb3hfw6Gm63YX53nOq7wLwSzMEtes7MqoQHvLUuNsnjybr8Lernj3BaCk5NZINh
         VU58ahOGzSnO3jepv/8OCO6kDHevUBoocHFHJ8270ZOoLVXrpMUlg/QZIqj/LnAdYfhK
         SH9q1IVLIqQZ4RgSayPid4EAx9mnpcXBOopSiT4jzPJdoS4QzsMGrZ/4kWJiBMxxZE+N
         tLHxONBs7GP95fp5GPAtQJN/WHyqOMy74SV0M8JQaOMnQSZB2x8peQ6z1PyyegMqum2Y
         9E1w==
X-Gm-Message-State: AOAM530kfNFoCzZ9+4F6WCnt63BZcMhJsdAIkAgP6buT/xOG4qz9AdnP
        To5WvqP5QdECwzPC5GMDBQy6Cu20qdiCJw==
X-Google-Smtp-Source: ABdhPJyFS9OqjDCOqsJKY7BeSsZzeX4E6S28lFaxU7lVCVpVLHp0j/2EeYj00doRHAf2/A3IB6ZZnw==
X-Received: by 2002:aa7:9736:0:b029:1b9:c4f5:54d5 with SMTP id k22-20020aa797360000b02901b9c4f554d5mr15128904pfg.47.1611833980175;
        Thu, 28 Jan 2021 03:39:40 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.48])
        by smtp.gmail.com with ESMTPSA id s1sm4891425pjg.17.2021.01.28.03.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 03:39:39 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/4] make jbd2 debug switch per device
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, jack@suse.com,
        harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1611402263.git.brookxu@tencent.com>
 <YA89Ov+yuX6BHJpS@mit.edu> <c2bfc960-d86c-b20a-e3eb-7995200a5dd8@gmail.com>
 <YBGS/FJ8boyxyaPn@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <c18b18d8-75e8-0aa1-d181-e59b5fcce899@gmail.com>
Date:   Thu, 28 Jan 2021 19:39:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBGS/FJ8boyxyaPn@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Theodore Ts'o wrote on 2021/1/28 0:21:
> On Tue, Jan 26, 2021 at 08:50:02AM +0800, brookxu wrote:
>>
>> trace point, eBPF and other hook technologies are better for production
>> environments. But for pure debugging work, adding hook points feels a bit
>> heavy. However, your suggestion is very valuable, thank you very much.
> 
> What feels heavy?  The act of adding a new jbd_debug() statement to
> the sources, versus adding a new tracepoint?  Or how to enable a set
> of tracepoints versus setting a jbd_debug level (either globally, or
> per mount point)?  Or something else?

Sorry, I didn't make it clear here. I mean the amount of code modification
and data analysis. Since we mainly do some process confirmation, if it is
to add trace points, the amount of code is relatively large, if it is to
add log, it is relatively simple. Secondly, the modification of the kernel
and analysis scripts is relatively simple.

> If it's the latter (which is what I think it is), how often are you
> needing to add a new jbd_debug() statement *and* needing to run in a
> test environment where you have multiple disks?  How often is it
> useful to have multiple disks when doing your debugging?


We don't use JBD2_DEBUG much in our work. In most cases, we tend to add
hook points and analyze data from hook points. But here because it is a
process confirmation, if the hook point method is adopted, there are more
hook points and the workload is relatively large. Secondly, these hook
points are not needed in the production environment, maybe it is a waste
of time.

> I'm trying to understand why this has been useful to you, since that
> generally doesn't match with my development, testing, or debugging
> experience.  In general I try to test with one file system at a time,
> since I'm trying to find something reproducible.  Do you have cases
> where you need multiple file systems in your test environment in order
> to do your testing?  Why is that?  Is it because you're trying to use
> your production server code as your test reproducers?  And if so, I
> would have thought adding the jbd_debug() statements and sending lots
> of console print messages would distort the timing enough to make it
> hard to reproduce a problem in found in your production environment.


In our mixed deployment production environment, we occasionally find that
containers will have priority inversion problems, that is, low-priority
containers will affect the Qos of high-priority containers. We try to do
something to make ext4 work better in the container scene. After a basic
test, we will use the business program to test, because the IO behavior
of the business program is relatively more complicated. It is worth noting
that here we are mainly concerned with the correctness of the process, not
particularly concerned with performance.

> It sounds like you have a very different set of test practices than
> what I'm used to, and I'm trying to understand it better.

:), Perhaps my verification method is not optimal, but I found that jbd2
has a similar framework, and tried to use it, and then found that some
things can be optimized.
> Cheers,
> 
> 						- Ted
> 
