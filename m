Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB390699980
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBPQLO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 11:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBPQLN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 11:11:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7DE4CCAC
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 08:10:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kk7-20020a17090b4a0700b00234463de251so6308879pjb.3
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEswlEoANnCYJZ4CQNeZ3b7/tLKIkxyJxKO8y46Blss=;
        b=t77I3zq/lsWwoijj5yg3nMALMbETP32lnruynx3xKn2jaAc0/sE0sOtaJVdYlBCrYJ
         b8bWpF5nwzQfr7t+XI4tCDItPZm0rd9LduV1mzvHNnB1grdCCgSodJW0AJn+xrfMg1U2
         ZrkpeZ2QK56qhNKA5WtC+7vb7EKkPUXUnpnJ7MkdvB8jS+lkivH4VU/2yudTOdaItpQQ
         GVh7gy5dKbQ6UcybdbjMuxCnIPfmzyfJjO6FNLiiMk5qKDWfnJG8JhHtoSrnzeoFOAYO
         U+58Vjz6eAADFgqEvTz1gMqHFPjsDjL5QuuXhnno2ndpkfD5oEa6qkGjcVJwShgX/C3W
         gWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GEswlEoANnCYJZ4CQNeZ3b7/tLKIkxyJxKO8y46Blss=;
        b=WVDrTt6C8YYzfLINBavbnk/R4yMsRvNflfFj1aX3FXt3F+fZudB5Unzh/eMzK8zQjJ
         yEpbEhM0bBnYDn/xtC7y3WNYRrN2xz1nvYMnTQt+zQ9H/tmrDFEvb4VnV9FX8IEZLkn2
         Zj986/LJyDoqRAB6FE5xAqMsKx/6pTZbsZoIKviyPX+Vx+gqnxh02pb5lNV/g4XcDrPC
         YbhgjWbkteaKJL/MF0D7UMjUWoQi36jIVsYLlRMN/pa2Vm3c6SKSrb4RrKEL8IsnrcHI
         GpjdoMZU1mlqIywakLj0wW4ftA8hYLxCobt6axDd5OPN4HS+RSlx/AgIcPH0/5UJr0WP
         ZfrA==
X-Gm-Message-State: AO0yUKUOYlark5+A2B6h2zWl6+jGrSAjTopa0rN4kRVsRChHiFqftkkN
        vvr1Dyte89BhvOnojwRL7DZ6Zg==
X-Google-Smtp-Source: AK7set/U5E34SKCpowgonDjLfLHp7GBOTSycnR5f8A4foP5WZo/kPZQngijv8VMRHs8I56nZRsFnGA==
X-Received: by 2002:a17:903:d1:b0:19a:996c:5c2b with SMTP id x17-20020a17090300d100b0019a996c5c2bmr4671596plc.39.1676563847574;
        Thu, 16 Feb 2023 08:10:47 -0800 (PST)
Received: from [10.255.2.172] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902c38100b001993411d66bsm1490186plg.272.2023.02.16.08.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 08:10:47 -0800 (PST)
Message-ID: <bc8f48ce-7280-c70a-db7d-825923f08b48@bytedance.com>
Date:   Fri, 17 Feb 2023 00:10:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v2] ext4: make dioread_nolock consistent in
 each mapping round
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <87fsb5lpn1.fsf@doe.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <87fsb5lpn1.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2023/2/16 下午9:13, Ritesh Harjani (IBM) 写道:
> Jinke Han <hanjinke.666@bytedance.com> writes:
> 
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> When disable and enable dioread_nolock by remount, we may see
>> dioread_lock in ext4_do_writepages while see dioread_nolock in
>> mpage_map_one_extent. This inconsistency may triger the warning
>> in ext4_add_complete_io when the io_end->handle is NULL. Although
>> this warning is harmless in most cases, there is still a risk of
>> insufficient log reservation in conversion of unwritten extents.
>>
> 
> Sorry, I haven't completely gone through the patch yet. But this idea of
> caching the initial value of mount parameter and passing it do different
> functions while an I/O request completes, is not looking right to me.
> 
> If that's the case shouldn't we disallow this mount option to change
> until all the outstanding I/O's are done or complete?
> Then we need not cache the value of dioread_nolock at the start of
> writepages and continue to pass it down in case it it changes.
> 
> Just my initial thoughts.
> 
> -ritesh
> 

Fair enough, thanks.

