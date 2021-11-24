Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1179345B025
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 00:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbhKWXbE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 18:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhKWXbB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 18:31:01 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7DC0613ED
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 15:27:36 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id k21so803835ioh.4
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 15:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=;
        b=280Bz0k0OYWwkdgLxOgZ/yknvlsY35nBXX/FIA0GJh2OzyEIkxt5dpnuKGk0CYLcq5
         TCs4l/IGtMPPRvIkfh7gH/pGmvzlVs6NvyJ6w0hdoNhSV+OrMcIQ3v/8q1lQ5kw8U6Jo
         YJdu23zpP/HXsN9JN5PLPhkmOp7O5i/Dl5tvuU2dAtz3FXIdr84ljg79VUvjuJ9xMmSB
         G3mOJRwlnaX+CHGjYsLwiXdPsGNQDhV56Wx0xvgeY537pwm+O7xdFZ5lNODLLwNyTH6s
         54nHv7m6oEMU/8qeYijxiOpI/ELZH/jkBgHWIgtbAND6MJO1j/yuAGZFGzgb+3joCKwm
         Z4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=;
        b=02xH8t8TdqRSN4cWg/WV81P6ZqM/g2xUp7BRH727iTQD+6RyKirC0FsSv+p4w9QpMx
         i0v+T5k4r2XWQIAapZTgd9VZdb7s0IDuhZ53pAxhhjAVKDRxo58kFSgy8R6CKCgnzc32
         zIp8OKIjQgsUfxiXAJpC1Qab/Zmo9Vh6vpbWC067drOAcRHfaxCZ/LEkD/dOkzOK8Sxp
         UO3AcFvOqfj7VkHUV4KGADoNFCLNRLgDGtrYwFbhB273O2J0pancBEcWbtSW3YOW93O8
         YUsoKPRi/Bp1tFJBVrO2oy28LHAivQ2/M+gtKFADNzr7sO4ugF+prgcR3KVaQvDcB8oM
         Uoqw==
X-Gm-Message-State: AOAM532ZL8h0Gs3hOxmyUsAxTC4Rh4x3DBlxIjwL74Zy13CW7ZHoWai5
        X/FHWkLAHpTqC8yvJxVxy9BWHQ==
X-Google-Smtp-Source: ABdhPJwCLJjwK3aKbSmDRGjmTjIcEDCwjg5vNWeo2TaKak1MQec8VtkkIaTJqJiEgLX5uA6pCl1ncA==
X-Received: by 2002:a05:6602:1604:: with SMTP id x4mr10349425iow.84.1637710055352;
        Tue, 23 Nov 2021 15:27:35 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s15sm9869112ilu.16.2021.11.23.15.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 15:27:34 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
Date:   Tue, 23 Nov 2021 16:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/23/21 2:05 PM, Kenneth R. Crudup wrote:
> 
> (Please forgive the SPAMmy nature of the To: list; I'm not exactly sure whose
> subsystem this issue belongs to, so please trim as appropriate).
> 
> I've got a Kioxia NVMe SSD on my Dell XPS-7390 2-in-1 running an i7-1065G7 CPU
> with 32GB RAM.  If you need more info (and I suspect so), please let me know.
> 
> I'm sorry I don't have a better description of the problem, but I run Linus'
> master branch (and sometimes I weed out problems like this). I'm current as of
> his commit 1360572566 (the 5.16-rc2 tag).
> 
> For about two weeks now every now and then my block/NVMe/...? subsystem comes to
> a total halt on writes, and I get a system that can no longer issue writes
> (reads/pageins still seem to work) until I reboot. SysRq-S/U/B still leaves a
> dirty ext4 filesystem requring recovery on reboot.
> 
> It happens at random- twice today as a matter of fact- and there doesn't seem to
> be any particular action that causes it:

It looks like some missed accounting. You can just disable wbt for now, would
be a useful data point to see if that fixes it. Just do:

echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec

and that will disable writeback throttling on that device.

I'll take a look at this, but most likely not until start next week...

-- 
Jens Axboe

