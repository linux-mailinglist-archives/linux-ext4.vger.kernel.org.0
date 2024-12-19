Return-Path: <linux-ext4+bounces-5780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1D9F8370
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E008516149C
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011F1A76DA;
	Thu, 19 Dec 2024 18:40:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD701A3BC8
	for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633623; cv=none; b=GB5HnIwRAF6z6bzPbMSqgxf/hiau2BWfQzLkOFymzQCrjfWLl5tf8Tclw2iaCGgxXtv+QUbkPz+UdpmIzUHYtzw+M/brApQlL55z15Cr2388fvq1hT0on7E4PDWBuHJgOKHP2uah0OOgd5wGa1yvEsVXPqKP+MaarD74yB7ALJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633623; c=relaxed/simple;
	bh=b9urhbWc2ml9eMBOfBrasCss4KojoZPYbuJLyAO7IE8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JcAPYEjzdbQ18BCrwyE1mvVi5j6v5YWyDrShziU8bafIyOuS/sa6XAIe4LAsqDyyn5Ij2ZNGWbLU7GRCeymX/JrbmJ8MGUciyFxKhOnIPbyXkAfQGfoLvCPJICPWo8O63hnHNPSzUKQyIIbJ50jvEgjT7CEr3KQoUiY+FhEsDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844e8b6a786so166223539f.3
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 10:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633621; x=1735238421;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNtnM9pPzqf1ba1aOwvBByyMyZ410QrChEoUiH/Z1Q8=;
        b=n7KAUxiNQqsNCxlBxCObFfYXi/D2tg/J+953xTcG4/axajIGEjtHoZpqAUVCcA3O82
         xkUsz/iXurmAyqg1vgpanrhs/LKDyv8J4i9q5hv46Tw3Jy1JXE/MogJbCq0rH7CYLq+Y
         je+XjhniqfFYuRzOucr+SGpHJmTrp4cpolMNUE10iT2HvI7zH/R3r2au76Bl3W1u60yx
         2SBJwVSqik8OrqZa6TWbJMvxwl06L5/JOQTpdsejWI0N/EWYKfavoNdT3HVQMDS8V7JD
         cU3lTMjr64SlbZ7kV3CpnXvO2NrUoE050fdS89UfwskSNcW8F078bt1uc4wcV+q98c9b
         z7Pw==
X-Gm-Message-State: AOJu0YxRiAhXj9pe/OL3t0b+0GRLLsz/NeUa1j2WLneVAmV/9WcIaHv+
	DeGGJ9GqUtaUctOc8wVRXUHrkssm7U0B2s50/FiQIw0+5LX/6KKvG06OEiTv+rPYL5UtFXAhTAk
	oLdP/45KVc8Ls35l2N6I3GZXH1NyoKto9R49OUJX+ipX1h1Q/WQ5IMuE=
X-Google-Smtp-Source: AGHT+IEEYsS6t7i3btQXYeYvVXoTtGqfdNsIL7upLDz6oy9xnwBPsgOCLzh+ENKcw63hyRMYUJ2+lUF6Nrn1EfSwLLL89cIqDpHI
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d82:b0:844:c76a:354d with SMTP id
 ca18e2360f4ac-8499b6fada9mr69167539f.2.1734633621005; Thu, 19 Dec 2024
 10:40:21 -0800 (PST)
Date: Thu, 19 Dec 2024 10:40:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67646894.050a0220.1dcc64.0021.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Dec 2024)
From: syzbot <syzbot+listb2affa5850e4e78411ec@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 6 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 148 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  18162   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2131    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  1774    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<4>  1594    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  923     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<6>  581     Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<7>  189     Yes   WARNING: locking bug in get_page_from_freelist
                   https://syzkaller.appspot.com/bug?extid=5abecb17ba9299033d79
<8>  151     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<9>  130     Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<10> 104     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

