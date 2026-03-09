Return-Path: <linux-ext4+bounces-14710-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH/ROdSfrmm2GwIAu9opvQ
	(envelope-from <linux-ext4+bounces-14710-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 11:24:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D997236FB4
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 11:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FBC3042B4D
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2026 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8240438F229;
	Mon,  9 Mar 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M96LMfqK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CD256C84
	for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2026 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051856; cv=pass; b=Uv/dLEvoEgIKfpthDAWxpOIv3djCk6uqtWo64mmJsV4pLhLTpIXFx8yhvBb96MjXPBqLi8AmdJ7GRQBWNfQI5ZQZyjxmSnezDyz9QWl/DIY6S+Nf89qGIWnTbdaWhaTifFBw0ld2YFNdALNDcb6Ugq5bD2TnJZAgj6QJMbR8R7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051856; c=relaxed/simple;
	bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ooJgbgrHqFNXQ8xghinJWBXHlFl2L8D1JJMmiN2/HXQu079ChjoKWLLLoUzzqCH24/Ne8Ix8gkArLMMiIJ0yV7GOd+8erhzqf1Mbyr/w9HxDKb8sLBti1oRxC7+LNlW6k6LbSp39eGdEBAHVdtL1Wb4KfxLx2f+Y1arEkhC7OHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M96LMfqK; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so7045574241.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2026 03:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773051854; cv=none;
        d=google.com; s=arc-20240605;
        b=i52CElFFawmUC0zbrDZUQs59FedPf7RBSHyrYWhy2R0CaD81npwEXiPHpq/2gEFl4x
         /8w2bozLiOdNzS7oh+5HzNSJkWlugKpAQaKMe1ui6NwRjGo917lqM78lXBYs5mMvvhS0
         1KYflU91WKAPrVqkyyRsxaIhGqB0KXJYsROMaACMK8uyKTGACFXbsqt9D1vLnjBdjT+q
         UYEaMz5/ZDGVh1YeEDeN1v9VwHcAFE70heQkKwe8DGJtjiQhrrcXvh5Xi2qZ8skOGdsh
         z6pgpAY1SSemeJ8V3dXqVEzdODWx1rauOMx4viyZ9WOibRfcRLyRHniMHsUggMi2AMNg
         Hx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
        fh=2Z7dHjX51cTdvdyNVf3rvSXAtPiZZN/HmmKtz1S3QZ4=;
        b=EMpfFJvnLHJ+lzLVHwn/Joo29mD2bqwWtXISMh9FlC/X8OIRz70gH85XVF6Qkb61Lv
         yMlBISWtlnSDyDKuPkhndfBv8QgP0ZaK0tvaGkreU/52YjiD0IfyTg90G7nFa5o4duop
         QowxLeN2h91tZV4cy16io5J+rDgEeUlSJBpVs4ZX5XSnoUJM9k8p7aTj0Pj3rN7m74ta
         yO23QA0BRYy0lP611y3fVOALdA06vRR9UvvlJweuRLP3M6P5hAjvLyv5hSZkOht1kOCZ
         rEgymauoFYhcw6bdt2EnNpWjx8zdXY4w2Sl7mBM6vkvfIRhOvcQK8OgVftERUnnxRvAd
         VJDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773051854; x=1773656654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
        b=M96LMfqKaJvEVJwEIlT3gVqm6jdVQTb80uRK6eoj5smIxK2f6vuI80tebqRdgbT5QR
         qi3+d1OvKq7QoJq1Atf7F2rwe4Wz230Dt9v9liy2XF+pjmVVjEHuYSPACelsE4BGVSOm
         Ef1BtPy9fgGpnusP5JzQYN1+5V7itjtuPuMNC72PGbNcJWYjGRoxQIFH4SfySr1JR9h2
         e/zuzTLUbXqYFfByZ91cO10htAYaQg+NlrOFh6h0hWc5YlNWmh2tSc0b3+HhIW4e2e/U
         ZBcCnD9TyPpRF2pF9tr8y0XPU4X3U9TOrpaw6516nswxKikZ8kmdOSdE50mofZAmhn8G
         Bfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773051854; x=1773656654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfjcpKlEgFWwCO8gJ1zijvCoQmKxg4JNjWavrbN5RKg=;
        b=sDfWIbWrBjMPgPqT/+f38IjCIoaIg6bJqhEyNijcpBpYkWhlFIa03NbCnoVsx56Rvi
         XAPt/2ZKGiMjZnne0h9lMc1tUE6j+FuGajqkw1uwrRpQOfBxbSabdkPB6++SANJ3d/PA
         2zNKm7C+P6jOepEXcduEc9aq1BiZmcXqCH+gmWyL8Pp5lAO8bi+QqbD2DXdp+QzKAU0A
         eQmk2dzqcJXsYc3uN32DkHJUw+Iz98+vbC/ColzPbuL+c5eu9vySVXa+I5EBtjJwHKro
         6wzVs+nakRo/AtKaEqeYBVaQkXHAtR0YrxLl/u0HMCwwbbzI7/31bGWl/U6N+Qe9whjn
         O3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUqC/Ezv2zcSMpLYl62IA9OdP74p6JTNF25MFRvKBX5K2wOFkiiLdQQg2SCQPbM+KbE003Mn6wCdh3P@vger.kernel.org
X-Gm-Message-State: AOJu0YzZitwwkUEn9tM0UEMG5aOY8HOsf0EWGWYHQpyaznQjXszj9T17
	TG1dw43js1QJhmHpCgkVGLzqmZmtRen/EQMQio9KGkARZF6mVzZUd1EdkRqYhSk9GF923TTlaXy
	ZbCg3UjfjFMyAgCxQWxaJBAi2dGwC6p0=
X-Gm-Gg: ATEYQzzFrdza3GeTRF0/MrsyZHCYKCS/nBM2a5hLvoddEwVQUXTjN26/L19imW7Yhh7
	mQei8CHzhDhKzegr7ARZ3+kv+2i9fZ8SnxlrUAXV0FgFIgtoXJsJs6ZcW3n2Y4TmITzNiSwY3nz
	qPxbN0bOn13RKcbStLsiMZI+qvCr5XtD4u5n3joHphDqRjsqz03xlheD5Tt5I3CK/P5+JSn48Wp
	fPJDTKxdxbMbB1/340GPxZgQV8oHenWpxTu38P/CywXQMrcNn2v0s4rAotk0Vkzfrq4hVzgzAxP
	Etrh3lI+BF2YqNne+CKuadULYo5YCBDHwb8wIKywAMDlqk+ChQ==
X-Received: by 2002:a05:6102:6cd:b0:5f5:2539:9b11 with SMTP id
 ada2fe7eead31-5ffe5f75506mr4624398137.14.1773051853948; Mon, 09 Mar 2026
 03:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Mon, 9 Mar 2026 18:24:01 +0800
X-Gm-Features: AaiRm53pzT5XMRFBWgfUI9kvmtqbtHPHoXIqvUIc-7RG_c2omjGbqGhVbNcPkgU
Message-ID: <CAOU40uDriX5NCfac2iK70z-M3Ea9pTMvTHtPGz97HKXbYhrjdQ@mail.gmail.com>
Subject: [BUG] WARNING: lib/ratelimit.c:LINE at ___ratelimit, CPU: kworker/u16:NUM/NUM
To: tytso@mit.edu
Cc: jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D997236FB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14710-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangxianying546@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.865];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,pastebin.com:url]
X-Rspamd-Action: no action

Hello,

I encountered the following warning while testing Linux kernel
v7.0-rc2 with syzkaller.

The kernel reports a warning in lib/ratelimit.c triggered from the
quota release workqueue:

WARNING: lib/ratelimit.c at ___ratelimit

Workqueue: quota_events_unbound quota_release_workfn

Before the warning occurs, the filesystem reports several EXT4 errors
indicating that the filesystem metadata is already corrupted. In
particular, ext4 detects that allocated blocks overlap with filesystem
metadata and subsequently forces the filesystem to unmount. After
that, during the quota cleanup phase, the kernel reports a cycle in
the quota tree and attempts to release dquot structures through the
quota release workqueue.

The call chain indicates that the warning is triggered during the
quota cleanup path:

quota_release_workfn =E2=86=92 ext4_release_dquot =E2=86=92 dquot_release =
=E2=86=92
qtree_release_dquot =E2=86=92 qtree_delete_dquot =E2=86=92 remove_tree =E2=
=86=92 __quota_error
=E2=86=92 ___ratelimit

During this error reporting process, ___ratelimit() receives invalid
parameters (e.g., a negative interval), which triggers the warning
about an uninitialized or corrupted ratelimit_state structure.

From the observed behavior, the warning appears to be a secondary
symptom triggered while handling a corrupted filesystem and quota
tree. The initial corruption is detected by ext4 during block
allocation checks, and the subsequent quota cleanup path exposes the
ratelimit warning while reporting quota errors.

This can be reproduced on:

HEAD commit:

11439c4635edd669ae435eec308f4ab8a0804808

report: https://pastebin.com/raw/yJp9p1dM

console output : https://pastebin.com/raw/tyPquTTH

kernel config : https://pastebin.com/7hk2cU0G

C reproducer :https://pastebin.com/raw/Sh3a62JM

Let me know if you need more details or testing.

Best regards,

Xianying

