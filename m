Return-Path: <linux-ext4+bounces-3377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429193A19F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455591C22219
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B815351B;
	Tue, 23 Jul 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EGRRlWtr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B7208A0;
	Tue, 23 Jul 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741732; cv=none; b=UMFCHNRQzNWA/BlgkBP4lyI+wMduldC/pSesl+i5Ja4Pstui0eetXbhlkwbyp6clZORYxMmBlz1nkukAhjd62yOhq5eJWXo0jGXjVI/Bi3hHFOnMIx/L1JrmansqKiaKDbRpG4lA03NBKL2hs17L71DyqKgcboFmBBH5oSEfTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741732; c=relaxed/simple;
	bh=RjIL2LaXMSllEH0B9rwmL7zMAvde7nwWWDixazHouUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIOHS1PtiS8Fi36iZ1ayKOpFc2JeDAi5lySlC2OpdXTY4iv40cz5bbfMUmO3+37E9b9RAPuXZfVWeY4tstXXUmWZbpJqJgmEm5RwQRSouKVnWr6UnoC0eQeUCT0xadnYaPDgDGCjuxuhiD3LKoJuVGf9TT/N945pWPycRg4+EMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EGRRlWtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47691C4AF09;
	Tue, 23 Jul 2024 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721741731;
	bh=RjIL2LaXMSllEH0B9rwmL7zMAvde7nwWWDixazHouUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGRRlWtrHqHJmMai0F/2gk8tt+q+wx6T1YGDlPYJig9HcTlIOxTG53BebLUzQZLA4
	 mlnILR6xY/zHFJeaAsf6fXxpU+PHo1DyLO93LX9XjNZlPKSmChUjFFfm0ASNmyq3a2
	 meq3s7D/PxPC4r93Znl4RWXssT5/7T7KXAu2NAIE=
Date: Tue, 23 Jul 2024 15:35:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: stable@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v5.10] ext4: fix error code saved on super block during
 file system abort
Message-ID: <2024072323-cone-mustard-94b0@gregkh>
References: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>

On Tue, Jul 23, 2024 at 12:17:19PM +0530, Ajay Kaher wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> [ Upstream commit 124e7c61deb27d758df5ec0521c36cf08d417f7a ]
> 
> ext4_abort will eventually call ext4_errno_to_code, which translates the
> errno to an EXT4_ERR specific error.  This means that ext4_abort expects
> an errno.  By using EXT4_ERR_ here, it gets misinterpreted (as an errno),
> and ends up saving EXT4_ERR_EBUSY on the superblock during an abort,
> which makes no sense.
> 
> ESHUTDOWN will get properly translated to EXT4_ERR_SHUTDOWN, so use that
> instead.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Link: https://lore.kernel.org/r/20211026173302.84000-1-krisman@collabora.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> ---

Both now queued up, thanks.

greg k-h

