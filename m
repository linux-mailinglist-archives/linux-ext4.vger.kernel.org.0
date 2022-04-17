Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E15045E2
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Apr 2022 03:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiDQBCM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 16 Apr 2022 21:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiDQBCL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 16 Apr 2022 21:02:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D88935854
        for <linux-ext4@vger.kernel.org>; Sat, 16 Apr 2022 17:59:37 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 125so12861860pgc.11
        for <linux-ext4@vger.kernel.org>; Sat, 16 Apr 2022 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yXcY2sLxKmu9+uc8znQAcPD2dNxuNr8ZbO+FOstkiZI=;
        b=jsUPT3YHo4/cYIAmgZIAnSlYKI0nc959ufJajYfMof9OwJfk20C6Jj4MCQxOoFVfzd
         8CZITImUA0JUL0rrsbN+Q1jNPdwfbDzbpEAwuMbYmWzUDWqN1LlxTMxKdr7wiTart807
         lVYSEsSYCvnqEcNF4dIvrrVs1ZnilrXJQq3BpTVlfaWyUg2/iYsX4teP+q2rubL0kyQ5
         9eA1WHgD3af7B0FsT02HiHg8qTUY1m/N2ZSDXv1ZSbiE2eGhS1U75MedrZWG0VbqDCIk
         86ZiAmZ+hqm6VgzTsJ6EyhJsfsG2O+zSwYSBGtFzwmVvR8ykckMNH1pUvI6/JhYqMXJc
         cAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yXcY2sLxKmu9+uc8znQAcPD2dNxuNr8ZbO+FOstkiZI=;
        b=gaSQqeTy3MQv80fBXcZ+o0Eg9il1qb0ysqjs+Clw5s8UsLt+YFdxbcGzp7Yq6iUZSX
         QeS/Yn4fbUXroW0b2siY3AkK8fbEgYFZCXYE6XJc8JxQPpJxSNzmojh7nE52Jy/6fNDx
         CM2OApSUj7L2N4LrjPzH6fVtVbz4BdrOtQPP9gUbiPBq+8bbo2lQrucc7GEVfhHDRaXO
         Omc9rxjmOTrpni3R8SaBfPTYy6cAJjLXY+WsIEf5oRc3KmNQUSjLDH+WodLnaV1+Q2gH
         iLfIgstuJzsnl8okwQh8999wqVqkN+z5xyfsfMaBTiVhi9DqrrdfywMlEaYHJpl4weRk
         mT2g==
X-Gm-Message-State: AOAM532PoUhX1jbw3PY03d3yd/W7vAl+HTDE6aPIgGpjWkqKrf4HdvWO
        SuNyjVo1LeKZANn7193bObLSDw==
X-Google-Smtp-Source: ABdhPJxS8hWePjkV3vWDzdBPaKDjkCYeE4v1b+9th/qUkjqCYUe6JY6gLNCzRhsT0ihLU/bpO30Pqg==
X-Received: by 2002:a05:6a00:2186:b0:4f7:5544:1cc9 with SMTP id h6-20020a056a00218600b004f755441cc9mr5454910pfi.62.1650157176951;
        Sat, 16 Apr 2022 17:59:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a670c00b001cbb7fdb9e4sm12697070pjj.53.2022.04.16.17.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 17:59:35 -0700 (PDT)
Message-ID: <7ae1f26a-cd09-85ff-2f4c-9e80af41ce66@kernel.dk>
Date:   Sat, 16 Apr 2022 18:59:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
Content-Language: en-US
To:     Eric Wheeler <linux-block@lists.ewheeler.net>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net>
 <YjfFHvTCENCC29WS@T590> <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net>
 <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net> <YldqnL79xH5NJGKW@T590>
 <5b3cb173-484e-db3-8224-911a324de7dd@ewheeler.net> <YlmBTtGdTH2xW1qT@T590>
 <YlpRrLmwe/TJucjz@infradead.org>
 <2815ce9-85f-7b56-be3f-7835eb9bb2c6@ewheeler.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2815ce9-85f-7b56-be3f-7835eb9bb2c6@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 4/16/22 2:05 PM, Eric Wheeler wrote:
> On Fri, 15 Apr 2022, Christoph Hellwig wrote:
>> On Fri, Apr 15, 2022 at 10:29:34PM +0800, Ming Lei wrote:
>>> If ext4 expects the following order, it is ext4's responsibility to
>>> maintain the order, and block layer may re-order all these IOs at will,
>>> so do not expect IOs are issued to device in submission order
>>
>> Yes, and it has been so since REQ_FLUSH (which later became
>> REQ_OP_FLUSH) replaced REQ_BARRIER 12 years ago:
>>
>> commit 28e7d1845216538303bb95d679d8fd4de50e2f1a
>> Author: Tejun Heo <tj@kernel.org>
>> Date:   Fri Sep 3 11:56:16 2010 +0200
>>
>> block: drop barrier ordering by queue draining
>>     
>>     Filesystems will take all the responsibilities for ordering requests
>>     around commit writes and will only indicate how the commit writes
>>     themselves should be handled by block layers.  This patch drops
>>     barrier ordering by queue draining from block layer.
> 
> Thanks Christoph. I think this answers my original question, too.
> 
> You may have already answered this implicitly above.  If you would be so 
> kind as to confirm my or correct my understanding with a few more 
> questions:
> 
> 1. Is the only way for a filesystem to know if one IO completed before a 
>    second IO to track the first IO's completion and submit the second IO 
>    when the first IO's completes (eg a journal commit followed by the 
>    subsequent metadata update)?  If not, then what block-layer mechanism 
>    should be used?

You either need to have a callback or wait on the IO, there's no other
way.

> 2. Are there any IO ordering flags or mechanisms in the block layer at 
>    this point---or---is it simply that all IOs entering the block layer 
>    can always be re-ordered before reaching the media?

No, no ordering flags are provided for this kind of use case. Any IO can
be reordered, hence the only reliable solution is to ensure the previous
have completed.

-- 
Jens Axboe

