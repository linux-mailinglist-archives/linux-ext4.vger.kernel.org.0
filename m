Return-Path: <linux-ext4+bounces-11344-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A0AC1CD1B
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC8E3B6B6C
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A735771C;
	Wed, 29 Oct 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd16Sndz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE6357716
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763567; cv=none; b=Tl4dsE66cJgCq8ZGLaVDXh5IkeM9FvFF1OjfHkFQg+YrmjdNBYlgAMdYUXpnOI/ouxbVuUoy1MofPg+ElfWWELnBP5Xa5zLwfg7JvQFf2a23ZSVM7oPs5txNTBUG3uDg2Tlr7iPDvKwqVzm0LNQDLL1uBJSfNBLsqd1fmWpSsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763567; c=relaxed/simple;
	bh=OrWlJ6JZLo/BrlSCnylCjyhXG4lAUpfhVMbOLTF90HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0Lxzo3u6y+9Vw2QjLmyJHDRDIHp9hzqfUPV5BJ6gJH1LY7+7e6pJ7BcfT8rkf4wr+/j4LIwASYGwLXAfk6UPi8fVVMeuWBkZ6ugTH1jAFcbOrFuaUKc1o34psoSfyXbHdYE7Sg51CZ9Dqu8jui8Uo69s53MaVDKAWkxUMuf/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd16Sndz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57bd7f0e2daso12236e87.0
        for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761763559; x=1762368359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWrPcr+YHQwlDYGWW/C60xpax+dwnoF3boq6mvUGiOQ=;
        b=Qd16Sndztk8IIVz1rCM7JHnkKcdoEtitrpyjt883YBevgoMP4CS/Pl3sRifi/FLUxV
         CKkVhBmAXCwlVdveB2cnGchhM57qldVOiABHaDNa7PR611LnGN6HWIOzVQrD7nj+6ls/
         g520fcSyWC8wp1YfbtOLkYAqKBxhiF1PO+UYAVlq6YvxYmWLuzj9davXzPgYNfs8YsRB
         r4wJEXhFvcgcIO1rSqoFT71szRljIjsIvuCA5JRng/Xu2jI4yWOujerYmChLGdibdicv
         Szs9svoflbXABPwaparVy/Yp/cFY1DgVb5Q83Edur26ntyrlFBTJHoGlz6rltvlx4oC1
         64ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763559; x=1762368359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWrPcr+YHQwlDYGWW/C60xpax+dwnoF3boq6mvUGiOQ=;
        b=oywi/7C/dPlM7qP2UFnk7qBluDC8iPaq8lHcEJMBY8VAaacB2tMXk3EL+Rx2GJ2tmh
         GT8XTZTLukhtCgYQwT8lZTIp8lhy4yOFYYp+RmjX9Nz8Lf8JfiMuRhkfwR9TYbxdR8Ek
         SBENWBlsc97pxLkHFR/7rugYLKD7V+vQu+NTtkkdN+VbbfTJq4N9L9TleR3a+OPkKoes
         ChwTGGqDuMW9k1qHFrnXZzr6QJrHI7jjGqhSfbFm2dwASDa6LV8odNILLspy26LXlykk
         /E1WgCHsNyStE0kbllx90zcoUV7A5DFF+eZawvm9kYs0WgpYD35WGWDH9O/wl+Umq4mN
         iyuA==
X-Forwarded-Encrypted: i=1; AJvYcCV4HyAJyzB1uCDVjd30pkyRnF7t4hYewLVmcH2j+V2q8nlaJrZeib6G+jZii9ROCoyutV4QCGMg4nd8@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYP4g7TZ/+/w450VZVcqOqv/EuFRZg2KzMGXGxXWrP23engL2
	yU4zTJhkmz4Hstrw+M6n4YpvK6EbbH1ESOgGMMBG8bDfR322ou/87Hzs
X-Gm-Gg: ASbGncsko8i/la5QLzzygKmMTn4TA3mScoC2fkHRTuvMObaRzMIovJ4sW/chS0Hk3VW
	KSRN9I4BuKonNkRdubgIExCkRULeimiWxRqsQG3cH79im07arrDUndlj/FLgseZNOvximDoG19q
	As7n4cymdRIJFhSmkqqhV/lZW8NkQSYpmuyd7d4kferP6x1wEVdjHJN1lNlxXeIX6oekZEcp6oc
	9Xg9W2tF7lGJF/rwnGIEd/3GrWywAbNCskXryTRpGZXlTONiD5bXBMlPi0cfCcjZ52f3+GrDZE4
	xkctA1ot9EXeX50kNl5GA4C8166GzUDimWPVu8OmYJTtN3E1JaCC6AnTZfOKPGECdrFVUp9wqSu
	vkAxoUyECZpa/091kS/+VTTZfCemUdKmKNIJtqzVBN/EPm3qOHmv5QuKsEl4QhhKr2zF6D9k4CE
	egajKVuQ==
X-Google-Smtp-Source: AGHT+IGuEzsNziCkBkpixVM7TgXRYPDuuncHpPEAXKQDJA0pf9GlMeK+fWS7c2BxL9a+qZkeWch5IQ==
X-Received: by 2002:a05:6512:2246:b0:579:2ddf:996d with SMTP id 2adb3069b0e04-5941286a767mr855964e87.3.1761763558572;
        Wed, 29 Oct 2025 11:45:58 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5098bsm4044641e87.40.2025.10.29.11.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:45:51 -0700 (PDT)
Message-ID: <c8f89f0a-a327-441e-9bd6-17523c5fa65c@gmail.com>
Date: Wed, 29 Oct 2025 19:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V3 6/7] mm/slab: save memory by allocating slabobj_ext
 array from leftover
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org,
 vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-7-harry.yoo@oracle.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20251027122847.320924-7-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 1:28 PM, Harry Yoo wrote:

>  
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +
> +/*
> + * Check if memory cgroup or memory allocation profiling is enabled.
> + * If enabled, SLUB tries to reduce memory overhead of accounting
> + * slab objects. If neither is enabled when this function is called,
> + * the optimization is simply skipped to avoid affecting caches that do not
> + * need slabobj_ext metadata.
> + *
> + * However, this may disable optimization when memory cgroup or memory
> + * allocation profiling is used, but slabs are created too early
> + * even before those subsystems are initialized.
> + */
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +	if (!mem_cgroup_disabled() && (s->flags & SLAB_ACCOUNT))

Shouldn't this be !memcg_kmem_online() check?
In case of disabled kmem accounting via 'cgroup.memory=nokmem'

> +		return true;
> +
> +	if (mem_alloc_profiling_enabled())
> +		return true;
> +
> +	return false;
> +}
> +

