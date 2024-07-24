Return-Path: <linux-ext4+bounces-3405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D593893AC13
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 06:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E841C22BEB
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 04:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8264643B;
	Wed, 24 Jul 2024 04:56:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751FDF5B;
	Wed, 24 Jul 2024 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721796992; cv=none; b=Cam0l+VgP2IbpGFZpTPko/16JPH9xbjbROh4f/lfztO/38uNicrQtCqzq7o8PAEXjhwtHW6cz623SafdpEWBqqMtC/JgyMrSegINqgBlxgzflvSSyL/gi2qouk5DhEtHbj+jZEdfAF6yc0Ds4FpA0ZRj3CYF/PJcB4BVQ9Fw0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721796992; c=relaxed/simple;
	bh=ojRQbAahHTByEAfI1eOYOni1gIRLm26bkB+y4at/GTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2xoCCtM/oq84UMe4R7aKS/a2mHFwmk8prUxrwp86xulIbQdUDkSAx8BvVaH+ip2SGYpq3ilTDqPYTrTfQVEpWDY+fjMZcmDlY0mfSkNOO5chk4zCUsUVZ4VzI6q6/zThxoB3KbRG0NufytH1OfU6JKqlA61WukUUBzhBh/FnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip1t1721796955tn1j07u
X-QQ-Originating-IP: ngYma45+Uyq6qWUH9KZ71PKZU1IDMA1Xub2T+rMrxJ4=
Received: from [IPV6:240e:36c:d5d:2c00:58c6:db ( [255.146.199.5])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jul 2024 12:55:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17571171907496050409
Message-ID: <206F8E88DD4C4DD9+5197bc65-d440-4ad5-8b19-e1f83f4a1c7a@uniontech.com>
Date: Wed, 24 Jul 2024 12:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4.19 0/4] ext4: improve delalloc buffer write
 performance
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, yi.zhang@huawei.com,
 jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, niecheng1@uniontech.com, zhangdandan@uniontech.com,
 guanwentao@uniontech.com, chenyichong@uniontech.com, wentao@uniontech.com
References: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>
 <2024072316-thirty-cytoplasm-2b81@gregkh>
From: WangYuli <wangyuli@uniontech.com>
In-Reply-To: <2024072316-thirty-cytoplasm-2b81@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Hi greg k-h,

As a commercial Linux distribution maintainer, we understand that

even though upstream support for linux-4.19.y is ending, our users'

reliance on this kernel version will not cease immediately.


They often lack the time or resources to promptly migrate all their

devices to a newer kernel, due to considerations such as stability,

operational costs, and other factors.


Therefore, to provide a more graceful conclusion to the linux-4.19.y

lifecycle, we propose backporting these performance optimizations

to extend its useful life  and ensure a smooth transition for commercial

users by the way.


Of course, we appreciate your suggestion and will prioritize backporting

these optimizations to linux-5.10.y and linux 5.4.y first.


Stay tuned for updates. We are committed to staying informed about kernel

updates and community trends. Thanks.


Sincerely,


--

WangYuli


