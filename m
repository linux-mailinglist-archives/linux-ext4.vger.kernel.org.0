Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120A4C9062
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 17:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiCAQdN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Mar 2022 11:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiCAQdL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Mar 2022 11:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2865532E0
        for <linux-ext4@vger.kernel.org>; Tue,  1 Mar 2022 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646152348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n44Wo6vgxZpi5bWperlxNMLPYijk8JsTILs9YPWVgno=;
        b=QOAHEmxYmFE++6qvDpinVAqosd1W69q/0e9tWSLqGUeVtvZQBhJJu8iuwq9mItRdsqMmAA
        saAEyeelvl03M7DFQ6+ijw9jrFDTrOs21uPcuuZwp+eZzvOlybxv0YlckLxOKt42V2e0a5
        7N8zlhS67nWJweswTzbZ8Lry/Q9rI2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-MW3_y2fQM0SwGopqqDPxrA-1; Tue, 01 Mar 2022 11:32:27 -0500
X-MC-Unique: MW3_y2fQM0SwGopqqDPxrA-1
Received: by mail-wm1-f70.google.com with SMTP id m21-20020a7bcf35000000b00380e364b5d2so1458632wmg.2
        for <linux-ext4@vger.kernel.org>; Tue, 01 Mar 2022 08:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=n44Wo6vgxZpi5bWperlxNMLPYijk8JsTILs9YPWVgno=;
        b=zk6a+LfFyL963J3y5btJ/Pu0/pKTmjdIkep5HU27gVcadHmd9ejiCtAk73lFHIRyDJ
         3Wnz4Mf1/zhl0GjuDnprEmkioZSFu1vDShnj+5jtlqK3B7htO0tpw1dixHZiA1TtHiYo
         baR3mpUmUON4MyToae68zNjbWy2tN4gwKwTnIfnCjlpZyCIAyF6nXCmsYpV5jHGPryq6
         dP3s1ZyjnREp+lIRmcka1bo35it3t4Flk2ami/qy6QhmdpTVaNvc7/OvphRCux61oNW+
         sSNKEbNSQVW/G0+sKNTKyjop0mGcllzGKikiKRKYGNMpnyntXroY4si8L7D3rBDyJoIn
         yciA==
X-Gm-Message-State: AOAM531OmA1YmsdB533cXz89sqJebL37AzIUjEE+UBQhEhRwzOesjpCk
        eWysTfbra++AYZ4rS1mo5LTaBC9aPpgtIgx0CxFV7KwYhLGLH84kAOiqQ7sOkd43AzIXdEfPTiC
        VPUWH7QHcA4JHK+iDYMaAGA==
X-Received: by 2002:a05:6000:1b0c:b0:1ef:956e:3210 with SMTP id f12-20020a0560001b0c00b001ef956e3210mr10718765wrz.322.1646152346585;
        Tue, 01 Mar 2022 08:32:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3kzdNGIIvZpX2C9to3Pb3Y486zu3gVqra59S1lC+acXexuk7wv16jDLZDxszLnYK+EvUsSg==
X-Received: by 2002:a05:6000:1b0c:b0:1ef:956e:3210 with SMTP id f12-20020a0560001b0c00b001ef956e3210mr10718743wrz.322.1646152346319;
        Tue, 01 Mar 2022 08:32:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323? (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de. [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00380e3225af9sm3328629wms.0.2022.03.01.08.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 08:32:25 -0800 (PST)
Message-ID: <85a68c56-7cce-ef98-7aa6-c68eabf3fa0b@redhat.com>
Date:   Tue, 1 Mar 2022 17:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: split vm_normal_pages for LRU and non-LRU handling
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     rcampbell@nvidia.com, willy@infradead.org, apopple@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, jglisse@redhat.com,
        amd-gfx@lists.freedesktop.org, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, hch@lst.de
References: <20220218192640.GV4160@nvidia.com>
 <20220228203401.7155-1-alex.sierra@amd.com>
 <2a042493-d04d-41b1-ea12-b326d2116861@redhat.com>
 <41469645-55be-1aaa-c1ef-84a123fdb4ea@amd.com>
 <bfae7d17-eb50-55b1-1275-5ba0f86a5273@redhat.com>
 <353c7bbd-b20e-8a7a-029a-cda9b531e5e8@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <353c7bbd-b20e-8a7a-029a-cda9b531e5e8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 01.03.22 17:30, Felix Kuehling wrote:
> Am 2022-03-01 um 11:22 schrieb David Hildenbrand:
>>>>>    		if (PageReserved(page))
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index c31d04b46a5e..17d049311b78 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1614,7 +1614,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>>>    		goto out;
>>>>>    
>>>>>    	/* FOLL_DUMP to ignore special (like zero) pages */
>>>>> -	follflags = FOLL_GET | FOLL_DUMP;
>>>>> +	follflags = FOLL_GET | FOLL_DUMP | FOLL_LRU;
>>>>>    	page = follow_page(vma, addr, follflags);
>>>> Why wouldn't we want to dump DEVICE_COHERENT pages? This looks wrong.
>>> This function later calls isolate_lru_page, which is something you can't
>>> do with a device page.
>>>
>> Then, that code might require care instead. We most certainly don't want
>> to have random memory holes in a dump just because some anonymous memory
>> was migrated to DEVICE_COHERENT.
> I don't think this code is for core dumps. The call chain I see is
> 
> SYSCALL_DEFINE6(move_pages, ...) -> kernel_move_pages -> do_pages_move 
> -> add_page_for_migration
> 

Ah, sorry, I got mislead by FOLL_DUMP and thought we'd be in
get_dump_page() . As you said, nothing to do.

-- 
Thanks,

David / dhildenb

