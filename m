Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B24561732
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiF3KEY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jun 2022 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiF3KEW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Jun 2022 06:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED0C8443F6
        for <linux-ext4@vger.kernel.org>; Thu, 30 Jun 2022 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656583452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmU0ygkfQICKkJrotNjuaw4hfz5r1ur5tb6+FXoicmQ=;
        b=G1AVLzD1DiKVZJQyxTjqAJSb2eMIubO1H92b43P1C/faa3FRxM8cebCnihl+ABy3+7sbhB
        hGSh+oHGlz72RgiqyJglfbPwmj75EmpCTcsi0ZcJmPQKpdDdeAQYA+5FTvwGfq7u1Nbb1F
        mOsZtKYd7AuHrSy1jnAesoUXieM5Sl0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-59xaOh01Mx656ylIj9njuw-1; Thu, 30 Jun 2022 06:04:11 -0400
X-MC-Unique: 59xaOh01Mx656ylIj9njuw-1
Received: by mail-wr1-f70.google.com with SMTP id q6-20020adfea06000000b0021bad47edaeso3008797wrm.20
        for <linux-ext4@vger.kernel.org>; Thu, 30 Jun 2022 03:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=DmU0ygkfQICKkJrotNjuaw4hfz5r1ur5tb6+FXoicmQ=;
        b=nVAb7T4CwOAQ7f6ihOBbFCZITtbPGuzej9QZb5ItoPZBUfbICLPiexjyLn77ZXOLhX
         tnjsoTNKbyfplvNBtivk0wW6wkhe5Q/fodaJgCjQ4NWubYoo3fDCGBSnrLnYI8W0rLPl
         xiipaeGtJf6DIf4Bm33DjBxo3hwKsN5zPUqAba1ZhByHU80GMC6vWKuOw35lgKHybTVt
         QjVT2hN45zRSCyx8ft/7Y4PXHN2dsmur2a4TVMFh0M29irky3wLqma1pvjlMyQVrRQaJ
         71BbUIe7aqPZl3HQaEmc34UEqMFXEmTh029FymotYOesopL2mTng9wFYFAey9kvYJ2AT
         PbRQ==
X-Gm-Message-State: AJIora9f2fCmkG4MHEkRBbBiAV8OuP93vbLi6DBLLIt1BfeAej8SJGra
        wwm+Kjl59PNz+wrawZ6aVf4w79XzgMk0gksiGMOtMy6jfldDObrw/FI8QKcUnDAz1bh3/5lQCRX
        S24g5mjdCRsw8iIIMHTu+QQ==
X-Received: by 2002:a7b:c152:0:b0:3a0:3e53:aa17 with SMTP id z18-20020a7bc152000000b003a03e53aa17mr11394757wmi.78.1656583450235;
        Thu, 30 Jun 2022 03:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuI1sm5VybPo4wkaCR+sryKNwQzXdsHV339ZfkUZFjdgFAR5z/wUEvUcNLFrEOEmcW1irqSA==
X-Received: by 2002:a7b:c152:0:b0:3a0:3e53:aa17 with SMTP id z18-20020a7bc152000000b003a03e53aa17mr11394724wmi.78.1656583449915;
        Thu, 30 Jun 2022 03:04:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:7f00:214b:cffb:c693:2b71? (p200300cbc7087f00214bcffbc6932b71.dip0.t-ipconnect.de. [2003:cb:c708:7f00:214b:cffb:c693:2b71])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003a046549a85sm2150594wms.37.2022.06.30.03.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:04:09 -0700 (PDT)
Message-ID: <956b1c51-b8f1-0480-81ca-5d03b45110f7@redhat.com>
Date:   Thu, 30 Jun 2022 12:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-5-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 04/14] mm: add device coherent vma selection for memory
 migration
In-Reply-To: <20220629035426.20013-5-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 29.06.22 05:54, Alex Sierra wrote:
> This case is used to migrate pages from device memory, back to system
> memory. Device coherent type memory is cache coherent from device and CPU
> point of view.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Poppple <apopple@nvidia.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


I'm not too familiar with this code, please excuse my naive questions:

> @@ -148,15 +148,21 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			if (is_writable_device_private_entry(entry))
>  				mpfn |= MIGRATE_PFN_WRITE;
>  		} else {
> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> -				goto next;

Why not exclude MIGRATE_VMA_SELECT_DEVICE_PRIVATE here? IIRC that would
have happened before this change.


>  			pfn = pte_pfn(pte);
> -			if (is_zero_pfn(pfn)) {
> +			if (is_zero_pfn(pfn) &&
> +			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>  				mpfn = MIGRATE_PFN_MIGRATE;
>  				migrate->cpages++;
>  				goto next;
>  			}
>  			page = vm_normal_page(migrate->vma, addr, pte);
> +			if (page && !is_zone_device_page(page) &&

I'm wondering if that check logically belongs into patch #2.

> +			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> +				goto next;
> +			else if (page && is_device_coherent_page(page) &&
> +			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
> +			     page->pgmap->owner != migrate->pgmap_owner))


In general LGTM

-- 
Thanks,

David / dhildenb

