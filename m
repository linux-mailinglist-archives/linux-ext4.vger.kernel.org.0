Return-Path: <linux-ext4+bounces-7810-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE2AB3D8F
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D160188420D
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CDA248F7F;
	Mon, 12 May 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoGp6yF2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3A248F58;
	Mon, 12 May 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067363; cv=none; b=b3u9JEoUeol7qsvERlB/uZH4X6MT0CFIBP35f2Up6RtSZ6Rq6ysIxnYRhf+D5Z8gtnmoy5p5EbRAoGi4nUAAMczbzlIB8t0ns1y76TWW41cN8Bzz2bzvDbBhbQbMC8ecufWtYCJhzmV88b83mq1LdLARe4MwdvybWtclimTLDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067363; c=relaxed/simple;
	bh=30dNwph3avKCb3wF/O1+5qWyksfKgbLn5JTNcAC1Yk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1WPj6AbYZsHpb4/tyDywASRa6ennAqJy08uxDuBLtZEo9pO9SDnZAwskjFQb4LWx8meX67FHBCZ/QwH9/GBmuvYXbyh8BI3zc6Xqk0Nni+RvrSJsydIKka2vY4CO/r5UaR+nqUX3f/cKTq3f3bALgFw21Mb7c/4zds0HGpgzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoGp6yF2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e331215dbso43988255ad.1;
        Mon, 12 May 2025 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747067361; x=1747672161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTk0Cg5Yj1LxOw27evlR3HPrso5j/gTY3+8AFWOHw4c=;
        b=NoGp6yF22UNeMvt+z0U+rlcOLzR4syFPE9HMtVtnTDXowyB53EVkWGH/RGRDBV7Hw5
         CBx/JSDLIPKeIBKvSEqOE1fxHB8XCgvymalcri/0u/FTxNtJ8NTHCBE6pGYS0xid+J0Y
         snnUUMTO9+UO08Z3vwGK29m4SkDr3a5Q+MxbADOjAgzIN2D+7l2hll61dnBJfgJAtzR6
         zzI4ZnZynkwtCh4yDEJvpleb6IjHTJBlHHAaOZKl8iAFmqyIcT4yR9F8676RBgaFVpbG
         LRgVcRi1F7dHQ8G482h2Y+zj61ipt8pavRq+Tpo2bCOveI/kTacKLuuzWD2IKJkKABaB
         EN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747067361; x=1747672161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTk0Cg5Yj1LxOw27evlR3HPrso5j/gTY3+8AFWOHw4c=;
        b=ix3SbWKuepx8jyCBQR8EUtdNwvTVRqu4eFRFyQz6h+Nz3URHdquTz/AbM2CBa8B5IC
         moKG1hU/cHWCqU4nuw/YM/sgMW9LQRBpC3Sf471UoWiNad3UkUrfO5fdIw/ZuQn6+p0i
         qgdFl5VeeoYhTHrsrUF14efyJiahvlcY6bo/Jekqv1T5+c/Pu/sfNWYLigd1SC3jPKi2
         uGgswLRwsxqnHzgNMt4r6g2UkyhACn9qgaZl5TRyq9IjhuDdX+CyaZjy4Ja62QAUesOc
         hSY2uymvOjPDrp1R4eO2iRnUBWMaZeWNlDwtT13UeQifHMWHxBgFDTD/HISVdVi2fN1g
         NP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2l3RtxLnAngDafqU+M4Jy7zUuI3p8X7UEI/mKLR6C0nqJ94Y90HWjjXvTsSLoAGGBnAdH1D0KzHNfCw==@vger.kernel.org, AJvYcCWUcH3cf6oQKCKpEiYkqwFk1+vjpB7q/szTIwVAHORI5snYr7ptzWEOwGMTckYCR+uFbcazpXrF@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0uhsECGWKEWS7d+LfB0eEbdmp6OR33Hkq1AgDZ81hKhpIhFH
	mtF2PzBZCDomC10mvsnKDV1blsNezjKJx822p3lneO+6WG1HA/QQWml5/Q==
X-Gm-Gg: ASbGncs1cTs+/y1nocmTN6czNlxwv2frnNA5cVhahxSgmo0spGBi8GVW1AEHy2n2Z9m
	zAyKbT1pCupaKyFsWTKP3H0Puv04KCRTnDTmvYQE5Hc8HVZP40yIFZjgS3mX32NMBkKnzcGC7Tl
	Z438ZApOP7pG3vl4+9yng0bVyd9JfVPCOD6s5kT6w/p0qjYVxiPDQh3GGCG6rE3Ln9jrNRwiGQZ
	4iH1d86E2cIGucaWTXKkQDxbnqEscoGdr8vv0CcpezOJXhpwyNKS3Dgzvcut6NvzdNJZhGtZKWH
	RKhlj+8zshHYl7qNiAi5nJFQ1AthNACkNE4ZUN8vXGUlWrnOJe9otKgelzZQLA==
X-Google-Smtp-Source: AGHT+IHspdCssr49wGdVj4WP1uEA0bIWUJnfi9xoADIkbA7XElXqtqapnZ7hN3gc6wUwaSi/U29MEA==
X-Received: by 2002:a17:902:cecd:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2317cb30b1dmr990385ad.20.1747067361200;
        Mon, 12 May 2025 09:29:21 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828a463sm65129085ad.167.2025.05.12.09.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 09:29:20 -0700 (PDT)
Message-ID: <796c228b-a072-498d-819a-c09b2708ac0a@gmail.com>
Date: Mon, 12 May 2025 21:59:15 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, cem@kernel.org
References: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
 <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>
 <aCIVbuot62pZu9xk@infradead.org>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aCIVbuot62pZu9xk@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/12/25 21:06, Christoph Hellwig wrote:
> This still looks good.
Thanks.
>
> One nit:
>
>> +	/*
>> +	 * Now that mp has been modified according to the remount options,
>> +	 * we do a final option validation with xfs_finish_flags()
>> +	 * just like it is done during mount. We cannot use
>> +	 * xfs_finish_flags()on new_mp as it contains only the user
>> +	 * given options.
> This could use slightly better formatting:
>
> 	/*
> 	 * Now that mp has been modified according to the remount options, we
> 	 * do a final option validation with xfs_finish_flags() just like it is
> 	 * done during mount. We cannot use xfs_finish_flags() on new_mp as it
> 	 * contains only the user given options.
> 	 */

Okay, I will make the change in the next revision.

--NR

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


