Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFD4D8EA5
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Mar 2022 22:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiCNV3F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Mar 2022 17:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCNV3E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Mar 2022 17:29:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970F273B
        for <linux-ext4@vger.kernel.org>; Mon, 14 Mar 2022 14:27:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f8so16236771pfj.5
        for <linux-ext4@vger.kernel.org>; Mon, 14 Mar 2022 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=HCriX2r0BZeSwYB+dRgFzfFxov4MsbNh1fIV9bebLLs=;
        b=i6T95fAyavJc86SWyV1s+HPzwfPGnTpsZtJTdt6i0zwAOVXI4BfH389f5ZBEdbj25Z
         jIVz/6Jp24dYDQrONc/kmnWLQBbSKZxb1/I4Y5tEpjUeH+sgR/3DQ3O3ltDF4kTdbyhJ
         h/LEYE34YcLkdhY0+c3wxv/cvYVom2PXOnr33AbKNZ2vkIZHVhng+Tllmzp6tnDQDYC9
         JdiIfrp3j4deq/SOhV8QLJNInrFSE4zYzADdzl4igc3xE9F5wEGq+Ktpb8TTnie5GxxN
         FnkpRGr99Q68Ytur4rKJR2dA/KL/SZ9ZCLzU4IFYY/QIQM9wd0i8dhzXs4lc0c9tiYXn
         N2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=HCriX2r0BZeSwYB+dRgFzfFxov4MsbNh1fIV9bebLLs=;
        b=PUlzaI0CkgihtabylIElVAcBAYLNls9Vg5SgYQyAe2I9w6sjwxhYJ4nCMEZiOjsnQb
         2yV8lkKK4jZQKFv39c1k3njmbzMpOaogKgHod0rEQDW/mBomnBMT02dxUkhJu3zty89E
         nc+BmzT7xv4SAZ7kYd3iAxhpv5cUW/o9w/mGtvHw7JKANPFljfqgZmdW5oyguHV8d+An
         drwKG+S0WdUOlluM1Haaxjb04aoN6lUVt4tdiTyQTCkDFCorvliBLcLGI/JmewUN/tkg
         3TjGmvf6dT55r2TtOyiFqpCD8bNFWSGziv3vv3F4daA0aurda7q3HCc9p6uS7D8hQTE1
         kFdw==
X-Gm-Message-State: AOAM531trTXbVotwA9AxwhfdQ/eJdIxj4vdth9h+aniW0ne6Xxr7mDvf
        X5OTdP6XmC/mDQiOEFCORJTCQA==
X-Google-Smtp-Source: ABdhPJyRMHz3mbU+tCTSvZk5MJjnYI/+rqSKXzlBI6kwoMy70SIkklwfLyvTEtoz4O/6syjzVyCFpg==
X-Received: by 2002:aa7:88d5:0:b0:4f7:7fbd:c653 with SMTP id k21-20020aa788d5000000b004f77fbdc653mr22260979pff.41.1647293272830;
        Mon, 14 Mar 2022 14:27:52 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm437256pjb.16.2022.03.14.14.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 14:27:52 -0700 (PDT)
Message-ID: <843601c0-2c87-d848-c876-bef65bfc6d98@linaro.org>
Date:   Mon, 14 Mar 2022 14:27:51 -0700
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
> 1216  *
> 1217  *      Free the blocks in the defined range (end is exclusive endpoint of
> 1218  *      range). This is used by ext4_punch_hole().
> 1219  */
> 1220 int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
> 1221                           ext4_lblk_t start, ext4_lblk_t end)
> 
> -ritesh

Hi Ritesh,
I tried to bisect it and went as far back as 4.4 and the issue still triggers there.
I couldn't build anything older than that with my compiler, but I suspect that
the issue exists even before 3.0 where ext4_fallocate() has been introduced.

-- 
Thanks,
Tadeusz
