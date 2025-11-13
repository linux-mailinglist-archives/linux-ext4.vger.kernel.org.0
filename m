Return-Path: <linux-ext4+bounces-11845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4CC55852
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 04:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463963B64B3
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Nov 2025 03:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148E2D8362;
	Thu, 13 Nov 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oTHfrGei"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42797287246;
	Thu, 13 Nov 2025 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004063; cv=none; b=L7dBlwsNBRkcLGZ74QHQ1TprVR9DfjjOKKn42aHfo1yspmlBtuSb0gfs4/cMVXeYDaytCB4w7SgiLjI8WVhtPikmapBNoIZK0V5vx0+h+8rz33UolxjKvTQ4GYq++hON88BjFEM37XzLMgRyH7VfdcVCbzGkfw2RGIbPjemZEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004063; c=relaxed/simple;
	bh=ryt8NBNeYBKtSQ2wNS6OvcnNhOnC32nJB8RRh2zkFLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qj/nRBsjosjbvF0FNb/dIQ9r1/AoDrihv0H9OaKUF5sbauc4fQuUcai/wKdMSj8af4u9gU7YQ4K4+V75w9tI7MD1tn1eG8aK55xEGHQbfmbo7piR3T9+iDYfC890dfgq6ttKtHHjkXfBXI9LGmvOMxDyP5CAUFxInYeNDPDqyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oTHfrGei; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=9czSu55DU8ELZPxeDi6A75ZeMV5mctPic4yTTwfqo9k=;
	b=oTHfrGeifFhVpo0ATdk5BUIE+NTzigZ9F4l+PxBkeJSo69Rs3n8cXvpenvU1Gz
	MiWPbHLPghSEBaHezTVaYb03ICevvKJYopURyh6L+GeMlrGust2Bbkg/OOvd/kek
	MGH9WBXuaTlkUNV9rbgPq7T6lVo/M8viZq+QABeUN4NMg=
Received: from [192.168.18.185] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3P+B_ThVpUX+dDg--.29065S2;
	Thu, 13 Nov 2025 11:20:32 +0800 (CST)
Message-ID: <04555a4d-ad6a-4ca4-9698-098cbfff8f6d@163.com>
Date: Thu, 13 Nov 2025 11:20:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] jbd2: use J_ASSERT instead of BUG_ON for checkpoint
 mutex
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20251112102914.82278-1-liubaolin12138@163.com>
 <xjdoodv3rxgz74sfqoosfr6jt2td5zdxz55t6cuqknua5347r6@hfkq6e56jsmx>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <xjdoodv3rxgz74sfqoosfr6jt2td5zdxz55t6cuqknua5347r6@hfkq6e56jsmx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+B_ThVpUX+dDg--.29065S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RME_MDUUUU
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwgBTHmkVToD6mwAA3c

> Sorry, my intention was to unify all the BUG_ON statements in the jbd2 code to J_ASSERT in order to improve readability. 
> You made a good point — this change could indeed cause conflicts with future patches. 
> I’ll withdraw this patch and not submit it. 
> Thank you for your review.



在 2025/11/13 3:29, Jan Kara 写道:
> J_ASSERT,
> J_ASSERT_JH and J_ASSERT_BH


