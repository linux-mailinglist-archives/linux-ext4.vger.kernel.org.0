Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9164A58D8DE
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbiHIMpp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 08:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbiHIMph (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 08:45:37 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EAFB1F4;
        Tue,  9 Aug 2022 05:45:36 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id j8so21967037ejx.9;
        Tue, 09 Aug 2022 05:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2ZVvknZLbI+9dH40fkax3dFzhSLXw8C3++x5d9U6r8c=;
        b=591Fl6RoPeZ/7PKaKCzVPQjX2gF0IoX0eKH/NgfpExS7rhJWH1JH0LbhRWFR/eDFnB
         25Sh/oB29MPHbwdSYryovWr/2A+DccgIbWEs66jqi4pnthkwXSrD1/VL09kHEhRv6bOR
         IeOaN/X9o3Y+JMbIWGaqVKcJiPsY0o+sxg16QzFunbzc7fSlDxIyv8AvWbQFiveETmYi
         5c/xpQpyZ+ggI38pqAkcghL7CHFmh3Z+BT7y7fxQ1SZxAtrsltxzCuvKnB9wTSoGnjkI
         07NGVvQ56UWIgw9AzNgveiOyCmiNW7aWtKv4LosizgrycW8CE8t5HHInyYHxw5YbW0wp
         mL/A==
X-Gm-Message-State: ACgBeo36/w6f8RGCALS68DRpFCPBI/fcIhr4HPDzJjadTmHfepGNzNfi
        Ug8J2XYqgd8wy/vtzr0S4Ek=
X-Google-Smtp-Source: AA6agR4Um1jKdWusNyBdpQ42qrtjC3m4YcqT1Vk5/9x2rkR13SZ+mGj/6jBrgLgzyWzlSlH5C6AQPw==
X-Received: by 2002:a17:907:9625:b0:730:ad62:9c86 with SMTP id gb37-20020a170907962500b00730ad629c86mr16990268ejc.281.1660049134964;
        Tue, 09 Aug 2022 05:45:34 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709061ba200b0072f441a04a6sm1110817ejg.5.2022.08.09.05.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:45:34 -0700 (PDT)
Message-ID: <b2662600-07cd-7125-d7c3-b7bbe1bad824@kernel.org>
Date:   Tue, 9 Aug 2022 14:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: ext2/zram issue [was: Linux 5.19]
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com> <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
 <9fd860a8-4e4f-6a95-5c3f-1b3c4a76cf51@kernel.org>
In-Reply-To: <9fd860a8-4e4f-6a95-5c3f-1b3c4a76cf51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 09. 08. 22, 14:35, Jiri Slaby wrote:
> But the installer is different. It just creates memory pressure, yet, 
> reclaim works well and is able to find memory and go on. I would say 
> atomic vs non-atomic retry in the original (pre-5.19) approach makes the 
> difference.

Sorry, I meant no-direct-reclaim (5.19) vs direct-reclaim (pre-5.19).

-- 
js
suse labs

