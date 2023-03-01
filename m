Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AC6A6BCB
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCALhZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCALhY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 06:37:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5B2FCE5
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 03:37:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d30so52547961eda.4
        for <linux-ext4@vger.kernel.org>; Wed, 01 Mar 2023 03:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677670642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILqP9JaynhHBwPJ20FgojHiwm2UE6OMpf0+hJUlUpUE=;
        b=IRON5pELOnYTwC6medrpi0oj7p738+1pKaLtmbt54GdDIrNTndeF+R2wNBQhFwxH9X
         kSXSsLQ665bfemVTSlnewc054ZPa+AXF5xID/boXXoyR0hwphO+pkm1lSZe1uQH1j2+U
         e2nSpnDeUDrcYcDw7y7BAKLD9giqkqTSIIavMIjE8LsiMbo0OZa21ApfOX6LdwoUEoHp
         khA8Y4d0kA1T3Pxwrc9GQ2x5FJBoli4PmWy1wcA2Iz56tpxHfmC1gTOKWakrq1utTFJ0
         vqi2+xnhBBqy2BbMycTI6FTZdwqYE7koqZRBdGMV6hzSmt+DGGk196BApkhToRsde8/N
         mzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677670642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILqP9JaynhHBwPJ20FgojHiwm2UE6OMpf0+hJUlUpUE=;
        b=3HPXKI3dP5/UTTrP4+5g34jVjh6Mlm84k7V6EhAte457rUWKiwvfiQlSFJEtwPtdVa
         6103nW1EtKcbbc2YMdEyV7/21AoNL87nOExXQ0KlaW7XH23l9aUfYNZ+ADWOWXyoMduM
         zvJi1AjlQkj50jEKpYAe9Rx+WhStS7+bt60XNkd7oypQPq+5qWclkxIaFDH2I/sgNGc0
         ggI8KYZq95AfGOWujQhmNvJJyv1KKtUgLV7Hsc9cMsVJtQsIRSMA8Kklccyli5x2dgq0
         CAbXasYp+6AiZwsaL2urvV9xEmkqidHGeX50RBubR/wIL394e9PJQ4IayJFDLPZOHpkV
         P/Dg==
X-Gm-Message-State: AO0yUKUSi9nhMd9MCE6YC3NBXvhShTeubOQ2qqp3j6ag8dlk8OXW3X1F
        1557sEU1XJAk89AwxaSy9I3f+3j9GIXZwAYaYP4=
X-Google-Smtp-Source: AK7set+GlisWBkApY0lPbaSLVubH29AwZs/YD/vcXnU+9BwISblJe3y1JGzj1xVbVgHvFDN9kgA0QA==
X-Received: by 2002:a17:906:68da:b0:8af:2fa1:5ae5 with SMTP id y26-20020a17090668da00b008af2fa15ae5mr5693036ejr.53.1677670641879;
        Wed, 01 Mar 2023 03:37:21 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id v13-20020a1709064e8d00b008e3bf17fb2asm5783415eju.19.2023.03.01.03.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 03:37:21 -0800 (PST)
Message-ID: <d2a5be55-4bcb-da7e-fae5-9cc598223b17@linaro.org>
Date:   Wed, 1 Mar 2023 11:37:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] ext2: Check block size validity during mount
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Cc:     syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
References: <20230301111026.15102-1-jack@suse.cz>
 <20230301111238.22856-2-jack@suse.cz>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230301111238.22856-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On 3/1/23 11:12, Jan Kara wrote:
> Check that log of block size stored in the superblock has sensible
> value. Otherwise the shift computing the block size can overflow leading
> to undefined behavior.
> 
> Reported-by: syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com

Would be helpful to also have:
LINK: https://syzkaller.appspot.com/bug?extid=4fec412f59eba8c01b77
a "Fixes:" tag and
Cc: stable@vger.kernel.org

Cheers,
ta

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/ext2/ext2.h  | 1 +
>   fs/ext2/super.c | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 6c8e838bb278..8244366862e4 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -180,6 +180,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
>   #define EXT2_MIN_BLOCK_SIZE		1024
>   #define	EXT2_MAX_BLOCK_SIZE		65536
>   #define EXT2_MIN_BLOCK_LOG_SIZE		  10
> +#define EXT2_MAX_BLOCK_LOG_SIZE		  16
>   #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
>   #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
>   #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 69c88facfe90..f342f347a695 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -945,6 +945,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>   		goto failed_mount;
>   	}
>   
> +	if (le32_to_cpu(es->s_log_block_size) >
> +	    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
> +		ext2_msg(sb, KERN_ERR,
> +			 "Invalid log block size: %u",
> +			 le32_to_cpu(es->s_log_block_size));
> +		goto failed_mount;
> +	}
>   	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
>   
>   	if (test_opt(sb, DAX)) {
