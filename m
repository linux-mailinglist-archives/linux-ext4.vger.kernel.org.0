Return-Path: <linux-ext4+bounces-13526-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMrnNdBkg2l1mQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13526-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 16:25:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B9E87CC
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45704304DC53
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFC42980B;
	Wed,  4 Feb 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj3PZO/p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461F426691
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217746; cv=none; b=JJicwD3C4k565VNa3L9/6Z+a/0FaIzb686L1WFL0h7Nix5JDSdMCTaEyFWvw4SuJ0Fgj2UH4FAwL9VT1KgY/xwUUArIrb9+PKXW+rBC7fBqY2I8roispyJL99s+kj0A0rXkTQYnpGgiZY3RXCYBILv7DRLaP9n3CsEBWjhxFglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217746; c=relaxed/simple;
	bh=s+h8tPFEoHBFyC4SszIfcNz/5tQ5uQJuxvMFYcXuaM8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mdRbUYWOWCAoUE5xFCJASIHBdwpoFypDnbvx6o2IXSTLUnh0wtRZD9KoQBqJmIaHQzVbqBgtYm2QEn8FzevLiQ6CG9toZfrD4HMieixhgZPayrBek7HiT2nd428L0SUhsUCzPVkJN3FO7aQ4svaRAfw08oiS5kcwJfvIkexWlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj3PZO/p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso5710395e9.3
        for <linux-ext4@vger.kernel.org>; Wed, 04 Feb 2026 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770217745; x=1770822545; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ9HeuGtWnUm+VotOezBkdkMbFGZUlFL8p7rfJPrtMg=;
        b=Qj3PZO/pnfM50AEt5GMWK7StT5RjNUtkWVl11H4oerhL3jyP+fZpD8TP62yZSoapCM
         8Yl0hTD40V9N3/jML56A7jNjwD4ktswoZVHohefzuD/SmWAgOXUsSXFwb0Vr+KEhN7Lg
         /9QINvG4EUnYWrDcLmmMhfkhdsP1aZVHodO7vSs61OQyC/ZE5Euq1VoWoFy+Lb3RW2Co
         hZquDE3cXWBCSmSGdAtIib+LoYICX8poPnlgytxdxvW2IZehsGx0Jr1kNGRnR/95AzzV
         /XzyFaFA7Fya9TcK8TFt36IQMkP+WysS7hFriG4OP8KuJQWsgoCRca/3V3LLh4GwVg5w
         4nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770217745; x=1770822545;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZ9HeuGtWnUm+VotOezBkdkMbFGZUlFL8p7rfJPrtMg=;
        b=vDG6BTee/PH3m3t4CcLvK3iNXKxeCCVy3/Q9JEbzgTjIEATH7MgkcpoKnDCHxRuJ36
         3Expoae4CJQQ2FRCHHb8jcOOivYuBDA8R2lo6N1Yblm7FfII8FW0D6HWXdy3EvBTQGoD
         FgbTp+X8QiDpfpBUa8DZAq3BFtjHkhKV5YWyDJLMcSWk2oY+grpmn06HmskAoWJY/lIi
         xzfzMCp6XpXWvKrD+IAVcHdQV9TfdxxmZFmBGylSGy7dcPYkqo0j2bVzze3s960YJCmJ
         Pd69KWRTZaX6PfiuNyWinG6gY6bBaEh8FGCALwePPXS09RwXQ4/BoV1+FKO50QCeJGke
         WHfw==
X-Gm-Message-State: AOJu0YzWJih/5beAgfjtqMpigj7mOV1FY8+JD22/1r7UbkWMwq1xvKyl
	UiavQe0c4muA/DwzWCZLwTvVi5bVYRALBWjIKNp9X8es5vrsMXZKGWffZXzkRw==
X-Gm-Gg: AZuq6aIKsoye6NPB/EsZT7yG88sdUXDNNREb3HkkXUvLT10+U+81BiehMlVj6qZq8GG
	pChvC2JHlTAnjLhoos5B+bM72jxCrKEm3WZp7bmnYXAt18i5yzd/SMMmtwLRkTiFa4tW1EXPzkx
	Lt8IlwqlDHz3GMLdDyrwh+HhiEg5Z8iZW75xawOV2X+ivpg57lRi09X1A8b0PFn7pFLKDWIAWT/
	SHrK1Y8Xy4rg4rAa4k9VX39IlCMxBNnITL8wxwRbJbxGvpEg+eVvu0nrU38ujMZsfi7CQu9JNnn
	WwjL46Y19LjNhjvmx98O2CPWQbq6K/5N02F7ecX9hjxJJyeEsQ4jnyxKOBoF+HBDEHUFTGYOFBm
	MHoexxmFqpxbJna/pQ2UBq8GVTdkDT7wIX8JQhqZ+KRVUsbJCQ/Lte5N0BykKNxRZm845rn/3JI
	d5CFB4WrmrS5mAzDxbItrdN5U=
X-Received: by 2002:a05:600c:608e:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-4830e96d1e3mr50311575e9.24.1770217744455;
        Wed, 04 Feb 2026 07:09:04 -0800 (PST)
Received: from [192.168.63.97] ([193.247.225.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec10011sm34600875e9.0.2026.02.04.07.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 07:09:03 -0800 (PST)
Message-ID: <8feeeec8-7330-47ae-9b54-9e789ebdfae5@gmail.com>
Date: Wed, 4 Feb 2026 16:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 anthonydev@fastmail.com
From: Simon Weber <simon.weber.39@gmail.com>
Subject: [PATCH v1] ext4: fix journal credit check when setting fscrypt
 context xattr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13526-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,mit.edu,dilger.ca,fastmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonweber39@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.com:email]
X-Rspamd-Queue-Id: 995B9E87CC
X-Rspamd-Action: no action

From: Simon Weber <simon.weber.39@gmail.com>

When creating a new inode, the required number of jbd2 journalling credits
is conservatively estimated by summing up the credits required for various
actions. This includes setting the xattrs for example for ACLs and the
fscrypt context. Since the inode is new and has no xattrs, the estimation
of credits needed for creating these xattrs is performed by passing
is_create=true into the function __ext4_xattr_set_credits, which yields a
lower number of credits than when is_create is false. However, following
the control flow until the fscrypt context xattr is actually set, the
XATTR_CREATE flag is not passed by ext4_set_context to
ext4_xattr_set_handle. This causes the latter function to compare the
remaining credits against the value of __ext4_xattr_set_credits(...,
is_create=false), which may be too much. This flawed design does not
usually cause any issues unless the filesystem features has_journal,
ea_inode, and encrypt are all present at the same time. In this case,
creating a file in any fscrypt-encrypted directory will always return
ENOSPC.
This patch fixes this issue by passing the XATTR_CREATE flag in the
ext4_set_context function. This is safe since ext4_set_context is only
called when creating a new inode (in which case the context xattr is not
present yet) or when setting the encryption policy on an existing file
using the FS_IOC_SET_ENCRYPTION_POLICY ioctl, which however first checks
that the file does not currently have an encryption policy set. When
calling ext4_set_context it is therefore not undesirable behaviour to
possibly fail with an EEXIST error due to the XATTR_CREATE flag and the
context xattr already being present.

Co-developed-by: Anthony Durrer <anthonydev@fastmail.com>
Signed-off-by: Anthony Durrer <anthonydev@fastmail.com>
Signed-off-by: Simon Weber <simon.weber.39@gmail.com>
---
 fs/ext4/crypto.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index cf0a0970c095..5b665f85f6a7 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -163,10 +163,20 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
      */
 
     if (handle) {
+        /*
+         * Set the xattr using the XATTR_CREATE flag, since this function should
+         * only be called on inodes that do not have an encryption context yet.
+         * Since when estimating the number of credits needed for the new inode
+         * we called ext4_xattr_set with is_create = true, we need to pass this
+         * flag, otherwise the check for remaining credits is too conservative
+         * and may fail.
+         * If for some reason the inode already has an encryption context, this
+         * fails with EEXIST, which is desirable behaviour.
+         */
         res = ext4_xattr_set_handle(handle, inode,
                         EXT4_XATTR_INDEX_ENCRYPTION,
                         EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
-                        ctx, len, 0);
+                        ctx, len, XATTR_CREATE);
         if (!res) {
             ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
             ext4_clear_inode_state(inode,

base-commit: 4f5e8e6f012349a107531b02eed5b5ace6181449
-- 
2.49.0


