Return-Path: <linux-ext4+bounces-14194-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP/DBRUnoWlmqgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14194-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 06:09:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C61B2CFC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 06:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 723C030774E8
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A03563E1;
	Fri, 27 Feb 2026 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrzxnBYE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A74301701
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168978; cv=none; b=RK5cZrARc2aYY3JIwKmHsWwpO2y5AYV6KYcxE6FKziWfdf3+6VRTIhAwj1MdQ9+rvq3GU0uVwu0QqVFI1XoeKOFeMSJ/tyh14vAXfNi5e/+ShuIJkPSY//9Zws9Wca7GZYk7LJl15ajFWE5b8AiXOMAIb43TmZxiUAkzueOuZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168978; c=relaxed/simple;
	bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKKJtBcWI8gO+bVaeAogpqZQOKv9AGLgYjbntiswV8QbDqkl0cLxdo37cfUcrKOxO8+aWCUffuDWG+Y2b3H5LQwBWCAA+DFV/qL/ssr8KNErQY218on0dbaZ1HsufviFO3FdxeLP1ROufi1spqz5/qPUrop8g/HfZIfNbN5yQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrzxnBYE; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcada445fso946601eec.1
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 21:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772168976; x=1772773776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
        b=CrzxnBYEHn9vUStfzY4v6bKm4ZPvs693tDj+q6G7wFkOCGVTsgYVUp/U6c2gA55YEW
         YZuTOEQw3ELZreuDcShcR/s9fwQqTxqf0MfRbaUZsvZylSDWytSdfkbwCSO4L+W2U/o8
         CF0Nkbel1EMwlVzMJf0LRp6aC4CGrm/BwskhcyJfAbI/jdPwGyWfuJFTSaGvKo92BsFk
         qBUlnwuDKu9qHjkUv7ri8CYVsaIddKrX33lOBYP9ImKnSHbLCIdVUUDVwujFOb6gozTL
         kJjqv9lyOxtmdsVVadaMyDm3n3DhEyNII992Ls4OvKwlaS2D2SAuKQgRGXM1G+SxzJl3
         eHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772168976; x=1772773776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
        b=LCo62e3dSL6DJyBFYORehTN0FV2846UhEBuq+jnrI5BlxxATppgXzQSn+tvrWY48gG
         rcX6dL4X1dPFMeIb6iEc0+Pt7ekQQGzqQWgVMtg742D2daXIBTzI7fcLMNifK08b6/KF
         MQvZSTnvuyRnT+5xwZ2fsz9FlIyvzS7JxCimhsx5PXYPxFFfhV0YRs4W+TpMkwC+BNm5
         m1f3IcDq1a14d3aFpwNzHmJsRJ0PJvrsi8x/CeDFW6CbpnAb9paw86PGweiYC5yaMaVh
         2tGs5GFJgjKd9XXlSQzZGoRRdZqGHpKzXRJQYtKhtqn8JZu0617CYfNHCy6q6DzW3DoI
         +UPA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7pkUmgqv2cCaUs4P9zr1Oi6XzxtU1lJTVBv3+OpL9tdJRN7CMdaqlo6WYxQEDj/JwFzloGtCBNLr@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLeQWg35Xx195iz1cPcV65vE+mxzrToWsZMZLF/+ZJsVaL4Tl
	o5w1DlEubkj0HCJmCf13zBi+nBtgse5NRcXG4TESy5P41U8ZqeUlj7oa
X-Gm-Gg: ATEYQzztaqIr8Os/JQ25wU+s0kxSaGRfvU4ZHJGiY0LDu+Q+ubC394emGYSdgaO4ADd
	gCHbK4GBXkbOn5uGXTUpgc6piYvHbOUvYa0/H+rNMQADU+gozmO/Qyu8skmfNwVD2xOPSUwjRJr
	JKJ6OrZ4NRkMK+sJSyvPfLguDic4LG+wAY4O6yNYE1qtMyJ3+Sxg0uZzHBJ7CrEcG03pIUB683/
	P5HLmanP0rVz4wYnD+mUYRnKbdfzCpiZLnYb2W/SFK4PzLQt30cT+YRacEx4TDW3lm39KonHfU9
	8Lk7vdYwqsuCQrSD0h2vto4H0414j4hpL2BBVQddURHNFY7v5snV52skA0749YZP81mq9TBYpGX
	fRH+8sYr6QFfRw80/ZLXTvo5Iry6TKcgz4cRNhd3zWQCL0cxu+ztgyHFJxLMWLIM+PsP/6ib7MB
	vDj6XzII0Kf8TWiGDi9kzxMbO4wj5g5kT4NJSL9aBSvP5gTRFfMUjR+b4nsRNUnBCx5/volLR0N
	5C3rn4etkcBmb+QYUC89sg+F1Jx9R8/Xt+FTY4iZNZ4DyprHvFsyfhkn1gCiNR+j+fj5qBAd7Ug
	uy/Oe+niykLgQpfnMCoBWGn58l6E
X-Received: by 2002:a05:7301:168c:b0:2ba:9fad:8fc4 with SMTP id 5a478bee46e88-2bde1fbe776mr573431eec.5.1772168976246;
        Thu, 26 Feb 2026 21:09:36 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f4658esm3267735eec.25.2026.02.26.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:09:35 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: nikic.milos@gmail.com
Cc: jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: remove stale TODO about kmap
Date: Thu, 26 Feb 2026 21:09:34 -0800
Message-ID: <20260227050934.16189-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207002908.176933-1-nikic.milos@gmail.com>
References: <20260207002908.176933-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14194-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 858C61B2CFC
X-Rspamd-Action: no action

Hi Jan,

Just a friendly ping on this patch now that a few weeks have passed.
Let me know if you need any changes!

Thanks,
Milos

