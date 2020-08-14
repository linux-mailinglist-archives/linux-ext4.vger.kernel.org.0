Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4612442AA
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 03:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHNBOI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNBOH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 21:14:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62AC061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 18:14:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x25so3753670pff.4
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=didrtgmgnxY6k00MqKnJp68dTOcrvVR3skgKpcsT0AI=;
        b=moteHZx3cO8PdmEKl2HWL3tGi5FqWVhmV4g1MMVEaLi67OkNhFU3v+S5pL6mb+jHx2
         pYij6aCNUf0Trnc5xrkoRemr8vrfnYJywYy7W/L2RcC6qj89yHqEymNkWlUYyRl2B8AT
         0Qz6kdRzFne3cX/D0vcK8FR2kqTyVCIwtOC7eJqQT2nZjFf1bxKyMtGPv4ZG98Zx55ke
         G7TPesQdTjP4QU5R5Ha8RKdNQX2R0PVRZcllYjxb7A86e92G36DSUl1/ttSkEfVv+SSh
         M2iUqQkxhLGrXFXJtaoonA33nPrhiKeMzSiDfBGmRv7Nu7pUwBeC581PrsRXZsXntCsY
         HBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=didrtgmgnxY6k00MqKnJp68dTOcrvVR3skgKpcsT0AI=;
        b=QyJujj0dxe1edhOZ0Ip2EVvbQrzYXOW2O4DHbZZ6SCFJYxGPnACU1XpS/jtESP5DK+
         Io95XkwFNXf42QwshfTmIudvRIS630ZCz6Zud9WR4pDAH2rhfjoYXeIOrz5nexJGr2sD
         ZL+WTkmkXQFRf9LceMAkG6t9VKmHPSLe+8SsSxkccM7NpoYdGDLN2cJ/GoU832SDrVKR
         uFGBbc0+OykW40Y9RXd6dkP+o9eqnZCAqJMhrfHobIWqroKqbIZ+JEdCL0klblQFMU+x
         DVoKvBvNrxOZvXja4TmIjwizLTPUXmzLwKjj0t8JzWgUqV7JRzHsvSPPjTwp5xZ9vFtF
         Kfeg==
X-Gm-Message-State: AOAM532xU8j4D+QcS0SxvnR90eVeUyIOZ3v2gfayDJKICQ2Q4IS6+htd
        VacwvVobV+ICAEIuSUi3z7Qdx/Zj
X-Google-Smtp-Source: ABdhPJzUDVABBd9UWd24c9F6wUhJgPG6IkHVjeYQVVjG9OvI5MANhzEyksTWIVZpCDSXjvY1g8Ujjg==
X-Received: by 2002:a63:9dc2:: with SMTP id i185mr188689pgd.203.1597367647276;
        Thu, 13 Aug 2020 18:14:07 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id h7sm6495246pjc.15.2020.08.13.18.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:14:06 -0700 (PDT)
Subject: Re: [PATCH] ext4: fix log printing of ext4_mb_regular_allocator()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
 <8A79C6DA-5C0F-4B4F-9EEE-E272993AD0FC@dilger.ca>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <fbfffb3d-e7a1-ccef-6247-2599522671da@gmail.com>
Date:   Fri, 14 Aug 2020 09:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8A79C6DA-5C0F-4B4F-9EEE-E272993AD0FC@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This suggestion is good, I try to update it in the next version.

thanks.

Andreas Dilger wrote on 2020/8/13 3:36:
> On Aug 7, 2020, at 8:01 AM, brookxu <brookxu.cn@gmail.com> wrote:
>>
>> Fix log printing of ext4_mb_regular_allocator()，it may be an
>> unintentional behavior.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> The debug message would probably be more useful if it included some
> actual information (PID, status, fe_group, fe_start, fe_len), but
> that isn't necessarily a problem with this patch itself.
> 
> Reviewed-by: Andreas Dilger <adilger@diger.ca>
> 
> 
>> ---
>> fs/ext4/mballoc.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5d4a1be..b0da525 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2324,15 +2324,14 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>> 		 * We've been searching too long. Let's try to allocate
>> 		 * the best chunk we've found so far
>> 		 */
>> -
>> 		ext4_mb_try_best_found(ac, &e4b);
>> 		if (ac->ac_status != AC_STATUS_FOUND) {
>> 			/*
>> 			 * Someone more lucky has already allocated it.
>> 			 * The only thing we can do is just take first
>> 			 * found block(s)
>> -			printk(KERN_DEBUG "EXT4-fs: someone won our chunk\n");
>> 			 */
>> +			mb_debug(sb, "EXT4-fs: someone won our chunk\n");
>> 			ac->ac_b_ex.fe_group = 0;
>> 			ac->ac_b_ex.fe_start = 0;
>> 			ac->ac_b_ex.fe_len = 0;
>> --
>> 1.8.3.1
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 
