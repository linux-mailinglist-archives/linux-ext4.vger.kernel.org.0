Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E8578054
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 12:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiGRK4g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiGRK4f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 06:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 916B7DF60
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658141793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wznRRcQ1E1EPLsgI7kgVwWWa1K3DaSgJ1EEclGC9ESw=;
        b=UqIwt0rCEezQGqETBObAo68KXCLg2Obgi2JPKi/21J6K5UIQFtMkWO2GLP6E7cQ8vUp5L1
        x51GcJoO9Vo8rcHhfPqh4kRFsW9uDemy8xDiUzR6YW34qDBg43LmD/FKzACl4nBBjsa/j8
        OndFxViFJ0JYgf3rQGOwI/EsoY+0LTM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-Y1Plga1sM1S0hMJ0Mt8JcQ-1; Mon, 18 Jul 2022 06:56:32 -0400
X-MC-Unique: Y1Plga1sM1S0hMJ0Mt8JcQ-1
Received: by mail-wm1-f69.google.com with SMTP id k27-20020a05600c1c9b00b003a2fee19a80so7514054wms.1
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wznRRcQ1E1EPLsgI7kgVwWWa1K3DaSgJ1EEclGC9ESw=;
        b=XPGBgPXzgGK0K+/aH3Y0lYs5byeS6MWplCIEF9Ip00Wz3AUDowOgZXi9Ptmf4cCEVm
         e74KKEF9l8T4ODMbcAdAWPtfCvZb41FTtVVLIvPGMTDyAxDUYdS+B0o6YYQiIKHeJ7A1
         AX2OPOKEcSB90WM0A+LALN0iGx3mxYm1pioWxGzQeKfsLn0caDVc1PYH366Q5TWgmEUs
         2eaOH00u9XlWBFcMkZ5vMdrxsyglvJ7ysKYYdmBiRumPaz0XPLvxAYoBOiBb3POR+fax
         UkH3JBGk3xI3GU1HC4clLB2m3SotsTdZMRWS5APoBBij2E64P40OJUiHj8eA74CGEsoy
         9yXA==
X-Gm-Message-State: AJIora9QmS8cnpkB3qyUXf9RuqDM8CefMNzRBIQhbqtB8C+iQ/p8fcxn
        rPCqcLYWTZ7A6J/gcVye+I94q+Ks9KB5DSzLByhsh4BUMV+xXjRP+XqMGIYXynfHjgIITwvyt3A
        aCbiIW0VeLolHtPuqf55ZjQ==
X-Received: by 2002:a05:600c:3b8d:b0:3a2:ea2b:d0f9 with SMTP id n13-20020a05600c3b8d00b003a2ea2bd0f9mr25454650wms.120.1658141791253;
        Mon, 18 Jul 2022 03:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1semjCkDwGjEQMzpCRvMdqQ/nTLWiXGmEKcwwSpdKliRLXOgrdG+Rkplh3ByVOTYHpbct/E2A==
X-Received: by 2002:a05:600c:3b8d:b0:3a2:ea2b:d0f9 with SMTP id n13-20020a05600c3b8d00b003a2ea2bd0f9mr25454634wms.120.1658141790977;
        Mon, 18 Jul 2022 03:56:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d5541000000b0021d728d687asm12298516wrw.36.2022.07.18.03.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:56:30 -0700 (PDT)
Message-ID: <225554c2-9174-555e-ddc0-df95c39211bc@redhat.com>
Date:   Mon, 18 Jul 2022 12:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 06/14] mm/gup: migrate device coherent pages when
 pinning instead of failing
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-7-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220715150521.18165-7-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 15.07.22 17:05, Alex Sierra wrote:
> From: Alistair Popple <apopple@nvidia.com>
> 
> Currently any attempts to pin a device coherent page will fail. This is
> because device coherent pages need to be managed by a device driver, and
> pinning them would prevent a driver from migrating them off the device.
> 
> However this is no reason to fail pinning of these pages. These are
> coherent and accessible from the CPU so can be migrated just like
> pinning ZONE_MOVABLE pages. So instead of failing all attempts to pin
> them first try migrating them out of ZONE_DEVICE.
> 
> [hch: rebased to the split device memory checks,
>       moved migrate_device_page to migrate_device.c]
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

[...]

>  		/*
>  		 * Try to move out any movable page before pinning the range.
>  		 */
> @@ -1919,7 +1948,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  				    folio_nr_pages(folio));
>  	}
>  
> -	if (!list_empty(&movable_page_list) || isolation_error_count)
> +	if (!list_empty(&movable_page_list) || isolation_error_count
> +		|| coherent_pages)

The common style is to

a) add the || to the end of the previous line
b) indent such the we have a nice-to-read alignment

if (!list_empty(&movable_page_list) || isolation_error_count ||
    coherent_pages)


Apart from that lgtm.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

