Return-Path: <linux-ext4+bounces-12356-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178CCBC36A
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B13300C6D6
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0073126B8;
	Mon, 15 Dec 2025 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xb8moBEz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A962E8DFE;
	Mon, 15 Dec 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765763683; cv=none; b=jUwd6wQpC3fLUoXuOIWv94t/yIAtNpMSxonY9oxn4u6bbrFqgbAj0vn26jgoyN7pjZi509slGJysQZNTgxRTaz/cimWZXj0LoAJ1xF+uUjzzGFphyDPKdgcHwMtp4rfIXu62EC2m/ahJkCrAWuCPw/+ybQ5KWW1xpb5i6hbAIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765763683; c=relaxed/simple;
	bh=YSVkXZUT/VY0EskR9QQgzFeKqVXPmTZaJxIMYGr33VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=s0+Grlx6kVsSCZwb8+WpWkCP5hKi5/LJLFn+Qr0GAlucaPhv/l1gEjTsI6yUeEwQuvnyfAfR8r0SC2dB+ZGeOJOpz0mIudCnAV8euErGxV2CAS1TOesl+ulkY+Rx43K8DEQv+Nj8Il7/BIaUKzdQIM61ko+07P1YldVfHoM/mCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xb8moBEz; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YSVkXZUT/VY0EskR9QQgzFeKqVXPmTZaJxIMYGr33VA=;
	b=Xb8moBEzOP/qzbXXlvVy2Y+031sdoSgJYeiu4wT9y8xjQPQM2BUOOT0dIh8O6Ah7VdL5JK3oi
	0Oi5BoaWvXvJfyPVIUH2WUqm3a9aUtsBekkJyYNSvSFzLk0Qk9q1WaEcaPkQVqNOW2NIwNssSR2
	qYwYlSabptIDaDbgwmrWF6A=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dV3383SCgz1T4Hj;
	Mon, 15 Dec 2025 09:52:20 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 61505140133;
	Mon, 15 Dec 2025 09:54:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Dec
 2025 09:54:28 +0800
Message-ID: <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
Date: Mon, 15 Dec 2025 09:54:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
Content-Language: en-GB
To: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
CC: <security@kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi,

On 2025-12-09 20:27, 余昊铖 wrote:
> Hello,
>
>
> I would like to report a potential security issue in the Linux kernel ext4 filesystem, which I found using a modified syzkaller-based kernel fuzzing tool that I developed.
>
I noticed that your configuration has CONFIG_BLK_DEV_WRITE_MOUNTED enabled.

This setting allows bare writes to an already mounted ext4 filesystem,
meaning certain ext4 metadata (like extent tree blocks) can be modified
without the filesystem being aware of the changes.

Could you please try disabling CONFIG_BLK_DEV_WRITE_MOUNTED and see
if the issue is still reproducible?


Cheers,
Baokun


