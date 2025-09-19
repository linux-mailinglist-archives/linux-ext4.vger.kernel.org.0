Return-Path: <linux-ext4+bounces-10249-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E3AB87A49
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 03:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0781C28644
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 01:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F44254B03;
	Fri, 19 Sep 2025 01:53:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE56231845
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246787; cv=none; b=ew8UCmAPEixkWgdlOZkU2d+K6qOHsRBtGVJMowntsT6oWbZRJ7KeMOkoaG8IR9phJdJvfktmK2RN0QFx3oJrqVtfMfMnwW6rBX5zwz8M1XB0mygJyS+DRU5wk7wK9S2wklI2kBRzHux4aGSvAL90efhplRzAsY9/tn7bDg3SLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246787; c=relaxed/simple;
	bh=HsqXOGytWmTqTX55WwcivWlmPMXBaA6r9gInXS/y5GI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dJ0tQkISNXHQxgNQHSWinsB+NysjJR2W3PTlZnrHr5q9xFgHJZ8/Vjj49OzfLJ3bmto2MTG3cMY+eQQL0R+4s5EtrQTrEwiYTHacg2U2CTGfg//cV63tXjyKoAB76WbkAxuvVryvDfIj5eisUnJOoUa6m07p/9ljcrBDKFrThVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-896d8bc595aso320390139f.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 18:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758246783; x=1758851583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5+E4pD4Npho+TjkB3BTKVRK66Yv7VfqKIzT7t52A3k=;
        b=Uy7xQANNSf48fL5Rr3Fa5UQDdQoOcBPwINd0X69z7u+xJDYIj30f3SpH5qOiFUP174
         uPoR+I2XHrsH1JK2WDx/sj74sfn04HhPE+ktBz7MoCRHf/zIljIBKFrgMt/vjkcc9wbm
         6UnJa90caA/USBEadfdfeiHcuAD5E3tVpq4t3HPyu8P8RFYjXwL+/jj/sFO8tvD1HVNc
         qW90mEF2lteru1hWfcE0PLmpLrquu/m72sLb3pJxRPfXOUkWNyiMs8ehbjH8zl7s3n7D
         mvoWFIberduDIajrtRy3V3Y2cqFNJL2VjplNKCDmEBhZXPoTU8zLteWYsu8fMSUXdR03
         SaCA==
X-Forwarded-Encrypted: i=1; AJvYcCXAZvsFzNkkW3VeYmL2NHMnX6NA4PY66QzX7ELS8Ns+Ux/buaRepZ0vIr0pOgN8OvqdytTnGyD/jNKh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZx3tV7qPivyiDlinbYDpmls7UhBiVXL+cheh7RSyvOWLrzQ/Y
	b6xLDtgivfTxYziUcraHixBbCb1ErtFUhKIGcZMZMsqshfae4mHQj+srkSlDnMrL14dHb+f9Q34
	QhrWJqnavxhLOMWrX8kcyuiLpIIp1TEXAkjtuTDdo6GUuDM6NRMytZltI86k=
X-Google-Smtp-Source: AGHT+IGn7kSpNfcJVx/hg3eqJx5ch9U9bBXxhqgGez1fBZOhIzcKluhNm7SDOLYq7WKKXSUMdJ0v9Kf9lDdv1LrFsoUEqYSbp1ch
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:424:8166:9b7b with SMTP id
 e9e14a558f8ab-42481927117mr29492505ab.9.1758246783367; Thu, 18 Sep 2025
 18:53:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:53:03 -0700
In-Reply-To: <20250919013214.472874-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb77f.a00a0220.37dadf.0011.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com

Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e4c712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142f1c7c580000

Note: testing is done by a robot and is best-effort only.

