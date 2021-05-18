Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7D386F12
	for <lists+linux-ext4@lfdr.de>; Tue, 18 May 2021 03:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243495AbhERBV6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbhERBVv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 21:21:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74BC061573;
        Mon, 17 May 2021 18:20:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 69so4163298plc.5;
        Mon, 17 May 2021 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B3Y8K28Bk2cHjlmHVhWfZJK+jWG4xRdwr+oMbl8ZdQQ=;
        b=LlXudOpBBjO0YpuaL67deWpsqGTktYcv0rBm+LPYRFPIwulTRMIH5DmV5F9UNFkVD4
         obZKugAeROE7jDI1cN2LE9ZHmhJgQGFvZ0DAYcUQ0kaW6IyyT3ncYHifSUfpl+XdkHp+
         NUvjV8gDeEtMGO7aeXUAT+0vSqMdZG0bRqiq3o522zNsHi6OVxnWUcD2VS175FjbChml
         I4Xva0tj2o0FVAVEsR3o8ZKj2esqJd3BMQLitdgUTyGqX4XIOmJMkJfSC1fiYjsR72N9
         6EZ7BCowwi6QxdEQfmHET3J2CBlaShL/8kGF/I/QzN0z+Yi0HFO/PAnwGTCWJPd0tCg+
         W3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B3Y8K28Bk2cHjlmHVhWfZJK+jWG4xRdwr+oMbl8ZdQQ=;
        b=crRHDrRo36SN8wk93bGr0AhNM+xBNhUv6/vM4gjkMjpCcmO8iVq674mGUv8NnJly94
         fkw++nsnaCc9Bw571ViWuUPZyGxLdYRHlJIgsPmwO55t3acCov/ZM+IyCR6Tr2SO85k0
         LwweiVpfg97wVcAqFjZePjX+L7BX8ta0JQokrpEY1qIu1TBwWC2+RDvy4JuKpURCLcD7
         CvI9gui85sxoFShfJXeK4WxolBHp/9/RVJOjCZb8gRwpIv1+eprH7cIfR4YUrr+o72ot
         qfyn38XiE3VRxKF2Gpjt7WuoruumVyyC3BL5aVNcTHlORHcTU9D0aVJyipUgz/BnFy3P
         6DZg==
X-Gm-Message-State: AOAM531SA0TParVEA1ervmj7vxKaQxxAibinIBQj+uUfR9R6eGHsUkh2
        bhdYK35Bc+BjB8ejS+2Gkw+QsqUr9epMoA==
X-Google-Smtp-Source: ABdhPJwU1anXLzy6H+btpzTEu794ld+JfQRkxTVrzAGnOd/JZR3sm23CK0G+/XF2mJKzf2zGvPd3Iw==
X-Received: by 2002:a17:90b:3706:: with SMTP id mg6mr2182256pjb.90.1621300833737;
        Mon, 17 May 2021 18:20:33 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id u10sm11534497pfl.123.2021.05.17.18.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 18:20:33 -0700 (PDT)
Subject: Re: [PATCH] ext4: get discard out of jbd2 commit kthread
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
 <YKLXev4cjeRuGRqd@mit.edu>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <c7c00420-ed5c-0f5d-23c1-1c64b1800778@gmail.com>
Date:   Tue, 18 May 2021 09:19:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKLXev4cjeRuGRqd@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/5/18 4:52 AM, Theodore Y. Ts'o wrote:
> On Mon, May 17, 2021 at 11:57:09AM +0800, Wang Jianchao wrote:
>> Right now, discard is issued and waited to be completed in jbd2
>> commit kthread context after the logs are committed. When large
>> amount of files are deleted and discard is flooding, jbd2 commit
>> kthread can be blocked for long time. Then all of the metadata
>> operations can be blocked to wait the log space.
>>
>> One case is the page fault path with read mm->mmap_sem held, which
>> wants to update the file time but has to wait for the log space.
>> When other threads in the task wants to do mmap, then write mmap_sem
>> is blocked. Finally all of the following read mmap_sem requirements
>> are blocked, even the ps command which need to read the /proc/pid/
>> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
>> used to be blocked for 5 mins.
>>
>> This patch moves the discard out of jbd2 kthread context and do it
>> in kworker. And drain the kwork when cannot get space in mb buddy.
>> This is done out of jbd2 handle and won't block the commit process.
>> After that, we could use blk-wbt or other method to throttle the
>> discard and needn't to worry it block the jbd2 commit kthread any
>> more.
> 
> Wouldn't be much simpler to do something like this?
> 
> 		if (discard_bio) {
> -			submit_bio_wait(discard_bio);
> -			bio_put(discard_bio);
> +			submit_bio(discard_bio);
> 		}
> 
> 
> We're throwing away the return value from submit_bio_wait(), so
> there's no real need to wait for I/O to complete so we can fetch the
> I/O status.
> 
> That way we don't need to move all of this to a kworker context.

The submit_bio also needs to be out of jbd2 commit kthread as it may be
blocked due to blk-wbt or no enough request tag. ;)

Best Regards
Jianchao


> 
>      	    	       	       	   - Ted
> 
