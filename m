Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC22D41D8
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 13:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgLIMNT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 07:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgLIMNF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 07:13:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CDC0613CF
        for <linux-ext4@vger.kernel.org>; Wed,  9 Dec 2020 04:12:25 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e2so1072476pgi.5
        for <linux-ext4@vger.kernel.org>; Wed, 09 Dec 2020 04:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NFoV48DItfTTe3SlF6RZFxdLYtsBvjBxtHZVolQR/zQ=;
        b=HocdRK1o4oPkHn0GsDEqQwy1rU5NgdGZhWJSyyUjdpbmnjuxfSLmJoJFgP4FEEPkNj
         54wcq/g94vnXg7SSaqXC23dbpR3ZHgDbTKEbemEWDOrDE+J6LVzaE8nVEEx/vwNZyLuv
         wDhU2phhqibQo1g6lwjWZMGZW5DSr8QhZW0CkG+LVdNge/tTimjaV0DqoWr+3Uynim7N
         MNB4AkbDkfQgPExwJkKk9KIMyj/awFEC3jSK+NlSQtj5I5quJ5tId8yEtpy7+ggkAF3k
         1w2WLwdgPLn8exwumle6h82T/4Gcl5DjZGOXN6sH/IYI7l74CJcophzBZqTbhNZDHlrF
         uDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NFoV48DItfTTe3SlF6RZFxdLYtsBvjBxtHZVolQR/zQ=;
        b=Tg9nORIb4IOYDRFd77VpZX+jxkqjKXPoT0EhbR7QGG1epS4L2ybS5JALDWzhIx6+E7
         vbHL4abqQg7RgykRUNlIunJUnM4qTSl1unneuTInmLvjrOb90SA7VllJvz/6ny0j4cRf
         Ewxco4sV9UhK1CFYhCjijwjz3xbypTifCpJjuNF2g9bs4WS8IDUfUsDDYRFc0l7oege4
         f2F25QSO8hHL+EVPCf2tNhtuIZeEcXCgr67batsidFn8U1t5yipglE1Ii0EaHHu8LGfp
         s12Fk4As+hmwbilgma8Ih6gN8R/Mi2i7EhAQ9fp74bUHq4HZ1V/K3wrjIudz6B7ghRFe
         4iUQ==
X-Gm-Message-State: AOAM530/kRF/Gj3CKVwcLfauyLlAXe1WBN1bcqwHYHtAZAnusYtvuzTH
        k7uOy32/ycYO+obs1ySP3bJ2li83fxk=
X-Google-Smtp-Source: ABdhPJyBta6Io9I6sFc/IXdlSbwLivMvBZLwB0ln8azluf7q5F1/Yd+qpFkRQYGweQRxO3ows5Unag==
X-Received: by 2002:a63:545f:: with SMTP id e31mr1698775pgm.327.1607515944869;
        Wed, 09 Dec 2020 04:12:24 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.51])
        by smtp.gmail.com with ESMTPSA id 129sm2486868pfw.86.2020.12.09.04.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 04:12:24 -0800 (PST)
Subject: Re: [PATCH 6/8] ext4: add a helper function to validate metadata
 block
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-6-git-send-email-brookxu@tencent.com>
 <20201209045515.GH52960@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <4c5f69c0-31b3-9709-aa0e-713012a15934@gmail.com>
Date:   Wed, 9 Dec 2020 20:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201209045515.GH52960@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Theodore Y. Ts'o wrote on 2020/12/9 12:55:
> On Sat, Nov 07, 2020 at 11:58:16PM +0800, Chunguang Xu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> There is a need to check whether a block or a segment overlaps
>> with metadata, since information of system_zone is incomplete,
>> we need a more accurate function. Now we check whether it
>> overlaps with block bitmap, inode bitmap, and inode table.
>> Perhaps it is better to add a check of super_block and block
>> group descriptor and provide a helper function.
> 
> The original code was valid only for file systems that are not using
> flex_bg.  I suspect the Lustre folks who implemented mballoc.c did so
> before flex_bg, and fortunately, on flex_bg we the check is simply
> going to have more false negaties, but not any false positives, so no
> one noticed.
> 
>> +/*
>> + * Returns 1 if the passed-in block region (block, block+count)
>> + * overlaps with some other filesystem metadata blocks. Others,
>> + * return 0.
>> + */
>> +int ext4_metadata_block_overlaps(struct super_block *sb,
>> +				 ext4_group_t block_group,
>> +				 ext4_fsblk_t block,
>> +				 unsigned long count)
>> +{
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	struct ext4_group_desc *gdp;
>> +	int gd_first = ext4_group_first_block_no(sb, block_group);
>> +	int itable, gd_blk;
>> +	int ret = 0;
>> +
>> +	gdp = ext4_get_group_desc(sb, block_group, NULL);
>> +	// check block bitmap and inode bitmap
>> +	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
>> +	    in_range(ext4_inode_bitmap(sb, gdp), block, count))
> 
> We are only checking a single block group descriptor; this is fine if
> the allocation bitmaps and inode table are guaranteed to be located in
> their own block group.  But this is no longer true when flex_bg is
> enabled.

 Right, the check of bb and ib here is not very correct.

> I think what we should do is to rely on the rb tree maintained by
> block_validity.c (if the inode number is zero, then the entry refers
> to blocks in the "system zone"); that's going to be a much more
> complete check.
> 
> What do you think?

This is a good idea. After we merge ext4: add the gdt block of
meta_bg to system_zone, the metadata information of system_zone
is relatively complete. Using system_zone makes the logic
clearer. However, due to the need for additional tree search,
there is a performance risk. I will try this method later and
test the performance overhead.

> 						- Ted
> 
