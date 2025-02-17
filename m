Return-Path: <linux-ext4+bounces-6468-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE7A38CDF
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2025 20:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9122416D89E
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2025 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C4239567;
	Mon, 17 Feb 2025 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEv90QqL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313C238D39
	for <linux-ext4@vger.kernel.org>; Mon, 17 Feb 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822331; cv=none; b=nbfJuWxkQI4UQMLuPO4oapzIG6c8r4Bd7o2iaUqIAGuNMG7UvgPkXVVXADLuA7tg7GK8yXiqZCymZlK+b+qFyed3bQAzVd0cg6b7+UjYay0OKrziio6yvhZoJnT34juwHe7S6v5nBBOEsNT4jaD4sgZK+RwEPBpA+MdJHW2oKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822331; c=relaxed/simple;
	bh=H7EXqVyyi+kLT8T3AFWH4gU/uM442cOf8FS+Ncb8NkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzmBbCHJZJzKt8pEA0L+TYooYyJVJ/ngb0lIp1W2AxtB52bJcizt1Nn2nMfyWP82Ug1F6gyngc+/9WY9K0/+9wOpp7mxw94vm3jXJxXF0zMItc7EqvxawCRXjTWM31e2xSrcYsFEMvYqXtkyGJSpkvEZEfd3bq7S6DLgIRllsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEv90QqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739822328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NlktFKbt7fWOri2OGRbyYiQR64jGh1ap4Xy3JViDRMo=;
	b=XEv90QqLiwNBMjF1S27daonlXuEOOLHs7NrLdcZ852Eyi1X0g2ufVb6bYGyDj1wuiNUSyK
	OOBPeN7XymK/ge0Rmg+nO6mu7L5GXaisEI3ml3V4pcEkt4r95P8NqsEYp/9GUtEx4L6ur7
	MgBXpRf8Wjsgw/9gagCKLkl9aewXYac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-AVVzMD-WNvCxV6ahzMsBIw-1; Mon, 17 Feb 2025 14:58:46 -0500
X-MC-Unique: AVVzMD-WNvCxV6ahzMsBIw-1
X-Mimecast-MFC-AGG-ID: AVVzMD-WNvCxV6ahzMsBIw_1739822326
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f44be93a8so748839f8f.1
        for <linux-ext4@vger.kernel.org>; Mon, 17 Feb 2025 11:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822325; x=1740427125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlktFKbt7fWOri2OGRbyYiQR64jGh1ap4Xy3JViDRMo=;
        b=s8gUPNCv8e5GGWlEJPuEBSQJk81/gZJ7m6dcrPIZkiEYQPlA82SNPAMxYDV+iPapGO
         H/pofc9H11xw23qaF0bZPOiHfIAeHF3dBjzkvfnnJ3hfETB2ZzyKN6rcXepcy337XqB/
         SsngBl46GlcdRvNf0U4Z2kVOazIrsvWUqjS5XUQPYARrw+xHZUbothUJOkfzGSFLiAtW
         0NB6CkRLDzJ3YnDt2uwMw7d/mSa7r9n7x3TigA5Ys2JTb2yTAzBIM3nYxrogNtOMl+Ii
         gWEMbnew7bZowDH0aon/84QZbGQfQEQxPzIfUUtvrzp/40U93sHls2flw1pqFganGA+Q
         LZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi+8hvku/dGiiy8lj6Xl6RZoz9RsGgoSTTST8Au/U46Ej46ZystruTM7+rGanUFj/Z2YKYqLuA6mTr@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFRv9sbTNqFHpDKgSgb4MLn5NphJguqj4TcAMcqulKxUYHRVh
	AC+0640uH+WzhWoZTlHFrKzufenJ1HGyY4tW+ovWfy7RJu5eKeW44g2yNZAxzI5MLsSYCE+wOr0
	pKeOctrB+qzEtJ9w4kKZPgqd3zngq8vDtDilJ/7fmDD3W6yNWOrFvb5gFBu0=
X-Gm-Gg: ASbGnct9iMc7e3rrUzHXO+WH21tKphBpDSyHJNfotnBybrYjUYQvIPhteNOYbkrZ41z
	ALyckSDF9uIuuSUXruQ6jcb05ukxTCzNtwP26VjLy1Kk6SyoCPPH5SpW52nHPmAfAyBEdDxLOT4
	pmOkk/C9e7WYIHQ4fVEp3ajFdwzVUULc1F0zA7uW3yrR4vjqqUk0fvIi/N4uesQaLyWmMiPD2RE
	m6Lnxm3gPamz1SFYIcceu8qwJSNSl97EPsJ/LcDSjmDf9MCw+YBEjOEf7Z3xxBErRv3QowvtIMt
	lGjyq2mqtCy9BGAPRcPWlGgTmWpj4CnXotfxthTZ35p66RzMUPudllMXlbxCAh/CEPJKHhxMUs5
	ePy8Ib3AV5M6AwUczuWnpR7Rdz1LMCA==
X-Received: by 2002:a5d:4a43:0:b0:38f:3392:9fd8 with SMTP id ffacd0b85a97d-38f33f2cb57mr8062651f8f.18.1739822325471;
        Mon, 17 Feb 2025 11:58:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmnf+EH+x2w9Z3amJyvk4I4a5QL1krZ5SQiXGUsJvRabwqfhUp4vd7zVPxaXWLqtKKNwXS0Q==
X-Received: by 2002:a5d:4a43:0:b0:38f:3392:9fd8 with SMTP id ffacd0b85a97d-38f33f2cb57mr8062617f8f.18.1739822325081;
        Mon, 17 Feb 2025 11:58:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:900:900f:3c9e:2f7b:5d0a? (p200300cbc7390900900f3c9e2f7b5d0a.dip0.t-ipconnect.de. [2003:cb:c739:900:900f:3c9e:2f7b:5d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4118sm13425148f8f.18.2025.02.17.11.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 11:58:43 -0800 (PST)
Message-ID: <519c6ef7-ca56-4aac-8e43-f75b17353d66@redhat.com>
Date: Mon, 17 Feb 2025 20:58:38 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/20] huge_memory: Add vmf_insert_folio_pmd()
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
 Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <9f10e88441f3cb26eff6be0c9ef5997844c8c24e.1738709036.git-series.apopple@nvidia.com>
 <afff4368-9401-4943-b802-1b15bdcf5aaa@redhat.com>
 <6mmjoe27y63cfe5cycqje63gehgumod3bp7zzgvpz7qehgfuv4@uomvqgizba2m>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6mmjoe27y63cfe5cycqje63gehgumod3bp7zzgvpz7qehgfuv4@uomvqgizba2m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 05:29, Alistair Popple wrote:
> On Mon, Feb 10, 2025 at 07:45:09PM +0100, David Hildenbrand wrote:
>> On 04.02.25 23:48, Alistair Popple wrote:
>>> Currently DAX folio/page reference counts are managed differently to normal
>>> pages. To allow these to be managed the same as normal pages introduce
>>> vmf_insert_folio_pmd. This will map the entire PMD-sized folio and take
>>> references as it would for a normally mapped page.
>>>
>>> This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
>>> simply inserts a special devmap PMD entry into the page table without
>>> holding a reference to the page for the mapping.
>>>
>>> It is not currently useful to implement a more generic vmf_insert_folio()
>>> which selects the correct behaviour based on folio_order(). This is because
>>> PTE faults require only a subpage of the folio to be PTE mapped rather than
>>> the entire folio. It would be possible to add this context somewhere but
>>> callers already need to handle PTE faults and PMD faults separately so a
>>> more generic function is not useful.
>>>
>>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>
>> Nit: patch subject ;)
>>
>>>
>>> ---
>>>
>>> Changes for v7:
>>>
>>>    - Fix bad pgtable handling for PPC64 (Thanks Dan and Dave)
>>
>> Is it? ;) insert_pfn_pmd() still doesn't consume a "pgtable_t *"
>>
>> But maybe I am missing something ...
> 
> At a high-level all I'm trying to do (perhaps badly) is pull the ptl locking one
> level up the callstack.
> 
> As far as I can tell the pgtable is consumed here:
> 
> static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> 		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
> 		pgtable_t pgtable)
> 
> [...]
> 
> 	if (pgtable) {
> 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> 		mm_inc_nr_ptes(mm);
> 		pgtable = NULL;
> 	}
> 
> [...]
> 
> 	return 0;
> 
> Now I can see I failed to clean up the useless pgtable = NULL asignment, which
> is confusing because I'm not trying to look at pgtable in the caller (ie.
> vmf_insert_pfn_pmd()/vmf_insert_folio_pmd()) to determine if it needs freeing.
> So I will remove this assignment.

Ahhh, yes, the "pgtable = NULL" confused me, so I was looking for a 
"pgtable_t *pgtable" being passed instead, that we could manipulate.

> 
> Instead callers just look at the return code from insert_pfn_pmd() - if there
> was an error pgtable_trans_huge_deposit(pgtable) wasn't called and if the caller
> passed a pgtable it should be freed. Otherwise if insert_pfn_pmd() succeeded
> then callers can assume the pgtable was consumed by pgtable_trans_huge_deposit()
> and therefore should not be freed.
> 
> Hopefully that all makes sense, but maybe I've missed something obvious too...

Yes, you assume that if insert_pfn_pmd() succeeds, the table was 
consumed, otherwise it must be freed.

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


