Return-Path: <linux-ext4+bounces-1818-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675E894A30
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 05:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4922286B58
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 03:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C601759E;
	Tue,  2 Apr 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SiHqWckA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25B1426F
	for <linux-ext4@vger.kernel.org>; Tue,  2 Apr 2024 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712030118; cv=none; b=exuuNVi9LawgH/Q5NCZiZmbrnyu4/j9mShxQhZlTHEStdcD1SQ66zLWMfSc4Susj8DEdW8a9Phag4RfENlGRUkxytwgRXatp0+9Z8GHdXev9olezRz8mbGNwbnAw/nTJL7ysZf6Mw90F21VOxjyDZmLXVtpxmu69lYp2Jeee+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712030118; c=relaxed/simple;
	bh=TxgPK3t8qTIp8s7+dz2T3zXN7rUHW/wGDIy6qjBQd0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utSBqmozjwH5P3x2Nljt0EegBzLaQWQ2m/qo3dQWPDawH6HIRcYEC9iuDjsmbQ2QVL0R0T2XWqVC4viffRF4MQKo0QH8obKogwrLBPbaBc1ciTAm4cQEzDDSa3I/YBuO9iAMnJKL65zG1GZXQYwhZ10aS6w5rD3UcQwW/j1SPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SiHqWckA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-232.bstnma.fios.verizon.net [173.48.113.232])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4323t2OM027928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 23:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712030108; bh=2FWI5HTUPKIrmfRUocgz+rQZxloeVKb2yYFnmd5HQD4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SiHqWckAMuuNEzkMnQfSWtSFwVdVl8BRV9TbieE4hqLCGsAcG0PGNH5oP4QHSGZE6
	 CC0GpcZLuYnK3DNwuB1mdoQXAj26ea+TM51KE4Jz4zYfts6KUG+xC2Vck3+4w1HSDp
	 SGGxlg32stqtdcsjZeTBwmTmoT36WYvGJTlNjoZ1ABIo0JrFhBeZiKH9xXLD4CFqWp
	 jpeiIx/MxAzGaZixyN6Tve0mfPQHEdNWES8B+T3bkf3nfl+dVLujbMyj/IZSwRTRjS
	 QNXt/n16Wh0o1KzqgWMsjy/jJyQsTdiSYO9JqyDUmDVLSDw0zu0DZYxtgIWqXREQTG
	 R+NCIyPQwwyZg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 62EF015C00DC; Mon,  1 Apr 2024 23:55:02 -0400 (EDT)
Date: Mon, 1 Apr 2024 23:55:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Li zeming <zeming@nfschina.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: extents: =?utf-8?Q?Remov?=
 =?utf-8?B?ZSB1bm5lY2Vzc2FyeSDigJhOVUxM4oCZ?= values from path
Message-ID: <20240402035502.GC1189142@mit.edu>
References: <20240402024140.28456-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402024140.28456-1-zeming@nfschina.com>

On Tue, Apr 02, 2024 at 10:41:40AM +0800, Li zeming wrote:
> path is assigned first, so it does not need to initialize the
> assignment.

That's technically true, but the compiler is perfectly capable of
optimizing it out.  So it's harmless, and removing it does make the
code a bit more fragile, since it needs to be set so that the cleanup
code doesn't accidentally dereference an uninitialized pointer:

out:
	up_read(&ei->i_data_sem);
	ext4_free_ext_path(path);
	return ret;


So if later on, we add code which does a "goto out" on an error,
before path gets initialized, that would be bad.  So removing the
"unnecessary" set has no upside, and it has a potential disadvantage.


	      	      	 	     - Ted

