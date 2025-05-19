Return-Path: <linux-ext4+bounces-7958-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89CABB3A6
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 05:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D617C16F388
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62A1E2853;
	Mon, 19 May 2025 03:27:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2688F54
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747625231; cv=none; b=gViQUQLS9qdnjkSDBF+O4ULJbu7sOkV2m+qD3qknhnLv248azo9m7EEBpBUBjEBBxfwe4CXDQIHYhKjwY+sUh+fhJd5MB7CKww0wTUx9egrNfLCCVwgF5EwKZqdEbFJ/zMSr9dUqX/ej3AK2RJkyRLET1MbEZE00nXg8sPqXBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747625231; c=relaxed/simple;
	bh=MnHL586hl1+9lImPZNL2KvXxymDu5tTM7SgU9zbzoXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRCd3i/0BJYqMvdBh5CoDVhwrq6Ek6yn5Jn3IllEpK2GOBTgfH9T+dMdRTmJG8m0vMjF7XCdmHzI908Pb2HCPCffWGf+TztNFjg+yxXAOYuQz39NontzZRIvpwlNjRDMpFdLMra1RpoTIu4or2XRfzpzbjTdLQu9GJs3rDzfkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54J3QgfD013812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 23:26:43 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7A8222E00DD; Sun, 18 May 2025 23:26:42 -0400 (EDT)
Date: Sun, 18 May 2025 23:26:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: replace strcpy() with strscpy() in
 ext4_init_dot_dotdot()
Message-ID: <20250519032642.GB158804@mit.edu>
References: <20250518-ext4-strcpy-v1-1-6c8a82ff078f@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518-ext4-strcpy-v1-1-6c8a82ff078f@ethancedwards.com>

On Sun, May 18, 2025 at 12:48:50PM -0400, Ethan Carter Edwards wrote:
> strcpy() is deprecated; use strscpy() instead.

We never actually needed to use strcpy here, actually, becase de->name
is not NUL-terminated.  Instead, we have de->name_len which tells us
how many characters are in a directory entry's name.

So we could just as easily replace:

	strcpy(de->name, ".")

with

	de->name[0] = '.'


and

	strcpy(de->name, ".")
with

	de->name[0] = de->name[1] = '.'

.... if you really want to get rid of the evil strcpy call.  As it
turns out, it's super easy to assure oneself of why what's currently
there is safe, but you really want it to go away for religious reasons
then you might as well do it in a more performant way.

Also note that there is a similar use of strcpy() in fs/ext4/inline.c.
If you really want to "fix" things in fs/ext4/inode.c, you might as
well fix it in all of sources files in fs/ext4.

Cheeres,

					- Ted

