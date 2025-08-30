Return-Path: <linux-ext4+bounces-9762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F90EB3C872
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 08:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CD8568304
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Aug 2025 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD9270EAB;
	Sat, 30 Aug 2025 06:15:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED621B199
	for <linux-ext4@vger.kernel.org>; Sat, 30 Aug 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756534506; cv=none; b=oJlrXt3tpoaE1Y1v+AH1e3WDuODMT5bl1XacnYmWvt2K19uLxVMTW5D/hSXY6qFc7Xzp2bM9H/bXMEPUDdll7Udxk/oXssXD30w5A7PLenQtdMyv+TzVxUzNCGDKudcHdaWy/QR2P3FKG55q/oYUyk0ty4TjVUrBO6JDhOdzWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756534506; c=relaxed/simple;
	bh=tmZB1nVSSRipWiyAB7XZA7O5R7fEqGHvKca03KMejas=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gBjUGn3mmiPxXKJLVR7wVrSmE2A/3zPhJwVHDcn1IQtoc7m5TXA6tlYD5pAZXsondBbxUNlCkGVRy61kWqKkH9yjnLvthkZGFYfezJt7bZNr3z784dcQutrpuG0xK10s+/22IgtOkWc/zcAkJ1xjnhPnSZHetsM9orWp95jnEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eefbb2da62so69220035ab.3
        for <linux-ext4@vger.kernel.org>; Fri, 29 Aug 2025 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756534502; x=1757139302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzdRXtUwN7b49DUAa+oICb3Bg2JQNLD+we98k3VPOZo=;
        b=kxmknvNIgP41BGNSaT739eyAR8xxgjYueV6IGUudw5bmYXL1a9ZynKz1wFz6NLlov2
         3FlLhDBfX837QzX59tcGivuhEN8tFwr8YE+FwTEJeg+dKXx6UAUObPq0c+rJWwqSD5G6
         P+Rwo6UpOH6rNiaGwy0XQ/j1uFlFVYHvPrhAPG14EGhZJH7qXC4sKwML0oQ5zW34OuO1
         ZsG/9sf9GygvhVaL7QzTFKE6/lL5V+fgGRhgEr6jkhsoAv726NIu3oWp3fzMBg81YCX4
         yvE/edZ3CGSNvQtabPbkoNcSPkWT66mmBY8u+ik9gaEZAYt5KwsGnvasspETWQl3AaVC
         760Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlhfEW8NsVv2fE4Ph0wrZrF7z7ZIigadFZkSZaS0VMCNY9qOShdFMdaItTITsFHNLEiRtvX0uR/seg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6f1FWe9LLcoD5XVIHEezur3X0d1gDWkjfSHAmupnA0yHxV3XV
	4WDDcan6xvC1kJfVaszHcnAJSUQ0JsZw1Kkeozs3ms6ZTDSE++3S+U9PlkXGdKvxmhLLczfTOD2
	HuE7EYUSCCdnjvQPo+ZDnPG78+I3oXmgYvQHGNHuq9YIosJpszW5fXfYN3GI=
X-Google-Smtp-Source: AGHT+IE2kGR5jTsLkA0yjVS6YxrvvYv1X8Pd93StA/xrtFjuEmH/Z/GTeFE5d/PGZmpYDSB9+gRGQk2zvsfHf81H9yxubL+YF5De
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:3f0:abe5:54eb with SMTP id
 e9e14a558f8ab-3f3fd18b519mr24741415ab.0.1756534502590; Fri, 29 Aug 2025
 23:15:02 -0700 (PDT)
Date: Fri, 29 Aug 2025 23:15:02 -0700
In-Reply-To: <CAKYAXd8xoejuSenjr5o7SG5o-DsYpfZdQt8QE-JRN2=u2PRMyA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b296e6.050a0220.3db4df.01a4.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ext4?] WARNING in __rt_mutex_slowlock_locked
From: syzbot <syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, brauner@kernel.org, jack@suse.cz, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Tested-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com

Tested on:

commit:         11e7861d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13755262580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=a725ab460fc1def9896f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b6d634580000

Note: testing is done by a robot and is best-effort only.

