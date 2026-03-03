Return-Path: <linux-ext4+bounces-14580-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF38Jf5xp2k+hgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14580-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 00:42:54 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766E1F8717
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 00:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B519B309B0AE
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1236D9ED;
	Tue,  3 Mar 2026 23:42:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8B366561
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581357; cv=none; b=G9ByAMaPyqVbMTpBtI9US+1WUER2hkswYn7bG7hTUUhKI7hYuGl/vFktQU+zRhpbGdeClA2+XvrnQ0QuIi1XDY8VM1YAVeIw9xUxGdeHRL0LwHpcyGQsgQ9QEGDvg9p9dJgpCaSU5fsNXkATryQa1qYAy7BkpTE0UnqGhrDC1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581357; c=relaxed/simple;
	bh=08e5Strv7kHrahIC/ybDbtnGl9YtCyRR7MXf4eNih34=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s+nlv/8geww8fkgvw1XX4cITS6OS3bs4UiZnoMHivfooNWyhWuoffSc1zSw8/v5k7bSOrwgp8SoGtsS0u/tAnr6NYYYBGijm79j5vBVOh5a64LI8VQL0MvTAOMWfz3vyfVDoh3Y+mIkkVhV5YSw6LIGxkJnHEvBLgo4Cd6GkGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c14c60faso64981985a34.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 15:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772581355; x=1773186155;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VPjOuV85ve4xDgZ45C+rWcFOGqkYmsrXJcYjtU7mVY=;
        b=AHLa/iFekhFK4PPiXG5LBuTodkr6+dgc3maPXAwLD++CV59x9UjzhcLtMy7KxGAPmv
         drBGGnuCUgA8iZr4b0Ul73uRcmZcJC2Uf2d7fbeORciXIlDTMKfuXK+k259us/CwVqHD
         b9I2cOFvfYEi9GWHrlOI2ixYEXgh0BGsl8jjMCn98mI8yJDn8STweUbQY/FrYIxo1jE9
         DRmzJNFfsYaYWIwGYJNWmaAey3W8DAQ/djU+B99MwXMGF4kkCaRVM3LYFEmbKK4ETaAj
         bV4521FJuuJFxtJvUN48Jz+Au+BPT6fp93zY+5fEuxI3WCmDNRzEXjTwKwlbuEEbo26b
         HP9Q==
X-Gm-Message-State: AOJu0YwldhExo0vBcC5jXtknBbMHxV3Po61eWX9C6PiI2xMk6zIBWOQr
	Xz8vO6RpXedUoKRcWmFdUgKFA4gBqci/rqF4Nk+3qLXTqHF1r97b82mqXDt75Ya6xtBJXbLjkk+
	D9EXoBqfkIWzHVGASwqvzwShcghNoHOca4vs4Yzx1X8QHZbpnSP0M5NTLWg8=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:228e:b0:679:e85c:10e5 with SMTP id
 006d021491bc7-67b176e9c2dmr184222eaf.13.1772581354921; Tue, 03 Mar 2026
 15:42:34 -0800 (PST)
Date: Tue, 03 Mar 2026 15:42:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a771ea.a70a0220.135158.000a.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Mar 2026)
From: syzbot <syzbot+listc68eb7aea00e6714702d@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0766E1F8717
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
	TAGGED_FROM(0.00)[bounces-14580-lists,linux-ext4=lfdr.de,listc68eb7aea00e6714702d];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Action: no action

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 7 new issues were detected and 0 were fixed.
In total, 55 issues are still open and 170 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6756    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<2>  5047    Yes   WARNING in ext4_xattr_inode_update_ref (2)
                   https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
<3>  4148    Yes   possible deadlock in ext4_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
<4>  2977    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  2936    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6>  2170    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<7>  1607    Yes   possible deadlock in ext4_destroy_inline_data (2)
                   https://syzkaller.appspot.com/bug?extid=bb2455d02bda0b5701e3
<8>  994     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<9>  575     Yes   possible deadlock in do_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=756f498a88797cda9299
<10> 464     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

