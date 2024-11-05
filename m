Return-Path: <linux-ext4+bounces-4957-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB59BC9A1
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465FC1C22CA4
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD91D1500;
	Tue,  5 Nov 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vsSnX/VE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691B1CEE9D;
	Tue,  5 Nov 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800388; cv=none; b=oEPArGMoEZRVO5nympywNeWjN0vfcfo0sVyn9VGQPYvYd+GJjU5D5WuxXD3fZlQlCisQMxFaFsSHaAmz+9Y7mBHBL1nNv8Sn9y8GF7f1B+QXiRzaUo+12S4X/np3Ri7DlZf7ujxSJEHew+9DHTXZIqYcxfWVxkTMwJTy3Of+DDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800388; c=relaxed/simple;
	bh=IuKS1GNqv5j1nam4aK4NaiHGnKTkksjQePYyFYLl8pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCRfN9/1GYjFpfIbHfvCH50o4LpFjsVAaXGBylxI+nyVx4Mg1Dm50nwqeifyrR8ZHhcH6PJ0+my0erfxDAAsDUtpC6s5YiDimJGEKNI0TsXTzlYi7n/7IB8+FNbQdE/QvKyq9YnItbMMdHLpnzMpMbauIFWLJeDgXWlu9cwTr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vsSnX/VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6969FC4CECF;
	Tue,  5 Nov 2024 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730800388;
	bh=IuKS1GNqv5j1nam4aK4NaiHGnKTkksjQePYyFYLl8pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vsSnX/VE3ap8YV/lXdJBexgHwBVRjJibaCz/x0/w84647/XfbWSA21p3WnHSZcAdT
	 orqUIFk/w+tv8DMRYahhmqdmcSfZ+DYApwIyRMyAU+Z2vQMY0bjLfgFUdpdr+okEx2
	 rysN5cEwUOP5CVNydbn9GL1A5/y+of++Kj8OOJYw=
Date: Tue, 5 Nov 2024 10:52:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] ext4: Annotate struct fname with __counted_by()
Message-ID: <2024110530-ashen-deforest-9f71@gregkh>
References: <20241104234214.8094-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104234214.8094-2-thorsten.blum@linux.dev>

On Tue, Nov 05, 2024 at 12:42:14AM +0100, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Inline and use struct_size() to calculate the number of bytes to
> allocate for new_fn and remove the local variable len.

This is two different things, why not do this in two different patches?

thanks,

greg k-h

