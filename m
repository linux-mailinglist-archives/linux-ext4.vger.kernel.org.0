Return-Path: <linux-ext4+bounces-4533-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD28995427
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FFDB292F9
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557841DEFDC;
	Tue,  8 Oct 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r00hE3Tp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9E17578
	for <linux-ext4@vger.kernel.org>; Tue,  8 Oct 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404012; cv=none; b=O8XKynwiudvyGe1kZXRApFaedXaSldcMLQ5zjn49IgJa+pS4Pe5gYZK5fIxCqS6hAMGyZZFXVh3HfD50LlDmQzbQ0AanlnVlGIS5iC6/90O4Grhk1PRFjkq9pJblYGu6mGEfP+x/vek6I/Z/5o3GPWXWa0apbzktxjI7sHkvRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404012; c=relaxed/simple;
	bh=gp13OH656bUEan9SJnp7WEauLTdEy1HPQVswiFXLn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGK2HLx9DIqRkUEMgGtbM17a7efi5VysOQGsJexrhxPlTl2fZsY71S3jnUtlQoILmLvUZirLt440+8YFYJjEAipdtEj3AYZ+OyHXXJ+DPbKEJoIN4vV7TLDM0kUjLl7WGr3AxU+h1nO/xpCW/jUgamsUsL09MYLiHbWxgWcOokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r00hE3Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B23C4CEC7;
	Tue,  8 Oct 2024 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404011;
	bh=gp13OH656bUEan9SJnp7WEauLTdEy1HPQVswiFXLn7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r00hE3Tp1DrdczF9W3kULZiF96CDKPzH+Cdr4lBmJLhc/Z1f7pppWuFOABMvlwhLb
	 2aJuVYuw6Mg4VRYyUdW41afJAr+8t7haY0oHez7ulrj7Q13lfO23Is7QIb7kM4yL4n
	 LkGNRgzCTHcUkCaK9UKWDqc0X4CQBvoeIGB6GhdmoT56ejez06iuZQNFfnqey1c/NY
	 AY+GA6IXFQlfhgDgDOYOOcm9k+C8BmMBYh6N1j8fehz/AnuyUh3Oloyoes2v0B40Yy
	 iKTbOICAr04Iony60jbXkObjfHJ0m7pLQSNaRWXUORCQfgGUSeKTDyvo9/1bQSZyIJ
	 yUW/Xel2wpDMA==
Date: Tue, 8 Oct 2024 09:13:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Sunsetting ext4.wiki.kernel.org (unmaintained)
Message-ID: <20241008161330.GA21832@frogsfrogsfrogs>
References: <20241008-strange-hospitable-buzzard-b0e64c@lemur>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-strange-hospitable-buzzard-b0e64c@lemur>

On Tue, Oct 08, 2024 at 10:34:43AM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> The ext4 wiki appears to be mostly unmaintained and contains pretty obsolete
> data going back decades. I suggest we do the following:
> 
> - Archive the current contents as a static site on archive.kernel.org/oldwiki/
> - Add an admonition on every page that:
> 
>   - the viewer is looking at obsolete contents
>   - all up-to-date information is on https://docs.kernel.org/filesystems/ext4/
> 
> I.e. this is exactly we did for the unmaintained git wiki a while back.
> 
>     https://archive.kernel.org/oldwiki/git.wiki.kernel.org/
> 
> Please follow up if you have any objections, otherwise I will go ahead with
> the plan.

I lost my account on the ext4 wiki when the login system got changed
and never figured out how to get it back, so I migrated the one piece I
cared about (the ondisk format docs) to the kernel and disowned the
whole thing.  So I'm perfectly happy to have it archived before it gets
taken over by adverse bots. :)

--D

> -K
> 

