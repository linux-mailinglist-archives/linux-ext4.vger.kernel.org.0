Return-Path: <linux-ext4+bounces-6773-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142AA5DE7F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812497A63B3
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0C24BBEF;
	Wed, 12 Mar 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="FBYlemFF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmXe00dM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D331DE4F3;
	Wed, 12 Mar 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787859; cv=none; b=U54w6Qlr5OeuXsZ4gOQiQc4yO6w9kdCKCHEYH9vPkxbao5RUYzqIHOuYD4U7l20smkDzE97GvvMEI4gfIuggRStju7d/aBtcczX1lyEGSgoFsMrdrLTJZ8E4MYIeAk5iiw/aLvS8jdSULedcjuOX5Jxj56STgNCPZcIBNXzgXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787859; c=relaxed/simple;
	bh=ODfDxg+tJTObsFCxO5VxPB3pMoZ4NauYRdbR4yGqBt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQB5gY3DXqFuIBaVWXLHlV/mcPzGqhrXNSy+mc2viZ5R+0IUZSGXrt+vf4jV7KkBL3nH2Q5Tp+vE5AwemqN80mja0vxRv/vFHu1MeM//iL9dmcl0Qj4NVIj0PH0GYpiu+a+0BKSr8ggjGAuC0oXa33raTNQOaqVvli58rRtWiyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=FBYlemFF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmXe00dM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26CF61140214;
	Wed, 12 Mar 2025 09:57:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 09:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741787856;
	 x=1741874256; bh=aGA08pOCa7PBqVAWzUWhvC49r5KkslXTwLJRmZ2UPZU=; b=
	FBYlemFF3lv5nt9mxup3bFOgYf+pzRpYUDoQL8rSwFXacWiltDPypNEzIf3vJ5vk
	3210tGVU0oovG4ZD+Dk0qCrFy8EqqYDwzOczZsqtvJAI9+MpVcorkIAN1Cnut+cR
	QL0/ga0KKhMmN1OE17tVqdeVJHGBpZI28TL2vh7xvbw7XfEQu9gGah/Eqvk8zvJj
	rxPRW0RAkPXIhmLL5TuStkwzRvoBPOnHxawyXRMbc4/9pLqtecF8DgFELltTLq03
	+7rdSNMh+AY1L5eqY2kCP9tZeCNmf2q01/uCUFN7bS00axZzMfoSwjQZAVm1Xogp
	08CobRy+PeYC/9WeCRfKeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741787856; x=
	1741874256; bh=aGA08pOCa7PBqVAWzUWhvC49r5KkslXTwLJRmZ2UPZU=; b=n
	mXe00dMQG7jAFCCIOtU1z1PLyszJw1f9d1BFH4+BjfYdGnQ2NDeEl4u+dcTalJod
	7tZ0bhH75mh/fbjhJ5TS7UN8tyq1gbImYMlZJdrxsNW0yKQCwe0zqV8HsdASUiR1
	8epfgKGMc6Jsy8xUylsniV9nqyQan8pm8vxwonWvYQpP0K03ENJJ/CPWSqTtVwiw
	cYm2ALZL6hRPp5XsjEBQbjP0cqWArtbKOd9/TusdqftjA7MJjRQSWgGDlk79sdM3
	jY7tcpdFqrs3JhBGTFoT8T9j8CrgSZFrLdTw90b0D018Bb5Ia1mUcBhV3yKbnWq2
	w7S4c/yRMn0FkT3Yt2gwA==
X-ME-Sender: <xms:z5LRZ6N-H2Dv0HeWghV_VjP4hVbxVS9L0HhUsjHnKqygM8NSGfVOKQ>
    <xme:z5LRZ495aZn_0X1ZYewX1riGbiIDSCyAep1mXgNk39adFbzz5xnzSm1Uaodyz2aj-
    hErlAja5_jS1OVKRDw>
X-ME-Received: <xmr:z5LRZxSUUx4hLkEUbLsZ6UKQWLlAuCgBymDyVv4QkHTa4EyoSnc-3XS3afNnJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehojhgrsh
    ifihhnsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugidqvgigtheg
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthihthhsohesmhhithdrvg
    guuhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihgsrgho
    khhunhdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghhvghshhhkuhhmrghr
    ieehjehgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:z5LRZ6tw8x9KeaJ3cCng-0PASmOc0jHW3LhDUROiA3rsbpyMxWvrlA>
    <xmx:z5LRZydfyLWQsoLUGRnhVDyFka2e2MHZV1lHHlCgA5JwA5mQ2KG6tQ>
    <xmx:z5LRZ-0pqHZbfRoB42ooC1GLrfk94Okdn-2OUkJBwCyMcVwQA3NUrg>
    <xmx:z5LRZ29ZXjrJInFAnj3qdXGP0Fg13Bw38voT0qgkIo9IB06KSlnR4g>
    <xmx:0JLRZ4uF8G0_cWifODNA6oJa4pzMZDb9TxQiuyaOYDZ9VDdgGa_d5HcH>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 09:57:34 -0400 (EDT)
Message-ID: <ad999fb3-51a5-4a76-9783-cf2053c031c1@sandeen.net>
Date: Wed, 12 Mar 2025 08:57:34 -0500
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
 linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 8:28 AM, Ojaswin Mujoo wrote:
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2b7d781bfcad..d48e93bd5690 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>  	 */
>  	struct work_struct s_sb_upd_work;
>  
> +	bool s_journal_destorying;

Just a late nitpick and noted that Jan suggested making this a flag,
but just in case, this is a typo: s_journal_destorying -> s_journal_destroying

Thanks,
-Eric

>  	/* Atomic write unit values in bytes */
>  	unsigned int s_awu_min;
>  	unsigned int s_awu_max;


