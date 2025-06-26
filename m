Return-Path: <linux-ext4+bounces-8664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9958AEA76D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 21:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB72188A569
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D62F0C5A;
	Thu, 26 Jun 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggYo3AnS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58382F004F
	for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967637; cv=none; b=OQ+M5jprX7kbKCVo1+7thECekGpkBafbnTMwVSRYnFzUWFbFAonDaRvkMpQmdXf7Srx110e4dV1QEI4SyYbe6Ez8PCYeE5zrzSwKczph1HVwWdOLOMAEOkf0zZyAMwI45Q+jWka/PZgLRrbhBSqkst7NPXa1sU4OyOsurYWMdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967637; c=relaxed/simple;
	bh=f9CwWMff4QXbVHW9cZdRc4cB27oFc6Aq8eFF5yj9+F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmr6V+s3O0KntXAqmYYH/y86tyf+3dQDKFSOYW2i/2l6i+YiCB73z7O/XmO1nf7rLRsSaFH1+qMNx22wKLMFH92lqCUhNZkBvN//PdZwJ7m2mEvqK3dQI6n8mBw0K6uPQ7iBX6obL+H0KuLJZYLKlQLrxNmde4vexD0KFZJEl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggYo3AnS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750967634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/nLmVsdZrAYBKvHYS4BNJcLEavliBujZLyQxb0TY/8=;
	b=ggYo3AnSzD93tJesQtFcl7/jtbFdBSCXcE+53ERiAO5A9EN/V8Dtczx3sFECHCPrH7yBtP
	2zMjOhEoVE2G8hrKRhg/xIFfCvq4PxuUJ68GdEEiHQTFH6xH/JwurudubXltLH5IWTLAjN
	sJgRG9Gi1xnGw9cDmZO67+mI6+Vfvgk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-dfKOIxKyPFyZfJos3o8vmw-1; Thu, 26 Jun 2025 15:53:53 -0400
X-MC-Unique: dfKOIxKyPFyZfJos3o8vmw-1
X-Mimecast-MFC-AGG-ID: dfKOIxKyPFyZfJos3o8vmw_1750967632
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-747dd44048cso1528582b3a.3
        for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 12:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967632; x=1751572432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/nLmVsdZrAYBKvHYS4BNJcLEavliBujZLyQxb0TY/8=;
        b=miTVKnplOqfNafC//nq4iffog2R8TX7vbpOiiUZg0+OaeW2z0Unm7nXOQGueSpFY0c
         Qy+LHfDMgfMohifKbek66QAx5JtHwfLg7LPiLoBP1Hox5O+djD6A6EIOFnNggz+nLRnh
         bwuY4jl/AzsLsJEAKSzK2N1scDVOremc4om06ClprfiqTrnjlhThVfoukhcBH+PkTJyX
         z4dUk+nY/oci/qUH/IBAPgbEu1K7vwJ81ri4r8ptsCw88ZqgjaM0gqo01u5ifuHRkQ9X
         WL3LZ3aBEBderps3YU80YfzxMD3+MceUHyJoAXepebgoXjQpDx8CMHw4xaFPvWxe0Egb
         1qTw==
X-Forwarded-Encrypted: i=1; AJvYcCW2XpKqNWNF5LFYw8ldVJvJqng0ZqdI7iKQGYUmCoB3VwF8WHfKtOdq2uuTgveWGTGD7GCUT2j+xukQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9rmvsMnM93JVyyt83TCwRVLvs4EKkMttmEhS708ipL3Rx51/
	S243eha0aK6o55qSjLFcPTIxXG4Z01cHFGXvlOwEOhKmFVT6Epqk+TjEOssXTi910rGwhLYgaDu
	6MBFZAUFITvAiwiDKKvyDAiVeWq/2ds9XmBAhTrF08g4lKWPy53/KEmSat3+X8oP7tV2L6zMipw
	==
X-Gm-Gg: ASbGncvNnDsXcs+n8XE3ZyPQ5shu8O7L11pRL4N79R5RlaSg8qQ/Gx26Y6rmu5Gn0+1
	nxaz5gZQdfb1Ajh5PBfmTsl8YPCToy4yI0E52/mx5DZ+5KDfx7QODx0k/npfmBNnoTT5mM1Yo5l
	Ea94t6hDeJi8dEJcVAG6K5XFNjYYt0aUnnu3vBgiivdODmYYSHSx6ID9549dQlWW98IQEBG3lJ2
	u7/GL/KwLuY1NMT0tqeMToc1HAzOIJFnxeDneeg1W3g6IUwzDMp2agvWgvkIFY4DAhkGZT9QJIa
	V5rT6Ji9eebVvWwuG06S41fPQ7mS5aMbVLFK4lgFcX6p/JpwxwsPn4LsueAOX2k=
X-Received: by 2002:a05:6a00:92a6:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-74af6e27ba7mr551926b3a.1.1750967632011;
        Thu, 26 Jun 2025 12:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIINjE/vY1h85MPe/c8z3TutZvYn7V+KXms08M+Thz7F1vzrvh5g64od1QB//BjvXYC4pBmA==
X-Received: by 2002:a05:6a00:92a6:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-74af6e27ba7mr551915b3a.1.1750967631656;
        Thu, 26 Jun 2025 12:53:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57e7279sm411582b3a.150.2025.06.26.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:53:51 -0700 (PDT)
Date: Fri, 27 Jun 2025 03:53:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250626195347.qo2sjqrtdj3cdigy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250625212022.35111-1-leah.rumancik@gmail.com>
 <20250626035125.GA198321@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626035125.GA198321@mit.edu>

On Wed, Jun 25, 2025 at 11:51:25PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 25, 2025 at 02:20:22PM -0700, Leah Rumancik wrote:
> > There is a descrepancy between the fsck flags for ext4 during
> > filesystem repair and filesystem checking which causes occasional test
> > failures. In particular, _check_generic_filesystems uses -f for force
> > checking, but _repair_scratch_fs does not. In some tests, such as
> > generic/441, we sometimes exit fsck repair early with the filesystem
> > being deemed "clean" but then _check_generic_filesystems finds issues
> > during the forced full check. Bringing these flags in sync fixes the
> > flakes.
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> Looks good to me, although I might suggest ammending or just dropping
> the comment:
> 
> >  	# Let's hope fsck -y suffices...
> 
> ... since obviously, for ext[234] it wasn't sufficient.   :-)

Thanks Ted, I'll remove it when I merge this patch :)

Thanks,
Zorro

> 
>     	  	     	 	     	    - Ted
> 


