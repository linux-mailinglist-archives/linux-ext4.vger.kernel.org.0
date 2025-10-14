Return-Path: <linux-ext4+bounces-10873-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC307BDB815
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Oct 2025 23:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89097354F7A
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Oct 2025 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6C30CD9F;
	Tue, 14 Oct 2025 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="T9FjswIc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A62E88B6
	for <linux-ext4@vger.kernel.org>; Tue, 14 Oct 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479048; cv=none; b=Deu1BxTHIE9GpR3Tdoo7hVbZd0UE7w/aWUFxMZRHpvAXWuICC7oVUVsfAkrO7skdYiV5NFOYW0jSj2xYnvNW5V55eqw/u9bVWwNG79Tu97qp1v0gvkVIKzz+3bUGZqe5VaSqBkLplc0VhBd4rKzIsgBQQUqsZkiFSHnHW9bsFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479048; c=relaxed/simple;
	bh=lbp/svBrqIT8k+MRq3/jmjxuU8akOPgMPTESYka1epE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkHil6ySS/arTpewtAsSvU+OfSqI0ScG0Nu5eqmYNvNKu2ys4gWCO61urw+1jsdTJQPSa4mk8t/u7p9GxGYd7YCirhFNhUDNFhq+o7G09qTIww5aTzjArho0vXowxQNOvEjMQpxpiI1Ge4RxLO2s3PkAR2HCcvOPLbbLVS6Bb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=T9FjswIc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-794e300e20dso245089b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 14 Oct 2025 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760479046; x=1761083846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AL/bnV/py/dxrrqchUFB69kdjG2EwxKxcNMsAmNeKP0=;
        b=T9FjswIcdHH/j2782D1jjnXNP42OV1TStmHEnhaKyPrqOsbVq9lQfvfZv3GCqPnHD8
         FexeoNXr3/gm3oCR/0fP2A3kMQ4O8hZjZlZs5bHR6KK7D52M04Q8LLKmoNukfj521A3p
         sx4DxPtKTjzkrOpxhir6wMCuPKzdV7iifb99ogfvN80U8/qJNKEJttNWXwOGOxyovtPt
         1KybvFhAZBPZ7QT3cLgvrcVjxoWkmfgcEIbeRc0d7Kf044/O1eXmAKkl6zfRrqnsnBAZ
         ZrXMMCoeBhowPB7sMJ/esusntK1LQWjp/Pc4IlmJ2IJBA4N+e8cCd1lN8kPIsP3nlgzP
         zp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479046; x=1761083846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL/bnV/py/dxrrqchUFB69kdjG2EwxKxcNMsAmNeKP0=;
        b=I91YEf1mWhwPmQWljsUgIXdQd3CEanPdc6xFaCS6bNU7lBClgDxKao3F/hptY3rtIL
         CBlCsun+9/II+2ycz+CRKbhHZUbBgnqPlkW7NiQqf0O2vCl/DbAr2090Gq3GVZmx6TB1
         gao/lXIhOwbo2yRSkUu2JSu6r7ZM9+XHiHEPp9XipvXk23b6qhwR2U566FcXGXTYMKv+
         EkJ+hHNs4OFHSZ/+M+vzrZpeS/enZqvN2GUnCQ/jAwF6GI/2yqrdZSAgxB5FQRi/uwvt
         69pBIuRxXk8GktLlyhD/fOS+79Atr0ZeW4M1E0TSw4NwXY5NV6t9WWKftsipddCs2jQW
         yZww==
X-Forwarded-Encrypted: i=1; AJvYcCWE29anDdX4NPAcDqwk7PvNU10chTiSrkVS+15WEhKZ+QcNw631ZQbPf1kPSLiL2jzv2DyM8CPvD4Go@vger.kernel.org
X-Gm-Message-State: AOJu0YzViUbiUBtldguYo1Ahl6sSkrNyBkEjvPNBr2ddu5n0B/L7Oq29
	OhZ3QseKrQ9wLgGgIYAXwRXriUi9Vq+T1I7mdrTbjJh8+5w/Jb9IAZdl6yq8JFqgvBk=
X-Gm-Gg: ASbGnct1gts5SkT10s3IeQ2i0hcjxKNQRkMDRHDbjaC7mFI0uWIbvrzWjLIUUDwihqd
	IGwbbXmNkd85bRNTlvK+W+WhczFOAVoxhYW5xSai8NVEud8nbswrCwMZGPn5y1spoMx2SzPYVC/
	l4qYZoJIVgaSPGt8c+ta5IJwJUGLlEWBOF5MWAE3WnD/JpOpxvEIFreHR41SScyZmKCXxsf+YLZ
	FO1FnfL4xd3Dtd/h3Nbgo4+fy46C+Fo8J/wBz39+HIpLwVFJ5mE+EbDqT/N2rv7FlAtlOOFpP0h
	itNkJIHCMpvhv8ZWfqX/ZeN3q1oVdI8AUyX7oEUNTFu0fZGRCmshlLBAaTQY0uCE8r3J3mjx52i
	O6Gq6BBty4wUoY5XYujWDR9BwI6Hhn20f/9eRdF2caeJMPTcpNAokfLa44Q/n44dqC/5serZZ43
	vjU5e9N4/5wzcTKewO+ZoESIT7xkqF5umgr6bDVg==
X-Google-Smtp-Source: AGHT+IFEm7YEffZsxkb8K+nehDd+qD29oTSduQqQSjJ7xgEV6CAlDHsQGWe8Y3vIo1bRLa8jllHUlA==
X-Received: by 2002:a05:6a21:3383:b0:2ac:7445:4947 with SMTP id adf61e73a8af0-32da8f7b6b6mr32112486637.19.1760479045581;
        Tue, 14 Oct 2025 14:57:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678dcbf919sm12945398a12.9.2025.10.14.14.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 14:57:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8n1G-0000000EtZi-0ICM;
	Wed, 15 Oct 2025 08:57:22 +1100
Date: Wed, 15 Oct 2025 08:57:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <aO7HQkF8UOfjXGcd@dread.disaster.area>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>

On Fri, Oct 10, 2025 at 04:44:19PM +0200, Jan Kara wrote:
> On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > +static inline void inode_state_set_raw(struct inode *inode,
> > +				       enum inode_state_flags_enum flags)
> > +{
> > +	WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > +}
> 
> I think this shouldn't really exist as it is dangerous to use and if we
> deal with XFS, nobody will actually need this function.

XFS does it's own inode caching outside the VFS, so for the moment
it needs to have access to the same VFS inode initialisation APIs as
the core VFS inode cache instantiation functions to maintain the
same externally visible behaviours.

Yes, if we change how the VFS inode caches initialise inodes, we
have to update the XFS code, but that's always been the case. This
isn't very hard to do....

Keep in mind that XFS has been caching inodes outside the VFS and
doing external state initialisation since it was first ported to
Linux (i.e. ~25 years ago). It's kinda strange to suddenly hear
people claim that this sort of VFS inode state manipulation thing is
"too dangerous" to allow anyone to use given how long we've actually
been doing this....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

