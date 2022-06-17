Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6010A54F485
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jun 2022 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380887AbiFQJks (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiFQJkq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 05:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB9C69483
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655458844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2YIQuKwekY0WiBRZ5F8WSRdemt7ajPawZ+d5zPsp/4=;
        b=X2RqaL/iHJy+wMJRjLpiu6LYPeQye9VZvH/ZjDI3yT5mK4/Q/H4VvGOnGdkCiVM5Fnszgl
        WVhSN+JMtp1ln4DX1pEd7WJIxwrShCcT44lVVe+DwhBpwvzL7iIpHMH2euCkg1B9/aR1Cf
        jpx+lR3Wj9TWi6Pn28lsdQ6IDLC9Vyo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-h-o-fFusOny277yXQxUzQQ-1; Fri, 17 Jun 2022 05:40:42 -0400
X-MC-Unique: h-o-fFusOny277yXQxUzQQ-1
Received: by mail-wm1-f72.google.com with SMTP id 2-20020a1c0202000000b0039c94528746so2479304wmc.6
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 02:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=H2YIQuKwekY0WiBRZ5F8WSRdemt7ajPawZ+d5zPsp/4=;
        b=pYIQfmiI48/33u1b/lIimzgSJoabDQq4/r+nUj0KP+rtSpzOy+zGlZsH7gJY/SeGnw
         z1Nkqrdu27nd0EOaSAACHKCjozuUhhEvWMS1NLa2c64jkPoUjMPTvd2rrP822GbDIJGU
         HsmLo8Xp84x9mw+4cvH4glCUk27+ytTrvm5E9iPJUNFue9ViugBEsKMG3jicOJy7xMlw
         V50e1b0fC+00v494fy2tPx3BOX3kzk74o+0hsHHuxnB6frWRV7COKgeb7Gb35TVrpPLc
         m2SZsL2Rv6lEK9CsSELIh4NQLW601S9LXZ1VlEY7bCQizEmVgfr9zJQGpHMmRdZiL7iS
         hD1w==
X-Gm-Message-State: AJIora/CsfHZfduG3RkuXtfMs2AzNF8EECoN6XHaaeCi96uikAESp8Si
        jGp1uY9kZhdbOnlChgVh8ARzhVxtBSxAKdDj7gWOWLREiBLVlfo4Cq6kIRoRrVE03rdkXdw+EuM
        tw8D5Cuyo7JEMIP1cV+UDcQ==
X-Received: by 2002:adf:ea90:0:b0:215:a11d:3329 with SMTP id s16-20020adfea90000000b00215a11d3329mr8273283wrm.709.1655458841236;
        Fri, 17 Jun 2022 02:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcyIDstW1UoHx515Nm3zkT6PwFo4LTcTooQfD0VdaRVMK+nlfneS0G9f2+zYKCej73GtUeFg==
X-Received: by 2002:adf:ea90:0:b0:215:a11d:3329 with SMTP id s16-20020adfea90000000b00215a11d3329mr8273248wrm.709.1655458840923;
        Fri, 17 Jun 2022 02:40:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824? (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de. [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d614e000000b0020d09f0b766sm4082674wrt.71.2022.06.17.02.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:40:40 -0700 (PDT)
Message-ID: <3ac89358-2ce0-7d0d-8b9c-8b0e5cc48945@redhat.com>
Date:   Fri, 17 Jun 2022 11:40:39 +0200
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
References: <20220531200041.24904-1-alex.sierra@amd.com>
 <20220531200041.24904-2-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 01/13] mm: add zone device coherent type memory support
In-Reply-To: <20220531200041.24904-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 31.05.22 22:00, Alex Sierra wrote:
> Device memory that is cache coherent from device and CPU point of view.
> This is used on platforms that have an advanced system bus (like CAPI
> or CXL). Any page of a process can be migrated to such memory. However,
> no one should be allowed to pin such memory so that it can always be
> evicted.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> [hch: rebased ontop of the refcount changes,
>       removed is_dev_private_or_coherent_page]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memremap.h | 19 +++++++++++++++++++
>  mm/memcontrol.c          |  7 ++++---
>  mm/memory-failure.c      |  8 ++++++--
>  mm/memremap.c            | 10 ++++++++++
>  mm/migrate_device.c      | 16 +++++++---------
>  mm/rmap.c                |  5 +++--
>  6 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 8af304f6b504..9f752ebed613 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -41,6 +41,13 @@ struct vmem_altmap {
>   * A more complete discussion of unaddressable memory may be found in
>   * include/linux/hmm.h and Documentation/vm/hmm.rst.
>   *
> + * MEMORY_DEVICE_COHERENT:
> + * Device memory that is cache coherent from device and CPU point of view. This
> + * is used on platforms that have an advanced system bus (like CAPI or CXL). A
> + * driver can hotplug the device memory using ZONE_DEVICE and with that memory
> + * type. Any page of a process can be migrated to such memory. However no one

Any page might not be right, I'm pretty sure. ... just thinking about special pages
like vdso, shared zeropage, ... pinned pages ...

> + * should be allowed to pin such memory so that it can always be evicted.
> + *
>   * MEMORY_DEVICE_FS_DAX:
>   * Host memory that has similar access semantics as System RAM i.e. DMA
>   * coherent and supports page pinning. In support of coordinating page
> @@ -61,6 +68,7 @@ struct vmem_altmap {
>  enum memory_type {
>  	/* 0 is reserved to catch uninitialized type fields */
>  	MEMORY_DEVICE_PRIVATE = 1,
> +	MEMORY_DEVICE_COHERENT,
>  	MEMORY_DEVICE_FS_DAX,
>  	MEMORY_DEVICE_GENERIC,
>  	MEMORY_DEVICE_PCI_P2PDMA,
> @@ -143,6 +151,17 @@ static inline bool folio_is_device_private(const struct folio *folio)

In general, this LGTM, and it should be correct with PageAnonExclusive I think.


However, where exactly is pinning forbidden?

-- 
Thanks,

David / dhildenb

