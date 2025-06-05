Return-Path: <linux-ext4+bounces-8321-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF50ACEEF6
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jun 2025 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376053ABBA5
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jun 2025 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5721C177;
	Thu,  5 Jun 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I0osl0hl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5A218858
	for <linux-ext4@vger.kernel.org>; Thu,  5 Jun 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125363; cv=none; b=tQTp/MwdZSSfoJec3C88nadkhntPaMamQZjO1plx+eK9zJ585nlzLZLwPnnI3gmE/9EyqSnGRth+SyNT6cthj3gKN3x2v+RFgUnXDgZHjtIlikWZNQd0Zp4hCZhZgb0sOvykFkaWQPV0kBD3lMqqrS7LM7gawf/sW7fF5G/6BYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125363; c=relaxed/simple;
	bh=68ST4wWru6aYFudYB/AR3+klXokvG7WPyNYVacGmxco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJB0JVo8Oj4NfG4Lay8ZK7LXEou0wQIdezkvKaCT532EFS+tM1b9g8e8QUDRCi/hBlmZ1+/SeEBwab+Rj0K/7rGPTaL4L/GQKtvUnddhhfVcIek0/EThCxqAQ4Sg3Oms09Jd/8+yAjeFlBPmQr1CTT9t5MP2bqwwHszA7oUzIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I0osl0hl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fadb9a0325so8791556d6.2
        for <linux-ext4@vger.kernel.org>; Thu, 05 Jun 2025 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749125359; x=1749730159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNA1AqJPiuiUBzCeRC8bK1nu38f0qCHlYuwt9uDWl+g=;
        b=I0osl0hlt4Wb/cImSyn7xpSmr1foyB4eyd+a5FZJdcMpmq0atJGB7StBZyENYtbAjo
         bW9cIyQRYLE53n7QdQ0yCDv19KXYNITb/IYQrJjtsgDwbvT6v3/Lw3PgwRTn5tPV3kYt
         A7XvI7/W8ynRihhAmKIuK0j+T4HbrSOTDRAopm1PiPY75dAyj0Jn90+7bfFi3b7yO4Qn
         bgCJIxdvpy3cwdSFVbvKNbb3SLTQRJ2NzhraEow1wJZzkTTPkccKIRfm6Qkfx47gBD69
         xzE4vscJt+NJLa9s5APp6AdsiUhZpUTeUHLdl91VJIXOafhwkbWfRRJTmPFHWGE9BXem
         aijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749125359; x=1749730159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNA1AqJPiuiUBzCeRC8bK1nu38f0qCHlYuwt9uDWl+g=;
        b=GK15IfhBEeu95B3Oa5gh6oQkEIDTkqMQIKtUYfeZ33TG5ogBiV4wFzmGW3svuOgTQx
         crLjZfmC+kiONeUBt/fQJ1JeraEDscQ3U0LCJGuO391ogOeGCAKsA3+qt67jk37E2vL9
         ORaMCSFKzBAdk2TRGc/b3+TsWEwcB/N13Wbu/59HwEY5pRkSUTna3oaTdYcdGsxgc46r
         dbZtg+glEkZC66vGJorHdizeNYpdTictE6WI+EQp4AQtZEM/gsEAuIN5ZcDgin6hMpCv
         D0YcHWVv1tqIR5DZ00Yl6jkX2BiTNTPcuJLrgv/H9Ok8TEYEJGuYzWN4WPZ8XIUZoCAz
         y07A==
X-Forwarded-Encrypted: i=1; AJvYcCWEGmrbUufrUA/5jrvHGFbBATXrNQ/mm+XN2mScTMaOuIfAUVCjILMJMDwYow3r0j630k3j2m5hfDXp@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGpAXP1sKl88GR/UCh3Bl9JELJqrAN0czmVSMsGJuZAFLq7x3
	M0Ov7aWxCH+p0xaNVEXp0HRI3X0tI+87BGOuSOsrMKLzlB8j7Nw8upPkKUHby455pwA=
X-Gm-Gg: ASbGncu+mMs7J2F2opfT8/QK7L6gjssOXJ8W+kQtsWvLaTHVF3aJ9YpP3t3sKcpwd1W
	l0ra6tHzYkudqazEVsYOB84+94vAWs5WxdOzbPhdOo2uDHrP2Yknnqs5IfT3AO1qheOFePygNjO
	M1q1M9g8Hylh1blNTAQmQpuPY0NSND/HaeQzO2exccMzX24WT0bPCRU4Vdt8KAlnOQmTTtQ5eL4
	CCpcCDjfsmJByeuirmw2wkXXG2lBjdAa+roWm1CVmE/R+wTJId3w8GQ2ExMj/7/z1IUE7WbzcBk
	56yIsrKP/f0qYbaRKorilrBkHr1U1DLSQx07a4JB+mKYmPD/VDrwEJDiusnQGNv4cC70MTh/9Xz
	00PSiRIKQplQZ+m1QH64MuQ6vGEA=
X-Google-Smtp-Source: AGHT+IGoKm/5U4/UM2uM64qO2HBitYJapsKbuDFJlmk9byEyE/W8ROsmev/IR9V9jeal6LfHAI1O8g==
X-Received: by 2002:a05:6214:224d:b0:6fa:c512:c401 with SMTP id 6a1803df08f44-6faf70163f2mr115317766d6.37.1749125350351;
        Thu, 05 Jun 2025 05:09:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4c7d8sm120604836d6.36.2025.06.05.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 05:09:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uN9PB-00000000EdT-18gz;
	Thu, 05 Jun 2025 09:09:09 -0300
Date: Thu, 5 Jun 2025 09:09:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	gerald.schaefer@linux.ibm.com, willy@infradead.org,
	david@redhat.com, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, zhang.lyra@gmail.com,
	debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, John@groves.net
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
Message-ID: <20250605120909.GA44681@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
 <6841026c50e57_249110022@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6841026c50e57_249110022@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jun 04, 2025 at 07:35:24PM -0700, Dan Williams wrote:

> If all dax pages are special, then vm_normal_page() should never find
> them and gup should fail.
> 
> ...oh, but vm_normal_page_p[mu]d() is not used in the gup path, and
> 'special' is not set in the pte path.

That seems really suboptimal?? Why would pmd and pte be different?

> I think for any p[mu]d where p[mu]d_page() is ok to use should never set
> 'special', right?

There should be dedicated functions for installing pages and PFNs,
only the PFN one would set the special bit.

And certainly your tests *should* be failing as special entries should
never ever be converted to struct page.

Jason

