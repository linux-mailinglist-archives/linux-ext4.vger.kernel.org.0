Return-Path: <linux-ext4+bounces-4682-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B889A91C0
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 23:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E6B1C21EB8
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A2B1E1C17;
	Mon, 21 Oct 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="okApF/5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+bAfSWf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173261C8FD6
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544906; cv=none; b=fZp98MnVK/On9Uu0YaBACcP8yqO1XJ0ocVqLQ+fh/Q7rbx2lD78Sh6Az3sU3aMUJVs33zWhxJtLXkuH3DHFENeC1AADritCS8tKlbSruvjVWcAK+I/yc/845og3Lh+U5IlNR8kY3X/WP93kZTAZd5kgKDa4t10GOX9qPsZWkmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544906; c=relaxed/simple;
	bh=AFjfsoKH04QT5523iX1eVEdjCtVOD7cCSxzltE6oGjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YU4fEevdqbuhZyKmu/wccXzpRGcmx2ZJ2qn5mFOXvQDblSrF6JOKjzWYArSNOaUHBRNd2DLMjEVbAS+oBp8zWmVZCf5/IBA0onjvh2ll3INIKtqiHIv6LtpJPzDGAgFjrEr+QXeCU3jfv0caM9MeFQO81tlXSaGTOANYzujlA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=okApF/5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+bAfSWf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 46DC31380160;
	Mon, 21 Oct 2024 17:08:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 21 Oct 2024 17:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729544903;
	 x=1729631303; bh=JUyxP50xo2tKTGe6gnb2qQ9RBt7lElG2xucUYFshMjM=; b=
	okApF/5nG1In1Fc7gQsgs4quLi17l/GkTgd1TNd1gUyObbc23pQIpfzOTm7GVRX7
	+6xleXudWK/A9aTlkvmDhxoBeKbQf/bLSZXlepLblbL1b0IzWx4C0vlvRT2S/P9W
	YN4hYksdQ7TvhGCHauUSyWAQcF/qHBBFwevD1Bxb9Vnww2Z9wCAP9dUdSIB+o1zH
	Nh5z25XB1n+MuuVIgZ3Z4AZZgF4rvEYdEZlXOI4wCQscJEn8upSaVq4hniwsDSRP
	K+jHhb+Ung1YzR3ZcrR2gHz7gIP9YliwYTPc/tatUpoTxW065sutOmDO4Z6O6yz+
	GD21JamR57WmnpOsW+HDVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729544903; x=
	1729631303; bh=JUyxP50xo2tKTGe6gnb2qQ9RBt7lElG2xucUYFshMjM=; b=a
	+bAfSWfaJUn/ji5joCEjCv+9NupbVsrCsVFHaLbSTqGAKQjXbtaSRgg1otRwMrBJ
	6uvQS0E8SpIiO+FKtlAyYNV1B4aNXwhZU/G9TxsvoyGtpBAe8H+PGTbnJjd517f/
	3hz/Y4vBP2sHMX57l5LSkwmJNF0pDSGoYh3wPS+eRAGx3DwjAnw7qg7CDePmDeKS
	GeJIJH5chYs4Bas4LWOhb5dY9vLg2TW6eZmuorCJN07tfx4cK0iK4KHmpRSJ4GKS
	zz5mH0JMs+X7fvuHxbye4OsY9/6/aYqO8ypNRqKiYMxwmgI9fCJbxyEaYZwFLmcp
	SPxBHBCgCMo1+/hO0SRYA==
X-ME-Sender: <xms:xsIWZ8ZrRBU5ePlRqEMdeQs7c_iv6tUdSRxC55SMH3aYfor-S1yjOA>
    <xme:xsIWZ3bjc92n3r710wseaUrILSVCi_14v161kkM533br230o8xASXDitdV2OKk_03
    pyuNSzb1-FLFTcKDI4>
X-ME-Received: <xmr:xsIWZ2813GS-cgLaQtlanXaZTiCcA7lFy7v7aOFSSKj74XXV-2OiSV4LxaR95attKe7xnr_FJAymcW1xvE0dROA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepleetteetheffjefgffevkeeuhffhfefh
    vdeggeduhfegvedvieelhfethfetieevnecuffhomhgrihhnpehrvgguhhgrthdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghn
    uggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehluhhishdrhhgvnhhrihhquhgvsheslhhinhhugidr
    uggvvhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtoheprgguih
    hlghgvrhesughilhhgvghrrdgtrgdprhgtphhtthhopehlihhnuhigqdgvgihtgeesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x8IWZ2rm-5LoRcHvZY69wU9xu2FFjLNByBdjnGLWA6z80fFRFKR1pw>
    <xmx:x8IWZ3obQHiEYHk1mhvhLioo0uSZO3bZ2EafCl4dBg9QnWZ3QWW_5A>
    <xmx:x8IWZ0TrWW0H2gN7QuUTgBR7eBGUoCtpeozfchqeDthRDvH0bXO5Lw>
    <xmx:x8IWZ3rV9aXkApktHmDhqwnVzIGjR3pP4EQUnDQ_5oM6kO5o_pK6sQ>
    <xmx:x8IWZ4nZ2glb2UPNoMOtWO6obCfALXbGeZJLmtcWYNEZBGJuhZro-nP0>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 17:08:22 -0400 (EDT)
Message-ID: <1e606c8a-31c1-4f7e-b677-575069aa8c30@sandeen.net>
Date: Mon, 21 Oct 2024 16:08:22 -0500
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] e2fsck: make sure orphan files are cleaned-up
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
 linux-ext4@vger.kernel.org
References: <20240611142704.14307-1-luis.henriques@linux.dev>
 <62c41f80-4bfc-488e-ba8f-8e1d5fc472a9@sandeen.net> <87bjzdn700.fsf@linux.dev>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <87bjzdn700.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 4:24 AM, Luis Henriques wrote:
> On Fri, Oct 18 2024, Eric Sandeen wrote:
> 
>> On 6/11/24 9:27 AM, Luis Henriques (SUSE) wrote:
>>> Hi!
>>>
>>> I'm sending a fix to e2fsck that forces the filesystem checks to happen
>>> when the orphan file is present in the filesystem.  This patch resulted from
>>> a bug reported in openSUSE Tumbleweed[1] where e2fsck doesn't clean-up this
>>> file and later the filesystem  fails to be mounted read-only (because it
>>> still requires recovery).
>>
>> Looks like Fedora is hitting this bug now:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2318710
>>
>> (unclear why fedora upgrade is leaving an unclean root fs on reboot, but
>> that's a separate issue.)
>>
>> With this patch in place, bare e2fsck asks for confirmation, not sure if that's
>> expected. But with "yes" answers, the filesystem is cleaned properly and
>> mounts just fine.
>>
>> Also - shouldn't we go ahead and deal with the orphan inode file even on a
>> readonly mount, as long as the bdev itself is not readonly?
> 
> Since that would be a filesystem-level change, my opinion is that we
> should not do that in a read-only mount.  But that's just my opinion and
> maybe there are other similar cases (I didn't check) where changes are
> written on read-only mounts.

Well, we do the whole log replay on readonly mounts, as long as the device
itself is not RO. But I guess I don't know if we fully process orphan inodes
during an RO replay. *shrug*

Anyway, thank you for this patch, it's in Fedora now, would be great to get
it upstream.

-Eric

