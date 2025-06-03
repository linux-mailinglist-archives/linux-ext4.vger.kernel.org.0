Return-Path: <linux-ext4+bounces-8292-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0002ACC873
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18A3171961
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D123816C;
	Tue,  3 Jun 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IedptUNT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA323815B
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958686; cv=none; b=Y339ZrtQSuSp1zzSxb6NJO4Yjfbxm1P6dbQOBfBgEuIybElsokFjjrxIanfVHmWn6wze0raxel3Olm8k9JdCUrUoSJVr8iipz8+6W66sACTMxTOcWPEAzPbZdrHZGaxX87nwQNmWrI3SSuq7J96ejRp2HmXq4NxIwv6iQbnN+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958686; c=relaxed/simple;
	bh=DZgdvaQsVzy3FEkZ9qjIOfWCU7WN4gcYp04RM+bGGPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxCRl7XGaPO0EYD+n+agBKQXMC81xPdPksw6WdphecKTSGax/3yZPZBFc1+IzFKGMZf1QtUjAVUPO/Rdo+ghCdRdBk7D3XGDsaiKVvm/zqILBzxqD8CBHzFRPstR8fmcFukeLkukIUtvSpHzi9Ct/OX1wwqI2BL/Ry8kfE5Cn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IedptUNT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecf99dd567so65998226d6.0
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958683; x=1749563483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzY+cZCL0448RY0GID08t4arF/zf+2+XaBNqbHYkIpY=;
        b=IedptUNT6Ql+/A5IUfTIL7owDIGPJY0PsmqMowMi5fm5w+soHZVqfQoQ/cDhRyyczv
         gv0wx05D6nHlPoaVhBYfP2NoFtlfEgPYO+Ch19nMcWVuzoPb0f0eCVPT/4CG6/dc7BHT
         n+YnHg/hH46ufdhzaX4fPCz7fdGiDzfGY3LntiePxXSGPACwjQotc8xocpu/j862zsQz
         aE0A4G3dVJHskD0CTgXP9wDqaQOPOqXniIfLaZGjazqE7x+jp2UNzQhfuJDjnpDeqMri
         vzpw3L9W4Ygj2ge2rovOCCf5BtnKxfSuTXZie1+lX5SvFbGbR7TDt8/rDu0mRdjOGZcH
         wWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958683; x=1749563483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzY+cZCL0448RY0GID08t4arF/zf+2+XaBNqbHYkIpY=;
        b=akpv7I17LyLmkmB2Uy8llcdDTDxYQPdgb1umC8v7k4xBbTgYPlLBlgM2lw/YT1YFTv
         xmAUNOy6sK+Dir9lf3UohN6Fl736MGUoz6rCicXO7DE5oaXZmIxaSkGTysik5woxCSGM
         KbaJIkpAlyQCSzCLrjOA9rlE/CJbyYRuSk69VUdFzVsOGFnagG5YOkL1uDUUt3tWvG16
         GR4BNkWzrjqrJs4UU6vezm9Obi3c7S4uRl+udyCoQfkdTIjXz/jY1OuCnhOAZU0RxRC2
         aGtiKxm6toF1yrN2tVXVNbXc9CboQMNH+1fG0NZXZX3s2SR/l+bq7og7UikiR+ezG1X8
         e9LA==
X-Forwarded-Encrypted: i=1; AJvYcCXHf5j5OIrO3jVDCN9YGOk4cVy2rwqs6ddFMHG/uOWZKLrD/97JjUvnqXkWJyP0XK+HWLp+tXOmrl4V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AMB/+yQl/q3m4CkU3QJU3oF3hk9c9njDwDDYRI+0GDLuIMxg
	G8h39XU85DMqBAOmOovU1nFGJuc1zijyfaZU6ZVdIrjI4XLoH8HkZyqUIbaGdNWDtK4Z0mn2wsA
	AFZZ8
X-Gm-Gg: ASbGnct9/ZPukYwFGin/2lJfEWKhSSLLQSSxg2h4Rv/bWFmNFdoz1odY+g3KMB2zApz
	QeW05wyZqSk333My8kmW8CtsEHOkgOKFhBoNLSVP6PI/gSzcMPp6wqISvJWq+u4wXSMJ5jFkvAw
	8e8npiqXVvuvqIThq8qhLZ1cM3638P1+1uHd73GV1F1H08XA1rMvmLSNUTIYCV9Tsv9fyrWhBu5
	Ea9IVMgW/k/yQuW640aZydrwY5YHJ2ITD4VZIcH/ukWV2pDD5JiSk+R3i0tRer0Q9IPrUw1n+NE
	D/eLPXgPrvRSDrCtW+YgHB2Z2VNcBZuzh3B+ftzv1CJZFx0qEJnWsW4+DhsAjr3Gf/gLsgsMKOY
	hVjdSjhaiaE3QA/0F3lMd+qL0rEE=
X-Google-Smtp-Source: AGHT+IFvqH9ubcC6dbv0UqQGW5DGDtp+BZ9QNaQHwHo+bs9Vg0oCfSh3AzQ5xeJI5fTattmwccxXPg==
X-Received: by 2002:a05:6214:2aa3:b0:6fa:caa2:19bc with SMTP id 6a1803df08f44-6fad916605amr159392986d6.44.1748958672893;
        Tue, 03 Jun 2025 06:51:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fad0495cf2sm68040826d6.39.2025.06.03.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:51:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS2p-00000001hDX-3xh9;
	Tue, 03 Jun 2025 10:51:11 -0300
Date: Tue, 3 Jun 2025 10:51:11 -0300
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
Subject: Re: [PATCH 12/12] mm/memremap: Remove unused devmap_managed_key
Message-ID: <20250603135111.GM386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <112f77932e2dc6927ee77017533bf8e0194c96da.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112f77932e2dc6927ee77017533bf8e0194c96da.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:13PM +1000, Alistair Popple wrote:
> It's no longer used so remove it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/memremap.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

