Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2734C18FDB9
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Mar 2020 20:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCWTck (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Mar 2020 15:32:40 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33348 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCWTci (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Mar 2020 15:32:38 -0400
Received: by mail-pl1-f169.google.com with SMTP id g18so6358244plq.0
        for <linux-ext4@vger.kernel.org>; Mon, 23 Mar 2020 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hi3EuG/Ev6bXmXxwMF/V1jsHh5EuhVttPWLzFdZA0IQ=;
        b=vLeGSpfsq1jVhwKe7kGlbB3RuNa6YAmDElpxlsUF/kzrtyDfdHxqgJmZhPcbrjBWan
         3ke0mbmoeY48ITd+sWsO2NK8NTXadJ9C2p1cRWDCrTJbWuix/ztHPjE0ypAwPWHqei4j
         bUDV8mfhgCuj/z+owEpyzoSHJ3BTyZw1QIPeJhf4uH6j6z4CH03XVYXZ6Tgc9+oVTnrX
         Te/k7QqG0OWh1N8xOM73p9dGJAqP1o6IXkqwDd09VrtfkgLUtpn9588R95kvdAwEpmkt
         KNzPv5G58gPwwTWCsdJxucJ6dyjkCBCs6inICd5eyY6UV6sRPx5QHu+z+fneH0XFQDzj
         t3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hi3EuG/Ev6bXmXxwMF/V1jsHh5EuhVttPWLzFdZA0IQ=;
        b=ibYaLeeE3g4rhuFk0/8qdShJ2JxRzFemzXdBFnfpSZ0EagIgXDeMTBRkZUlJvbNH7y
         rrb7F0hAOjv1AZa1eEN4WKNV/UArKefYs+TuC2exUKdc3euLJSPPm/lU9Q7TaxuZvIX8
         D2TJa+EW/jOFIJOld0PpfWcEwTqq9+lC2RK/S+a6OXJOt/s4Z+llEEodg1oattEzha8E
         V77ZU0qPhoYsBbeDYDEyuUI7YOqSaCwXRHg/Q/0g95iv0zO9mrfqJRhg03FkRcJ3kmde
         ExF96hrPYYocKzgQFspAubbAbDzCb9LTO9/UIGTuTvFXEnUNXGLm5tGBsUKyIfB73wkH
         9CaQ==
X-Gm-Message-State: ANhLgQ04Mv1wpEQVVfgDj+PYTmTCTb5gvZ7qKehzZtXK6GEYSLOrUXUA
        AJscuWbP+HQzBv8tmWllrGFTmA==
X-Google-Smtp-Source: ADFU+vtkqgNro5u5VRLne/XHXMrhbxd9k9mxWS33Rv36JKSAlNgx3sQ2qJJ63NNjZmKfOTLKstadBg==
X-Received: by 2002:a17:90a:9f96:: with SMTP id o22mr1013390pjp.88.1584991956664;
        Mon, 23 Mar 2020 12:32:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r17sm2127140pgl.80.2020.03.23.12.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:32:35 -0700 (PDT)
Subject: Re: cleanup the partitioning code
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
References: <20200312151939.645254-1-hch@lst.de>
 <20200323165234.GA29925@lst.de>
 <7b7eb188-441a-b503-d526-f5bc029891fc@kernel.dk>
Message-ID: <5144a76e-1d99-c5a0-3e16-e031e12d93ec@kernel.dk>
Date:   Mon, 23 Mar 2020 13:32:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7b7eb188-441a-b503-d526-f5bc029891fc@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/23/20 10:55 AM, Jens Axboe wrote:
> On 3/23/20 10:52 AM, Christoph Hellwig wrote:
>> ping?
>>
>> On Thu, Mar 12, 2020 at 04:19:18PM +0100, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> this series cleans up the partitioning code.
>> ---end quoted text---
> 
> I did take a look, looks fine to me. Doesn't apply to the 5.7/block
> branch though, I'll take a look in a bit, probably an easy reject.

OK, so it also assumes that the PAGE_SHIFT -> PAGE_SECTORS_SHIFT patch
is in, which I dropped.

Can you resend?


-- 
Jens Axboe

