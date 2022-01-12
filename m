Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3CA48C2F4
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jan 2022 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiALLQZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jan 2022 06:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352796AbiALLQV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 12 Jan 2022 06:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641986178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvfHccyQZvOEcbK/VSQsdfq4siS9aIa44pr1d+OE6yo=;
        b=HAM4Il6slJmF4EmtKpGjyeeL8xlTIFltXg4ZPoASTrVwFNtqYr55YSpL8x4bWGEnbIKuKF
        XI9NBn+TCDKEBfIDYg+dOb9pQWBV7SpUfOO3dsfsBOFsz+s+7o/DM0kGE7QiOhOXxQWSBH
        IFfKXHR7mbj53V6LhC9A3fbeA+OZh2s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-rwcQtYMZNGaJixabacrDNQ-1; Wed, 12 Jan 2022 06:16:15 -0500
X-MC-Unique: rwcQtYMZNGaJixabacrDNQ-1
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so1958829edc.9
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jan 2022 03:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rvfHccyQZvOEcbK/VSQsdfq4siS9aIa44pr1d+OE6yo=;
        b=vRFTxneG7TMgY6ho6IPydSAu3tH4bcadetOfta9+pP93RE9XeJm3D7e2x+mKqajYRP
         LvUi5r02jXPHWDevttpeQfkKgoel8vfjii88FaVuKK5hKGemGkPPN3j4gx+Ubszr8Uh+
         DxNoa/8xQtA/f29Z5WqFwfhT8WwBQEqN6Si8bERk4wE5fDpY8mOL8CFWLONIpCkA6EtV
         1u87QV13EGptTZ3t9P5CFFnkABefbKJ5eyiKvF9bL6r0y6a9T0L6dtrBnJgRE1HI411N
         0l2BO9WmYbV6EogPsVyNWsb6g3HegjBxXp9+2aHh6rPXr9cjvdMWDuaBl/y8ApyuCi0e
         qzSA==
X-Gm-Message-State: AOAM533a3jsNU2YMI++6l7FhbEm2UTc+bbNZHb9JICGUmFY4549DvsXc
        P8G93Sx3WkshXxhWX1OHQTiRdjYsz71CgALzhjF5JCB7fznU30weRQjGN5lGJJCaCaZu1f89fNH
        U3Lg0r6ZALzXiN1qtZ18xIA==
X-Received: by 2002:a17:906:974a:: with SMTP id o10mr7201044ejy.226.1641986174389;
        Wed, 12 Jan 2022 03:16:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylcjOYtqv8QO2gzLMiyLf36NeGdQwoe97SOgETUwT3484y0JFJN63XyHPi2xLKoaaQHMvZ5w==
X-Received: by 2002:a17:906:974a:: with SMTP id o10mr7201027ejy.226.1641986174194;
        Wed, 12 Jan 2022 03:16:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id f18sm6068251edf.95.2022.01.12.03.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:16:13 -0800 (PST)
Message-ID: <8c4df8e4-ef99-c3fd-dcca-759e92739d4c@redhat.com>
Date:   Wed, 12 Jan 2022 12:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 00/10] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
References: <20220110223201.31024-1-alex.sierra@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220110223201.31024-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10.01.22 23:31, Alex Sierra wrote:
> This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> owned by a device that can be mapped into CPU page tables like
> MEMORY_DEVICE_GENERIC and can also be migrated like
> MEMORY_DEVICE_PRIVATE.
> 
> Christoph, the suggestion to incorporate Ralph Campbell’s refcount
> cleanup patch into our hardware page migration patchset originally came
> from you, but it proved impractical to do things in that order because
> the refcount cleanup introduced a bug with wide ranging structural
> implications. Instead, we amended Ralph’s patch so that it could be
> applied after merging the migration work. As we saw from the recent
> discussion, merging the refcount work is going to take some time and
> cooperation between multiple development groups, while the migration
> work is ready now and is needed now. So we propose to merge this
> patchset first and continue to work with Ralph and others to merge the
> refcount cleanup separately, when it is ready.
> 
> This patch series is mostly self-contained except for a few places where
> it needs to update other subsystems to handle the new memory type.
> System stability and performance are not affected according to our
> ongoing testing, including xfstests.
> 
> How it works: The system BIOS advertises the GPU device memory
> (aka VRAM) as SPM (special purpose memory) in the UEFI system address
> map.
> 
> The amdgpu driver registers the memory with devmap as
> MEMORY_DEVICE_COHERENT using devm_memremap_pages. The initial user for
> this hardware page migration capability is the Frontier supercomputer
> project. This functionality is not AMD-specific. We expect other GPU
> vendors to find this functionality useful, and possibly other hardware
> types in the future.
> 
> Our test nodes in the lab are similar to the Frontier configuration,
> with .5 TB of system memory plus 256 GB of device memory split across
> 4 GPUs, all in a single coherent address space. Page migration is
> expected to improve application efficiency significantly. We will
> report empirical results as they become available.

Hi,

might be a dumb question because I'm not too familiar with
MEMORY_DEVICE_COHERENT, but who's in charge of migrating *to* that
memory? Or how does a process ever get a grab on such pages?

And where does migration come into play? I assume migration is only
required to migrate off of that device memory to ordinary system RAM
when required because the device memory has to be freed up, correct?

(a high level description on how this is exploited from users space
would be great)

-- 
Thanks,

David / dhildenb

