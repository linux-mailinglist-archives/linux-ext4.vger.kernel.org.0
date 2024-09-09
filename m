Return-Path: <linux-ext4+bounces-4088-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593A971EF7
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA681F236DC
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297513A879;
	Mon,  9 Sep 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CB2Y2dKj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BB14B96A
	for <linux-ext4@vger.kernel.org>; Mon,  9 Sep 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898813; cv=none; b=TSkwy/iQSgzw+A6b6BNwnghgDSugbVhXSClzsseKYxFof6vhR7urJX9fOk1EfBMXqHtmZLWrfNrOmykxk5AsGSZL/TCfzlT3vWootozAU03r8bpDzZIxV8SG5o+AzSdwCO4jtFQ4QxduMBEzdwvOVlVGgvCmN25St/9arUQuows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898813; c=relaxed/simple;
	bh=XOBHjrgWpqrrplFQ4AfRo5GS77MpH5VnN6+K8h89qxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3M61wO+980MMVGFCcZBwFWJpOvPRSwWbq0UoH+O4AM0txsTKRw2CdvDY8eqsv7JvYEubbbBOJz2cWAhLkLFG5bVd+ASyfweWTYP4IfDED7LqeCX1ouye+IwTheFX75OXEY+fNby2/PWm/zyYML9cYgZROQ4T8F+MISwNUEP+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CB2Y2dKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C4C4CEC7;
	Mon,  9 Sep 2024 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725898813;
	bh=XOBHjrgWpqrrplFQ4AfRo5GS77MpH5VnN6+K8h89qxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB2Y2dKjzhV9Xjwrs1zjJfgZ3XfJG56ZJZexY+LpvwiFPVhmm4P5IOZe+HFsxHsdc
	 BizBgHSmWWV82yHN0fsROOtRBKuAFIFHIFezYXGKusBIaTvxiHzzZwM86Gl9bwSLkW
	 JgmRi+64/OpPD8ZR2v2nN/AUI3T7qRLWVBJorC+Q=
Date: Mon, 9 Sep 2024 18:20:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: cve@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: CVE-2024-43898 is invalid?
Message-ID: <2024090919-eats-countable-1a0d@gregkh>
References: <20240909153144.GA1510718@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909153144.GA1510718@mit.edu>

On Mon, Sep 09, 2024 at 11:31:44AM -0400, Theodore Ts'o wrote:
> I believe CVE-2024-43898 regarding "ext4: sanity check for NULL
> pointer after ext4_force_shutdown" (commit id: 83f4414b8f84) may have
> been issued in error.
> 
> ext4_force_shutdown() is called from FS_IOC_SHUTDOWN, which requires
> root privileges.

"root privileges" are not something that "is this a vulnerability"
normally takes into account given that there are zillions of ways of
giving permissions to processes to do things that people do in crazy
systems, as you know :)

That being said, the commit message does not document root priviliges
being needed, also, it looks like the function is called on the "normal"
shutdown callback for the superblock, which I don't think is required to
have root permissions, does it?

But as a maintainer, it's up to you if you wish to reject a cve for your
subsystem/code, so if you really want it rejected, we'll be glad to do
so.

thanks,

greg k-h

