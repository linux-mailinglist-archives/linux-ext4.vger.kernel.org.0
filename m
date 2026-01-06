Return-Path: <linux-ext4+bounces-12596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B40CF969E
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 17:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8FDE30B6B4B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A730AD15;
	Tue,  6 Jan 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjeJIvMN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235E254B18;
	Tue,  6 Jan 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717390; cv=none; b=aizXYf2kNFA8ARG2hC4avrxIJKUQDQfucfYGeLJHNQE8Je/UXbCKdWWCGEDVacg8fbOji1X4knbHaPJnHy81DZsqX+ivxjkO+USz84G8qfVHMBYsAHAIG0iQT2xFRD7bGbEthfg8r0YLEK3mTWNURFtM6amYfnxHAiImcR+irkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717390; c=relaxed/simple;
	bh=YDUnswj3zAgAUBPNvL5Nb8UuwiZt0aAYaBYhGEo5Wpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om4uNb4f1OQMmf0jZOaVKRJeEuNRjkXm1+eaSVHXdcvdREyCuASTWrDy6hLiKGK76QvCY16p8GOjYFeKUEb/dpQJUa/DKPQ/AMbrbZqxuhIDlLGBObVFomWH6nzEckQEnrCWdddAdDLQFCUfP0iPiVdMKnwzH1BpTnAkdnyYwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjeJIvMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992A3C116C6;
	Tue,  6 Jan 2026 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717389;
	bh=YDUnswj3zAgAUBPNvL5Nb8UuwiZt0aAYaBYhGEo5Wpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjeJIvMNg6jnKhydM4JuG9jsMqRnNoxCZore3iLgl3x8Y/u5DpZboEX9itnoF2a+R
	 Ubd4o47RWoD59pucylomgfEV2oEFyaONZM6IwP6gxzKdN9QXoTjF3c3dsD83vUB+wc
	 YPoes1suckunEtoINFoG0QL0VQiwara6qrg2tpKPQYALELodxqsX6HKWLGPxOu2szS
	 VzfKKGk5L1QPn7sEXkFHU2RCuqX1mH3If1eSV2r0A990hZceo4kMZ99pe7/rdFzlhD
	 0NuHHufj+vgDf2uro/qMYcDTskbInjrjT6Wc3fuQOmMptI7RIVZUMUqn5B4KDRr0fT
	 H6UzN45FGp5ng==
Date: Tue, 6 Jan 2026 08:36:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Glass Su <glass.su@suse.com>
Cc: fstests@vger.kernel.org, Su Yue <l@damenly.org>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	zlang@redhat.com
Subject: Re: [PATCH v2] generic: use _qmount_option and _qmount
Message-ID: <20260106163629.GG191501@frogsfrogsfrogs>
References: <20251208065829.35613-1-glass.su@suse.com>
 <F1D7CB58-C22E-436C-B8C9-26A3F83CA018@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F1D7CB58-C22E-436C-B8C9-26A3F83CA018@suse.com>

On Tue, Dec 23, 2025 at 02:41:50PM +0800, Glass Su wrote:
> 
> 
> > On Dec 8, 2025, at 14:58, Su Yue <glass.su@suse.com> wrote:
> > 
> > This commit touches generic tests call `_scratch_mount -o usrquota`
> > then chmod 777, quotacheck and quotaon. They can be simpilfied
> > to _qmount_option and _qmount. _qmount already calls quotacheck,
> > quota and chmod ugo+rwx. The conversions can save a few lines.
> > 
> > Signed-off-by: Su Yue <glass.su@suse.com>
> 
> Gentle ping.

Sorry, I've been on vacation.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> — 
> Su
> > ---
> > Changelog:
> > v2:
> >  Only convert the tests calling chmod 777.
> > ---
> > tests/generic/231 | 6 ++----
> > tests/generic/232 | 6 ++----
> > tests/generic/233 | 6 ++----
> > tests/generic/270 | 6 ++----
> > 4 files changed, 8 insertions(+), 16 deletions(-)
> > 
> > diff --git a/tests/generic/231 b/tests/generic/231
> > index ce7e62ea1886..02910523d0b5 100755
> > --- a/tests/generic/231
> > +++ b/tests/generic/231
> > @@ -47,10 +47,8 @@ _require_quota
> > _require_user
> > 
> > _scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> > 
> > if ! _fsx 1; then
> > _scratch_unmount 2>/dev/null
> > diff --git a/tests/generic/232 b/tests/generic/232
> > index c903a5619045..21375809d299 100755
> > --- a/tests/generic/232
> > +++ b/tests/generic/232
> > @@ -44,10 +44,8 @@ _require_scratch
> > _require_quota
> > 
> > _scratch_mkfs > $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> > 
> > _fsstress
> > _check_quota_usage
> > diff --git a/tests/generic/233 b/tests/generic/233
> > index 3fc1b63abb24..4606f3bde2ab 100755
> > --- a/tests/generic/233
> > +++ b/tests/generic/233
> > @@ -59,10 +59,8 @@ _require_quota
> > _require_user
> > 
> > _scratch_mkfs > $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> > setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
> > 
> > _fsstress
> > diff --git a/tests/generic/270 b/tests/generic/270
> > index c3d5127a0b51..9ac829a7379f 100755
> > --- a/tests/generic/270
> > +++ b/tests/generic/270
> > @@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
> > _require_attrs security
> > 
> > _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > -_scratch_mount "-o usrquota,grpquota"
> > -chmod 777 $SCRATCH_MNT
> > -quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > -quotaon -u -g $SCRATCH_MNT 2>/dev/null
> > +_qmount_option "usrquota,grpquota"
> > +_qmount
> > 
> > if ! _workout; then
> > _scratch_unmount 2>/dev/null
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
> 
> 

