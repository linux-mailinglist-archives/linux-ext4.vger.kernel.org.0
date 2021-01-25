Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD11304952
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jan 2021 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbhAZFdj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jan 2021 00:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbhAYOAl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jan 2021 09:00:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF63C0617A9;
        Mon, 25 Jan 2021 05:59:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lw17so9148519pjb.0;
        Mon, 25 Jan 2021 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YCNxOPt7j32/1EIvyQ0fS2gCRu3WbYw0TNwCSoOVYOQ=;
        b=U7kddIv9K4+RMbg8YUbJIW5e5lm0/rMWTI6cwWVYOrxXuAds2QBxe+fEAhCG+K43QG
         e3JtUe9DA2Z1YJLJJ4gsNpcPjH1fwHxG8UXYlzK11CFKPFFuBxBONSeBvyO1e1l1gsT8
         HxoJKpJRmlnGY+TSmVzyLfHfny1hBX7KFUY02JCfGGSND8K3eLbefYUNeM9hCWHkKcku
         tbKwEh3oJkclB2BNOUbKQc5ANQbq9ZdWoOX1ZGETcFa/GkBa6JmVg02x19qIM8BEe7Vm
         OdLb68RodxJPemBqUqcSOBr8j3MOqLxZTDA3Yw9HU7RWCy8XEhQ/VlCqn3ffZ3IkC16m
         5+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YCNxOPt7j32/1EIvyQ0fS2gCRu3WbYw0TNwCSoOVYOQ=;
        b=AyhPRvbgWaZbR4stDA5TQKPT3DV9+DP01tzWnU4myHXlD/6BP/q7W+gWCgiTtZIMWD
         E3nJidJQfDsHpokL4P5d7+cF0DEJa3XgY+RPH/l1arw6DHATS8792LXWgBWySljVGBOe
         sXK12hJFOT+gUjgJMXHxGmqocD3VEaTnPcc0YlgJ3LBhMBd6D50Av5cTgDE7uquLtFRb
         a3IGV2SNIfntG1y8C12mBCv655sapFdMjtS4vRoR9Z1lNY+guKBC1qwL3mxRaUF3Qopr
         I6/T2mbkwt/UwmK72KqhU27L+SaUU0nRSV633UNi9k4LUqMNr6a0U25chR/5nnn7mvI4
         Vn7Q==
X-Gm-Message-State: AOAM530EIJcSgv7wWFurFw02Q0sXm5XZ6nkpWfklwUxmaD/+bI1wV0ak
        yHPfZGwuyHMXp8FQl/LhGLPa9W4tW0vbIVNj
X-Google-Smtp-Source: ABdhPJx5FeX8a0GdQzhz6YSGSt3+jDk20i14nc7litXWkyqKlbbO1erv4O2wca+h7GOaUDMcN/xWiA==
X-Received: by 2002:a17:902:e844:b029:de:5abb:7df1 with SMTP id t4-20020a170902e844b02900de5abb7df1mr529152plg.55.1611583152007;
        Mon, 25 Jan 2021 05:59:12 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.48])
        by smtp.gmail.com with ESMTPSA id a14sm4587509pfl.169.2021.01.25.05.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 05:59:11 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] make jbd2 debug switch per device
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1611287342.git.brookxu@tencent.com>
 <20210125124117.GB1175@quack2.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <968d9c0f-153e-c187-4bc6-ab3cf7e257ca@gmail.com>
Date:   Mon, 25 Jan 2021 21:59:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125124117.GB1175@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your reply.

Jan Kara wrote on 2021/1/25 20:41:
> On Fri 22-01-21 14:43:18, Chunguang Xu wrote:
>> On a multi-disk machine, because jbd2 debugging switch is global, this
>> confuses the logs of multiple disks. It is not easy to distinguish the
>> logs of each disk and the amount of generated logs is very large. Or a
>> separate debugging switch for each disk would be better, so that you
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
> OK, I didn't look at the series yet but I'm wondering: How are you using
> jbd2 debugging? I mean obviously it isn't meant for production use but
> rather for debugging JBD2 bugs so I'm kind of wondering in which case too
> many messages matter.
We perform stress testing on machines in the test environment, and use scripts
to capture journal related logs to analyze problems. There are 12 disks on this
machine, and each disk runs different jobs. Our test kernel also adds some
additional function-related logs. If we adjust the log level to a higher level,
a large number of logs have nothing to do with the disk to be observed. These
logs are generated by system agents or coordinated tasks. This makes the log
difficul to analyze.
 
> And if the problem is that there's a problem with distinguishing messages
> from multiple filesystems, then it would be perhaps more useful to add
> journal identification to each message similarly as we do it with ext4
> messages (likely by using journal->j_dev) - which is very simple to do
> after your patches 3 and 4.
Our test kernel did this. Because it broke the log format, I was not sure whether
it would break something, so I didn't bring this part. Even if the device information
is added, when there are more disks and the log level is higher, there will be a
lot of irrelevant logs, which makes it necessary to consume a lot of CPU to filter
messages. Therefore, a device-level switch is provided to make everything simpler.
> 
> 								Honza
> 
