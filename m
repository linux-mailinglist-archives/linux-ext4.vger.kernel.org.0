Return-Path: <linux-ext4+bounces-14193-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFa1CdMmoWlmqgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14193-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 06:08:35 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809551B2CF2
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 06:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92D030EC855
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 05:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1560D362129;
	Fri, 27 Feb 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UINITyhG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD3301701
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168904; cv=none; b=t+5MqXdHSXpOh746Gi8rmgXTuHs4Hx2Ksn0CFRH1faWVEXsOshTWS7d2LwYeCuoIrILD6fA7xMoTAHfZ6Hx7/0+t+G06WEZxhLQ7eZMT8q4icCFv4xkt+GRauTWSLaMD4tuPU1x9jG5tdFVYRlCjT8hBwv++XsKUIf1BDT6yL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168904; c=relaxed/simple;
	bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MP1/DOrjAxmcmceNUhP42kZ/Mp6cPfPbe+T4mSwMXSUq4Fn0No770ESmQ1ILfsChbScTVgyF8QU/BuLsWy/DfLpzTBWLruze2Y9v4Vc9zWghQndBP7LCsM0LTvdI/njGMV09wBB+c2JhBhrGoNnQV3b9MY6IHNNOLFzdY+tw89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UINITyhG; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdbe434b47so3680378eec.1
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 21:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772168903; x=1772773703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
        b=UINITyhGd457pUnPCYtdGdjQPd+LoPsMzL3chrAUX97yQrZf4jOtek/V5qZRUKnUA3
         8LpL5Ptk5ZgK3AGBADh02KJ30n4OpxYfEBZe8R05ePn5Z1MZJHkfMbawQBMs45wGJGJe
         HFfRBHMw880aJxs018/zmSi4AcOBTwcheDmjCUVAr9/7lEgX3+X2lYZXuSyDh70P3lyc
         k8eKvQq7H0lG3zCq1kJiEsl3UDLhLJbn5rtkfhSJIso2Vo6unluhrzkR/8SIiWsNsAPj
         mO6YaNKRjztsKvnBlfCBK7QH+Q348RTc0YCvLgmkrbsImROAa30EzFYjkwdVTV1ztbLF
         o6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772168903; x=1772773703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSGHnBJ5pNX5vyeUAoVCHxB6L3jgL0JJmCniFSp8230=;
        b=VuUaSbP26yovURMvnccVi8cHyV5Xfw8C0qZJ0c9Kz5VwncfyE6DquKl1tfmt3oOBTy
         7zWz5CcGJK+atbhXaey0GJJbEfyd49MI+1dHo+hZ9dklMn1uthYsw8fZ8xJ2tTgnWtug
         QF5c13emQ9WCWzoD5ZGinH5XfgJCZyrOtA6G1uTjw7Vycs9B7A618nSATwjWFrx7uGYz
         5FVX151t+E2a+mfyBXwlyqpJpDup/h0rMpCuWUeUGpxsxhvvscfIjFuc9vm9btpqvWtk
         fJMwUi87Ykdhmj/f7bwxCGrNl2c5pLeSksIXcRqsMZbj6hnU32d8eeBYJfRhknZaq05o
         Baew==
X-Forwarded-Encrypted: i=1; AJvYcCXQPlHf54Ph+/QDFZZiVQjZ+rzlKBybdxCehplSBw+q+2xDDSq9JOb3ihA6BYT4oC4GVXquJ/eR5+tK@vger.kernel.org
X-Gm-Message-State: AOJu0YwklEEZulMJll2Jf0I5tcG2O2nLS01Swaqx30OZdhb3ZJ84mxY2
	WiWitBpeeYVWsYWlYqTXm5DlwjbqJgZnES7r0xlZ/F4cPgF6eJ0fgc6E
X-Gm-Gg: ATEYQzwYdPD2Ea2PpYQi80i2bfpLcFnMn8X5zyBOV3lB+e4U6NyqEpst5V7aTnVPMjz
	dxZJ3aHL+nJlyAuRoFgu8PY9Vyv+IHFd4r2R6soIonJyxx4oV87t6h+LbxcGuDQxeGa4q/ueQHx
	L+1fvNSwH9Byoj4/zNSW/vIOnOtcDfgjMzcQRUyQfQeKYuMKGHrYe1a5PhIlkAvHlEuvdINAcUV
	HmAmRi3+fUFBhQVr3EPmnJ3tE+QBF5Je+J1b9yElmBC8NEXdrqJ/DTInC4nIFPxEdcQuJR4Fn9I
	pKLcfqNwuvN4WtzcqFP89bHoZpuDn/cEdIdC5gRT/s5xlh2cwzjZZKXM5jdJ5XVbNOdVY4A4s2i
	QJeeRhhQUv487husfh3tT6z5jv68EpUkMnQlPJ21dW2OTFC5XeOOPXWZt473CbQRDX3oAi7efF+
	bisV/Uy82PcBkH4Fzsk05AhTVN5O7Aix3cF4OIgdz/4BIHO8TjD3vyA+GgKiDsBJPQ4X5kYtfjD
	B1v6FhkvrspJFJlFqUnklXVoFPAduROc0Tx/bX5C0k2sWZpFoCrULFKw7hgDO7CkObu/7KFemgY
	FtjX6U7cPLjZMY98nHyKDihMmTYfXRB5blITN/I=
X-Received: by 2002:a05:7301:2b06:b0:2b6:ffb9:9633 with SMTP id 5a478bee46e88-2bde1ba60a8mr673463eec.15.1772168902613;
        Thu, 26 Feb 2026 21:08:22 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7e68bsm3198869eec.30.2026.02.26.21.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:08:21 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: nikic.milos@gmail.com
Cc: jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: replace BUG_ON with WARN_ON_ONCE in ext2_get_blocks
Date: Thu, 26 Feb 2026 21:08:19 -0800
Message-ID: <20260227050819.14920-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207010617.216675-1-nikic.milos@gmail.com>
References: <20260207010617.216675-1-nikic.milos@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14193-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 809551B2CF2
X-Rspamd-Action: no action

Hi Jan,

Just a friendly ping on this patch now that a few weeks have passed.
Let me know if you need any changes!

Thanks,
Milos

