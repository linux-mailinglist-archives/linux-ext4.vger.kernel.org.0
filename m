Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682113F840A
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhHZI7T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbhHZI7T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 04:59:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60561C061757;
        Thu, 26 Aug 2021 01:58:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so1385304plh.7;
        Thu, 26 Aug 2021 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEePIJsNKUhe8VCWtiykIc8ceuZS5oinIILlhZg2UbA=;
        b=G4ho7MlpAuMgFCinS4rS3QXbXy6O9yPx+I6GXxm88IyfkIbdttxj/UiLjxlXXupAMo
         7o00kawSHuOjMTXmD0lcsJtnSP86slcUiRBwzJHyM+Fva7b8yiHkLJNuDnMSfC69geoh
         jDQ4PSf1C2SpfwhK1xwoBBQ74BKAx963fRPl/ofncpHD36oK3xbAAvKNhBkQkePue9fd
         5+MngytfsG0Iqa8CKzq0HuHXffu9uozmlfY3R5VXtIug/JIzP17glBuzzD7jmANgz/rk
         uZD3+e3MOrXJopF/07FsCsWJt1Qi+ef8FqKzm369aj8riFgJ28lxm3G66PpzLVhtqN+R
         V4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEePIJsNKUhe8VCWtiykIc8ceuZS5oinIILlhZg2UbA=;
        b=rb+sAiLlavQau4k3u51Ky/rPA1YHrKWAQN7uy2dat6zNv0srw0cdWf7BeYYKLn77GZ
         O5wb96JrTEkOhN00diOIUKQxvKuXR9M8v7iiQghl1mqdFJp7+PRsYbn5p/7WQVzXU7fe
         5hROnvKnX7wZk5mnJzj5PIFBj2GqCKTVsobLgXb8C+YAte1+EH8+X25iABmaMwfaRJO5
         Xe6t/h6w8vU0dvMqR9cYy6af8VpGFhWnKRJfbabQHNkISRXoJisAl/2cHc2IawCsgWmZ
         iI3zqa+HPqmQ7WIpH+WONN898s1QCD/ZLuEMPQpeAaZjCCOEhgGWl3Om5HNXPMIpNeLw
         fP/g==
X-Gm-Message-State: AOAM531C8fUxa7QpfPCw/7wY7WTpj/Ke1ZLdGoNZXWUgLXB+gHJ2TjTg
        d5vzuuuVbkg3beKjncMUslE=
X-Google-Smtp-Source: ABdhPJzFXAntZk3ub7JoKNLQ7YzwA9y0Tm8rSAuWA3X4kgXOgqIMWw0IY7TnhxVEn1NmZiKUbmU1bQ==
X-Received: by 2002:a17:90a:5e03:: with SMTP id w3mr3137259pjf.152.1629968311951;
        Thu, 26 Aug 2021 01:58:31 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.223.168.16])
        by smtp.gmail.com with ESMTPSA id y7sm2231456pfp.102.2021.08.26.01.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 01:58:31 -0700 (PDT)
Subject: Re: [PATCH V3 4/5] ext4: get discard out of jbd2 commit kthread
 contex
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-5-jianchao.wan9@gmail.com> <YRV6qqZcsNBHZzyn@mit.edu>
 <65c6aa35-5e4c-a717-d1dc-8842e3ce0424@gmail.com>
Message-ID: <5a3e272a-0714-4d10-d260-fc716f9438f9@gmail.com>
Date:   Thu, 26 Aug 2021 16:58:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <65c6aa35-5e4c-a717-d1dc-8842e3ce0424@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/8/26 3:51 PM, Wang Jianchao wrote:

>>
>>> @@ -3672,8 +3724,14 @@ int __init ext4_init_mballoc(void)
>>>  	if (ext4_free_data_cachep == NULL)
>>>  		goto out_ac_free;
>>>  
>>> +	ext4_discard_wq = alloc_workqueue("ext4discard", WQ_UNBOUND, 0);
>>> +	if (!ext4_discard_wq)
>>> +		goto out_free_data;
>>> +
>>
>>
>> Perhaps we should only allocate the workqueue when it's needed ---
>> e.g., when a file system is mounted or remounted with "-o discard"?
>>
>> Then in ext4_exit_malloc(), we only free it if ext4_discard_wq is
>> non-NULL.
>>
>> This would save a bit of memory on systems that wouldn't need the ext4
>> discard work queue.
> 
> Yes, it make sense to the system with pool memory

s/pool/poor  :)

> 
> Thanks so much
> Jianchao
> 
>>
>> 					- Ted
>>
