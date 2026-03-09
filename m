Return-Path: <linux-ext4+bounces-14712-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6qbmMO+5rmmxIQIAu9opvQ
	(envelope-from <linux-ext4+bounces-14712-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 13:15:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B42389DD
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 13:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9783E305FE7E
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2026 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19C3C6A2C;
	Mon,  9 Mar 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzi/zzC4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026003BED6F
	for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057938; cv=pass; b=uKyqBceScFkae80DNdaYATycRPny2+n9RJAIkznBGe1HELfbexj9FH45TN2ipyCeQs10mLgIRcXEqQ0uq/VrbU40jL1Jh6IACQNITrqCEEDDa2g+O0R65/sOVuLKgBbA5ebQOx6ygx2Z3clkUVGPiJfnmA9CALiGY2C8wk9DMfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057938; c=relaxed/simple;
	bh=VUWamRrlBHxufwBCPIkAdMtCeJ3/2HIUD9EIOqyA00E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XQyiKWvp3qJHiXxr3l0p+kY2TxYQNdgaKN3wyeZcT6g1ckKrlDw4hAoYGkd82Q5oXk4r/ZvsXktAn8CkbaDZSffhKo5eXfZKdYFjMq6oO6wtynF0byJ6RySQ1x4ZD2dznDfww6ErjOK85glNoJD1oMyWFZCJ61hOEwwoHZGyNuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzi/zzC4; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1994152a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2026 05:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773057936; cv=none;
        d=google.com; s=arc-20240605;
        b=MfotlKaRKGAhlw1V0JLfqUIU7Fk/Hbmo6PrTmqE3IDoaH8tT04FiIctL9IRy9V+jIC
         oG0UAhXue9XP+fdFUfqh8AZ4CRCLeMTYS1WOfrV9appyqs51I+Mdl2F2bQjTfww+dWgq
         7oVDr/tYZhBiGWZxWbaMrAoVF/SanZaTxoBudsaXfl9VcbwsPEXe8uMZJNOUOj8Slgtb
         W9i+wbBYB1Ei24yc+8yUwhCO5LvQ5VsYXcT7Q7BPoN+bIBhf2I3CGOHV6wZVEGvNMDjF
         1ZN07WUom9iGEeqNH6ok0wQNfD7Fmii+jvWJY2ioJ1ilkD4Go6Een6FdrBut8YBW1v0T
         R19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=U+OxVBWwx07EELFqhFehTn+mP40UXv8vOlZQTL9ipv4=;
        fh=QiBJn0fL7pgj2XE8m6Inxo/6mioSAz71ZtZtEZ4NfqM=;
        b=g4uHJC4YM3aXPR+kr5k3pO4w08AtVuWLl1gNwqIRPD05JbciHJF0Ca5z/N7W7aHVE2
         PegTqVWFrP3UwIWz7P7XdhP521f7ZVtDgQmn4h4PfbIDvwAQg9++mPL6SOnPz5PhUyOT
         sFz3jrF/nVGUmMB+AUrkuLdw2+Tt/xRhSgTdd8CHTwXDR2cTzktHbD2yB2C3H1kAs1Hu
         df/g9pI1p036bfcO6a/2z1g1dTJMf9r/7Ny27VYUVXKekhsu3Ka9hpCAcTEQBhvKdwPc
         9up+L7uBqk8Tz4OgBZxGTk1ePc77fdHhH5m9NCVRsCJxo6tLRH7ug0YYIWxVGPOJrPE0
         8MbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773057936; x=1773662736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+OxVBWwx07EELFqhFehTn+mP40UXv8vOlZQTL9ipv4=;
        b=Uzi/zzC4sJ/bfXZterLKAEuZU1stoVhr/hpAHNxQaz4P1todnApJi0RPmEhtfywKA8
         270XFT1V563jYpeBGi85iw6OQORwAbGa6TeYxkSA52R39DUMUvkNpULEqjC/mr2sPkUU
         J71yN1U3oYlYPmCY4vYdxIU+oHr/jTNvD8LxqTn4xREncQ8/jlvNPHTYvOgTAX6bo0jI
         oq8vNc9dbxt21RsCgRZqOsUl5cIWd6g5LpzKo4sGFc/r+k8dXYC3B6R2YgLZbz+O/Clh
         f8w4nRFW5lCVl6vgTNHgP/YzfbnAkolMH4mtgoc8ofvhhcnn1sgoBm8qHrlrXmHN8KI7
         nX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773057936; x=1773662736;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+OxVBWwx07EELFqhFehTn+mP40UXv8vOlZQTL9ipv4=;
        b=jW5fuz9k1/Ua5kGvQZqn9U9Qp8jy4VKZIwTTWXd6NshJzNuBWrAGHvXpRlvgdrRGyU
         91/4mOyKpw/QCm7nIMi0zdsyXX+Yvvcw55w4PRqZM9KPCWIHoKP65QCeiHce8cKdX9Ze
         satM7HudgfICxkLOW6wY3+MsqUg6uY0ggC8cCfX4CoHOjOnSQRH3Yaic/vs2Rk0GutCl
         PQZzsVVbBQswD9eUh0xjrFH9IdnuWylK2+GYeiKnEDNicXGEZm4QBBQsHhxexmN2i3IX
         I4e8GCpvgdZWw3CxaScd7OT2Fj2DuZpUUu0bu/rYaeKaRRAhBgybcz8gkhluurl9ujv/
         Kqew==
X-Gm-Message-State: AOJu0YwfsocrQRJXVnVi9fsvoW7Dratw0ZurM9n30CUb7dNHkieGHaUa
	4+eAKCQ0AGh8sXi5aXeOYCXoO1UJsDTUsKqaL+NKBrKc9wIJbFpv9D0tqu2AofTGHKcGtVT6tvs
	k4BrzS8nCYUPEdcqz+LU1J23e3duL1fs=
X-Gm-Gg: ATEYQzx4e3aca+GYTxHYu8GlMrMf39sh4yw7u2bhvzz1o0PeAcTJ69O/Cti4b3nDNQD
	OKXUOlOZN72O13YytzQCDMeI40j8I24HMzxzdexb0E9PXTnVPQDe/pijBvY/jQODZ0FX5mqn4kw
	eSkwd8RC060ar5HY5efXy6k+wWmVJMmoJZ+rU1ZZtLHVYiiAoOnasH3ARCBRMS+sZYs828XgXw6
	y2A+daaWBv2lSEps4xVR2gF5dvG0T4maiVMrBYcGx81GpTWgP0qotirVtXnEDvanqj1LaywV+2x
	SxRVSVw=
X-Received: by 2002:a05:6300:6697:b0:398:7cb3:2bf0 with SMTP id
 adf61e73a8af0-3987cb32c20mr5245924637.36.1773057936198; Mon, 09 Mar 2026
 05:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Mon, 9 Mar 2026 20:05:25 +0800
X-Gm-Features: AaiRm51wREzrJ3CqakdQU0MlkEyseVHVkpGINLOa39JYNwuYtRyerEa5Pj8e_wc
Message-ID: <CAPHJ_V+7K3CPfqjx86jGx7iRKtCA=YeX4s+QOeAjn_vwEEC4Mg@mail.gmail.com>
Subject: [BUG] ext4: kernel page fault in ext4_xattr_set_entry via ext4_destroy_inline_data_nolock
To: tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0E5B42389DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14712-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.878];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shicenci@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

I would like to report an ext4 kernel crash that I reproduced on v7.0-rc3
with a syzkaller-generated C reproducer.

A crafted ext4 filesystem image can trigger a kernel page fault in
memmove() called from ext4_xattr_set_entry(), during the inline data
destruction path.

The first crash happens in:

  ext4_destroy_inline_data_nolock()
    -> ext4_xattr_ibody_set()
    -> ext4_xattr_set_entry()
    -> memmove()

Kernel:
git tree:  torvalds/linux
commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
kernel version: v7.0.0-rc3
hardware: QEMU Ubuntu 24.10

Rreproducer:
C reproducer: https://pastebin.com/raw/T7HRiZc2
console output: https://pastebin.com/raw/iYYf40Ek
kernel config: https://pastebin.com/raw/CnHdTQNm

Crash log
---------

The first Oops is:

  BUG: unable to handle page fault for address: ffff88800745d000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0003) - permissions violation
  CPU: 0 PID: 285 Comm: repro Not tainted 7.0.0-rc3 #1
  RIP: 0010:memmove+0x5f/0x1b0

  Call Trace:
    ext4_xattr_set_entry+0x870/0xb80
    ext4_xattr_ibody_set+0x1a8/0x270
    ext4_destroy_inline_data_nolock+0x1b2/0x300
    ext4_destroy_inline_data+0x44/0x80
    ext4_do_writepages+0x216/0x1aa0
    ext4_writepages+0x165/0x3e0
    do_writepages+0xe3/0x1d0
    filemap_writeback+0x103/0x140
    ext4_alloc_da_blocks+0x58/0x110
    ext4_release_file+0xef/0x140
    __fput+0x1ef/0x550
    task_work_run+0x94/0x100
    do_exit+0x3bb/0x1260
    do_group_exit+0x53/0xf0
    __x64_sys_exit_group+0x1c/0x20


This looks like an ext4 bug in the inline-data/xattr interaction path.

Based on the call trace, the crafted ext4 image seems to drive ext4 into
an inconsistent inline-data / inode-body xattr state. During
ext4_destroy_inline_data_nolock(), ext4 updates inode-body xattr entries
through ext4_xattr_ibody_set() and ext4_xattr_set_entry(), and the final
memmove() faults on an invalid address.

So the crash appears to be rooted in ext4_xattr_set_entry(), with
ext4_destroy_inline_data_nolock() being the immediate trigger path.



Thanks,
Zw Tang

