Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BDE5704B8
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiGKNxb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiGKNxU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 09:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 167856714F
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657547582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiDFw+H9wQAOoFgenmknWW5ulkS2E0Ovm/60i012Tps=;
        b=bty9a/+z0po9y951Q9OaFfA4QOPqe//PWk8MD1gR4J0tKzF3NylJ2ikslSpTq9YG4OvP7i
        xooGpKzVJfRxbNJ5eZrWgD2cqsH9lt06u43E8EC7+ZAaRx9+vN2625MUD/SQzsAHzOiWUI
        wCo6BpOdZR4E9TR57FWW76ri8KkSSUc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-oUD0MFdNM5us2YNIFDF2FA-1; Mon, 11 Jul 2022 09:53:01 -0400
X-MC-Unique: oUD0MFdNM5us2YNIFDF2FA-1
Received: by mail-wm1-f70.google.com with SMTP id m20-20020a05600c4f5400b003a03aad6bdfso2695685wmq.6
        for <linux-ext4@vger.kernel.org>; Mon, 11 Jul 2022 06:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=TiDFw+H9wQAOoFgenmknWW5ulkS2E0Ovm/60i012Tps=;
        b=z7ZydQ4aORlRNzIlytQe0t+7aii4MlF7Y4P7BB8P20lGbScQFcb+8qbBbBDa1e58Zc
         fCepq6rVwJUrL4ijLiG23YZk1+pNQ+tXZYoj83Txnq0sKUEPBexXQucpk9KJUzTblWtS
         YQTcvAX86trIQDC7+roYHWq83zwj3KcAFzSulT7tvitwd4vGyY+d5sNjp0F6/B1/IyZz
         oJ7vulfD6k1pAfyEuP/Xwe7lJ9OTp15/EbIxopvdXktEz2MtKag4dUMUlhCj9ocCuA1C
         u1nICEj2kg4mkJAScyXhgqcQ6NrWn+EmGOzSaAM4bN9TgMDeXfM4Ep/jn8zrL5E1+h1k
         X8Tg==
X-Gm-Message-State: AJIora/XA8I5v+YiKE1EATK2xSV6AtwNNSGm6+Wt05fkDaPugLOTqHsV
        XhvsNbMtNtVs2eGgrAw8bzOl591me2HYM8l0rVN1PNvUCo47S2IZhGkDdvxo9BLjErs+OWpM0La
        zIJROy5x800dlQWPgHQoeow==
X-Received: by 2002:adf:f151:0:b0:21d:76a7:76d3 with SMTP id y17-20020adff151000000b0021d76a776d3mr16557690wro.702.1657547579797;
        Mon, 11 Jul 2022 06:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVRhLI1q2NxvdCqXB46XQEdcekPaWp69NFcGLqv0djixdSMTe1BzXGsV30YFN4gPC0osccbA==
X-Received: by 2002:adf:f151:0:b0:21d:76a7:76d3 with SMTP id y17-20020adff151000000b0021d76a776d3mr16557660wro.702.1657547579573;
        Mon, 11 Jul 2022 06:52:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1400:c3:4ae0:6d5c:1ab2? (p200300cbc702140000c34ae06d5c1ab2.dip0.t-ipconnect.de. [2003:cb:c702:1400:c3:4ae0:6d5c:1ab2])
        by smtp.gmail.com with ESMTPSA id z15-20020a056000110f00b0021d6c7a9f50sm6200486wrw.41.2022.07.11.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 06:52:58 -0700 (PDT)
Message-ID: <7a772ca0-0c82-2251-dd54-8ad466774e99@redhat.com>
Date:   Mon, 11 Jul 2022 15:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-7-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 06/15] mm: remove the vma check in migrate_vma_setup()
In-Reply-To: <20220707190349.9778-7-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 07.07.22 21:03, Alex Sierra wrote:
> From: Alistair Popple <apopple@nvidia.com>
> 
> migrate_vma_setup() checks that a valid vma is passed so that the page
> tables can be walked to find the pfns associated with a given address
> range. However in some cases the pfns are already known, such as when
> migrating device coherent pages during pin_user_pages() meaning a valid
> vma isn't required.

As raised in my other reply, without a VMA ... it feels odd to use a
"migrate_vma" API. For an internal (mm/migrate_device.c) use case it is
ok I guess, but it certainly adds a bit of confusion. For example,
because migrate_vma_setup() will undo ref+lock not obtained by it.

I guess the interesting point is that

a) Besides migrate_vma_pages() and migrate_vma_setup(), the ->vma is unused.

b) migrate_vma_setup() does collect+unmap+cleanup if unmap failed.

c) With our source page in our hands, we cannot be processing a hole in
a VMA.



Not sure if it's better. but I would

a) Enforce in migrate_vma_setup() that there is a VMA. Code outside of
mm/migrate_device.c shouldn't be doing some hacks like this.

b) Don't call migrate_vma_setup() from migrate_device_page(), but
directly migrate_vma_unmap() and add a comment.


That will leave a single change to this patch (migrate_vma_pages()). But
is that even required? Because ....

> @@ -685,7 +685,7 @@ void migrate_vma_pages(struct migrate_vma *migrate)
>  			continue;
>  		}
>  
> -		if (!page) {
> +		if (!page && migrate->vma) {

How could we ever have !page in case of migrate_device_page()?

Instead, I think a VM_BUG_ON(migrate->vma); should hold and you can just
simplify.

>  			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
>  				continue;
>  			if (!notified) {
-- 
Thanks,

David / dhildenb

