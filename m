Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82EB7AF9EB
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 07:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjI0FSl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 01:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjI0FRz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 01:17:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979B76B3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 22:02:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60778a3bfso61623825ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695790937; x=1696395737; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asDSvXTBaML2VDZc7fHbaEdRp1jCKeoaGbaT8C4xT78=;
        b=KLbAu0UwcORdwCmCCzDRAMBRWUC7vKXxSBG+uZ3V+rWqgYFbfRi3t/ift2AmNIruQj
         nsZA6ZWna4yl6gryU0jakzmtahsJXjUgrS2bhRvSSUq+ThCukWLlIBXuGeIF+mT3je+M
         +u/aPVKKR+nCnf3soHDZHNfhwnA8+hvSf/arV2ZMTvg8TCE8SQYKMdnQmBJBTaxZ4CLb
         yirXkiuep3Gqs0Ybp1Z6MHc4KRPae0YCyJN2Wcuorocyf10Q1kMj24jUTn+0JC/xWrvj
         ntG9l1oA//JDF7dC6jMtApbI6B6OJbggdUSVjWiBCsZVUAYfg3XE/TvArYzqF7G/9AoJ
         tmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695790937; x=1696395737;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asDSvXTBaML2VDZc7fHbaEdRp1jCKeoaGbaT8C4xT78=;
        b=BkNm+TpuzYFev5ENnOLXT7He1zy0gu1W1f3IowFAOFjaIboz8k8SghelqFjDSBX0fO
         l9GOkjyGn7hC7xs6BE0svzVWxUcDZLkG3TltTxGF1lLHfBfFnpomD+S5LbX4M6yuW9He
         MUsnsAas9IhVna5IN65lq3T2mi+MdqeW9capsxXB0RbB74XBX6kupQJBx5B8HErqIWN0
         vvBPJu/KUBUT0pPZL1UNbGYByRh/jZTYwqLrRTX03VnmxxWC1s4pbNWCiHgPGSzAe/Qw
         FDw8iBMP8oc5FHh4QAy9YeBoxJ5U5isFaQQ0O/FW43YDYsrjHLMqjTy0vXG55nloPaL/
         JEDw==
X-Gm-Message-State: AOJu0YyVhQk2zLuTrWlUh/Cj3gYTgEmZ5ltR1g5labdVoODRNDCzvrsN
        8vcxHBMHtvq97rg15vy63A62kbf8rto=
X-Google-Smtp-Source: AGHT+IGYbM09vE1je76mf+4f04aShsOpfP6cx7Jo7jaMJak3HGY1KAJ/8UNIVc0KOHyn2SWFpZ5NBg==
X-Received: by 2002:a17:902:70ca:b0:1c6:2927:fbbd with SMTP id l10-20020a17090270ca00b001c62927fbbdmr852341plt.18.1695790937480;
        Tue, 26 Sep 2023 22:02:17 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001c0c79b386esm12021996plb.95.2023.09.26.22.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 22:02:16 -0700 (PDT)
Date:   Wed, 27 Sep 2023 10:32:13 +0530
Message-Id: <877cocgqei.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     linux-ext4@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] ext4/mballoc: No need to generate from free list
In-Reply-To: <20230918153619.tku6d4556os5tvzj@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Thu 24-08-23 23:56:31, Wang Jianjian wrote:
>> Commit 7a2fcbf7f85('ext4: don't use blocks freed but
>> not yet committed in buddy cache init) walk the rbtree of
>> freed data and mark them free in buddy to avoid reuse them
>> before journal committing them, However, it is unnecessary to
>> do that, because we have extra page references to buddy and bitmap
>> pages, they will be released iff journal has committed and after
>> process freed data.
>
> So do you mean that buddy bitmap cannot be freed until the transaction that
> frees the blocks in it commits? Indeed ext4_mb_free_metadata() grabs buddy
> page references and ext4_free_data_in_buddy() drops them. 
>
> Perhaps I'd rephrase the changelog as:
>
> Commit 7a2fcbf7f85 ("ext4: don't use blocks freed but not yet committed in
> buddy cache init") added a code to mark as used blocks in the list of not yet
> committed freed blocks during initialization of a buddy page. However
> ext4_mb_free_metadata() makes sure buddy page is already loaded and takes a
> reference to it so it cannot happen that ext4_mb_init_cache() is called
> when efd list is non-empty. Just remove the
> ext4_mb_generate_from_freelist() call.
>

The above changelog is very clear. Thanks!

The observation made in this patch is very subtle. Indeed we cannot have
ext4_mb_init_cache() get called for a group as long we have an entry in
grp->bb_free_root because it holds the reference to the buddy and
incore-bitmap pages. These entry gets freed up after a transaction
commit is completed via callback ext4_process_freed_data() -> ext4_free_data_in_buddy()

Nice catch. It's from 2009 :)

>> @@ -1274,7 +1272,6 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
>>  
>>  			/* mark all preallocated blks used in in-core bitmap */
>>  			ext4_mb_generate_from_pa(sb, data, group);
>> -			ext4_mb_generate_from_freelist(sb, data, group);
>
> And just to be sure I'd add here:
>
> 			WARN_ON_ONCE(!RB_EMPTY_ROOT(&grp->bb_free_root));
>

Right. That might catch any wrong use.


-ritesh
