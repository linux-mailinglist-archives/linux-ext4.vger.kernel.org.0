Return-Path: <linux-ext4+bounces-4187-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C7F97A30A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668B81F226DB
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B5157E78;
	Mon, 16 Sep 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tOUDN05n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A51581F2;
	Mon, 16 Sep 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494083; cv=none; b=ISK5RfT+noyn+ekS906gDuBhuJrZtbYDK0IpzduoxU8yEOr+W2sJ5tmbrw7xCnzFv++ztpS1wGMCnWBCh98Lsk8GvkIxqapooAwOHAMjkI5OW3oWbAPgCJwQAwDrbSYmkjBB/AACwY3LFYR27VobZKOhwQrO9sUcG3FQscJOB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494083; c=relaxed/simple;
	bh=iVysvC12xdv+/H9Wu8iAikCy/mEsz8wn3qeFoaJqMaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHmnpGYpQI3ikaCcItdSpLvPoF/+zP1nMiIU4qESc2GZRb3IkSZEDiBrpOnMdk3+eWqed3Mrqsz517hS58LA0rS0KLCGyaMmkLwPMjHwdV7EtvugcN9zjjh9bq00U5YPHarn2byQXnBBQgQxem00DAwR4GCi2UEctuUtynWJHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tOUDN05n; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X6mK73Gl8zlgVXv;
	Mon, 16 Sep 2024 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1726494069; x=1729086070; bh=f0Z28i3bhewUsYtouX9tkRcz
	F8CS2uoUmp73FJDJGSk=; b=tOUDN05ne0g4zHU6/tJE117VerMmS0lAc9haPukG
	oBxHQ7MntKzJUPcBfpkn6oZXrs262CSXmClXllycrQ4fCgd489WtoISqbvIsEWSR
	jvcEu80wYON49TWca7yRdkSASU5DAPWhoamRq+1uBzTAjhnD+rgzdJJasgGrnven
	u7COsAANEmC5M4nO+K9sbOOyEg1Lsw9Npb/Vq1eBD0ow1O9iXZCeYN+Ndz+htFs8
	/9w8gYO99nMK4Z1PUOdXOTfc/SUfnINfruvBd3+tkv8RJfy9FX3NlXHIoQC80Cqo
	iet9GTSN5PnySvhqXzpwv3ZJJIyKJ71+EA+H72V5C9k2BQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tkhQZnikgkjk; Mon, 16 Sep 2024 13:41:09 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X6mJx5HlkzlgTWR;
	Mon, 16 Sep 2024 13:41:05 +0000 (UTC)
Message-ID: <da2d3fb8-b4b0-457a-80fa-a3eae5c8e1fc@acm.org>
Date: Mon, 16 Sep 2024 06:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>,
 adilger.kernel@dilger.ca, alim.akhtar@samsung.com, avri.altman@wdc.com,
 beanhuo@micron.com, hdanton@sina.com, jejb@linux.ibm.com,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 syzkaller-bugs@googlegroups.com, tytso@mit.edu,
 wsa+renesas@sang-engineering.com, syzkaller <syzkaller@googlegroups.com>
References: <00000000000039fb2d05f3c7d0ed@google.com>
 <8e13233a-2eb6-6d92-e94f-b94db8b518ed@acm.org>
 <CACT4Y+ZvEjpX8a9VW4tS1YSP8RE6xjb8C9ae6PcSa0rr-q+62g@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CACT4Y+ZvEjpX8a9VW4tS1YSP8RE6xjb8C9ae6PcSa0rr-q+62g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 6:28 AM, Dmitry Vyukov wrote:
> On Fri, 3 Feb 2023 at 19:11, Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 2/3/23 00:53, syzbot wrote:
>>> syzbot has bisected this issue to:
>>>
>>> commit 82ede9c19839079e7953a47895729852a440080c
>>> Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>> Date:   Tue Jun 21 14:46:53 2022 +0000
>>>
>>>       scsi: ufs: core: Fix typos in error messages
>>
>> To the syzbot maintainers: I think this is a good example of a bisection
>> result that is wrong. It is unlikely that fixing typos in kernel
>> messages would affect whether or not the kernel hangs. Additionally, as
>> far as I know, the systems used by syzbot (Google Compute Engine virtual
>> machines) do trigger any code in the UFS driver.
> 
> Hi Bart,
> 
> syzbot has logic to detect commits that don't affect builds.
> It hashes SHF_ALLOC vmlinux sections to check if the commit actually
> has any effect on the binary:
> https://github.com/google/syzkaller/blob/c673ca06b23cea94091ab496ef62c3513e434585/pkg/build/linux.go#L253-L286
> 
> Bug CONFIG_UFS_FS is enabled on syzbot, it has some coverage for it,
> and strings affect the binary (can actually be the root cause for
> bugs). So I don't see what else can be done here automatically.

CONFIG_UFS_FS controls whether or not the UFS filesystem is enabled
(fs/ufs/). The UFS driver is unrelated to the UFS filesystem and is
controlled by CONFIG_SCSI_UFSHCD. Support for the UFS driver has been
added recently in Qemu. Does that mean that it should be possible to
test the UFS driver with syzbot? See also
https://patchew.org/QEMU/20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8/

Thanks,

Bart.

