Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2468B57802F
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiGRKva (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiGRKv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 06:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D21F01FCE7
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658141487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQ3EHE5Y/uXmTBk59WY/sBfkyYOaAyrJ99vyQlUJOsY=;
        b=KtnHMQ45H6fUTApqJwQks4id7VGvoA60j+53ASM+EkgRLuiDz+S/mgikM2b2Jifu72jhmU
        WKTSPM3Vg+PYvCqgxkwJ2M0NSZvfQCB3uwVG3eB3UK7TO8sygSGBDC14khGRFGLC3GLQhe
        egm5yHoMlfMTr3t+MBDGvflqEHJfbvk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-n8whcaIePbWy9vZj_3FoqQ-1; Mon, 18 Jul 2022 06:51:25 -0400
X-MC-Unique: n8whcaIePbWy9vZj_3FoqQ-1
Received: by mail-wm1-f70.google.com with SMTP id k27-20020a05600c1c9b00b003a2fee19a80so7508073wms.1
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QQ3EHE5Y/uXmTBk59WY/sBfkyYOaAyrJ99vyQlUJOsY=;
        b=V2IOA2BnQtyk27R9Ol9XTPIzTAEjhXGIppRg9VfoBRsKTn5zCrUF1Dq3tsuL8QOJwo
         ywXwliQUfqSlAzGvWnQ47+u5NwuKRLkQ7qZKCRwqTdrn9Vh2Mv9PTGvRpBDOhQ3YyYf7
         TjwzcjUkN/RK8H/mTFTX2BxEbQLc7swTirRGAAv/fSPEAl8PQzMqeKZ4LrJTSwYbvly5
         +UD9RVLFzbYEbr57yL3ox92gHmMNxHFdUsUPBH/0PBUkBZwl2o1GUxRaCi9hhstnL/K0
         +C/bgOitxXLDRFbPAxRbGpmySV6qMIDSmaFKbwbE3U4Nwrpfi/LTdOvgfPcQQpwJfW67
         Zr8g==
X-Gm-Message-State: AJIora/uBQ8tOLdWFqh/hdFJKeoDudPBVzvcV4cvn5cX5Fk6X/wyOyPv
        NvQExt09XyvXT2nDrpLEUNMqLtHYHIItFcE1B9lCqq4/2FNaQM22P0nTgnJRkbdns3KHgCcoWJh
        mNVM7b6kkLTJNo5Dfc0c86A==
X-Received: by 2002:adf:f905:0:b0:21d:f460:1acf with SMTP id b5-20020adff905000000b0021df4601acfmr7759756wrr.108.1658141484510;
        Mon, 18 Jul 2022 03:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOXS/jyYuLht99baWDw+JXGFOCaonutnGNWmhXXtQ2efKyLTqtTuwadUZoGMqOmdhX/IMMMw==
X-Received: by 2002:adf:f905:0:b0:21d:f460:1acf with SMTP id b5-20020adff905000000b0021df4601acfmr7759740wrr.108.1658141484280;
        Mon, 18 Jul 2022 03:51:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003a033177655sm21076465wmp.29.2022.07.18.03.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:51:23 -0700 (PDT)
Message-ID: <95b3c8f3-2e4d-fa2f-1552-580236eea485@redhat.com>
Date:   Mon, 18 Jul 2022 12:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 04/14] mm: handling Non-LRU pages returned by
 vm_normal_pages
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-5-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220715150521.18165-5-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 15.07.22 17:05, Alex Sierra wrote:
> With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
> device-managed anonymous pages that are not LRU pages. Although they
> behave like normal pages for purposes of mapping in CPU page, and for
> COW. They do not support LRU lists, NUMA migration or THP.
> 
> Callers to follow_page() currently don't expect ZONE_DEVICE pages,
> however, with DEVICE_COHERENT we might now return ZONE_DEVICE. Check
> for ZONE_DEVICE pages in applicable users of follow_page() as well.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com> (v2)
> Reviewed-by: Alistair Popple <apopple@nvidia.com> (v6)
>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

