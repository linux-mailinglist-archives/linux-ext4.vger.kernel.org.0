Return-Path: <linux-ext4+bounces-2944-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0C915D75
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 05:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78294B21B2D
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36DD48781;
	Tue, 25 Jun 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="d+QEuZId"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E524132C85
	for <linux-ext4@vger.kernel.org>; Tue, 25 Jun 2024 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287429; cv=none; b=qYyTiWg0g2GGGn1IszeSckAbYamrajHzO9ay0YVP2VFV8pUelShID2Fe0XVN+4RAG0lNDQu2d7f81u9AYJJfiQTLU5Owy63w4oGwZZ7N8QVvuS4ljbR1EzpJ8JZag66qsETugQ4kIT275IUWkT4RnPZGnu9Vv8zy0wPLwmHxK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287429; c=relaxed/simple;
	bh=WQPBWxSIP8Yx+5RsBeKRzx+wY9Ns0aK1tiPl45ZZZZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcS5DUeUnKUxLqskAGGb0S4dbtzHKWUD1huRrTnBil/U351/er8wEmsBm6YtPk+P7+DmewIevq7x3TcqkoKiKt5nHAZdoAmZZ9s+wf6ssAndgxf6VAFP47VhqktqWlxRO1uorknNgOhYotHRyYR0zuoAt9zg4b5VdWFm6oAhOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=d+QEuZId; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-193.bstnma.fios.verizon.net [108.26.156.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45P3o8Pe025839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 23:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719287410; bh=cYh6wNsY6fBGNNGnghMIqtzTq8z1MaqJ++drmipxfJw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=d+QEuZIddSqKSZ7rYA8ijHIFgRtEGtmJN5s/enmE/FYl11nOSIJC61Ml2pSP45Au4
	 FmjxyqMDzFIPh8rW58VIa/pyg9R/S/3ESGr30kMkwEAZ3uu9jpv8k07ti/W/cKHGCy
	 mz+ziHGCo+NkZ5RKgXkAXXld/v96wJ92yDXLHav/BtIceJRhUAsdDjFvpQY5p2TIRI
	 SHCOuldDYc2kpAMW8qgdy8amyiCaeEgOxafzklm/GujPo50/dYNbtwAYkeKs/UZs9J
	 ulng9vQxfTfPkGD544wirxhFDufRJOXv6MR+1f13gFrwXt/uO11v1pr5l5tfeopzVL
	 K50+ftvO6PG6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 99EAF15C00DC; Mon, 24 Jun 2024 23:50:08 -0400 (EDT)
Date: Mon, 24 Jun 2024 23:50:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/740: enable by default
Message-ID: <20240625035008.GC7185@mit.edu>
References: <20240623121103.974270-1-hch@lst.de>
 <20240623121103.974270-6-hch@lst.de>
 <20240624161605.GF103020@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624161605.GF103020@frogsfrogsfrogs>

On Mon, Jun 24, 2024 at 09:16:05AM -0700, Darrick J. Wong wrote:
> On Sun, Jun 23, 2024 at 02:10:34PM +0200, Christoph Hellwig wrote:
> > Instead of limiting this test to a few file systems, opt out the
> > file systems supported in common/rc that don't support overwrite
> > checking at all, and those like extN that support it, but only when
> > run interactively.
> 
> If script(1) is installed, can we use it to run mkfs.extX in a sub-pty?
> 
> Or is that not worth the trouble?
> 
> (This is really more of a question for Ted...)

It might not be worth it.  One of the reasons for it is that mkfs.ext4
can be set up to try to pull in libmagic using dlopen, to minimize the
package dependencies for things like the distribution's installer or
minimal root setu[s for Docker, et. al.

As a result, mkfs.ext4's ability a pre-existing foreign fil;e system
won't always work, depending on the libmagic shared libraery is
available.  It will be a lot easier to add a test for this
functionality functionality in e2fsprogs's regression tests, since the
build system will know whether libmagic is available.  So maybe it's
not worth trying to teach generic/740 how to test mkfs.ext4, at least
for now.

Cheers,

					- Ted

