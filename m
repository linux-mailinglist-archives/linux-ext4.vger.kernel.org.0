Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF04B6BD4
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Feb 2022 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiBOMP5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Feb 2022 07:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbiBOMPw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Feb 2022 07:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EFEE1074D8
        for <linux-ext4@vger.kernel.org>; Tue, 15 Feb 2022 04:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644927342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=li59JkksonHEim8N19eLLyTcVUoQZhmnR79T7jisS84=;
        b=VzmYcxfB7+4gKXnH4m7ZuMtf78Wddqp48GIGOTv3EkS1MehitFAvU5Xlj2gJAPaFnm7+0r
        GUHmSWn4oINWhCkgv6AB4uVnm+emClkffN47vkNxO8p1QRO2meMmNk0YYEq//FCOReqDj+
        f4xgKiP5C6bcKEP01aV4c1iPjb9ggqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-ycF_ZAAcOiGDzc5-p2jsbQ-1; Tue, 15 Feb 2022 07:15:40 -0500
X-MC-Unique: ycF_ZAAcOiGDzc5-p2jsbQ-1
Received: by mail-wm1-f72.google.com with SMTP id n3-20020a05600c294300b0037bc685b717so500293wmd.8
        for <linux-ext4@vger.kernel.org>; Tue, 15 Feb 2022 04:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=li59JkksonHEim8N19eLLyTcVUoQZhmnR79T7jisS84=;
        b=4YQcoG0fkHvuTwaF1p9FCC3rL1eCS3YVEXYoUQdzbANDtAZqqTL72pZfjrrNCUIGWQ
         MwonjfWGDPutJZAQDhvDqDelxo2nihDQ5qtc/X2ins6zx5iTWg0Yu1111DOfIHPubafk
         oO1GCWO0ZFLWK5z+sc3t4feWmV453r2ch2UkciJphjMu7npaOiS2m3VomnFm258dU3Sa
         f8QdK3UDhI877tshbaMbs4QWnjb5tafZcEr9Y7E7wF8coOBwA2joTYxh4BZg5r5wnJVs
         ANPo28k42vlw2uUmRUH83NS/xnSlQKIdlXYnt2Dn0qP8t8GU268hYW8yzk9M7ZTR6kC0
         2yeA==
X-Gm-Message-State: AOAM530AiRn6nYTOHNf4q/ZlE3z3vTQI1leHj9hmbe0nEX1/2ZH2crKd
        izw7Dp6ev1Np8YtFzT7ankeQsHoVcn9nhYb9Z9gSklzxpgpKpjIMhOMT9r0VboJls9/qcbMVuIv
        j+snUS9ADzrMf7UTIn1zEhA==
X-Received: by 2002:a05:6000:2ac:: with SMTP id l12mr3048026wry.639.1644927339751;
        Tue, 15 Feb 2022 04:15:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkXiKIPDmUKc3peLAnxWMPOpVfO+YZVnwiubxG8ybWR9d1yWHVTQW3fpFRYPoIV1z4/FG1xQ==
X-Received: by 2002:a05:6000:2ac:: with SMTP id l12mr3047997wry.639.1644927339488;
        Tue, 15 Feb 2022 04:15:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e? (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de. [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
        by smtp.gmail.com with ESMTPSA id u3sm18392835wmm.0.2022.02.15.04.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:15:39 -0800 (PST)
Message-ID: <7b830dc4-37bc-fb7b-c094-16595bd2a128@redhat.com>
Date:   Tue, 15 Feb 2022 13:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org
References: <20220201154901.7921-1-alex.sierra@amd.com>
 <20220201154901.7921-2-alex.sierra@amd.com>
 <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <20220211164537.GO4160@nvidia.com>
 <6a8df47e-96d0-ffaf-247a-acc504e2532b@redhat.com>
 <20220211165624.GP4160@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
In-Reply-To: <20220211165624.GP4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11.02.22 17:56, Jason Gunthorpe wrote:
> On Fri, Feb 11, 2022 at 05:49:08PM +0100, David Hildenbrand wrote:
>> On 11.02.22 17:45, Jason Gunthorpe wrote:
>>> On Fri, Feb 11, 2022 at 05:15:25PM +0100, David Hildenbrand wrote:
>>>
>>>> ... I'm pretty sure we cannot FOLL_PIN DEVICE_PRIVATE pages
>>>
>>> Currently the only way to get a DEVICE_PRIVATE page out of the page
>>> tables is via hmm_range_fault() and that doesn't manipulate any ref
>>> counts.
>>
>> Thanks for clarifying Jason! ... and AFAIU, device exclusive entries are
>> essentially just pointers at ordinary PageAnon() pages. So with DEVICE
>> COHERENT we'll have the first PageAnon() ZONE_DEVICE pages mapped as
>> present in the page tables where GUP could FOLL_PIN them.
> 
> This is my understanding
> 
> Though you probably understand what PageAnon means alot better than I
> do.. I wonder if it really makes sense to talk about that together
> with ZONE_DEVICE which has alot in common with filesystem originated
> pages too.

For me, PageAnon() means that modifications are visible only to the
modifying process. On actual CoW, the underlying page will get replaced
-- in the world of DEVICE_COHERENT that would mean that once you write
to a DEVICE_COHERENT you could suddenly have a !DEVICE_COHERENT page.

PageAnon() pages don't have a mapping, thus they can only be found in
MAP_ANON VMAs or in MAP_SHARED VMAs with MAP_PRIVATE. They can only be
found via a page table, and not looked up via the page cache (excluding
the swap cache).

So if we have PageAnon() pages on ZONE_DEVICE, they generally have the
exact same semantics as !ZONE_DEVICE pages, but the way they "appear" in
the page tables the allocation/freeing path differs -- I guess :)

... and as we want pinning semantics to be different we have to touch GUP.

> 
> I'm not sure what AMDs plan is here, is there an expecation that a GPU
> driver will somehow stuff these pages into an existing anonymous
> memory VMA or do they always come from a driver originated VMA?

My understanding is that a driver can just decide to replace "ordinary"
PageAnon() pages e.g., in a MAP_ANON VMA by these pages. Hopefully AMD
can clarify.


-- 
Thanks,

David / dhildenb

