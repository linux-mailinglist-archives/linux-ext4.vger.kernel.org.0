Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9229342D
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 07:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbgJTFDr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 01:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391577AbgJTFDr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Oct 2020 01:03:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A06C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 22:03:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w21so481874pfc.7
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 22:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vo7+pXqb39FGRcWB0FSvO6F1GW876k2QxHPATN5jvSM=;
        b=JHhlJZxX7feFSN/ougwkdDFOmklZzTY8PnTqx/uFrfMCF4x2bV+n7EjOq+DPFfhvwm
         NPxMDkCTTtYrTd182GhnTYiN5+vRWED461jGDo14WKbl3qirApKo3C4UAl4eSxeB6WF+
         992IlMJZUoJj+wzjQxR2dxfe4Ytj57cdYBN4g7PUIUWrfHNRiJbJrfHg8AhG2YywKwI7
         CDu5GFrTAr3tazkALkZloFmODyZu3vT3W3J2s9sYJ+lHwgG8lRcycJQ2AloSnwTCsy6M
         HnbM4W2LlG0CY5par7dPRXR+8JTU8jmvRBrHsdb2J1N/fr5r77DBnys+f4YZp0brt0C5
         GVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vo7+pXqb39FGRcWB0FSvO6F1GW876k2QxHPATN5jvSM=;
        b=nSmD1AcmxAyHpurzyzHwA/RKMb9t1zqZvdB4Dk953GZP/oZhfgX+2tEP8k2PmViGvD
         E/Cf5xN4imXg2sQeAMNzBeLP+uWnLQM4BU17Cd1dqkkNPK0YKalYtCYqUFbxndlS8j8k
         P5zntaTK0H5/tMkJYeRLQfW3nQlUp+ER/ixULGKAvqFQ7QDyps9OA6XAUy+h13/MEXZD
         cWfQwMozmOH9fes+o+MUW4GCd2X4ByDp8mGOrXg3hKnDnLM3CevGWtfgJo1r5PNdnomu
         zNImZDA0thwlp5zEmThYHUSuPM8f0lIv9ROCFOh1z9wk3dHuLM9iMD8mF4qZFPDxz7q2
         VyHA==
X-Gm-Message-State: AOAM532fp8Oxm71U1mRpgQYH8GCwbHvMBU95XtYgyfX2A+UXtz1B/jGf
        Ra0g+HOq/JVDS0S3u8Wyo9V948z2fcs=
X-Google-Smtp-Source: ABdhPJzA22vjffrLL23r+JddFp9G7NybOnKfEjPXat0C1SdhRtKvHjL5xX8F/Vbp+eHkzSNGnc/rcw==
X-Received: by 2002:a65:4bcb:: with SMTP id p11mr1184976pgr.253.1603170224976;
        Mon, 19 Oct 2020 22:03:44 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.65])
        by smtp.gmail.com with ESMTPSA id m9sm520812pgr.23.2020.10.19.22.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 22:03:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] ext4: use ASSERT() to replace J_ASSERT()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
 <849873AE-1880-45D6-B987-C5DD42967D4D@dilger.ca>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <b9c6851c-7b0f-6b22-fa4c-5e620df55a41@gmail.com>
Date:   Tue, 20 Oct 2020 13:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <849873AE-1880-45D6-B987-C5DD42967D4D@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your reply.

Andreas Dilger wrote on 2020/10/20 11:37:
> On Oct 19, 2020, at 3:02 AM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
>>
>> There are currently multiple forms of assertion, such as J_ASSERT().
>> J_ASEERT is provided for the jbd module, which is a public module.
> 
> (typo) "J_ASSERT()"
Thanks, I  will Fixed that.

>> Maybe we should use custom ASSERT() like other file systems, such as
>> xfs, which would be better.
> 
> My one minor complaint is that "ASSERT()" is a very generic name and is
> likely to cause conflicts with ASSERT in other headers.  That said, I
> also see many other filesystems using their own ASSERT() macro, so I
> guess they are all in private headers only?
I also thought about this before, but even if we define it in a private
header file, because we still include several header files in a certain
file, it seems that the conflict cannot be resolved. However, maybe it
is safest to use a name with ext4 prefix. I will try to fix it in next
version. Thanks.

> Some minor comments/questions below, but not worth changing the patch
> unless you think they are important...
> 
> You can add:
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> 
>> @@ -185,7 +185,7 @@ static int ext4_init_block_bitmap(struct super_block *sb,
>> 	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> 	ext4_fsblk_t start, tmp;
>>
>> -	J_ASSERT_BH(bh, buffer_locked(bh));
>> +	ASSERT(buffer_locked(bh));
> 
> I thought J_ASSERT_BH() did something useful, but J_ASSERT_BH() just maps
> to J_ASSERT() internally anyway.
> 
>> +#define ASSERT(assert)							\
>> +do {									\
>> +	if (unlikely(!(assert))) {					\
>> +		printk(KERN_EMERG					\
>> +		       "Assertion failure in %s() at %s:%d: \"%s\"\n",	\
> 
> (style) better to use single quotes '%s' to avoid the need to escape \".
Thanks, this is a good suggestion, I will fix it next version.

> Cheers, Andreas
> 
> 
> 
> 
> 
