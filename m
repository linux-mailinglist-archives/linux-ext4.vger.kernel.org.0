Return-Path: <linux-ext4+bounces-11024-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F59BFFA0E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 09:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169893AFEE7
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A72DE6E3;
	Thu, 23 Oct 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKNxvX8V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A12C21E5
	for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204276; cv=none; b=fmTO4lK3iPsgJmlfsN+Ic3rMgQwC/zDwSCAtlqygMv/4aPUGhFuxV7HJwd4tUUVNwX02ZtUPGd37OrZX1bH+U7uOrnpL0PgWkoFNkjJKmGkVydE5dfg2zMtJUqRmPDWYXbv130mtEyH7cxqjJL0UPde3rcQfGAW4itmvy+DWCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204276; c=relaxed/simple;
	bh=g90FtKRGBv7vo++NwfJk3w9Fd3Q0nz/7WUkW69ugyyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs8I38qghlySDvzIOg5emGAiAnT3PpZAcsYl1mPVkSsBqJEXdz9l9F3q2lsnFsDRHdLdjVz+s/ELXtCoYSv6z7jNwPpJ9UeMJp89jMBskfxoXufHqvNNnYybCf63Kw68deXnBrdbGFNZfY5fjTAQRB+jWonq8AJGMiEvYhKFfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKNxvX8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761204273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=At4MrgAP9F7GQPooz+KssPb3r2AaqOOpWbjQGvPMAWQ=;
	b=MKNxvX8V8w0vfufVko4fb7HrStfEWAO9qyjYQ388p8MpTKCeFc6gyXYWqb1FZY0d5z0BK2
	dNw847GXePnBpOcBGO2cROYIxV14PX2vH/xvQdsT8ga3VgXftQGNAETGxVcBSmGWHg/8UX
	FJY7kafrJJCy3VZ29F33HvI9AbWaiMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-4UukJjOQOIm3Vdpk8VzGuQ-1; Thu, 23 Oct 2025 03:24:31 -0400
X-MC-Unique: 4UukJjOQOIm3Vdpk8VzGuQ-1
X-Mimecast-MFC-AGG-ID: 4UukJjOQOIm3Vdpk8VzGuQ_1761204270
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427a125c925so246666f8f.2
        for <linux-ext4@vger.kernel.org>; Thu, 23 Oct 2025 00:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204270; x=1761809070;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=At4MrgAP9F7GQPooz+KssPb3r2AaqOOpWbjQGvPMAWQ=;
        b=MPmCyD3w5jS//WlNEHSnNAtgfayb37lRVAm+NcCVvqikJrZe7d7GITUq6yzQJn0EuH
         LA7KEJjGVaknw4Q9dvNxEvDpT0udll97uT29ijn8envaQZ8X/C27iLWNmZBRB6Oo0j23
         xKIkCAEKcHa7dqYlduEHsUr0nYju70YlL1GynmLfGl/8RBAM+RjZaQfe4bB5LGzRfSDF
         fS/Odf267La3tegHFbXUDohYGr/YQNC2jMaRC5eHU7WSBwLXj4Q8+IW56KTqb9kXBxio
         c/87K5K1RTxs5BmaRqrvv8xLvgT2YHDIDMkE+n+nGGuKjgFI3zwo3C1wEdrLSlv7GbD4
         BbCg==
X-Forwarded-Encrypted: i=1; AJvYcCXiM72hbkqBydxd8D3GXgx26bX0sk292towiWULdgV+FXgb3sLA4RDxrIAJ12zXTYLSUvehYjrD+Q5r@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoJiNqjwIp0nsxLX+rfCYWV5+GJKj3J7i1eqUUn4kMLG+Llmk
	TLlc1xkC8l3I88L+rDta73zetak92O0wUch9KpLhTyCDpEu3/8VmhA2YFjN5HcJPSMCcjy68l4r
	CVdwz7HC9VWu0KgJF3+akMUfyGFdEOIuBByPg0FGx+t85Zlbbp0rUsRsObIJkWes=
X-Gm-Gg: ASbGncvvhu82tUgJ2ds2SHck+MS/jOotGNa0R9P0amDKx6grlIiu3RbTApo654ywIiH
	a32PMKuYdZCkEYLs/eP1UNY7iG4BIjmtTMupXnVhxYZk9mbrFZob9pgAPFLtyiU3Xdg0weINQiP
	fJFLMpwYEBK0STuqRV0yrADf68a5xhsRNc17Nd04WA0UpVc9tUh/ZV7GYNt9LcU/OHy/vuj8Q2n
	4v8qblBITHrJgIR8wpwKzfMbd9jX9B1bf69A/e15Vgx/W7NDTbA/5ZYvjpYU+AYFjR7/sD0ge5D
	w8KW0nj/G7+rvLmDeEZ/87Sj2Lcax5VfcXOMEpU7ZhGzBf0Z17OPwm0qJQqh29HU2Dyv4JcnGR0
	zovtE+1G3ykqa4dSVsRm9kp3BAHjI6wA=
X-Received: by 2002:a05:6000:4202:b0:426:d82f:889e with SMTP id ffacd0b85a97d-42704d74dc8mr17413741f8f.14.1761204269951;
        Thu, 23 Oct 2025 00:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBeaZeBjNlT5I0rpSARhRSXau88x2Xc7FXWiFhfLb1011+8VdGMBFcPxLi9mgKNY+vLoBXcQ==
X-Received: by 2002:a05:6000:4202:b0:426:d82f:889e with SMTP id ffacd0b85a97d-42704d74dc8mr17413724f8f.14.1761204269544;
        Thu, 23 Oct 2025 00:24:29 -0700 (PDT)
Received: from [192.168.3.141] (p57a1af76.dip0.t-ipconnect.de. [87.161.175.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ebf82sm2481947f8f.42.2025.10.23.00.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:24:29 -0700 (PDT)
Message-ID: <41f30998-e498-4c33-a4b4-99b9f7339fd7@redhat.com>
Date: Thu, 23 Oct 2025 09:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible regression in pin_user_pages_fast() behavior after
 commit 7ac67301e82f ("ext4: enable large folio for regular file")
To: Zhang Yi <yi.zhang@huaweicloud.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org
References: <ebe38d8f-0b09-47b8-9503-2d8e0585672a@huaweicloud.com>
 <20251020084736.591739-1-karol.wachowski@linux.intel.com>
 <0fec500c-52ea-473d-b276-826c0f4dd76f@huaweicloud.com>
 <43cc7217-93bc-4ee6-99d2-83d9b26eb31a@redhat.com>
 <610d89e2-6970-4924-824b-f27a2424979b@huaweicloud.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <610d89e2-6970-4924-824b-f27a2424979b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> __split_huge_pmd_locked() contains that handling.
>>
>> We have to do that because we did not preallocate a page table we can just throw in.
>>
>> We could do that on this path instead: remap the PMD to be mapped by a PTE table. We'd have to preallocate a page table.
>>
>> That would avoid the do_pte_missing() below for such faults.
>>
>> that could be done later on top of this fix.
> 
> Yeah, thank you for the explanation! I have another question, just curious.
> Why do we have to fall back to installing the PTE table instead of creating
> a new anonymous large folio (2M) and setting a new leaf huge PMD?

Primarily because it would waste more memory for various use cases, on a 
factor of 512.

> 
>>
>>>     |     handle_pte_fault()  //
>>>     |      do_pte_missing()
>>>     |       do_fault()
>>>     |        do_read_fault() //FAULT_FLAG_WRITE is not set
>>>     |         finish_fault()
>>>     |          do_set_pmd() //install leaf pmd again, I think this is wrong!!!
>>>     |      do_wp_page() //copy private anno pages
>>>     <-    goto retry
>>>
>>> Due to an incorrectly large PMD set in do_read_fault(), follow_pmd_mask()
>>> always returns -EMLINK, causing an infinite loop. Under normal
>>> circumstances, I suppose it should fall back to do_wp_page(), which installs
>>> the anonymous page into the PTE. This is also why mappings smaller than 2MB
>>> do not trigger this issue. In addition, if you add FOLL_WRITE when calling
>>> pin_user_pages_fast(), it also will not trigger this issue becasue do_fault()
>>> will call do_cow_fault() to create anonymous pages.
>>>
>>> The above is my analysis, and I tried the following fix, which can solve
>>> the issue (I haven't done a full test yet). But I am not expert in the MM
>>> field, I might have missed something, and this needs to be reviewed by MM
>>> experts.
>>>
>>> Best regards,
>>> Yi.
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 74b45e258323..64846a030a5b 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5342,6 +5342,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>>>        if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>>>            return ret;
>>>
>>> +    if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE) &&
>>> +        !pmd_write(*vmf->pmd))
>>> +        return ret;
>>
>> Likely we would want to make this depend on is_cow_mapping().
>>
>> /*
>>   * We're about to trigger CoW, so never map it through a PMD.
>>   */
>> if (is_cow_mapping(vma->vm_flags &&
>>      vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)))
>>      return ret;
>>
> 
> Sure, adding a cow check would be better. I will send out an official patch.

Thanks!

-- 
Cheers

David / dhildenb


