Return-Path: <linux-ext4+bounces-7627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661ADAA73C0
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2458163F6D
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F57255F2A;
	Fri,  2 May 2025 13:33:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DB25525E
	for <linux-ext4@vger.kernel.org>; Fri,  2 May 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192815; cv=none; b=OF1igrShUPZoGtSxclebarJD7L+Yv0TJvdH/Vbk2cwUkgxpRNhzUZ6FwJ8NotCyf8Hss9KlTNdGqFLHn03zctJFzNxdKn0ROAB47YbAobxWML/UotkJJYq5LMWrPoEF/s8BGixGHaXay5jrggh2qCBvNzrCXvk7enW9qsnC5tNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192815; c=relaxed/simple;
	bh=YX3L0lHArVa4cEVT5SxJ3DOMDbZYRO/IgKsEnba4x6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb23ukvbG9kxmxdq+nKG21B5YqwXmqfz+Ucg1WVOxdC9akNmswZYDKQyQzlhnqFWws31JQnE1djvLnBsdPcYLrWAgT1rj2XNsxVvOmAPjI+BfAhsxmNMThJOZLJYic1dU7DRKiQMAZ8iWiJnAbIdMkFMwGGnQHYcA/2J27pYfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 542DXAYE000384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 09:33:12 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E2FE62E00E9; Fri, 02 May 2025 09:33:09 -0400 (EDT)
Date: Fri, 2 May 2025 09:33:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>, hch <hch@lst.de>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4/002: make generic to support xfs
Message-ID: <20250502133309.GB29583@mit.edu>
References: <20250502113415.14882-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502113415.14882-1-hans.holmberg@wdc.com>

On Fri, May 02, 2025 at 11:35:01AM +0000, Hans Holmberg wrote:
> xfs supports separate log devices and as this test now passes, share
> it by turning it into a generic test.

Was this fixed by a kernel commit to the XFS tree?  If so, could you
add a _fixed_by_kernel_commit pointing at the fix?  And while you're
at it, could you add:


[ $FSTYP == "ext4" ] && \
	_fixed_by_kernel_commit 273108fa5015 \
	"ext4: handle read only external journal device"

to the test?  This will make it easier for people using LTS kernels to
know which commits they need to backport.

Many thanks!

						- Ted

