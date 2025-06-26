Return-Path: <linux-ext4+bounces-8649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04906AE94B7
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 05:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABB3A49F5
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jun 2025 03:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06731EBA14;
	Thu, 26 Jun 2025 03:51:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76343159
	for <linux-ext4@vger.kernel.org>; Thu, 26 Jun 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909894; cv=none; b=CTG8UtsWEmh90V8KdgYEFbH3OLzePsK3zGPR28lXdnXExoOmLLNG07d3qTlMmE8AL4O71iea1gwJL2DWoZDp4Qx/FXEmj6k6U6rno6ySvH9G7J+2QS745r9VtQUAKmbHqXUurOVF8d2ABXu18IJ6OGzUgUXnmsJQrvXOHSPJW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909894; c=relaxed/simple;
	bh=JYfr8hvw2247ZAEKYiu94IuzMfbVgKEUw2nztG6r+DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONXjeImrSq09NW5vwASvRykmz8KAAaXfq+P6Dc8my5RcrJ/pKasrbqWbRZWWuUNUEXEXjj2sYwvg13VsI6GOkK79JpfyMk4PxAaUkIbvV5UR7oGH/eD/4khmOp4tT7i/9vpKU42uIC6RolC47Y0+ShtbHrAzd0t+hqE+iIMByLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55Q3pPL3025996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 23:51:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 35E712E00D5; Wed, 25 Jun 2025 23:51:25 -0400 (EDT)
Date: Wed, 25 Jun 2025 23:51:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250626035125.GA198321@mit.edu>
References: <20250625212022.35111-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625212022.35111-1-leah.rumancik@gmail.com>

On Wed, Jun 25, 2025 at 02:20:22PM -0700, Leah Rumancik wrote:
> There is a descrepancy between the fsck flags for ext4 during
> filesystem repair and filesystem checking which causes occasional test
> failures. In particular, _check_generic_filesystems uses -f for force
> checking, but _repair_scratch_fs does not. In some tests, such as
> generic/441, we sometimes exit fsck repair early with the filesystem
> being deemed "clean" but then _check_generic_filesystems finds issues
> during the forced full check. Bringing these flags in sync fixes the
> flakes.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Looks good to me, although I might suggest ammending or just dropping
the comment:

>  	# Let's hope fsck -y suffices...

... since obviously, for ext[234] it wasn't sufficient.   :-)

    	  	     	 	     	    - Ted

