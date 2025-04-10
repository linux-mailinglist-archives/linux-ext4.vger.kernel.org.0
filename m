Return-Path: <linux-ext4+bounces-7205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBFA84732
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Apr 2025 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5CE9A4955
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Apr 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8D2857E5;
	Thu, 10 Apr 2025 14:55:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B870830
	for <linux-ext4@vger.kernel.org>; Thu, 10 Apr 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296947; cv=none; b=jSQ+TRigaGemT+nhDLgss9zYazpwU31QJUS/BgkUFYViqykL5m9olrLhz+GEsRexgA9ct0MnSQgfcqZ9tcjfPJgvzHthVMFCJzHdpYn8wj1hC4NYcnbMpJo6iTdcQ7Dn8G3wCe/paMDOYnnCitZ5okV5I3goBbv23KpEm9AlIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296947; c=relaxed/simple;
	bh=OBcyd7UqWXZ4ps/4EYJDmB6P/bKOk7nyXS0LA5Zv/yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n12d4fwLcXaZ/hFE2CQ8BpXX8bJsT/m5rCukBvw0k0WZAQJQPDPAf0xgQYf7hoSSYa/jl2/q5HqmXWqPMaY8RVSBUkhr7ycZEiPNCvgX2l+DTBmRC1Tbqn995lue78AJbyBcfufNlzCWfa9r/A8VNzk9DzcJzQfy/AkF0SyQCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53AEtbrc023234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:55:38 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 892212E00E9; Thu, 10 Apr 2025 10:55:37 -0400 (EDT)
Date: Thu, 10 Apr 2025 10:55:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: don't treat fhandle lookup of ea_inode as FS
 corruption
Message-ID: <20250410145537.GD13132@mit.edu>
References: <20241129-ext4-ignore-ea-fhandle-v1-1-e532c0d1cee0@google.com>
 <auitbbb56g2mpb52irzcfh3qfob3qjot3326qpigdvhw7wyw6b@p624krjopkc7>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auitbbb56g2mpb52irzcfh3qfob3qjot3326qpigdvhw7wyw6b@p624krjopkc7>

On Thu, Mar 27, 2025 at 12:04:38PM +0100, Jan Kara wrote:
> Hi Ted!
> 
> was this fix missed?

Yes, oops.   I've applied it now.

					- Ted

