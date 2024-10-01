Return-Path: <linux-ext4+bounces-4411-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620D98B911
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DEB22FB0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AC1A08B8;
	Tue,  1 Oct 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQpBdw0W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D319CC2D;
	Tue,  1 Oct 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777735; cv=none; b=spdBe/A/GjaDMAIiSxSCJAD2BKESos+DwSFDN/DqE7/WsTeHsb16SbrPdAeKWz3TW61TAPcC2Fc7YAGck4/GRwIqZb4MReuW1OLC0Xlk1TKGS5BVXCv8a3GKVScbXVUYT1MSntVTHG1RcKFxhJWj6VODUbc74G2CAQf7MR3qwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777735; c=relaxed/simple;
	bh=FjTYyCxCmJcgFq9jGU46jWa0EG3UvGSNFAhbYqbsqec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVlCPLocSWedMPp6mV/uQ5Xz7e7DDxxkM72FrTV1/u2XKkXhzhl1oZIwocibmY2kVg71jsgyENUykiFXrL/iIRwaHugWV/Q4GZqc7WVOtHjbh779SXOISRw3LdgS/AKsM1eSr6aLhtgRADPHYdFunH2MaTKqjhZIM7cEw9wRD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jQpBdw0W; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/A7sMvf/MZjcgy4YoCHGZRKtghk5a9aggM76D1xG744=;
	b=jQpBdw0WKrG//JMyCsBBw1F6jjSB8ZsL4mnSWpnuM1FkYVI5vYJ7UR4Dowk1bk
	9hOzCQv3uzYbm8rj1lisyzn3WHL/f7YW3fA29cbcTosRh44pvAXOm3IPoSpfgH9m
	XwI0/6NZPA6FjBJyKTHXoTVtkBjhdb0nNCIBEowfxT/5Y=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD338+ny_tmWRTLAQ--.2768S2;
	Tue, 01 Oct 2024 18:15:03 +0800 (CST)
Date: Tue, 1 Oct 2024 18:15:03 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca,
	syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
Message-ID: <ZvvLpxoIUdfC0xML@fedora>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
 <ZvvD2FeVm3ViPWIl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvD2FeVm3ViPWIl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-CM-TRANSID:_____wD338+ny_tmWRTLAQ--.2768S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4DtrW7Gr43Aw1DKw1DGFg_yoW8GF1fpF
	WftFnakrykJ3s7tr1xXay8Xr4Svw4Sg3y5Xrn8JrykZr4Y9FyxWFWUWrWFqa45Z392g3Wj
	qF1jqF9FyFsxZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDDGrUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQxramb7v+qbSgAAsR

Hi Ojaswin,

On Tue, Oct 01, 2024 at 03:11:44PM +0530, Ojaswin Mujoo wrote:
> 
> Hey Qianqiang,
> 
> Thanks for the patch. I'm still reviewing this codepath but I do have
> some questions around the patch. So I understand that xattrs are
> arranged in the following format:
> 
>  *   +------------------+
>  *   | header           |
>  *   | entry 1          | 
>  *   | entry 2          | 
>  *   | entry 3          | 
>  *   | four null bytes  | <--- last
>  *   | . . .            | 
>  *   | . . .            | <--- here
>  *   | . . .            | 
>  *   | value 1          | 
>  *   | value 3          | 
>  *   | value 2          | 
>  *   +------------------+
> 
> Now, in this error, my understanding is that we are actually ending up
> in a case where "here" ie the place where the new xattr entry will go is
> beyond the "last" ie the last slot for xattr entry and that is causing
> an underflow, something like the above diagram.
> 
> My only concern is that why were we not able to detect this in the logic
> near the start of the function where we explcity check if we have enough
> space? 
> 
> Perhaps we should be fixing the logic in that if {..} instead
> since the comment a few lines above your fix:
> 
> 	/* No failures allowed past this point. */
> 
> does suggest that we can't error out below that point, so ideally all
> the checks would have been done before that.
> 
> I'm still going through the issue, will update here if needed.
> 
> Regards,
> ojaswin
> 

Thank you for your suggestions.
I will investigate this issue further. If there are any updates, I will
let you know.

-- 
Best,
Qianqiang Liu


