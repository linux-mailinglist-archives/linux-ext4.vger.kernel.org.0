Return-Path: <linux-ext4+bounces-4616-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73B9A31BE
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 02:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC59D1C2261D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D073BBC1;
	Fri, 18 Oct 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Tt70nWeu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9852A1C9
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212281; cv=none; b=ZwSBBOwjixgGgyq+ZtsxzBmRpoEKMGYBGP1DEo3Bf9Cc8MaJTrC8YqpLehe8rGCoxPXwPwwkr73znZtL+w33UukkZOrWSOqnY/pVruNCdXJPGTO1hF/ayTZ6hVWERarxJUIufvnN+jO8b77O1wNuNs029E8mdY9Q/IOgrUWKbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212281; c=relaxed/simple;
	bh=O9lJMApKAyosshi6ynaVTCtUdzkm6E1rH0tV+BSplMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9Xmix0x7xH+IhkneFl4AtAAdT01YS+doeS3r6/ErXLWPXeUGeJKjhiUFBlHJGI5jp4nHZGEjcI2YXX3btfpHWs7pEGVJHIbNu25nxRjSHdkMBwbBrehRzg9eQo98YLqU9YveLelB20mGBoV+8tDHIlakGsAdM9WUOgXI9TJ7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Tt70nWeu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-118-108.bstnma.fios.verizon.net [173.48.118.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49I0iR5o025376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 20:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729212271; bh=a338VHJdtr8ktcvv2/F0Bs/QROtjRI/tIx2TpkIjpAI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Tt70nWeugUJImbmhUYkqWbaHvAq4xtmozzHL6CEmu6h8EM34qY10YmeAeFnEGiUrj
	 OHeWW/XLijR9TsUvBL/xU3awLAmRNsnmhwRkhLu+bUXZzKs3woZdsHxSKyile2DNmf
	 Nh2TMBOP/AOSuQ6/lljgXSw5a6GfWMMYMGis2PaMe1Bz7bbVN+Je06TSQC3QHZo8ln
	 E9gswgDkwACCgeQeG67yCgvnZa0DuWp/Vk8zgnHaBJ2q8Bo9SBAExnOrK3xAKRILyN
	 MzBimdbIzg6V0YL8puBru0Aog8UB4E12btTv9hnRnphgaKha8ioH5udPiTbv0hFlZJ
	 no+KzOhGUmNeA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4A75815C02DB; Thu, 17 Oct 2024 20:44:27 -0400 (EDT)
Date: Thu, 17 Oct 2024 20:44:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: BUG: 6.10: ext4 mpage_process_page_bufs() BUG_ON triggers
Message-ID: <20241018004427.GC3204734@mit.edu>
References: <ZtirReiX7J+MDhuh@shell.armlinux.org.uk>
 <Zti1Y5fthhgiL5Xb@shell.armlinux.org.uk>
 <Zti6G4Wq3pQHcs++@shell.armlinux.org.uk>
 <20240905131542.GS9627@mit.edu>
 <ZwlcNXOPTX0MVWQe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwlcNXOPTX0MVWQe@shell.armlinux.org.uk>

On Fri, Oct 11, 2024 at 06:11:17PM +0100, Russell King (Oracle) wrote:
> I'm about to throw 6.11 on at least some of these VMs (including the
> two that failed) so the on-disk filesystem is going to be e2fscked
> shortly. As I said above, I don't think this is an ext4 issue, but
> something corrupting ext4 in-memory data structures.

I agree; I wonder if something would show up if KASAN were enabled.
If it is some array overrun or some other wild pointer problem in some
random subsystem that is enabled on your system (but not mine, since I
use a very restricted kernel config to speed up development builds),
maybe it will turn up something suspicious?

> It could be
> related to the VM having a relatively small amount of memory compared
> to modern standards (maybe adding MM pressure to tickle a bug in
> there).

Yeah, it would be interesting to add a test in xfstest which runs
fsstress and fio with memory pressure (where the memory shortage is
either memcg constraints or global memory availability).

> Or maybe we have another case of a tail-call optimisation
> gone wrong that corrupts a pointer causing ext4 in-memory data to
> be scribbled over. 

Maybe; I assume you've tried to see if it rerouces on different
compiler / compiler versions?

> I'm grasping at straws at the moment though...

Ditto.   :-)

					- Ted

