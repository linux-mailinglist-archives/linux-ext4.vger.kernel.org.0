Return-Path: <linux-ext4+bounces-9942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792E3B540C5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 05:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E833488592
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876942264C8;
	Fri, 12 Sep 2025 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="oXCM2FST"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1253227586
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757646865; cv=none; b=nxlx6r/V3TIdQ8pHmVBavjk1GirGhmwFUOGttVT3EVRPrSmT3QYWwYBuGFx2I0nI8vlvDWqZrY/jnoTf6mqdxwzGi+tnm+KdnnxhbTiir6uFtbSUIZyEjInEAfNmBUX8apQapIbFIDIacTlGKckUjopHPlkCrQdorHP8CpGc/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757646865; c=relaxed/simple;
	bh=hE0OrtHBHlvVM9UZyEucxr02fzKnGcK+pN8A6Rim25M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5l22t5ILjnooth0n0wleWmHtxKJv0dib+VaP2gerrwzA1EsfsP8Zz8POZUwcpFJ2Cu4KYi9QkD3LpvQ/sNXcXMZn6hW//x/JS0dauNoy0Zr9Zu0xWuQY8xQgTlM5xrPvkXAMrYcNliAOyuXVJtaDsFme6i7jp4u7KNILqDKypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=oXCM2FST; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-47.bstnma.fios.verizon.net [173.48.111.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58C3EEiU027537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 23:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757646856; bh=yx5FCXfGM5c3BQwly0bs+7iw7ycW0pAe794J392hgs8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=oXCM2FST6yg6MhTFOmScZ2d0wyQx9cbTNsYQTUQYpdB5vAvVTlOeieQ0m9vke/j+g
	 24jJyZzq//E2jiW7wglaygvEt/t7d2Y9NhJfKFRWNCpHWJIi5k5Ht+BAMQ/hu26yvH
	 czSeO+zfRG/0xkcZuc3FxaS+OCq8+8+auUAM/VOySfPklkPTu9OieRAiL0X6fW7Mu5
	 d+nyWS81VnhQm+hb9JBWzA2qiNMIxt5hHpJO+czf5sPznd7lXLBAR3A7rFe4suvU92
	 OOkGrLJa9yjA+JDedAyDkMK9fPARHskfBr9S5lWfLbN+p3roYNVsUB1AkAATdC9t2J
	 fDq8HJ1QI6FWA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 926BD2E00D9; Thu, 11 Sep 2025 23:14:14 -0400 (EDT)
Date: Thu, 11 Sep 2025 23:14:14 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: implemet new ioctls to set and get superblock
 parameters
Message-ID: <20250912031414.GD3703006@mit.edu>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
 <20250908-tune2fs-v1-3-e3a6929f3355@mit.edu>
 <20250911224019.GE8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911224019.GE8084@frogsfrogsfrogs>

On Thu, Sep 11, 2025 at 03:40:19PM -0700, Darrick J. Wong wrote:
>
> What's the difference between _FL_FEATURES and _FL_EDIT_FEATURES?

We have three sets of 

_FL_FEATURES allows the user to set the features via:

	__u32 feature_compat;
	__u32 feature_incompat;
	__u32 feature_ro_compat;

... while _FS_EDIT_FEATURES allows the user to set or clear specific
feature or feature(s) using these fields:

	__u32 set_feature_compat_mask;
	__u32 set_feature_incompat_mask;
	__u32 set_feature_ro_compat_mask;
	__u32 clear_feature_compat_mask;
	__u32 clear_feature_incompat_mask;
	__u32 clear_feature_ro_compat_mask;

I originally only implemented _FS_EDIT_EFATURES but it turns out that
given how tune2fs() and e2p_edit_feateurs2() was implemented,
_FS_FEATURES was a lot more convenient.  But I kept _FS_EDIT_FEATURES
in case some other users wanted an easy way to, say, "just enable
feature X" using a single ioctl.

> > +#define EXT4_TUNE_CLEAR_COMPAT_SUPP (0)
> > +#define EXT4_TUNE_CLEAR_INCOMPAT_SUPP (0)
> > +#define EXT4_TUNE_CLEAR_RO_COMPAT_SUPP \
> > +		(EXT4_FEATURE_RO_COMPAT_LARGE_FILE |	\
> > +		 EXT4_FEATURE_RO_COMPAT_DIR_NLINK |	\
> > +		 EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE |	\
> > +		 EXT4_FEATURE_RO_COMPAT_PROJECT)
> 
> Is it actually safe to clear these without scanning the filesystem to
> make sure nobody's using these features?

Hmm.... probably not.  For some of these features, tune2fs will issue
a "pleas run e2fsck -f" before mounting the file system.  All of these
featrues tune2fs will allow being cleared on a mounted file system,
but looking at this more closely, I probably *shouldn't* have allowed
tune2fs to remove the feature wile the file system is mounted.  (For
example, tune2fs -O ^project" will try to clear they project quota
inode even if the file system is mounted, hilarity would soon
follow...)

						- Ted

