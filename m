Return-Path: <linux-ext4+bounces-7418-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C51A983BE
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7500D176F23
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC10427057F;
	Wed, 23 Apr 2025 08:32:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CC21CC68;
	Wed, 23 Apr 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397138; cv=none; b=KL2ylVtr4i4WVUEwy0eAs2pMcTyQ/AVhxcPEpLe4MNLNWRZ4oVAqiPXZF09MjkVYpdq+YTH6lFtIy5Fqf69B3sYVes+W1OBTApsQlVUNEFI9HuEHsZCgHVp+/LQ/v5vOJNDUpIuBmcA6FKK/r/RFip1nVZlwTcx69/LUmTxtD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397138; c=relaxed/simple;
	bh=RGzzcIzKfCEWfRbVP7vCQQ8Q+HsYzfJUfK9U1dUvFxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCxMpEHxiX4y5PCAhgygLJv26uZZYpvvzMP3v+08aYn4eEMlFJsI0R9XQuKYFRmdIZWmezbFFtctONYaUsJMIyJribY9xYwDB8WocK//+WyIu/BbRdad8yVVzdnEGEvdlkQs/PrznzqFveELvCejwynrORUqKuSOecH4CcESYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2624768AFE; Wed, 23 Apr 2025 10:32:10 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:32:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 15/15] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250423083209.GA30432@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-16-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422122739.2230121-16-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 12:27:39PM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Introduce a mount option to allow sysadmins to specify the maximum size
> of an atomic write.  If the filesystem can work with the supplied value,
> that becomes the new guaranteed maximum.
> 
> The value mustn't be too big for the existing filesystem geometry (max
> write size, max AG/rtgroup size).  We dynamically recompute the
> tr_atomic_write transaction reservation based on the given block size,
> check that the current log size isn't less than the new minimum log size
> constraints, and set a new maximum.
> 
> The actual software atomic write max is still computed based off of
> tr_atomic_ioend the same way it has for the past few commits.

The cap is a good idea, but a mount option for something that has
strong effects for persistent application formats is a little suboptimal.
But adding a sb field and an incompat bit wouldn't be great either.

Maybe this another use case for a trusted xattr on the root inode like
the autofsck flag?


