Return-Path: <linux-ext4+bounces-4012-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834DD969E56
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351241F2264B
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7B1CA6A6;
	Tue,  3 Sep 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="k9hfrQ28"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF71CA680
	for <linux-ext4@vger.kernel.org>; Tue,  3 Sep 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367842; cv=none; b=s+DoOuujZHB3jv3PLSvPCAdYIh1Xkd61KO4jQ+WiY7JLBGcjHSDXqU+uRutN9CIorXpLVGui/JcN+UVbm/RMLYeQZNGL64ay/jrKz1l20o2N87Bns5Vi8sNJLjA6n75mfDz7mPARDJRjB0H22HXFIpN6HH+/uz67MFMLIe8zf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367842; c=relaxed/simple;
	bh=flRatLrWnVLGm0ukD5PLJh7O9Kq+VSr/Lehnc7GIMNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avfi1mnKkfepkO+BZX4fBsRDgi8ZoKDtDX0J2ZbJ9T5hIVQ3oo4q/anAC7GMrib52tgFTZbIv1d4Mdeg3WHVc8OQnsLXwQFgEJwtUL1Cnaj2FAsEwCQc6hdGc/YJLM9Cmaq4ilbRU9JzKzuas7V5e6Bvh68VIpocXll8sTke428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=k9hfrQ28; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483CoMRD029696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 08:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725367824; bh=j9Sn0deNeRSALz8owlDSJet469u2F2s8YihKNVvIJqE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=k9hfrQ28xX0ruzLC6s/toONApDnKHSCxJdzu4kuwslKy0NEl4ckxrqiVqvkldT1Oh
	 f44eQtQM7AchSItMX61EfBvPdAypBpIeYreFYbOx3Jp6LPjKHvawo/mk/WkTlpQ00/
	 umJACk765x9bcQL6XiO5bOboCH3UKCebI3ZzPTi+tSBRVPjNN1aktaHVyNw9MHURm8
	 WZnn0pmV/QH/VxRW7mOkMRmspZcx+70ZczUCj5p21rWaZkKeZv3EjKY34EOVfILj2/
	 IcQxMjiFx39feLYZFx+Ui+BWy6r0U/dgSkCybRj1WOw4CKzV2zlck9iYVvDnpGcoS8
	 tVnkIcKtoGnNw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 1F31F15C02C4; Tue, 03 Sep 2024 08:50:22 -0400 (EDT)
Date: Tue, 3 Sep 2024 08:50:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Li Zetao <lizetao1@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next] ext4: Remove redundant null pointer check
Message-ID: <20240903125022.GF424729@mit.edu>
References: <20240820013250.4121848-1-lizetao1@huawei.com>
 <628a0278-6809-4d2e-94f3-14a882bfa34b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <628a0278-6809-4d2e-94f3-14a882bfa34b@huawei.com>

On Tue, Sep 03, 2024 at 03:52:01PM +0800, Baokun Li wrote:
> Thanks for the cleanup patch.
> 
> But the change is already included in the patch:
> 
>  https://lore.kernel.org/all/20240710040654.1714672-21-libaokun@huaweicloud.com/

Yeah, I noticed.  I had already applied Zetao's patch when I processed
yours, so I just ended up manually handling the patch conflict.

(I haven't set out the patch acks yet, because the current state of
the ext4/dev branch is apparently causing a test regression which I'm
trying to root cause.  They will be in tomorrow's fs-next and
linux-next branch, though unless I end up figuring out the problematic
patch or patch series, and end up dropping them from the ext4 dev
branch today.  Still, feel free to take a look and let me know if I
screwed up anything.)

						- Ted

