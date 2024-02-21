Return-Path: <linux-ext4+bounces-1303-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C285D3B5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119B2284BD8
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E13D579;
	Wed, 21 Feb 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VUlKEg29"
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF43D39A
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507993; cv=none; b=nGVColVoe0U88F9mFoFGYaqUcHZs0DGojKp75bqpgk8O/yXI8Bmi8br6l80RtL8bouyqxW32gWTSVo0O4+xztdJGzvjvSWgP9l4Hs6buI2bnJYumLJWOoHQdX8UjHWGfDK66UoeRC/CH8FXJiDD7NY+n9urtNtONQcn3BYKV8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507993; c=relaxed/simple;
	bh=xXwl8F/5kkproMQilCsscuBVrbTeMoF6+n11uuXUAR8=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=uL9m1LfzZz6T6SXCN/hnJFGYZHxQX15ZYUgXq2Es4NE6c02isSGWmaWm81anj5d+z7vIsLNci8rH6Vzn0tRKCtgTvpLNJow+4c5P01G8wmtfb//7mBfLc/pSqJ2k1ZzCW7/IaFwJH0/o79xm6n1VD+cI8xaqEgteFEbqa2CbvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VUlKEg29; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F5451C0004;
	Wed, 21 Feb 2024 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708507985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8sgqKHEMOfRlHzKHv543qpuMIxIu6/2xNhMTCObUG+8=;
	b=VUlKEg29qY277ejpROpJgg+WmP5+T8erb/rh1H5alF/CRz5B1r69TYAd6YZhoUdZSiiS9B
	Tim67YWDqptEGMp/+yK0QjJ+iFSQPdlAb3FXbprXBZLz5rQ2WyakyXgUwBpQdPYbTUx/PD
	TXL6ewdnrr2pHtdPWIyWZckNINhvrmFa+0WaqpwkoFU2vb2yF0p5fJdSRnYmUjdi+xE/k5
	RkH/OxPspqeV8bjV0pmt+EyfCljuDXL5l7AmFn/VW80yrYAAML4tJKymMzCIHt81Pxhop5
	gvjx0IwQuuEsMz60yP2tQpxRYpnDIYZVKPIrreOU2EovfUakcwX2KjdZQvSb2Q==
Message-ID: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
Date: Wed, 21 Feb 2024 10:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, linux-ext4@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Language: en-US
To: Jan Kara <jack@suse.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Why isn't ext2 deprecated over ext4?
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Greetings

I'm wondering why ext2 isn't marked as deprecated yet as it has 32 bit 
dates and dates will rollover in 2038 (in 14 years from now!).

I'm asking because ext4, when used without a journal, seems to be a 
worthy replacement and has 64 bit dates.

I'll be happy to send a patch to fs/ext2/Kconfig to warn users.

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


