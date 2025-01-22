Return-Path: <linux-ext4+bounces-6193-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2EFA18CC2
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 08:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F561888F61
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178941BD004;
	Wed, 22 Jan 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="HDGhkdFS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C126AF5
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530955; cv=none; b=EdHbqSBnXW5xeI3KtlzEP3nELfWAdA4o6fu3fW9dKEl1sBqJ+DQ2Z3lHcSiTj69cYP+Uy9abEhhVgq9p1y3kQglk9fwpn/xgPtIyhD7miq6PB3ZFHCX0tdCZZO6HZjbAlA4ZYFeJWGzhHDStlkDajJvNC07994sKqs6eNxKABiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530955; c=relaxed/simple;
	bh=T4/sZ9cLMF6CsYhYVN60Hu7UdAfBd5IHXw8JzARLIx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqqoslcdIKxTcJVqvEpuW7wPGvQyJvUiYZYqrirqm9mLrsNuWZgSPyHMop2J5j7+OW6P2Wn7h/k6JrdRvhh2Os+5SA6rIiajZHsr8Wbize6cvYTC3JjasbJ1Uka1dRyHhUZ+SYDMmsdLZZzffu/EZTd8Gas5/ZKqeE3ZNX2M+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=fail (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=HDGhkdFS reason="signature verification failed"; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 2ED839F29F;
	Wed, 22 Jan 2025 08:29:11 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 50M7T9SE205369
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 22 Jan 2025 08:29:10 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 50M7T9SE205369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1737530950;
	bh=YZE75MdPy5RhAMOEjpJvDDZapSIHxjRxf3GnH+3ns0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDGhkdFS7vH/EIdvRTTxroSlPTvUO1rLeLVG0eRwLhxkY7YTbbMkvpmKHj5r7YoO1
	 Jp6WKPDZnulK1rQ36iwtEVslS/WUp7f/TTPa5DLjxIFAsJjJdtmBUXtKG7RhbLuyz9
	 uwd+e8b3c/tVPJXxDJpEU4gv6a8zj3dH1izOTa0v0ArPCNaZ8E58l0UkFgJ2s4BbON
	 TpfTmtKRDFKTgMr3DV85hzgF5WHqFWHn7qat1KUL+/yq7b/jqoj2qznyrLwWs15gT4
	 K5RqNcu9XPBMPXu99lEpqy/u9gFU0y/1Q8DzTVS40XAPIXGvnPPUjl7tooHfioMh46
	 n+3dJuJsYKwYLXNDzAXu/m0VoiqZDERRTg01UGkrQtF16342EfeuvCv+JY53PBX9QW
	 cMFz47fMlbgMD67VGlbVlX52BosyXOIHCCbg960GzdvFEIihQ+QIJY8VuAkjYSKh60
	 JTdkzvft7vxRRSYItk0CRnIKTTUMhYuJAg4byV3+xu6qzphL8+29rIvncVfQTfdIWe
	 QbbF2M3MUXgKAqFctjJqpIlkTJmAipb5t0TW6GUxBZ7fPVJ6SZctE23tlvtESbHdK2
	 R81Asqy/orcf4QTGZ4n1cT6UNDuaVXoI2Q9BWpNWcYZJu6VeO0wBO8jicIm7k2+2ts
	 EHBtFNR2w7ZS/i8cgXfNTBug=
Message-ID: <b8663f69-cdaf-4c05-b99f-cd4105023264@wiesinger.com>
Date: Wed, 22 Jan 2025 08:29:09 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Transparent compression with ext4 - especially with zstd
Content-Language: en-US
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <20250121193351.GA3820043@mit.edu>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <20250121193351.GA3820043@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.01.2025 20:33, Theodore Ts'o wrote:
> On Tue, Jan 21, 2025 at 07:47:24PM +0100, Gerhard Wiesinger wrote:
>> We are talking in some scenarios about some factors of diskspace. E.g. in
>> my database scenario with PostgreSQL around 85% of disk space can be saved
>> (e.g. around factor 7).
> Worse, using a transparent compression breaks the ACID properties of
> the database.  If you crash or have a power failure while rewriting
> the 64k compression cluster, all or part of that 64k compression
> cluster can be corrupted.  And if your customers care about (their)
> data integrity, the fact that you cheaped out on disk space might not
> be something that would impress them terribly.
>
BTW: Why does it break the ACID properties?

Typically the transaction log will be (and have to be) flushed/synced to 
disk (fsync). If that's ok everything is fine and all DB transactions 
can be forwared if necessary. If that fails the last transaction is not 
recorded.

I also don't see any compression related. That can also happen without 
compression.

Any clarification?

Ciao,

Gerhard


