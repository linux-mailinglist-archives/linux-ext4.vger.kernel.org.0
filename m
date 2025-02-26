Return-Path: <linux-ext4+bounces-6577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF47A466D2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 17:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036F33AAAB2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC018218823;
	Wed, 26 Feb 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="LMvrj6zQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKtZLbtD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530DEED7
	for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588136; cv=none; b=FA2hZFL07lcUK75G3lr97vSziqWkdOSKA5TkVEVvdYPGlpL4VD2aOv00nF3ZUw6dTxvTBktMWRZ11HAZ7MTBF6q7dhM9NB1um50zaxcnmcCdFxaQWIJd/SmjY2A3GXWfkDG9Y+zV+KZiHndlJoWHj3ZrYk8+Y5GF/PKDpem9nUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588136; c=relaxed/simple;
	bh=SQgjHuXC9WLAwkGFl04R22lGd94y81G6zyP4gDEAjg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLcXHzO694A3hu7wnYdZyhfqKcI6TRZj+lj7KWp43LsfMZmqX7ori3yV4oSwnm71glQGBiGquSJlsZT1zpin2haoluNXhvGBatmQlVzneUnQJJEcemNGviwSsXUQvMHvJ9eaFC6Vau0sShiVakM2A6muLapFgO/lo4FxgjQ7Vhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=LMvrj6zQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKtZLbtD; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAD3111400B4;
	Wed, 26 Feb 2025 11:42:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 11:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740588132;
	 x=1740674532; bh=zfZakCVWYH1Ddk8QRTGWjUhv0pMCBS50aFKsDSW6yRw=; b=
	LMvrj6zQQdikxMO4Uk9vrn2L1Q6SMe9+piOIq607V84D6siJbbPpPSiRXOyBo5+S
	u4YWz2pwK503VJgXZEfCMTody3Q7y/aSFM2cMtCDlkm/NzZ5M0PJnkYTVb7YKBJb
	E5mIfbNrLZc9/Ll0QR67+V8gatosA3iJRuvLAtpabSnJgffncsy2mOb9beN/h7a0
	4g7P6OXLtakRtKsXF2spBWPypbrwZbFWPZHpFSuREH1Dh21xcKTT9YSUuEojMCIa
	y09OzIDoBnouW6jr2WAwOw/UkRA2AdZ25GwHwBdnhupGvsLvk+D4TeI7vd6sm9NE
	ODptSCk9pPpl0bnocLXI8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740588132; x=
	1740674532; bh=zfZakCVWYH1Ddk8QRTGWjUhv0pMCBS50aFKsDSW6yRw=; b=O
	KtZLbtDoV2zjHtlLhgkzQAeiwUowOmp3R73F4TWdCMvtoPoqsCRb4Aq5IA/H8SK6
	5HDF6wwa+Y7wx31oRBGTPDXmsQMER1g5x5PW6036jwb1ovxE2wWAnyOtpiy2s6BJ
	lfzEL4JqwE+wn947q9eugq6jWDWSpv786ymwsN9QsWqAhRD5AFjcZ39egB3AF/n3
	HM3bdGxYRk0lWYSbFyrVLhE4S2qjeYHn1rc56NFGlY4FK4RYbNz+/dgz1fzzMDR7
	6o5t8yqV3raciFhNgtjGWKErRkcsuVzFlyBt3C7spah5CZ+CH12epiC49BzwZ7vR
	dbG7QoOAYyW4SScI02BHQ==
X-ME-Sender: <xms:ZES_Z-fg1C2lLWsICBmTi9rjlUmsJ-2Gov43TwcHkcnhvutz4Z_8cw>
    <xme:ZES_Z4NonbQ15GmEJqLBaf0Q-gNdE_Keul-Y60oiz64vWU6Dpf7X66feYpRc7gJVW
    b7NPj4qrbdoYwqAlRg>
X-ME-Received: <xmr:ZES_Z_iJDz03u7leH4hVdZJZZuVmjf7Dp5mQz6lPIueU5GNTTsrcErt7elvfAa38w3BR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgg
    gfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggv
    nhcuoehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evieekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeulefhvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvg
    hnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehsrghnug
    gvvghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZES_Z7_6FXtI13HDk99IbwNZoPRkN35SV0em4CkC03j9jrOuqclUcQ>
    <xmx:ZES_Z6sh-y2lNDnE6W4D7Kbnn4Z5cn5YbTLtwEpxt3IIZhXlNQK55A>
    <xmx:ZES_ZyGUtwhFm-y_8U7QVBDdvjl-Vf5zmF2LK4vYzNwik9SqzyCwrw>
    <xmx:ZES_Z5NJSUQetBfM5zcjDFy1xWLqjAHvsGq6WRRu-o2eaaezIVK_FA>
    <xmx:ZES_Z8JXVZYJia8MxYwGYOLlpiBCRFxQAwoAJbvpXzDAfR_DNN7fZZ8H>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 11:42:11 -0500 (EST)
Message-ID: <ca1f1899-455f-4e69-a302-c01acfd565f3@sandeen.net>
Date: Wed, 26 Feb 2025 10:42:11 -0600
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext2: convert to the new mount API
To: Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org
References: <20250223201014.7541-1-sandeen@redhat.com>
 <20250223201014.7541-2-sandeen@redhat.com>
 <goynv3cssrrdpykmtwon63xiye4qdzbmvpwq6gjzwine63r25n@4mfgf2ycqzql>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <goynv3cssrrdpykmtwon63xiye4qdzbmvpwq6gjzwine63r25n@4mfgf2ycqzql>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 8:02 AM, Jan Kara wrote:
> On Sun 23-02-25 13:57:40, Eric Sandeen wrote:
>> Convert ext2 to the new mount API.
>>
>> Note that this makes the sb= option more accepting than it was before;
>> previosly, sb= was only accepted if it was the first specified option.
>> Now it can exist anywhere, and if respecified, the last specified value
>> is used.
>>
>> Parse-time messages here are sent to ext2_msg with a NULL sb, and
>> ext2_msg is adjusted to accept that, as ext4 does today as well.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> Looks good to me. Thanks!

Thanks Jan - You probably saw the minor nit from the kernel test robot,
"const struct fs_parameter_spec ext2_param_spec" should be static, too.

Sorry about that! 

-Eric

