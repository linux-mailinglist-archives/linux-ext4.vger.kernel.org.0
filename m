Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2032CE525
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 02:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgLDBaS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 20:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgLDBaS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 20:30:18 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E03C061A4F
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 17:29:38 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b12so2225560pjl.0
        for <linux-ext4@vger.kernel.org>; Thu, 03 Dec 2020 17:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzVbOuTWMuJRRFEI2/dqlAiLtYVTf7OdfuGUSktbgOE=;
        b=RBVa86xhpP4LKzJDNIlL3M2br1GggvFiWHatsixICYkea2Efcp6i9aHWo5734zyGYK
         yT0dQWUfT6+Ol6OUKOpVeFNDSOWlFbfPJiOg2RKefcifcjWtik15kC6YP6NVot8femig
         jCD78GTY1luQujnkLZ2BwtqU1zz918oMFNFqHVGXKBIYW/t3kr3RErBo8/WlVTJM5/xl
         OkGEFCB27bYv/9d8YxMzWLlJ8E1jijOR48NvtWwahPegORdlgBk3XJhllGHj90MwO0eM
         Yy/Z06lrxKVdYdRqP659L+wCrEwqeJ2qG+lMGScVMxs55e++kWV7ZWN3fwmxd8oLBv3N
         C60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzVbOuTWMuJRRFEI2/dqlAiLtYVTf7OdfuGUSktbgOE=;
        b=ksVAa9cvqauKvTXVqj7YGZ59NJYmEyE1/dnMBghImALFTf//hDVuXVhtjM9w6sgtn9
         z/kjA3xufgSS1zUeO/02D88gaL1/Ur6x4go1257c+KRywi3QJb4NgnUXeKmfjGyM8A4C
         piOzXZNv/ImtbEvSUDqhsjEd84h7riSak2vLXA0OLkMuYP+gMDyXAdjbWDPdS4YDW2zu
         RfJhsky+STuu5yP+MG63iDZ6OfHhHL82PedWhaBoN3ncCjwQLwWMPxvJuzI7snjOi7N4
         YSFGbvRX7p2A82DdzcUCIGr6fFIfzr6bWOU81ufoL+3EHMINFOWNmOZbxiz7D9NryBh6
         xc6w==
X-Gm-Message-State: AOAM532UkkLCYEOJW/bql10Xm4IelSKPrFJtyTD7kf/gqc2gs+A9y4OK
        FMpyxjYZ5xIJyVKvQh9bbEeJwVC9Szs=
X-Google-Smtp-Source: ABdhPJywxkP/7Bbm3xdesJoE8hRUQkjDL1PxSaqK2AYWQrKcLRM39eBI3O3ZTfoMZgipmu69nMHz0g==
X-Received: by 2002:a17:90a:4b8d:: with SMTP id i13mr1874994pjh.86.1607045377509;
        Thu, 03 Dec 2020 17:29:37 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.50])
        by smtp.gmail.com with ESMTPSA id s11sm2950258pfh.128.2020.12.03.17.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 17:29:37 -0800 (PST)
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <6d061665-f66e-9af4-5f91-fe0e4902bce8@gmail.com>
Date:   Fri, 4 Dec 2020 09:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203150841.GM441757@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Theodore Y. Ts'o wrote on 2020/12/3 23:08:
> On Sat, Nov 07, 2020 at 11:58:14PM +0800, Chunguang Xu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> In order to avoid poor search efficiency of system_zone, the
>> system only adds metadata of some sparse group to system_zone.
>> In the meta_bg scenario, the non-sparse group may contain gdt
>> blocks. Perhaps we should add these blocks to system_zone to
>> improve fault tolerance without significantly reducing system
>> performance.
> 
>> @@ -226,13 +227,16 @@ int ext4_setup_system_zone(struct super_block *sb)
>>  
>>  	for (i=0; i < ngroups; i++) {
>>  		cond_resched();
>> -		if (ext4_bg_has_super(sb, i) &&
>> -		    ((i < 5) || ((i % flex_size) == 0))) {
>> -			ret = add_system_zone(system_blks,
>> -					ext4_group_first_block_no(sb, i),
>> -					ext4_bg_num_gdb(sb, i) + 1, 0);
>> -			if (ret)
>> -				goto err;
>> +		if ((i < 5) || ((i % flex_size) == 0)) {
> 
> If we're going to do this, why not just drop the above conditional,
> and just always do this logic for all block groups?

Thanks, in the large disk scenario, if we deal with all groups, the
system_zone will be very large, which may reduce performance. I think
the previous method is good, but it needs to be changed slightly, so
that the fault tolerance in the meta_bg scenario can be improved
without the risk of performance degradation.

>> +			gd_blks = ext4_bg_has_super(sb, i) +
>> +				ext4_bg_num_gdb(sb, i);
>> +			if (gd_blks) {
>> +				ret = add_system_zone(system_blks,
>> +						ext4_group_first_block_no(sb, i),
>> +						gd_blks, 0);
>> +				if (ret)
>> +					goto err;
>> +			}
> 
> 						- Ted
> 
