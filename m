Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAD56B875
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiGHL2h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbiGHL2f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 07:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EF6F95B3
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jul 2022 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657279713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wv13NujG3+dVwkih/Xqwv3AU9lfrcuYQf1ebjgUaVVk=;
        b=Iczp9EkZHsxaQVzWfufbTPb/vdDcV1rfzBnQaBl/XJ9xiBrl9eCEmY+3w3aMuH9JrTeGCL
        YyN3K14yB/yzRCBYpxOri9WMn9V7DhE/vismxDRqh6rAo/18u8es4gmwdtmZNLq27Qt06U
        f3pA8u3z1AQpsDU3gT0SZqZXSl7sUds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-R0nkFTc_NLeu0RuPe3jmnQ-1; Fri, 08 Jul 2022 07:28:32 -0400
X-MC-Unique: R0nkFTc_NLeu0RuPe3jmnQ-1
Received: by mail-wm1-f71.google.com with SMTP id e13-20020a05600c4e4d00b003a2ddd5caadso34767wmq.1
        for <linux-ext4@vger.kernel.org>; Fri, 08 Jul 2022 04:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Wv13NujG3+dVwkih/Xqwv3AU9lfrcuYQf1ebjgUaVVk=;
        b=EhYLWj8HWARt7Gj6yWAcuVInBWNlRfKS9yWmbuWPKoIGdUv76CxrrAXr0L53/vWp7C
         4Dv95GBkWClUid0/aqFgqUSAuo35J5jOatsFypxqcVR/TkJb/33AqhlsO/JcbQXefLHh
         wafPciM62YerAk0Y4idsC7SEPSn8G64w2M2nyCMVj1l4YvdZL3nOf0/GWUy7eEHGt0V2
         aiJ4ahvKnEh1OTgTxiAqKKzuYgFOXU0X55joj/dXKapJoQgcccsBm2mdJPPmTS4Myig6
         vPkas2UAVQcpxxGghmk0adLboyqaV2yWgVew52p80m2PZYFbrliKEXZc+2DRGkF3CywA
         WhFg==
X-Gm-Message-State: AJIora+xuhBFVoXG4oDGOIFZyvHnpUtOoZdl3mppKIAl5nVQMuVdiL1i
        ecgXYwAVCtvVY289V8/HrwpZj+xO8TDijw9rQ2QrF1W206czLv8/AuUmpmaQYeqiHJq7S544ZKz
        41uNTcWs/N/MWT/ksl5gJKw==
X-Received: by 2002:a05:600c:2d45:b0:3a0:46e9:7bde with SMTP id a5-20020a05600c2d4500b003a046e97bdemr9948560wmg.49.1657279711577;
        Fri, 08 Jul 2022 04:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwGt5CrdxA6TaalbRjXWp7cv9FLQs1vbEX6yKshjXEbNsz1xjWIT4O4gDvAQM4X6U54AxsXw==
X-Received: by 2002:a05:600c:2d45:b0:3a0:46e9:7bde with SMTP id a5-20020a05600c2d4500b003a046e97bdemr9948543wmg.49.1657279711385;
        Fri, 08 Jul 2022 04:28:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:6300:c44f:789a:59b5:91e9? (p200300cbc7026300c44f789a59b591e9.dip0.t-ipconnect.de. [2003:cb:c702:6300:c44f:789a:59b5:91e9])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b002167efdd549sm12911271wrw.38.2022.07.08.04.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 04:28:30 -0700 (PDT)
Message-ID: <97816c26-d2dd-1102-4a13-fafb0b1a4bc3@redhat.com>
Date:   Fri, 8 Jul 2022 13:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/15] mm: move page zone helpers into new
 header-specific file
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-3-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220707190349.9778-3-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 07.07.22 21:03, Alex Sierra wrote:
> [WHY]
> Have a cleaner way to expose all page zone helpers in one header

What exactly is a "page zone"? Do you mean a buddy zone as in
include/linux/mmzone.h ?


-- 
Thanks,

David / dhildenb

