Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81B35624A4
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 22:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiF3U4Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Jun 2022 16:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiF3U4Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Jun 2022 16:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0022E3F89F
        for <linux-ext4@vger.kernel.org>; Thu, 30 Jun 2022 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656622574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cs91WyVesi99NqFGAEv3+PryqGuZwEkmE4TutiLYwN4=;
        b=GFobmnGzXZZ5xmq3c4odqlUMDeXoILxDr9NNxFFeNpLmygnKHi5wadatfEXfqiAusZeY8p
        XFLpYysngdgHl7DIvQiBeKeHYH4iMLDWgBHCg1Z18BgLuUbt9Ib/hSCVZsh/uzRm7tQVzn
        wxBh8wjpIPTMVpKqhUf1veo9hHIu4sE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-82JKDJA-N5WYcOXwkye-ug-1; Thu, 30 Jun 2022 16:56:05 -0400
X-MC-Unique: 82JKDJA-N5WYcOXwkye-ug-1
Received: by mail-wm1-f72.google.com with SMTP id v8-20020a05600c214800b003a1819451b1so224898wml.7
        for <linux-ext4@vger.kernel.org>; Thu, 30 Jun 2022 13:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=cs91WyVesi99NqFGAEv3+PryqGuZwEkmE4TutiLYwN4=;
        b=IIdqHX36Sv+geS05ABnHTgsLVrI2cn4CvQFGTB5OPfJhgGv2sjVzrrKqF8LSjm+A+u
         ldDQzAEpSgTxJKTmvjPjKwO0lof5HIaOPVQgUpUz7dF03jFV7/VSQHo24KOLd9YvNobz
         u0cF+H2Lh4T3//pSm+gGsx3qQTP3llyPcRUs5gRwnQ5IfAQcjr/jUck4W7wAT59io8RZ
         4z3Nsm9weLEY28C49PyHOk51BuIuckI7IbWlCY+jAGUSA0vGuqgVTyzQUaMX6siClwhz
         hD8clhooeDcAQk49r/H9yji+4ygBMILXsup7a0PADiF0jcpmzRXXyDMxiBX2hzxP2BJ/
         tW9A==
X-Gm-Message-State: AJIora9mCPtlZ03lvu1mNY4UNJHRUhSaQXyzeKOk8AyE3Dr0j6oaKT2u
        NlC+1skyjXeg2+lIerXstxQadh3+MYhSagtHNxhhaloAXpXdyGN78bM4Ga7rhseQfG/xdqOWIiH
        +7Q4Ou75r3j5s6cUzVvCLxg==
X-Received: by 2002:a05:600c:22d0:b0:3a0:3bb9:3936 with SMTP id 16-20020a05600c22d000b003a03bb93936mr14637980wmg.137.1656622563847;
        Thu, 30 Jun 2022 13:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulPmxkj72HO5yHWbkMgKLlGDzSAl2x3/KwnxpkCAD53J5CgIe7BBJs8xjCIGOLRUODCIR27Q==
X-Received: by 2002:a05:600c:22d0:b0:3a0:3bb9:3936 with SMTP id 16-20020a05600c22d000b003a03bb93936mr14637943wmg.137.1656622563542;
        Thu, 30 Jun 2022 13:56:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:7f00:214b:cffb:c693:2b71? (p200300cbc7087f00214bcffbc6932b71.dip0.t-ipconnect.de. [2003:cb:c708:7f00:214b:cffb:c693:2b71])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c064300b0039c8a22554bsm7666219wmm.27.2022.06.30.13.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 13:56:02 -0700 (PDT)
Message-ID: <24577304-15ea-0c9c-9b73-946143bf2726@redhat.com>
Date:   Thu, 30 Jun 2022 22:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, willy@infradead.org,
        akpm@linux-foundation.org
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-5-alex.sierra@amd.com>
 <956b1c51-b8f1-0480-81ca-5d03b45110f7@redhat.com>
 <878rpe73t3.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 04/14] mm: add device coherent vma selection for memory
 migration
In-Reply-To: <878rpe73t3.fsf@nvdebian.thelocal>
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

On 30.06.22 13:44, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 29.06.22 05:54, Alex Sierra wrote:
>>> This case is used to migrate pages from device memory, back to system
>>> memory. Device coherent type memory is cache coherent from device and CPU
>>> point of view.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Reviewed-by: Alistair Poppple <apopple@nvidia.com>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>>
>> I'm not too familiar with this code, please excuse my naive questions:
>>
>>> @@ -148,15 +148,21 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>  			if (is_writable_device_private_entry(entry))
>>>  				mpfn |= MIGRATE_PFN_WRITE;
>>>  		} else {
>>> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
>>> -				goto next;
>>
>> Why not exclude MIGRATE_VMA_SELECT_DEVICE_PRIVATE here? IIRC that would
>> have happened before this change.
> 
> I might be missing something as I don't quite follow - this path is for
> normal system pages so we only want to skip selecting them if
> MIGRATE_VMA_SELECT_SYSTEM or MIGRATE_VMA_SELECT_DEVICE_COHERENT aren't
> set.
> 
> Note that MIGRATE_VMA_SELECT_DEVICE_PRIVATE doesn't apply here because
> we already know it's not a device private page by virtue of
> pte_present(pte) == True.

Ah, stupid me, pte_present(pte) is the key.

> 
>>>  			pfn = pte_pfn(pte);
>>> -			if (is_zero_pfn(pfn)) {
>>> +			if (is_zero_pfn(pfn) &&
>>> +			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>>>  				mpfn = MIGRATE_PFN_MIGRATE;
>>>  				migrate->cpages++;
>>>  				goto next;
>>>  			}
>>>  			page = vm_normal_page(migrate->vma, addr, pte);
>>> +			if (page && !is_zone_device_page(page) &&
>>
>> I'm wondering if that check logically belongs into patch #2.
> 
> I don't think so as it would break functionality until the below
> conditionals are added - we explicitly don't want to skip
> is_zone_device_page(page) == False here because that is the pages we are
> trying to select.
> 
> You could add in this:
> 
>>> +			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> 
> But then in patch 2 we know this can never be true because we've already
> checked for !MIGRATE_VMA_SELECT_SYSTEM there.


Ah, okay, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

