Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4560878B277
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 16:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjH1OCo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjH1OCg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 10:02:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F9FBA;
        Mon, 28 Aug 2023 07:02:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2153296b3a.0;
        Mon, 28 Aug 2023 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693231353; x=1693836153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX4q9X0XjPcxu8xergag9cpneazuWyiZmw+yPoALHVk=;
        b=lQTmuSgIoZvf0GQp2gsAPvlbwnluh0ktknRtcMWafnUSr0SXXet6j5EZaivHIfAT+j
         2e9ttRgPTLEyp1xJKkTgJzovo7Is3I0ErG3J24YeocOUzbGx4ZnJJQPOoiSeZTw6QWe4
         rfSC4/9m3NAPEMSR9908sGP3HSsIJihmKGEz1Q/UIyXkSI7LK9mIBMVVWAaXxb//caks
         82O/IEqKk7p6Z9qGJhsOCc4IT0bGRqEjR8vSpVznSHIULMyCJg7bEAWS7ZuPaDQCaSSN
         pp52ytxvMnAX4hVJfZD79xw5yO63s856vNVXvBdIVBmSC3icVlakoW3LMECIbZ0Edc9J
         MxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231353; x=1693836153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gX4q9X0XjPcxu8xergag9cpneazuWyiZmw+yPoALHVk=;
        b=HhMzPZ6SxGzV8entHBum3dKacqPf4ZzpB3VrneK2/Zw4yQ09bthlPUAqbcajHe+f2A
         HP5XItRqWVUztRZxIcerBP8zJEJBit77nFeR0XDKWKSaEz1QiXL/49Eium8ffq7UcYJj
         ci+VkB1roVto7kmqBclXJs6auJ+CJSq2GpxjEUeWvnjVDy/W5lgMjh9FChnG3viWwtwu
         4sTpgb7QQM/CrkgK5gDggkq2xh4sRBq6kKMWg0PD7RN4vC1qosfhaFxfx338U/ZoN8OV
         DRvr/SuW0iXSJoV0AgGTasLnLTVxgyhwoJ+pY6vTl4i6rSZxm3hmutNSbDiaLxFXDk07
         lNFg==
X-Gm-Message-State: AOJu0Yx9ZE88gRh/qZsvLfStGq6pbRaINbHorgsk5rU8J+OsTySYuSYb
        QVxdKljGAKzDCO6ppj4uL68=
X-Google-Smtp-Source: AGHT+IHEtGzXWLbHoBoIHQK7jtKPa1moH17URc4//fuNNbzkO5bzmoZVGtMhAws2Ir92jNbtc8To7w==
X-Received: by 2002:a05:6a00:1a15:b0:68a:6746:fecb with SMTP id g21-20020a056a001a1500b0068a6746fecbmr17729689pfv.5.1693231353209;
        Mon, 28 Aug 2023 07:02:33 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79192000000b00682669dc19bsm6672095pfa.201.2023.08.28.07.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 07:02:32 -0700 (PDT)
Message-ID: <f9a37c55-32f3-15d2-a370-286716dde2f2@gmail.com>
Date:   Mon, 28 Aug 2023 21:02:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
To:     Jens Axboe <axboe@kernel.dk>,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <ZNqWfQPTScJDkmpX@gallifrey> <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey> <ZNu668KGiNcwCSVe@gallifrey>
 <ZNwm7Mo9yv7uIkno@gallifrey> <324fc71c-dead-4418-af81-6817e1f41c39@kernel.dk>
 <ZNzg1/zhxYV2EkBX@gallifrey> <ZNzl2Sq9UJ3FiTgV@gallifrey>
 <ZOymtgiZYGQ6QlxN@debian.me> <285df093-dd85-4d5f-8151-6d9f54a994b5@kernel.dk>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <285df093-dd85-4d5f-8151-6d9f54a994b5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 28/08/2023 20:55, Jens Axboe wrote:
>> #regzbot fix: 5ff3213a5387e076af2b87f796f94b36965e8c3a
>>
>> Yet, I don't see that fix commit on v6.5 release...
> 
> That's because it's e5c0ca13659e9d18f53368d651ed7e6e433ec1cf
> 

OK then:

#regzbot fix: e5c0ca13659e9d18f53368d651ed7e6e433ec1cf

Sorry for inconvenience.

-- 
An old man doll... just what I always wanted! - Clara

