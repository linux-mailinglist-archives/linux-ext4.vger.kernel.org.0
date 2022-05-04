Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8751A1D3
	for <lists+linux-ext4@lfdr.de>; Wed,  4 May 2022 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351051AbiEDOMU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 May 2022 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiEDOMP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 May 2022 10:12:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A891419A5
        for <linux-ext4@vger.kernel.org>; Wed,  4 May 2022 07:08:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq10so1355348pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 May 2022 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KCUaAMRk/weQ5nqNkSROe/7DXdzibTETQDxMQoF1EaE=;
        b=RFbQxpIuE6C2ezyq6DDlHFOTEWWOCSlzloILsvJYPYmOGxX7gQ9uTEG51n5YjaL6OD
         V3j00TS7GvuTSh8bEkjygYEWwVSCEORP8z/L6I+P+PcRHBGFru66/FXdJvyXRffMJ6yr
         dNE3FqU00mvP2Df22Jr+MTMrbKg9vkHExlgW2dp8rdaRvtdK3fSsyk3wSS43qpMsx3f8
         eCUf4EQF+S6uDKqANPkHZNKBcv+587jufWas9I09vYyBK6vsTMDQoR8kKuTxd2ooOTM1
         yzhX9yCKwb/LnFU6LP/5tWcn45KDU9EuIamY097VHjBm5+fojU3Y7lS0K8b69x1WVB74
         OuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KCUaAMRk/weQ5nqNkSROe/7DXdzibTETQDxMQoF1EaE=;
        b=E1wuYNdbB48A1i4mTuwxQi0/Xw3PlioS+fKU3rlGt9nDLOtuJVp7F8WiHTRSTcpUs1
         LrTHl+aNfUbDjV5V1ZIIcbW5UfcnrH3DXnmEIcf9xUOIcJpIPS4/gIEsisl/Zi66UFVN
         8w0XCUJEJKfkI7LU3E434mQ2Or3bPrMI8WnUg739ioja18BsniEj/BS5CvzptF0uo9sM
         0jrPkMMYNaBDiYFfDaJY5ivfRgUB0Dpm4ysV/5EhaIYMVnawg4U3wtieeWCG2m7blIvt
         +43aXw+SaheNVyz0RC0KblbvfHKjpglsmo+d9fo0SFWAGYCxEZ5nUxEf4gCcR36vBgka
         qasQ==
X-Gm-Message-State: AOAM5308huPMdNn2ZFAmAdh22ln/SAoZ7umSCbAPEPiVAN7NAw9PCPj+
        fBohOrl7HRgTHXDq/HozUqc3DQ==
X-Google-Smtp-Source: ABdhPJylWIf1pK8rvbBUafZUQvlvfAiHqRnOsNMdX1IJgYuXv1cD6M/jCDQK+hl++TSIBX3sjHgizA==
X-Received: by 2002:a17:902:ef47:b0:156:646b:58e7 with SMTP id e7-20020a170902ef4700b00156646b58e7mr21309272plx.57.1651673318945;
        Wed, 04 May 2022 07:08:38 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b0050dc762816csm8258048pfh.70.2022.05.04.07.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 07:08:38 -0700 (PDT)
Message-ID: <159d94d4-d9ea-7f3b-f86d-be5f981db605@linaro.org>
Date:   Wed, 4 May 2022 07:08:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ext4: check if offset+length is within valid fallocate
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, tytso@mit.edu
References: <00000000000042d70e05da43401f@google.com>
 <20220315213857.268414-1-tadeusz.struk@linaro.org>
 <20220428140209.mewduy4rzr25iepb@quack3.lan>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220428140209.mewduy4rzr25iepb@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 4/28/22 07:02, Jan Kara wrote:
> On Tue 15-03-22 14:38:57, Tadeusz Struk wrote:
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> Did this fix fall through the cracks? Tadeusz, can you do a proper patch
> submission with your Signed-off-by etc.? Thanks!

I'm still working on it.
-- 
Thanks,
Tadeusz
