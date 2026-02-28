Return-Path: <linux-ext4+bounces-14230-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHKPDvSoomkn4wQAu9opvQ
	(envelope-from <linux-ext4+bounces-14230-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 09:36:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8D1C16FA
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 09:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CD6330E6FF6
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8823E8C65;
	Sat, 28 Feb 2026 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek7RWcc2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B11C7012
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772267394; cv=none; b=gOBTqGXp53m9qWflxBNmKhvRZ+K62ybMpzyxfWXp1vaZdQYFvdp9HqX4WUNV1fcyGOs3eHQ6yLZHo2Go5mvRQyn2+YU67zVeZCd9IisYpfhy7KS18N1R2x2WwgKlFgd2rC7U/Ewu6+CTjQg7QgaOLZegFv8UUq29ZztTCWCZkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772267394; c=relaxed/simple;
	bh=GSPUoSIz+9pB97rCfmIDKkMYJEqxB9ztnB1NXD4TE4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2lCbE8TBrzM/syXyw9DdV2EIGXTm8e5L0lcev6e4cx+vFWFvkfhltOYPV2K3/eQhfGMg6hWNN+HWBInFROoTJQnQyHKyI5sPEKQlW812hcX6la6J/FRinL8y1HKo8NmjqJaYttjg4IK9CmF9GC305a2o4r9OuJENcPqhb40RFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek7RWcc2; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso23007505e9.1
        for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 00:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772267392; x=1772872192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q8ZvKHkpjnAA8I/B72ngNzENTZUf11sap4CueXWS5I=;
        b=ek7RWcc21J0sLhfWlJ5S+z44a9WFVmZvavTh/so71Tv3oMJCb3XaVxVYV8E5mo6nQk
         l83NNlmA8NwXmNWw/btfY06BLZrFHbCq5gUu5fGJ+kwRyG9DUN/jExEIPhPE8McL2Ms5
         hDj3Gnb7DoPetI34CpcWRcyku7DUF5Gfj2T+isPt7urtOZGrFv9Rd9dzuzWEtd06Fy92
         DFIXwx9B/ACPquTZ2pF0jGM+o0ZEBzmLVvAUGnA/wI0znh5vPQN2Q+mWrBEJKGXeMc7O
         m9TMoUz5d5Tw8/jcP1LkKXJcbm6kWInV/vUoElI4tahIttUkNglx9jb99JcUv03qgLlJ
         ou2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772267392; x=1772872192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q8ZvKHkpjnAA8I/B72ngNzENTZUf11sap4CueXWS5I=;
        b=kcfDIJ5Y6VVO9cD0ok+BvwhmOIswNF75YEJlMXRibjat/7rdVWKFC0dyBBeKV8+X49
         nJnkgIkU+bYfNrW9RDsdn+wWug4prBT2AGLfavBEyRlPCPnD513BTnYUvwUN7Qn6yF7h
         Meqf3sW5xxxWE1v3KM/sHtnWEBwM3LvVa55da80SqTVrEOJnphqiuLRcXYII+GDnxFo6
         GeOPixZiL0Upz4ZZnpi8qBONbEgiQu/otdZ3qSMgVnFfZhqsfVKVt7BS0VkKrP52mxlg
         Y3jY+Md1HQ9mJWH8fGlOsnnN0qlIuke/w3FfiQ8IHvlnE/d3R6KRroJFJ3v6BIYaNL4O
         K/ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2ZgmyPm8YRXclyDPu5hY9jeBvgOBiVgig7LVARd/hOkSlJDFawUE3N/kI9O4Iu2uEWCtq2fkjz/j6@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGQ/OzJyP/knu7wYcHkWJRFnvta1BnwUjkGWVI7gFIagYphai
	81KcS++djl2Q4/lHCACEnYnXEQgMLlKh/9EYZXT75Bden0/KyBk12h63
X-Gm-Gg: ATEYQzwN7P2ZuDxWFQTghId/+vaW1h0ZmCCTdzqig96h3rtq23Tsd54wxYhgcp9IlQj
	HDoQ6QEMMh+0m30hxjnc0CRdDUoZ/OxklZMwnDct0DaZYS3RybA8Go2DRL43ERmTG3oK8Q02SXV
	Ik0aXxIsBctWSlb/l8jnulMIRwA7BgWYY9IAUbGDZdeqkUuCWsdvJRnrIRRcIruU6f6uDNy+klZ
	H4l/bgKQ4Xtj6trMq3mxMtjcUmHbKyrvYGSFF9bDZ/LWs8LHfrqDBC1JgX+zFK/Bq6kU6MiMhKJ
	kyh4AqTqFI00LYKcPTbpGiT1Dir66rAwPJhu+ZQTkoHqlMfSvB8rouWZ8zVosxBpZQ3/IIQClFk
	GAAipgOCvgnNBx4ELM0CVUvE7y2gSeUkE7b0AftT1oYVJsHrSf68t6ltwPvUiJuLNOVvYOIWErq
	Kh3lPUEbElHSg5cvquVi4F0CmHFUZRmKujoCscbpvGWEDtFKW6jg==
X-Received: by 2002:a05:600c:3e0b:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-483c9b6d539mr97952825e9.0.1772267391632;
        Sat, 28 Feb 2026 00:29:51 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm239122975e9.6.2026.02.28.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 00:29:51 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] INFO: task hung in filename_rmdir
Date: Sat, 28 Feb 2026 16:29:42 +0800
Message-Id: <20260228082942.1853224-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a1a0eb.050a0220.3a55be.0021.GAE@google.com>
References: <69a1a0eb.050a0220.3a55be.0021.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14230-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4,512459401510e2a9a39f];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B3A8D1C16FA
X-Rspamd-Action: no action

#syz test

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..34a5d49b038b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5383,7 +5383,7 @@ int filename_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	dentry = start_dirop(path.dentry, &last, lookup_flags);
+	dentry = __start_dirop(path.dentry, &last, lookup_flags, TASK_KILLABLE);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;

