Return-Path: <linux-ext4+bounces-2996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6491A7EB
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B2F1F214C9
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF05190698;
	Thu, 27 Jun 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="o3QFlHJW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C5186E5D
	for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495136; cv=none; b=TzPX/Hhc0c5puAXmbzeZ48FCZYTN37uWjrI0ZYTZQ+8OCsil4yby+HnlZBwSmX0gMnTBA50mZFG6306osIS1Vsfhcaohxv18kCWI+7wlVehIHeHcH80YE+nCjxBAifzf8QWvi0gUegko4pbdFaMQecAN8x88V0z2bl5rkGaWfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495136; c=relaxed/simple;
	bh=9IMR4bG+QrMD5EStLhJXG387Il///O58FizFb1FZuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q42dV6zYsdDHt6ZNxV6VVmS6VY3ptRcarwPLKUWNwRH/XdkizKGWyOGwP5dSXXYXnTHiEJyZqf11UENhE0nhduVg6mZZsTdiUbZxjGEEWghdexQrcPjWRLDYgmsprEhgMR3vEg3eb9cthAOygKF8v+Q1x/3xlAk6HFIgbdw9DFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=o3QFlHJW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45RDVuZt007178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719495118; bh=4DvxyIc7L8lU4EWlQ5jMV1t1CdN5ET04EYd2tGmW2tg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=o3QFlHJWBaz7caf1GEhCOtK2WUj77IoI4kh8asYRgWokbtDVe84wvBvj0H14gx+fr
	 eWCvRzoM+V0DcLnlZciS1gSvrQdCR67fB7tcPu95uNft2LuKFkF0opGvEOdSOIhFAa
	 Uk24xn49qN/e5Rww5At3f4A3x70uJGY2HhKnmBGE+OQD+9L3MG0emfzx+kxQonlkNM
	 3dEvgMFl9nwdVNPKCEn99Mzl3Hc91qwxSuoZ/hUeiqEOK6TZyzmHy76yyPL011BR7G
	 R2EE4hR/jZX+OTPDRFq/FBegkhWvjHgEc/djiqTDiUB+jVDuG7I3wO/RsJly6iyTlv
	 uC2T7mD2/aqRQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BB50215C626C; Thu, 27 Jun 2024 09:31:56 -0400 (EDT)
Date: Thu, 27 Jun 2024 09:31:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: Wang Jianjian <wangjianjian0@foxmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: Add a comment for incorrect tag size
Message-ID: <20240627133156.GC412555@mit.edu>
References: <tencent_1D453DB77B0F2091CB4A68568A77627D4E08@qq.com>
 <20240619233655.GC981794@mit.edu>
 <0c296005-c607-431d-a696-b5b165c83856@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c296005-c607-431d-a696-b5b165c83856@huawei.com>

On Thu, Jun 20, 2024 at 11:19:30AM +0800, wangjianjian (C) wrote:
> On 2024/6/20 7:36, Theodore Ts'o wrote:
> > bd2: fix descriptor block size handling errors with journal_csum
> > in 2016 --- a full eight years ago.  So it's probably not worth adding
> the comment at this point.
> 
> Thanks for detailed information, but is it better to put it in document in
> case any other one confuse about this when read code.

The comment would probably make things more confusing, since there's a
much larger context involving the fact that csum_v2 is an obsolete
format that in practice is never used.  Sure, we could make the
comment even more verbose, but perhaps it would be better to simply
completely remove csum_v1 and csum_v2 from the code.  That will
probably make the code even more simpler to read.

Cheers,

						- Ted

