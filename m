Return-Path: <linux-ext4+bounces-8288-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEAEACC84B
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA5188758F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E73238D52;
	Tue,  3 Jun 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KoP8asrO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5423875D
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958528; cv=none; b=jL8up9sgq+bnaLdrRks94p5ZucbD1jB9f5DPdflVbddfnTBvuVMkq/XD/LmllTejsei7KU/GbjQ9k5FkkKZ6vVMR6aNXwf8UZ5zfpnaGvgiXWjJmOGfK6Jn5GUxCnFgfOYfm4mUMSdnvk9qmNpZwBXQZ6w79L7JgGAIdC0cL4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958528; c=relaxed/simple;
	bh=RcXEhllfDG955BJXEN1tqIgpRJ2MsHzTBep7rZd+naY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTGgyiKs3O0JhV60KAblLba8UU5t4RA0De2NWgmHgN5TBWEWygS+Ywh9izZASx5+zf6kBB2Uk+w4jFUvp+MHoHFqJLlaEcs1UeTrC+pUfo77/0JXsQRO5lfY4i8+Etl0aU9a4S6wJSIG27KVRgpKZ4JF3ewftajmlWHCcLMG4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KoP8asrO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so55273406d6.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958525; x=1749563325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSTZfPDDH1MLe7AQH4Yed2Uaqt/hLn+gokhyp0JhueY=;
        b=KoP8asrOMIEJethoS/itlxDSGu3+zKoaKa8sDFbGOOwqgCYGuYTFZfYS8Mnkx+tl2G
         LjxtWypcZcjUxtywmuy3LTV23DzErA2mqesc1QMxuKAF1XQppJ55Q57IUPuLTyiUn0Sk
         YS/uss7FvucPNO97r9KoOsxXLFtUQJm+qNUu/DkymsWRGtNsFPMKPn5wT9vBJuunJkBi
         /ukr6MpVltCAllXmAe7Dx+EhPp2hMVvhbhJNotnIQu7A2DxkaHLbi1S2kV3TyJK+7eoh
         hFWkqGTwpByFV0dpwd0TOBMUr6BTdcw6HqglUcBifaQWg5i7gw3KGyxZEuz/Utn1gmBa
         rs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958525; x=1749563325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSTZfPDDH1MLe7AQH4Yed2Uaqt/hLn+gokhyp0JhueY=;
        b=gaq9EwYqV7wM0UuwDZz355w0QoOQhG4TYvXnv1zroBVLc6Ym06PHiQtn6dbtBfd6Mg
         St6plI3SkpMqoo01EBbpsbuJD6n1AAvdL+tAsbjXNDzLHc7dSMkITve9tu83nCM2HIFz
         /G1B+GOPwteLNTrucWO34/eLHpa/FVVX1ZLlZRUcJFd+8RsjgSm9cMUsgbkhmklBr7mF
         DPPX/oUQgIRHlguwj4yU0UmoIKvuIKCxtOYHzuLkYqji1WOrhw0ME8mfodylIzdmuSs1
         lQrUDmjiNYIYVNyIPKs+i+9m/kiL3Tfsf0kMGzkQKxd8cOeKgFThu2XHo80B9K2XSanD
         LaMA==
X-Forwarded-Encrypted: i=1; AJvYcCVy4TK+SgMrTgRuWQJbqErEk5UL/1Bm56RMci0/yxVip0gV56h+VIbGYcLHnliz+nG5ASYpThq+6ApN@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBQx8mmcOeNbmyN27YCxfuPyIkmtH8fF6QERN8LRCGr0DljUK
	i619+DNyxeE5sm4MNNj+QlrpUp+Rlm0Aa8WY4MD/lYYWGZTaHHB0hqVLG6lqLfEMQ3+W1Z0hzgm
	c/KH4
X-Gm-Gg: ASbGncvg8xuJjI1t7mfu6z7CxIauVjPphIarcUHMDSpxesd2JhuF9THatqm7PA8056U
	9RFrB70Z4PU0yXRIyECKkhMkjY+xHfEYHKKkponQrQ4Vd+tKmqtpHJ8WlYfuWNRk5Vv06KFjkFr
	4fsQVCcSdhiUiSZMpJqTmHkb55/tcdkbauTySjFhMjYofyEbSSZ4At957+otGvJCvzUDdNniGWg
	7CtBQeOlc+pXlZ7Qub9+9qPI8WBkAxgzOtliN5cxh4DGH7kovCIeLAu8/1GSQy0+rJ7jeR3p2MJ
	zLkDGTLUxQ1WCRTdal1yRfUR6WNkj8wQ+u1lq+a8fcpf3dEFX2Sx1J2qlQAM66BtydPDaJSF30R
	jpsXfivzTmY4ya9Rk2jbXVfMPTBU=
X-Google-Smtp-Source: AGHT+IH3Vn4y24ccOnNjvyrMKRdXMvoXmINXxWtKUHHRDjsnlypx2qCEJce143rhCfMATkU1PKi1PQ==
X-Received: by 2002:a05:6214:27cb:b0:6fa:acc1:f077 with SMTP id 6a1803df08f44-6facebef794mr265266426d6.35.1748958525108;
        Tue, 03 Jun 2025 06:48:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a10e844sm842209085a.49.2025.06.03.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:48:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS0S-00000001hBt-0o7d;
	Tue, 03 Jun 2025 10:48:44 -0300
Date: Tue, 3 Jun 2025 10:48:44 -0300
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
Subject: Re: [PATCH 08/12] mm/khugepaged: Remove redundant pmd_devmap() check
Message-ID: <20250603134844.GI386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:09PM +1000, Alistair Popple wrote:
> The only users of pmd_devmap were device dax and fs dax. The check for
> pmd_devmap() in check_pmd_state() is therefore redundant as callers
> explicitly check for is_zone_device_page(), so this check can be dropped.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/khugepaged.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

