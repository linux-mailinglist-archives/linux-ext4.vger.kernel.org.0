Return-Path: <linux-ext4+bounces-5394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A709D856C
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 13:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B597AB3C7F8
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBF196446;
	Mon, 25 Nov 2024 10:53:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D89195381
	for <linux-ext4@vger.kernel.org>; Mon, 25 Nov 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531997; cv=none; b=SY+H6eZakumuK/IVcqQQukXNLdMnAWPNmlbdgE1VVfj/FsU2x+nwhhIu8ocrM76msPLZCI7imViJiOTmhLaIqxWlWsCwCpz/a3DtNBB8Wlno6nVeCZRAE1mta5bVmpDTN2LvxxPScE3TBbnTPtub5i6zz+WLmaYGtWArkd4N0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531997; c=relaxed/simple;
	bh=0ID34OV2cxjnjPpNIv6Pze02a0yYp8TnSEA4zPf8W48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9DWk4JZHINQpIoKZShn3FcdelV2G4KwJ7Ia6EGd4ybD76CxasOGgZ12WRMTc30/TlVlIl8qu//RNutQBWuw7jG1uBs/v4qlXXqcGATL1T4WfYCcEY8BXCKFLStP3eCwS1ka4RjE0b2au6KfX6g2ymlKVYI2pI5AXr0ev8/TepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.110])
	by sina.com (10.185.250.22) with ESMTP
	id 674456EC00001EC0; Mon, 25 Nov 2024 18:52:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8749497602596
X-SMAIL-UIID: 89358ED7F56A4D449A108EDC536286F9-20241125-185232-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in get_page_from_freelist
Date: Mon, 25 Nov 2024 18:52:20 +0800
Message-Id: <20241125105220.1566-1-hdanton@sina.com>
In-Reply-To: <6743e5af.050a0220.1cc393.0055.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 24 Nov 2024 18:49:19 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177ab75f980000

Test the idea [1]
[1] https://lore.kernel.org/lkml/20241122155451.Mb2pmeyJ@linutronix.de/

#syz test

--- x/mm/kasan/generic.c
+++ y/mm/kasan/generic.c
@@ -538,7 +538,7 @@ static void __kasan_record_aux_stack(voi
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
+	alloc_meta->aux_stack[0] = kasan_save_stack(0, 0);
 }
 
 void kasan_record_aux_stack(void *addr)
--

