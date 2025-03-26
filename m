Return-Path: <linux-ext4+bounces-6985-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D95A7152A
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 11:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDDB7A45D4
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1161CDFD5;
	Wed, 26 Mar 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="ybCwoLqf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BE1ADC86
	for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986760; cv=none; b=rr5e7B2W4HDXlGmSUmAgKExOL3qUqXdzqOQ/wQVrq3Xlmn0vJVIyS8uZhD+dXrVDF6D3u1P0r/dWe4bhA854TuzRRwBpapkZ+2vR8RJ3+ylJv29+jIgm2WOddf0sdzTUrkVvgCE4iTV02E103j5bjdg0j0XtDWs0j0K+e+mbOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986760; c=relaxed/simple;
	bh=uN1vr/Fb0iYszlHwQ7A2qkr2YXVD6KSqZVcwTPfuI+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkDSm2g7VHCxLkqmawIOouK4miSTB7Ca/aa5OdC41ZC5dPZgIkLY4HbbPtlp5LjVPkGi/lCD+sXsp4WqRfH5+0IauOATQVLulxAtWTRLaeYEyIaXdKJycgJky4Gz7RuMTr88yL+K3PL+5ci2ggHkQ0CjWHqbGtGPOI1ZKBMx9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=ybCwoLqf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-394780e98easo3811417f8f.1
        for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1742986757; x=1743591557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkYrvJH8MLboZJYN3SET+tKv3pjaS9s/Q33mAFg+/Ks=;
        b=ybCwoLqfgz9r8ysTBw7NmfiRIHD5TC4BJGuoq3IVFmNOnEY012oZArULW5cake8jFK
         po4G+HZSz3Mh/74Y2FPDQ1NYVTOqvbm2ZU2IhnUhdRO4AlDiXtaV2pJSjGZsi2OfTEX+
         Dm0imzxUO78R7nE89UEivoMYLQCsbicet8CMlts2+f5ri4/76yngat11BkqPp5uwnmEy
         BlnFZvrS6eGOwqgi0LQiT+YfIoeApuQYOV7pOTk9nOmFOraSR4cxVk0uOShRXqyWLbTr
         H1SqcDmZcKrCVt45Aiv/1C6FeWZc5vTqghmLaGi0lCrdffev1H2wWgNhYn4ZXfXcrRKe
         v/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742986757; x=1743591557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkYrvJH8MLboZJYN3SET+tKv3pjaS9s/Q33mAFg+/Ks=;
        b=JwRnf9QUDt3KofWpCKOGDxs6XP5InWjPPr4Ah0VJ6m6D7E+gEdjh509i3ig6JNC0K0
         pLcq5rwpjVtsEb/U9yPH2GwAXrPrEZl/9JvzSQEI8Qb1iPK8jZPTGML2trsN/BPjyO6U
         iPYoN1mbEblLyorhkAYkVrEBvY8DObigtQctNbEVdS9OvI6AW1YDYlv0oy5+4ewbNnph
         AejcC5mTQCJhhyL77uh0MggmJtud4QTKNa7J/hnBiw4AdQa9+Ocqd6yk9gtb9if/abP9
         5LNxHUAXm2/cf6KqwEoEJr7jZiJmJjaju7B8qPhseimFBw53YyUmGh4ZqjxM9j0jQNS8
         gDIA==
X-Forwarded-Encrypted: i=1; AJvYcCVFJGdaaW13tMe97U8aM0Tao08YT+3yZ2lD4znnAA8JbTXC6UzADFpZSqUXYK2fjakKcK7+VAUHuVi0@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSrq3IP1hAAeZkUqgqOL6eiaW5CuS5ZBhbcmeX89OkznPXycV
	EJlrQQ2n/H9Sr05lTd5yeCPcFHTMZfBPZxOPgwmR5EMn/4UurroU9NMcxr4J4Qk=
X-Gm-Gg: ASbGncuxLqXibezAQ90LWdeinB6Io7QTu0QZAjA6AtY+Y5oHLnnB5JxVvzQz6aDhMDf
	DR61RgxTYkNPZrGSip8v40Oy4l0Z9kB9BoKzNkj4SPWL10gHpPSWG1e19ZoiqFbnt+EoxvIUWBW
	52Y7Orgv2wyZJK4I97l1Ar5vh5Hv302JsOmhFhekuio3SGJBn2kdW3UV9gwyVhEfttGRjYELtM4
	sNyUkp3tygLWP6IKYh9k+tQ9bKrUUtFRyND9iaCg/1uCFH9IVSBBkvk7pMGxX8kY532N9YZWBa/
	mhmVH/x4hM68oZZxmsyUD2qNjlR0KQ55PApsMmGjxQxa+z4G
X-Google-Smtp-Source: AGHT+IGsynMjLeM6MvbAOiFyQWhOSUi+GKcc6H4q6k5SLyMO29JdoL407k9GE1BOdU9b67T9vRhDlw==
X-Received: by 2002:a5d:6d86:0:b0:38d:d701:419c with SMTP id ffacd0b85a97d-3997f92da9amr21706605f8f.41.1742986757289;
        Wed, 26 Mar 2025 03:59:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:28e0:840::179:137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99540bsm16374900f8f.2.2025.03.26.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:59:16 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: willy@infradead.org
Cc: adilger.kernel@dilger.ca,
	akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luka.2016.cs@gmail.com,
	tytso@mit.edu,
	Barry Song <baohua@kernel.org>,
	kernel-team@cloudflare.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux kernel v6.13-rc5
Date: Wed, 26 Mar 2025 10:59:14 +0000
Message-Id: <20250326105914.3803197-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8kvDz70Wjh5By7c@casper.infradead.org>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Mar 06, 2025 at 05:13:51 +0000, Matthew wrote:
> This is the exact same problem I just analysed for you.  Except this
> time it's ext4 rather than FAT.
>
> https://lore.kernel.org/linux-mm/Z8kuWyqj8cS-stKA@casper.infradead.org/
> for the benefit of the ext4 people who're just finding out about this.

Hi there,

I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.

Does overlayfs need some kind of background inode reclaim support?

  Call Trace:
   <TASK>
   __alloc_pages_noprof+0x31c/0x330
   alloc_pages_mpol_noprof+0xe3/0x1d0
   folio_alloc_noprof+0x5b/0xa0
   __filemap_get_folio+0x1f3/0x380
   __getblk_slow+0xa3/0x1e0
   __ext4_get_inode_loc+0x121/0x4b0
   ext4_get_inode_loc+0x40/0xa0
   ext4_reserve_inode_write+0x39/0xc0
   __ext4_mark_inode_dirty+0x5b/0x220
   ext4_evict_inode+0x26d/0x690
   evict+0x112/0x2a0
   __dentry_kill+0x71/0x180
   dput+0xeb/0x1b0
   ovl_stack_put+0x2e/0x50 [overlay]
   ovl_destroy_inode+0x3a/0x60 [overlay]
   destroy_inode+0x3b/0x70
   __dentry_kill+0x71/0x180
   shrink_dentry_list+0x6b/0xe0
   prune_dcache_sb+0x56/0x80
   super_cache_scan+0x12c/0x1e0
   do_shrink_slab+0x13b/0x350
   shrink_slab+0x278/0x3a0
   shrink_node+0x328/0x880
   balance_pgdat+0x36d/0x740
   kswapd+0x1f0/0x380
   kthread+0xd2/0x100
   ret_from_fork+0x34/0x50
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Thanks,
Matt

