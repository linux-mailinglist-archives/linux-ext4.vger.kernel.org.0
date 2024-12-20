Return-Path: <linux-ext4+bounces-5828-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200FC9F99D3
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 19:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6110F16DBC6
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8532163A6;
	Fri, 20 Dec 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0skO7Rv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616A21E0AD
	for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734720853; cv=none; b=ATO3OLHG2M/DkM6oQLdXZfTxnFVkrfueTnYdCTwFpvONlmvB1kSWLmsRp+kAHamNdbfj2MR3JTUDGvh1oBmY6USVe6DYaJXym/8mTecacYqC0FVpQ51JJ3Ae/yxnFQkLdzUw1yk04R04miHmboPwKrgKY1JEpk/e3fjLmHSmIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734720853; c=relaxed/simple;
	bh=Pz4ddOMOiRZygnzO5PtUJ9xeSRAlqGBHaWr2ib3RRqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEBMfZb6X1LaIz7nVlPcmqt5lm8wtirMgaEt3+9/Mzz19iqtBO14SAq00k0pP3Fyw0z2zazkHzCHTk+ljtqQRgqKfJwJUy98V1pjBabe27TTe7uKYwvwambRyUiQ96EGk85CGxUs50Xo/Wzv8+t7hISfl09djyB+W6ydZ9OgA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0skO7Rv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734720851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dwul1B0ZjRX8XHXiw9S5GpTdynHuc37dTo3qyY+Q/Ok=;
	b=X0skO7RvNjfQu/vsbPmWcy5aUgT9YJWS8sE/X1GA1w0qFHQMbBeeO2/R7G0V1kVrXBPk2E
	dfSYY3/Ao+6Na1D8bh8CFvy2artGzV1khGbe+ShdoY+R2V0GeCbxseLf539PfkLNEzYocs
	CPS2unTbTC1/re3n6oWpni6CGzZWE4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-KSvGeyjWOHWmhyEIsV80Qw-1; Fri, 20 Dec 2024 13:54:09 -0500
X-MC-Unique: KSvGeyjWOHWmhyEIsV80Qw-1
X-Mimecast-MFC-AGG-ID: KSvGeyjWOHWmhyEIsV80Qw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so12975505e9.1
        for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 10:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734720848; x=1735325648;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dwul1B0ZjRX8XHXiw9S5GpTdynHuc37dTo3qyY+Q/Ok=;
        b=YtbFdrEP0wHoi6qR+25TxvN7AuNgiNN9uJOgGFTtgiZIdrkS/BvpqoHvzUa0R/xcmg
         Ghr2FNz6HglavL6uhUNqVUYDHJAQQ/qMgpLDN0fc37XPQ2ajKb4mh9tQdXtoc8Aqy6Nc
         /biBKwGPIVEr8ipskE6SqPqOSJbS6z6FddKp56+eesG7GZuPDnV0l5OdwRJVvz9ePtIQ
         pKemKuFoAlBsNo4fDpgWc5uzQxgRhLAe4QckrLle+tTSeIxJs+ZSj95PWHZVU3W8+2Hi
         eNLoncIuzGxE5z7XxDUnwPBOf44Uwrm2A83jbnZbVYUq4yIJ589Yz5+lqyFjd6m6Mqvw
         uKmw==
X-Forwarded-Encrypted: i=1; AJvYcCUU+XB9+1yKqr/XZeUAOA8pFdaVrH70RJ6glCGWe3Z/QYrFdoAmamEjn4N9t2usX1V57lsLdahT88Lt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Mf33f+ePCgWuXb/TztdQAHR0qJlQO4juDg/dbmWH8KD0ByaL
	ieMqxZPYFXwyz8rJaoRN5yeil+RyIn5baI9sdrwDWUUdWxsrgUARHjsOnyMKQxsmTtdBh72YrBw
	LUFCRiV7haO7PU97rBgwZbVzBBaC90eOhXB49nOFSTfqFFA8tvgyb7jWcLl4=
X-Gm-Gg: ASbGncvHELAgBN1xuKask76foIoAJl38eRBOQDBGVZ6stJARqpmnqZxk4NH4RX/VlJ+
	fv1OhJ7wdIMrwOxVC2VwK2Cxdmxv8d8QhL2J1+zkd2d7qx0N14vICDWNJaCOUPsOQp1iXmUh5hc
	DKFvFumoXfx18SjX2U0gJGa7MupXkEKbgeM5c099kkx30V3AtkDNMRw67nVvs6zhk2kRwqLjRr6
	WNkgWUo/dHeKa+BK5nXP4ej+aCCOT0PnsiCiCq/eoGYOcXdi2hs5j4mG6dA475ytEdcgyivvl8T
	Wgr31XzFVajI5/lB3Oy8/aTJCdvEpoX6LlxxQhpBFWSppGpi+8toLFKiq8I3gb6IIW7iw+FnnwB
	SX2M/nieK
X-Received: by 2002:a05:600c:468f:b0:434:f335:855 with SMTP id 5b1f17b1804b1-43668b78324mr30167525e9.28.1734720847729;
        Fri, 20 Dec 2024 10:54:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+mu6LGdXIB0NGv4yM1Fr/+Tla9eI5H7TAKe928/ZkOL89O5OYg43H9k6wobb3o6UoxzSHnA==
X-Received: by 2002:a05:600c:468f:b0:434:f335:855 with SMTP id 5b1f17b1804b1-43668b78324mr30167405e9.28.1734720847387;
        Fri, 20 Dec 2024 10:54:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm4757808f8f.71.2024.12.20.10.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 10:54:06 -0800 (PST)
Message-ID: <d20b0078-afda-4a20-ad9e-b3694a43ba33@redhat.com>
Date: Fri, 20 Dec 2024 19:54:03 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/25] huge_memory: Add vmf_insert_folio_pmd()
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
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
 david@fromorbit.com
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <b1c1e92f29094d6d5b78c6f87dc8ac81a9cbd7aa.1734407924.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b1c1e92f29094d6d5b78c6f87dc8ac81a9cbd7aa.1734407924.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long addr = vmf->address & PMD_MASK;
> +	pfn_t pfn = pfn_to_pfn_t(folio_pfn(folio));
> +	struct mm_struct *mm = vma->vm_mm;
> +	spinlock_t *ptl;
> +	pgtable_t pgtable = NULL;
> +	struct page *page;
> +
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
> +		return VM_FAULT_SIGBUS;
> +
> +	if (arch_needs_pgtable_deposit()) {
> +		pgtable = pte_alloc_one(vma->vm_mm);
> +		if (!pgtable)
> +			return VM_FAULT_OOM;
> +	}
> +
> +	track_pfn_insert(vma, &vma->vm_page_prot, pfn);
> +
> +	ptl = pmd_lock(mm, vmf->pmd);
> +	if (pmd_none(*vmf->pmd)) {
> +		page = pfn_t_to_page(pfn);
> +		folio = page_folio(page);
> +		folio_get(folio);
> +		folio_add_file_rmap_pmd(folio, page, vma);
> +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
> +	}

Same comments as for the PUD variant, apart from that nothing jumped at me.

-- 
Cheers,

David / dhildenb


