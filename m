Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3976B77E5
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 13:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCMMoR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCMMoE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 08:44:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0321720044
        for <linux-ext4@vger.kernel.org>; Mon, 13 Mar 2023 05:43:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j11so48174793edq.4
        for <linux-ext4@vger.kernel.org>; Mon, 13 Mar 2023 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678711419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KBwvnk3MOdnQ4phoEaOd/Sur+/zbQ/JcB41OHqz69Y=;
        b=D4VxQAk8YQwdaIM8f6xYINpHIRnUks7jRb9tsVIwr+xLOKI4eU1WjFT1DR1+Kvez94
         cD8PI9tVU+f53Ogrhgc7pJDdr5FBqWO2GtCkn+RSODiBscpmH4XVR9oyvxG4dXPg+ggf
         WAe+sijyQmoixwKDJa1uFN1nfEf7I5nuLTF4xTkZtZ76rT0RuhX+AJEEdwjEzLgJkWvr
         9XVoGJ2OFoDl2Kmw/pHdF84e637IDCgVcc5RsksII6rVB+TWZaWvdZLwvHEGA2v3VHv/
         BW+ylQCc6njgxEURSSo89hXrd2u2exXL+6LIef1tz8iPDK2FSYFWP3xcaRSOAvQ9Uj2g
         Upug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678711419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KBwvnk3MOdnQ4phoEaOd/Sur+/zbQ/JcB41OHqz69Y=;
        b=rnvgdBiD8ihlBoS/kX181cvh9KNruiZvDEpPsV239nZus1raaC09briWHVEQLCShON
         KVfpG2aV4HT5McAmds5w3LTiZQ50gkQxH3b6yZ2yJelDpfuFJ4kw5kIOkr4M3/ngvmlh
         if2JBehZOiBtG4Z9jmE3BTvgCM8/t3nmn7EIVYINpfzP9kQmZBJm+9qF1fpMR/dehJDa
         xYeoIIrxMRO8zqv8KOhc0NVc+UwkI1uKxQO/UgRSvaocnB0yaNmhfdJYxONk5KtnwrCN
         +ytK7aFOB2oYJCF43+0J3HINHK0TbZslSDozLN6wqfEeHhrxbHoBsxn2zw2hTdfYMoJ2
         okPg==
X-Gm-Message-State: AO0yUKX+r5ufh05rd+RaoXoQRjNbzBo/T/jBWq84HdJxlLpwiwfyReoR
        CW+zmlutdL1Kk2R1cG3Eizpu6g==
X-Google-Smtp-Source: AK7set/XusdDAbHQT5pKgrC7UIBb/UmhxFSKOwIcmIx3IRayQVro5RXMU3oezqx+mZXiWwpX+74xyg==
X-Received: by 2002:a17:906:64d:b0:8b1:77bf:3be6 with SMTP id t13-20020a170906064d00b008b177bf3be6mr32449177ejb.10.1678711419311;
        Mon, 13 Mar 2023 05:43:39 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id gs20-20020a170906f19400b0092babe82cfesm473294ejb.215.2023.03.13.05.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:43:38 -0700 (PDT)
Message-ID: <d3f2cb4d-da47-baec-4d93-4f1a700a07d3@linaro.org>
Date:   Mon, 13 Mar 2023 12:43:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] ext4: Fix reusing stale buffer heads from last failed
 mounting
Content-Language: en-US
To:     Zhihao Cheng <chengzhihao1@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, Lee Jones <joneslee@google.com>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-2-chengzhihao1@huawei.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230310125206.2867822-2-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Zhihao,

On 3/10/23 12:52, Zhihao Cheng wrote:

cut

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217171
> Cc: <stable@kernel.org>

Shouldn't have been stable@vger.kernel.org instead? That's what is
advertised at:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

A Fixes tag would be helpful. It would assist the stable kernel team, or
people that have to backport your patch, in determining which stable
versions should receive your fix. Same suggestion is made in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks!
ta
