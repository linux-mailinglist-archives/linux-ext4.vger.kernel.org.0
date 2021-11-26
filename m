Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28E045F2D6
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Nov 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhKZR1z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Nov 2021 12:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhKZRZy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Nov 2021 12:25:54 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F5C061A28
        for <linux-ext4@vger.kernel.org>; Fri, 26 Nov 2021 08:53:17 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 15so550147ilq.2
        for <linux-ext4@vger.kernel.org>; Fri, 26 Nov 2021 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDwlRdpjTzYPwAhSnbeW857QP4iA06QyXUK+72xmWO0=;
        b=Yl7aflVYIKA8NwiU6HKYQgGI1PRZXflwMsUz1SFWlR4vTCFpRc/dIgxUm6Qxec4nSq
         M0ZAPi9cAnro/JRUdWX3Qn04cLaDsYZgXd46rm9dayPq2OaW3FrWJp07ldoXJH6zhRc1
         9SOecwWh5/D7lKrUqy74GUSElLBhVBekoiIfQLHMTrNcERUhkEWrgdDDefSeQm1cirua
         4BX8ztxr/TiTPi55f95UrWEiNVeGK/iLyzW1Wfpzf6syYSVCy/S6L7GhWxDfiL3smE8p
         U6XkJfsj+S+QvNfjhk1IieB7CyQethVUJYIGmmK27HW7FxkpK0vg790ju5jMqaVYKrjL
         +qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDwlRdpjTzYPwAhSnbeW857QP4iA06QyXUK+72xmWO0=;
        b=X2/i+IZgJk5bddONkO9qF3KYH92LLcr3tblBq4RCOLw2dVhmzxMhGB/Zs+deuOy6CP
         t7W7Pz1FAU3cmiI8wNKBvDYotC9osnFvuJICyV1/tuYU54PiRkWZWSM+fZ8+cKI8eMBi
         moQm7iRzcibpSgrIUuJ4jTWq/HJPpwMjELUUeBLZsT/8WZSr/FcDqaxR9M1nto0vKumi
         DnOGQUAIp6hAer1Z0FOf4wdbvRVukGG1Wv95BgArIC7b3/GZlb0tNNt6zAMSIhhw7PYS
         COCkVlAsCN8BVOXOctIbaL8ESpjZJvVvy8IiOBiDxwQvH2eBoAv6XiEptbBeDReKfKnX
         ppUA==
X-Gm-Message-State: AOAM5305i8P9tpCKrbUpCMuHTiBJjFnRsXwm5U73F9KtYYZ9fBLc1Zw7
        der0OFJCZNlDhduTF4u/OsNTjfVdD0avcre1
X-Google-Smtp-Source: ABdhPJzsgw04zJvm5GtiLCxl/tnSLY7FlbjoF4d0/XBEG7n5Y38/jin0OpXq6CLemyKpFpFrUDjbnw==
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr30636080ili.14.1637945596380;
        Fri, 26 Nov 2021 08:53:16 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t12sm3192833ilp.8.2021.11.26.08.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 08:53:16 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
From:   Jens Axboe <axboe@kernel.dk>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
Message-ID: <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
Date:   Fri, 26 Nov 2021 09:53:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/25/21 2:07 PM, Jens Axboe wrote:
> On 11/25/21 2:05 PM, Kenneth R. Crudup wrote:
>>
>> On Tue, 23 Nov 2021, Jens Axboe wrote:
>>
>>> It looks like some missed accounting. You can just disable wbt for now, would
>>> be a useful data point to see if that fixes it. Just do:
>>
>>> echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec
>>
>>> and that will disable writeback throttling on that device.
>>
>> It's been about 48 hours and haven't seen the issue since doing this.
> 
> Great, thanks for verifying. From your report 5.16-rc2 has the issue, is
> 5.15 fine?

Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
it for you?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8799fa73ef34..8874a63ae952 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -860,13 +860,14 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
 
+		rq_qos_done(rq->q, rq);
+
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 		if (!refcount_dec_and_test(&rq->ref))
 			continue;
 
 		blk_crypto_free_request(rq);
 		blk_pm_mark_last_busy(rq);
-		rq_qos_done(rq->q, rq);
 
 		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
 			if (cur_hctx)

-- 
Jens Axboe

