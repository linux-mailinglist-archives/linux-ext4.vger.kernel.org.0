Return-Path: <linux-ext4+bounces-6103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB0A118A1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542123A6FF5
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542841836D9;
	Wed, 15 Jan 2025 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bNwmx6F+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4671876
	for <linux-ext4@vger.kernel.org>; Wed, 15 Jan 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917230; cv=none; b=m/NNnqNIjTVtqv8pNIrQWte/ifH2dXc6i9CCwE6B27tAK6JeBjYQ7r5MpSS84yVfhsPlEzg4Z4di8ft1z5B3UGegfRiPQ9HHkMWy5VCQznIjYTcSiDJWxchOZd6Dle1bepO3O4yTArdOHvd2cGZSBkjaH+romc3/2n8jn3m26XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917230; c=relaxed/simple;
	bh=sePE74wpPWiNXNoxEUN8Ry9H6vpLGlXFeTBBoz+pvwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC1m1tvmsf+SnawecXsl2ArIZpZIQCE80j/UMAddD6WiJlFHLVKmYAd+fPHEcDv+HdPojEVepFbVkMa4EhEcRdByL3kfFpKNMnWKju325F8zgLBse4sKa2ZNRh2v1EzcXQCC6CDO0bKrUDQ87xUsh1HxYvpkCIlSkZFoFyB61aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bNwmx6F+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50F50FME003928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 00:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736917218; bh=tkOjXzpY/sSr9F6llPq2ltDP6q1IFjSxyqXSSqzKsMw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bNwmx6F+DXjxqmSaNbXbFBDnmvnG5VPktS6tPPEryTDnNBOEqedZn1SzK1kxt8mVY
	 wZ0uPaovsSX0hR1eSx7pD1ZogONW3Ae9SddBo+GSEEjqqH2VBRRpdk4txG11UbhasO
	 gblbGArCPKMVzfrtxV+1RP7G4AUux3JfD97Tne6dw5krd5Tkqk3oUzPzVzwdN+aK1y
	 VHq9nm33sBAJcGM/TQJtGOuGVxXFH371LOXOIMLlP7NHUi0ATFZOgo8nf0y323wYR/
	 s43zDP5qTHCRaPW2sH/BQr6FbOXD3DyWx4TJZLzLvPhSXgczfIPOUB2ZM2TWcUcUiR
	 1T6xAtHVsTk4w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8E53515C0175; Wed, 15 Jan 2025 00:00:15 -0500 (EST)
Date: Wed, 15 Jan 2025 00:00:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: "WARNING in ext4_destroy_inode" in Linux Kernel v6.12-rc4
Message-ID: <20250115050015.GB1954680@mit.edu>
References: <CAKHoSAsxwS1J2fme+6-d84tguJGDYamVCHfcuXZbeGpTGHze0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAsxwS1J2fme+6-d84tguJGDYamVCHfcuXZbeGpTGHze0A@mail.gmail.com>

On Wed, Jan 15, 2025 at 10:34:24AM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version v6.12-rc4. This vulnerability was discovered
> while i was testing the kernel.

A WARN_ON is not something I generally consider a "security
vulnerability".  This is especially if (as I suspect) triggering
failure requires mounting a maliciously fuzzed file system image,
which is something I don't consider an interesting threat mode.

And without a reliable reproducer, I'm not likely to waste a lot of
time on this.  So if you're a researcher trying to mess with Syzkaller
in some weird proprietary way without runninga proper syzbot
interface, sorry, this is a super-terrible way to try to demonstrate
real-world impact.

Feel free to do more of your own analysis, and when you have a
reliable reproucer, please let me know.

> 
> Linux Kernel Repository Git Commit:
> 42f7652d3eb527d03665b09edac47f85fb600924 (tag: v6.12-rc4)
> 
> Bug Location: 0010:ext4_destroy_inode+0x1d0/0x270 fs/ext4/super.c:1465
> 
> Bug report: https://pastebin.com/YKFyLm5P
> 
> Entire Log: https://pastebin.com/fE1tFAUS

For the record, this URL is not accessible; possibly because you
failed to make it be public.

> Thank you for your time and attention.

Sorry, but you've wasted my time.

					- Ted

