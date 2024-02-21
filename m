Return-Path: <linux-ext4+bounces-1337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF385E1D8
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829F41F22AA6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F080BE1;
	Wed, 21 Feb 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dP4Dv4E8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948633A1A2
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530567; cv=none; b=UIs9VJcg1oL9R2cCSuOs1mX8NNM3e3PQxf6g7A1puZ6ep/CebKxV8GwZq9FgMtj40py8bTrIH0xG3j4OQoKqq3Vpnb5ZOr5Xn3W0+oDZfU6RX1u+Eyrnd+d3PbYK/TPaU8mXIY6nULT8TjbfiDV9cuzuH8oBzgFBDJwVvZM62SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530567; c=relaxed/simple;
	bh=Yd4d/JC9epR2VxvN/pxlvoHf8bMrDFj0KMBnyOIA1oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvLC135W8ydw55KSIQdk8uF8ZYhH1R6aRS6WPmMzkHeOVmWRpRJVs/+ok/6lLWAkOb4r7a4vHDF5stUcklX0qUd73R3xf0xqgGSmN0mOi8R+ahE9F57wTLPp2WKb/X/CH+RPaja4P7rs/FGhyeBgx5iv25/GdFzQ6NLu4RyAsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dP4Dv4E8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41LFmxqC031539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708530540; bh=jPyvlJKw1Zon2KRus9HTmJn3YzXV4GO8a2ReHsRUilg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dP4Dv4E8gUM0M2LDO6QKN+vwVEoUE51GEZYACI3MH+O3anmjhDt7AE5hBHXlNavCu
	 Ye879w172qZ9BhmuzQFytNKl192RniU7xPSl2/mmevJJyI+gPqGlDy9Nk3aPr9Dk+k
	 qndVfVF/EOs8Ler0vjIEkI/R6om2fb89UgSWszWnmAi6YdO22CO1LBE/eyKpe1UWK5
	 wpoPt+29TYpP7i8YBXxsYp4cfDaEU+gl2zVWAmuCDXdL0yLL60nFFL5a7NOMkrPaEK
	 FSc+iweUkAC0xuTtQnK+g+YkjxyXGRa0MNydw/TfGTu+i0jCmLgd8XUCbarqtAraJt
	 +iQD4Syo+QAQA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F31E615C0336; Wed, 21 Feb 2024 10:48:58 -0500 (EST)
Date: Wed, 21 Feb 2024 10:48:58 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Reindl Harald <h.reindl@thelounge.net>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Why isn't ext2 deprecated over ext4?
Message-ID: <20240221154858.GA594407@mit.edu>
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
 <20240221110043.mj4v25a2mtmo54bw@quack3>
 <4b40056d-9b55-48b2-86f0-b91207e9abb7@thelounge.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b40056d-9b55-48b2-86f0-b91207e9abb7@thelounge.net>

On Wed, Feb 21, 2024 at 12:39:54PM +0100, Reindl Harald wrote:
> 
> you shouldn't create filesystems with a on-disk format that don't support
> 64bit timestamps no matter how small the filesystem is
> 
> the arguments on this list where "such a small filesystem isn't expected to
> be still used in 2038" which is nonsense in case of a /boot FS in a virtual
> machine
> 
> our whole servers already survived 16 years and 30 dist-upgrades

This is an individual system administrator's decision.  The defaults
will not create file systems with 128 byte inodes.  

However, there are situations where it *does* make sense to use ext4
file systems that can not express timestamps past 2038.  For example,
at my employer, 128 byte inodes on HDD's because we do *not* preserve
file system images across hardware upgrades.  Using 128 byte inodes
means that there are 32 inodes per 4k inode table block, as opposed to
only 16 inodes if you are using a 256 byte inode.  There are
performance benefits if you are concerned about reducing the 99.99%
latency on heavily loaded disks, and reducing the TCO costs for bytes
and IOPS for my employer's cluster file system.

Furthermore, from an ecological perspective in terms of power and
cooling perspective, even *if* hard drives would survive for over 8-10
years, it would be irresponsible to keep those systems in service.  So
my employer knows what it is doing when it uses explicit mke2fs
options and/or mke2fs.conf settings to create file systems with 128
byte inodes.

					- Ted

