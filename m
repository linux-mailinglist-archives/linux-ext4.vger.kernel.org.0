Return-Path: <linux-ext4+bounces-9585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62DAB31C80
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200711D0844E
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBC031281B;
	Fri, 22 Aug 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lZQvjLYh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8D308F2D
	for <linux-ext4@vger.kernel.org>; Fri, 22 Aug 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873641; cv=none; b=MKzZ/wRO4baQWV/Lw9v8fYOJgh+JSUawLDGcgz/PPV8/WW6A9qCoQ7bWV9SP2RmK+Ay9v9IQ/PHQtHrxFDdA9z5DJk/l4C9e8M8q+o8ZUN19yXgamA1m4tm7w7pXIzYjejmGp+GVi6ABuhCTUKmmJ6rcAu6ALarmlXnY5QdDHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873641; c=relaxed/simple;
	bh=fEOMn/md0OE1QvUICBnX8O+3a7PgQ6vANjZfZQ8gxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiiiCf9ZTE7ZBnPqdJEV0NzSXXPT1NQ4ClriuhjlmmM9P5gsJxJFVorGXKR43iAMYGANM/PvE6mlH7Ui29zI11VAQkA5bL2LMX6D6jUQxdEBfcZwiUE1SZ2Zuq3N/yzWyXFlwgI49f/15uQgWsOYRGZIxAp+5Yq0FspCSPasAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lZQvjLYh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d5fe46572so22358117b3.1
        for <linux-ext4@vger.kernel.org>; Fri, 22 Aug 2025 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755873638; x=1756478438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3OogfFXdkMqRNtpkZ1fUtnIz6uf3uzEeX+PeKEs10Q=;
        b=lZQvjLYheqIp9V2Ez+RTb2JAres8DKTut5o8p2IJo57s0eCDZm9/podHwP91jEwTQv
         p9qJJ3sDzFkUDpL1Z1ai1PRQeVKLy32Z1zJxWbfeTKAvzfENO3UUc72tdg+C5A2L9G+4
         w6YFH9XDGVNJguysAG/VCQ7iWmZ0GkmFHI2uoX+SzK50/hxA0DZpBCcg4xnTJsUZCokR
         9PQ6+V8d60M46pMHmBPcH8xzmcnpLNGPkuAPlgiCpgEX/EJzBSv94g4AdX4DRymLbFhc
         cx08V5P4Nc2DsD774SFP96FPUus8q24pA77zbLJlAppusUSHqxzzQ2vh3WX3qSoYuCkO
         1iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873638; x=1756478438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3OogfFXdkMqRNtpkZ1fUtnIz6uf3uzEeX+PeKEs10Q=;
        b=jmS6EgZP79vAO+ZwyTZLa+xbJUIjZrEjbwsy5gDROSN5ByKZ3sKPcSDx+m5+41qDcZ
         q2V7yIVIVhESXJ9pb0tFcb9g1nDti4F1vVxb/Axt85T9foSVDgB+f+khoKz13NzKPZ/5
         L/oSuNm2EWnFSa6QE4ltN9SsDJ+/hCG1q3FFIFIwVfy/5S6kD5KrTDnQyuu9WIKMAFU3
         v9B85NObidWBmUJVWzSRtYlHbWGfXxpRTV0GyjqofjnFQjIZ3C6zcNEk/S7KrwQ1E069
         mH3s5v1WbxJSZiPFKLd029WCO/kQWjQCDJNCyRIcoHX//bpnnuH2hCPjRiuwX8KHa6Ba
         MGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEaYbVryON1tiIpljS/vISE2qqIg2UceyYdmX7wIba3yKRoL2szEghYhnzfIC3WACL441Qw6yEf2df@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNGCqKYLdNHe/oJ49G2NSfSw8P+F7c5UnuVTifQkeQ3cE4m8G
	I8dqpQMhX9AtE/JPbzzR5X2YByUoILp4Xx7LsNHe/GTG7KOLLvNR03pp097sHAboAwI=
X-Gm-Gg: ASbGnctpJY01RbjPmmQss18SOAmKf/jkwXj45rsYrN+v/zN3WJlmp8jL0IuFwNcdO5V
	6QWgGUZx251va5amzgK9KIAWSAgBVEjAQjguDuail1LxsY8NoeZDUqYgr1p0u6bHN1IrUWVgpY7
	CwpSVJrO600d67GkHUvodPR6/ibs7854e6N2OYVsJ3YRdMKJ1KwjD5r4cLseoHZncbnXWsfhjbL
	oWcN/zF4TIHUuBX2F5Y2ml1aw6ub3hcXVt+3WXBakyFIvI1IBuPefxBXhbr/Rl8duCcjUz+0jes
	miSJiiVoel7is9vw7P0zAFThunOYCUYGdr5ZEkvLFBYCTB/t6tmcP77WSxdUgjDBgl0dhCNqMsM
	RkuEAJ6a507NAzCum2xfsMBK+SFeMWqk7S6vpiPMAED2Uuj73ToJsFagpBts=
X-Google-Smtp-Source: AGHT+IHOy5Mb0Jt/cJA6ywQp6sLORvyAzia/tx+cqSm3UKE5FfWzv+W3sub+zG2wAFxqmQLGUh57tw==
X-Received: by 2002:a05:690c:6bc6:b0:71c:1754:26d0 with SMTP id 00721157ae682-71fc9c664f6mr55261597b3.6.1755873638329;
        Fri, 22 Aug 2025 07:40:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fd92b885fsm6937457b3.10.2025.08.22.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:40:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:40:36 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Sun YangKai <sunk67188@gmail.com>
Cc: brauner@kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Message-ID: <20250822144036.GC927384@perftesting>
References: <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
 <3307530.5fSG56mABF@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3307530.5fSG56mABF@saltykitkat>

On Fri, Aug 22, 2025 at 07:18:26PM +0800, Sun YangKai wrote:
> Hi Josef,
> 
> Sorry for the bothering, and I hope this isn't too far off-topic for the 
> current patch series discussion.
> 
> I recently learned about the x-macro trick and was wondering if it might be 
> suitable for use in this context since we are rewriting this. I'd appreciate 
> any thoughts or feedback on whether this approach could be applied here.
> 
> Thanks in advance for your insights!

That's super useful, thanks for that! Christian wants me to do it a different
way so I'm going to do that. But I'll definitely keep this in mind for code he
can't see ;).  Thanks,

Josef

