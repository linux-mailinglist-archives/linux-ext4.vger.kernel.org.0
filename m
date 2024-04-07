Return-Path: <linux-ext4+bounces-1914-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FA89B050
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C6E1C20BBB
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E71799B;
	Sun,  7 Apr 2024 10:13:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF914F78
	for <linux-ext4@vger.kernel.org>; Sun,  7 Apr 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484807; cv=none; b=IZ9k0xZdNv4lu7rw91L4CfOBt5BHD9ouL4kc9fLafg0ufc/yr68uSLheaE2nc5ip7VZ9r7MoIASSlkpkynS44eY+CtYsn83hgUlpWWGc8Rben/921UFEnHe3W1pwO39d5Qj/RSKg85FxuMllwNHuo/tgPV7+ydmdVmR8L1xfJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484807; c=relaxed/simple;
	bh=OFyVryUc1NGTKhISapajWNZecBVQ/pCkLD4WQ9yiwRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tch03eUmSMlezfLZaQHgeAVkvXU/LCDbARfRIrQ29IkbSiCDIVEQDW9yKLwBfJGg2ezWvq4YfuOodyCP6X1yM2O+p7H+4a+nj/QBoGK2t8WUd0oOuQ9kHTJd6cIL2zo5CaVTiLQHYdRWGVKoMUwN9tSIaUt7k4xoJaI+ul6WVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VC7Jm294Rz1RBb5;
	Sun,  7 Apr 2024 18:10:32 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id D09941A0172;
	Sun,  7 Apr 2024 18:13:21 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 18:13:21 +0800
Message-ID: <01581bdd-bbab-48e7-bffb-6d3e50f39398@huawei.com>
Date: Sun, 7 Apr 2024 18:13:20 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
To: Luis Henriques <luis.henriques@linux.dev>, Theodore Ts'o <tytso@mit.edu>
CC: Wang Jianjian <wangjianjian0@foxmail.com>, Ext4 Developers List
	<linux-ext4@vger.kernel.org>
References: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
 <20230817170557.GA3435781@mit.edu> <87ttkl6u13.fsf@brahms.olymp>
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <87ttkl6u13.fsf@brahms.olymp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

Hi,
Let me test it and fix it if it fails.

Regards,

