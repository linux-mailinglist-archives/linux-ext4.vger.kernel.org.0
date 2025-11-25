Return-Path: <linux-ext4+bounces-12030-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B5C8740B
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C33539E1
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA74285C8B;
	Tue, 25 Nov 2025 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TkH+BA7D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5521A23B9
	for <linux-ext4@vger.kernel.org>; Tue, 25 Nov 2025 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107297; cv=none; b=WurWc++ux9XocIs0Q7kDZA4iQODQyrSn9GmcEfbrhia/llIPuRkP098+jEjaLDFywjvcxo0K1alMqvCs86n17VdufLDrKoy1o5AOCD2dqmE+q2SrLUP5lnztdjCSj7KR4GG/GBA/xjnsDj55dsvJZXx/NN8vSAbQv/NWT/W3YNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107297; c=relaxed/simple;
	bh=C6rD3/ZW2Bo/Hc0UZrtvkWqR9jYyTme36bGQZU6+gVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdBhy9cH83hb0MbZeYvVBs3NWu0qGbdcqpcdCjLwGYJWhqQqRcOYVlmozWZoIZ64c3VQqs6/ptmsOe9zsBGJRMJiYqTUg3DO/9yDqiv0aW18dbcWVLKRKGewPGJVycoJguU/+g20rlxIvoSk7J12sFVtf2QQaUUNVj3Qz5KGzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TkH+BA7D; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5APLldxE005693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764107262; bh=/1h7Nl3p+uq5ofv+L46i4rgGnhhqczHCHg7UVkyxfw0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TkH+BA7D8iR1g9giFJg5zAX0aCJwsOhi4AihwMCWd9eECiFKBBC+5jtmFNHnmQ+hz
	 srGQv3s2OzE8iZ3nZ4lyDDk+8sOMszCOpT4jKlfZIvJCcqfbFR72Rv3F2jW3Yrvf0J
	 vdCZlIFovtK/H69Iw70gbMZ18qxruhlgQreU2UTBrnJQ/CmxyAkyUZAxnb7cRh937J
	 m+tG3UWL1iFQ1Tajaoc8qScIu2zCTZ1yQeymVgHxQe+Ta1H9XrlNHceQ31xKTKirFK
	 HdYvgsvypVIu6zysEnTe9Iewz1TWtEl7WntLl7DHBtdUofL3FzsaI3E+ox0OngmroW
	 Ll98mLvXXcD+A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 2B8404CC466E; Tue, 25 Nov 2025 15:47:39 -0600 (CST)
Date: Tue, 25 Nov 2025 15:47:39 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com, libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH 2/2] ext4: improve integrity checking in __mb_check_buddy
 by enhancing order-0 validation
Message-ID: <20251125214739.GA59583@mac.lan>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
 <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
 <6mjxlmvxs4p7k3rgs2cx3ny5u3o5tuikzpxxuqepq5yv6xcxk3@nvmzrpu2ooel>
 <2d7f50d1-36f0-452c-9bbe-4baaf7da34ce@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d7f50d1-36f0-452c-9bbe-4baaf7da34ce@huawei.com>

On Thu, Nov 06, 2025 at 10:59:22AM +0800, Sun Yongjian wrote:
> 
> Thanks a lot for pointing out the logical flaw! Yes, you’re right—if order-0
> bit pair is clear, then without a single 0 showing up at any higher order
> we’ll never enter the `if` branch to run `MB_CHECK_ASSERT`. The code you
> proposed is indeed a better, more elegant implementation!

Were you planning on sending a revised version of this patch set with
the suggested change?

Thanks,

						- Ted

