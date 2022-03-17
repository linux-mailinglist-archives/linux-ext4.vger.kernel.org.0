Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D404DC0C0
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Mar 2022 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiCQIPQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Mar 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiCQIPP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Mar 2022 04:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA128141DBD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Mar 2022 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647504834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxA0Pce6UnOZWW6gsq8il76yFsehAiTQ6twP7i/3/GQ=;
        b=i9ocHWQ4ruFxw25UNHFShxytWepuLkCReLw3lss3KN+Ovdfa+ThGwCIDnbPe+jitf0YTPx
        WF9pB+KJo/PISDHdtLt+ZatBzQgNYNCrmOreUoawU/NJtuLinQHJBwIi1fZ9OVCMcE+0Jf
        5bJ3tJrBaRJf/FEfQG8DJeuaU6A6X/Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-SrmON4lqNbqj9K5IS5nAYQ-1; Thu, 17 Mar 2022 04:13:53 -0400
X-MC-Unique: SrmON4lqNbqj9K5IS5nAYQ-1
Received: by mail-wr1-f72.google.com with SMTP id t15-20020a5d534f000000b001f1e5759cebso1299253wrv.7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Mar 2022 01:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xxA0Pce6UnOZWW6gsq8il76yFsehAiTQ6twP7i/3/GQ=;
        b=2TbtfITGdif7dMoBA6lEQEXqqU4pCTyaBrWPiwTD4XdspD1O9NzpMFs8Mrk83WTNuH
         acX8fLZAbJNxR4sRNeFW+Q3bo1VM+SSAxNfDDiRJrr+shGd4ptKQ0X3bZsEjw6btAoxB
         iYEG16rQoysdBYWTU2WCi1uLMFSf/tngvCtUl3ZE0s3x++eBXWmViCGDWVB84AOxolSX
         xx5towTgwuzQn8sDsfLJ4wYpLYnu9lgTExwqa0SKhDnctkHWoR11nuD8EVph4WhK3IRf
         F0fHDO867go24UEe7F2Hmx3FP9oEMMU0wI7CLy4raQ/R+ctLvjPc7o739weBaXg0thbu
         Lu9Q==
X-Gm-Message-State: AOAM531AYq3t45kXCQYGHeyBufLTnyuZjyYDRI3wlgebpXHfrHIej/u+
        J2emG64ApK26s4dc0oSb4XcFN5a/YGRCC8tbCoYhe4W3NVfwW020Le4Xd9JA2oA//Q+2t9dHtns
        hi+T3qe9qK698RmEXMkRVZw==
X-Received: by 2002:a05:6000:144a:b0:203:8688:35d with SMTP id v10-20020a056000144a00b002038688035dmr2896887wrx.399.1647504832457;
        Thu, 17 Mar 2022 01:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkIygRnwahr8xhyLvIiK8lTpLSYuqqmv1avWZ31V4hbmg8hvmgWPIvr5DZvtTFDGtJ3e2QVw==
X-Received: by 2002:a05:6000:144a:b0:203:8688:35d with SMTP id v10-20020a056000144a00b002038688035dmr2896866wrx.399.1647504832168;
        Thu, 17 Mar 2022 01:13:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:d000:22e9:afb1:c890:7468? (p200300cbc707d00022e9afb1c8907468.dip0.t-ipconnect.de. [2003:cb:c707:d000:22e9:afb1:c890:7468])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c410700b0038c72ef3f15sm2542317wmi.38.2022.03.17.01.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:13:51 -0700 (PDT)
Message-ID: <ab26f7a0-728e-9627-796b-e8e850402aae@redhat.com>
Date:   Thu, 17 Mar 2022 09:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 1/3] mm: split vm_normal_pages for LRU and non-LRU
 handling
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, willy@infradead.org,
        akpm@linux-foundation.org
References: <20220310172633.9151-1-alex.sierra@amd.com>
 <20220310172633.9151-2-alex.sierra@amd.com>
 <07401a0a-6878-6af2-f663-9f0c3c1d88e5@redhat.com>
 <1747447c-202d-9195-9d44-57f299be48c4@amd.com>
 <87lex98dtg.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87lex98dtg.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 17.03.22 03:54, Alistair Popple wrote:
> Felix Kuehling <felix.kuehling@amd.com> writes:
> 
>> On 2022-03-11 04:16, David Hildenbrand wrote:
>>> On 10.03.22 18:26, Alex Sierra wrote:
>>>> DEVICE_COHERENT pages introduce a subtle distinction in the way
>>>> "normal" pages can be used by various callers throughout the kernel.
>>>> They behave like normal pages for purposes of mapping in CPU page
>>>> tables, and for COW. But they do not support LRU lists, NUMA
>>>> migration or THP. Therefore we split vm_normal_page into two
>>>> functions vm_normal_any_page and vm_normal_lru_page. The latter will
>>>> only return pages that can be put on an LRU list and that support
>>>> NUMA migration, KSM and THP.
>>>>
>>>> We also introduced a FOLL_LRU flag that adds the same behaviour to
>>>> follow_page and related APIs, to allow callers to specify that they
>>>> expect to put pages on an LRU list.
>>>>
>>> I still don't see the need for s/vm_normal_page/vm_normal_any_page/. And
>>> as this patch is dominated by that change, I'd suggest (again) to just
>>> drop it as I don't see any value of that renaming. No specifier implies any.
>>
>> OK. If nobody objects, we can adopts that naming convention.
> 
> I'd prefer we avoid the churn too, but I don't think we should make
> vm_normal_page() the equivalent of vm_normal_any_page(). It would mean
> vm_normal_page() would return non-LRU device coherent pages, but to me at least
> device coherent pages seem special and not what I'd expect from a function with
> "normal" in the name.
> 
> So I think it would be better to s/vm_normal_lru_page/vm_normal_page/ and keep
> vm_normal_any_page() (or perhaps call it vm_any_page?). This is basically what
> the previous incarnation of this feature did:
> 
> struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>                             pte_t pte, bool with_public_device);
> #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
> 
> Except we should add:
> 
> #define vm_normal_any_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, true)
> 

"normal" simply tells us that this is not a special mapping -- IOW, we
want the VM to take a look at the memmap and not treat it like a PFN
map. What we're changing is that we're now also returning non-lru pages.
Fair enough, that's why we introduce vm_normal_lru_page() as a
replacement where we really can only deal with lru pages.

vm_normal_page vs vm_normal_lru_page is good enough. "lru" further
limits what we get via vm_normal_page, that's even how it's implemented.

vm_normal_page vs vm_normal_any_page is confusing IMHO.


-- 
Thanks,

David / dhildenb

