Return-Path: <linux-ext4+bounces-6366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B12A2B7F2
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 02:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50CF1889455
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 01:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F6B41C71;
	Fri,  7 Feb 2025 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nFQWE8MB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436E946C
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892152; cv=none; b=cYe3wq3Wns65PzGuHl7m6lKcPSws5mLSxMPv/taeaWxQKWBZ9RUwmP5vvPK4uKgclukt4Qfp7GVRMAGXqx4NLjznvdK/nhusCvozSoPaU0ezs92jJMe2h7HWuiJArRv2h6IaTp/igx/smxTylQ9SUiI+UBYxvYSnFbseNNgqtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892152; c=relaxed/simple;
	bh=iWgiLlDxgGfM7+q+SCUzoRrdmc0q4fZ/Oymq/Ltf4bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2YXeDe2150K4Cv/+6RYuKMAUJbix7t1XQDxFWkojbz3Jid41z4SWF632I/6Tn7b/lGGDPUqRNVy0bVsG9CL4a5uvLLygLAbSOQJHrZsOJRuo3TjmcLaE7BdO/BZ7/JICgSkfirc7D26LO1rlAfng2Ee6r2n9kOq/Am6yh3BCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nFQWE8MB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-148.bstnma.fios.verizon.net [173.48.111.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5171ZUjd005801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 20:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738892132; bh=e5Ff8WEcLvOnWFzrk8mRICz3eOSLM2MeaKE+2momM2I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nFQWE8MBVq+7hkFVFDK5uPSHIa34JynXnW6WCEgNyhR+qmWIRMpxMrLyxceQPclyZ
	 wA7PdNu8woJUkramREOmYIKSY4zeyQ40678teniMo35X4fkX4H2NYbWi8Xr9IXpnhP
	 bz7C8M4BdoDpa2ym+bUQwhSoTRk1IM4p2xjvsYphFVqfna69iDw025+RebLRfENx+5
	 /QL2gROzhH/xl6AJjdtoDyjFwGr24eyLtPueBkSFQ69B87l4hjkaWylGQPIQvCB1V1
	 oZLtkBB+q2IsgItMO3xbCqxU2/cI2eziVEIMAOA+k6MT7GRoyyBXbGAIgtBu1gJqkz
	 5tefVumE3cHIA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E1EFB15C013F; Thu, 06 Feb 2025 20:35:29 -0500 (EST)
Date: Thu, 6 Feb 2025 20:35:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ext4: avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250207013529.GI1130956@mit.edu>
References: <Zz0TEX3GycUEmISN@kspp>
 <20250206150910.GA1130956@mit.edu>
 <09e5992a-46a7-410e-a57f-3d337d282943@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e5992a-46a7-410e-a57f-3d337d282943@embeddedor.com>

On Fri, Feb 07, 2025 at 09:39:42AM +1030, Gustavo A. R. Silva wrote:
> 
> > Thanks, for this patch!  It appears that this patch has since been
> > obviated by Eric Bigger's commit f2b4fa19647e (" ext4: switch to using
> > the crc32c library"), which landed during this merge window, so this
> > patch should not be needed.
> 
> Oh, nice! Thanks for letting me know. :)

Yeah, apologiues for not getting back to you earlier.  Between travel
and the holidays, I didn't have time to process patches for the merge
window which just closed, so I'm not catching up on the backlog.

In any case, Eric's commit is in 6.14-rc1, so you should see the flex
array warnings from the ext4 checksum inline function.

       	     	  	     	     - Ted

