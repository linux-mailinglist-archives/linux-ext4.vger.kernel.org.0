Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF404DA191
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiCORwE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiCORwD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 13:52:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DD51301
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 10:50:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e3so98546pjm.5
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=dFqS7uhHrUTM31ok9jzJKAUhOPqbKtIWHtjHVRDLFUs=;
        b=kVdOhJBOECZyhUJ5QPGNj1JXTw9cXP0tFFKkcswMksZyOeGoRPQu+42+h5Fy7nD4dI
         x+ACcvFkIrUqbJTo2UytXemBjP4h7KxGCYLjf3sEmOzj3/OyHXYW2Ad0MpsOjXefWlPz
         4E1hiZjs4Ymgm08wCFdMd9pqS281d8f87xWUrsZ2vA1PCCMaCmoorn4mUooA5t1kKdWv
         6rEOoF7oXCY3jQDjr8eaFmVjZl9IOLi25ga/TLOwNplGNItleFr2dGbzk/ggZWsJUhY1
         NtNLnhiWSs63jpdnPeDX2Aat5okQomgvRzOHd1cKKn8bcopbvqJrtUL7riyVAE65YOzy
         lPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=dFqS7uhHrUTM31ok9jzJKAUhOPqbKtIWHtjHVRDLFUs=;
        b=DM3rzlJZn63qT0FzhwbrvGw44O9xXGDXcqeJI6PxhHKGCp3lP4w8qkTnlzT95o4M2Q
         wuTu5TZmFU0ZzJACZgedgAGFOqYfl61qfkalMidwddtzs7hG2EVz2PWNoHje+DUsihA6
         NZBeCjEjO7BpvtOEtOL5C55FEZDMhpjDP2VlDFVlmUm3Bwz6Pg3eYAcTd5H6oKnbvZ7J
         Dnyik2e45iD1+LWhIbyVZWIcDJmWnPA6KXeg0bkA/r5j1R+n12Pf4CRnbO7M/i0CW4Xf
         WWIgrRuBWNMJyhZ4KOUnzOmWtF5Jspv0GyJC0ulu2WQwjrmY0iZfxC2ODC7INlkc6Z80
         z7tA==
X-Gm-Message-State: AOAM5320ehwmoV01lQxo3lFFKuPjN6NywLdU8fWrcDLWQ45Y0bRYzLpd
        OUkCbvg+jQ4C9FL5/xZJQ/SNfw==
X-Google-Smtp-Source: ABdhPJwCjtkRr900bceOFqQvdRoj/zYcaaHsroSwd7PQSQlfJfIwe6gZWcaRjgA6QBYk5ijaroXeHw==
X-Received: by 2002:a17:902:d890:b0:151:6b8b:db0a with SMTP id b16-20020a170902d89000b001516b8bdb0amr29567745plz.15.1647366650715;
        Tue, 15 Mar 2022 10:50:50 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b001c6457e1760sm2672907pjc.21.2022.03.15.10.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:50:50 -0700 (PDT)
Message-ID: <d153bb2e-5f95-47d0-43db-b95c577e2b91@linaro.org>
Date:   Tue, 15 Mar 2022 10:50:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
 <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
 <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
 <20220303145651.ackek7wotphg26gm@riteshh-domain>
 <995d8b3c-44ee-e190-42ae-75f2562b8d6b@linaro.org>
 <20220303200804.hugwhtqovxiutkfd@riteshh-domain>
 <20220307054557.v4qqm4ushmm55v4y@riteshh-domain>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: BUG in ext4_ind_remove_space
In-Reply-To: <20220307054557.v4qqm4ushmm55v4y@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/6/22 21:45, Ritesh Harjani wrote:
> Just FYI - The change which we discussed to fix the max_block to max_end_block, is not correct.
> Since it will still leave 1 block at the end after punch operation, if the file has s_bitmap_maxbytes size.
> This is due to the fact that, "end" is expected to be 1 block after the end of last block.
> 
> Will try look into it to see how can we fix this.
> 
> 1210 /**
> 1211  *      ext4_ind_remove_space - remove space from the range
> 1212  *      @handle: JBD handle for this transaction
> 1213  *      @inode: inode we are dealing with
> 1214  *      @start: First block to remove
> 1215  *      @end:   One block after the last block to remove (exclusive)

So in that case, in ext4_punch_hole(), what should be done is:

if offset + length > sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize

it either needs to update the length to:
length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize - offset;

or -ENOSPC should be returned, which would be more consistent with the `man 2 
fallocate`:

"ERRORS:
...
  ENOSPC There is not enough space left on the device containing the file 
referred to by fd."

Please let me know if my reckoning is correct, and if so which option you
prefer and I will follow with a patch.

-- 
Thanks,
Tadeusz
