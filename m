Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E907823C831
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgHEIvk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 04:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEIvh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Aug 2020 04:51:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C032C06174A;
        Wed,  5 Aug 2020 01:51:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so19532952plz.10;
        Wed, 05 Aug 2020 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DFx0cJ/Suyk8QZwdKixb4htVgkqN4pjcMvUDuig6W+o=;
        b=p04w9bd/tDSWqQXWkmweeQN10jIzDJOkbxNxoyFeXmWLDtXCNB/Q1u6rbq3EC9Nl0l
         OS6G4oHVxhMXz1bO3pCmShOaIrL9SptPiSYvFuN4VGW6Aw73OIQZ0nPmsiYnV0ZOtoHQ
         j6QDFsJtPfZM0TBRCThxBo2cNySJ2VuCTSVrU2AgVJbUn4k6bh6viR2NmyvO6jjyGMWr
         AXeLP+j2O7KOO0Za6dq4PU0/HiUranl4WsjjNvBPCTJA11bDJhp/wiYpPyqBfE++b8zU
         dLgOxRyyUtG9alqmcV0zys9N63KpH161IN71RPA89mTUzfKJtTgF2so62yoz1/9RMVCh
         6aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DFx0cJ/Suyk8QZwdKixb4htVgkqN4pjcMvUDuig6W+o=;
        b=RhucJ73U5uDTw+eorvPb+NTEnKy95+KZjR/+XdZmjwNSXo+ONDVETgHzRM+UIrkr4v
         4KFucUYS+zlghzoYtK785Nc3Hs8SC74EO0cnSDf66i3h0nt/dI8MRDc9sYnZ55MQD3Eo
         u240jIOGE+2rvhg0GwMHA+ihRyKUkZNTorko53xBtOMOFz351rJ1l6SiKetITms0nPlA
         6savPTV035UwEIEf+ZSBp5qZae/l34wxrYIxmm7shi7mFDDgJwoHo/jdBrd2PwvRUh2w
         wOIgEoKbXpMuJYmjTfpmatePtxW2Jnxk9qmmybfjT6HPHhNxPBBwiaxuk7OilSRVk0J0
         FK0Q==
X-Gm-Message-State: AOAM530WOkO8cAQj2M3uYg2OAQQeeD2c32o+vzKDRfNMscF1UUwD8BjS
        zQOCv2YQiK8u6VtYGFtUHQJ8SpGBBGU=
X-Google-Smtp-Source: ABdhPJx1LwDBzKZfX+ojW+hZLoZsFkRX0qW2gLks+KgYmBAn8ZreGHBdUyJI5EMlDVqCQ7vj8swWAw==
X-Received: by 2002:a17:90b:a45:: with SMTP id gw5mr2174261pjb.80.1596617496594;
        Wed, 05 Aug 2020 01:51:36 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.45])
        by smtp.gmail.com with ESMTPSA id c132sm2598592pfb.112.2020.08.05.01.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 01:51:36 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] ext4: add needed paramter to
 ext4_mb_discard_preallocations trace
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <34718b7d-9e0c-e8a9-cdef-9150fc5edab8@gmail.com>
 <18DB2B7A-FAFE-4DD8-BD5D-85873F9ECC54@dilger.ca>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <6f2a96a7-5b26-3302-568f-c341a2c20a32@gmail.com>
Date:   Wed, 5 Aug 2020 16:51:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <18DB2B7A-FAFE-4DD8-BD5D-85873F9ECC54@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, this is a good suggestion, and I will merged this patch with the previous patch.

Thanks

Andreas Dilger wrote on 2020/8/5 12:54:
> On Aug 4, 2020, at 7:02 PM, brookxu <brookxu.cn@gmail.com> wrote:
>> Add the needed value to ext4_mb_discard_preallocations trace, so
>> we can more easily observe the requested number of trim.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> IMHO, this should be part of the previous patch that is changing the
> API for ext4_discard_preallocations().
>
> Cheers, Andreas
>
>> ---
>>  include/trace/events/ext4.h | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
>> index cc41d69..61736d8 100644
>> --- a/include/trace/events/ext4.h
>> +++ b/include/trace/events/ext4.h
>> @@ -746,24 +746,26 @@
>>  );
>>
>>  TRACE_EVENT(ext4_discard_preallocations,
>> -    TP_PROTO(struct inode *inode),
>> +    TP_PROTO(struct inode *inode, unsigned int needed),
>>
>> -    TP_ARGS(inode),
>> +    TP_ARGS(inode, needed),
>>
>>      TP_STRUCT__entry(
>> -        __field(    dev_t,    dev            )
>> -        __field(    ino_t,    ino            )
>> +        __field(    dev_t,        dev        )
>> +        __field(    ino_t,        ino        )
>> +        __field(    unsigned int,    needed        )
>>
>>      ),
>>
>>      TP_fast_assign(
>>          __entry->dev    = inode->i_sb->s_dev;
>>          __entry->ino    = inode->i_ino;
>> +        __entry->needed    = needed;
>>      ),
>>
>> -    TP_printk("dev %d,%d ino %lu",
>> +    TP_printk("dev %d,%d ino %lu needed %u",
>>            MAJOR(__entry->dev), MINOR(__entry->dev),
>> -          (unsigned long) __entry->ino)
>> +          (unsigned long) __entry->ino, __entry->needed)
>>  );
>>
>>  TRACE_EVENT(ext4_mb_discard_preallocations,
>>
>> --
>> 1.8.3.1
>>
>
> Cheers, Andreas
>
>
>
>
>
