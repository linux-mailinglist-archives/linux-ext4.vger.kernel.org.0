Return-Path: <linux-ext4+bounces-10727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4FFBCA5CF
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660A13C450B
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A5242D79;
	Thu,  9 Oct 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="uv3GpQf7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AADD240611
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030519; cv=none; b=kZRDLtZ0K+i83svlH4nnma7HyfsXuihTuWaesBhktT1JyTei817BDr9PHO9vr+Cfqxcz+AtW9bODOZdh7bVudEe5Ut32FTSEMAY0A/ywzYPXITAD8H2F5LMYKGLfmS2yJ+iaoWSLYLEDv+/JK9wUNL/hErbTqw11KziQDdQTt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030519; c=relaxed/simple;
	bh=VQJJ0kkdsoKilAETyLjjnmPlpywwYhmhfiCz5TnYPTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9kmYHgPFbC1H3m3z+IVvFHvwHKZQ4MHJT4XnnZZKiD7FCS/80YdNFXCHlyK7tywXOF0AYFcmAv1y/QyFXAta0N+GdXyli5FBnBp2uQTDwUaXl4XwI40Ak9bHbmp3Js+7zoERcZiGOqPOFMP7HKHSR0j5ugENV+BKtk65DEHgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=uv3GpQf7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bca51so798056f8f.1
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760030516; x=1760635316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+KLFKFTWpPvFnQc5/YBzjsvsC5/CidNVj2ClsuS6MQ=;
        b=uv3GpQf7E/vDeTz9FLxH1pauaLYsJemYzB6731uJSXpbjVHeTvKvX4tygAOWkI7wJG
         BdgeaDZDjeK4Zewz6oHUZerIvkZ0++bfYSpekkS1EVORWyMUwvBhYIvBaeDkLqq5/EaK
         qZPyNKt3gpPYn3wnco2eUZ2SN5KFZ6/T2bJKQWXNVdTejTjxTSPxTjGROgPZTlcbpkEm
         0Ydsp4ScEgLTgFUkIwGuylAPD1BP2XiJRM2UEGt25jfqwM8/MaQ2YO3fpQOLqt0xdc6o
         Pgtq0a3VKLmPmj71IlYHkfMd+4CxNsw6iQi63q9JlRODbNiUvz4LeQY216GLI9NIudYD
         eccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030516; x=1760635316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+KLFKFTWpPvFnQc5/YBzjsvsC5/CidNVj2ClsuS6MQ=;
        b=cTA4e3vUm6Jyvsv0dh6vk+Uy4Lh9VO8HSAuWxH5n8J8FCiANToRKL2tXbS+5imVV0s
         zIduug7kGnKk+TtoMCvyLqPtDFNclbIxX7ngtd5aEjJ4wbsFmIKccC7W0jeUsDXd4GcN
         b6t82ZYilMf2AV1TsLGuGRw8Mvqlvl+o7O25UNCDeN/kFOh+iGCaVvA9ducwCmQzw2jR
         jKirZGYmK2ZDnAYKpbJuXDKBcDGITsCWlHGsoNLFhwQ8RlLnsIhfMfQ9vIZYRIuDWPi+
         m7+l0Gq4HvEmq1CUtviQeNXIdur+otjA43YnCJ+KDEUQyGddLJo8gpcaigcZk5s3F5F5
         yjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHLAzfNxoe9Bl4LYpZuddJb4LxjIDDYLBQ0dPSrbKPfF7jGcHQN+jSbUtbMDHVumHpaiVaEnXNK3/4@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOLnsZBGA5R1j6qap1tJYMqJi+2VLsaA/pJWn60OuZ4VHaNC3
	vHJDMNGZkY6ZCBOVMavaud87aT9MSmrbrIOTlPBTfeVhF6/1riyFOc+jhF70C4qzh+s=
X-Gm-Gg: ASbGncv6CgLm2wUQmtop9EVTxgYF25m2Kb99oPfqJoqXuhD8kCXgOQqHbL07azAAWNr
	pKMi2c/2a9PRkCommQ0B9FxbPILx7IeblHr9QeQDBZ5wfmGYLrupItSojO60S2z+ytDwmZAuRuD
	w5W53yBeRMoLLXvWyESPaOOuRH0yKAXfYCOjfac/IiyNg0PDHIVf4qT5HLOLPxy5ZCLjccEiXWS
	zL3vV6zrqU9v0n/aJpcaMkN3Q+gQBl29B6Lmqy+pQV8BlHpIvG5RUPjABbAtPuTZgvjdBu+3ZYb
	rHPgkAKVpygRYJI4Tv2f/rUT/rEAU7iy/XczGEvjbvKK/J/Imx5tsaSejXX7e9TbsAzlTJX2dZ0
	akvL4r4ZqCFCoPw3xunh15AKPc4EzA+BdFEtwhkVHFg==
X-Google-Smtp-Source: AGHT+IFvtBt4VPloj/uWDHxR+fLdN49T1BIdUNfkKzHmKlSqCdUXz5aRdqggP7xZyjd/f8BtBox2sQ==
X-Received: by 2002:a05:6000:1863:b0:3e6:116a:8fdf with SMTP id ffacd0b85a97d-42666ab969fmr5606797f8f.13.1760030515562;
        Thu, 09 Oct 2025 10:21:55 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce50d70esm87352f8f.0.2025.10.09.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:21:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:21:53 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>

On Thu, Oct 09, 2025 at 02:29:07PM +0200, Jan Kara wrote:
> 
> OK, so even if we reduce the somewhat pointless CPU load in the allocator
> you aren't going to see substantial increase in your writeback throughput.
> Reducing the CPU load is obviously a worthy goal but I'm not sure if that's
> your motivation or something else that I'm missing :).
 
I'm not following. If you reduce the time it takes to allocate blocks
during writeback, why will that not improve writeback throughput?

Thanks,
Matt

