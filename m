Return-Path: <linux-ext4+bounces-8276-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79DAACAD80
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7218E4003D3
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0821324E;
	Mon,  2 Jun 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZByUxsDK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980811A83E8
	for <linux-ext4@vger.kernel.org>; Mon,  2 Jun 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864717; cv=none; b=Ej09+2VVJhRP/JAWJUeU/eL2aft3YEk6mik6ETcj8Qmjs3v6GIWiCdwQhCCif3FSePwdH+233Mc+UfmGMABuZDE4/MIYRBg7fqducaD8Ff0IS6YcYQER02szyHxnoyPAvbDQ/GWubJVNx6Jir8fE7bFff+xoKfTF6mqZ3L9PlT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864717; c=relaxed/simple;
	bh=62q+4Y3u3AUMWco0Ri8A9+Iw4BxELPI+v9ZG2/03SOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giBhJxVqOulro3AhCiNYrv1Kqnaz1cBg2qhMwe7dzq+l4ndnGBWWh2yUYfBdpGnznr2m4e2ZntdEXhZfjut70u2uMxefcwigA00pBJvS0AzruR039wZMyhWDyiv5+A7e6/NirFNMcy5gMd7F1kX4b9MDrR+dK4e4fqarLF28k30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZByUxsDK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748864714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pluW0u/+xJd0eUGvzfkykomG6yjqcYSK31IZ33YVJmI=;
	b=ZByUxsDKPGTaZk8y2+Kb8NwAh3A/X0ad92kDTHL3s7oa62aj+3PbBYumiAXFx4gdsn3Shr
	5ftlCSznJBCNlmeLhWZYXTqkH0g7xrqjd3+FX+b6V66ESJv9aj2jCT/MN3K+/QjHQH9gAs
	rRlfECCwTwghjwoEenSa88OJ8sMt7XQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-70ie-4mxNlW3Nti6ZcUSSQ-1; Mon, 02 Jun 2025 07:45:13 -0400
X-MC-Unique: 70ie-4mxNlW3Nti6ZcUSSQ-1
X-Mimecast-MFC-AGG-ID: 70ie-4mxNlW3Nti6ZcUSSQ_1748864712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450de98b28eso7402515e9.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Jun 2025 04:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748864712; x=1749469512;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pluW0u/+xJd0eUGvzfkykomG6yjqcYSK31IZ33YVJmI=;
        b=SI//KGPahhcJco0QJrBCCeIQ0bBuxB4+TQJMDDvKGzzbGd/aNIUWzm2/HbxZUdKkv5
         Yle9U0Tepk/A6CdVwW6n04Ir5g+H8rYjBcZMrfSctRCHZe5JUAj6b9G+wzcG+MlYq0cQ
         ce8/Li9i1LuLRLWZ364aodA1lnHfpKoCSK0V8WZtKzdxnC7n9PfWBRoTNbFx3X8IJR3A
         fqN7mpsSKeEYshhPr8zosRGdSbNZVmoCXDQr70y/2mySw+JtwIQvZXc37lH2pi1GCgpP
         1+IkQOr6MKFmrBrqCIG9FFPI+gQ6rTJdjD6DgwoFjK9ZUKluoJ9DH4sdX108Xp5K1F6F
         pDGw==
X-Forwarded-Encrypted: i=1; AJvYcCW73SvtHTKsBpQYj0cmQvOWEhtCiXWl4CcG/ko9LActobohDdtlJSg54Pfoaafk4/egkAJKmF9ldy4q@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1SdHMcZSogoUI/UNow+SJ1NOhWTEjN2sMGr7jUyizb5lzC7U
	9pcPpX/8OnQ/WK7v9Uo7IcgH4sLShKMpftIuCMvvToTf8IqHQb1kn5y2/8T60JtPbqLKDbYT/Lz
	i6RIA/R8HnJVcWV0DIr+NJAngxWzs01aWge/J4hi5SYoRRohBjdNSRe+oO3u62JM=
X-Gm-Gg: ASbGncufwGSwt0DrFfCyBEL8VFmDwotdSeFSx5OxeJSmdm7d1hAObKKSQKYwQ58YYZz
	sPLQCnBVmQFu6EBdZ8eXaM9ruwDrDxDrHZz1dz3+Ue1AfMDXuyZy3ooroRgLLRl5icY+iAVNSnG
	jGKuGJao90p+KxPEYzqJ4KXiSmQ4cGA71s3OoRn65AP8OnF67Mh23mpsM80OWK2RLtPk9xbbbfo
	jmp1bnp+Dl6p6ZxBr2PVpX/YNkLpJ0PLvt6246AFEz+oIqX0t35OvpvfjLgz5RMkNagOVD47ict
	GNg0GxzBwiq0C7fc4Mr5ziMvTlYkz9QwfPgxD+uVplZVu0kkrkJ4yRuVLx7X5FF94KkcqmRkAqN
	+03C4E1fOwYkxWBviPhruxTET3R3I9a3Knh23fGcbaA2DETYa6Q==
X-Received: by 2002:a05:600c:3555:b0:450:cabc:a6c6 with SMTP id 5b1f17b1804b1-450d6bbb899mr123242585e9.15.1748864712256;
        Mon, 02 Jun 2025 04:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNiWxj7ru1ZpdEa7TTYC+Mx0/zZsZQT6PVApBO3c8hzuU2D+iOpq+QjyaIBIup3raLJSW1Xg==
X-Received: by 2002:a05:600c:3555:b0:450:cabc:a6c6 with SMTP id 5b1f17b1804b1-450d6bbb899mr123242185e9.15.1748864711876;
        Mon, 02 Jun 2025 04:45:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f92585sm126373555e9.5.2025.06.02.04.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 04:45:11 -0700 (PDT)
Message-ID: <3327f886-e708-4229-a83f-2404f115d44b@redhat.com>
Date: Mon, 2 Jun 2025 13:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] mm/khugepaged: Remove redundant pmd_devmap() check
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca,
 willy@infradead.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.25 08:32, Alistair Popple wrote:
> The only users of pmd_devmap were device dax and fs dax. The check for
> pmd_devmap() in check_pmd_state() is therefore redundant as callers
> explicitly check for is_zone_device_page(), so this check can be dropped.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


