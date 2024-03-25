Return-Path: <linux-ext4+bounces-1748-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887A88AE60
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 19:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160C91FA2584
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873E884A2B;
	Mon, 25 Mar 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cYD3LThD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56473163
	for <linux-ext4@vger.kernel.org>; Mon, 25 Mar 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390385; cv=none; b=N1Tty/X+XhD2+6aQk7Ae5BtJFWBidATlBd5biTiQPTYsV6a3AZK3Wt4SLgwzJU9ku1eVMzA8UaGYOqnhQRFZ35XeU+2wxvBe7ufuFZapO2KVQIO+6yZOFDCuZEg9e+q544vFEVFdflri8GpSlgtM6powr8AUknk54PGLMw1nkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390385; c=relaxed/simple;
	bh=WjGma3kLFLe5YvQWuoHM/Ro3EyqnqLh5sSD/9vJovxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlJj/NKrICc7ZLp0xYl1unh3qoL7VRvHcnuRtiekqMxsgP1j0ZhyUZZ4hc99+hC99BrMc7Y8vYpqbHu5BQri4cHNvD6OyNDP0iJG3pDMBLdJiq1vamfWb8qArO9qG9F1Be+lRAyU39ApTfD7acC89Jisxv79PQ2h5MmYFotgUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cYD3LThD; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc5fdb0148so185100439f.3
        for <linux-ext4@vger.kernel.org>; Mon, 25 Mar 2024 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711390382; x=1711995182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSAZR9Vt2Q5o0+5V5RZYkh5l63Ssoo3HvBsqSbE2JvY=;
        b=cYD3LThDCY2HRZ4XaJl0qb5/m7/UuUArsxk7q6HSklIa4h77pe6mgREU3xTLq48iLm
         n0RkZJEO8WKHvNoRK6BwbAtA1p3w/2VSTQzzCDb6k8NN3yXadttYWDOjCjbPfASV4mN/
         xE4qsdH0N0oIpsyCbvpT4JR4fMH1I9xnDSs5RgBsFSKtLTwszfCTnKRsCFbHWnwkeKEm
         9n6xY9YxEoFhVNldSNBjQLU7yZ47xgec2937a68Av/BeRKMYU7QudJuXMSRDO1uqZFXM
         OQfhhvXfHomS7zLGX3XHPy/aOqI0N28+/nLIcvCIWF0UHuAz95awwW4efJUnUPvPhSeK
         EzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390382; x=1711995182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSAZR9Vt2Q5o0+5V5RZYkh5l63Ssoo3HvBsqSbE2JvY=;
        b=MhVyGlzhJmcr7vIYWZD2F4X0e5tI/HO3ezt/ZWvd3KEKwhwgXvIb+9Ctaaheb+Kib5
         BDWkcB5zYHUUR1JUMipD3F+dE+ardbbvxjZ5Xn2nQ7T+48srXG6oxBnaUfCs4Cl86bH+
         a/se9XCuCF9J2v8w6jFr6+TEzNOLQcsEj1qgdNHH+UovUYd/XKd20M1OHHQqxWfN/Ju0
         Cs7oJoBppz+Zupfd88pPvKhBEOKO3WzlAy5aV/FFJSuhXN6uxmW+2zbFpCNXswpuRA7a
         3p/0Kk3XnnFzoq2qzKL9+2t70wOLKAFckSYbVe0wYDkbEbWj4wcdBucm/hhjqDkaRozH
         +G/A==
X-Forwarded-Encrypted: i=1; AJvYcCUsVuaGGjHvo1BnHHQoUE2gd4p7wnMUp+trmmWzxkGOQq8m22sp0X06s5iIbD9NEtG/bR9W2GS4Sq10YMKJwynnH6pT7aeTU7xC0w==
X-Gm-Message-State: AOJu0YxOD3fCxXj6vUG3x3D2Np5CLRIqZ8ufzDQPVtdz/y8xQQ9h5iVM
	AX5T/a/a+sgdUR/Oif+U5gorLbEt074kp+rTFus+yGEV1J0PnWzf4MhzZvoXqxM=
X-Google-Smtp-Source: AGHT+IG9xwHF3fNymQJbxJun7y4cLuwksrTJ9sJhMxnIaoGig5IF3zdZeyGfbkfQJnnpy4r1l1tvQQ==
X-Received: by 2002:a6b:7b0c:0:b0:7cb:f395:47a8 with SMTP id l12-20020a6b7b0c000000b007cbf39547a8mr9179021iop.16.1711390382256;
        Mon, 25 Mar 2024 11:13:02 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:9478:4be::79:22])
        by smtp.gmail.com with ESMTPSA id r14-20020a056638100e00b0047d69cc97d1sm173364jab.40.2024.03.25.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:13:01 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:12:59 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	glandvador@yahoo.com, bugzilla@eyal.emu.id.au,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 0/1] Fix for recent bugzilla reports related to long
 halts during block allocation
Message-ID: <ZgG+q0dujYQR8/0q@CMGLRV3>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
 <170476879011.637731.13228432208887255974.b4-ty@mit.edu>
 <ZfsUaicHDpOtkkVv@CMGLRV3>
 <Zf1B1cPj/aO21pjZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf1B1cPj/aO21pjZ@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>

On Fri, Mar 22, 2024 at 02:01:17PM +0530, Ojaswin Mujoo wrote:
> On Wed, Mar 20, 2024 at 11:52:58AM -0500, Frederick Lawler wrote:
> > Hi Theodore and Ojaswin,
> > 
> > On Mon, Jan 08, 2024 at 09:53:18PM -0500, Theodore Ts'o wrote:
> > > 
> > > On Fri, 15 Dec 2023 16:49:49 +0530, Ojaswin Mujoo wrote:
> > > > This patch intends to fix the recent bugzilla [1] report where the
> > > > kworker flush thread seemed to be taking 100% CPU utilizationa and was
> > > > slowing down the whole system. The backtrace indicated that we were
> > > > stuck in mballoc allocation path. The issue was only seen kernel 6.5+
> > > > and when ext4 was mounted with -o stripe (or stripe option was
> > > > implicitly added due us mkfs flags used).
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > 
> > I backported this patch to at least 6.6 and tested on our fleet of
> > software RAID 0 NVME SSD nodes. This change worked very nicely
> > for us. We're interested in backporting this to at least 6.6.
> > 
> > I tried looking at xfstests, and didn't really see a good match
> > (user error?) to validate the fix via that. So I'm a little unclear what
> > the path forward here is.
> > 
> > Although we experienced this issue in 6.1, I didn't backport to 6.1 and
> > test to verify this also works there, however, setting stripe to 0 did in
> > the 6.1 case.
> > 
> > Best,
> > Fred
> 
> Hi Fred,
> 
> If I understand correctly, you are looking for a test case which you
> could use to confirm if the issue exists and if the backport is solving
> it, right?

Not quite. I made an assumption that having a test was a requirement
for backporting the patch. I know some other file systems prefer a few
loops of kdevops to backport patches, and was curious if that's a similar
flow for ext4. I only backported the patch to 6.6 and ensured that our
affected nodes perform as expected with it.

> 
> Actually, I was never able to replicate this at my end so I had to rely
> on people hitting the bug to confirm if it works. I did set out to write
> a testcase that could help us reliably replicate this issue but it needs
> a very specially crafted FS that is a bit difficult to achieve from user
> space. I was using debugfs to create an FS that could hit it but I kept 
> running into issues where it won't mount etc. Maybe there's a better 
> way to craft such an FS that I'm not aware of.
> 
> One more option is that maybe we can have KUnit test for this in the
> mballoc code but I'd need to read some more about the kunit
> infrastructure to see if it's possible/feasible.
> 

I think kunit is an interesting idea. One thing to keep in mind is that
mocking is going to be the real problem with that approach. And with
more mocking may mean more brittle tests.

> Regards,
> ojaswin
> > 
> > > 
> > > [1/1] ext4: fallback to complex scan if aligned scan doesn't work
> > >       commit: a26b6faf7f1c9c1ba6edb3fea9d1390201f2ed50
> > > 
> > > Best regards,
> > > -- 
> > > Theodore Ts'o <tytso@mit.edu>

