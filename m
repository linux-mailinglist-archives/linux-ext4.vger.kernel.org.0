Return-Path: <linux-ext4+bounces-14699-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLrNFJNuq2lqdAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14699-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 01:17:23 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF8228F35
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 01:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9DA5304C0B3
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2026 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92C23E330;
	Sat,  7 Mar 2026 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YSS2pQGM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C025FA29;
	Sat,  7 Mar 2026 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842619; cv=none; b=iuoKX4+kTLcFhgTbYp6afAJS1jqchqzNBgFRPWFl8kxPbOl7gNgptjWUJejGOeMs+cOJK+62bONphQvTZO3L1Jjk9wh7t3kGr+PEPceIgq012kFlBgfkOV2JF1dF92U09hnDlsC/rWhFNg/VY3Rj3EveT5k/f2NVeGQBg0sFODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842619; c=relaxed/simple;
	bh=bG1lD7YvUm3cXv0rKSPVWhKJ4XrMsusCcd+0FjvB1UU=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RuAxk5hFpzpgNoBIC7BRu9hmttqeEafLmKRjXn8Xn/2+zfMPtzQVaSJvzfus7RdTPREurvtVnAXCQ4I/RBhbN2IVzgQs6BxoxqK9EoI2HKFY32qEu6GoMPMJl5/JxkN+cpCC2c7XQBEL9TCnm7VPjUpF7QaeyDGKOD8fh/xSdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YSS2pQGM; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bG1lD7YvUm3cXv0rKSPVWhKJ4XrMsusCcd+0FjvB1UU=;
	b=YSS2pQGM6g1NjFDf88+5mLv/95uS0Jp7vl92ZRQXY2FwQWG1NaEJoqE31UQ/m5mo2Mwg14ZWD
	vsvQTuyTfqOyN2YXLOGJrCbOfaGkEb1YXZRXlidGSsaZ4a9w2hI+pYsInqbm5EKKErX3fRk14yG
	9tj+xISN3Kfp65BLdSNmMfE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fSNxB634jz1T4GS;
	Sat,  7 Mar 2026 08:11:42 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B2EB40561;
	Sat,  7 Mar 2026 08:16:48 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Mar 2026 08:16:47 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Mar 2026 08:16:47 +0800
Subject: Re: [BUG] kernel BUG in ext4_do_writepages
To: Xianying Wang <wangxianying546@gmail.com>, <tytso@mit.edu>
References: <CAOU40uDHsLY6KOor1A-uuozEn8yJgF+gmQx_MLnkU6oSnyAERw@mail.gmail.com>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69AB6E6D.4080007@huawei.com>
Date: Sat, 7 Mar 2026 08:16:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOU40uDHsLY6KOor1A-uuozEn8yJgF+gmQx_MLnkU6oSnyAERw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Queue-Id: A6EF8228F35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid,pastebin.com:url];
	TAGGED_FROM(0.00)[bounces-14699-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,mit.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2026/3/6 13:42, Xianying Wang wrote:
> Hi,
>
> I would like to report a kernel BUG triggered by a syzkaller
> reproducer in the ext4 filesystem writeback path.
>

There was a period when I also noticed block allocation failures during
write-back, but after the configuration was changed, it didn't seem to
happen again.

> The issue was originally observed on Linux 6.19.0-rc8 and can also be
> reproduced on Linux 7.0-rc2. The crash occurs in the ext4 writeback

Can you identify which patch or which patchset introduced the issue?

> routine while the background writeback worker is flushing dirty pages
> to disk.
>
> During the crash, the filesystem reports that no free blocks are
> available while dirty pages and reserved blocks still exist. Under
> this condition, the writeback worker continues processing pending
> writeback operations and eventually reaches an internal consistency
> check inside the ext4 writeback routine, which triggers a kernel BUG.
>
> Based on the execution context, the issue appears to be related to the
> interaction between delayed allocation and the writeback mechanism
> when the filesystem runs out of available blocks. When the writeback
> thread attempts to flush dirty pages in this state, ext4 enters an
> unexpected internal state that causes the BUG to be triggered.
>
> This can be reproduced on:
>
> HEAD commit:
>
> 11439c4635edd669ae435eec308f4ab8a0804808
>
> report: https://pastebin.com/raw/dNFvCatE
>
> console output : https://pastebin.com/raw/LAPYKL5P
>
> kernel config : https://pastebin.com/7hk2cU0G
>
> C reproducer :https://pastebin.com/raw/v07yFCWP
>

Can you add these to the email as attachments?

> Let me know if you need more details or testing.
>
> Best regards,
>
> Xianying
>
>
> .
>

