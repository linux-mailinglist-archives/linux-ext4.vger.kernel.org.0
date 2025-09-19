Return-Path: <linux-ext4+bounces-10299-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D749AB8A265
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE21C803B0
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC7D1F3FEC;
	Fri, 19 Sep 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="oCgxBSyM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EB70830
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294078; cv=none; b=S+5pKuRLsciMcRaAQSnfhhRisYCn+foExrPUyfZSUSUwBvRKxp0B4f9EjYlNk1YaSlTzedRiTM2iDw0qRuMWBsGrN8LH2G4mQgbYCxxDpXbR47i4yvmQk00KuUzMXoczCPzLgwRKLuiAIq/uhPup8QDZogMbJaK1Xg8GU8MGlzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294078; c=relaxed/simple;
	bh=8aN+DlUTdqttobU0990s2RW/d/B4GK0UVxCQhhuXBBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dACdcCNwv1Gp0ekLSzq6b2PD6GjsW/79UeAZQA0nB7yt+d48UdXNqLyqY6VdUCiMehnBBZ8Arn6pnp+knuGDTUi8VDHiAIrwR7bSvd9F2TCl6mXhZentPw7HcW85DY8U0ZYpLcXKyaEQqqvB4/wnRblbz87585KJwFmWjWkllMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=oCgxBSyM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-47.bstnma.fios.verizon.net [173.48.111.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58JF163a032702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 11:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758294067; bh=V63PF0gcyphNJ5XBdiakmPH+M9mQXya2Wa4EroQjS50=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=oCgxBSyMLrdxwEtaBt3GBQAYw/gwmFjLNjAvPf73R/dHb02dHD4TF1o2mc0eU59/G
	 N9qebJ7XDVasMk49A2jX2vHRD+V6zY/c/e8liCLNPJF57lyPv0DsCaFREtiwli2Xxk
	 eZFGr/YuSQ1nryda3UpNSqpd+SI0nhAAcHoPALzDENmpzza+k1YVVt2xdFhKn7/7kI
	 49w2ySSwpvB+p5CN2cKwZ+FXT10czDq7tXkBD4/5q7lmOtcgp3A75yJ99lLgbRcWCA
	 mGmc6EsGoawPOpirifjLIC7MErTY+00K2ptNY3OKUAhXSbN9OpO16l0QIwAiPWG1fJ
	 /Xi1xBxLCh06w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4C7972E00D9; Fri, 19 Sep 2025 11:01:06 -0400 (EDT)
Date: Fri, 19 Sep 2025 11:01:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] tune2fs: try to use the SET_TUNE_SB_PARAM ioctl on
 mounted file systems
Message-ID: <20250919150106.GG416742@mit.edu>
References: <20250917032814.395887-1-tytso@mit.edu>
 <20250917032814.395887-4-tytso@mit.edu>
 <20250918174724.GH8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918174724.GH8084@frogsfrogsfrogs>

On Thu, Sep 18, 2025 at 10:47:24AM -0700, Darrick J. Wong wrote:
> > -#else
> > -	return -1;
> 
> Shouldn't this still return 1 if this isn't being built on __linux__?
> 
> >  #endif
> > +	return 0;
> >  }

The calling convention for try_mounted_tune2fs() is to return -1 if
the caller should bail out and exit; and 0 if we should fall back to
modifying the block device thle old fashioned way.  So that's what
should happen if tune2fs is run on FreeBSD or GNU Hurd.

I'll add a comment documenting this.

> > +	if (get_mount_flags() < 0 || try_mounted_tune2fs() << 0) {
> 
> Why shift left here                                        ^^ ??

Whoops, typo that should have been < 0.

		     	  	      	     - Ted

