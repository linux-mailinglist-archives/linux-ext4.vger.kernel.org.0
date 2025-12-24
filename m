Return-Path: <linux-ext4+bounces-12502-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0778CDAF3D
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 01:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 372453003BCC
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC1316197;
	Wed, 24 Dec 2025 00:32:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EB315D22
	for <linux-ext4@vger.kernel.org>; Wed, 24 Dec 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536324; cv=none; b=YWW4IeNN+hkyCtmw+pPQL9WJoO8LBVShkuaW0H9H7FY78h1+Nio3pMJvHiiJWN7VG716bjbr9cCfFowpPAzOuleKtY6eFbBKVKYH46BvoON3Qk1danSwq0Zny+XGNGIwE6XkFZ9Bij5MLIo+ZvdolZPzEQoprMi2LMlGY8uTyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536324; c=relaxed/simple;
	bh=WLDYsKeqtHC1X7/foxDAGGLfxjA90yTqPp+EiscQlX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Az0j495YntMD9w6mrFyGio7Y7FrgOWwKzJMm09JJHgqFjIHGqtw9X+cJmocOpytojdDuyGXjvTL+tUh0nl+/pswdNs5jk5Dl3uL6RvDbwnraLbnVzH4dwiOs77oel6CpeT2kDVg9TzwZf5oY5dbU+6+mUFb6kcy7kvVukLKEdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-656cc4098f3so8844803eaf.2
        for <linux-ext4@vger.kernel.org>; Tue, 23 Dec 2025 16:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536321; x=1767141121;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Va2VfPs9ApZjSsj5ATJ7KVoiJwVbCQA0CZHsuoEnzCg=;
        b=YGMaqNCdkGqCwTSzkvacwwwcbciZR5Msy4B0sOndNcUky/78B+jHoX858Qv5Rq+sT1
         I7hXuGUWW+0i6xwO4otbsgsVj3LEqI+gteb7tkJtnE+THe2dere1RcUtLnFCA1RVDMJ8
         w8/8lvG5hG9FCRruCNXhc3DlfxYmQVmoYz9tNb/u9413kELc/duiKr8BqznPCrBcTjqT
         s29ByNJDoqlU1tfoTJuJl2DzKw63wigPX9VLEVcdELE2OS6qtkrjIO579YfEtBXNn+DD
         QQ5oKuREUKFXcKjLNmxnENMCUwp+HBPT+WUrDZMHaUlevrRzynayQZ6h+ZULCOiIlDbg
         nocA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/B7CrfNX7yaHNLB93DFvgsb6FV79ADAnmNjbjuMNh0elE+JuVGrPVGCAdCENwZx8dgw0eOAqxnnT@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7XCzKOerqmYgtdkUBTxI+83spRu6Ji/9F/IjSDCpDlq1x7jQ
	Lti/+pGfDhK6yZF8+65hoIQZIJPOpA3pW0x2htvQuH6xbixBx+De371iCYl3R8Q9jjXiRXrlUtp
	eKeSWcahPwgfVx+eCbyfWXZVEBzB4+HAvJg/tDo94HYIXzZw91f+WFphMCFM=
X-Google-Smtp-Source: AGHT+IHOZfF91uzeoESVPCmUGI5rO+RB8szUXHzbAvDO46/yx4H8YqG3HZpHGicG5m8L3famMF9a4gnkPXDENXrHWS/b5aTfi6Wj
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2229:b0:659:9a49:9026 with SMTP id
 006d021491bc7-65d0eb10455mr7186596eaf.83.1766536321463; Tue, 23 Dec 2025
 16:32:01 -0800 (PST)
Date: Tue, 23 Dec 2025 16:32:01 -0800
In-Reply-To: <67775d94.050a0220.178762.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694b3481.050a0220.35954c.0009.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] [ext4?] WARNING in __jbd2_log_wait_for_space
From: syzbot <syzbot+04ae2c9e709a347f1a81@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmantipov@yandex.ru, jack@suse.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, kartikey406@gmail.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 93ce0ff117b0c468961d7c296a03ad57e1e8da9f
Author: Deepanshu Kartikey <kartikey406@gmail.com>
Date:   Thu Oct 30 15:30:03 2025 +0000

    ocfs2: validate cl_bpc in allocator inodes to prevent divide-by-zero

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b4ef1a580000
start commit:   63676eefb7a0 Merge tag 'sched_ext-for-6.13-rc5-fixes' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=04ae2c9e709a347f1a81
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c678b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112bcedf980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: validate cl_bpc in allocator inodes to prevent divide-by-zero

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

