Return-Path: <linux-ext4+bounces-10728-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1DBCA6D8
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEBF19E20FC
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E517246BD7;
	Thu,  9 Oct 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="SvPir9XI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049B1E2614
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032228; cv=none; b=E2xX27XGznAQAkPYxJZRL+f3WFWVyvZdMOq661OR8lIVMT42JXk1gZywS32BFxpPV+AwjICXekS0JeDlZjiZ5g18MsBnDd2SleA97uR830K63PbO/bpZSHc3dByVeA9FnDG0jmKvDWJ4g88pRqpSq05lH92I4pjPSEsbE+o8V/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032228; c=relaxed/simple;
	bh=81OCvozsxVuLtWUQCNblLzzY2eOGkAvorDqJmgZ1C8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHZ29RDw4aGwdroMMi+LLS1/hpsWvDVSolbBeRteH2acM4BXzntRUJ3ywJHYkvpCXx9K5gZRvvIYCq8YTRxE3AECYklmJPoOz/rLie80KAViMwVRlE07YFK2IqA4p6a+Hk7Man7QrwbnJrnAMyCYuBrpR9mRfq0FrjynKKpYGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=SvPir9XI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1285181f8f.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760032225; x=1760637025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ks/MTKg0YoCjDlnUh+3C5Magvqx36EuPX64Sc6wPGg=;
        b=SvPir9XI+1PqBLao4m+AHEUCbOksJnQSgh6Z5vtv2sZ335k+Gb8LFpoGZ+4ZA2XsNr
         ebvR9GKed0htrNr++5gOEixkod2KjEzPSZnOd2Ci20vKQUVA4Gw9uY7Uom5c8kGyStlE
         olsbsYICTWXk8pPI0S8WkNmPuk4xWVJsBaTzyV5EGHUjAignbgnhy/0s0C0dw/5ZOqut
         ypvrWlERUDLmG7YN6O40iliD3UtS9a455qCLE0Fbus2Ano80Mxkw0tb4pqh23QJDDP3i
         4oEoyOIOjQU/ra5WyMwd5hK+sSKywLsyBQHUKkjYSpKOITV9ggs+8ILRKxm/wuJegenV
         cmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032225; x=1760637025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ks/MTKg0YoCjDlnUh+3C5Magvqx36EuPX64Sc6wPGg=;
        b=FJobBC9cvvMv/LkKzrnFX3tJZW3lZsnDGSclLljxlqWZHYKEJuNPehGPGS9lMJcQ4O
         4GjyvqJ6h5ZzCd4QqJPNiEPyvxsg74+s2NJ5AFmKeSXO6mK0hi7Bq/MGCqlEsSLLWE9q
         vEkzeNfiROHvy1ucodgE99doknyFxsrbdOqCTfO6rLvSBvoAzIQxY+aRybmP+ABObNBe
         rPnPVMH6SWZSyMto2hu4JJruCfxnelGNIbA7dGuDS8I4MZgK6ELdidX1BdicNPqFCvvy
         IZkfeivWoJDGbwHQsBjvU3Mprf/eFzIPFKZSN8MpwXCupSWrKB30UwjwMBmj8OYNH4m6
         SzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnkBJErhX7gzzyZsTqNcyb1c/ixI8vDALmdlMzqk4/CVkdOI2EHZxf6Bj1VGOKAAAdIkNajEd0vsjk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5X+NLQRZHuiQxcfQubuKh6AdcuYDh1My3D8gndC/HztPVSDwg
	BN7tEU7p2xzrPs32vG+DRtRji/0b+lVIPHhEEmdiki6y9Ke+VwjIxPH0e9x7lPd2o9Q=
X-Gm-Gg: ASbGncvgbHyab0uvOUlR2K21IEqQ/r+IQOMt4I1s0kP1UWVv0cKAa8wibxKGymlqQ/H
	BT0u6Mvcw1Q4XKho+Foyv9rUtqe6E+BWfvKgmMsI9jZxL6uI5k/QI+FYgiANnItjZcfZ2rzFXoC
	rQFakrUgxeiFpbp3L558eQCbcEFs1R/AKtEOayhOLvXv/j52jPPEfjtmxMJs//S9nV6tC7QUVgs
	A1dmDVPRuZgtL0BbRPY2mk0hWd/L6CpzRrTGbFPEd01MM23kUnT8YizGS4PrwLZO22h6gNqYu+Z
	rCYcwXVIhvPs+oVzBDFo6Dir6q0gfJNqbL4AQ8yq4iFjvlSP08KC/jlNeq9z186moXa7LUCnp/w
	H4cO2T87B7vB21QeEUQwg+w3Mq03qlBM=
X-Google-Smtp-Source: AGHT+IF1difQVKEJP2TbXWm1fao8I+fxiVlJ9Mz29m9hxZ4zGhUTJBidvU775n983cRscyRjCViJ8w==
X-Received: by 2002:a05:6000:604:b0:408:9c48:e26c with SMTP id ffacd0b85a97d-4266e8e0b99mr5235827f8f.62.1760032224674;
        Thu, 09 Oct 2025 10:50:24 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0efasm105756f8f.41.2025.10.09.10.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:50:24 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:50:23 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009175023.ftbnizjmabbe3x2l@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <aOesS6Feov9mrbJh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOesS6Feov9mrbJh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Oct 09, 2025 at 06:06:27PM +0530, Ojaswin Mujoo wrote:
> 
> Hi Matt,
> 
> Thanks for the details, we have had issues in past where the allocator
> gets stuck in a loop trying too hard to find blocks that are aligned to
> the stripe size [1] but this particular issue was patched in an pre 6.12
> kernel.
 
Yeah, we (Cloudflare) hit this exact issue last year.

> Coming to the above details, ext4_mb_find_good_group_avg_frag_list()
> exits early if there are no groups of the needed so if we do have many
> order 9+ allocations we shouldn't have been spending more time there.
> The issue I think are the order 9 allocations, which allocator thinks it
> can satisfy but it ends up not being able to find the space easily.
> If ext4_mb_find_group_avg_frag_list() is indeed a bottleneck, there
> are 2 places where it could be getting called from:
> 
> - ext4_mb_choose_next_group_goal_fast (criteria =
> 	EXT4_MB_CR_GOAL_LEN_FAST)
> - ext4_mb_choose_next_group_best_avail (criteria =
> 	EXT4_MB_CR_BEST_AVAIL_LEN)
> 
> Will it be possible for you to use bpf to try to figure out which one of
> the callers is actually the one bottlenecking (mihgt be tricky since
> they will mostly get inlined) and a sample of values for ac_g_ex->fe_len
> and ac_b_ex->fe_len if possible.
 
Mostly we go through ext4_mb_choose_next_group_goal_fast() but we also
go through ext4_mb_choose_next_group_best_avail().

> Also, can you share the ext4 mb stats by enabling it via:
> 
>  echo 1 > /sys/fs/ext4/vda2/mb_stats
> 
> And then once you are able to replicate it for a few mins: 
> 
>   cat /proc/fs/ext4/vda2/mb_stats
> 
> This will also give some idea on where the allocator is spending more
> time.
> 
> Also, as Ted suggested, switching stripe off might also help here.

Preliminary results look very promising with stripe disabled.

