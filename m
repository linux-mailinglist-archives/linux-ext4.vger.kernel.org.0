Return-Path: <linux-ext4+bounces-8291-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F25BACC868
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703357A2559
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EE238C3A;
	Tue,  3 Jun 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QHfIQXw5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBF1531D5
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958664; cv=none; b=CCeWW8jSZz6Z+sMV1SZmu9AUvj+EW6/SINCNrcTKwKentRWJWhAOGyiSZ/fWJ1zlSUDB19ksNGyqt8qfc8bXTuaJsYelmEx1z7iosoQbrEygR2PtpLG4pwn+YDNHjB5lBsmjfS6tp+54bf/34fqC5qQMsZKtbas7lliOzldaVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958664; c=relaxed/simple;
	bh=TpMwl2oz7EgmR302mml/BLJBQvaM57yfpZzI6Z7p75c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcrfRbl6NVrpSbC57fU38iHpgueqAAIXv481za/jI5xmGz3RvS4S52F6KrW4/ggDHnHmzzEB+xns3yPPmf8pPKlUhOiZZqCUp7CeTGvu/SYJogQI3/wZsA+5EHswUOWS8Gheipc+dJVzuEHKCUr2nWWSywDEfuyXUOfvjh27/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QHfIQXw5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fabb948e5aso58509476d6.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958662; x=1749563462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjoJn2Zm/22QHFjhWW1StoVgQrArf1QtKVAZNo0G9LI=;
        b=QHfIQXw5But1vmUFqdBH6BH/hFhbWI4i6QCDYKQrH6nXF1gNEWyy3Linkm2QzQB3eS
         hQ+jSXBuKlpUDWA8HxTrScBMYslIuisCvkwxxZoOp0hOqSgCk8kTO1XCvTZryXT1AV3s
         vLVgX/f5cdSflDOz7fT635cTw7WA3xxlF6PYdR2WoOmpzZUxVTW/M9y1cfI4RdC/3fB/
         epQDqplIPk4dJ6LYXVowzT3PlepXl2womploBf3dqZ0F2j5JdNj9tjRAAy3NxziyZrNy
         0mqe4M1l0RGyrNmg4SBuwcBh4a0FdBz9gzPQeqsUhQEAgJ+aDTuNihxlJbkzwdDRgTJt
         mRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958662; x=1749563462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjoJn2Zm/22QHFjhWW1StoVgQrArf1QtKVAZNo0G9LI=;
        b=b/qqV0+xFp42X8t9Gdg+IfQz9AnWgD5Q19v4GD83ZawdA1tTuUFyYUfk64tyt7rtoi
         QvYq8URuV/S03Jq/Tw9rUZoQKaUZ3u9ppBJOZvgdEiIZ4CxR16PKsR2guZ1OP3QH0Gy7
         XDm+oJKAj9dECf19NPGkjtpBm8WFmF62mg6SVlbg9TL7siq0WsIKCVouUK1UTLXI0wnE
         VlUmkaJo+N7Oj2N1vVG8mifg5rRBYuRp4LEZ+9LqsghlBl5zchgVf+PHnfFODD5+1I9i
         usnbzjmDo2iQs3JpGj5wtr11s/iDiomWTh6oJ8C6YXnXkOXdLx0IgIxos292JVk7wvdI
         8ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4d7iTr/Pu0lXZK2t1JC6hmRdiMG7IjB+h9cKhjSW6L11ZdDzAKjJDp11rdeu2Zyw+7YbesYjM1sYy@vger.kernel.org
X-Gm-Message-State: AOJu0YykNZ6WmbkPbZqaax4EHIdhbJWJ+cvb0WLHADn441ap0j0KA4tO
	kchwDbbJAF2MntFg81al5BzTScouMwtimMPZEQ+xtukLTyS5I+b9uYkhgugrAC4tD3TrB8KU5VB
	4IWPZ
X-Gm-Gg: ASbGnct1YafCWqIz4yXbUFAP8QOhT3pKOXin4sf2blAbqltI/DRvBZ4eLzVIGt0Z9Ci
	ksApTBITkMiM3RO75ZuH0Af07odZRYNhLGP3zFYFejmfGndNH/LSrVO8XyjMeHvR9VMnCQbk4Kw
	F3L6x6BUiinAqI4LHxMnV2K4vqjgWvpEYAUIZ1RGGf5Nbzqt2yvv/5RxpnZioOwVl++TMMe6Eyq
	AF7TXlha/IR27AmmZfi2L5g9BAC0EBaIElMr3sp+LcMutj2mCiV0hAgxLxHMnzmiQf30QCVCOHu
	dqxA+vYXdZgoI2dy/PMHaG7lAv4+n6dpsl6ULiOiPyfGGHUKDzgYbjByvT9bM/l5tzdH/EsHoS1
	i5RkAEAeKuYxeOk/WcEEakWbmgdY=
X-Google-Smtp-Source: AGHT+IEFP32FP1kWWCcJZHDROTyLVsjrCtV3bR6kiIwGVnTYe5RPt72l9Jyf9JX2LfFifGppycDP9g==
X-Received: by 2002:a05:620a:4629:b0:7c5:3c0a:ab78 with SMTP id af79cd13be357-7d0eac62c8fmr1708400485a.14.1748958650816;
        Tue, 03 Jun 2025 06:50:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f9925sm841658185a.41.2025.06.03.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:50:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS2T-00000001hDC-3YG8;
	Tue, 03 Jun 2025 10:50:49 -0300
Date: Tue, 3 Jun 2025 10:50:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
	balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
	John@groves.net
Subject: Re: [PATCH 11/12] mm: Remove callers of pfn_t functionality
Message-ID: <20250603135049.GL386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:12PM +1000, Alistair Popple wrote:
> All PFN_* pfn_t flags have been removed. Therefore there is no longer
> a need for the pfn_t type and all uses can be replaced with normal
> pfns.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yay!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

