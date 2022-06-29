Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3EE560C37
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 00:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiF2WPN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 18:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF2WPN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 18:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5657340D6
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656540911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfIp4/8d6FKNViDaImkd8XOnHcFGT6GmiXjgK1Qhx+g=;
        b=g7hGTeMtbdlkfFm2sZ2JVnA1l0xgpoCD5CD0FO0Apr/BdnZvotpqvJCuph0QCEEn4cHEHk
        +onzVPeKMbZojzQ071u3o/OSLKAMWvg3tE4Dz5zpgVhEwXFSHs+Jghv+iwNp9ndq6QHwN2
        Y7PkPhUYqYkuYSM3BNJ2U9U9ABd9Dn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-GyT30SQwOqqX84WfvSKXTA-1; Wed, 29 Jun 2022 18:15:09 -0400
X-MC-Unique: GyT30SQwOqqX84WfvSKXTA-1
Received: by mail-wm1-f70.google.com with SMTP id j35-20020a05600c1c2300b003a167dfa0ecso412832wms.5
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 15:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JfIp4/8d6FKNViDaImkd8XOnHcFGT6GmiXjgK1Qhx+g=;
        b=xE4A02Kwj4/SL9D/4FwTYH29OF6SMLHPTDGU3Usan8fch87zjb1sdagjWl99YNIpeg
         Bf+0gX9xBcsLPqQqUMAzYoNLjMNyKU+jX0CZz4HKDUHE4RhvoF46CeP4tgc+vnN73F9W
         gmvGQ51lgbuev8evJ0hvFPQknhimAOr+PJvrRcjdSADeNTocUl3DjnkmpiADzwhP33YV
         vNUwGn5Xc1/M2mcOHBfEC9KFVT3gcbZnnj+60n8rIIyhWX5mQRdA5N0Qge1+16ofrOmp
         HMCZueC60qxvcHCXRtp2pUlcvkcd+kgjxePTtZQ+h7uBgvU7cA/1mkxgNgXXqGaAP6dq
         UIag==
X-Gm-Message-State: AJIora8hvk2Xs0qJmBgoaAx7P3vaxdCPjcWjbKCBjAGAGLWFutLFOg+O
        knk7HZbg0QG77Tf/etG+CIcEEFemILH5/PrqXp4zBMinoV4rJAZYv8jeoVjCjZFHtB46IvO3FLV
        CK/n94/sl4fcKF303YfjpGw==
X-Received: by 2002:a5d:5481:0:b0:21a:3573:def0 with SMTP id h1-20020a5d5481000000b0021a3573def0mr5049186wrv.28.1656540908359;
        Wed, 29 Jun 2022 15:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5fcdInM+cviZFvBrEBaCvHGKr28RaqkJjmjlhZihtB4ptS3bDvlPUJ4iGFvCByQR4VNIvKw==
X-Received: by 2002:a5d:5481:0:b0:21a:3573:def0 with SMTP id h1-20020a5d5481000000b0021a3573def0mr5049172wrv.28.1656540908120;
        Wed, 29 Jun 2022 15:15:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df? (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de. [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0020fcaba73bcsm17891932wri.104.2022.06.29.15.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 15:15:07 -0700 (PDT)
Message-ID: <49315889-96de-8e41-f8ee-dd5b33c5e1db@redhat.com>
Date:   Thu, 30 Jun 2022 00:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-2-alex.sierra@amd.com>
 <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
 <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 30.06.22 00:08, Felix Kuehling wrote:
> On 2022-06-29 03:33, David Hildenbrand wrote:
>> On 29.06.22 05:54, Alex Sierra wrote:
>>> is_pinnable_page() and folio_is_pinnable() were renamed to
>>> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
>>> respectively. These functions are used in the FOLL_LONGTERM flag
>>> context.
>> Subject talks about "*_pages"
>>
>>
>> Can you elaborate why the move from mm.h to memremap.h is justified?
> 
> Patch 2 adds is_device_coherent_page in memremap.h and updates 
> is_longterm_pinnable_page to call is_device_coherent_page. memremap.h 
> cannot include mm.h because it is itself included by mm.h. So the choice 
> was to move is_longterm_pinnable_page to memremap.h, or move 
> is_device_coherent_page and all its dependencies to mm.h. The latter 
> would have been a bigger change.

I really don't think something mm generic that compiles without
ZONE_DEVICE belongs into memremap.h. Please find a cleaner way to get
this done.

-- 
Thanks,

David / dhildenb

