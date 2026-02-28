Return-Path: <linux-ext4+bounces-14231-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6c1zIxWvomm54wQAu9opvQ
	(envelope-from <linux-ext4+bounces-14231-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 10:02:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E502E1C193B
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 10:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01E93038176
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F0361DC9;
	Sat, 28 Feb 2026 09:02:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A8271443
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269325; cv=none; b=p+05UKIqgnLwQG2mdVej2mtq179JrQ+BslBHLrjP7koo4V+I0rnAurmQt4Xhb370UCrgmUI9LCfrkNU3pl6C1iCHz8qqJkFlhKK84K9XFiqf9AStuU0UjRZkvwfMHLDok19QVFDd2N0Shq6Z0a78VqAjguc+fl2GaxSQjCBO7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269325; c=relaxed/simple;
	bh=e7pe42o/NJEcT5RKB58+4L0JjwFI1ZwGRLBBqW1dWmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P/QL0VoQSDR+HAcDWDTH6jPmikhXXEPaOaUUXJ5Eq/iF1wC8II1js6UkOWp8kMlcOxi/wafg3k/AN894rKmG+0xMqzdsujPzJzeNptQR2/lzuarWsS7hMYI8fKDtA2K2brKE6g9wPbghNIq7Nd2QpaFx5wws5nc1EDq8yeNJ++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c6ef1538so62838235eaf.3
        for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 01:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772269323; x=1772874123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMMeZnIENDkfG/wFtS+AEcbt/4uqhNSNz00R+7tQIcM=;
        b=VwZNU0zAsdgQAc9RIPquS9mAcUlcU6Nac/4nrfFeH3GJq7SDoC4ThphwR8aCFV/uIw
         PXKwQJPU4PQStVUrqTFXuABdecpOdrQoVJ+YAHIo3v8/ejvumrAhmYj58PMwdiV0jpqG
         8bwPr/z9x6JaKKCCmaXD/aMMVbG35k/rDMsjweWErxithhAZybJNVdnTbiXSX8vyVTKY
         BAZ2KQws9ZNrEq8xG3FIUtdCVoTXpMWL1xYPLcsh7TwPW7tso/tTnwVhhxVNz+mOiAzm
         fGt9x37SLVtoO7GVcCJbpx4vTRycLzJ4yD5/XUNTmCobBeCoHzMexuvEuUHju8alt7XX
         ZpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK78u+kXbPclU++c0FR9/L7cQBIzDm7GCbJJQ0EZBm+4PBsoJbhmF9Dt1FlSMrY/0RvnLATOp0nYL8@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbQASExV9WuQZDdlRqnEBh/UU4LJLT0XylGh7/may1Wfb50vc
	527/hPmDidqCswLy2zAbVd9FUmaMan9/w5y3kNQbB9GohE6QIr6vSyvJHEo3lCdgG7wh6dD20zx
	FSqESsNmJUzjuJpcmwwZeDb8IcCv/7TF6W70PRrxMGD/K+XXv45rfTYKticE=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150a:b0:679:e7b2:9fc7 with SMTP id
 006d021491bc7-679fadc29b8mr3518993eaf.7.1772269322909; Sat, 28 Feb 2026
 01:02:02 -0800 (PST)
Date: Sat, 28 Feb 2026 01:02:02 -0800
In-Reply-To: <20260228082942.1853224-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a2af0a.050a0220.3a55be.0036.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in filename_rmdir
From: syzbot <syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14231-lists,linux-ext4=lfdr.de,512459401510e2a9a39f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,suse.cz,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E502E1C193B
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Tested-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com

Tested on:

commit:         4d349ee5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b7f1aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4
dashboard link: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d62202580000

Note: testing is done by a robot and is best-effort only.

