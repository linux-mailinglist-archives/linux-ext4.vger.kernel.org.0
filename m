Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C634D5E27
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Mar 2022 10:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbiCKJRR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Mar 2022 04:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiCKJRR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Mar 2022 04:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E1901BBF57
        for <linux-ext4@vger.kernel.org>; Fri, 11 Mar 2022 01:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646990174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIGdPHjLg1hmetspOZdQaeJznczctW/NKNGy6+DAXDs=;
        b=aVQ7iMrikJkUXhtU/7W2OWadbjlV8bh1d7HopqBMbWN7/Lp4fFBAcwG/SembDnu2qNbfqn
        RWyOA9YnuxTMmz4jTEneDfIQORd4CLht3np0n7rVqCjBLaGKKEtLjI8P2RT18Q0yXAK8S6
        2TltN77WzWL3EYJr+MeWIkA4L8nehsc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-PYxbsCrzMGqQKyABKmOz2Q-1; Fri, 11 Mar 2022 04:16:11 -0500
X-MC-Unique: PYxbsCrzMGqQKyABKmOz2Q-1
Received: by mail-wm1-f71.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so2798296wms.0
        for <linux-ext4@vger.kernel.org>; Fri, 11 Mar 2022 01:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=EIGdPHjLg1hmetspOZdQaeJznczctW/NKNGy6+DAXDs=;
        b=zYI9z2v4G7LWd/b6UAP3JDmdWeOMZNNGxlwsltBlCtp1JBfRmHUYkW78PpN4VUBDLg
         8Iuu8OksrnVoWJbgf/C57lMMflESrsBuodIdeRjhbRejgAH8hkqylsrm/J6Zl1DOwDdy
         /gfIHzq1pm0fYk0gvpvYyOGhXXOTG1tuvCopVEz/Fq5KuijGiRU/o5Gv5i3HZRv61s7Q
         Fx0EyVw9PNsutkXOqDDmgk1NFVc7BRHVdD+NvEn9r56n2EHrXfcfj0zSwLqqlE9Ci5Hb
         eysF7oUNtP8H2lu1kbXHUuo8M4nVzy5d663PnVJyn3AMWHsbEQIB1D9vBUnD6joHu8PN
         Jpog==
X-Gm-Message-State: AOAM531tNBOe9ZG7Kl7rv24i+Uiejz7qofZYhQnovBXR/XTOwWfVeFRO
        OMidyTL1ql3L0XS/twqWy5MC4khLAt2C14mX2eQ9XKHGOUF0E12AgFfpsIs7JnBpmilQOFLhqut
        XrVRS/oRKgBu2ZiV3Vq7Ijg==
X-Received: by 2002:a05:600c:4f0e:b0:389:eb27:581f with SMTP id l14-20020a05600c4f0e00b00389eb27581fmr2193338wmq.132.1646990169868;
        Fri, 11 Mar 2022 01:16:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz66GE36RKglM3amxTnbF4SO/2NAriOwP++GkZh2LKs8fqberByaO4MYMTDcE67f9+yx5ejJw==
X-Received: by 2002:a05:600c:4f0e:b0:389:eb27:581f with SMTP id l14-20020a05600c4f0e00b00389eb27581fmr2193321wmq.132.1646990169610;
        Fri, 11 Mar 2022 01:16:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c068800b00389bdc8c8c2sm6270654wmn.12.2022.03.11.01.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:16:09 -0800 (PST)
Message-ID: <07401a0a-6878-6af2-f663-9f0c3c1d88e5@redhat.com>
Date:   Fri, 11 Mar 2022 10:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220310172633.9151-1-alex.sierra@amd.com>
 <20220310172633.9151-2-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] mm: split vm_normal_pages for LRU and non-LRU
 handling
In-Reply-To: <20220310172633.9151-2-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10.03.22 18:26, Alex Sierra wrote:
> DEVICE_COHERENT pages introduce a subtle distinction in the way
> "normal" pages can be used by various callers throughout the kernel.
> They behave like normal pages for purposes of mapping in CPU page
> tables, and for COW. But they do not support LRU lists, NUMA
> migration or THP. Therefore we split vm_normal_page into two
> functions vm_normal_any_page and vm_normal_lru_page. The latter will
> only return pages that can be put on an LRU list and that support
> NUMA migration, KSM and THP.
> 
> We also introduced a FOLL_LRU flag that adds the same behaviour to
> follow_page and related APIs, to allow callers to specify that they
> expect to put pages on an LRU list.
> 

I still don't see the need for s/vm_normal_page/vm_normal_any_page/. And
as this patch is dominated by that change, I'd suggest (again) to just
drop it as I don't see any value of that renaming. No specifier implies any.

The general idea of this change LGTM.


I wonder how this interacts with the actual DEVICE_COHERENT coherent
series. Is this a preparation? Should it be part of the DEVICE_COHERENT
series?

IOW, should this patch start with

"With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
device-managed anonymous pages that are not LRU pages. Although they
behave like normal pages for purposes of mapping in CPU page, and for
COW, they do not support LRU lists, NUMA migration or THP. [...]"

But then, I'm confused by patch 2 and 3, because it feels more like we'd
already have DEVICE_COHERENT then ("hmm_is_coherent_type").


-- 
Thanks,

David / dhildenb

