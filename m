Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FE677D47
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jan 2023 14:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAWN7T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Jan 2023 08:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjAWN7S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Jan 2023 08:59:18 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689626863;
        Mon, 23 Jan 2023 05:59:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s3so8794269pfd.12;
        Mon, 23 Jan 2023 05:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfoL7qpFeEQAso2LlCjuxmJ/O8yOVmGxvnrueZMG658=;
        b=XRv6qGpn1lv2lKxbaYr/7CJqJ0OUnvzrS/CnDxrg55ArYpZFNNUfEUVfMZ5HoNd82f
         Xdxit6Q/n0V8CizAQr6O4infdXY12jtsan4xGtv6wazmMo0ydME/m8DQonutQ2kSUIRO
         K7mSUTqM61tPKuP19O3bR4K1wMO3Po9fjITgJdzkTyhzGNcE9crmg87oggGV7HSywGXz
         j0JM+X/UhDw1JWnQwdKXxjjK17b+V3+4u9eMZjQcrhO4r/8nG+NwRrXAxS8a/vMWRYq0
         fuosWqv1B1w/6D7bWFr5JIa/9sbRjPH3vEGZ4rFmyw+JVNaPlfIIvdynekS3NlKwfzUL
         kHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfoL7qpFeEQAso2LlCjuxmJ/O8yOVmGxvnrueZMG658=;
        b=yDinIgslKzowso4im/ek5LRLyGcm21J8/vZLyDR2hJj8CciyDphtOBH5ZsV2ki3foC
         Ezfoj8FnflhZr7PkkM1WkCC0G+v33LeidDJtM4i1uMz8Nyz3+JpeI7Sl1fJT9k7d/V1f
         wIQzB9Ol9r5zzROGFr3Pfojbo90UkAct6D60W05wbmlqFe5tmdvSCaumb2CV67jbAk1J
         9tWrVG62iqM3HJ0WCWULke+qcpecpgaNa/dGPCPgnPdX81sPJP6sTGwlEKK7HcLelkqC
         NRtaeFwJOFvddhs9avw7W8/n9CzQzwIgFF2fs1/kETMl49ljTcTnNr9BT8cjq4kIQNcO
         vGFg==
X-Gm-Message-State: AFqh2kqgtYjUR3C/o1PmPRA14fQgxbWBkPtemf/9phaZRGH141y9kyWP
        9jyU1TZy5nNgxJtgS/eHm6o=
X-Google-Smtp-Source: AMrXdXuf3ZqJbbXGrwSpPQBsRr62KhzmVg4LgAJC1geDIjbSXheDfOM0HrpASVeyVp11/cwxZBscUw==
X-Received: by 2002:a62:6410:0:b0:58b:c873:54e9 with SMTP id y16-20020a626410000000b0058bc87354e9mr23542843pfb.4.1674482344855;
        Mon, 23 Jan 2023 05:59:04 -0800 (PST)
Received: from [192.168.43.80] (subs09b-223-255-225-233.three.co.id. [223.255.225.233])
        by smtp.gmail.com with ESMTPSA id z30-20020aa7991e000000b005898fcb7c2bsm27189906pff.170.2023.01.23.05.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:59:04 -0800 (PST)
Message-ID: <cb0187ce-7e40-c1e0-f2ce-fc1f9b45f5ad@gmail.com>
Date:   Mon, 23 Jan 2023 20:59:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: ext4: Fix full name of the GPL
Content-Language: en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230122180552.53445-1-didi.debian@cknow.org>
 <Y83sssQr5DMg2KMc@debian.me> <3646506.8mSpapujdy@prancing-pony>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <3646506.8mSpapujdy@prancing-pony>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 1/23/23 19:44, Diederik de Haas wrote:
> On Monday, 23 January 2023 03:10:58 CET Bagas Sanjaya wrote:
>> On Sun, Jan 22, 2023 at 07:05:51PM +0100, Diederik de Haas wrote:
>>> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>>
>> No patch description, really?
> 
> Please disregard this patch.
> Next to 'style' issues, I now consider my initial view of the issue as a 
> spelling error, incorrect. I would be changing the license and IANAL. I'm also 
> not the copyright holder which I believe is needed to change the license.
> 
> Apologies for the noise.

Nice to see you reply to the review.

However, as I noticed, it seems like your NAKed review replies
have the same wording, which make me wonder if these are written
by a bot behind your email handle. Next time, please write
variate your writings (write using different words but convey
the same meaning). I'm also sometimes hard to figure out
which words should I write.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

