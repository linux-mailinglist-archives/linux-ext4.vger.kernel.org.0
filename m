Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B26FB3A9
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjEHPVO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEHPVO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 11:21:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA7A2
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 08:21:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4000ec74aso31251915e9.3
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683559271; x=1686151271;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlLr3YPSofUAdgq72TaFVtGoYHHp2mBN1aru65dU79w=;
        b=i6Zuf2x8TvQ8MQVOP2VoQSMGD3r4IG4DVxE+oDJSo99xMQRI64K5LkVfEEwU2KbECi
         UG+USgjewDuuZPuFML16vrxt4XYlLOKAVvwemg7OT0V8UnfxEQExL/I0aDcnRk1BZqlM
         5tgFuvhm8QeRZuyqavN1iydTgKsEQKyMS+PM1TvQ/P7IAT6f7EB8O5pJNAeWkyvaVpO5
         /lBOiGte41ITh3d+beSRIc4Jt1LBUMxRn9wz/c5EUJ/3BUILG5BtGDiMPTbQNtl39bOs
         xsLZjGixZHnd51M+ttbgatB4u6ekAAPRQWNSxN5Zzx4SeEUdkrYm32NKefW7YtzBoqZ/
         ZQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683559271; x=1686151271;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlLr3YPSofUAdgq72TaFVtGoYHHp2mBN1aru65dU79w=;
        b=ImNMqqASWU3RDVUARiDKTR77Ry8Ad69j04XPoUV8cVMSabJS2xU4nZYBIzOqexEPGk
         Y4nu3WAysCUQ/26Xu5ZnoKlD0SYEN0coulFHVD/SlqqU7qSBCJjBogE/vbqgMwq8O11/
         lpDHxX4HzCGuIO8v7NVFW2tFgNWISCKwCC0pxb/c00FGwJl7BLl0q2H2NcvS9c+UjJKb
         W/gMom1M42eDKdZVrM83xF7bglsIYP1fxspLJC4gkLYVbOkSa82Th48wfqUVKA9h4FsH
         JYmva6mFPfJOGkPkTAuDM9RC9qM7JSbWnkafKflqmpF5i23biAQLOzVbx5oo8JANQphQ
         nD7A==
X-Gm-Message-State: AC+VfDxAYytLumI8GeEzjzfMAj4e6rjIgqLVIvHoqg/wRXM50nT8UVoi
        2pfuIUgZFI71zJhR51jyPFDgSA==
X-Google-Smtp-Source: ACHHUZ6ZFgl/nDQLUHU9qZXz4+8sBAT8yHIEH7fwMEMMJoAlqteCYu63Q7NPVtlOGgIfSME9DZMdDw==
X-Received: by 2002:a1c:f615:0:b0:3f1:952c:3c70 with SMTP id w21-20020a1cf615000000b003f1952c3c70mr6736017wmc.40.1683559270997;
        Mon, 08 May 2023 08:21:10 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe792000000b002f7780eee10sm11675586wrm.59.2023.05.08.08.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:21:10 -0700 (PDT)
Message-ID: <5734a5c4-9d85-0264-a3c5-60c8e140596c@linaro.org>
Date:   Mon, 8 May 2023 16:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ext4: fix invalid free tracking in
 ext4_xattr_move_to_block()
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com,
        syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com,
        Lee Jones <joneslee@google.com>
References: <20230430160426.581366-1-tytso@mit.edu>
 <d84ff5f8-771e-3f03-bd2d-bc71fec6bd81@linaro.org>
In-Reply-To: <d84ff5f8-771e-3f03-bd2d-bc71fec6bd81@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 5/8/23 11:20, Tudor Ambarus wrote:
> 
> 
> On 4/30/23 17:04, Theodore Ts'o wrote:
>> In ext4_xattr_move_to_block(), the value of the extended attribute
>> which we need to move to an external block may be allocated by
>> kvmalloc() if the value is stored in an external inode.  So at the end
>> of the function the code tried to check if this was the case by
>> testing entry->e_value_inum.
>>
>> However, at this point, the pointer to the xattr entry is no longer
>> valid, because it was removed from the original location where it had
>> been stored.  So we could end up calling kvfree() on a pointer which
>> was not allocated by kvmalloc(); or we could also potentially leak
>> memory by not freeing the buffer when it should be freed.  Fix this by
>> storing whether it should be freed in a separate variable.
>>
>> Link: https://syzkaller.appspot.com/bug?id=5c2aee8256e30b55ccf57312c16d88417adbd5e1
>> Link: https://syzkaller.appspot.com/bug?id=41a6b5d4917c0412eb3b3c3c604965bed7d7420b
>> Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com
>> Reported-by: syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> ---
>>  fs/ext4/xattr.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 767454d74cd6..e33a323faf3c 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -2615,6 +2615,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>>  		.in_inode = !!entry->e_value_inum,
>>  	};
>>  	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
>> +	int needs_kvfree = 0;
>>  	int error;
>>  
>>  	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
>> @@ -2637,7 +2638,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>>  			error = -ENOMEM;
>>  			goto out;
>>  		}
>> -
>> +		needs_kvfree = 1;
>>  		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
>>  		if (error)
>>  			goto out;
>> @@ -2676,7 +2677,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>>  
>>  out:
>>  	kfree(b_entry_name);
>> -	if (entry->e_value_inum && buffer)
>> +	if (needs_kvfree && buffer)
> 
> If buffer is null, no operation should be performed, so we may get rid
> of the buffer check.
> 

I meant that if buffer is null no operation is performed for
kvfree(buffer). Sent a patch on top of yours at:

https://lore.kernel.org/linux-ext4/20230508151337.79304-1-tudor.ambarus@linaro.org/T/#u

Cheers,
ta

> We should also add the Fixes tag and Cc: stable@vger.kernel.org, as the
> blamed commit fixes another bug and it was backported to 4.14+, thus
> this one needs to be backported as well.
> 
> Fixes: 1e9d62d25281 ("ext4: optimize ea_inode block expansion")
> 
> Anyway:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Cheers,
> ta
>>  		kvfree(buffer);
>>  	if (is)
>>  		brelse(is->iloc.bh);
