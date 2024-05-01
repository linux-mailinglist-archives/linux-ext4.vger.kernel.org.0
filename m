Return-Path: <linux-ext4+bounces-2244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21C8B85B2
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 08:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD63B1C21E04
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFA4D11B;
	Wed,  1 May 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JWy6cbG+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACF40BF5
	for <linux-ext4@vger.kernel.org>; Wed,  1 May 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546280; cv=none; b=PMgBt8ECM2C5+3DB5J5OkTFtBa29p53IRJUfYtME2RRjcOjVAp6tjO4qWW8kyKEkI6MMoHk/xyRtgJUKjVOnoYaKx2BXkajMgmz5JgySgADhJcdKILTkZ+L2ocWDvpodH/Nqh/Alu91vwILjFMWKk7VI7H/530/xhG768miVM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546280; c=relaxed/simple;
	bh=JHfTGE6XFrijEkQaAb+wvtESU483miAAM5IVbgbcahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjWlc3/kSin0J0yri3kIQC6Y7hBCWtbd7q01G4FZP5Q2p3oSnR1cZWNXn37pzXdRrEUnS4ssSTff5iGWkojN5nqao9rHzz6NRnqdP1br6DkPMZcgNr9722eYbumlwUofqaj332yvKCm3HHti2laVePepC9cz00RG5Hz0c1tPOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JWy6cbG+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3f17c6491so54101335ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 30 Apr 2024 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714546279; x=1715151079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNZLyG6u4xUG/H7FZmJcRs0vrAIcDKlQHLf7CLLPwDA=;
        b=JWy6cbG+1d0schy6VblnRV1b8O4/WRVEMZHSY9TLj4GUzMQmgIV51zl+D+cwb/04Vt
         mWoruIvdADMNphspxbztAELyMdqn/4muC18D7P/YRyOJkj6DmEPgeeh8ROIuP7Sm1g3B
         aEh6VWgMYzV+6PFI7UBTVuJnUzr5KV0+FZ3MAcYiZMBfVM+fEPqcxo37vtRq2b6zEMx/
         IoxJqhGmORhFLrb3Stl22h5LimBfRQRbcCpR70eBJHh1YLlC8XYmIP/7BCTO+FEtFfFN
         zB9psiBUymZXoTGmtATB9191oPfWTlPT3hrjTKNUwMXZhKvKqPzmOS8yYwuK1xFRvuyp
         MzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714546279; x=1715151079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNZLyG6u4xUG/H7FZmJcRs0vrAIcDKlQHLf7CLLPwDA=;
        b=X+soKgG2+SNxcWcCIkwKjf0JQcccEVYCZe/l1Gd9JBYa9W+KCUJfsN2PZBz4rX2LAs
         8C0UW5/ijqZE5b8HNW4BNPiBpuhBx2we4Lp3KbLFYjT9xX64mTZ/s60KTYn5kKCfZz2K
         9/RvSmUzqOz8Qsmm1VjOtCZ7ekFiAyyaLJIJtnw8o/YL+KcAhYOXVOmGPDQBxzgdOjFE
         9OHA6AafjnequsJz1xxs+ZStPWfjruVcBmaPKExuNhDvnZU0GMT+D1Z8xH7DlRki+0tV
         IrRCzmWHh02axZydNF2Gpmj7S0ostlID3s7cALascNOeWi84bZ6ZhY+CkVpRCueTAaxf
         NDOA==
X-Gm-Message-State: AOJu0Yx4781PLnjN1icWvfU3xMnGlUMUE+ReSYX0xQiMUu/cIT6gw+eR
	2anNbRQesdhzJ9HTnPcgkonWJ7tgocqqDk7S2hGKwMvVD79EcKc0CJCo50XRuaU=
X-Google-Smtp-Source: AGHT+IG2Z/wySqd1NJnCFct2EGwo2kzRUh5XmAZi5hWfxL0w1v8Ms72FMH2GUKU/yvqUwnEtxfxs8g==
X-Received: by 2002:a17:902:bb17:b0:1e2:bf94:487 with SMTP id im23-20020a170902bb1700b001e2bf940487mr1480759plb.57.1714546278723;
        Tue, 30 Apr 2024 23:51:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id mi7-20020a170902fcc700b001e2c1740264sm23528976plb.252.2024.04.30.23.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:51:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s23oB-00H5CZ-1A;
	Wed, 01 May 2024 16:51:15 +1000
Date: Wed, 1 May 2024 16:51:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
Message-ID: <ZjHmY6RoE3ILnsMv@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410142948.2817554-3-yi.zhang@huaweicloud.com>

On Wed, Apr 10, 2024 at 10:29:16PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now we lookup extent status entry without holding the i_data_sem before
> inserting delalloc block, it works fine in buffered write path and
> because it holds i_rwsem and folio lock, and the mmap path holds folio
> lock, so the found extent locklessly couldn't be modified concurrently.
> But it could be raced by fallocate since it allocate block whitout
> holding i_rwsem and folio lock.
> 
> ext4_page_mkwrite()             ext4_fallocate()
>  block_page_mkwrite()
>   ext4_da_map_blocks()
>    //find hole in extent status tree
>                                  ext4_alloc_file_blocks()
>                                   ext4_map_blocks()
>                                    //allocate block and unwritten extent
>    ext4_insert_delayed_block()
>     ext4_da_reserve_space()
>      //reserve one more block
>     ext4_es_insert_delayed_block()
>      //drop unwritten extent and add delayed extent by mistake

Shouldn't this be serialised by the file invalidation lock?  Hole
punching via fallocate must do this to avoid data use-after-free
bugs w.r.t racing page faults and all the other fallocate ops need
to serialise page faults to avoid page cache level data corruption.
Yet here we see a problem resulting from a fallocate operation
racing with a page fault....

Ah, I see that the invalidation lock is only picked up deep inside
ext4_punch_hole(), ext4_collapse_range(), ext4_insert_range() and
ext4_zero_range(). They all do the same flush, lock, and dio wait
preamble but each do it just a little bit differently. The allocation path does
it just a little bit differently again and does not take the
invalidate lock...

Perhaps the ext4 fallocate code should be factored so that all the
fallocate operations run the same flush, lock and wait code rather
than having 5 slightly different copies of the same code?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

