Return-Path: <linux-ext4+bounces-5576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31C9EDF76
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28B2188991A
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143091E571F;
	Thu, 12 Dec 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fv5V9hKG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670B1DFE1B
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733985015; cv=none; b=DkZdz0KZiyUVMLZTDnNIm+eAqmkeZx/OW8OdneRTIAhoktFikXS8XNX00cnDE3YS+t1AdqGfziSZ3YEoHngFpNy+06GEntQckj4cOEvhZViYupQC2EuIlbo5UlsICP0crYZeDhBAbC1TxkHD2OwDnBXyfrFU6k8fbzAnuDuLwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733985015; c=relaxed/simple;
	bh=+q0tO9eE9xIAw92+n4AQ6FcsTcbhA+7zdKb51iYPo/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9ij2B9FUh2R3iDBmbAs/QZL8Plve37/LqHq6Yf1r49qee9MYI7BSIZZxA6voTx6OjgSvBdktUXVLH6H/3bq5UDYtD1C+4v5JPgHk3bihL2eHKU+mY+qXLAO0us7buPKfXgNx3fRl31iXrd5B4FBhxvz7PiguInlKF6VzpM62IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fv5V9hKG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72739105e02so318058b3a.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 22:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733985013; x=1734589813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYO4gLRX7POMC8p86voajeAsoeCt3mE8Gucm+POLq6s=;
        b=fv5V9hKGkI22dnv9pXs0lxmbZPL6UCo+XbQFQInBEkuDV7dIj9+l0sgvOTBOHqsGGm
         C7rpZOKRHdz+OZnHctKydrD8T+dgMZvzY/hPYWDTN6nahhH0kAVGJeRhIf9D9IUolZfA
         PVm1jTMmhwbsAX9oHw1z2JPq6OAIwZjWLYrrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733985013; x=1734589813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYO4gLRX7POMC8p86voajeAsoeCt3mE8Gucm+POLq6s=;
        b=fav6Yc/nGi3L2KE64Lt/5ih02BjOHtIsUsV6yP6nL/RQuLPnJYqpshr1wHn424TVuX
         Z7y9qRbJsH4sY2CVUTQiQhFJzQaq/TndL8lT/CBLKR4zDAHzvwb8Hofc1bZzDq0MSMrY
         atuCPdv/qJ+o7t2nIbDGvIedU270wP4ZIU7T58jsCv7pZHhwCxER8vRxGyN3n5R9f1Fo
         w5psurrzMuSy9QhwhKYj5gzODubiEs64Y6q1VdbPymqalQtNQZIBdCqRVrR60PMff7m9
         AEq6ALIJ7YS9orGIzOYNfhHbh4BYyMbyPY4Fymj92s+tHhoI71zDZ2RkjxTBVL4zSicU
         7cTw==
X-Forwarded-Encrypted: i=1; AJvYcCUaufbFoNB4apKjZz8Qos626v88sMYI0JVJ00RyhJR0jvhVzI3VuNNHwxpzv1jH5wNFVfa2sjS0HD40@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBwIz8MNWKvioBaNUODk1LhoG3Jcg+6HhbIvHotft8zPRh8+v
	zvOA4/zd77F1E5ljpHBt6oDd/7WV+r2vAfHW6Fx4b4kWrKCItDmNJZm1jfjsdQ==
X-Gm-Gg: ASbGncsIo7FVj0+4w/vsicVfxZWyC9YLUxmX+UAkyFySMLiTEl9loKaxAqXbXRxx/fb
	EPgt3QeILoN83kcUuYwIAxg5siOHNLYTSdApPhJ8Gfrn68d7pcw/Gl9LWW1SMz//SFULyTQGGU+
	SsLpgByZnzmwLUNkyLdUCIzHUvZhPRW2+rFWZr2II6hbJhdlfJLQwfGt8e6KbyfamWs1zVi+8Lu
	EM/AzUlMgrZWEDfmv0S6XsfnHB7pwG7gQmxHTbtsbSCokXnSPokQDThlYRJ
X-Google-Smtp-Source: AGHT+IHMivnj+voy/rTOu8EexVFs8o1EofVC8XlGImTRBzEMNl1ryH4qSLVI+fLh/3xqmSXC1EqTKQ==
X-Received: by 2002:a05:6a00:2345:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-728faac45c2mr2803799b3a.22.1733985013419;
        Wed, 11 Dec 2024 22:30:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-728e2927194sm3911383b3a.191.2024.12.11.22.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:30:13 -0800 (PST)
Date: Thu, 12 Dec 2024 15:30:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>, Yu Huabing <yhb@ruijie.com.cn>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	caiqingfu <baicaiaichibaicai@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <nnp45hifpemlw5ruzqaamhplperpsauggx6sw5syat7whk3gan@es5qy7kfbeay>
References: <20241212035826.GH2091455@google.com>
 <20241212053739.GC1265540@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212053739.GC1265540@mit.edu>

On (24/12/12 00:37), Theodore Ts'o wrote:
> On Thu, Dec 12, 2024 at 12:58:26PM +0900, Sergey Senozhatsky wrote:
> > Hi,
> > 
> > We've got two reports [1] [2] (could be the same person) which
> > suggest that ext4 may change page content while the page is under
> > write().  The particular problem here the case when ext4 is on
> > the zram device.  zram compresses every page written to it, so if
> > the page content can be modified concurrently with zram's compression
> > then we can't really use zram with ext4.
> > 
> > Can you take a look please?
> > 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=219548
> > [2] https://lore.kernel.org/linux-kernel/20241129115735.136033-1-baicaiaichibaicai@gmail.com
> 
> The link in [2] is a bit busted, since the message in question wasn't
> cc'ed to LKML, but rather to mm-commits.  But dropping "/linux-kernel"
> allows the link to work, and what's interesting is this message from
> that thread:

My bad.

> https://lore.kernel.org/all/20241202060632.139067-1-baicaiaichibaicai@gmail.com/

Let me Cc Yu Huabing on this:

> The blocks which are gtting modified while a write is in flight are
> ext4 metadata blocks, which are in the buffer cache.  Ext4 is
> modifying those blocks via bh->b_data, and ext4 isn't issuing the
> write; those are happenig via the buffer cache's writeback functions.
> 
> Hmmm.... was the user using an ext4 file system with the journal
> disabled, by any chance?  If ext4 is using the journal (which is the
> common case), metadata blocks only get modified via jbd2 journal
> functions, and a blocks only get modified when they are part of a jbd2
> transaction --- and while the transaction is active, the buffer cache
> writeback is disabled.  It's only after the transaction is committed
> that are dirty blocks associated with that transaction are allowed to
> be written back.  So I *think* the only way we could run into problems
> is ext4's jbd2 journalling is disabled.
> 
> More generally, any file system which uses the buffer cache, and
> doesn't use jbd2 to control when writeback happens, I think is going
> to be at risk with a block device which requires stable writes.  The
> only way to fix this, really, is to have the buffer cache code copy
> the data to a bounce buffer, and then issue the write from the bounce
> buffer.

