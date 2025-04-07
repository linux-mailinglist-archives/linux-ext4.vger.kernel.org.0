Return-Path: <linux-ext4+bounces-7094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E8A7ED05
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB165188A6EC
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66062561C8;
	Mon,  7 Apr 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLVNaWsr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BF217F54;
	Mon,  7 Apr 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053127; cv=none; b=OgB++hOSZiPEAzdbgoBs0k7kVIsxsy0mV7bTyj0yfcIIK82EqYucNNCGUfrXa1RJNMGPCfMuISN6B1603wRZnzBLke0CqQyLeG/vlVaG+ixIgRNXP4keXfBYrcHmtgwfVo1tmhBL8fS1shFuJKn7tzMGSd7TRo2e59cQsghtPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053127; c=relaxed/simple;
	bh=bzB5Y8MKpBrdkgn7AiTLu62e0pqGLziO3jScyEwzMhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meKtJTCqRMIH7O0P/4XwfzwmN6fNzgKD0P5cPdjKSIBditFXJ6qSddZWRzlCfhMqsSGpkGc7QPQuAHHZbTa7BJurGD/yUXn+ZUNQpv1t5ohtAwqIzc4N/HzqQIpnEX91ww/hfMnN74F0WIRqejT+L1FCZlhqC0Hw6umb6Fo2mu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLVNaWsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A50C4CEDD;
	Mon,  7 Apr 2025 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053126;
	bh=bzB5Y8MKpBrdkgn7AiTLu62e0pqGLziO3jScyEwzMhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLVNaWsrryFrPdN+x/aVk6pZwi0WavWXSor/YKk+S4O7NrzPZuK1k8lGoT+3jEomS
	 cCiyAUA9fApTv6WvKz5FmQpukB80PN1hKH7Si1HyIpnIyHt4wi8qBIZfJdoHeROJAF
	 XXEkgbUBA5K3g4RN6NZdUVlDZUme+hFk625Q1ReZJ21me+iFIp9otpkwrestUR17CI
	 aOVjiWBqW4A42SMekEGfZtZXOPm3ho0zYjtT8yXtrNWxI09YihLEVj5WsrbucHfZgr
	 a3wzjeHVpNsZcLXzgXb0/jCUnwX0czb92ESoDih2IhAAAtomaRtfHgtbbv4Uxxo2tr
	 TuMhQ3LUQCfgA==
Date: Mon, 7 Apr 2025 12:12:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
Message-ID: <20250407191206.GD6307@frogsfrogsfrogs>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
 <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
 <87mscwv7o0.fsf@gmail.com>
 <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <877c3vzu5p.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c3vzu5p.fsf@gmail.com>

On Tue, Apr 08, 2025 at 12:16:42AM +0530, Ritesh Harjani wrote:
> Zorro Lang <zlang@redhat.com> writes:

<snip>

> > Yeah, nice catch! As the defination of _exit:
> >
> >   _exit()
> >   {
> >        status="$1"
> >        exit "$status"
> >   }
> >
> > The
> >   "
> >   status=1
> >   exit
> >   "
> > should be equal to:
> >   "
> >   _exit 1
> >   "
> >
> > And "_exit" looks not make sense, due to it gives null to status.
> >
> > Same problem likes below:
> >
> >
> > @@ -3776,7 +3773,7 @@ _get_os_name()
> >                 echo 'linux'
> >         else
> >                 echo Unknown operating system: `uname`
> > -               exit
> > +               _exit
> >
> >
> > The "_exit" without argument looks not make sense.
> >
> 
> That's right. _exit called with no argument could make status as null.
> To prevent such misuse in future, should we add a warning/echo message
> if the no. of arguments passed to _exit() is not 1? 

Why not set status only if the caller provides an argument?

	test -n "$1" && status="$1"

perhaps?

--D

> -ritesh

