Return-Path: <linux-ext4+bounces-10327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A46B8D56C
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 08:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CE0189BA1F
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 06:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C88248898;
	Sun, 21 Sep 2025 06:03:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3891A5B8D
	for <linux-ext4@vger.kernel.org>; Sun, 21 Sep 2025 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758434585; cv=none; b=RsMFux6PGWrCB3HiFd16kw0FWoBr8N9GnCiL+7PdMSuYSh7w90aeO/q+TPKNsJILYH11hrAM3lwoLgS7MHurmiN8IsbHJdwbhCBNiQ9hi1dHjHm4HzNRvizhgmwaCyJfKCWvO9nlRqyKo9ht0ABFi6Xr+ZbhNwmjwpFiM1e3gtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758434585; c=relaxed/simple;
	bh=psSr2bM3JnMxufeL/g3AsGHtXT6h1LwOif5UPWk/5xk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L3GRMmlvbKLf6ONASqGc6PNsIOC8Kjj7kf1nKQsjBXMzeUsK9SjoFVZj0WbvO4HYbXGnI1Pn6TNqFVsQF8660erl9ZPQoxYTylCZul+hGNJIrcprlr6Z9AzUCOh2S6sfNbgO3WN4qIdgOXAZSSFixbFX0Ihidp2Rp0N5ZX8lwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88c2f1635e1so348192639f.0
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 23:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758434583; x=1759039383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6dDx9Z14ty0hRGDOpEn56adgVcnRxlC2O4IbjHD4vg=;
        b=YHCbVtE7NNhhvmbIigemyJ3sEsC6KlV+94p/uHezKHrG9daRQ28JPbJoye/zkkNJR8
         91j1bL2r/4qGmZPoJ/wirLzpmjmiieR4RulUskDlV3K0sO+jv+LXlFTN1PeRSzt2o+JT
         HCB6Lcfby8hdXK2WeM59l4Q8rWf3/FhtDwxmyZV4/ZxbogdxIQAIXA+ndZZGavHlKLD/
         FBwiu0jR6e5QcPAxrWVE94EOBHGTVkNxwW3zr1HqXBxkWhr6s5JnXK5CkSm/FoeM3El9
         Xz8IOFiJQz/qjCT30WX9clzBQ/ZQT2Ucd+qxMCpadkPmqx59THpQycdklrjq7268ElXc
         H3fA==
X-Forwarded-Encrypted: i=1; AJvYcCXQjCD77GA2Ukzxg4mrZSqGOyhQ3StltF5RFB6906SfEw9TR1JrnnZav0XyWG8kufqhsfS6ktFLl8KL@vger.kernel.org
X-Gm-Message-State: AOJu0YybS1PqL7yZgm76aJpR8lSIoLRxzufwNJK17jwaqszjyoZCbt0/
	rG6xpL8fbo8cyfiwI8c8ALQ9LNr9irO/R0Dqs0yHezdpaHzCAmStH1ZojAG2EZu1g9C7GsoNjAL
	4nXf8VDwI/QC+3S/Mw6T/PcsAkzm+cnVg2g76621TatMZvAgxVyCvuTL10ak=
X-Google-Smtp-Source: AGHT+IGWwS22f/HXMtlGtGzvUELXrtInlWeTZjRaQZNAq+YXsKmdVFMT1RRz8383+U1FP/Tbm08Nr8w9q7SdqTwnbPn/T1hJPuBp
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:424:7e36:f873 with SMTP id
 e9e14a558f8ab-42481999b76mr109605535ab.26.1758434583227; Sat, 20 Sep 2025
 23:03:03 -0700 (PDT)
Date: Sat, 20 Sep 2025 23:03:03 -0700
In-Reply-To: <20250921052315.836564-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf9517.050a0220.13cd81.002b.GAE@google.com>
Subject: Re: [syzbot] [nfs?] WARNING in nsfs_fh_to_dentry
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: david.hunter.linux@gmail.com, kartikey406@gmail.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com

Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127fa712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=9eefe09bedd093f156c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ff1534580000

Note: testing is done by a robot and is best-effort only.

