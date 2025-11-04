Return-Path: <linux-ext4+bounces-11445-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E6C311C6
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B6C18C0447
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A632F2610;
	Tue,  4 Nov 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Hdn7x2jV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072222F0671
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261601; cv=none; b=OakOHSAbLmx4HMOvPLcRcD5LknIkGUoVtI0HyQp8NipDlkmu4I57GWKTKBvBWO4PF8kZQSt7f97GA7txaTrvlJV+4TMaXjSNbXRaWgVisyquccF48XU0dIgpPLfTJI84rECVaI+3apZ/zQjF2fqjYlYTQn8/zG6Nj/9Vb3l2NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261601; c=relaxed/simple;
	bh=Sw98CA7Dd7m9VDa27oTBLlgbwnVxpNKFphTRiJFFvvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYQDehaA+VoLO9LZsizD7Yr6cLlkPDS3hCa1FB7vq8N379NPQiYi678WQYC026iW/CQtRgvqEtiTooEtIeeMnGjygHtz7oCONmymUVpOaZghgaf8+shZ6djxZnmb++EsogsSrnJuxpDC6kKAefmd+GG1lwdOPRlppqRRFIoPqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Hdn7x2jV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-96.bstnma.fios.verizon.net [173.48.121.96])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A4D6GWm018644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 08:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762261578; bh=NR6KcCeNwcpvHNysD8dkvb/mT+S63WyNywQfp0IG4rw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Hdn7x2jVdT1yvx+yIZ7YESB7FcjeA5fn52bWXRm8lOBJ1DTqu2aW56w+ciTrYIAFE
	 ykxSj+xVBZavWXA09TwGpGtMiLM/CyX/V/66fSvUxOt1P7qGbC0ptuFsUPJPWLfrqq
	 uHdyBUO2jhKXYB/MyoPv0vjPOB6G8iaDWjRiZm+JnWm3Vl2ayH921d2npIszByc8qA
	 Ak41Ht3nmCfjNllUfaeDX4TCI2s7u7WKrSpocAZGcWBdDcj4ISJThK6u8c1CdZv/LJ
	 Rmdn0dWKng48zwS6G4Y7bCWji08QiqtMLVybMffeWBefdkAs9wk6KQ/htrqs3LcVIR
	 gg8KrW5G/4O/g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 289192E00D9; Tue, 04 Nov 2025 08:06:16 -0500 (EST)
Date: Tue, 4 Nov 2025 08:06:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
Message-ID: <20251104130616.GA2988753@mit.edu>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-5-5108ac78a171@kernel.org>

On Tue, Nov 04, 2025 at 01:12:34PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ext4/mmp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Theodore Ts'o <tytso@mit.edu>

