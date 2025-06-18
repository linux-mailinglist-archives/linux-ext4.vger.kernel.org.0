Return-Path: <linux-ext4+bounces-8507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685EADE719
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 11:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25AE402E2F
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99482820C5;
	Wed, 18 Jun 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfRK2f6X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE928033C
	for <linux-ext4@vger.kernel.org>; Wed, 18 Jun 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239070; cv=none; b=REp/J+IB8MbItWslfjl9N+H69A2BrD554ngmZHST7VwHu3IibaUdXCmeoj2nu459S8XcpYCI8Upu08cB5p/rsYwCJFea3AlIgunY20kt/Hu99HqivWyC10JWPACIL3UBHQZGtQiR2ln3w87XxRcudY2XSS3xZ9S25BM6V3sbZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239070; c=relaxed/simple;
	bh=4DUmQNuK4KTUlCUIkhvb5/nFonNtmaZleGEiMulYcdg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KAQwiiWrqslBrQLM8uFGyPLFzYZvO5YAVz/0GSKd1WiJHozrCgw3XHv27rm5WGT9elxKJPzUnyHH2tOBML2gTBNz2DvA/mNp86+rD+F3HhMig9eXX899+y53HnwKbVp+l5UTHVE9t00LA3RdK8Re7FY5yuw215llrDApHZ+PMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfRK2f6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750239067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DAAxpkDR64hsnaI9Udos0W7mCWFzGT/DUlyAtDcPHQM=;
	b=XfRK2f6Xk0iT8cmMZXk815s0t3tgxz+oyOZWSVz+uW4+p+qa8jmYy4l02WoJfkmXsOZmMc
	VfXqBLUNi2O+68Kz2Kw9vK+lybCs/GkbBmwoKXuCyXpzBstruW6ad8lfns1w/mgLG1Hd2K
	Dy6GbhyvB+smAKK56F/oOL1WdRs77+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-O0-rGw3NOAerjQkGQyHLSw-1; Wed, 18 Jun 2025 05:31:06 -0400
X-MC-Unique: O0-rGw3NOAerjQkGQyHLSw-1
X-Mimecast-MFC-AGG-ID: O0-rGw3NOAerjQkGQyHLSw_1750239065
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45359bfe631so3230365e9.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jun 2025 02:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239065; x=1750843865;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DAAxpkDR64hsnaI9Udos0W7mCWFzGT/DUlyAtDcPHQM=;
        b=Y5VjTmxz5Ux6vYTnZjPnzSLPYjQQXMwN7PiMpSPB6/ABb/ohX2N4koPTNWGVikswkD
         1e6yPdc0IQhBWEUN9J0CEbrdmq4lFKofIRE4ggr7eNWV+O0usrMJwAs4FCm7VuC3L+J4
         PFocbSp54WN5Q1KMY+2Y4YlEp+Bt5+1faAa6BhZ2Jx0svt73Wh+gUduK/F7FWnES1hgU
         I611bnZYeZNVw0LcY2kxqrH1Wy6a6vdsiOCfxAwcUhrAJzZx7dIcmLj1mo6BsSe0mflw
         pdKlKYgVZI9WwHEPNzVsRaNpVSAUB1EHzKSQK1+tO0Mkng+SKkoVcPF8pPWMtMdMdjAA
         rl8w==
X-Forwarded-Encrypted: i=1; AJvYcCW3djP9+E7oW5Evh4s4/vHO9d/MhnseYR1COGXbB806q2AZ4aNrKHdoRRUrPqJsZ+3H1YWqxArwUGYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xHNklRLLkGyOkVh/Aw0W6PvkWUqC4FqqT9cfpe742QjXm2y0
	grQhU1g1XjOEHmRDBYarDekoSk5/j/qU1YuN6B6+fkdq+SgFrffMiKIFsrvUIq1UzstaSoswEYZ
	BGVgWmGuCnSekY3Id6YFDa9M5F4vri6tStiK9mmZAYh2Hx2cq18dmUyIMxl2r290=
X-Gm-Gg: ASbGnctu/lKwq3RRsOkn62AED0INALy4+Jzhmp0d9hbR55H0NbT9ZEqCLmBUqRYdC/R
	Mv75W7qjY0gWnPxxV5XE3uNDflkwrGZdPhO/68FdcGm0sEEaUGRyi1bovyrSvZ8bFhBlOGPQHnp
	a8/LXEMS0CIDcuf/ReVnTODIrXxF06Mal7yQ2GDpZtTOhJSMeqObOCmFmJaWY2jC8OfdeK8WXcT
	kpznypEBfu3Beh+QTRgNXWUtRCzNplDBpK9lmxO1BEtrR5Vp0G8TcBddTTQOfJtdpnk/Ntz3rmi
	H05v8TFyEVER+YCeQYuIeR4BFGs5E9YIbB97mIF7AeMiKWCHOUpDvAytTOig5aobr+s1RVOqmLr
	Kf7pTj0jUC/O+NVHlKiw6y9znts/J6/5cry5zVA/YNYuAosY=
X-Received: by 2002:a05:600c:5396:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-4533cac8fdbmr151178365e9.29.1750239064917;
        Wed, 18 Jun 2025 02:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFE2lmgl3UBomQIO41tOZKwEtVJWCPsqqDyTr4SmltEOYbKotteA+xAeGqRpDK/3zaPP374g==
X-Received: by 2002:a05:600c:5396:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-4533cac8fdbmr151178015e9.29.1750239064488;
        Wed, 18 Jun 2025 02:31:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:2400:4052:3b5:fff9:4ed0? (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a73845sm16606417f8f.35.2025.06.18.02.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 02:31:04 -0700 (PDT)
Message-ID: <051f769d-3a0e-409e-bd40-22000f10b986@redhat.com>
Date: Wed, 18 Jun 2025 11:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] mm: Convert vmf_insert_mixed() from using
 pte_devmap to pte_special
From: David Hildenbrand <david@redhat.com>
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net,
 m.szyprowski@samsung.com, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <5c03174d2ea76f579e4675f5fab6277f5dd91be2.1750075065.git-series.apopple@nvidia.com>
 <1709a271-273b-4668-b813-648e5785e4e8@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1709a271-273b-4668-b813-648e5785e4e8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 11:49, David Hildenbrand wrote:
> On 16.06.25 13:58, Alistair Popple wrote:
>> DAX no longer requires device PTEs as it always has a ZONE_DEVICE page
>> associated with the PTE that can be reference counted normally. Other users
>> of pte_devmap are drivers that set PFN_DEV when calling vmf_insert_mixed()
>> which ensures vm_normal_page() returns NULL for these entries.
>>
>> There is no reason to distinguish these pte_devmap users so in order to
>> free up a PTE bit use pte_special instead for entries created with
>> vmf_insert_mixed(). This will ensure vm_normal_page() will continue to
>> return NULL for these pages.
>>
>> Architectures that don't support pte_special also don't support pte_devmap
>> so those will continue to rely on pfn_valid() to determine if the page can
>> be mapped.
>>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---

As Andrew notes offlined, there is no content here. I sent this by mistake
after replying to patch#6 instead.

-- 
Cheers,

David / dhildenb


