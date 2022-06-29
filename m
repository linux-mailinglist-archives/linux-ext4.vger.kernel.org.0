Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C75609B7
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiF2Ssi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2Ssh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 14:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E366E275
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656528515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZM4Ql5QJUmiVq6/iTZYAWyD16J7WFBV3CLn4iAwAjY=;
        b=C32cZ5sH31WQ/Ym1uHaWC/SjQbfB5Bktea0JtWZEQhGlQBFKoWMWgVbRFTsnyzqj8wYrO2
        ED98TBMvs9D/Cetq4eThPWBnAs71O70v1KtEdG+O5ZW00Hk7Ar0wi3sHM+2/W5rtEydg0j
        avUHXKXtBZcu+emR5wvqFnN6BZoIqcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-aba8xGh4Ov2fQKkiBkZAhA-1; Wed, 29 Jun 2022 14:48:33 -0400
X-MC-Unique: aba8xGh4Ov2fQKkiBkZAhA-1
Received: by mail-wm1-f70.google.com with SMTP id c185-20020a1c35c2000000b0039db3e56c39so123244wma.5
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 11:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4ZM4Ql5QJUmiVq6/iTZYAWyD16J7WFBV3CLn4iAwAjY=;
        b=JVIuYGA94oZ009NSc/J8ikONShCp911/VWa/z+n+tqzq6d8vhf8Xtgd0Cy7fL4xLaY
         haCampnTx6Y8CQ6b+hXwKp33YBL7icBMon0st0boxUJ3KxImcu4IYOiCY/cwIHxyegHO
         HrdNEnsaMHYJf+vAgNK8sbPmc62feR9cLdnOswawTCMDMeNcN1o7NW1ix8OfuU1C/w/I
         ShEIZGcyZxv6fljSRwU7pq6ainr7FY6KuJ3JhI4XkbVGrp/1sqXfNbOYaehdymL7dmq6
         NPnODzs6FB70MhU1XR0XMaHQP6x3G6gLJjEJouidD0I+QWu8UQJneKoutzEJ9H3hbiWt
         nGVg==
X-Gm-Message-State: AJIora99lTbS5bQc6MWsnm9JwWMJMSCwXPf40U02M8Bfyf0dYZNNWMI/
        7iZ8w6KBMO6JAUGgOXjsnT1DDWjIk0boGvhdRtN/+uSWnf5ty10WxOtpSVcubUirJ081rIRu8AA
        5hTu2izYlNW/1bCDT5PK5ug==
X-Received: by 2002:a5d:688e:0:b0:21b:9d51:25d2 with SMTP id h14-20020a5d688e000000b0021b9d5125d2mr4756604wru.286.1656528511922;
        Wed, 29 Jun 2022 11:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvKQZkINfbcfHGdv/ByN4E2v7ddXq6JGPQGqaW4FGF/wVw1dJjo/vdI/EF/pOq03d27lnmag==
X-Received: by 2002:a5d:688e:0:b0:21b:9d51:25d2 with SMTP id h14-20020a5d688e000000b0021b9d5125d2mr4756580wru.286.1656528511695;
        Wed, 29 Jun 2022 11:48:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df? (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de. [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm3206358wms.18.2022.06.29.11.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:48:31 -0700 (PDT)
Message-ID: <2e3e1050-7fa4-106b-9c80-6321afc5ac42@redhat.com>
Date:   Wed, 29 Jun 2022 20:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 02/14] mm: add zone device coherent type memory support
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-3-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220629035426.20013-3-alex.sierra@amd.com>
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

From what I can tell, this looks good to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

