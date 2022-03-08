Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2BC4D1F8F
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 18:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiCHR7t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 12:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiCHR7t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 12:59:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A931209
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 09:58:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so2292705pjd.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4XioSStp2t+dBCfYd1EpGILjRD3W6ozQmbqKvHcXZ+o=;
        b=zcG+lG7pnMs9K3TfyHxJ/3SrGwTFn/IX6uM9Ard3OtshulZ9jr3+Nu/OHwX4OczRSN
         Jvxs3hO8xFMGy7BMJ100jmWKj46lPzmhOfwWPqmv0eb84n++xlO2ORV9c8Z9+McIoNoS
         Q0Ht2Dw930P/wyQ1O1l6ck58RQMSfFUSQZBv+1GDfZu5jrkZ4yOLwr5Q1Jm3O5Enm2yR
         HVlNYrG/O9URPVWioGpXfNJxdJSMD31ioFM7tgSMDI7cc4AQFm9NiDmm6/vo3xxQgRxr
         KFt2fzJLX2h6VFQNAPxqbDx7ZKOV1m7Ti5aBcMdbH7JqZLAL7c4Eskqjotfwa2xaud0g
         6G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4XioSStp2t+dBCfYd1EpGILjRD3W6ozQmbqKvHcXZ+o=;
        b=4xp5ea49ocGE5LQcsXnnTTSHRfAFssyFg4ecOKDqSYo2i4BYYNH3+OHbo3eAjSZ0y/
         iVs37nV13gMB1j6P/VjhAcnMlQcQlTDcerb68LFPORmR8CnKuojtsKZnR0Vc28N0Fc9j
         h15SDrT9eDhwP8mxhmzHHCECm2SwqADDvE8RHao/JbThNQ86Zz7hNJNMSzMmWfbFTlRn
         yX3LxFTKcOTCinnw3uByFK76i1eFEdv+fvcIfNRX9iqgelBQfME3Mp8BSvU23Mp9ADJs
         gGwJ982/1wvX3LtPyDCWXGAXGtV/gv1hJkFfvODalsGEfoKTJqVglghArB00Lx1pUinD
         a7wA==
X-Gm-Message-State: AOAM533mt0UCQp7QBBb6I9qaFrbSk+kGU83x3z45xKbwlIWjDydFRbbo
        dkc85uWUIoPgAXcc7DdlEIQtxg==
X-Google-Smtp-Source: ABdhPJypPeog7mP9z+ekOnFO58FrxR8mVY95qOKmqwI6aAy+NN6S986J00PqQzSFFbYKHXLIGHqplw==
X-Received: by 2002:a17:90a:d3d3:b0:1bf:2e8d:3175 with SMTP id d19-20020a17090ad3d300b001bf2e8d3175mr6126125pjw.2.1646762330552;
        Tue, 08 Mar 2022 09:58:50 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001bce781ce03sm3581460pjp.18.2022.03.08.09.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:58:50 -0800 (PST)
Message-ID: <3a901543-60cf-6658-cb9f-45e567ae2151@linaro.org>
Date:   Tue, 8 Mar 2022 09:58:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: BUG in ext4_ind_remove_space
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
In-Reply-To: <20220307054557.v4qqm4ushmm55v4y@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> On 22/03/04 01:38AM, Ritesh Harjani wrote:
>> On 22/03/03 07:37AM, Tadeusz Struk wrote:
>>> On 3/3/22 06:56, Ritesh Harjani wrote:
>>>> On 22/03/02 03:14PM, Tadeusz Struk wrote:
>>>>> On 2/25/22 11:19, Tadeusz Struk wrote:
>>>>>>> I can verify this sometime next week when I get back to it.
>>>>>>> But thanks for reporting the issue :)
>>>>>>
>>>>>> Next week is perfectly fine. Thanks for looking into it.
>>>>>
>>>>> Hi Ritesh,
>>>>> Did you have chance to look into this?
>>>>> If you want I can send a patch that fixes the off by 1 calculation error.
>>>>
>>>> Hi Tadeusz,
>>>>
>>>> I wanted to look at that path a bit more before sending that patch.
>>>> Last analysis by me was more of a cursory look at the kernel dmesg log which you
>>>> had shared.
>>>>
>>>> In case if you want to pursue that issue and spend time on it, then feel free to
>>>> do it.
>>>>
>>>> I got pulled into number of other things last week and this week. So didn't get
>>>> a chance to look into it yet. I hope to look into this soon (if no one else
>>>> picks up :))
>>>
>>> I'm not familiar with the internals of ext4 implementation so I would rather
>>> have someone who knows it look at it.
>>
>> No problem. I am willing to look into this anyways.
>> btw, this issue could be seen easily with below cmd on non-extent ext4 FS.
>>
>> sudo xfs_io -f -c "truncate 0x4010040c000" -c "fsync" -c "fpunch 0x1000000 0xffefffff000" testfile
> 
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

Hi Ritesh,
Thanks for update. Let me know if I can be of any help to you.

-- 
Thanks,
Tadeusz
