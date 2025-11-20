Return-Path: <linux-ext4+bounces-11942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62379C75222
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2191C361779
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683A3590A4;
	Thu, 20 Nov 2025 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TtpYxeQW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4B35CBA4
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653380; cv=none; b=rXFoZoUO7eEDyQWmxrIjiIiksvK4eZJ8WhWG9Jsr7lsvZZQHBuMebvuddQttZN4N1jGzBj/h5AHVI7ezK52ziSJK87QQ2mCleyuXSW7snOhOjS8+Ulpm2lxQowq8GrxZ7y/WoFpW2PSXH1jcw0ykkOFN8Rz8ScJJiRJdahWrm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653380; c=relaxed/simple;
	bh=jqc1pIyMAxigE7tZset0OOfL6VF1aHdRg4wAWz7wfVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpoqnYYtjBJs7HvN/kzwhfuh+rv9QKONoR1QNj0PukVIttIUoXbmgoSQnSku0rogaM03ghsLInzF8HM4AYg2uw6FPKR2/Onit4DU8OnfGkwGCZsQI76y1fcv8ep5Vwa84p1pH+eKhgCEfMYrFHtzXAebkInaCzVI1DsrRC45Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TtpYxeQW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([104.135.218.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AKFf5Xa020346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763653275; bh=PwK25/DM8jyeo/BvfK6O5K39WyPp+rYvJyaLpKyDbuI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TtpYxeQWgnqXOecP7qSvrH8Rt1E0fj801JxicjCD7vnBuS29cvctMe1itDRfYRJIt
	 //kPQ8sVpQ8cloF9zF5XJQTJrUpeCrkjlTLhEaVKj4POjyoHFExAxaL0rXc0Mlzbo4
	 9pUJWVc0XBy7OM59/0V3NnqTBJeFuQCFMJgaqmHSYlUqBW3BBctAvGhOIQdixtOFuP
	 lmhUcieU+aHejv79Y0cbs+bGlq6BEf7MIJHUyTR1ZWg8LcV3U5MIBvluKlByDa+Z/8
	 QT3yflfmiHx2rUdNCCzFTGX+oHyyU2H5YREKeklz+ii92XKSKO9e+ss2GyzNECgpf8
	 vgkJ5eu8T30ig==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0F87B4C0AD99; Thu, 20 Nov 2025 10:41:05 -0500 (EST)
Date: Thu, 20 Nov 2025 10:41:04 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
        libaokun@huaweicloud.com, linux-ext4@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v3 21/24] ext4: make data=journal support large block size
Message-ID: <20251120154104.GA13687@macsyma-3.local>
References: <202511161433.qI6uGU0m-lkp@intel.com>
 <ce363839-18af-4372-b7c2-e08cb053e403@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce363839-18af-4372-b7c2-e08cb053e403@huawei.com>

On Thu, Nov 20, 2025 at 09:21:23AM +0800, Baokun Li wrote:
> 
> Oops! You nailed it. My bad, I totally forgot that unlock here, which
> definitely left the lock unbalanced. I'll get that fixed up in v3.

I think you meant v4 (since the current patch series are v3 :-).  When
do you think you might be able to get the next version of this patch
series ready?  I think we're almost ready to land this feature!

       	       	       	     	    	     - Ted

