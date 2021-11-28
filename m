Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A84606FD
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Nov 2021 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357972AbhK1Oz5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Nov 2021 09:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353477AbhK1Ox5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Nov 2021 09:53:57 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474DCC061746
        for <linux-ext4@vger.kernel.org>; Sun, 28 Nov 2021 06:50:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id w22so17820630ioa.1
        for <linux-ext4@vger.kernel.org>; Sun, 28 Nov 2021 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Txps8BV5KXXLE5Z8Dj4HtwZJIjHx8LsUHB2vb03furM=;
        b=RiTzv1xSgdvwqnqWp1SXVPrTRBpb6DAg2TnKPceezDniBL2S1NlsonFMXDz+45YHO1
         BFIMKqdBc445J8nJfMwWjBLKzbxvlekQBNG+/tLTBdUs9dOXF8l06CLOeehBcYDkSjFg
         lPNfFvxzd7Uhkq6B67VDg0SJSb3gZ94qDT+srk+nHBI8z5oGgs5f+Th6ZGOCdv9DUqCQ
         E3p2Fu8+sIqRXqw/bSOGqX7vi4/JKRGEw1kLcDvUbcVRoBLDvU5us2mBfCOHTa6Q+L6F
         tF9CY4KfFjx5LR/uTlm1vqtnZTSmuzl40A2UTPxF9XmouhSBeqVajze+KY76eljOjjCI
         mTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Txps8BV5KXXLE5Z8Dj4HtwZJIjHx8LsUHB2vb03furM=;
        b=nCk2jy1oWV+98AS+Ug5IjOYJS/WWZ4QDZDYWTI2UPyskOud5a+KspOpgTJs5dZX+tI
         1fwcvHP/B72Ofv/KTyGhXEih0DPbZ15ks4sjNIRRExhqw/U0nydel0IyOMM+mTmP6QCk
         583ZCrBCMrlP/RtnlLY/VI0o9pelW4N/IWYcyPaiaUuGqr0QlukjJd9uoSeO0SWiUCNW
         zDSWJedrzqixX8FhueC0D8nzUIpi7yecRebEWV9JPMZli/ADVvQ1zs8uiwIjVPI+vWC/
         a1IFk1gpvk5DcIeLucC3rvsvE1BaUgBDDzz+hx/qjsJBnboOk6HP9NrH2cUAV++JwLfy
         9rRQ==
X-Gm-Message-State: AOAM532tkHF3eyr253RNCZs+NlqCnDH/a5WVSR2KaEVRiGBDp8TNrqPs
        cKkjuIGKIHn0snsMdyNgBxntRcU3WEBLJwbc
X-Google-Smtp-Source: ABdhPJyLSvA0K16M7WTbsvdBpW4pLzudrSbFlFJc6kW9I+0NBLSERL16NBvWVxYaC6PS327/5+okjw==
X-Received: by 2002:a02:9609:: with SMTP id c9mr62298537jai.118.1638111040447;
        Sun, 28 Nov 2021 06:50:40 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s9sm6817343iow.48.2021.11.28.06.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 06:50:39 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
 <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
 <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
 <a4d728c2-703d-66be-bffd-3bfde0fddf41@kernel.dk>
 <b549b4ce-4156-eaab-a146-1fa52f51b642@panix.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <838c86fa-bb3d-6794-64fd-35b81c62bbb6@kernel.dk>
Date:   Sun, 28 Nov 2021 07:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b549b4ce-4156-eaab-a146-1fa52f51b642@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/27/21 5:11 PM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>>>> That said, I'm pretty confident in the fix,
> 
> Moot point kinda, as I see the fix in Linus' master, but yeah, it's
> working here.

Thanks for testing! I had a high level of confidence in that fix, and
wanted to flush it out before -rc3. But testing is always appreciated,
and thanks for the initial report as well.

-- 
Jens Axboe

