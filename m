Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66B258323D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbiG0Snl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiG0SnU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 14:43:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CACF11CCC7
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:40:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso112972pjq.4
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=9ODf3/7a0YWthMFUbQSzorMWt+mXId+4ZYKev6XizEA=;
        b=oeYciCEYMx/K9VImyELz6jlH+XHh46HGEMQxt3c84YhX/td2/rS+FvJsqTK6woA1AO
         IZAiiwjFZL/2hSb38TJjx4ST45zgM9t/j6p5luheuQqBlX4ejrvWRqR0xYdJq9wVU7Ug
         Ij49DaJgPk5LVwdTM2GMB5okdgTpp3+UXCzLMbaTSfoVPQEKiGcL36bJYVrSfc+jW+Bh
         AkYrL3LVjx+M+F085Dm/UzF0SlxCJGk2G34MRNTUZ8au7T2Oo2P/A6uTYKt5JZ3N3rav
         3LcGrCaO33Ue/kBIsq0b2y7+DwBHlZMWCBTWi8iWcLH0W7CIQ0SG0Q9gjO/oT8V64WKW
         u5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=9ODf3/7a0YWthMFUbQSzorMWt+mXId+4ZYKev6XizEA=;
        b=Cb8XMf63o712n+sRjjeQKNre8ZcugXHg+FPdP4aFv2HQDnQ+dqvrIf1pk4PZlJ+pxD
         JV/oBLs6vn85mYqZpafw52T2GYm/VCL3gIx3FDfcAs56hXInJoEiVdyipFlzdi/XOxNd
         3mclWZbXIaxZZFJE7CFVD2Zsj8X7W/Qd/uPq/bx/cRNs4M7Iwe6TKqxZLRWrAj1ZDrWP
         FREg9qp/DpTIxzC/nXNq/IMNZI+aXH6I57CKZH0ZKAxBhmSEuFQPWDwd+XFquXnjeQvi
         XBgbrrae6RriV/SpRSmwpEQFP3fnSnA65YxICUFvLe+Nl+htt+aLZKkyg9Pp6xalmqgt
         yC8Q==
X-Gm-Message-State: AJIora/ubLhhYz1yPzy5y1/Ecqnmf8PA+ffS9qlATZG7qgcX77emM0Ub
        aCOGTkZ7DwNa35WfLRbFcgqsuw==
X-Google-Smtp-Source: AGRyM1s13Fa1EJMrBTGTG+hbpfKcUTOSzkwGqNkTWYvWM2uPpC7aXcj3AZSburuigniRBSjn0/LFTw==
X-Received: by 2002:a17:902:7290:b0:16c:cbcb:3971 with SMTP id d16-20020a170902729000b0016ccbcb3971mr22265567pll.165.1658943627157;
        Wed, 27 Jul 2022 10:40:27 -0700 (PDT)
Received: from ?IPV6:2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225? ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b0016d9e53c138sm4480741pls.17.2022.07.27.10.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:40:26 -0700 (PDT)
Message-ID: <29a17172-c8c6-0e69-6e38-e482500d2ae3@linaro.org>
Date:   Wed, 27 Jul 2022 10:40:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
References: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
 <20220726224428.407887-1-tadeusz.struk@linaro.org>
 <20220727172517.bv2bflydy2urqttv@fedora>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] ext4: try to flush inline data before calling BUG in
 writepages
In-Reply-To: <20220727172517.bv2bflydy2urqttv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Lukas,
On 7/27/22 10:25, Lukas Czerner wrote:
> I don't think this is the right fix. We're in ext4_writepages, so at
> this point I don't think an inode should have any actual inline data in
> it. If it does it's a bug and the question is how did this get here?
> 
> The inode is likely corrupted and it should have been noticed earliler
> and it should never get here.

Yes, that was just an attempt fix something that I'm not quite familiar
with.

Jan sent already a patch for that fixes it:
https://lore.kernel.org/all/20220727155753.13969-1-jack@suse.cz/

-- 
Thanks,
Tadeusz
