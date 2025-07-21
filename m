Return-Path: <linux-ext4+bounces-9135-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096AB0C375
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 13:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DFE3A8927
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED52C1598;
	Mon, 21 Jul 2025 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GdmAuZN1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF612D29B5
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098108; cv=none; b=bc5M8zdTHncT3Rua9eAvEwTsLMnNZD0kuUYq/Ojx5jkJq1WHIaetk+LvyfFWe+XMPWVx3antwZMEdpgTJIc8j7z4Ba/8YUtaCIe0ic2ubX7Q9qW5iCNV9FMmHjZggHPBfv4wcj9OWE+saaKHVrwAj+FkN9L980xN8F5/xBpzJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098108; c=relaxed/simple;
	bh=gk+k0qppxbEv0jFNAuV9f/KNCTqGSvRQ8dbKBcdnUiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mudSeIyMjlwOIof2X7aSLnqqGOU/m6TLTkHpy+N7mKUIwfpDodfo9VhdArKD77xHSFYjjM9w07VybGFdpgBVF1FOEnbcdTDjORT5l3t0jYmurcC7Iz6bFV1KbXFYcZHJkpx+OHXSCvXEw+stem3Y5rGEJ1m0FndnVPn09Ruv5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GdmAuZN1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-135.bstnma.fios.verizon.net [173.48.122.135])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56LBfHHn022094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753098079; bh=RSZnpfe01xXxsn0vwzB/gVdnh11I+k39EEu3w67MR9Y=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GdmAuZN1OmPk8L39wWkqt7fmN0n2KaQodvNVHyYNTp2SiqRv/aIgaertRVR0DzW45
	 k9J3mY/yyUmR6dYrZ/ge91RvS6bKvwU6R0//ImkKqRCUjQKEaoaapoAbENT/VmDAka
	 qt5NlIR6AJnCCYjgzd1VARRD9HH9OCgEs9QA4IEZPTmlsc4Dyntnop6En5niocRO5V
	 yggkfkqEswb1q9hgWKcFloXUGj+pxi1U2cr+6ohejUSnZVjrbh4UcpWriJYSqlTOkR
	 ZRK1YVcP4McPwJX3kLq06EkoYppEHWOppA6k9Hxe2P2lwODQuzprdWpOrPEvbTQycC
	 G0pyEkvpEoMNg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8C3D12E00D5; Mon, 21 Jul 2025 07:41:17 -0400 (EDT)
Date: Mon, 21 Jul 2025 07:41:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sam James <sam@gentoo.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/5] fuse2fs: stop aliasing stderr with ff->err_fp
Message-ID: <20250721114117.GB231115@mit.edu>
References: <174553064491.1160047.2269966041756188067.stgit@frogsfrogsfrogs>
 <87seirz2pu.fsf@gentoo.org>
 <20250720185135.GS2672070@frogsfrogsfrogs>
 <20250721054234.GN2672022@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721054234.GN2672022@frogsfrogsfrogs>

On Sun, Jul 20, 2025 at 10:42:34PM -0700, Darrick J. Wong wrote:
> Oh wait no it turns out that libfuse obliterates std{in,out,err} in
> fuse_daemonize() by opening /dev/null and using that exact trick.  So
> the only reason why I was ever getting any FUSE2FS debug output
> throughout *any* of the fuse+iomap development sprints was that glibc
> lets you assign stdout/stderr directly.
> 
> freopen also won't work (at least on glibc) because its freopen
> implementation uses the dup2 trick which will be undone by libfuse.
> 
> GREAT!  I only got to debug my program because OF A WEIRD GLIBC QUIRK!!

So either we need to find some way to inhibit fuse_daemonize() and
then have fuse2fs handling doing the daemonization.  Or maybe we can
arrange to have some kind callback to set up stdout/stderr after
fuse_main() is called?  fuse_daemonize() is called from fuse_main(),
right?

						- Ted

