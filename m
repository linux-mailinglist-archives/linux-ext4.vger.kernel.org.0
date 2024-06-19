Return-Path: <linux-ext4+bounces-2899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4D90F9CF
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 01:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBAD281C52
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 23:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984A15B0FE;
	Wed, 19 Jun 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="arDlJHcd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEDF9E8
	for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2024 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718840227; cv=none; b=PrmOZpUVGbQLk5kgnSGZyKZqW4IDbJv4ZD9DaV050pVUGVM+0+/sjZIPf1WugFoEVgNrpGcPJRqpHEIfIpH5g7F40Inq3kJGqMtB3rXUJz6o0wpw26Ut+bXwe0A1I9RkZwqEvov2d1M5QNyvX3RZBjBmPjOHr4D9cCqbWIOpQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718840227; c=relaxed/simple;
	bh=hhQzkIdIZJWtJyELMkI+FL5WIBBaGxz1pnWWaPKMQqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGO0fm4FALnBJmtmvSjwQ86t2BSYym7evPJWpUThvCI02RPS3u7o6UJ7UW9X4giHx9nm16yHTkd8VRNgkEYddVErvkf6AnXum/mHQ1U4tnLrLdjUXxQs4vDbzfS/tDQ3Tb0F/4xxi8ACCdBXcHsS+HyLJopLSlwlX9VSN6N34Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=arDlJHcd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-239.bstnma.fios.verizon.net [173.48.120.239])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45JNatc1031807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 19:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718840217; bh=693oF+gJXs8dsL8wEgBD9QOR5aboL0TKuitQKGX/EZk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=arDlJHcdNjH313wjJDGiO+wmLD5+VPypyu4UvLPxCOez7gsMEI/SXiJhrcWwcue5s
	 gY22AoHOCCFcqDWVao+EG96r1k4+Z/dRZiYMYqT+5rS3903ojqmQe9qIQZbiNvHVhZ
	 zA2AyeLDeqovNAux23wCtxkIZdQX0ZEiKK+6eZm7O7oeXb9a9Y4y1aTSknC3Vu3Li2
	 BbbB9kDpJL8mkPJnYJaLjBGR/BBv9M5U8gSvVywtzqoiOBt2YK+omSdlK2gl1X0Xiz
	 3Ut/5qEz8CpRyy6jetaUX13vCnNhKOJ4D0AcuzR5TjH8CJgCCLc6fcjMbSKSA2jIUd
	 DTxKgMmtBa9Yg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9310015C0579; Wed, 19 Jun 2024 19:36:55 -0400 (EDT)
Date: Wed, 19 Jun 2024 19:36:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Wang Jianjian <wangjianjian0@foxmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: Add a comment for incorrect tag size
Message-ID: <20240619233655.GC981794@mit.edu>
References: <tencent_1D453DB77B0F2091CB4A68568A77627D4E08@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1D453DB77B0F2091CB4A68568A77627D4E08@qq.com>

On Thu, Apr 04, 2024 at 09:36:54PM +0800, Wang Jianjian wrote:
> journal_tag_t has already counted the checksum size, however, for
> compatibility reason, we don't fix this bug and keep it as is.
> 
> Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>

The csum_v2 layout had a number of problems, which was documented in
commit db9ee220361de:

    jbd2: fix descriptor block size handling errors with journal_csum
    
    It turns out that there are some serious problems with the on-disk
    format of journal checksum v2.  The foremost is that the function to
    calculate descriptor tag size returns sizes that are too big.  This
    causes alignment issues on some architectures and is compounded by the
    fact that some parts of jbd2 use the structure size (incorrectly) to
    determine the presence of a 64bit journal instead of checking the
    feature flags.
    
    Therefore, introduce journal checksum v3, which enlarges the
    descriptor block tag format to allow for full 32-bit checksums of
    journal blocks, fix the journal tag function to return the correct
    sizes, and fix the jbd2 recovery code to use feature flags to
    determine 64bitness.
    
    Add a few function helpers so we don't have to open-code quite so
    many pieces.
    
    Switching to a 16-byte block size was found to increase journal size
    overhead by a maximum of 0.1%, to convert a 32-bit journal with no
    checksumming to a 32-bit journal with checksum v3 enabled.

We switched to using csum_v3 in 2014, in Linux v3.17.  So most recent
LTS kernel which used the v2 csum format was Linux v3.14 which EOL'ed
in 2016 --- a full eight years ago.  So it's probably not worth adding
the comment at this point.

In fact, what we might want to consider is yanking support for the
CSUM_v2 and CSUM_V1 at this point, since *all* currently supported LTS
kernels (4.19, 5.4, 5.10, 5.15, 6.1 and 6.6) will be using CSUM_V3.
It's not actually *that* much code, but what's there is a bit hard to
understand since it very much relies on how the v2 and v3 data
strutures line up with each other, and the fact that the jbd2
structures are stored on disk in big_endian. 

						- Ted

