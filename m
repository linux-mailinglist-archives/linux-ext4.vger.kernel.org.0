Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0722755F917
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiF2Hdf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 03:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2Hdf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 03:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FF261EC56
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656488013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dA2eoSPtGttWxJYZGlfOcE/QeU9denwWrEKtVHSFEyo=;
        b=RjZzRQXEzUevNSu6VfUPeENuCjiAflugBKE+0cfUCRlXIpBVdVIGS4YDmWkDHcNEnodF8+
        rIjdx3nEI740BDTAgJMA/+0Eq9MxsSwPgJmoxJV2IGg/6onWSsP2XnQQTSrJCucHYUEV26
        2byZZM5eTTqV2w9n0D+DuZ29VIHMCY8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-jkKc-sfHPzmhlQURlGp8Ag-1; Wed, 29 Jun 2022 03:33:31 -0400
X-MC-Unique: jkKc-sfHPzmhlQURlGp8Ag-1
Received: by mail-wr1-f72.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso2154293wrg.21
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 00:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dA2eoSPtGttWxJYZGlfOcE/QeU9denwWrEKtVHSFEyo=;
        b=RIsyCKJqRkGpvAejLT0ujR8gAXJYTZkhZB3SnmKiCRS4eh64RrMxZPfHwq3gSmKikx
         bMqdMvcdoZi1OfDnkS0WfgGQsfMJT+pFWTjoqACYPzOfQZfrwFtw46BhguVhNVp5SarI
         yECGXeXzfLljk5t9IELGaO5L/rk1QZa9QmDbyH1k9yIzdQdcQz55/gOuvx8/fPBoDMTe
         w2UL2EYlFoyTkliY8YXZpFEUiu73O3rSyu4D7Ya52ark0h5Meimm2hSPzgxauw7Cr/k1
         WT8qWt2BCZUrZ2mjRcAihX3+NcmezpF2NBBVNHXLCxnuhSJGdRod5iHQo86v0zU7Bvjg
         naRQ==
X-Gm-Message-State: AJIora+8ZT3xxXs23gMNztYG4pI8mi7ygUWj9dwUElFIIohiLRbq1pvP
        kufL7ox28O9cEeXTaNpwo0fV0olqZuQ0u4HQJoZ1+72woKWKd+/0fnRGCTdS9F7Qqn4AwTMh7sw
        s9QrMpf8Dv9i9T2jmbpKlhQ==
X-Received: by 2002:a05:600c:3591:b0:3a0:563a:49d3 with SMTP id p17-20020a05600c359100b003a0563a49d3mr1926453wmq.60.1656488010107;
        Wed, 29 Jun 2022 00:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uum8Hx2eoXPmPEzIAfJI+bxpHTzM8+zWRZ0znb96530kqbhcZ9rF+BBXjqVzGxgQ61VtlDlw==
X-Received: by 2002:a05:600c:3591:b0:3a0:563a:49d3 with SMTP id p17-20020a05600c359100b003a0563a49d3mr1926431wmq.60.1656488009851;
        Wed, 29 Jun 2022 00:33:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df? (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de. [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
        by smtp.gmail.com with ESMTPSA id g21-20020a7bc4d5000000b0039c587342d8sm2175038wmk.3.2022.06.29.00.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 00:33:29 -0700 (PDT)
Message-ID: <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
Date:   Wed, 29 Jun 2022 09:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-2-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220629035426.20013-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 29.06.22 05:54, Alex Sierra wrote:
> is_pinnable_page() and folio_is_pinnable() were renamed to
> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
> respectively. These functions are used in the FOLL_LONGTERM flag
> context.

Subject talks about "*_pages"


Can you elaborate why the move from mm.h to memremap.h is justified?

I'd have called it "is_longterm_pinnable_page", but I am not a native
speaker, so no strong opinion :)


-- 
Thanks,

David / dhildenb

