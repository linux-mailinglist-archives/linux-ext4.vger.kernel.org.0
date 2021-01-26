Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A5B303511
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jan 2021 06:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbhAZFe2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jan 2021 00:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbhAZBbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jan 2021 20:31:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BABC061220;
        Mon, 25 Jan 2021 16:50:08 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j21so4119784pls.7;
        Mon, 25 Jan 2021 16:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90gOqXB5kIgrCtezxzYynADxoGqHYZyZlhmhfaaFijY=;
        b=dASJ6QC7vC3AsXlxSfTUL5EYu5Fo9DWo3oRgoZtwag1Q64ThVQAYlofDbVu5bPRcQk
         1XHMr9KIJYgxlM2l+Fm9LshUZBE+JtLyj1FRY1flmXgmTQMCuW6nzJvEjysps2U5LsoC
         RPLMCewbw0aV9TUi/2gzfrL7eQA2MckCGjyndG85TUHa842pEUb8QqtZ9cnxxyMCvKe7
         obdmEd174RsNTj/pHaGrFOQSN5tq17K7JmnaYHHlc9GFySHaVhXBx+miM6pncYGTKzgf
         qaUK3ME2+k4g1NACX15GZQ5Z8mjV5IJDau4FKh9Qk3p2P9GHUBJB1BRmFvcF3GJHevNU
         2Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90gOqXB5kIgrCtezxzYynADxoGqHYZyZlhmhfaaFijY=;
        b=eBpTFzm2exebuJsxtOQCO+ys1MwD8vHO2czwJnfInLXYDqkcetnAIqDmSWVB4nGqzC
         fumT0rStZyoCgQm91Np9yI4qwvO5veRRHlV58yDmgDBksUPaZ5AJWIMxV8VJ4JgXVYxr
         52KUy0Efe/rmO5lzPKMWR3BvhI9U/inInRQPg7XYgtrO9bcD+JKhZw1H//SIXH2BWuB1
         seRT/unXuwHzVKzs3+daOsOjWgdFlEfUtCNbrBFBXP42/UZtSHUsX45+JWrEfqpZT9pY
         Yaf5vMGuP+65bdRqrg4Ki77V+QVWY+ykGjEQHOtokhs9mJ+UgulaXnqOYhlhERirIjHz
         fBVw==
X-Gm-Message-State: AOAM533v2G0nMWpXekMpIQ/UzgR3lWjejvojxKh76t9Mb23CoK0z630e
        nZdU5Ubuf7VKOUIYOtrp7sHYttMl2+kvybGq
X-Google-Smtp-Source: ABdhPJyab2pKuHBsULNFgbWe4b2guUQ7smJgOJ8t+XnhYliGNJZCvyCaNHtcC7Y2VcWG8IGh4V7PHQ==
X-Received: by 2002:a17:90b:4acc:: with SMTP id mh12mr3054080pjb.10.1611622207203;
        Mon, 25 Jan 2021 16:50:07 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.50])
        by smtp.gmail.com with ESMTPSA id v26sm1282031pff.195.2021.01.25.16.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 16:50:06 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/4] make jbd2 debug switch per device
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, jack@suse.com,
        harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1611402263.git.brookxu@tencent.com>
 <YA89Ov+yuX6BHJpS@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <c2bfc960-d86c-b20a-e3eb-7995200a5dd8@gmail.com>
Date:   Tue, 26 Jan 2021 08:50:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YA89Ov+yuX6BHJpS@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Theodore Ts'o wrote on 2021/1/26 5:50:
> On Sat, Jan 23, 2021 at 08:00:42PM +0800, Chunguang Xu wrote:
>> On a multi-disk machine, because jbd2 debugging switch is global, this
>> confuses the logs of multiple disks. It is not easy to distinguish the
>> logs of each disk and the amount of generated logs is very large. Maybe
>> a separate debugging switch for each disk would be better, so that we
>> can easily distinguish the logs of a certain disk. 
>>
>> We can enable jbd2 debugging of a device in the following ways:
>> echo X > /proc/fs/jbd2/sdX/jbd2_debug
>>
>> But there is a small disadvantage here. Because the debugging switch is
>> placed in the journal_t object, the log before the object is initialized
>> will be lost. However, usually this will not have much impact on
>> debugging.
> 
> The jbd debugging infrastructure dates back to the very beginnings of
> ext3, when Stephen Tweedie added them while he was first implementing
> the jbd layer.  So this dates back to a time before we had other
> schemes like dynamic debug or tracepoints or eBPF.
> I wonder if instead of trying to enhance our own bespoke debugging
> system, instead we set up something like tracepoints where they would
> be useful.  I'm not proposing that we try to replace all jbd_debug()
> statements with tracepoints but I think it would be useful to look at
> what sort of information would actually be *useful* on a production
> server, and add those tracepoints to the jbd2 layer.  What I like
> about tracepoints is you can enable them on a much more fine-grained
> fashion; information is sent to userspace in a much more efficient
> manner than printk; you can filter tracepoint events in the kernel,
> before sending them to userspace; and if you want more sophisticated
> filtering or aggregation, you can use eBPF.

trace point, eBPF and other hook technologies are better for production
environments. But for pure debugging work, adding hook points feels a bit
heavy. However, your suggestion is very valuable, thank you very much.

> What was the original use case which inspired this?  Were you indeed
> trying to debug some kind of problem on a production system?  (Why did
> you have multiple disks active at the same time?)  Was there a
> specific problem you were trying to debug?  What debug level were you
> using?  Which jbd_debug statements were most useful to you?  Which
> just got in the way (but which had to be enabled given the log level
> you needed to get the debug messages that you needed)?

We only do this in the test environment, mainly to facilitate debugging.
We will dynamically adjust the log level, sometimes it is 1, sometimes
higher. There are two main reasons for multiple disks working at the same
time. The first is that the system management tool will update the system
disk, and the second is that the collaborative task will update other
disks. During the actual debugging, we added more additional logs. The
original logs of the system are useful, but some logs don't feel very
meaningful. Thanks.

>     	      	      	    	     	      - Ted
> 
