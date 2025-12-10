Return-Path: <linux-ext4+bounces-12263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B449ECB27E6
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9554330262A9
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E54305064;
	Wed, 10 Dec 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RcB2erev"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06A7082F
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357551; cv=none; b=L0L1TFUFDUZzPR5jYTLQmXNcZ+gRSa6JKiEeWdtNxRCFwsmRxcMl2Uz3ce+uUliAUzyPXs57ylUSUx9EjuSOzwQOFgt+JZPt96Wkumw1ozbDqPAH2GTKG5srA2/XyU8xASWsPkQT8QONcaWZtAy/flCy6L/6SN4LmhqkGgvs7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357551; c=relaxed/simple;
	bh=xFiNqyw63/T2sJ+EzYCCg3BLcQSfyJKuEJOhH74W6Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+hvyGbfCwXvHTgo/OJhk/96UUO3rMourgkdsLTc9AudDSWmS/kSsULD8Rf4lHij1sXrbXptwmnd3vU7poP1Y50qmzAbvFGfndyAz51hpWf48wOl4tFHYMoqIh9sscRINAM1rRD046K0NA62ufTQgtm9BVL14lbKcvXMljQN4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RcB2erev; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BA95arX012649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 04:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765357541; bh=mMbiTsB+J6/HL38mMmy50qyTTnX6A2LNtt/Iqp0+j80=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=RcB2erevVB3wGgkPOHBCFZfy0th2RtoSOUHVLJ76j2o8l/pFZduEVrqnNg2cX5bnk
	 VdNBs3+3DdyfKhiQb3yObLDUu4IGs59xKrxCz7Ku+G5K+SZwKtlyajIadjVchfDLxH
	 Dmjq2faaM61rQ2iNtWeuQPi6bddAL7LcsSmQwp1nUYqGK4WeJxE1mcjw3Sx8Xqg2hx
	 KmspFq+eJO50oIYmzxa1ZxOaezuRabiuV5Z9bIEiijHmGC4vAPbx+6maZgwcZ/R8zK
	 IlMav691SPKvw4F5YJZIJhdXn4d9MnGe5xTq9/0b89IJnc0V6FUscFC86l+p6mJg2U
	 7EWjq1hhSJkvA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 20B804F8132B; Wed, 10 Dec 2025 18:05:36 +0900 (JST)
Date: Wed, 10 Dec 2025 18:05:36 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: Winston Wen <wentao@uniontech.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <20251210090536.GB42106@macsyma.local>
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>

On Wed, Dec 10, 2025 at 03:02:11PM +0800, Winston Wen wrote:
> We are aware that workarounds like wrapfs can be used to support longer
> filenames, but in practice, this approach is not ideal for seamless
> user experience. We are therefore curious whether it would be feasible
> to implement built-in support for longer filenames in ext4 itself.

I don't think wrapfs can be used to support logner file names, because
the limitation is quite fundamental.  For example, the glibc
definition of struct dirent (which is returned by the readdir() system
call) is as follows (from the man readdir page):

           struct dirent {
               ino_t          d_ino;       /* Inode number */
               off_t          d_off;       /* Not an offset; see below */
               unsigned short d_reclen;    /* Length of this record */
               unsigned char  d_type;      /* Type of file; not supported
                                              by all filesystem types */
               char           d_name[256]; /* Null-terminated filename */
           };

So how you might store the longer file name isn't really going to
help, the problem goes far beyond the question of where this might be
stored on the file system.

					- Ted

