Return-Path: <linux-ext4+bounces-3390-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5193A52D
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 19:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6492831B0
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F102158868;
	Tue, 23 Jul 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HhmkLhvw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CD158203;
	Tue, 23 Jul 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757436; cv=none; b=d1+Lf4ECuAJmNoxozDpeeYDkTNBLe1U8svZbemDbnJSXwj1aTqjOpr0LVk6UTHfiBGtEYNHu1lEaT8xRkFDcCzPr4bmxDcKi60Exmh7qkZAu+hqQVhnp8wKVyc+1Tavc4SGeddMg4FgaPudp6pFiKG+9TSTYybAhbVrI7cAXxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757436; c=relaxed/simple;
	bh=BP0BhGKwv62F6W96usjaxFi2hAre0sUnVO7t24wPpWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbPeYhTv+0yKMFh4Qd/9Nx+UdP40e/UbjWrOhibMlWQDX7cibz8iaIZBZt8AOrYgMNRLM01zjZeHoKc4Qtl15BhLC/TQErjkLZEY2E31L6rW6JTgjlSEfHpwYHEoj6XmxBpmTzMp2VdaPr2V8PBiQChb6nAVndpzFEF+YLzYaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HhmkLhvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8848C4AF0B;
	Tue, 23 Jul 2024 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721757436;
	bh=BP0BhGKwv62F6W96usjaxFi2hAre0sUnVO7t24wPpWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhmkLhvwIstlrT5RR2IfPa1Wgnzyt6qrBxqChuEGkz6MbWivbAdfBx4GxNXwMp9Va
	 CCeqeBkjl0HywolV2X+PI+EEiaV98/6i6vRQRqXsf3KPazofFgkfVWh5docQH5kDdQ
	 F4BUIurd0LgET/CSWSWr2cAjKTJFnck5uJ8ozBTs=
Date: Tue, 23 Jul 2024 19:57:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, yi.zhang@huawei.com,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, niecheng1@uniontech.com,
	zhangdandan@uniontech.com, guanwentao@uniontech.com
Subject: Re: [PATCH v2 4.19 0/4] ext4: improve delalloc buffer write
 performance
Message-ID: <2024072357-poet-statue-b2af@gregkh>
References: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>

On Sun, Jul 21, 2024 at 12:04:06AM +0800, WangYuli wrote:
> Changes since v1:
>   Fixed some formatting errors to make the patchset less confusing.
> 
> A patchset from linux-5.15 should be backported to 4.19 that can
> significantly improve ext4 fs read and write performance. Unixbench test
> results for linux-4.19.318 on Phytium D2000 CPU are shown below.

What about 5.4.y and 5.10.y?  You can't just skip those trees :(

thanks,

greg k-h

