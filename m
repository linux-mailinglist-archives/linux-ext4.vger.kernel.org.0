Return-Path: <linux-ext4+bounces-13440-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDm1MPSlfGnCOAIAu9opvQ
	(envelope-from <linux-ext4+bounces-13440-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 13:37:08 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25153BA94D
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 13:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86C53051459
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4237C0E3;
	Fri, 30 Jan 2026 12:35:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48A37A4BD
	for <linux-ext4@vger.kernel.org>; Fri, 30 Jan 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776531; cv=none; b=ieE7u8rh5Tx0moG6xCpC3qqfZ/ZsojnE9p5eitNjEOZUeCL/a7FsaU+lYqM7dD6eWWSRWsyt8Fo/4XnpLnoHTVocYrPZeyqr7ufllaHalQDHaGzsFfN7ssLhvNj9ZjtMD+A+1widKx1b0/dksp2G6NXrZjli1QA8mxnrdZoXNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776531; c=relaxed/simple;
	bh=PscRmNunkBaYuaVYEFYPiKzkQypEHKlPCoaLkkuJO9Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SmV1QCMwApay4a+iD/vNFKaNstEhASG3qN0DaqZ8IOeGNwfUY2fSx2quj4aGxbn54wT6oFhl3FQ4JZ0d64ywIjm3LksR4sYJz7bpvk/dgstWdVKgHWXlROMfr64AzjLpz9PQB4kg37aXIaS8OgNizBCpw5Syy5CzEFiklv51fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ce5218a74cso5744303a34.3
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jan 2026 04:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769776529; x=1770381329;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pVTyIgeV3CQsxtVuDjAqiU3vlVZFnwMbx196G3N8EY=;
        b=E8YZjxgKlPEelxhpkuhi/VNHZG8bqiQKRZ/hrZfXuFSbfiuD6v100QLZ6AskI7YriR
         DSOuljTShiLnTOKe5NHmUmni0A9082ljbfv7ddhNIDe+1yemCwv4ctucISZ7IDSRIBKZ
         Fiq5fLg1+uy+N82FB6Z4UIS2TLVbQq5YVpXJ17OEU4Y01uvvChjYx0PjaCsqMQezxsBe
         TS6vba/CUNQ91NMRLET9Ujaz/akKPwraFE7L8w6heW0JjozqpAvLofprHmud5kyipnok
         GZ/FKpE7ynfgY0Efcdi8PyvBSLLoqBu8XpmXC5EyTUux0DBnuak78hA/7a64vq19hWn3
         E0QA==
X-Gm-Message-State: AOJu0YxcoWepOMkiH6fqFncZph9kAzrwehAVQdRa3vSo/SbB2uWsQp4C
	ML0k88kbu1xhUyvcwXpT7GqYnzXdHLpnvOhQQYgnOJYyUEy0fvTmnogBzQPyaFxKvhump21VonX
	GzA6uP5l8I4wpB/hZKN6cIN7t/JjNbmJRn9Z9xAZSN0iHlJZg6X9JSoTZjKg=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4588:b0:662:d4e1:6995 with SMTP id
 006d021491bc7-6630f3db3dfmr1002761eaf.78.1769776529038; Fri, 30 Jan 2026
 04:35:29 -0800 (PST)
Date: Fri, 30 Jan 2026 04:35:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697ca591.a70a0220.6f39b.0241.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Jan 2026)
From: syzbot <syzbot+list9895050aa50b4c96b774@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13440-lists,linux-ext4=lfdr.de,list9895050aa50b4c96b774];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25153BA94D
X-Rspamd-Action: no action

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 2 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 170 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6265    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<2>  4238    Yes   WARNING in ext4_xattr_inode_update_ref (2)
                   https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
<3>  3407    Yes   possible deadlock in ext4_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
<4>  2927    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  2160    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  1014    Yes   possible deadlock in ext4_destroy_inline_data (2)
                   https://syzkaller.appspot.com/bug?extid=bb2455d02bda0b5701e3
<7>  993     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<8>  497     Yes   possible deadlock in do_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=756f498a88797cda9299
<9>  462     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<10> 273     Yes   kernel BUG in ext4_mb_use_inode_pa (2)
                   https://syzkaller.appspot.com/bug?extid=d79019213609e7056a19

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

