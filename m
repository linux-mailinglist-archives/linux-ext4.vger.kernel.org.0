Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD56BDF13
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 03:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCQCxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 22:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCQCxO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 22:53:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AF3D0A6
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 19:53:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cn6so3629014pjb.2
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 19:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679021589; x=1681613589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+eXRdP9Oh06pkJEQfCkDaUqO1qE+/y/kM5YhZ0CyF8=;
        b=66N2L5uy/PSyfUNkUPj5rCSWt0gJZJ31p4S2CMQEiXYLF146Zki/X97oGU+s9I2u6Y
         xCcS2stF6nU6bP3In4pcLJn10+1/WsT0s1vL4TcrkJyxXxpCofxhWCLOo+J6nk45kxyG
         7uy1/q1FsA79toXpAgRT3uwxANG544bdY44I21fDzaGoItRK9zOfjuwH6uro56aguizm
         9dBTuY+BXEjweMC/1q+F/DPd8J74gZrvf7SsgGhr5b/V9CZhBVawneYzTWhzm7MLa6a+
         NyF6sNC34a0/M/XCegFzKCWBlNvZgPTZ3KdPyfROtUh45kY/igru5nZcORVh6WFkUV0j
         Sv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679021589; x=1681613589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+eXRdP9Oh06pkJEQfCkDaUqO1qE+/y/kM5YhZ0CyF8=;
        b=Eq22KF44N8TbPvjkAFLWJouCS8e8NBqN8hU+Tpu91SZ+hv+J5jLhntH3+TRwGK0Gyf
         EfJMFs97F4OL6cKUz0S7BIDl7iG3Dy2aU+PSTLVl4ALSswfqAm4aPg6AMRdk6VOv+3bX
         EYWI6yNKKQV9IpBEUeaWUoK9oanDH5F2i0DRExMnOTt1Mcl/DS6JaPHO74EAmogZA6dE
         1rT3nfh1r1vvs7xuYQ6go/C+a+LVfObPjKviOVZii0rvfyW5Jr7ewPfmwsU7LJEt5oYG
         TzCb/N2+Ni6lcfEimenkOI6Lqqvb2aIgxBI1prt4T8anDZCUqbg8nmitybW9ADECZNqN
         mLYw==
X-Gm-Message-State: AO0yUKWlZUg7L11HecxQZpxFv/3LZru0bv/QnJZu3ybBRmj7zLNYZwc2
        3z18WyQCuBRgTM9xnwuPGLAIIQ==
X-Google-Smtp-Source: AK7set+lrtaNiEv6+zEyWS9cYD4p972SFQ5dYlgq6B5kZ0CNj58XZrBm9watTWVPNI590v7FWOwzmA==
X-Received: by 2002:a05:6a20:6914:b0:cd:fc47:dd73 with SMTP id q20-20020a056a20691400b000cdfc47dd73mr10145784pzj.2.1679021588750;
        Thu, 16 Mar 2023 19:53:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y127-20020a633285000000b00502ea8014f3sm340501pgy.42.2023.03.16.19.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 19:53:08 -0700 (PDT)
Message-ID: <c9c2c53e-ca65-2122-84fd-05cb4da99aa6@kernel.dk>
Date:   Thu, 16 Mar 2023 20:53:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHSET for-next 0/2] Flag file systems as supporting parallel
 dio writes
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20230307172015.54911-1-axboe@kernel.dk>
 <b11d27d5-8e83-7144-cdc8-3966abf42db5@kernel.dk>
 <20230316042912.GI11376@frogsfrogsfrogs>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230316042912.GI11376@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/15/23 10:29 PM, Darrick J. Wong wrote:
> On Wed, Mar 15, 2023 at 11:40:02AM -0600, Jens Axboe wrote:
>> On 3/7/23 10:20 AM, Jens Axboe wrote:
>>> Hi,
>>>
>>> This has been on my TODO list for a while, and now that ext4 supports
>>> parallel dio writes as well, time to dust it off and send it out... This
>>> adds an FMODE flag to inform users that a given file supports parallel
>>> dio writes. io_uring can use this to avoid serializing dio writes
>>> upfront, in case it isn't needed. A few details in patch #2, patch 1 does
>>> nothing by itself.
>>
>> I'm assuming silence is consent here and folks are fine with this
>> change?
> 
> Oh, yeah, this one fell off my radar.
> 
> LGTM,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks Darrick.

-- 
Jens Axboe


