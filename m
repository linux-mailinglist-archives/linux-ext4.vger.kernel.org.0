Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABAC2CE51D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 02:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgLDB1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 20:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgLDB1c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 20:27:32 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD832C061A4F
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 17:26:52 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so2567370pfb.9
        for <linux-ext4@vger.kernel.org>; Thu, 03 Dec 2020 17:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b3+G2g7eJAegtujoYBvsFOPv/1YLO1ekwKoxVeuv7n4=;
        b=nWcGGPzPOBzewgcZhzu6AHpveYZGfH7a1j69FTY5lvcT7w/yvt/BDgnjFEtIWIgNpe
         FG0Q4vv4+arIJRYCcMKAIdpAq63b/PrDG1qJ4IKWJ0VDFKfroUXSjHnpdzkebDPGwpOp
         KjRPV7UwSvvbh0hO6sV9UJSMCQkCpyN9MUG7PcloPNDUyuhp2bUwugttfXTPWVdZoBsy
         ay251/PcwE4bPa/PXlhv855KqxE91N52O1QaekwyU2OYoPKo2y7EDGBPDcBf1SOdS4bd
         oDD/RYhAEnO4D8bgFjDclLDZlYBw9qGI0bNMJf+DE+JsEj8y6LAv3A5nqCYbinKViu0O
         AO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3+G2g7eJAegtujoYBvsFOPv/1YLO1ekwKoxVeuv7n4=;
        b=K0trFl/KLMlrjfhkZQtsugZF2qULIfMKZKfY7KciVqAI8eWquk8jzGHdFpJ1GFKL4x
         6P59Ol3qkVuOJ5XXQba2I9juJ70oFXSfQ/SeAbT7TxSlMm+7ARQcgEAPmP59pvoejLpR
         rCCX1bcChUKQsuwKo/lH66sqy/r+z8ODV9PEVayS8lj1LJeJVffa5eQRn6KFBlRhwAP3
         MlkRLZfoFeJKYvpondQtIWMPgOW6oIVPHBl7/hj8D5rEoDig21PcLvyBKu2UaxZ+P96Q
         YXu/7FvSFCf0TySl0jPVv3dZv2VJcXcHKNDsyUk1z1aG2h380L3J0vZpzykQlOPjOiEK
         9Y0g==
X-Gm-Message-State: AOAM531eIzcHXehKwNiPARwXIjPzXrfb7aXEBZvdIIfqGiLgyaffqIsG
        yqORHNJYzcoVqJmyFNJhnNosRmw7d70=
X-Google-Smtp-Source: ABdhPJzZ3LFDB6Uir2SQ7S1tkMBr3O+egUpNbCSP8eM7rj0K2CghcAf/IzTKvZdIEwebrnFUUf37/g==
X-Received: by 2002:a65:5b0d:: with SMTP id y13mr5405568pgq.213.1607045212123;
        Thu, 03 Dec 2020 17:26:52 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.50])
        by smtp.gmail.com with ESMTPSA id y20sm3009604pfr.159.2020.12.03.17.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 17:26:51 -0800 (PST)
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
Date:   Fri, 4 Dec 2020 09:26:49 +0800
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

Thanks, in the large-market scenario, if we deal with all groups,
the system_zone will be very large, which may reduce performance.
I think the previous method is good, but it needs to be changed
slightly, so that the fault tolerance in the meta_bg scenario
can be improved without the risk of performance degradation.

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
> 
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
