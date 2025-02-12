Return-Path: <linux-ext4+bounces-6424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F2A331B6
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 22:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F3718889BA
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 21:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A464202F95;
	Wed, 12 Feb 2025 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pGLy+gkJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1C1FF7DC
	for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2025 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396830; cv=none; b=I2V5eNFOCMhCj64IyYzZ+35FlbMj9K5dNzYYbbzgDy2SPPoNLJDbVCwCx0AnWNl+zKAa/9LVhJVlyyALFG6ZLthZKdATAe3VsKzFNgkA2rgysljWrMmMCDSIpuS9UxSRn4wY3bXq9T/9mEWpSyCwws4xBZCvVor85oVa/5et31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396830; c=relaxed/simple;
	bh=Lnq4FTvbanMJRWO9UU2Sh2ynk+Qtj7WbE2EyQGFzh1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z76kXus3W8I8RfyFp5Ryir5LoG64Q6H0LvEoEnPU5WB3dPmfzN2pwYxogQkHN8YS6kJOFcW+xjZssA1boy1+4qMyjivAImIJNfkOhSNdlG+1xmlZjbncD3VFJiF5aTF6lsNorVYTZhjiq3LUabI790ovmAPTDUnZtTgwiBCPwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pGLy+gkJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f78b1fb7dso2272605ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2025 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739396828; x=1740001628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWgH6BRH4uvfdvHvSNKEFUnHAT9O3jpVoaM4yCHjsD8=;
        b=pGLy+gkJFeRS2FAYEdguWi+vIRuxJiZ3CMyiVGUGQWRToFyeiHI8IyIZ/Tkr98NWm5
         Sy5POiZhB4kS96WXqeX3hWrCv/pUBTSDeV8XW7pgp66W/jQ/ZjptoWiYJ7+GW+vLuHVv
         /Auke5v+98+6I/f8Waya5yhyd6Qwg+BpFfbYuCDwqSk2hYuDbC1XHMgVE3m7vmGQlUR3
         +y1sNCQmZiO99toHXHg+w9TiSmHPSRucPPsnOng0RhHtcSlU2nOKZGPaM10PLdTomzEr
         2AXqCxc0WbKaag+prVlnoZxVlgnGKuhrW5+OvEOq6/ogyE0qnXqpTbZIkt8XxFZHgtzZ
         lovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739396828; x=1740001628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWgH6BRH4uvfdvHvSNKEFUnHAT9O3jpVoaM4yCHjsD8=;
        b=gXxXlX0ltYasN3cgj3PFVOQDlFajT6gLbFJWHYz3RejJI3c84ioT8hQEgP2VAZn72T
         B9H5cqIoXONNuk9qQw/BIe7Sqr3U1BVIw4MvleMQ+PD9U4a9YALT/PSW2i1Tk6S0/B8P
         Iqls8afeheaHs116uDI2QqTu17+EswrJy/Z1VOKuHEQL9r9b25nolgQeFw5SDJKvipvv
         ETmakAWIhcWotm/hPQTST9bZvJ9yS4e08So0J+VwReCeJDVjJY9k7NE9gybNxaJswsHL
         hcenrozm9YvZt8E4al78jBD3mz9nRVR6I+PMB17SNgM0rosM1UYk3Mk+cX7kS/ItGgTf
         MZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVUYIXChHFCYWMD7rdcg+ZxiV25gJmjqo8LPOUphKnAszDyHVwR8ZL1AiZaXGsJeOKqMMeB5gHrglPy@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuWK47dCBsKSQlZs3VKJXk6z8lqipWzs73lblWMTddPLHOhbx
	5NbSK8IZlaJ4s8Igy2H+fzc2jN3NfeEbYvYWIanYey7qV7XCqylsWI5TS6rVssg=
X-Gm-Gg: ASbGnct7E+KsOz/tE5bK9HBMvdTbcO7DW5gRK+WpDR4QyVKHbfIo1ZEYANvpOfS0z3g
	Jxy4ABx0rUDsuDrl3/kVbsf+F58f5Rwkenwj+uc80VleGSFhdjARCzIGnks71Q3rkOE33NYLgQh
	UJjXUyQBJd3cP3bMs1JSi0H2FImQkNGVZaEYf85EK43bss9dL1jJ+SxXq1KoctJbD/XgX+cW9TL
	MVuLoLBokvidjtWlUUV1ZxE9KnO2H1m80s7cnlG0VgAeiMuKesamaWJomhbA8v0U2gTxUiPqCHc
	f+WOHVXa/q9XELVdO47ZHKjq2lAbo8LD/CdFVomYeGVTTtJU+RIyBSZI
X-Google-Smtp-Source: AGHT+IFvEo1sLDGK43eislHv14UxDSjw3KRGdmZi4jemDh6x9pT6qVEWn8GmLa/4wvn4h+SozAZ8GA==
X-Received: by 2002:a17:902:e5cc:b0:21f:3e2d:7d58 with SMTP id d9443c01a7336-220bbad65b4mr69397715ad.13.1739396828519;
        Wed, 12 Feb 2025 13:47:08 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm177145ad.113.2025.02.12.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:47:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tiKZV-00000000Rxy-2gAy;
	Thu, 13 Feb 2025 08:47:05 +1100
Date: Thu, 13 Feb 2025 08:47:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2
 on a v5 xfs
Message-ID: <Z60W2U8raqzRKYdy@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>

On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
> This testcase reproduces the following bug:
> Bug:
> mount -o remount,noattr2 <device> <mount_point> succeeds
> unexpectedly on a v5 xfs when CONFIG_XFS_SUPPORT_V4 is set.

AFAICT, this is expected behaviour. Remount intentionally ignores
options that cannot be changed.

> Ideally the above mount command should always fail with a v5 xfs
> filesystem irrespective of whether CONFIG_XFS_SUPPORT_V4 is set
> or not.

No, we cannot fail remount when invalid options are passed to the
kernel by the mount command for historical reasons. i.e. the mount
command has historically passed invalid options to the kernel on
remount, but expects the kernel to apply just the new options that
they understand and ignore the rest without error.

i.e. to keep compatibility with older userspace, we cannot fail a
remount because userspace passed an option the kernel does not
understand or cannot change.

Hence, in this case, XFS emits a deprecation warning for the noattr2
mount option on remount (because it is understood), then ignores
because it it isn't a valid option that remount can change.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

