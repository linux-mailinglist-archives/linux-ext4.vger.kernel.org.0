Return-Path: <linux-ext4+bounces-4258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A805A97E12A
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B0E1F21342
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C519309E;
	Sun, 22 Sep 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Wa2mPyKJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98A13C9C7;
	Sun, 22 Sep 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004807; cv=none; b=FETrHMoS2bikYyZwORbhVvv9xp1+HD1Cz3zM0OxnjsOXGDVD9WGEHp9UgbpuDUsvDTiesv2THV2heLguO5BwqU3quHj8DVVemprkQtDd66u358CHcBCIt2Ra9T4tMdSumwb+HztUVEgcjsOaND5nObf5/J9HZPopC68O2jpmSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004807; c=relaxed/simple;
	bh=/joLZmqkYGiWhew8IGitd+Ug4iIKNkPkowzkrEBRnFI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HMxWcHzcGvFHFgmAYQBU7qCaHBaqJMiRnSnE18ErjkcX2y5RSGfNnkOiRt5H6KpJSq5imcogV32lgZKAMiL2R+POsQVf2kKGjXTw9Ds02c01TA0LlcAJwtastlS7PM27Np8hgKbUnHfEXq47EzkJYYYrUSkpZwHwIkyD21Y1swA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Wa2mPyKJ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727004497; bh=VV+n9amUUkI7Y+C+ADQWGYSEkc3QvEW9zBZXsNeT2BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wa2mPyKJSWPwfYp6gtPqEW+5+IJeJtNzdA8Q4SZnYmuuHNAkkeZxrp06dcZ1VeXF3
	 EFFB5Qlbc+wVL05x7JBtcidk7I4dMzVVc6wGkiASbrVKzqPvPdoz/hIfelrF/aXY1x
	 TpB5/jbTl2ZFJzfd7TDMxRfqYvcth+LZQ3bEdhck=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 70CB188B; Sun, 22 Sep 2024 19:28:12 +0800
X-QQ-mid: xmsmtpt1727004492tsz6caa32
Message-ID: <tencent_AC4A33669E2C1B724B1C1BCA2552BA67BB08@qq.com>
X-QQ-XMAILINFO: ObFHHlrAm440/tR/OQKOlqS65Gu4z/JNGVE55Os+dmyyH4i0cvTeVBNIv+NT+l
	 BFp7dngJwqoNP5OTmoVyruFEdQ4A5OvVwiau4+daA/jWeMqUQ+6JJhZw2UcSFOZRIDfEqud8QHQm
	 CSqKyJnRUYVVfw6ypqG7P4UmGtPHnh4xwCF8todbU9oHiyke0OWp9mLr9ldtT+KbzwtiCUEoag19
	 pZV7vNqt3yUbuMYHN8pQPwSU+WiF786k3Nn4G78mL24RTCDEuoTJxRb9S1RqGkhBnyZ4GlUrF56x
	 YNx8Z4uGkL4KHET973JPFrpJdsWEuouVctEQHog8HsDgR39GYF8X5oAJfUbjnN+9Ym4XKNiF4Qds
	 gydfPQqtjPOrLdnW433R+LYbiOAkYh2ZZLpTpyQXeNR8+aaFM5y2URkwAc9UVzKMf50rqlqDaEyM
	 owhCsB1gRq+LCgq3TPvJhtCKHpqMNh9PppzlZvquo1Y+ykY7LkOLXc9f+7oPcssX20g2J52JOHyb
	 ZMznc/fmJUEwamWCjsINPskza0+o9vyyu7046UVt/yYJFii0KlapKWyDL3lPF2KZ/A+RElKrLrX/
	 PiUNwZYmG+g3nBRlXLdXPO/L1Bc9M6BkSK5g6DURkArdh4Of00MEg2klkVEhb8vyati6Et7lFSaW
	 54KYM19kkt1w2njkaR6Prewjx+D/b5NP4NED0mM4GekPM6NO/QWlinBDoKiJaiDVpFr0Q4aYk3Ki
	 cUh9urRcFUlHMhCFnuymsG5r5DG80NIzqtPPIQSZS8Ph7H/rMScBNwNUZ936x3/gNqz2c9bSNo1K
	 An8nRqJ+Xg2aw+JBamLTYvpVLlnCtgGZUAeP124tNP/dE7k3L3HnmEhAM17medhBGHpt7ADISEdO
	 lZCZHCy3Gu2diP7hXZ4CpUPnGaEtm0Yjz1haopGcsKE87NHz46ttM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1b2d1134e0b675176a15@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [keyrings?] [lsm?] [ext4?] possible deadlock in keyring_clear (2)
Date: Sun, 22 Sep 2024 19:28:13 +0800
X-OQ-MSGID: <20240922112812.2082719-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66eff723.050a0220.1b7b75.0000.GAE@google.com>
References: <66eff723.050a0220.1b7b75.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use GFP_NOFS

#syz test

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 388e656ac974..b6fd9e909b79 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -977,7 +977,7 @@ struct assoc_array_edit *assoc_array_insert(struct assoc_array *array,
 	 */
 	BUG_ON(assoc_array_ptr_is_meta(object));
 
-	edit = kzalloc(sizeof(struct assoc_array_edit), GFP_KERNEL);
+	edit = kzalloc(sizeof(struct assoc_array_edit), GFP_NOFS);
 	if (!edit)
 		return ERR_PTR(-ENOMEM);
 	edit->array = array;


