Return-Path: <linux-ext4+bounces-6525-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CAFA3F0C1
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 10:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C916AEB8
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB24205E20;
	Fri, 21 Feb 2025 09:41:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC204691
	for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130884; cv=none; b=N4N23mo0z+AMeJi7rjPuvDOJb843+VYrINmXeDDn5Zuu63YISM8aPsW1aNh/vI0DkUte567ROi97h5UTJe9+RbliboaMmgbQnumdNQziJx2FdHzRwa7G/+c2V/ySktwxs6UJg4oPS0OcSfClQVENaOJSlLJsNo8HJT9JSo1+sNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130884; c=relaxed/simple;
	bh=l3zvIDZMI6ET881AtYmbI3nm5amUHwCGjYOGgh9Xyw4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YXF3350w7niUCvV44CsbMbbHy2suUvW2sowbuFuKdP22mTGNFKE6KshhDk5Gc/S1Pe/r+T/kHtlJMHfDqiPRa7/yvZT7M/ThEdhE6kbcW5It/vnaFSYH7ZS7WFdlm2lAc5rjr1eVINsWoeCoaKN+CLWwnYON89KCk18bVdEV+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cf64584097so16861385ab.2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2025 01:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130881; x=1740735681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OsqRYgSCSxtMYToGhG+dYqJv9b218NUxAua9vJ1J8A=;
        b=WRZ2RY6PkTUTi7+Dv8LA2BjXdELkC2tV6CG1/6GU+QztWCBCywB209in8u7yVmYK5N
         ZlX1/1XQEV/GO9prRyno/bbC4WW/8wWR0uThpHWdxUzWpwwhH94KL6evn0gkJvA7tWyr
         MlGn2/Wf8xwgFIE1O3+Ttt3lHjMC05fu4iiYyhJt4kisM/iZV+Pfgq23o6GrsXT8GwUq
         pw/CViKU12T1o2Q4syuRzIfzasAghVJYPjDl6mC6K04opqSQQaMoxHUZ1aXy+YV2amrU
         rk+4Mhf0R3xnhwF4ogXPHecwnhFwnBiDIDEH9ZVFRZjNgn80tT62gha1bCX92lzAPjk1
         lIFA==
X-Gm-Message-State: AOJu0YwESHgSIM2gOwCs/6pVTnBWx5nGvHLWonLvEDwuL7ko2rywyD6L
	/n78GTaNCAwTeifJgLtuZu1f9y19hdX9xq+PGqcrc0GXskPZ3JNibe21nsbpp5Ra1DHGMJihBBX
	dIfJQGh7EVsk9jbko5iICB9i0mSVqjH2LF3/mPpRMxRoVocS7Y8LoLJg=
X-Google-Smtp-Source: AGHT+IGvcQBb/y8ol5/5gosN1vMmptjmm1MJ4VhyhbDByxh8z9QBFuI6f47r9MMRmH/TQ3GoReKLOUElVmAst1ZlALa3m9/9/v9B
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d2cae4652cmr21360085ab.1.1740130881378; Fri, 21 Feb 2025
 01:41:21 -0800 (PST)
Date: Fri, 21 Feb 2025 01:41:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b84a41.050a0220.14d86d.0357.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Feb 2025)
From: syzbot <syzbot+listf4d7496357876fa24aa1@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 5 new issues were detected and 0 were fixed.
In total, 55 issues are still open and 148 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  33227   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2203    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  1943    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<4>  1920    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<5>  1025    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<6>  1019    Yes   WARNING in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=2ff67872645e5b5ebdd5
<7>  201     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<8>  173     Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<9>  172     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<10> 96      Yes   WARNING: locking bug in find_lock_lowest_rq
                   https://syzkaller.appspot.com/bug?extid=9a3a26ce3bf119f0190b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

