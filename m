Return-Path: <linux-ext4+bounces-7543-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B23AA0F6C
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D18E1A8529B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9AA21ABAC;
	Tue, 29 Apr 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syWts1Qu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401381C5D4B
	for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937977; cv=none; b=OMcALPPBKBV9lHjmcN11WL9N+ihagGLgUVpXRCDi4x5Bu9YsCY9Weu8VwM6DcPJ5oBj/E9esjcJD4AU0AptDudbZjfuACwCwHSDSvQ+RDH8bylM4lZ+LO6S4kUmVuLmSkXh7tPFqVq29at4R3yhFvEl8RXPx2g8oUs7q3Jd1S4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937977; c=relaxed/simple;
	bh=3zBpt5Czfg5OmiT4ahhmjmXOZFShN3udc7YsKy02LFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHUTv/hRg87IBW9EP7mIHcKoR09IF0PWSOGrbcf9Z0rC3v1fkzb4wrqH4+kvC/MRmKeHg/pf6NMRlrxSFA4EkmJnIswXK9MxfY8kRtzGl8zCS27GiQEx7EnWnfzgbCNWDnfBqel2GiJKjXJv2iBX3KwGuVB7OEVlH6x2CoymWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syWts1Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3797C4CEE3;
	Tue, 29 Apr 2025 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745937975;
	bh=3zBpt5Czfg5OmiT4ahhmjmXOZFShN3udc7YsKy02LFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syWts1Qu4sgwKLRPmzJS8WWfvoujpjYxvIAgy+STryhG8YX3qw0C/Nu8qi0cW0nAE
	 5Ofm28IJ0bhpyaZ7AAR5hX/Pd9stsTGy/uO6ZMksfWp6aqcBuJeU8u57S7kUZKITZR
	 +ZAoV8z1oFHo82x8SU9Z23kO4sTvinOzMbai2gHDbgSymGF2JtUvQJk7hxo4hlMGXj
	 g+SHnS5rAa9udX4tkQZKc/FVnF/TblmQrAH8kVRUeAgvzWOKPvCaMp2682ga7sH6kO
	 DSHnuJckdc5zQ4z3uALXJWgZntvBfvpQnnKmHhPFewZxYJyAV/tX92rJaermzwGkbl
	 s1QKW2jqpQ5cw==
Date: Tue, 29 Apr 2025 07:46:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Zakrzewski <jozakrzewski@microsoft.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Question about fsck for ext4
Message-ID: <20250429144615.GE25655@frogsfrogsfrogs>
References: <DS1PR21MB4166208B2E5F4D23F547E349DF802@DS1PR21MB4166.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS1PR21MB4166208B2E5F4D23F547E349DF802@DS1PR21MB4166.namprd21.prod.outlook.com>

On Tue, Apr 29, 2025 at 01:25:35PM +0000, John Zakrzewski wrote:
> Hi! We are using the k8 utils opensource
> project(https://github.com/kubernetes/utils) and looking for your
> thoughts on an issue where fsck is being run on every remount and if
> this is necessary for journaling filesystems.  Eric Sandeen's comments
> here(https://github.com/kubernetes/utils/pull/132#issuecomment-605492335)
> indicate it is not but wanted to verify with you that his statements
> apply to ext4 as well.  Ultimately I am looking for reassurance to
> relax the need for fsck on mounts for ext4.  I look forward to hearing
> your thoughts and please don't hesitate to ask clarifying questions.
> Thank you!

Running fsck on any journalled filesystem shouldn't be necessary if
they've stopped the practice of snapshotting unfrozen filesystems.

But these days, maybe you /want/ to run fsck in dryrun mode to detect
maliciously corrupt filesystem images before mounting them?

--D

> John Zakrzewski
> Software Engineer
> Azure Core
> jozakrzewski@microsoft.com
> 

