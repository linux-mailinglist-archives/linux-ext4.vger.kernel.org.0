Return-Path: <linux-ext4+bounces-8281-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83EACC7E7
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DE8188D09D
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D7231C9F;
	Tue,  3 Jun 2025 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lrAku4ce"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1536230981
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957675; cv=none; b=Q0jm/EM8+hnDsqs/oIrdvKSXGOeM3NzBgC0RMuqKHyK3JU9JUmtLsN5ymbr6tfC48VbZBGW6m9f8/5u/NbHx6/Vya/CAJ2dC6hhRSrPjwJ7dOGMneJqP/3Urse9dnPBSPG0KoTI2HajmJHS+xIb32sqODiVu75Znro/VeZEGnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957675; c=relaxed/simple;
	bh=Lw5cSrf9yXELvBT6bTYGu3OBlBOa4jK7fmgeC+bgcao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUaCmlpP5Cu0iiIZVXOLDhx0SFT0dkrhP/JEFtMFzC8su37UXfMKdIv4IGatm3KK+Ee3W9QvrvitExgIgg1iiJbVYiEC0jcYL3Kie/svS8emjy0FT7UndYwOqroAr8LHCvwelqF+NWtusDR17mAij5IyjBLwbhE0bX442B8HiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lrAku4ce; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fac7b6fd32so29243876d6.3
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957672; x=1749562472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9eD6fBv50JvJ7Gx4KUjwD3EkSFG+lO7duRzw9dtFZs=;
        b=lrAku4ceWFfd92z3vNIRNznkctKgFgmmyMQzW81z4NHUxFQj/l3xSfa7PCLr00O6ew
         UM6mT2kD6Ct/OECKUDQZG53FXfqFij9nZhl/zpvcIBTGZn0q3FfWJ3rmLOcj/MsP7Gsy
         SVIVWQB/Z0dVQA9/oora/QY9tOLyr7TtDGd6V19zHnLrc/gLS2DpuqdvOgmR3z0NjizF
         6j42V4uqsJf+D3RxJVZDuduTu2Id0UiwGsV0mqt2UAsFiOvCgjL9MRxPLV8RIvcsMdYA
         frhFnACPi8wIvshwXOGxlFJ9wjx1nmtTgJh0ufocXr2a1Sf83OiQD3w05nQQJ5mc9Zww
         TEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957672; x=1749562472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9eD6fBv50JvJ7Gx4KUjwD3EkSFG+lO7duRzw9dtFZs=;
        b=fpyheYu9MQgOEeykT4/LH4hY2v2RZjfGC0MebSNCkvWMy7SFp20fdY+TQL3taAxL30
         pfqUDq9huFeJLkogfWYi2Ugaw8T9/X0PWgesGRG/u0fdMOBHTzpqvf0GtE2Y5NxdbVVq
         BW+I3jmNGsPl+6z+9jj1YxhHX0YTn2v/hfZPSKfrYYy2StKlc+5bu4RtTcJ+0NEuBNgy
         uxIr4TSobBvk2sX8hW3O3B8xVSFNc4vzALv14uWEVgFp7VpUBfKHqhBCvBvIDDmQYbwz
         4k4mPO/5ZlhWceAmBGgOBEROwh5YCPugvsRMEAIppZ94BZY3kaAGn9Tyc/a2JQfVhFMp
         SAYA==
X-Forwarded-Encrypted: i=1; AJvYcCXxK6ekv1YCIKGpbmxtch170HahpK1qoMqNmmfXbQevWZwpMWVUFiqul0Qwd3MsdbC/fld94udpY6gl@vger.kernel.org
X-Gm-Message-State: AOJu0YwmK4uUfuH7jc0MePKKzwqUGmvBHrS2MASD6iYclbroy6R7MYsA
	+4p0zKQ1NKxXZfuFzrH857Oa6D1kHpKC1CBecNZu8vuMAdIJq9nSbiziHTLF/VrQOEg=
X-Gm-Gg: ASbGncud5B/jJcwTOcHyCLzZzaM75PaCWSSbVpnhN+auF+QTVeoJUqcEWYYbEMpV0Qu
	pxzIRNuCG5SCbD0qNKQw6hsNQnU8IEfXmkIBK/v6kobzeI3GOr/IJS3k7CFDUyztKOkBq+P3tNe
	jqtsQa80bdoY/l3ROJp2kbTGh5y/IygJJrsOSZ+Bm7pqyJ8Y5BQzibiJgY3oJtceEzeYXCj0wNt
	TAUAqKzUKWjcxBukxWDSpg7cP1czEe+FzZWBDg0HE/VNwLfKSJYDxis9hkbjdr1MGxYwHKiRmfe
	OoYx20hvdBZ4o1lRjekTwCfEV0XW0dXACLkZyVKg1/RVCrtsoHm9eTFY2YCYuluKr5KlQxtCwk6
	PgOlV6JpK+OXTaTPEjmq3Eb2tyYA=
X-Google-Smtp-Source: AGHT+IH3/hKllTZ0eEK/dcuWTgO5QsHZ5LZ3JNRLIXTEioRhdRSPfL4GWfnU3eDieGqXq6aFnuzp+A==
X-Received: by 2002:a05:6214:5096:b0:6ed:1651:e8c1 with SMTP id 6a1803df08f44-6fad90aa622mr189063246d6.13.1748957671754;
        Tue, 03 Jun 2025 06:34:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e00b78sm80064216d6.75.2025.06.03.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:34:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRmg-00000001h3q-2scY;
	Tue, 03 Jun 2025 10:34:30 -0300
Date: Tue, 3 Jun 2025 10:34:30 -0300
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
Subject: Re: [PATCH 01/12] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
Message-ID: <20250603133430.GB386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:02PM +1000, Alistair Popple wrote:
> The PFN_MAP flag is no longer used for anything, so remove it. The
> PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
> also remove them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/pfn_t.h             | 31 +++----------------------------
>  mm/memory.c                       |  2 --
>  tools/testing/nvdimm/test/iomap.c |  4 ----
>  3 files changed, 3 insertions(+), 34 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

