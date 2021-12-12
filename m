Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B46471A3A
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Dec 2021 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhLLM5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Dec 2021 07:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLLM5H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Dec 2021 07:57:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD1C061714;
        Sun, 12 Dec 2021 04:57:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so12317873wme.0;
        Sun, 12 Dec 2021 04:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=caHoaEy2aONMpfGjBtSDMo4jFNKxlGFW4Ou5yTv9LW0=;
        b=HmbBJzZfdUqGsnmLrZpoURuBsBiSGjV1tXowmldCJxnhvs/DjYqS1XTDFbuWHA3GfS
         kyPBKlxToGGFtwZ4AS2OPz9VF55Vk24FLgP6lrp3bMhpFrkj5CsxYGtbW7da8dXKtrFC
         8aKYZvmmC/UnG2ybRM8/m1NYPxEjH7lfo1SrKa3+UcHx/msPx+XAODzrZXxOO/CIYq1L
         CZ5RrVeFajrmhG27nT8CKdR2PBQHJyyGdGNHHkVaFjZLDjqyXiKTyePRtw2EX/IxEvuM
         qPn+yTM29Tlq+L84oq2K7a8rGseLng3LmtILa4/Gt95/sEp3psED/2gae+cmc1iMXmi7
         VKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=caHoaEy2aONMpfGjBtSDMo4jFNKxlGFW4Ou5yTv9LW0=;
        b=yDE2AxgXd0ypzL+6xu/lIM9gNGSvN7ITverms0vDvDhZ+Z964/sAAh+Wq5NSYAR2Tu
         CilMm6dwOYCEdMVIXHTaCefe35dFZ8re787AUx9rpq3jw92mj/hm5SR7MPjs/Bf8bVKc
         AzZZlT74zwRcdei8to+PPDgiLBIWRmNHVSeTgL8AP/ExDV6kzxJV9zDicGY01VCCw8nY
         7TNwFhf9WiIQeG9g4uAMBssasEhd6TULHfVlSEHrTiiJ+buO2SQWkvSfRC2reYME7XaC
         5GCnsbnIFx4DcVfndQUAQZa7Yf8md5DdDikas+366UXybEFmka5gHbvnZJxcPhWOWPBt
         X+kQ==
X-Gm-Message-State: AOAM5310MXdYyV8X6uyAa6MnbfHvqyHIjLgUxBQ6X5zs/tjDz6cH/NnS
        zUOL5VFOUQhjS+FidXTRm3kadp1L7DgtdA==
X-Google-Smtp-Source: ABdhPJzq54FOzUTnAMsHfZoO3dHM+weCQCBhNPy7/RgL54n9AWSHDVP2Ob7VROq7SgUcMoK/R/RjmQ==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr29694895wmi.131.1639313825173;
        Sun, 12 Dec 2021 04:57:05 -0800 (PST)
Received: from [10.74.0.6] ([85.203.46.181])
        by smtp.gmail.com with ESMTPSA id y6sm8309913wrh.18.2021.12.12.04.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 04:57:04 -0800 (PST)
Subject: Re: [BUG] fs: ext4: possible ABBA deadlock in
 ext4_inline_data_truncate() and ext4_punch_hole()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <03a92134-ce74-f586-59a0-baed436b275a@gmail.com>
 <YbI2IEzCVo+A6GTi@mit.edu> <c9f25d5a-0963-5b2d-b1f0-e7c7454f7153@gmail.com>
 <YbOWz7tvA6DuXcrw@mit.edu>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <65ca0a4b-c8f1-860e-8890-4852eb354129@gmail.com>
Date:   Sun, 12 Dec 2021 20:56:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YbOWz7tvA6DuXcrw@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/12/11 2:05, Theodore Y. Ts'o wrote:
> On Fri, Dec 10, 2021 at 10:03:37AM +0800, Jia-Ju Bai wrote:
>> Thank you very much for the detailed explanation!
>> I will improve my static analysis tool for this point.
> I'm not sure it will be possible to programatically detect why the
> ABBA deadlock isn't possible without having the static analyzer having
> a semantic understanding how the code works (so it can understand that
> that code path which leads to the ABBA deadlock won't get executed).
>
> It may very well be that being able to understand why the ABBA
> deadlock can't happen in that case is equivalent to solving the
> halting problem.  But if you do come up with a clever way of improving
> your static analysis tool, I'll be excited to see it!

Hi Ted,

Thanks a lot for your advice!
According to your last message, ext4_punch_hole() and 
ext4_inline_data_truncate() both call ext4_has_inline_data() to check 
whether the inode has inline data.
In ext4_inline_data_truncate(), when ext4_has_inline_data() returns 
zero, the function returns.
In ext4_punch_hole(), when ext4_has_inline_data() returns zero, the 
function continues.
Thus, I think I can add such "concurrency" path conditions in my tool to 
filter out false positives, by assuming that the same function calls or 
data structure fields should return/store the same value in concurrency 
code paths without race conditions.

In fact, my tool can validate path conditions of each sequential code 
path. I can find ways to validate "concurrency" path conditions in my 
tool :)


Best wishes,
Jia-Ju Bai
