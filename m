Return-Path: <linux-ext4+bounces-11104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F2C0F8FC
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBC9C4EBA45
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B4315767;
	Mon, 27 Oct 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3txy0tOv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D230FC05
	for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585170; cv=none; b=H6JtUPbeU8LSKBsKPXMdqt6qgq42O3wDGRF5IakW6/smWP07k7xBCKWWYcSKKQ8vyOmVPqyyOg6IYgFSXfr+rRnFG4DURuzdY6jG+s0Y+NNnY3eT2WEnFjmxoX5PXaRX+f6bnjCldiikyLbauGZIS3CgGsL2B9DKJ89omE357Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585170; c=relaxed/simple;
	bh=eeCcaiB5m6mBMPE2QFVNav++Juuy6BY9qODhUaJkbbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcNrmQPfJhOv6HimMjiHHwq+1+Bn6HlDzQ8fd6DaG8UscO5ffixijOv2aaQe7Xm1D0hGsZDUhlK6uj5iUBYAjj2vT88VwJXL+GdTGqhOVuYC+ojgCR26WYK4zp/FITtAJgY/qrLfRrEraQ5bfeH3301VUJ/g/3eLpRQBX165BsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3txy0tOv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d67abd215so13695ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761585168; x=1762189968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPy+FHVUTDlqo9kS8K0pwEoZsjWCLKbllIO0a4/trd8=;
        b=3txy0tOvQB9Zzi2DRCgScrD2MNOnRQqPwvbiqFKqkxk9OeWypvULXELoePexHM4xCb
         KzGlJ0QmT2WpG6h1F3tNfpRcbawVVVAUBQIwR5jV8f8ChtCq9L0jtMQOJmOfrhCObz9I
         C/4bjn+Qx+qoo4dJtoQgWN6+/Umt2pJInfypP9QhlxM1X0dEzPrwSPrnQY/+qT24cuEq
         1XRqEbT7a7zFFiC8vlaguLgq3INGB8roO3QVSfHSAdIu4EyUnQXqi9/LBdV31tY4CcBH
         +dGaTepAgZQbAfQ8+HL+tB+/6pxn2waTKnt38HF2kPZ9DrWhZ9/jq+lfLBC3flE44b7D
         H3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585168; x=1762189968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPy+FHVUTDlqo9kS8K0pwEoZsjWCLKbllIO0a4/trd8=;
        b=o4bOK2L00aAoMxllj1/+h3ttAEaENuvNuH5sHK7X8cjWz6zIdejCcG937MGByDC+Kp
         PZdzcDm5RxmA6qjWpj4vKEB6U9A/kilrjEeL1NMT6rSqV4dFCYMvDdMIJa1SHzNYhJl1
         DeqXPUetaNw5ff5CSBQU85/zxY2GE4tZ5pCTawfZJhWPHpVhyRWQFAdMs8hHtv2vJAHT
         PgST/pP7O4YTA2n1LvEVGZ3hpXaiK1IojOMwVSaokQ0I7mPy8ebcHCylM8o3/PUrbBLr
         keTVrATDkJm6GH2oY8elkoEA2T4DNETNjdgpknsRRA1xYxoTvsgCt2YyNMwBIKz02CW7
         9Vgw==
X-Forwarded-Encrypted: i=1; AJvYcCUWDV2M9bqVdM9K2CIfBM88PR3dhrO4d7zhfvCIf/GIqDQoP1hVJZVaM7TkSIWJq0ewRJigEkdxZYGI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcg+abiYuohe5ofv+ZRiNq04R8yItJxXD1a/Lj52SOxcD2Ogvo
	fhP+6Tc/3kTujZoUU+TOXC3nsPMPX0dXIU3sf/F3sZtdhLBYua1LVu3dgzo8xmI7SQ==
X-Gm-Gg: ASbGncuTY7wA0C2Zh6hvdZHn98IQE1vgAL2BYF7RBckystFCEGH7P5IzHMc+IKHDNrF
	w43qyabLPav+DmYOleQWaP2GUYHH8x8GADHuzMbkdkOw+spGnO+kQaFFcWd6GcI247pWHyhnwuu
	+WqvQf0veJXXRPAl71gFyX2sEvrEyx4jWNR0CZk17mdT0za8h9TQY6I5Rzz7DSpML7ACwc7eRwa
	Eq9bZ2jkeCrkvvcvaHjh2Q+yY9bFgj/Cs9kQFvQkp1MFCSeP2Ur6YeA0Z/jUzlIZbKL3ZBhz1dU
	mrBBgZ2YYGAT8+x/kmcUV476NRXrzlVxghNjKN/zAZWL5gUsP/pZlTKBuRuoeasQIIZiVO+Esul
	FQt0zwPKYkadLrSkplx5HKy65aYNcDl6uGYn+ADIrGVhJ4nA74OkUIlx/PeVS5d7VxmD16KwJOw
	apD4v8P1+DcYPsijirmzq6n8tYDjuaKCvjqjapJ0o9LPrC9yvA/FtAwb0GIf9UHCOc+gUJIY3kh
	gKBE2Nwn0lezyKxLC3CHQnz+hKoZoHk1B4=
X-Google-Smtp-Source: AGHT+IFqnCggieYC70G3l4AysmlLY9PDhAFPBx/+0lwHkbnuWCU0qCp4R3nH9HyqPlC8U+RgBeixrw==
X-Received: by 2002:a17:902:e807:b0:290:c639:1897 with SMTP id d9443c01a7336-294cca88caemr184895ad.2.1761585167716;
        Mon, 27 Oct 2025 10:12:47 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34028fc5cc5sm32860a91.0.2025.10.27.10.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:12:46 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:12:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aP-oCfjViaEIowQe@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hByAKuQ7ycNwM@kbusch-mbp>

On Mon, Oct 27, 2025 at 10:42:47AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> > Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> > O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> > However, if I understand the patchset correctly, this is intentional
> > move which makes this LTP test obsolete, correct?
> > 
> > The broken test is "test 5" here:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> > 
> > ... and this is what I get now:
> >   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)
> 
> Yes, the changes are intentional. Your test should still see the read
> fail since it looks like its attempting a byte aligned memory offset,
> and most storage controllers don't advertise support for byte aligned
> DMA. So the problem is that you got EIO instead of EINVAL? The block

Yes, that is the problem.

> layer that finds your misaligned address should have still failed with
> EINVAL, but that check is deferred to pretty low in the stack rather
> than preemptively checked as before. The filesystem may return a generic
> EIO in that case, but not sure. What filesystem was this using?

I see, so the check is to be deferred to the block implementation. I
don't really know what fs I was using, I throught it was ext4 but let me
double check.

