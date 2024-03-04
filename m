Return-Path: <linux-ext4+bounces-1500-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B78709ED
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 19:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1108D282034
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D478B4D;
	Mon,  4 Mar 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgAIaxqk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6E7869A;
	Mon,  4 Mar 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578513; cv=none; b=uOZqgIwmLTgqvPYVDPWzqpYUxABevEDS2yl7auSmC+JAdbxo0ji8tj7fdF0IEHbTd8kbkgVDuKo72nL9w/OafN0QHKu2WAAQU+361zeuevH5heN/JtbN+c5DDuBG2hwzAEv7ZBAhGcCI+s24zG4qzyi2I1bludaaj+GZh7W6ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578513; c=relaxed/simple;
	bh=FnMJwlF96DcVWB+BQrfRhd3D153RPZF0wsf8N0ZsOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TclRMtPGSnRyEccwldi4FeO6m2vbER+j87xkQrOkRr5E0D3ImMsCkD9Aq3ewqtGDc5Viz+ne+kATQ4o7y0Pz6QObgQDHzKH7dM9Q93TE2M8foWxLXkSxxPN3MzWfwri+rQ0E0HIJcBbyoleXMLcxawyjG/zaYC7lo8shoNxBG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgAIaxqk; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4261168a12.1;
        Mon, 04 Mar 2024 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578511; x=1710183311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6EsCuzkrFIZIDT8fk6rKphRBaaZIClz4Nc3Ii64mzk=;
        b=KgAIaxqkDsGlDo3Y+myadGOk4X4D13rh2P2BYzM7fb+6RkJ3PrD26574I3oxKxK/AZ
         9X8lwhOOwZLGSWjAesYQRNX/SGyI0Iz/gnBGUTrCLOVD92MfBnTf4M7gKyF9IbysOw/F
         qS0MoJvlCEW8KFbeJLEVJoBdhoJL9zla4TSB8L/2/2yzkPGOSF2+bSJRXKW/wDjPjppS
         QG+G11EdQ+TYtoKOd7Y8bOxM0j96MZXleiKYBxcf2H/0wciqYQ3MY1gKZ/X9CnLTytYm
         WglBrv+oN490htb8IX31PrMbmJLPuhOmGssbhwlZ7LSwhdsZTXWRr4j2Z9gb0CP8ungd
         1LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578511; x=1710183311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6EsCuzkrFIZIDT8fk6rKphRBaaZIClz4Nc3Ii64mzk=;
        b=YIa88kI9uIsMSZs08OFfF2mhJgTIMd9bRJ0ov/vb35nrWsJan2BXsQXi/HryepK4lW
         sc0LuTGW9nsO3G1EpzOmUimorHczpHQGgoISrRFKxMI8vwL5R8xS2jbvFZOV7s8seHbG
         W5ihhHlf8YrVnkIQRFxvbdXcnWqQPP4iFH1qQKzn691cxEFr0sLKhLefNHWErnk1JQuq
         4iFKEFJZs+gT+N4HpX0unTd2IHmATUsseLC/ZtSe3JAcRt1UJs7Xr+gMfowWRLkWt8VG
         PLzg4xMNyyeXRa0YvU5WztP1whDKQhDy2KnIneqVtaLxttN5aZk7W2RghYwIQaZogsp9
         Cvig==
X-Forwarded-Encrypted: i=1; AJvYcCULv/jpj3KHeRvKw35Mb3YOzG/6KQ9V37RHv24c+k7NtwRbXOK1ug5nyKznfneKUNzNJH5pXHdIK/+sWRFlKYp3M+SVp1Y+UDurQc+x+3dWxWaJPiTiZr91MRb3Uq8n+a6pwW2redlN9Q==
X-Gm-Message-State: AOJu0Yw3Lhgzi9M4GRnFzDdmgbJNlrfKLgRFvfJ1262s/RWpad+Hbj4u
	Yc8mkOlAf+dvFWEYjKqtS2sPRlz01svZ/BbG6MKInjPNhoDtSSfw
X-Google-Smtp-Source: AGHT+IGEV8X5x9DFe43MYukPtpQZXMccwF6MU3Mn6iCy5ifFI6glQlajApV8FrTi5WS/KJBkDsG4ng==
X-Received: by 2002:a17:90a:b881:b0:29a:8c78:9a7 with SMTP id o1-20020a17090ab88100b0029a8c7809a7mr6590744pjr.40.1709578511285;
        Mon, 04 Mar 2024 10:55:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sw14-20020a17090b2c8e00b0029abf47ec7fsm10487219pjb.0.2024.03.04.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:55:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 4 Mar 2024 10:55:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org, brauner@kernel.org
Subject: Re: [PATCH v4 0/3] Fix crashes and warnings in ext4 unit test
Message-ID: <8d0506f8-7df2-45f6-85a4-2a0075b00050@roeck-us.net>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304163543.6700-1-shikemeng@huaweicloud.com>

On Tue, Mar 05, 2024 at 12:35:40AM +0800, Kemeng Shi wrote:
> v3->v4:
> -fix that sbi->s_dirtyclusters_counter is used before
> initialization.
> 

I see no more ext4 related crashes, unit test failures, or tracebacks
with this version of the series applied on top of next-20240304.

I'll send Tested-by: tags as response to the individual patches.

Thanks,
Guenter

