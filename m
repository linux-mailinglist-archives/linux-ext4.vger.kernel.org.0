Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A79248DBE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRSMz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSMy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 14:12:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E1C061389
        for <linux-ext4@vger.kernel.org>; Tue, 18 Aug 2020 11:12:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y10so8028165plr.11
        for <linux-ext4@vger.kernel.org>; Tue, 18 Aug 2020 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B6ZJxFf2Z6gDyFzWzMEu+MxYBenSPrvaZMkOZhCrYpk=;
        b=cWzzse+nzZalDgVtFalfBv5bPc3YtGZGFGJaWtJ3muGOvmJtvkQLCkSZFAc6JuSH71
         hjGDE20kS2S4cKvJWOo/DeQT3FFkaKSKXmSDLLyjPWsx4a2CZQGxGpmhxVWi/QCL6T6A
         ZtkmdiXDq8K3c5dHUpcaBPO9hjRl/4o0+bT55E9sLB8IHOrZN3hrT0ee3fX6VxaviUCF
         UOlHpGLLyp/ULrC9A4dayNcqNhVxRMs6OypRd2yCSKoUKQC/Yj2xw6TYDhtetahAXEBw
         ic6I+wlaeKoOFDOtBZqT7Fv+IbdyT+Lf/fmz4Jj+0Aq4+K7SkvDwPlHqG3yQdhOv3qgN
         bAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B6ZJxFf2Z6gDyFzWzMEu+MxYBenSPrvaZMkOZhCrYpk=;
        b=UTS/lluZ2HEl63DtlRyWDB6vTOEPnh7sa9b0G8U4GiaVDyuaghWm5gwo5BwTrbNhMB
         oPottRmeVwSfznHoO0raUU6jO2/0HOgfia1leuGz5G8VrSapXFSMi5to1bQVnvf6GJwq
         YBGsjQiiSAmU5z+lpuH+FHO6CBJSj7+X3TKFKVzT64OPFTl3lgn1EeEK1tFZdODEFApi
         z4bPOuvZqMp/CJdVjafz5Bw4ug3M+oqJAyNf5YUhp1/n0KX/T2n8sskwhJ1QGR5jXMqy
         Jcl4Oab8Hhv9pqP1bjAxF4iJ9ISm1CsRCSCieUTqC39CLvBesOrqb50oYmmso0bc5Mdg
         t3Fg==
X-Gm-Message-State: AOAM531YuX0LMTsJ6PyAidPjp8gfrrEPcqcLK5vBuboaclH9P9Y+gHxw
        epVKANI7LnRSTvAV88f1bf7uN0Y5SI/XO6j0
X-Google-Smtp-Source: ABdhPJz6UYz5gqOxPOPAZaRpOrNzyaFiiZ4VQvMnWaHvJSDDyH1OWWmADBZG13GncGmKNIV/Oq8PcQ==
X-Received: by 2002:a17:90a:6843:: with SMTP id e3mr931799pjm.89.1597774373413;
        Tue, 18 Aug 2020 11:12:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id r25sm21430047pgv.88.2020.08.18.11.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 11:12:52 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
Date:   Tue, 18 Aug 2020 11:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818181117.GA34125@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/18/20 11:11 AM, Theodore Y. Ts'o wrote:
> On Mon, Aug 03, 2020 at 05:02:11PM -0600, Jens Axboe wrote:
>> ext4 uses generic_file_read_iter(), which already supports this.
>>
>> Cc: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Resending this one, as I've been carrying it privately since May. The
>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>> please consider this one for 5.9. Thanks!
> 
> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
> missing something?  It's on my queue to send to Linus once I get my
> (late) ext4 primary pull request for 5.9.

Right, it went in at the start of the merge window for 5.9. Thanks Ted!

-- 
Jens Axboe

