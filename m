Return-Path: <linux-ext4+bounces-8187-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF3AC2509
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA7B9E1705
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC930295524;
	Fri, 23 May 2025 14:28:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5E1EE02F
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010495; cv=none; b=RjuG9UH3jhQIEz2+U5WUW7WoNklM9FrDG/hbhmXNIFgHDqpQaBp4UmoR9qeAgCFd16lHgoIi3xMcjdKjV80aX8Kcy5B/7yuFKAvl/uhW0SUWrtbU2tygMtxU7XIb+BTgegEiPfviTIPT99MOEWObBIK+SHjGJbyGDuO02Qr5TjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010495; c=relaxed/simple;
	bh=doUBnbrAXmCEND8KgI9ax+kD2mTwWaGjbtxgwz9jvd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRJI1teX94zVo+JZXVv/sdJ6/2HyL0DzEjNCHoJU3tYtTeQ7+22C7t2YfSIkILOQ7qREuWzCvG0SOdpnKaQfvxC6Jku6Egag6EmM2Qe/n3XbdlGIi38zj44RLd3/ouk5lU+5gRzrnXlLp1bIfvwdxfd9RQBtZb40rj9N1nCcEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54NES6oc029248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 10:28:07 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B0D672E00DD; Fri, 23 May 2025 10:28:06 -0400 (EDT)
Date: Fri, 23 May 2025 10:28:06 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 2/6] fuse2fs: various filewide cleanups
Message-ID: <20250523142806.GC1414791@mit.edu>
References: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>

On Wed, May 21, 2025 at 03:34:42PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> Clean up the inode reading and writing callsites and the opencoded unit
> conversion code throughout the program.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> Comments and questions are, as always, welcome.

Thanks, applied.  For more details/comments see

https://lore.kernel.org/r/20250523140344.GA1414791@mit.edu

						- Ted

