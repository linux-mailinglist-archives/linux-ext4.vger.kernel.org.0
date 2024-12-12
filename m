Return-Path: <linux-ext4+bounces-5571-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252B9EDE8C
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 05:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ACE2813FF
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 04:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BEC165F01;
	Thu, 12 Dec 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWhQGVGh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D60126BEE
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978110; cv=none; b=XBJDO/yqnIfaOQF66dzArZU0xhpmmedauTuF8v/HQIFiNQut0WVbfyzsgP0dA5cKKT7PHgQCAMZUuMVphzP5md+Tj5VJslUPiZGTmZAkccrOeHaK63HP81Gxs0O1c/oHXf2ijJHAft/bZT+4ATirZyCQ/BE9HNm0B/nMzRLToFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978110; c=relaxed/simple;
	bh=ilLvlZcUUBmdlXI8FEVjzvo7IS4oqNYGJn1FjuvEca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO6IF4tAFh8P7Z3ZRwnkWWrX/b88YMEayAkllPPvq3n9A5KTQIRUnA4Z+/ciyJcDKyauZsgXlxDp+zKgLhEhqSr98AdZGqdSa0JQTOHqZlrYWSsfoEe8jrsN/QTqwrYhFw/HLuxTJHTzrogk2PMf/1k+pORiMc3miL9AMFLz/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mWhQGVGh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2162c0f6a39so13266045ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 20:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733978108; x=1734582908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQ5332V/XImi01nVR9uvfbX+zP8Oy213LJgoxa19qw=;
        b=mWhQGVGhK7ocZzEPwL4+s8hJreL/v2rshnO/2qrMEcm3Bj8EQamxsCSWcTdlW08laC
         YNGH+jXlJtjQpvE6USJmkZ14e1ZA26/CNuxS3PsKJXmCJyhjsg896ENHxTp5p9vOcmL0
         1y79IXKovXvRu++oZb+rAdQic5svkYtmJaPG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733978108; x=1734582908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eQ5332V/XImi01nVR9uvfbX+zP8Oy213LJgoxa19qw=;
        b=Y1G3Nm5fLq9B0uRB/9bFMp2VvVg7FdJvAI5llHbKeU9KedOJqoQH4m9zvBwjM2wO5f
         rR9GKbrLltBAC6qKFTg+xjNxH2IBghU+9eSCnRlfD3tDy3l6whvVkc5H896zQr/4oxTV
         GybvRyR93avPmEPITqXL6b53M7BVGQQ6qrsYI2Ov6wcMfOyxylasF+YMRPV4+o0e7vHo
         bKYPiiviFItBaZcOC/QkVN/QoeedhLzFhfJdONTrXpYtXJl1QgAk4jjQ1Jmh0uaj6FOO
         5W0+PZ0wuGx4tpf6XFIyXko2r/qNqevQGkgJ8mz97FJse5lh9yqmStj74mltazQ4b9Xt
         AeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFkiCd/6mFw9QwwinyD+lzJNjNuUKrNS/bdZJX4Ojh30NsSCW7UmBBe+RUE3qX9paR4gljE4QYwpZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8eOWXZ4rlr65iL7+J+AmMqcnFikUupLXv2m6nKZavNjFaraO
	N7y+fnlKt8waMjvG30974WGU0Z4QbZyGRJjV6IopDdS0L0vyd9K2MSRSzC/jXg==
X-Gm-Gg: ASbGncubx8Nq4th0G5leU1iNsrnNRnVSzR731t58AZ6p0RGX4wpob9lXZZUITeIaIPG
	KFemaTRnmmVbMdr1gVqlr7bxMuMmHzXA4+d7ZcpMza0R49yH3+LqisFOxNp/fcNrNcInCBys/4q
	IcrbGWufEvob7DGIHT68/lUiYdISt2md2M1vbUWg/PdLk4R7l7aEnXBVEm3xmEzYKB7HZicvu43
	geEk2Ua9ioaPwVIURT0FyOGfhL7pX8OvdteiFF/ptHZlCB3o+Pf3OMN34QT
X-Google-Smtp-Source: AGHT+IEbTjYmoNjSHfYKhvMhadIRj8HQ01ctqbumJOOZupMel/xzlHR+iDynhJ3nrhudrJBVMZIUlg==
X-Received: by 2002:a17:902:d491:b0:215:44fe:163d with SMTP id d9443c01a7336-2178c873b07mr27094985ad.17.1733978108182;
        Wed, 11 Dec 2024 20:35:08 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164ec76ef8sm59938415ad.228.2024.12.11.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 20:35:07 -0800 (PST)
Date: Thu, 12 Dec 2024 13:35:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212043502.GI2091455@google.com>
References: <20241212035826.GH2091455@google.com>
 <Z1pjJWkheibiaWuV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1pjJWkheibiaWuV@casper.infradead.org>

On (24/12/12 04:14), Matthew Wilcox wrote:
> > We've got two reports [1] [2] (could be the same person) which
> > suggest that ext4 may change page content while the page is under
> > write().  The particular problem here the case when ext4 is on
> > the zram device.  zram compresses every page written to it, so if
> > the page content can be modified concurrently with zram's compression
> > then we can't really use zram with ext4.
> 
> Do you set BLK_FEAT_STABLE_WRITES on zram?

Yes, zram sets BLK_FEAT_STABLE_WRITES and BLK_FEAT_SYNCHRONOUS.

