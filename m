Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4341D55DE6E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 15:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbiF1Km4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 06:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbiF1Kmw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 06:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A925C2E9E2
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656412970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONUUHv3MjjvFIJKVWzF/NPSOZ8SZcSjCl83bnjLd8nk=;
        b=Hck/UEpIyYkrOih5cuyld8kC7OwJDMnkfmO96xxNJYnec48cAmDl/jyXZnO0P574KwWGaj
        FfJcQe/qr3aYnHCo2I0t+D6utjyizF/y+yj9Wd6w+N2Ris24KuVeDMQyfqELSI3qDUGuzI
        a/pEk21MwKmw8KTMB6iWxsaIcyETxbI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-PkcmYVpsPXmtBGQ0NcM9Ng-1; Tue, 28 Jun 2022 06:42:49 -0400
X-MC-Unique: PkcmYVpsPXmtBGQ0NcM9Ng-1
Received: by mail-wm1-f69.google.com with SMTP id e24-20020a05600c219800b003a0471b1904so3730325wme.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 03:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ONUUHv3MjjvFIJKVWzF/NPSOZ8SZcSjCl83bnjLd8nk=;
        b=Q5vT0ueA3OnlM8pdX9fww5Ia939rkVy1z5ww9AMRT8vncTf5p4PEsXf2xn2+ieHN9v
         uytzsreidVmzw+htkZauG32SAE4dJko3hyJKSKaj+Oz83iTSixp5GjboF5QqqYeW3Tg+
         zAx8KwkKm8QwZ4ROcy17vAOCZeyNDiFU0v2OGmF3BPsxUjH+1bHD9v4nbUAFnL1z0UDx
         ixRtEw0Rj/vnGnuwr4Xcqkf2iUQLbaY3ZxDiD/wUTOTl2w4Yw1BWAOTdyR4F2uvoXM9u
         EwI6nZWLB4bxtJWmXNp3hmM2wvyTn3RQrkNzv/HfM77HcU4yQEGNIpDHaVCkr8pLessv
         piwQ==
X-Gm-Message-State: AJIora9/iPdhKB2yv3KF5+b+NGrU/UnwojVQ7A9kjsZwXRzQKaIbQ01Y
        abLXjegMy2d02aXWzb5s9TAG8Sq3bSbdX1I/MvbnAFWofF6HNRbOCexI2uPohgcnWPguzzoL6Ua
        9x4P3EDjGrU7ub8ZHhQn+OA==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr19766105wmq.14.1656412968362;
        Tue, 28 Jun 2022 03:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t89v3kQLLnvmZ+A4VBSjVx4SCynlA5GjVj55ld5GAWdEkQJAn2Ag3b6wuqeEuz7QSmx4Iu0w==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr19766075wmq.14.1656412968043;
        Tue, 28 Jun 2022 03:42:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:a00:46df:e778:456a:8d6b? (p200300cbc7090a0046dfe778456a8d6b.dip0.t-ipconnect.de. [2003:cb:c709:a00:46df:e778:456a:8d6b])
        by smtp.gmail.com with ESMTPSA id p2-20020a056000018200b002103cfd2fbasm13329363wrx.65.2022.06.28.03.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 03:42:47 -0700 (PDT)
Message-ID: <79a7969c-311f-d36b-4d44-dfe2f02c9b99@redhat.com>
Date:   Tue, 28 Jun 2022 12:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 02/14] mm: handling Non-LRU pages returned by
 vm_normal_pages
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220628001454.3503-1-alex.sierra@amd.com>
 <20220628001454.3503-3-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220628001454.3503-3-alex.sierra@amd.com>
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

On 28.06.22 02:14, Alex Sierra wrote:
> With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
> device-managed anonymous pages that are not LRU pages. Although they
> behave like normal pages for purposes of mapping in CPU page, and for
> COW. They do not support LRU lists, NUMA migration or THP.
> 
> We also introduced a FOLL_LRU flag that adds the same behaviour to
> follow_page and related APIs, to allow callers to specify that they
> expect to put pages on an LRU list.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> ---

I think my review feedback regarding FOLL_LRU has been ignored.


-- 
Thanks,

David / dhildenb

