Return-Path: <linux-ext4+bounces-461-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5D8149B1
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 14:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168E42825A0
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2302E623;
	Fri, 15 Dec 2023 13:53:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1452FE32;
	Fri, 15 Dec 2023 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Ss9Qx64BrzW8Q;
	Fri, 15 Dec 2023 21:43:21 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4Ss9Qn33byz76dgd;
	Fri, 15 Dec 2023 21:43:13 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Ss9QX2Y9pz8XrRC;
	Fri, 15 Dec 2023 21:43:00 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl2.zte.com.cn with SMTP id 3BFDgxiw098749;
	Fri, 15 Dec 2023 21:42:59 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 15 Dec 2023 21:43:02 +0800 (CST)
Date: Fri, 15 Dec 2023 21:43:02 +0800 (CST)
X-Zmail-TransId: 2af9657c57e67a3-52481
X-Mailer: Zmail v1.0
Message-ID: <202312152143029891646@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <tytso@mit.edu>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGV4dDQ6IHVzZSBrY2FsbG9jIGluc3RlYWQgb2Ygb3BlbiBjb2RlZCBhcml0aG1ldGlj?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3BFDgxiw098749
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 657C57F8.000/4Ss9Qx64BrzW8Q

From: Yang Guang <yang.guang5@zte.com.cn>

Dynamic size calculations (especially multiplication) should not be 
performed in memory allocator (or similar) function arguments due 
to the risk of them overflowing. This could lead to values wrapping 
around and a smaller allocation being made than the caller was 
expecting. Using those allocations could lead to linear overflows 
of heap memory and other misbehaviors. 

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 fs/ext4/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index deabe29da7fb..7a9afac1597c 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -302,7 +302,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,

 	if (len && IS_CASEFOLDED(dir) &&
 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
-		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
+		buff = kcalloc(PATH_MAX, sizeof(char), GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;

-- 
2.25.1

