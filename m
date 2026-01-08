Return-Path: <linux-ext4+bounces-12621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E495ED00F63
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 05:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D81301FFA7
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1570E20E6E2;
	Thu,  8 Jan 2026 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="J9s4++i6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC961EA7CC
	for <linux-ext4@vger.kernel.org>; Thu,  8 Jan 2026 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767845783; cv=none; b=PODfki2zVvz3wW4f9uJGIX6EG04qHQXVFyBLZOuxFDg90jmvF5shUt1UqBqFg6fN1vSFT0bLe+ME2wxgAcSNkrNa1UOUTYcRl9g0HRqIQZW7r/RAy/fmpoYmOlmlfVRlBSyfbNWGL2Cy1PZ6hT7Ui26GeFxVm4A+fbF8B2896sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767845783; c=relaxed/simple;
	bh=hd2c0Eld5qdXZChTGXsW9A97HVhCwDv0ORHu4GAV+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njU6ayCwHzf1Wt0ui+yik6AlDvRahSLxIpRrh8Op7xR0vdrZ1GzJ2iWfJKbGN1S0oc1cD/lqohEnrh6zNiH+9hiwwX2eyLmwX+sRaBfX/pTV64U0OAWt2lhD+E03SiGChBMfk/vVblITt9/Uf8LhjqA5HOaHpNssDOjZzYb99NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=J9s4++i6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-108-26-156-234.bstnma.fios.verizon.net [108.26.156.234])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6084DelJ013053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Jan 2026 23:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1767845623; bh=49ylu8Pevmq1DwE//KCmLCd/ip71islIRAGq8l8W1WI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=J9s4++i6ah+3pO0BK8RuYaNnCmWyQOREvEYPEkY/wn/8VLzuEZGiDI/CZuJWJnN+Y
	 p2SIC4HtODnL8WXry03jQsTodzf52jDK1ngh+FIBMDatX7CJn/ix8eIqgvD4advc6e
	 bcmN8MCMbLbrrmDcx9Ay3h+ufPLuFxnicfto/PDzohmoEcl020HW7zCH+ERBUUDKnw
	 eSS5Yh/Qmmtq5dF1/BgBWIl14W3ecP8Ylu55YVtXNMJO8PsPOj66duGt1t20FfxWjc
	 1q8pMQNmRpQ52OVaFMSn00O3Tt0xmTnhMhEFurs+LEbjhvECs/xpKOGcW1oLJGJsK3
	 oaUWSnTrKbZ+w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 65DB953DEF24; Wed,  7 Jan 2026 23:12:40 -0500 (EST)
Date: Wed, 7 Jan 2026 23:12:40 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ext4: fix ext4_tune_sb_params padding
Message-ID: <20260108041240.GA75173@macsyma.lan>
References: <20251205111906.1247452-1-arnd@kernel.org>
 <20251208180310.GH89492@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208180310.GH89492@frogsfrogsfrogs>

On Mon, Dec 08, 2025 at 10:03:10AM -0800, Darrick J. Wong wrote:
> 
> Hmm... given that the ondisk super field is a __u8[64], it feels weird
> to expose a __u8[68] field in the ioctl ABI and silently truncate the
> user's input if they try to use that many bytes.  I'd have enlarged the
> padding field but as Ted was both author and maintainer I'm ok with
> letting him have the final say.

Thanks, I've elected to the the original v1 version of the patch.

		     	     	    	- Ted
				

