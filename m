Return-Path: <linux-ext4+bounces-10325-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D3B8D473
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 05:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313EB4449A0
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77AE281529;
	Sun, 21 Sep 2025 03:44:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141FA95E
	for <linux-ext4@vger.kernel.org>; Sun, 21 Sep 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758426247; cv=none; b=I0ba3veDM9gL9T7TLsaoje8+khNxioBItx0TsNPvxTuEHU+U9qSDud95M9y3Reuu4t5Sj5rFctpHb4qCPGOH6HhhnHdG6+6DoT+SS0P+lNgZUV/KQJuiKs60Dw2wkp/+IwKZHyrhcgnFmeylIAj4mZkRX9q3Iw1l6O/S/OFd32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758426247; c=relaxed/simple;
	bh=9Vyy6nzZefHF8h6kYfMkiN13MLdI0fokQqb3A0KLQT8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cyLL2BenhdR3vTP6bVC0MVXfxU1/TEKkDTj8trC8S4g9HD//Cu3gmRH4MSaYfKgQ9cz5q5WEGegWJ+gAlL/FSV+E95yJGdJlLmqt/Bd9tWhVwB69KEOY+4zxtSwU+99l0AUOUeEppHCbXuad0GsYjiArwfhpNWmD77/n3QTmftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-893656f5776so375545139f.0
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 20:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758426245; x=1759031045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdjgHlcbaWhWVIx5piaEC27S+dMD/Hjc0fOFih9t3Gc=;
        b=VAdbeUavtQrjNZbzbS+K//ndD/2hlXjvo6/Fztac+G0TA8YbPk+0nCbKkBwBz+iTUC
         eNz1JlFOZU0CdALjAxKR0oNBw/pTL3XJs4BJvQl6ezmygee+tC9Tq37O90Iywp4mQdr0
         k+1SQIg9wm8KPcpEQBzj8hPYTqpIcdjjVJUljrL+zhkq4t8G9c7NVRGLl2Uu1Cafsv/G
         KmQdaGbcyEtEzpc+fUETJjSdPQ/QHZVM73EOWn1Y7HeBr2ljqK126lWXpjnITlrgtVSF
         6qKRJUjuJkxO/gCLCloByMyzy+4XTeZrpGAcAkK1Wao+0vSfI3dy2VUD0OXQt9W7ifHx
         Ccyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMcCe8A9FTu95FEzelzgg1et6FPBwDxewNYVKlWldR0NSacECmSqf5BWCZGHsl7rLCDgw9dZb2JGDF@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOCU/q0CIoO08KoUy/SUkGiXw7bkTQNgh3qfkEE9lC+j1JTul
	Ozc/4vb2AVsOF94N+iLMbHDaRnumgB0dB7ywcQT3WZgs88t/I4282kvISP3lweeT4FDIN1Qxh8r
	UGaQxUlSEDOwdAkV6O0u9QVX9/NmDIyzOnUK97BXVDYto1I0Zp6kFgm+lOqA=
X-Google-Smtp-Source: AGHT+IHFhT9ux74NVmmSHs0E1OXa90ayjxf4uFnXIyvS/j3oomieCbVSs+xUPwqp9DnUBLxek0rWmB7CW0Xlo/6nbyWPFRsZXf3e
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:41b:3987:b3d4 with SMTP id
 e9e14a558f8ab-424819743e9mr113994275ab.21.1758426245239; Sat, 20 Sep 2025
 20:44:05 -0700 (PDT)
Date: Sat, 20 Sep 2025 20:44:05 -0700
In-Reply-To: <20250921031859.833667-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf7485.a00a0220.37dadf.0037.GAE@google.com>
Subject: Re: [syzbot] [nfs?] WARNING in nsfs_fh_to_dentry
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com

Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d650e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=9eefe09bedd093f156c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c650e2580000

Note: testing is done by a robot and is best-effort only.

