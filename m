Return-Path: <linux-ext4+bounces-6133-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E6A13A83
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D84818864C1
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCE1DE4E1;
	Thu, 16 Jan 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hWalaBqo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5F1D90AE
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032961; cv=none; b=cF3A8isGV8cSrljMpH50zRKZSjaHXvJa9entP5JEbMlzIsgR9q+zQxlXikzMZV3zdJh5sHdbMQkmp65hVeqwtivJghChC6tJGnmgErNn4CtTohwQuYZDT/5oS34npomViCAbH0iJ72OaVRskW9LSd1QN6xQAIzEkvYDhqwJlScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032961; c=relaxed/simple;
	bh=dyJZb6QkaJjsuRpYl9ejjwT65pyQid35UBxryDmKwUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFEaEGlXOHSCHlpsbaV7CZk4KgIJLs1ooE5p1SquayV/41SkIGnK+MqoqT0NpiXf1TAYI93NG7Fl3sP+9koE7Ug//6p9BlgoI2HVgmKPZVnwbRbsHAwKhZf9oWiOGLAKIh/QKjNydBcLPtAKN+NRrj6TXMzeWyQEtCcPdWc+NiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hWalaBqo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50GD9A1O027913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 08:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737032953; bh=zyirhleK43K5Uljp6tNnwVWevvMPdWTLSNdA9TbnUZQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hWalaBqoZfcURke5VWdyb9HuuZ0eDCJ3tXvyVSKR10i/rueuU72bnQKMh4Wc/LTSp
	 h+VYctDHsgt2OLPp1GQkglyjRzAiiQq+TgpK2USZEVofCWFW19PkRJ/FMI2UlDkKP8
	 4n41Oau8M8J8HxMx/UQxOCOWcNhKKgpO6BRmRvVl7MBcDOYcJKTRqxN1IXNAVJJLBZ
	 kdYqdJDSTXTcuS+bGHAN/8gkEk5YU0YZe8zcYKNwDhPXy03F3K9HbT5vVVXqRrRVoC
	 pnOR5Almirbh0zzyKnLi5AuOt8aFyAqJWSRezQWSRcCw2mFW70hFEwbKzCUdjMCQhj
	 oEiOR3P8G7dPQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C68DB15C0108; Thu, 16 Jan 2025 08:09:10 -0500 (EST)
Date: Thu, 16 Jan 2025 08:09:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@whamcloud.com>
Cc: linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>
Subject: Re: [PATCH 1/2] misc: deduplicate log2/log10 functions
Message-ID: <20250116130910.GA2446278@mit.edu>
References: <20250116011150.55313-1-adilger@whamcloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116011150.55313-1-adilger@whamcloud.com>

On Wed, Jan 15, 2025 at 06:11:49PM -0700, Andreas Dilger wrote:
> Remove duplicate log2() and log10() functions and replace them
> with a single pair of functions ext2fs_log2() and ext2fs_log10().

Could you please implement 4 funcions, instead of just 2?  That is:

      ext2fs_log{2,10}_u{32,64}()

Thanks!!

					- Ted


