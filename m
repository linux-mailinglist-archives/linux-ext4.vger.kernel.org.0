Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C695155FCB1
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiF2J7d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiF2J7c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 05:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F5D136330
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656496771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzceN8npiU1PHAzECBm7qOnZjHThBc7uhuHl4hlHZrs=;
        b=FGs720HSx2NWn92vuRUFvh+ugHAkzqJoRBoB6oISnoyiCXqLV2eL0bUAfc7zM82FG5+Cp4
        l5cxzuJZVLF0Pgqs7dCL7PBFIztOPDfgLgrlNehtNL3aKvmft4hQRa0GG7QEQjPWUGme3T
        iu3WUWymM7uOEmJMGva69jOSGNJIgLM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-w6OE8YlCNrulM0p6_lvlzA-1; Wed, 29 Jun 2022 05:59:29 -0400
X-MC-Unique: w6OE8YlCNrulM0p6_lvlzA-1
Received: by mail-wr1-f69.google.com with SMTP id w17-20020a5d6811000000b0021ba89c2e27so2278730wru.10
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 02:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=UzceN8npiU1PHAzECBm7qOnZjHThBc7uhuHl4hlHZrs=;
        b=UWwgeMdHi0mSkzs+WRldsd/UnwY+2wt+li8euygP71la4ShG9f8MmDvhtruMAS07TQ
         hZjo+osLnx8CuHn/DfiAd6u34tL8NEyY+/+VgbZcn1qZP1/8OJNF3VmB5Px5bv3r8nJq
         iUOxdZl+hUbzjpfmy/zSJqG92dMMpKEm2rSz3c/wVv3iWjEiOcWw1EU3UQwoXBFC3fG9
         zekP5VUTvbnr/oyQV+Qz4R9hCHjuwNxYulCOeArBHrkNkSfUEsoR+5QO4rmdNvCKQFbi
         sUPvw8er8SXwF2i68VVIn3QTdvK1NKIQs1R+KrLnQ7c5hzss8PUsFp4I5Rkyv6D4Po6d
         2tCQ==
X-Gm-Message-State: AJIora8zFrkUQ5cR3GTWVm7/NIxmMILltQ452Xk5sisseiKR9yn10U79
        GXecHDyOkTHo8E0LiGGEgs3jCNLEML0Y+I5EYpO5rKChBHOX/jo/BQZt3Y+AI6AODD8Ailvl5v7
        n1dduZ24+8Vt9h3IohM5PQA==
X-Received: by 2002:a7b:c5d0:0:b0:3a0:3dc8:73a1 with SMTP id n16-20020a7bc5d0000000b003a03dc873a1mr2664067wmk.98.1656496768474;
        Wed, 29 Jun 2022 02:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uzk/B6PTZXrzHxht/mKCZa7GoCf9iThGNKGutixbwHJDxt/oLs1rYeiHv7jfh4fv2kOpV6+w==
X-Received: by 2002:a7b:c5d0:0:b0:3a0:3dc8:73a1 with SMTP id n16-20020a7bc5d0000000b003a03dc873a1mr2664041wmk.98.1656496768236;
        Wed, 29 Jun 2022 02:59:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df? (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de. [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c20c600b003a0426fae52sm2555196wmm.24.2022.06.29.02.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:59:27 -0700 (PDT)
Message-ID: <269e4c6e-d6ee-bace-9fab-a9dcb4268d5a@redhat.com>
Date:   Wed, 29 Jun 2022 11:59:26 +0200
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
 <20220629035426.20013-4-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 03/14] mm: handling Non-LRU pages returned by
 vm_normal_pages
In-Reply-To: <20220629035426.20013-4-alex.sierra@amd.com>
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

On 29.06.22 05:54, Alex Sierra wrote:
> With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
> device-managed anonymous pages that are not LRU pages. Although they
> behave like normal pages for purposes of mapping in CPU page, and for
> COW. They do not support LRU lists, NUMA migration or THP.
> 
> Callers to follow_page that expect LRU pages, are also checked for
> device zone pages due to DEVICE_COHERENT type.

Can we rephrase that to (because zeropage)

"Callers to follow_page() currently don't expect ZONE_DEVICE pages,
however, with DEVICE_COHERENT we might now return ZONE_DEVICE. Check for
ZONE_DEVICE pages in applicable users of follow_page() as well."



[...]

>  		/*
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..e18555af9024 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -624,6 +624,13 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  		if (is_zero_pfn(pfn))
>  			return NULL;
>  		if (pte_devmap(pte))
> +/*
> + * NOTE: New uers of ZONE_DEVICE will not set pte_devmap() and will have

s/uers/users/

> + * refcounts incremented on their struct pages when they are inserted into
> + * PTEs, thus they are safe to return here. Legacy ZONE_DEVICE pages that set
> + * pte_devmap() do not have refcounts. Example of legacy ZONE_DEVICE is
> + * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
> + */

[...]

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..e034aae2a98b 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -95,7 +95,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  					continue;
>  
>  				page = vm_normal_page(vma, addr, oldpte);
> -				if (!page || PageKsm(page))
> +				if (!page || is_zone_device_page(page) || PageKsm(page))
>  					continue;
>  
>  				/* Also skip shared copy-on-write pages */

In -next/-mm there is now an additional can_change_pte_writable() that
calls vm_normal_page() --  added by me. I assume that that is indeed
fine because we can simply map device coherent pages writable.

Besides the nits, LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

