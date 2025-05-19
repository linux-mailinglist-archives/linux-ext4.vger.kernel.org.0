Return-Path: <linux-ext4+bounces-8019-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3943EABC2D2
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C2B7A9FD7
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3828136F;
	Mon, 19 May 2025 15:48:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9173EA63
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669694; cv=none; b=Sd9PNZjIQo5ySO1xlPygPi9+3yCDJX72YXCsi5T+58htsSHHC9WfILc7Zbw1Jy8m+CvKa/4hhd9zNmZH7mhezmPM9eoateqJRA/tf2SmsHvdyi4vdZtBpMJ97m50FoJE1fp9p6vxIg7Fsjq7sXTgtUMIQJ8B6CLSc63ddk7x3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669694; c=relaxed/simple;
	bh=i/TEzOxZq8ZPSh0BGuxJ9vEl1OKjCILM/KJe/XrNNVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUFZtn3+FqtoKCZN+LrCldUY72kHWWKJ3Qqkg2Az7jhrcGcVcPqWVc1W3rHqXTYQmeWiT9gCisfkYtGmpricvn7iQice9ekgeDJUccFvx6Dse79hOvYF7wa5B7c92qr49WoazNuTlyKsnkDXSD1XkbHxkBhkC/BnUNvhfp1RQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JFlswL016846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 11:47:55 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D3D2D2E00DD; Mon, 19 May 2025 11:47:54 -0400 (EDT)
Date: Mon, 19 May 2025 11:47:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 0/7] ext4: Add multi-fsblock atomic write support with
 bigalloc
Message-ID: <20250519154754.GC38098@mit.edu>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <877c2cx69z.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c2cx69z.fsf@gmail.com>

On Mon, May 19, 2025 at 03:37:52PM +0530, Ritesh Harjani wrote:
> 
> So, thanks for taking care of that. After looking at Zhang's series, I
> figured, we may need EXT4_EX_CACHE flag too in
> ext4_convert_unwritten_extents_atomic()....
> 
> Other than adding the no cache flag, couple of other minor
> simplifications can be done too, I guess for e.g. simplifying the
> query_flags logic in ext4_map_query_blocks() function. 
> 
> So I am thinking maybe I will provide the above fix and few other minor
> simplfications which we could do on top of ext4's dev branch (after we
> rebased atomic write changes on top of Zhang's series). Please let me
> know if that is ok?

Sure, that would be great.   Many thanks!!

						- Ted

