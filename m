Return-Path: <linux-ext4+bounces-3059-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F991E286
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 16:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9728C333
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D516C44A;
	Mon,  1 Jul 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="woHIJPTO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A716849D;
	Mon,  1 Jul 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844281; cv=none; b=oCe0WP1zLr9Dj7k+S+rnX2GiLrYRDUaVhFo5b0PYaanu173OljWeRv6vRAnUhMHXpRp82x94LrAeBul+lrcw1zLo+0VpxJzT2sTokMwnbSoiEylc7HPG9JQujhaK36BsDGQ5LDNMHp+wsvE/+CbBooVKnmmgmZ7h6t7h0JBcza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844281; c=relaxed/simple;
	bh=kh4fd2Tt1g3FgPpUUT16nQDDaDmCFVlh5X1PX3Rz9RU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nSCws6SAKRbZx8u+4a6m8Q0VDt1IJh9wcnKtyxzVGBjCQE5WAS0aSUrNOtlNSVP0unCSEJFo3pabTESGKW1Uw5c1Iyk4FZ2T/wCKRN9rmoB/hmeHLNQ7sIOjs/dDKw7eGZyhjT/3NkSwWQJwcSa8RyuPeB8Xa1DWFQXw0WAmvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=woHIJPTO; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719844268; bh=oig2jSCI3rDtVcLntOJD59bkVH+SVdUKsJBtU3A9NPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=woHIJPTO5DRjvijRxgqfRyyE6eNzJxy3y5aP5Fq2WJDs17gcUF3EkUWLr6UfD+BJs
	 jYs1z2gUcsNn0Gg/VMSRcoaimdNjweUaY/pUXgR4Zdc+ZoPuZAgNCkTDUECSlGnNrf
	 1jNT3EwsY8sjT8OcMjOHJYgJZAP9CcXj4YxTiRZY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 642386CC; Mon, 01 Jul 2024 22:25:02 +0800
X-QQ-mid: xmsmtpt1719843902t011y0o3y
Message-ID: <tencent_BE7AEE6C7C2D216CB8949CE8E6EE7ECC2C0A@qq.com>
X-QQ-XMAILINFO: OCYbvBDBNb9r37I3PMSS14NyCwzK375aFroJL/YLh4ESeb9E/2KRMBm3bnUoev
	 BsN9N0Q6AMJLVwj1FimcZvUyQNyqlBeu6FkSPuHzRXR7+fxTcSw1iPKuWQdE1nSKaGpjNspgO75Z
	 A36YvFBGz1YNdjrvyBpUf8l6uh2hb/jvNGb0xm5Pmq0GHxLb98sgaBSy0P5EuYXj+SNDYr6/P1/q
	 Q8+ipEes29TcweAPo0VxoYy+gaEaaV0ffbWLYVKGhFTpwpfTfGJwVOOrNupAzGS0wYP96qrWEQij
	 4Q3h+L0zMcIzfJxc9Ep1m2Cx7aMVHyEZ+aXCjHE9qEDAy78bNhYEN0W6NmA25ND4/Kq0aSeuuWaA
	 UF3Z8iKQu3CqR8ymtz+8q/Q6tNFi8fzsZb33NVHUTkaV+gyyWRnyModF0Qp1u2k+99pChZSbhoFN
	 +tqMmXsY7nOZceJY1UFtMk5J06xIDsbbjCovAuQRFd4rq6TyOoEYF72VDsTqqDEf0mNHBK14R2sR
	 +vUSPc/q6byPXidrTStGbXSjv/LfVDFSvLaRZzBU/3XM3kIswL7kR8+LFKOo3hJiog83OYeL3IgR
	 FFo6iHMRACXWG/9rzrb7+JdvmqLdvf2Tzgj+XM7Jobhh3qtlikjz3MKKpLlNWOgVBX9a7A43znvV
	 eJZKVlviHYA+VYZS5qt+yz4xgI3tsPfuDH+vZ3bfeOGabsC4/37V2o8IcFzSBe4ZXUAZh33E9AHS
	 8w+4m+OscvCX/uJAdZ+W7+DA77SYWv+43Af04q8GyzI9hW1aN/xHxeFF1S/vAHP63pY59a/Ha/ny
	 /h146ZVPDcWvxUmMw42V4d9hLOlIB4FPxowtMzJN78IOz9CTVxYdV7776tJF5Lu5GGfsZtgfyqVI
	 hdthla8G9HJnLOSEViWZ4rTvhy145C0aim7NX+HNX3OwIslcipY7NTPV11D5Zjm7JGeMXLt8Ge
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] ext4: No need to continue when the number of entries is 1
Date: Mon,  1 Jul 2024 22:25:03 +0800
X-OQ-MSGID: <20240701142502.2973881-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000075a135061c0480d0@google.com>
References: <00000000000075a135061c0480d0@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the number of entries mapped is 1, there is no need to split it.

Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
Reported-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a630b27a4cc6..0a111274dc4a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2043,7 +2043,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		split = count/2;
 
 	hash2 = map[split].hash;
-	continued = hash2 == map[split - 1].hash;
+	continued = split > 0 ? hash2 == map[split - 1].hash : 0;
 	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
 			(unsigned long)dx_get_block(frame->at),
 					hash2, split, count-split));
-- 
2.43.0


