Return-Path: <linux-ext4+bounces-2949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3098C91724A
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ECD1F2844E
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAF17D36A;
	Tue, 25 Jun 2024 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pYVR4XK2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395417CA0E
	for <linux-ext4@vger.kernel.org>; Tue, 25 Jun 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345977; cv=none; b=cowGTvIqih2dfxCnlAetw4nErhL+8QgLkELPufA0/CNYfGmiBcwkHmLr2p5N8UEe6XKHGO+QxL6zg2etK67DEvSdX/ov41AneBwtCBDuR2f6ASsG4W5+w9c85EMvNYsMZKcUcM96bhtHKNjdi7hEvNMQwKU3nb53mvndQPT7Mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345977; c=relaxed/simple;
	bh=5r+sg8zOWLb2A7m1PHd9pDzB+ZZOLQBTSmvcAvi9BwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld1fiyc7wXUq20p/6CNDYpdDCP/EeDKCBE3KL+z/PiOaBnlyY3b5ViYJODlrf+S5uhWddr2LJWVqI3fQwdZdz7/3PoNkB5HOg2SaFcpW3KkWt1oyGqOWVVelicM48CAmxkEmQmOOzlSegwrMzC7wqjVLcRq2YM8h4rLh9phSAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pYVR4XK2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-193.bstnma.fios.verizon.net [108.26.156.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45PK5ted009738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719345957; bh=ZdArl8DEmKUH3JhJHbYoi3F9BDg0hnY0P0cWr+pIuDQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pYVR4XK2fkVRVqlyG/GMkAqZGCiO0s5EpjLaqsCI5drQ3baj8vkCCF3s6vCz2ZaTz
	 t37m3KWAanvsHQonHTSvVn+qilt4V20M+wsH/cLTFVPzt6U+0r1aDQeHvCPfgkcokU
	 AQxZOJ34z3yZewPBVh8mpkTy/+Y7oSON2czaMwaW/Vuf/qykq+1gtLsxlouZJfsAZn
	 5eLTwjHuOROIJcRtznisjXOa9D3szm4RpmaqZrzM7REqv2UWvKC0+KkMsYDJ5PscPN
	 rUwmhd/QsQgtHNJVm32GlPSVEEN4hGBUj53qQVBx/fG39C45GhVDJIrDYeoW0RntmH
	 J3Q4bCUadQvug==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 55F8E15C5E33; Tue, 25 Jun 2024 16:05:55 -0400 (EDT)
Date: Tue, 25 Jun 2024 16:05:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/740: enable by default
Message-ID: <20240625200555.GA394275@mit.edu>
References: <20240623121103.974270-1-hch@lst.de>
 <20240623121103.974270-6-hch@lst.de>
 <20240624161605.GF103020@frogsfrogsfrogs>
 <20240625035008.GC7185@mit.edu>
 <20240625060038.GA1497@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625060038.GA1497@lst.de>

On Tue, Jun 25, 2024 at 08:00:39AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 24, 2024 at 11:50:08PM -0400, Theodore Ts'o wrote:
> > It might not be worth it.  One of the reasons for it is that mkfs.ext4
> > can be set up to try to pull in libmagic using dlopen, to minimize the
> > package dependencies for things like the distribution's installer or
> > minimal root setu[s for Docker, et. al.
> 
> So mkfs.extN doesn't actually use libblkid for foreign fs detection
> like most (all?) other tools?

Oh, good point.  Yeah, mke2fs uses libblkid in addition to libmagic.
So yes, it should work for basic detection of file systems for the
purposes of generic/740.  So the only issue would be the fact that
mkfs.extN only does the detection if it is running with a tty.  The
reasoning behind this was that there might have been existing shell
scripts that might try to reformat a block device over an existing
file system.  (For example, like file system test / performance
scripts like, say, for example xfstests's "check" script.  :-)

What I've considered doing adding an extended option, "mke2fs -E
existing_fs_test={on,off,auto}" where auto is today's behavior, and
"on" would always do the pre-existing file system test and fail if it
there is a pre-existing file system, and "off" would skip it entirely.

This would allow generic/740 to work without having to depend on
"script" being installed.  Of course, this would only work if a
sufficiently new version of mkfs.extN being used by fstests.

	     	 	    	      	    - Ted

