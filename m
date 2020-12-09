Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44AE2D415B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgLILtI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgLILtC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 06:49:02 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75162C0617A6
        for <linux-ext4@vger.kernel.org>; Wed,  9 Dec 2020 03:48:13 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id p4so872735pfg.0
        for <linux-ext4@vger.kernel.org>; Wed, 09 Dec 2020 03:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mtb5OPTwUpFzeHbPN9TpmTd1/voU4iC6gRA12yXTX7w=;
        b=Ddqqdooke6uoZebPACRRlwpkJuKsPcBqdCKjbwhvD5sZzGIhEUZLxJqc/TkPT+k4WG
         YHkam0T0viogxCex2uJLDdtG/ccFXq+RkH/xaMiohqnU0Vz/n9zqF3QkCXFaHkxEmAIU
         GQMa1kG07D6lQ9f0j/A7p60EonmSnB3FS8McEEduS/x4aBuMhg7XZNV7ryHxYoKatJPH
         wNXlZkckaHa1X+lIQyR9q5HQvYKkj/L/eKyUhMGBIIcOKNZVoWOVDt6eUDmbUej+wncR
         0MqmgvHuNY9q/AVnZTc/JW+dsqtFkXWBLwsM1/swwq/Yi1hqmY/FIaUN4w1sMDEyEZov
         tYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mtb5OPTwUpFzeHbPN9TpmTd1/voU4iC6gRA12yXTX7w=;
        b=PBhkt53sLfzVIpcErzvX91SiEn+BmQEq5KWTnjwgr54L/C+x+2I3M/DQuTMMQJKXBy
         VBKkzcU1TIphsG+98crCYdhkEteyJFR70oH/1ljFnHBkZoUFvVU9JElG2IiS05WoNlK6
         UXITG4pmMaZxv66D/R+OB7wr5zvhQfG0HKarq259zyAcyRj2ZgtDaDbrHy/kkd1vyleD
         WBpYrjDDEBAXMyuT0+PEFk/sx0lOVAUoEc4cA0HTRmikaXcrBOFtEOHVmwYUKP1u0+5h
         Z/r5HxST/8vUFdAPW4CCh2ZS7H14n8nA9oJvBfF8H2rWARGiuwUTODG04A63QxSWZ2RI
         4iTQ==
X-Gm-Message-State: AOAM531fOj5HG55eZXUB/QJRYiGab4QZd3XQlcEjakYXL+R+EKaiaIhG
        20XSVJpRfeevYI9dZnUmrGoWFQUTd/E=
X-Google-Smtp-Source: ABdhPJxDtsJ6pT9YLV1AoxZixgIC915jvIT/y1BO4hCg8+9cXWlCHrbEaL7wVhkJUVEnLVL9rZvCeg==
X-Received: by 2002:a63:2805:: with SMTP id o5mr1602266pgo.339.1607514492842;
        Wed, 09 Dec 2020 03:48:12 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.51])
        by smtp.gmail.com with ESMTPSA id p6sm1969503pjt.13.2020.12.09.03.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 03:48:12 -0800 (PST)
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
 <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
 <20201209043415.GG52960@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <dd6c2921-1397-4b1a-5a20-23956f9cf956@gmail.com>
Date:   Wed, 9 Dec 2020 19:48:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201209043415.GG52960@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Theodore Y. Ts'o wrote on 2020/12/9 12:34:
> On Fri, Dec 04, 2020 at 09:26:49AM +0800, brookxu wrote:
>>
>> Theodore Y. Ts'o wrote on 2020/12/3 23:08:
>>> On Sat, Nov 07, 2020 at 11:58:14PM +0800, Chunguang Xu wrote:
>>>> From: Chunguang Xu <brookxu@tencent.com>
>>>>
>>>> In order to avoid poor search efficiency of system_zone, the
>>>> system only adds metadata of some sparse group to system_zone.
>>>> In the meta_bg scenario, the non-sparse group may contain gdt
>>>> blocks. Perhaps we should add these blocks to system_zone to
>>>> improve fault tolerance without significantly reducing system
>>>> performance.
>>
>> Thanks, in the large-market scenario, if we deal with all groups,
>> the system_zone will be very large, which may reduce performance.
>> I think the previous method is good, but it needs to be changed
>> slightly, so that the fault tolerance in the meta_bg scenario
>> can be improved without the risk of performance degradation.
> 
> OK, I see.   But this is not actually reliable:
> 
>>>> +		if ((i < 5) || ((i % flex_size) == 0)) {
> 
> This only works if the flex_size is less than or equal to 64 (assuming
> a 4k blocksize).  That's because on 64-bit file systems, we can fit 64
> block group descripters in a 4k block group descriptor block, so
> that's the size of the meta_bg.  The default flex_bg size is 16, but
> it's quite possible to create a file system via "mke2fs -t ext4 -G
> 256".  In that case, the flex_size will be 256, and we would not be
> including all of the meta_bg groups.  So i % flex_size needs to be
> replaced by "i % meta_bg_size", where meta_bg_size would be
> initialized to EXT4_DESC_PER_BLOCK(sb).
> 
> Does that make sense?
Maybe I missed something. If i% meta_bg_size is used instead, if
flex_size <64, then we will miss some flex_bg. There seems to be
a contradiction here. In the scenario where only flex_bg is
enabled, it may not be appropriate to use meta_bg_size. In the
scenario where only meta_bg is enabled, it may not be appropriate
to use flex_size.

As you said before, it maybe better to remove

	if ((i <5) || ((i% flex_size) == 0))

and do it for all groups. 

In this way we won't miss some flex_bg, meta_bg, and sparse_bg.
I tested it on an 80T disk and found that the performance loss
was small:

 unpatched kernel:
 ext4_setup_system_zone() takes 524ms, 
 mount-3137    [006] ....    89.548026: ext4_setup_system_zone: (ext4_setup_system_zone+0x0/0x3f0)
 mount-3137    [006] d...    90.072895: ext4_setup_system_zone_1: (ext4_fill_super+0x2057/0x39b0 <- ext4_setup_system_zone)

 patched kernel:
 ext4_setup_system_zone() takes 552ms, 
 mount-4425    [006] ....   402.555793: ext4_setup_system_zone: (ext4_setup_system_zone+0x0/0x3d0)
 mount-4425    [006] d...   403.107307: ext4_setup_system_zone_1: (ext4_fill_super+0x2057/0x39b0 <- ext4_setup_system_zone)
> 
> 						- Ted
> 
