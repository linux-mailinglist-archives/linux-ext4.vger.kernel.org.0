Return-Path: <linux-ext4+bounces-4736-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2969AF7B8
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 04:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EFF282303
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 02:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE6418A920;
	Fri, 25 Oct 2024 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IKP/f8IT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD61E492
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824846; cv=none; b=VbYdAUJs5qOwdaN/xqvOtmNfOtPtL67EiaXVDHIk+EDuj161wSvzFmiCOOXcuXTvgzfSPeQ3/ODhegpsooL7+XKHKhIIDh2NV26FxOyY+mbYqkRQwUh6IXtn1bkiZfm8TF/mCDLHD3oHoSbUovRMOCIU0ZYZG4Vf22gahmjEmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824846; c=relaxed/simple;
	bh=J4zcNPcsDMg25BEidS4mV4RuTIXJ34312NFf3ysjDc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixbGKon5aKfo2CnDj8QRSxPzp5rdYMtVuMLe9tsY3cQIo0jXwBf8olsj9h4P88dRGJVAuw/CMtDeX9IWYn0AUCcKld6yKwJKS0xWbIVNKRr8BKbk5Y371Hvd5yZvexS2azuHphpXYJpgCRY1XWTrQ2FmtQ7EKk3Sam9TKHFZFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IKP/f8IT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P2rtKd004462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 22:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729824837; bh=1ApQ5IijcA1rKe5PlNOVJVhfpbvGE33dkPpFOCYW6Sg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IKP/f8ITptBl9wyVoKSPOREfxpuy7ehUqfApMDGVD253tE7wKxXZGJDeaG7gCjIhh
	 knMie05thEqGfkdCdSAUxWRdScwfH1TLotxET9HRTMpM4hK2psJPrvw943ft5cSk8c
	 1ZdmN1OEenEjO6j3aBdsf/EAqWanqTrssSc3V8j+z5HLNzsHzVVUKhroqdLr6197YC
	 XpF5ggWm0u7Da2Ys86Ql8Ulv36UsHJ2B3IBDRYZ1jpGika+HQUla9iuYM7s2pOjvyM
	 Ngyli0Ss3MO2sUoaQiTQ3vJrgHRErTqhmDHkgafUMKPZij/G7CZQCtHzQnZQ/X0EVS
	 RLLgBTMv7Ggig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6644A15C0329; Thu, 24 Oct 2024 22:53:55 -0400 (EDT)
Date: Thu, 24 Oct 2024 22:53:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Gwendal Grignou <gwendal@chromium.org>, uekawa@chromium.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs: do not update quota when not needed
Message-ID: <20241025025355.GR3204734@mit.edu>
References: <20240830185921.2690798-1-gwendal@chromium.org>
 <20240912091558.jbmwtnvfxrymjch2@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912091558.jbmwtnvfxrymjch2@quack3>

On Thu, Sep 12, 2024 at 11:15:58AM +0200, Jan Kara wrote:
> On Fri 30-08-24 11:59:21, Gwendal Grignou wrote:
> > Enabling quota is expensive: All inodes in the filesystem are scanned.
> > Only do it when the requested quota configuration does not match the
> > existing configuration.
> > 
> > Test:
> > Add a tiny patch to print out when core of function
> > handle_quota_options() is triggered.
> > Issue commands:
> > truncate -s 1G unused ; mkfs.ext4 unused
> > 
> > | commands                                                | trigger | comments
> > +---------------------------------------------------------+---------+---------
> > | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | Y       |
> >                   Quota not set at formatting.
> > | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | N       |
> >                   Already set just above
> > | tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
> >                   Disabling a quota option always force a deep look.

I'm not sure why disabling a quota should always "force a deep look"?
What was your thinking behind this change?

> Why don't you do it like:
> 
> 	for (qtype = 0 ;qtype < MAXQUOTAS; qtype++) {
> 		if (quota_enable[qtype] == QOPT_ENABLE &&
> 		     *quota_sb_inump(fs->super, qtype) == 0) {
> 			/* Need to enable this quota type. */
> 			break;
> 		}
> 		if (quota_enable[qtype] == QOPT_DISABLE &&
> 		    *quota_sb_inump(fs->super, qtype)) {
> 			/* Need to disable this quota type. */
> 			break;
> 		}
> 	}
> 	if (qtype == MAXQUOTAS) {
> 		/* Nothing to do. */
> 		return 0;
> 	}

I like Jan's suggestion here, and this could easily just be done at
the beginning of handle_quota_options(), replacing what's currently
there:

	for (qtype = 0 ; qtype < MAXQUOTAS; qtype++)
		if (quota_enable[qtype] != 0)
			break;
	if (qtype == MAXQUOTAS)
		/* Nothing to do. */
		return 0;

It results in simpler and cleaner code, I think....

   	      	      	  	  	  - Ted

