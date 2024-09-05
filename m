Return-Path: <linux-ext4+bounces-4059-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61796D6FB
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 13:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DABB1C24E43
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CFE199392;
	Thu,  5 Sep 2024 11:24:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD067194C6F;
	Thu,  5 Sep 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535475; cv=none; b=lopGOkl0AawWqodyJsLut4b1tc/QB5gGMTuE3hBMLViFLk3cE7WcdBwZRemCBM3WyF9Fn60tD/CQSxITXWxc7bID3fDMm78j59WYoaArCuyQn36ZMOJInvAlAW9wFcxdief150JgKduaoEcqGOAima16dc749H30skNL08laovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535475; c=relaxed/simple;
	bh=fLMboQb8Qu9oFBXX+bXOvCVhklOX/x/MXZ85KuMfkmQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VohrLg3sPnA9D90huvo0eEU7UgN09QLybhDqNyxESAG9myhW5Y5CjqsaXCbM1u2F2K97gu8FzzgW4nkerUwOJG6+Wk/YW7Qq8Wj/62rPBavXq/kj8/zHoVhAElmMNxuT9tVCt4ec9gyrUAoIDXTTPqvauyIJeI4/rc5h7Oncn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 668bd4546b7911efa216b1d71e6e1362-20240905
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:05485058-c782-40ac-ae75-d8398362b96b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:7
X-CID-INFO: VERSION:1.1.38,REQID:05485058-c782-40ac-ae75-d8398362b96b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:82c5f88,CLOUDID:2bc65b23d8ae3ce43d96fa38e0a50cae,BulkI
	D:2409051924244XIMVH4M,BulkQuantity:0,Recheck:0,SF:42|101|74|66|25|100|17|
	19|102,TC:nil,Content:4|-5,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 668bd4546b7911efa216b1d71e6e1362-20240905
X-User: zhaomengmeng@kylinos.cn
Received: from [192.168.109.86] [(123.53.36.118)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 7353903; Thu, 05 Sep 2024 19:24:22 +0800
Message-ID: <471f1c8a-5db0-4bc7-aa75-5eaaf63815ab@kylinos.cn>
Date: Thu, 5 Sep 2024 19:24:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+d6a7a43c85606b87babd@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <000000000000f8878d061b2a75d0@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_fileattr_get
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
In-Reply-To: <000000000000f8878d061b2a75d0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: ext4: use memtostr_pad() for s_volume_name

