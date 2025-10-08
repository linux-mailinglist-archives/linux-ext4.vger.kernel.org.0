Return-Path: <linux-ext4+bounces-10664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B5BC4D4E
	for <lists+linux-ext4@lfdr.de>; Wed, 08 Oct 2025 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914883ADDC0
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Oct 2025 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E084246BB6;
	Wed,  8 Oct 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Ryo4qDWO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4295B3F9FB
	for <linux-ext4@vger.kernel.org>; Wed,  8 Oct 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926869; cv=none; b=Xt0CMWEjRO01kH7+Pz8smPpN0q+chu58pKU1XrCVQObBLUoTyfvr/i/BLsn2dU4wUYcG4nH53vSIxz+eObJpks280i94CbzwgvyuV/eTmR8CVaEuukuwGCZhbYcIncdRsPOO3ASEKprfd5Ehae18o9IY3ImtqDkkQAuqjreV9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926869; c=relaxed/simple;
	bh=jgEzSxINTIZJtclL3ZuzKIHVsr2ZowkVcF0qd+LuNE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBxcXfBZGmtrrYebUtyPJLPnJx0hu/4R83JK84oGLAGVTYiKC3Is0D53xrZlNuZ04wt3im1YVZgxt1YVFuJma2ShVowNjLpMToFtKYR0Te+OEU2DTHiPcA6YqbKFnGa/qSni26G1DloRaLlbAt/3jOc3D3q1Qu3ZE83HkxSlnQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Ryo4qDWO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-192.bstnma.fios.verizon.net [173.48.102.192])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 598CYIWc004151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 08:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759926860; bh=XIDjaLI0bE4E53qZZ2BHdDlR9SQQHT0rhwDuZQyRrys=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Ryo4qDWObpI97pLzDabWWYCP5cA446QykPVRVwB6qGral9BexNwz5G1Spw/a2ZzO7
	 +q2Bw9YwjQoRlLugJAqvQVQHliEWueMepdy7YpncrE7+bmeXkBF0JZpfeKJZHDEfHE
	 y8bPpmctq7FRdNM0rCMCRvwCrayQf0h+NuxAfI+vZW89PMxmOAaDGoYi7QpRNe8xQl
	 Bq0BXsSPOrbmOtWp2hsokQhX5zqhJeZZLW13JmydW+s63IGoMLVOMcU6VsaOl2+We5
	 3k35oHaJU64rGWEk186F9Jhln8m75kUGci4zO397dexRX9ipY8OfPGo07XEGg6xb1z
	 rJ6yrFFf9E+AQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 259222E00D9; Wed, 08 Oct 2025 08:34:18 -0400 (EDT)
Date: Wed, 8 Oct 2025 08:34:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
        skhan@linuxfoundation.org,
        syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
        Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH] Fix: ext4: add sanity check for inode inline write range
Message-ID: <20251008123418.GK386127@mit.edu>
References: <20251007234221.28643-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007234221.28643-2-eraykrdg1@gmail.com>

On Wed, Oct 08, 2025 at 02:42:22AM +0300, Ahmet Eray Karadag wrote:
> Add a simple check in ext4_try_to_write_inline_data() to prevent
> writes that extend past the inode's inline data area. The function
> now returns -EINVAL if pos + len exceeds i_inline_size.

The commit description doesn't match with what the patch does.  The
patch changes ext4_write_inline_data_end() and not
ext4_try_to_write_inline().  Ext4_try_to_write_inline_data() called
from ext4_write_begin(), and it does this:

	if (pos + len > ext4_get_max_inline_size(inode))
		return ext4_convert_inline_data_to_extent(mapping, inode);

So the write extends past the inline data area, in ext4_write_begin(),
it will have already been converted to a non-inline function.

The ext4_write_inline_data_end() function is called from
ext4_write_end(), so you need to figure out why we hadn't configured
the file away from inline data in ext4_write_begin().

> Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8

Did you just randomly bash the code until the syzbot reproducer
stopped failing?  Please try to understand the code and the failure
much more deeply before attempting to change the code.

Cheers,

					- Ted

