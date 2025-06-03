Return-Path: <linux-ext4+bounces-8287-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15AEACC84C
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B733A5A26
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53023A9AC;
	Tue,  3 Jun 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AjOqEgfZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C9239E99
	for <linux-ext4@vger.kernel.org>; Tue,  3 Jun 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958500; cv=none; b=aTqsW08FhmmaYit8gVCKokwDDdOT0K7D13nMQsCACw5hWxOeAfxpdRTrlQEwsG1lgnuqkqiBCRXcuOj71a9QS6IkBCR2qJEWWL7Nki9l/gPShIeFysfdFmrKsH+xBf2OyI5/apT510IBRiMSubiqV0xcd4I5kvQNHnyESOBYbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958500; c=relaxed/simple;
	bh=y7QlyC6KXPLMJYPeW/fxUEb7YGMf3rqlxQiF8jReTpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkv8RUd710jiBQEFTW6fRBwM8mA3QREI7pXfRnDdmt7fz/9UaTA1ZkKohNy6i7gsUTyPTWdGS9566yeRmQR1EBakXT1U2ykB2gaSGBiDuYnUlvDwPUUoUJyZhfppNXOF/ya3e5FORDXi6Td2+vfzcyZqPSu+swsRZD8zseVQAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AjOqEgfZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d094d1fd7cso745196485a.3
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jun 2025 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958496; x=1749563296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ag2KSfmpizoceiuoj+cZXZUUA1usyi82jYygfJs/Bg=;
        b=AjOqEgfZCAKJpwstPgw4JUuuLsAGp4nuxZRwWsRx7CMfzOZNcGorTQaU0A+5m3TJgs
         r4OuHdohJGbuNjZ0ZfPjWtHdlHW0OUVT2MLGLWgssYWADyAl4O71jzDVYgB/hFpePHMF
         82h2pWYP3V1Wpd/Dx4GOY6hgM50TO3Sw38gXNjoK5nIiV0BAazMOQed27p1HtLGXrzfG
         Y41CTIjAqO84UvYK8NETu4qxigoFB31sHhGw/l5w/mwTsZm9iCHyHZFq5TAYGiWTz4G9
         jlH6Zb+lGS1JwhW2YHzLp7uXrXNKjo1ZIRmAJZ8hteKsQOdVlximwGQrn5r+EpsPZYxy
         YDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958496; x=1749563296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ag2KSfmpizoceiuoj+cZXZUUA1usyi82jYygfJs/Bg=;
        b=aOn0GbGHXk/tFepCmrBJQNL9Y07lOPIQFu/jR7+IYUmkiQG2L+yNrUHS7xz705MKya
         mH05D++P5D8YbcpdsenTKlWj5QfasZo6RDvdhcq3P1GNKtEAXC8rVj+86BzUwd5JXejZ
         tttdXeAThFejsSeBhAxPtkudBLx1jepvjdYApM6F3TA3RQlFev9B8L//ek8gBEqHs/fW
         e+3nKWVm2nHih8svq+osEzwtOArLoJTk2OwEmmdLRM7IAicW11CkmjzzvS27zGM94Gj4
         azLpJubcB+3MF3SR8n68Zn5iZqf7gb+wnXYYLuUu5KJO5hEeecIrQlEzDO+6w0nqRUPh
         G7XA==
X-Forwarded-Encrypted: i=1; AJvYcCXLAnupdkiSgm3U2hK6QFiiiW3M8349NslYzq5jumYNPs/L81VUErNiJqaHu2ddsVoJZKdpR1zbNAOk@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZJjMl3ig5moJy2YhZXDd3uPy/u17dZjk1XlqCCnaLdkpZrTJ
	xpMff388mUSNRT39wlZK1aVhdrsCxAMIZ4LqXMzbctMP4zi/jfT54XQqOcAY1mwRSwI=
X-Gm-Gg: ASbGncv9KOMgsW5nlepEuy4NEH/Zq9T5No+HRg/W2+l0DJjICzFlK1pUpCp+wU2YtfA
	nCZVKEfHhBIEbOgsfmAyt7P/RjE4w2xI1yxVVpZ9bQ2QNuDDIdYfcqAlVW8iKr6dVVj08eorIfv
	pudTwbiliiqSzwZCiwe/77HoUgr65QamL+ouIYEe+Z+Pinc15LBlWTRAkXybGRx/izaBUT2USte
	iXkYZqB+yTurpeiuSmFjoKyavttfBR3TCbYXImfWC5J6FtM0eoH928/UFsFYl3uyXqz3jpBbq68
	CmqKBBaSRBPdy1QjyEdaFWKi/C7bLxa+kMqEO6yhMzBnt/xBR07IRrewpFVz3LSIJKF15TTcYb+
	MhoJ16sofJ6nMs5YZLwDcWQMu6ow=
X-Google-Smtp-Source: AGHT+IEC7tetoyd4MWB27Cys7lEZRwLgg/tDNDKGL2nO8t1WlsQDGW4e4zhoToAJp9Wky9F+fr/2kQ==
X-Received: by 2002:a05:620a:290a:b0:7c5:544e:2ccf with SMTP id af79cd13be357-7d0a4e57644mr2655730585a.57.1748958495697;
        Tue, 03 Jun 2025 06:48:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e3fa9sm838696585a.24.2025.06.03.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:48:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRzy-00000001hBT-2tOq;
	Tue, 03 Jun 2025 10:48:14 -0300
Date: Tue, 3 Jun 2025 10:48:14 -0300
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
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
Message-ID: <20250603134814.GH386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:08PM +1000, Alistair Popple wrote:
> DAX was the only thing that created pmd_devmap and pud_devmap entries
> however it no longer does as DAX pages are now refcounted normally and
> pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
> and pXd_trans_huge() is redundant and the former can be removed without
> changing behaviour as it will always be false.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  fs/dax.c                   |  5 ++---
>  include/linux/huge_mm.h    | 10 ++++------
>  include/linux/pgtable.h    |  2 +-
>  mm/hmm.c                   |  4 ++--
>  mm/huge_memory.c           | 30 +++++++++---------------------
>  mm/mapping_dirty_helpers.c |  4 ++--
>  mm/memory.c                | 15 ++++++---------
>  mm/migrate_device.c        |  2 +-
>  mm/mprotect.c              |  2 +-
>  mm/mremap.c                |  5 ++---
>  mm/page_vma_mapped.c       |  5 ++---
>  mm/pagewalk.c              |  8 +++-----
>  mm/pgtable-generic.c       |  7 +++----
>  mm/userfaultfd.c           |  4 ++--
>  mm/vmscan.c                |  3 ---
>  15 files changed, 40 insertions(+), 66 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

