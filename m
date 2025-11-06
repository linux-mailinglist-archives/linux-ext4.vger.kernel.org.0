Return-Path: <linux-ext4+bounces-11517-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F5C394FE
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 08:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E359C4E195E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C327EFE3;
	Thu,  6 Nov 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jHmmCysV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FqbMGEzp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BD26E143;
	Thu,  6 Nov 2025 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412434; cv=none; b=A9bjV6rafV3YC47GhZtTHQ0DdEr0YNbhOqThzzjQq8r23cyfUnha6C652F1UmfDxpB5hqzyO0VM8X99SXGGoRV+x+fmutg/VqIbPc/0dc1Pxta71YK64ti7pZyZPaix6d8+EFdmPwUDKftKvq64PAxFnUSgvjwXTuutaiG8GVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412434; c=relaxed/simple;
	bh=pKiWkDv6VADt7bq/kISjURvOA8sX2B4Nz9WreXI6EMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF4hk2x/BG1Vanx4gI8RUnUsO0InmAG2fjQutduSlE1j5wWSx61y7KWPl8DeEP9i5At+LQNt0B5e6Q8ug1mhdhQUPir7ObFghjtto1fKtzgIM1rteVjxcIxxW9gwrAqhSsNatRyru0Z43sIt5n+WBwyS7DGWDS8I1pc/+8f5X34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jHmmCysV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FqbMGEzp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6C007A0128;
	Thu,  6 Nov 2025 02:00:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 06 Nov 2025 02:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762412430;
	 x=1762498830; bh=GwRElYD2FSG7uhsv4FneILWkGowEuJCdg6lJXamnFqE=; b=
	jHmmCysV1QogYOpqU7/yXaI5SlXEvxNho/JEoISCt1jjhcKsYX0RQXLJnNwxnThM
	zNr5dPCi/uTumjuegBjP7NI5//mzGT9b27/DZpplogyP4sjqj6D4CCKHgtcsKxMo
	Utcd1SVV50oqMQLo+hkny9nwA/nAzsOsauX9DXgDWTss72yNmMDYSUd7pOsHG4Xz
	wvVbdKIcLBgqOG7f2FhBmxiLfBch33dVY0agG02AdJWjFCNi8pky54k7Cfnit6OO
	6zMIgdHE10IJRsSsn+BKuQYg7B9yyh0Dh9Z87/g2fJtP8Q+tkA2RYXULaEz3MTON
	ueac46Z2TMJZrJ8znTtYvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762412430; x=
	1762498830; bh=GwRElYD2FSG7uhsv4FneILWkGowEuJCdg6lJXamnFqE=; b=F
	qbMGEzpwJZy84Blxz5SiMpo7KNJ0vIpdp+jPo9O1vjBJXSaHw/nmW1qrpi675EvJ
	7juVrE9MllcGJ/TsX39sq0K25ril41q9UfVTpWi521ErzsiAkE8DF76i1DiZtNX2
	6iVAbnOOs2fBqyGsxolYVNuWh6rRF7l7vWuEGYBYDQi3oKjfgwMbpwXaT7XNFaWs
	ZC+LD3YDbGfxF8A3Yz5Jn4SILX3SjbFOcWcmXVhmzgl75n7VQqnEofawpidyF2cX
	KcCwy5BooQJe0eyski89QzYkrwyJTZFtelyRtyI5+Kj9rbOmH7/9vo5NyVXF+Eav
	CuEySACMEsXqMTFvL7yog==
X-ME-Sender: <xms:jUcMafVVhlwMJoD3Xjp_CKkfKs6yQseRR_jJBMkfx7n4PV9wf3taNg>
    <xme:jUcMaYBt6turtNCE1ff6hjjB2mJ9LSMqlkvEP9iuE1Z9oOHM2VcvkoTpLyxt_VyPA
    LevsdoibNCdCeqHfxWLGPqp5i566vCSHULMsXW8kNEyZh6y>
X-ME-Received: <xmr:jUcMacGbOPywTWtnn1KYpvnQCLx6zpaIOnPX4cU0x0jAjNm0sUmEaLtr_nhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepgfekffeifeeiveekleetjedvtedvtdeludfgvdfhteejje
    eiudeltdefffefvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehludiirghoseiijhhurdgvughurdgtnhdp
    rhgtphhtthhopehsvggtuhhrihhthieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jUcMaR6ewatpE_vovAEOs3Qryb8c2GzsQbeG3W3YMeCUC4dWblHZJw>
    <xmx:jUcMaal_zVCxJgApyTQIJgCy8b3kDlJ3v47qrHwVverUkKFQxHctYQ>
    <xmx:jUcMaU4ycnYRlD0rEvG3Huw51qBnQEFNhuEJNXPlFIvP4Gum5OBK5A>
    <xmx:jUcMaTRX12fydXc8_odmkqh94WKLd88crt3XTBDjRecUROwhfiU8Fw>
    <xmx:jkcMaZ5r1e0CCHWt0EIvWAipFKzxFKZ_6jLw2hQq5xzkt_jB-Nmz09fr>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 02:00:28 -0500 (EST)
Date: Thu, 6 Nov 2025 16:00:25 +0900
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?56ug5oC/6LS6?= <l1zao@zju.edu.cn>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] ext4: KASAN use-after-free and Oops in
 ext4_xattr_set_entry with crafted ext4 image
Message-ID: <2025110632-fondue-chewer-2e20@gregkh>
References: <dd5c923.1fc4a.19a5475534a.Coremail.l1zao@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd5c923.1fc4a.19a5475534a.Coremail.l1zao@zju.edu.cn>

On Wed, Nov 05, 2025 at 10:39:26PM +0800, 章怿贺 wrote:
> A local unprivileged user who can mount a crafted ext4 filesystem image and call lsetxattr() on a file inside that filesystem can trigger:

Note, if you can do this, all bets are off as has been explained many
times on this list :)

The real question is, does fsck catch this issue before mounting the
filesystem?  If not, can you send a patch to fix that?

Also, do you have a patch to fix this issue so that you get the credit
for fixing it?  As you have a reproducer, you seem to have an easy way
to test this :)

thanks,

greg k-h

