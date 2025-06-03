Return-Path: <linux-ext4+bounces-8283-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83835ACC800
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB0917099F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809B23506E;
	Tue,  3 Jun 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QdRqef0e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58722FDEA
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957823; cv=none; b=Ty7XwyXPi0pqO1tNzWNAa8vbP5OzeSl1UpNasI7VVR6j/yYFVsMtmdY7SntQ2rrePYNk+ga6g/rlOLtVW7agNovPJE3ZHeN010VZA3CUfcz59KppQTvi6bSANCpil9FR5+qoErekaSUlX8CvMI/B5ngReGVlD9RNOhz681SLD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957823; c=relaxed/simple;
	bh=MfnZO5lFJA5kphVhQXFmjyYwzPaWj6A9QLg5HcsjC6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExHtv/ZbQNj/KrhNno2uzJHulVYhx2HOEEopNTpD/3atVSKt2GbPmUbQmlW1ypiJFgnmkUXWjfmEqOwH2DTyld7pFxYJ014H82oEXNBXnr3mBwOorakkgjdMT8Qdb7LBUqn/I2qDuzimyWUiXkpCANMAusyAxncLSEPZQhzjoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QdRqef0e; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d20f799fe9so127536285a.2
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957821; x=1749562621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2tOvYIRYhJ3zgazeT9iy9SxHIfkqCxujQJZWAlLZ4g=;
        b=QdRqef0eufvBDPsFNSKgItk8ioK5rW0bITD7h/gaJVlsLti5kJbkAWQoNEmZWRe68Y
         Q4oF4tefxOI7cERsX4wsVaBuaHz22hTf4BcC/yjkMVx+8DuPCBDLYZ3A+RWTRvaraqNs
         e7pqxu3qqrej8RwTwZermIn33SpopTq52Y2nm/rfb3Wh5IxZqh6cLkWQPdwWIBjD+YoN
         aiioFJ+ghZ9yPVDMy/MALzaSX/kPFwincvLa9cv4TcSSylFCgKj10d+Rbd3GZwiNMEHs
         ubZ2U/8vLM8FJ3hFzQB993FiXCNvO+ks/3rtygYKqSmy9D7l/904PPCBEYVreULiWIuI
         rFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957821; x=1749562621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2tOvYIRYhJ3zgazeT9iy9SxHIfkqCxujQJZWAlLZ4g=;
        b=LU2t0H5k4pqPPy1JfIkW1ek0gLByoesIy2XUvtySQDb0aNPGkR3Kscns67+khp1SvR
         Elm7vE2xGS9JkUQqzi7gHFrI5nWLhuRh02maXr3ptGD5a2BgQkBbIRI5JdGH/QX9B727
         cyDSFhAIFhjLR4yuIzmRn3OJMoZyp+nKcd4cO8LGKVQFfBpiWAAW+VtQ28U0r4LcVzI1
         0eBjR4MXas8B8/1dF6ZfOl8PCHir8EkF7hGlYIePzMiI4flOaWkYso1ZR42JshoReuJ3
         p6D6Mg8vkCujaZbXnwmlx9ji8km9YpnKNvChB2T7g8TQfi9OHKQJKOWG4IdBOEdZlg/X
         QXgg==
X-Forwarded-Encrypted: i=1; AJvYcCWt/u6fn7z/8TOGr0+ne/v3XCVnqBM5O9SBbF3yyIbIGup7td1iUNWkPz8E5Yiktlbg1MpW3MQc2SP1@vger.kernel.org
X-Gm-Message-State: AOJu0YwvM8PwFW/QULaZUpEBkepOUz83McE3aLl/CNf5dhCcdzSlXOfE
	chCTQPN0gvBgm4URfJVQ5qmRzrsx+/XnkP7OdsXum4nxIgpylLgXae85l0hlCe78Eyw=
X-Gm-Gg: ASbGncvyLA6au1AOPne18Vg800F18q8nls210LcIjaPcoQlBsQQBBxLSoeiXnKH/Ptt
	9vy/e2jwAVkVQAh47cx24XoxdVmP37bMPmJW02wBX0QvTIqxxzXATBO8NrQ/6Dd5aqGFZz1B4bI
	V3QwhdviLAMydcipBKi1EzOoXlldblIevey9LeZ1MX6rN73v7CwNfj3kS2e3gvZn0WS7mUq0aFj
	pMaa0m02gzKxThSHLY8gx4mzZ9VWFxH970bJV+iNoDKs8AMcEK9r4OxfTnvPHruCpTz/TZkRv/a
	OrgK2JnOWz8Gs+neOcaHK4iRvPQuchFhHw1Ec7limiVx5rOvK0qqWI1RwwVgBbAe9GSJs+rOcG6
	2QWUSzxxuJKBYhSrWjxPxFE3aO2s=
X-Google-Smtp-Source: AGHT+IF/1nQKKWghBymIv6kapapYp3T/T+mDb2uBcjAQYD1rkFwd/p2CMx7wy82AG8RXeUKzw729SQ==
X-Received: by 2002:a05:620a:4408:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7d0a1fb91a0mr2626422385a.19.1748957820692;
        Tue, 03 Jun 2025 06:37:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0fa38fsm842635185a.35.2025.06.03.06.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:37:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRp5-00000001h5Y-2rWO;
	Tue, 03 Jun 2025 10:36:59 -0300
Date: Tue, 3 Jun 2025 10:36:59 -0300
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
Subject: Re: [PATCH 03/12] mm/pagewalk: Skip dax pages in pagewalk
Message-ID: <20250603133659.GD386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:04PM +1000, Alistair Popple wrote:
> Previously dax pages were skipped by the pagewalk code as pud_special() or
> vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
> refcounted normally that is no longer the case, so add explicit checks to
> skip them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/memremap.h | 11 +++++++++++
>  mm/pagewalk.c            | 12 ++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)

But why do we want to skip them?

Like hmm uses pagewalk and it would like to see DAX pages?

I guess it makes sense from the perspective of not changing things,
but it seems like a comment should be left behind explaining that this
is just for legacy reasons until someone audits the callers.

Jason

