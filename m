Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FF1D6DDF
	for <lists+linux-ext4@lfdr.de>; Mon, 18 May 2020 00:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgEQWjW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 May 2020 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgEQWjW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 May 2020 18:39:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1953EC061A0C
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 15:39:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j5so9689188wrq.2
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2oqUKdmKM1Rh+Xqw9V9fnxEYGqf2DpkHn6dTih/vC4=;
        b=FwIMygt/2OPy330TZKo4omojK8w4ea8lEleV2Xo2I4I0UvZSfVKf9CJ/PNwqnN9OmQ
         35YnnM2wHTrRdjDl8Frf5CchhbDBaZoBTgnOGToVHh3hB6hC+iTrsiD/C7E5NdN/v6n4
         wsKQBdBp6KF+RRJavzZmL7rLKqwxnHm8GzY3X2C2ak/ERZH7GnhZZBgkjkAjT17+MfxN
         wlYhb7bE3DKHRUscAXl4iG1uAzXH2LEQRmo25C7w4i+dy0LK674p46JVKdpi9loFwTy0
         qdou+llZ88en2WU1zr5JEvWRyD0S7WWMLUe0A8uuCL3h+JBZm1eKvcSi13cqG14u5Xoi
         uzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2oqUKdmKM1Rh+Xqw9V9fnxEYGqf2DpkHn6dTih/vC4=;
        b=doqaYpYsU8cuClljrr/b17A27wNZWOku3KGNMtzGFm4q35awR7IiJT8/u8O1F5mSWD
         ZQ9I3wz6Df9rjKN0aob8dYwWBRLyHUadP9JQdDwm0OFl+m8LtaAxOqbX3vai8uzKt35j
         +mNUCNmios1zLe4teISOLyieO1b28QdQ9N3jOfWjKQo3yEtB7qb/BZAGr7ncpEGPx+se
         +WqQV5+y0Lyn/PrxhUnI3OoosvgQ63qOqyfBBxQIZPad0IPiGyxb7e9+fraiIo4sxkhD
         DJcDyU2ugsCv37WcQegI3OpHFDc7PeJiD3q/TpPR5jKrC6BnUWDe2uD0I1OR+6559Vr2
         25Mw==
X-Gm-Message-State: AOAM531qP2vpv1AIj4wGa7WMdcUPx3LuO7/3LooqpD8VCEdIgln29+H0
        2qfLhjmOcz6LNvMke/0OBDHWRQ==
X-Google-Smtp-Source: ABdhPJyLcjGYv8aRoJP63KExJJD6nDGymGKdlERZkNEjnYyVpUrBsDBPDmpavapspsTzhTiIgSb3Eg==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr16051172wrq.218.1589755160666;
        Sun, 17 May 2020 15:39:20 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id q74sm14652301wme.14.2020.05.17.15.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 15:39:19 -0700 (PDT)
From:   Jonny Grant <jg@jguk.org>
Subject: Re: [PATCH] /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
 <3DF89355-488D-47F5-857B-3B75D4E89AD3@dilger.ca>
Message-ID: <d7f22961-2fb2-d69a-28cc-073b735c6907@jguk.org>
Date:   Sun, 17 May 2020 23:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3DF89355-488D-47F5-857B-3B75D4E89AD3@dilger.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/05/2020 21:19, Andreas Dilger wrote:
> On May 8, 2020, at 2:36 PM, Jonny Grant <jg@jguk.org> wrote:
>>
>> Please find attached patch for review.
>>
>> 2020-05-08  Jonny Grant  <jg@jguk.org>
>>
>> 	tests: comment ext4_dir_entry_2 file_type member
>>
>> Cheers, Jonny
>> <ext4_ext4_dir_entry_2.patch>
> 
> Hi Jonny,
> thanks for your patch.  The patch itself looks reasonable, but can
> you please submit it as inline text next time.  To avoid issues with
> whitespace formatting, you can use "git send-email" directly from
> the command-line after making a commit with this change in it.
> 
> Also, the subject line of the patch should just have "ext4:" as the
> subsystem, you don't need the whole pathname for the file, like:
> 
>      ext4: add comment for ext4_dir_entry_2 file_type member
> 
> Finally, you should add a line:
> 
>      Signed-off-by: Jonny Grant <jg@jguk.org>
> 
> to indicate that you wrote the patch and you are OK with others using it.
> 
> See Documentation/process/submitting-patches.rst for full details.
> 
> Cheers, Andreas


Many thanks for your reply Andreas. I will follow your that patch guide, 
thank you for the link.

Could I check, did you submit, or shall I submit via git send-email ?


Many thanks
Jonny
