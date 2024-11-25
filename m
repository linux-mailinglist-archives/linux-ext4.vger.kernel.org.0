Return-Path: <linux-ext4+bounces-5395-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A99D8416
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F01A16756A
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B321953B0;
	Mon, 25 Nov 2024 11:10:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3549194AD1
	for <linux-ext4@vger.kernel.org>; Mon, 25 Nov 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533005; cv=none; b=UNxHSG4MQudJdrIgltnTdehrUJ0c+joZ/XUqZUEK4wFigF5Lf69rC3VpXbu/7T2vkavcZUgdD7tHm+kqxwh4j1ZZkFQdXFDV7mc+IDPljbdFu0A4iMAJmMNFXOcnSnKa3yL50tEPCpLOIzNAgbo27Fs2MzEcVOu+bmr05VoKr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533005; c=relaxed/simple;
	bh=ag81pewKSJv1JzPBH/2FxoqSjfhawrLPaWjKhWo21w4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nxjapwSJTt7Psc12rJVrLNJhRdSiD1D3VUWoOqE4uEr4u98tvkD+LmNZZBykqcIIBU7Fxeh6KB3/GC9oSAdaA1hLg3dRdhtlISpusufV6sOM7f8KuFfgj6EDHLuP7a9n/KgWko2eKilOrrDG+PmuUzjY1CCkB6xT9TE7ug0Kxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7b3c63c3aso10369915ab.0
        for <linux-ext4@vger.kernel.org>; Mon, 25 Nov 2024 03:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533003; x=1733137803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azFZgkAznkGWRqKpayynp8wcnMLv0A5z/vByIfvuy2k=;
        b=ZpVwLLFDWlmMX+UfhkAcdxT02x6sCrVwlGSJTQmwgEgXmNR0i03h7aotsGOi5W14uM
         Imbjcl9W186s4vyj5dQi+XKGvRBE8JmQidI56pYxmGS373wDvSwdktf8WGXWazZMyqrA
         3Xg3QM+Zg8uN9+m2i96EhUUq4YZ05h4wJKNmAEbnEwV2STluykjNFyzVQe3he1JJAqUm
         8jvhSLx287EeeLZvLy7f3v+ewmhfhQgKSh9133TqWnRiqEL5KbyN0A+TxsS4bDVlTvhp
         uNoi9TEa26MFkCvzWABxMprXUmAvJsfmVceZ7JccWj0pL/NgFXiUWzFyolXzzAKQVKvP
         MdNw==
X-Forwarded-Encrypted: i=1; AJvYcCUWE2G6g55jF83QJamfxxlbjQYzaMPP2vjgRvF9LIuAyBZsjdW3vJhnLXv77yA2VPH0y/4ddWJ7OG19@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9vaSzRL+YD3ImIG6YZQYMoK0DnoHPajTR/UcxkDhEtWzo+H8
	jh7hBvC4Z9u0uWcxLlWCaJ039BA+DyHGeq3QmKnWauJvLYaiNNVGpwN/Np4anShW06Sw3iwKCdD
	Rs5JFRNWoEw/tc6qzRNwnoTO3yH4nvQXnWQ5foxBp4dipq6Cnf13YX8s=
X-Google-Smtp-Source: AGHT+IFoQkGe2TzK2Kv1xxLurWvC9RrhZntMaXija6nT4YFa6w3mmJCpaUpQEkmsq6sXRwrNPG2IXp0gEE5GZ7zEEkt949sm/a6m
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3a79aeade39mr92766535ab.16.1732533003096; Mon, 25 Nov 2024
 03:10:03 -0800 (PST)
Date: Mon, 25 Nov 2024 03:10:03 -0800
In-Reply-To: <20241125105220.1566-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67445b0b.050a0220.1cc393.0076.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in get_page_from_freelist
From: syzbot <syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, bigeasy@linutronix.de, hdanton@sina.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com
Tested-by: syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4dee8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7393f07275e8e571
dashboard link: https://syzkaller.appspot.com/bug?extid=5abecb17ba9299033d79
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b46530580000

Note: testing is done by a robot and is best-effort only.

