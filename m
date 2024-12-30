Return-Path: <linux-ext4+bounces-5857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BD9FE336
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 08:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C6D18820CE
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BA19F13F;
	Mon, 30 Dec 2024 07:27:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023E19F13B
	for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543637; cv=none; b=GwbGiibzAF7oircVuVDyKhS8buEAoSIE34SG83HhKf321tKjQgdgLcQg+MCLiXB6asMrc7zy3XgyfBUx7thq9U1fHaSnDFU5K+KKTYVTT0W6oCn6wFGWN4L/khRvRNziJvI3Em5WoTcbxvGHYKLwAvrvcQEeSyxcLQXdyoLfwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543637; c=relaxed/simple;
	bh=KhiOBbCZlEURtVk7B7216KE0e4250KVGHQrQY4ckWO8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=XOnovy5Vv6P7gDHkuwtn3/EpDqL50156ivMBYChyEy7bEN5BGpI7lTcRxYPCY8MrtnADjhAUrIDXQy2JnJowH8dGJy+W4BG42nBv7qH0Ng3CjEEcUWqc/CKG3Dxf9EETZyHPRvV8HJMeWbpIKufLoM1D8IyQF5sKxRPj88E2TsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YM6zd0xqBz1T77w;
	Mon, 30 Dec 2024 15:24:13 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B2591A0188;
	Mon, 30 Dec 2024 15:27:03 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Dec
 2024 15:27:02 +0800
Message-ID: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
Date: Mon, 30 Dec 2024 15:27:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Jan Kara <jack@suse.cz>
From: Baokun Li <libaokun1@huawei.com>
Subject: =?UTF-8?B?W0JVRyBSRVBPUlRdIGV4dDQ6IOKAnGVycm9ycz1yZW1vdW50LXJv4oCd?=
 =?UTF-8?B?IGhhcyBiZWNvbWUg4oCcZXJyb3JzPXNodXRkb3du4oCdPw==?=
CC: Christian Brauner <brauner@kernel.org>, <sunyongjian1@huawei.com>, Yang
 Erkun <yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)

After commit d3476f3dad4a (“ext4: don't set SB_RDONLY after filesystem
errors”) in v6.12-rc1, the “errors=remount-ro” mode no longer sets
SB_RDONLY on errors, which results in us seeing the filesystem is still
in rw state after errors. The issue fixed by this patch is reported as
CVE-2024-50191.

https://lore.kernel.org/all/2024110851-CVE-2024-50191-f31c@gregkh/

This has actually changed the remount-ro semantics. We have some fault
injection test cases where we unmount the filesystem after detecting
a ro state and then check for consistency. Our customer has a similar
scenario. In "errors=remount-ro" mode, some operations are performed
after the file system becomes read-only.

We reported similar issues to the community in 2020,
https://lore.kernel.org/all/20210104160457.GG4018@quack2.suse.cz/
Jan Kara provides a simple and effective patch. This patch somehow
didn't end up merged into upstream, but this patch has been merged into
our internal version for a couple years now and it works fine, is it
possible to revert the patch that no longer sets SB_RDONLY and use
the patch in the link above?


What's worse is that after commit
   95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
ext4_handle_error(). This causes the file system to not be read-only
when an error is triggered in "errors=remount-ro" mode, because
EXT4_FLAGS_SHUTDOWN prevents both writing and reading. I'm not sure
if this is the intended behavior. But if the intention is to shut down
the file system upon an error, I feel it would be better to add an
"errors=shutdown" option.


Regards,
Baokun


