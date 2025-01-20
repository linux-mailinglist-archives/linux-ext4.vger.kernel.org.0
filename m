Return-Path: <linux-ext4+bounces-6153-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E68A16CEB
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jan 2025 14:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78D93A7770
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jan 2025 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD531E1C01;
	Mon, 20 Jan 2025 13:06:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C301E0E05
	for <linux-ext4@vger.kernel.org>; Mon, 20 Jan 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378386; cv=none; b=kfsCkc0gdvgZ4rfyFqkv2QhSKWyGXSp6W8YT9NJkzo7tbGPEsyu8ADMim7mo3n5cT4aSRbV2UxwmiIzODy2r1kTQCuG7HHAjIdmLMfGtOZ3V4v0cMTxPIOnsf53DG3L1DGMoZJBuP9vjH+QGVTrm5/qAhvx+7HBymI11HpPyzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378386; c=relaxed/simple;
	bh=61nPL4PRl4GGkTGyzaucCtogkeBVMM++BLcaNeGIUd4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s9wP+JnHb5MVRmd9M/lzG4cwi+/h7VgkmULHOnl/DehSe9H6ZUDb39aAWcJfSSISF5gTb5zGEuKhRRXnbe+fesFT+My7rnAAaVTnfA+bSoLQufU7qDnkSSbB0flFCPWeaMf9dw6klKPTGe7qzgDk65IFHB4Qvdq2o+G11lJa/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844cffcb685so311857039f.0
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jan 2025 05:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378384; x=1737983184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mf/w0qIPZKq/B9fcAKqRQIxyGgbAiin36bgB4K+JG3Y=;
        b=U8MJDluxqbOYf4ZfMrNWV1OKKvVFSmNoHJqbfRuotwsZTHEOtlxGdS0vEm2XWXhT4N
         tV0fPspjTslpEN6wDtUp5r8MEHIKUDHnTqd8fFCfQwICWYu9o6FPXeNJ9hsuw8JsiAnH
         OApcOtf4MQwZXkMme3glXZuGD2t5DemOpak7SffQzivrAh7sLpy7RRjxKlosN++MVX0v
         0ddxCvfK73xI2VyBodyyshJpQq6Kq7EI6274uGFfaQIkzlnDeoAtxCruPfxKVlqNPwI6
         KMgMEXQUTlA4Mv+k+opgCm3AL++skJbpGlFBKgmjQp5RE8Eu3H97Cs5rvSs1vO51qpdV
         x+oQ==
X-Gm-Message-State: AOJu0YwG2F2ohD+BSIQvJ8Fxb/LVFf01Rw6AEGMz5ksTF1wj48O3EBBF
	pFIwt9R/lgrQycZ5Qa1I1nbuWI+8b5Pnbo6D5JKW8JUaSWkk9Q2bQeSGS+VNd6znH1tpSOC33Tm
	6vAuq9JOIfFQmYmw2n0v2phugFYVBDipWNMM/7DMvj5vo2SYytlzcVMA=
X-Google-Smtp-Source: AGHT+IE+/wnRR4KBqwEdanTvMcDMgBhiE4COY7H3QvpkwA+pfaTo0ZD7gBwJQ/HG8hvNn70xNKmObbIBKxE/WwwVQVBZbgtJxUCA
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:3ce:900d:6b12 with SMTP id
 e9e14a558f8ab-3cf744378c8mr82199865ab.13.1737378384131; Mon, 20 Jan 2025
 05:06:24 -0800 (PST)
Date: Mon, 20 Jan 2025 05:06:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e4a50.050a0220.303755.0078.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Jan 2025)
From: syzbot <syzbot+listdca87f6dc01ef77fd86f@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 5 new issues were detected and 0 were fixed.
In total, 49 issues are still open and 148 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  27298   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2194    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  1913    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<4>  1848    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  861     Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<6>  165     Yes   WARNING in __find_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=3c9f079f8fb1d7d331be
<7>  163     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<8>  159     Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<9>  142     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<10> 101     Yes   INFO: task hung in do_get_write_access (3)
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

