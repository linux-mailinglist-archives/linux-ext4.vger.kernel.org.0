Return-Path: <linux-ext4+bounces-3376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB7939F83
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 13:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BB81C2204A
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099714F9EC;
	Tue, 23 Jul 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SqSU6k2S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438914F9CB;
	Tue, 23 Jul 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733299; cv=none; b=M8E0Gn7PNQ3xaXxeWmhafxp04oWjOtLfQMaL60hKnVFuI6Jsmpb+Y4+eFDwv1humIb2ObW5wrz0UaAkDmEdbm0sb8tTiwd1FqjwoWwJCYfz0hSSQS5P/kUgs6iaEYmAozaWNl2MvGKxtD8eyt+wVG/pAHfDXvvs01qN0qm9MBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733299; c=relaxed/simple;
	bh=WmIIb63NsWfWxILqxLi9S9QW8rRdWBhtaZWpRjACBnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keHDV9RxZZmFkpNW8+hfNfNy8LGyWToIaNuYLcKGUDI1vdD6UGdXfV8wrYmAHuoCG8r1Z3y8mf7dHce2G9imujTfUR7RR5lWQoIISiO4Oj2BnyKQT4l/qZvkgZknK1bYY6yMI3wyDzlO/NLekUprcAx0Y902IUHzMRZXGPzSjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SqSU6k2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B9CC4AF0A;
	Tue, 23 Jul 2024 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721733298;
	bh=WmIIb63NsWfWxILqxLi9S9QW8rRdWBhtaZWpRjACBnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqSU6k2SS8x6viaHXayT+6nzk8F+1CUTb/GhHMOpFlB5PvzX1m8oXGjWN3Pd5ebkd
	 OaUVwaX/Hb2PprfSJvgyiyXDdUtmD8q2QOGWJtxweHWQXZW3bl4/DDT1JNMkGLoYL1
	 UkksdNlGJsIajFjjyl7dpL5hIPht2fiHWVs6h/og=
Date: Tue, 23 Jul 2024 13:14:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Artem S. Tashkinov" <aros@gmx.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-ext4@vger.kernel.org, xcreativ@gmail.com, madeisbaer@arcor.de,
	justinstitt@google.com, keescook@chromium.org,
	linux-hardening@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Kees Cook <kees@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Linux 6.10 regression resulting in a crash when using an ext4
 filesystem
Message-ID: <2024072320-angled-irritate-2dd5@gregkh>
References: <500f38b2-ad30-4161-8065-a10e53bf1b02@gmx.com>
 <20240722041924.GB103010@frogsfrogsfrogs>
 <BEEA84E0-1CF5-4F06-BC5C-A0F97240D76D@kernel.org>
 <20240723041136.GC3222663@mit.edu>
 <108448f5-912f-4dac-bbba-19b1b58087b1@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108448f5-912f-4dac-bbba-19b1b58087b1@leemhuis.info>

On Tue, Jul 23, 2024 at 12:04:41PM +0200, Thorsten Leemhuis wrote:
> On 23.07.24 06:11, Theodore Ts'o wrote:
> > On Mon, Jul 22, 2024 at 12:06:59AM -0700, Kees Cook wrote:
> >>> Is strscpy_pad appropriate if the @src parameter itself is a fixed
> >>> length char[16] which isn't null terminated when the label itself is 16
> >>> chars long?
> >>
> >> Nope; it needed memtostr_pad(). I sent the fix back at the end of May, but it only just recently landed:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be27cd64461c45a6088a91a04eba5cd44e1767ef
> > 
> > Yeah, sorry, I was on vacation for 3.5 weeks starting just before
> > Memorial day, and it took me a while to get caught up.  Unfortunately,
> > I missed the bug in the strncpy extirpation patch, and it was't
> > something that our regression tests caught.  (Sometimes, the
> > old/deprecated ways are just more reliable; all of ext4's strncpy()
> > calls were working and had been correct for decades.  :-P )
> > 
> > Anyway, Kees's bugfix is in Linus's tree, and it should be shortly be
> > making its way to -stable.
> 
> Adding Greg and the stable list to the list of recipients: given that we
> already have two reports about trouble due to this[1] he might want to
> fast-track the fix (be27cd64461c45 ("ext4: use memtostr_pad() for
> s_volume_name")) to 6.10.y, as it's not queued yet -- at least afaics
> from looking at
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/

Now queued up.  And as it was not explicitly marked for stable
inclusion, thank you for asking for it to be added.

I'll go push out a 6.10.1-rc1 in a short bit with this important fix.

thanks,

greg k-h

