Return-Path: <linux-ext4+bounces-12370-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B29CBFA92
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 21:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ABD63003F99
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09992EA178;
	Mon, 15 Dec 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mks8kbFE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AE2C21CD;
	Mon, 15 Dec 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827735; cv=none; b=E/3SaeycKXnMY8OcaTqv4RZuXPyiK3Ef8oVxsP13wWZ2ft1XXCY7776NVorx0PZ7bJ1IlEXUIm5GnLsB3IZL8AoAjsTCziJiRlcAG/evjQg2+LpsfrjrbSChtOuIZBr/XVsENcIo0tEo319yR7S1RMJtPl0TayRqdy3oQGTgW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827735; c=relaxed/simple;
	bh=oRFG475j5hJYQo7Blo2TzrpeiLl5Ir4fft5Eu5KDu9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdor3L1UfE/EklKtKzwrfKb+HCsVFbY0KgoJjnrT0QySkK3Mgo3AowFiwbIfiw4nga6jEM3ebSZld6jrXz+iozWduthO+KOb2O+djbEsWUE3bn81h3l6/DaeoDZQI6oerdV33oTwnb8basqKXj1jp+x03+lEfX5txS7aIB5er/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mks8kbFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7997C4CEF5;
	Mon, 15 Dec 2025 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765827734;
	bh=oRFG475j5hJYQo7Blo2TzrpeiLl5Ir4fft5Eu5KDu9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mks8kbFEJIbdXTNYNpZyJbfF63XeiL5ZjLuhfsnafZz0Wl4/vp4iSohhCzXHPw0MD
	 e1BQcOLBTSLNU+lwPBM4rlrO2KLOqmmjz8u3nbKjP0ARc4D5IRVuCRXVwFMWtyT33X
	 XoSdn1BCB0LzZAX8c70NJCHJpb6FSO5WZ3BTvZci61X8SRxof01ZKZz1NtmCvnTk0P
	 KtMBGKEjkT3rOJyACre/dQmQal5qvP5wxjTfA+BTldUTqqgC/ayN1C4TEYhtjw4BCg
	 R6wWlyVz5xv5OkS13ITcSIF1/dEAVacDTF7IEnmuOqsy1um9J96jmFgDiS60fbCEfL
	 dJTL6wtJsumUA==
Date: Mon, 15 Dec 2025 11:42:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] ext4/006: call e2fsck directly
Message-ID: <20251215194214.GO7725@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-3-hch@lst.de>
 <20251212200246.GE7716@frogsfrogsfrogs>
 <20251215052756.GA30524@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215052756.GA30524@lst.de>

On Mon, Dec 15, 2025 at 06:27:56AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 12, 2025 at 12:02:46PM -0800, Darrick J. Wong wrote:
> > > diff --git a/tests/ext4/006 b/tests/ext4/006
> > > index 2ece22a4bd1e..ab78e79d272d 100755
> > > --- a/tests/ext4/006
> > > +++ b/tests/ext4/006
> > > @@ -44,7 +44,7 @@ repair_scratch() {
> > >  	res=$?
> > >  	if [ "${res}" -eq 0 ]; then
> > >  		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> > > -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> > > +		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1
> > 
> > Minor nit: $E2FSCK_PROG, not e2fsck.
> 
> This test harcoded "e2fsck" right above the diff context, so this is just
> trying to be consistent.

Oh right, I forgot that e2fsck has that odd quirk.  Comment withdrawn.

--D

