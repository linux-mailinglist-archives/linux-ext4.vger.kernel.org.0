Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DA73792B8
	for <lists+linux-ext4@lfdr.de>; Mon, 10 May 2021 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhEJPbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 May 2021 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhEJPaH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 May 2021 11:30:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566CC0611ED
        for <linux-ext4@vger.kernel.org>; Mon, 10 May 2021 08:22:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so10532408pjb.2
        for <linux-ext4@vger.kernel.org>; Mon, 10 May 2021 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4kJjyEdKJSSJcbIYRx1gsC3Tm92r+WAm3xChSESK0DY=;
        b=EwFGMVT/RquH9XWAorVf5LJnDWWm9i0AMvJhQVX23jF1tuP41qys8SSBNMRSkuRGsN
         eoF8x6/4p37PPO/NzY0xpAo+SH7vu4mntn6WTH6x3DAl0uOyDB8PHsQBRfZUmbvWO9ld
         gBK/MsdW3EZJvIMXj7GM3yRMh5UcuU3nVEtfP6ZzgS6tRtRdUeQiiuAS+ZuztRJnpgn4
         i835A6slNz7wc1vEL2SyHRx0lZpE3oqq2iUE76rDetn27Jd/vAASw7cU8jlVj7wRVboN
         o6Zym2GlM+pmPzRp5XY29VnPI30RoV6YfVO08SEGksyxD/nLQocesxDBk2vApsIB7FMG
         tsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4kJjyEdKJSSJcbIYRx1gsC3Tm92r+WAm3xChSESK0DY=;
        b=s4DAG/MnVySAwiK9kWKel8yGGSWnuPksix5tsOxT56/h5SDZidQ0kZYtFIDi7oShzG
         IYX+9C3Y7v3HcHKm4Nu6K3J/2wD0z+plUumrKFSO8S9gYsQqnFIAj3jj07RbvN/aDTPJ
         A5shO33gZKVw6StNnSINWwIBu4iLPf827Og1fE/r1NOhZSfQrmpKaAR8wwLaf65p112g
         YC+BbqiOFl44fB7AEMoyXseXQATAHxnkOYeXbzDDKg3EXub+1CBSOKASSrCGlBDnrk4S
         PtOW1sSpooiNP5oYPOKfaUqJpBhit1nlkRrC0VEx4pl78dybEp4IElfWcDoMum8qQ2A7
         fryw==
X-Gm-Message-State: AOAM531F1s01Lqm0UaCoaS4YxvsB4GB83nUrf9Huiop/Q6+vhIZcUAWt
        HkOFtawjY0zo39moducGU20X/w==
X-Google-Smtp-Source: ABdhPJxFDOJREynsD+t0qDXkJ8N0sfYWJnXjlJPZOiCIWUhfU/8Aux4zDCsk0nv0vqTiYdBS3VV2ZA==
X-Received: by 2002:a17:902:c612:b029:ef:2ad3:8998 with SMTP id r18-20020a170902c612b02900ef2ad38998mr6128708plr.74.1620660119598;
        Mon, 10 May 2021 08:21:59 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 66sm11274986pfg.181.2021.05.10.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 08:21:59 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] block_dump: remove block dump
To:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        jack@suse.cz
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, hch@infradead.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <498fe074-709a-48d6-dfae-bb50ff69c290@kernel.dk>
Date:   Mon, 10 May 2021 09:21:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210313030146.2882027-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/12/21 8:01 PM, zhangyi (F) wrote:
> Hi,
> 
> block_dump is an old debugging interface and can be replaced by
> tracepoints, and we also found a deadlock issue relate to it[1]. As Jan
> suggested, this patch set delete the whole block_dump feature, we can
> use tracepoints to get the similar information. If someone still using
> this feature cannot switch to use tracepoints or any other suggestions,
> please let us know.

Applied for 5.14, thanks.

-- 
Jens Axboe

