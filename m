Return-Path: <linux-ext4+bounces-10247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46EB87976
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66862A1EA2
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74B24503C;
	Fri, 19 Sep 2025 01:27:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB323D7F3
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245224; cv=none; b=PFe65aG7MCaUJlRh6B1FXUWPZpaiph6Xy3D/kV1gGhway/4FxJ1RXptC4UpHSLpMIly2fSSIHZjOr0441N3taC9EO88pkEeDE46lry4khE/PrYIybtysZBgXsYGjbRMBGlXnwKUURpjmrKpiCG5j7qb/BERRsLuoxYqoxfYeFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245224; c=relaxed/simple;
	bh=TvAjvLUzPXrlMGzOwNeheAuZyk3o2khNVEQJhoEKPXQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gbK78tHmmkV99MG0a+9dJOtStldyPbaD/ydjY0idNEOGt+pRL9dPY4lBoBEDPHMaBl/WiPa1QhmR13YG4nO3IOO63PwU3h+TGOxQxqsitMAJB/xUX+yS+C5aHTYuZES9dF3yUHtXLUzIgQ2OsHAiPij2A0lWaofXdFw/RqiQVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4240a41d2caso19334275ab.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 18:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245222; x=1758850022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2H3OA3pX5SOBoK6XYroKXhf4Xi80uinhZ9BKahBMUc=;
        b=gLTaP8o2xTWyx5xVZ9PyPHbfF1ElgQl6vsx/a3hMw1BKa1NEt+qxJrOo9yT6bwNyUt
         GY7cM2Xqw8Tc86f+HZMFajwl/jgOng2PxR+W52YResg0LaGG3BfO4YnOjBIb+u27DjTj
         SvlQ/1mhs1h+9FL9YLGSL53xxA2+LbnlzqvxJoM3jUwGwqzhe/ArHAWmvLIJrvK9KlXi
         9X1GtXzEwApYYN+DTEpl1vIYrWaLCR3JeoXYJFPRwWFp86ZGuq5vSs78KGGEDjtlolGv
         2uAz9w1wwMMB0RavA9RqubwNiJphrgjEa+zSi/ZjQM4UvE1W6oZk0x82zqZmowlP5SEA
         MGtg==
X-Forwarded-Encrypted: i=1; AJvYcCUGihGz8ZU8ODZKasPiJov6RldU/NWdMxPFNUNK9iMcCgHyjZAsPFRehEvEle3ONDpE0QgGdXoD3ZKh@vger.kernel.org
X-Gm-Message-State: AOJu0YzvALA2TT4OCeEUyt0ByS6a+du9sPepIEb5b7vQxriKnFL/ju+7
	IZC7/iP6bz+xEKblmU22q2aAqFNkB0N5Jt2oyMkvFiPWNjHMLIL3PIFG2YTG4tOG0Cy0+bz2SAg
	uuVuYI8tTQPASMsl4ea6mBhaFi5BSK3lW0bjzFVGIwR6n5O5wp7IYJ9ohRqE=
X-Google-Smtp-Source: AGHT+IE0nTSooBb6CKNztSpDLqtgxEy3ez+D1/QpCnVTeaymqPp8VB4efXFN7evAP4RiblOHqLwM2f5cXyBLoLzApVfxqyS3Tl4j
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:424:1e39:bf02 with SMTP id
 e9e14a558f8ab-4248187f948mr28684325ab.0.1758245222423; Thu, 18 Sep 2025
 18:27:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:27:02 -0700
In-Reply-To: <CADhLXY4XxHAF95Nq2NSg5kkDWWdEmonYaGM_6a0CfdfedHAF9A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb166.a00a0220.37dadf.000f.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/mballoc.c
patch: **** unexpected end of file in patch



Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128d3f62580000


