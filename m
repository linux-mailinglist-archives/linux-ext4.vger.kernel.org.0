Return-Path: <linux-ext4+bounces-9750-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE15B3A3A2
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF98981460
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE542261B99;
	Thu, 28 Aug 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WERgi3vV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF751F1932;
	Thu, 28 Aug 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393746; cv=none; b=QaxTl7LK4sGMAEfXsXdU78lyykrV2FIImSKP2l8fmle95De1I1YDLrORQRPBl/9dNIxHNCIOuAX1UkhNhOdyj2jYoE7X9l3+9fAdRX/Junb1KRneGvZJv55+9AUfVVSxnULrwDckJ01okqTN8+c6Qd4fgTyyR9WKIYOERnJkE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393746; c=relaxed/simple;
	bh=QEhPD3tD6vGrwgq2uVTV2AuL5VvNwkicFuwxTV3BCGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqeeiTq8UyG9c8rV8SzvUym8L4fu8SDkV6Cy2YTy5iHaP3r26/VQ34nGfJPfCnR3rKnOewx66R5vduHTOGZOy74hQnqf+VbMEY5jjNkT5whKtLgZSHNX4NlyUC4GkBLStVDz9wNQlmg3VYgUf3rEmf1ZifipgdYhxawkgNHE0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WERgi3vV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB0EC4CEEB;
	Thu, 28 Aug 2025 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756393745;
	bh=QEhPD3tD6vGrwgq2uVTV2AuL5VvNwkicFuwxTV3BCGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WERgi3vVXd6KrtqqApFxR/6rIbIBAQV9x0UP1MfDhrwrSKrjOsoDiBYrpVAdu24sk
	 SAyo0r7WvTgO2z6fTUleWEkNZwfluPadR3eOdPDHhWWBKe69A/Rzlp0/FedS2oyXhS
	 OK/IQiPMn1MUL92vrtUUeWc44fJt8s1vCsYmxZUxIkpIBQyLDC5vyaR3cMC/jF5RU6
	 u/R2zzWKbqmb/G3jEl3PIT6vnIGxZRhDdmeUIwtnP37lW3XFzUz0kZDO3TL2oo5Lh5
	 EpJ6H2XWsADYzzdnW83NoFvlHVqMzWEJtD8/L1nqYFbVq5T7yWjLT3iA9sNrKFicWE
	 8xCA2wrFRVRLA==
Date: Thu, 28 Aug 2025 08:09:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250828150905.GB8092@frogsfrogsfrogs>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Wed, Aug 27, 2025 at 08:46:34PM +0530, Ojaswin Mujoo wrote:
> On Tue, Aug 26, 2025 at 12:08:01AM +0800, Zorro Lang wrote:
> > On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> > > The main motivation of adding this function on top of _require_fio is
> > > that there has been a case in fio where atomic= option was added but
> > > later it was changed to noop since kernel didn't yet have support for
> > > atomic writes. It was then again utilized to do atomic writes in a later
> > > version, once kernel got the support. Due to this there is a point in
> > > fio where _require_fio w/ atomic=1 will succeed even though it would
> > > not be doing atomic writes.
> > > 
> > > Hence, add an explicit helper to ensure tests to require specific
> > > versions of fio to work past such issues.
> > 
> > Actually I'm wondering if fstests really needs to care about this. This's
> > just a temporary issue of fio, not kernel or any fs usespace program. Do
> > we need to add a seperated helper only for a temporary fio issue? If fio
> > doesn't break fstests running, let it run. Just the testers install proper
> > fio (maybe latest) they need. What do you and others think?

Are there obvious failures if you try to run these new atomic write
tests on a system with the weird versions of fio that have the no-op
atomic= functionality?  I'm concerned that some QA person is going to do
that unwittingly and report that everything is ok when in reality they
didn't actually test anything.

--D

> > Thanks,
> > Zorro
> 
> Hey Zorro,
> 
> Sure I'm okay with not keeping the helper and letting the user make sure
> the fio version is correct.
> 
> @John, does that sound okay?
> 
> Regards,
> ojaswin
> > 
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  common/rc | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 35a1c835..f45b9a38 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5997,6 +5997,38 @@ _max() {
> > >  	echo $ret
> > >  }
> > >  
> > > +# Check the required fio version. Examples:
> > > +#   _require_fio_version 3.38 (matches 3.38 only)
> > > +#   _require_fio_version 3.38+ (matches 3.38 and above)
> > > +#   _require_fio_version 3.38- (matches 3.38 and below)
> > > +_require_fio_version() {
> > > +	local req_ver="$1"
> > > +	local fio_ver
> > > +
> > > +	_require_fio
> > > +	_require_math
> > > +
> > > +	fio_ver=$(fio -v | cut -d"-" -f2)
> > > +
> > > +	case "$req_ver" in
> > > +	*+)
> > > +		req_ver=${req_ver%+}
> > > +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> > > +			_notrun "need fio >= $req_ver (found $fio_ver)"
> > > +		;;
> > > +	*-)
> > > +		req_ver=${req_ver%-}
> > > +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> > > +			_notrun "need fio <= $req_ver (found $fio_ver)"
> > > +		;;
> > > +	*)
> > > +		req_ver=${req_ver%-}
> > > +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> > > +			_notrun "need fio = $req_ver (found $fio_ver)"
> > > +		;;
> > > +	esac
> > > +}
> > > +
> > >  ################################################################################
> > >  # make sure this script returns success
> > >  /bin/true
> > > -- 
> > > 2.49.0
> > > 
> > 
> 

