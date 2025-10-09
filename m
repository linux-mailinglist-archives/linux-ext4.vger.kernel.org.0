Return-Path: <linux-ext4+bounces-10729-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED38BCA6F9
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 146984FB13A
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6051E2614;
	Thu,  9 Oct 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="UYxA8Kp2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F07248F64
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032379; cv=none; b=ltZhyp/uYVg+WrTQD4itceialvxm63+62yZNWI5BUSUZf0/bCiEUYyoJX7HI2rXl7M90lKlskjkwX7MEWd7X1oSRbUJqJqSKdYlyrgn/bam3bK4bLV1Ap8Wcg08rfNGkpA2xRn1620oVxu3BKerOwPxjWS/3hl2OO8vlGRYP9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032379; c=relaxed/simple;
	bh=ebOvcIfmi3GafyZIz6Mk3JkcM4lI40dZoDVr0qN254M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEpvalhvmfSI0dZzVBI9UushKawF81/+spdCXUZRWbVx8D7Jobgkh54R0OOWZbIiViV3x5oF23iQ04w3YXiMpPb5K922czHQ2du48zDNULAXRNjUUPEmjZ37pMOkP4TPthiTPa43LqGlmOQj66hUVxqoRmKLBvulek6B9rdC9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=UYxA8Kp2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1166330f8f.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760032376; x=1760637176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJOsN41yoa3YyKSJ9TTkHzxgmGK8HIKNRuuL8EXcrYo=;
        b=UYxA8Kp2JwGCpnXHTTdtWeghWv3lgRedYwTpgLxsS7XazmpAyt5RSNjMyjp55zgEKg
         yI32RZX3nX3nmr7ulqNDwBq/sUJFlpPlk+yS2HTonJRLPrJkUofLQNPwIcTk0j9SAV/4
         GHLTthRjphk92TUJEB809GRHBPIj3DeMFR3wzTCYxAvmH44wBDqSflSc369T8Zj9a83R
         sT/1Hj20hMFb9sFfMyQX3iteNJ44fc8wk9xltn9D5kxt4H8Yu2gUn6KJjGUFeSqwWPd1
         p/wrvFw5lySNcXvp6OSfZzpkN0Tjuxr0tC1MKege3yJxtyZ/cAK2LULYQ0eHmaouD3BJ
         eQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032376; x=1760637176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJOsN41yoa3YyKSJ9TTkHzxgmGK8HIKNRuuL8EXcrYo=;
        b=kdXMQsIwTQkmzZcvhXOKV9nxVCHRXDM50cyozcsIG6r8qxnFI+uxbqloy/QAVg1lHe
         YI6lyq4eCpkuMDM34bdWT1DNoDmvAxqe44D02TiBivQEeObeuzr/QkQ94NOFxyvAkv58
         6fxmWy/VSmL4W6duVxKkByR45flbvPKr/PxytiGKu8QNTORWKBRfC5RidTTq/CvUq+3n
         jDfHtaUDc8GDIRRJ1x6nJERfAF3qaNg+oCfIr7YBU/IZ3NpvAvde/uNm9FklV11+yYwq
         EyGOrlzEAR6AgbGDS3qx3psKOSVcgULNHHybkhw+NXdkDikTCemDF7LvfYXGCgjQoFiC
         1InQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl5aCQooM07NWxnIazOomj2rxLOrXqNFXLgMVr+HCyJDjkMMxhyoKnKSfAUxs4TTYV21cOy2UXdW5S@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhV+XebTzMCgR5cePBGhcHwIyQhL9yYqZBFHS1h/Oy9sTmE+1
	vn66QTNKQR8rZyTJOMi7N2/3JbNkF2nKhremwF2/YgjZaJf+OhGS+UDTVVS95+cOZkg=
X-Gm-Gg: ASbGncs4sCDLX6g3FKesFY95xHs1fWQX7J2UVxPAB+5OL+2Pt87eByJxoDRPBbJNIaX
	ZpgMx5ttibsF1qC3TYcSK1fSDfZs1s3A/UDElgS6zbl0JpVVQelXtEDsN+WAPxAbdV76zgwjqG5
	cBJD216RLijGcCGrsQa9cflm6qd7x4uogqides578/a042rfXtuHqcIO96ZkIgdN4Z+eWSXcGcf
	vZyFKBPWKgL/zNxiJ7QFem0QzMcL0bkAya+F2cuzjHecCGmL8Yeyuzm4741+HynjQla2kk9qcZK
	Rtvyj1h+S6yaRx0KQgUZDz/7MRw+CVqc9kMvL/Vmvp46o7axTss5q2pGUtKvYLpFw7v3EkOnKF2
	O2+CNndw0JpDpn2aZ2vMYoXSeGMXycXA=
X-Google-Smtp-Source: AGHT+IH4pkZ5LUcz1UVUD+dIXY7lwVVUALuhd5+O3JFYRmZLgI9Otm/vnGqmQzZUzY0VBhTbKmteqQ==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr4804842f8f.2.1760032375892;
        Thu, 09 Oct 2025 10:52:55 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm103917f8f.49.2025.10.09.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:52:55 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:52:54 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009175254.d6djmzn3vk726pao@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <20251008162655.GB502448@mit.edu>
 <20251009102259.529708-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009102259.529708-1-matt@readmodwrite.com>

On Thu, Oct 09, 2025 at 11:22:59AM +0100, Matt Fleming wrote:
> 
> Thanks Ted. I'm going to try disabling the stripe parameter now. I'll report
> back shortly.

Initial results look very good. No blocked tasks so far and the mb
allocator latency is much improved.

mfleming@node:~$ sudo perf ftrace latency -b  -a -T ext4_mb_regular_allocator -- sleep 10
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |          0 |                                                |
     1 - 2    us |          0 |                                                |
     2 - 4    us |         41 |                                                |
     4 - 8    us |        499 | ###########                                    |
     8 - 16   us |        246 | #####                                          |
    16 - 32   us |        126 | ##                                             |
    32 - 64   us |        103 | ##                                             |
    64 - 128  us |         74 | #                                              |
   128 - 256  us |        109 | ##                                             |
   256 - 512  us |        293 | ######                                         |
   512 - 1024 us |        448 | ##########                                     |
     1 - 2    ms |         36 |                                                |
     2 - 4    ms |         11 |                                                |
     4 - 8    ms |          1 |                                                |
     8 - 16   ms |          0 |                                                |
    16 - 32   ms |          0 |                                                |
    32 - 64   ms |          0 |                                                |
    64 - 128  ms |          0 |                                                |
   128 - 256  ms |          0 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |

Thanks,
Matt

