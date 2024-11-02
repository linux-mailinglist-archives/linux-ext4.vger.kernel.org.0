Return-Path: <linux-ext4+bounces-4909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E583F9BA2D8
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Nov 2024 23:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E04A283337
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Nov 2024 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D681AB6DD;
	Sat,  2 Nov 2024 22:58:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4C16FF3B
	for <linux-ext4@vger.kernel.org>; Sat,  2 Nov 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730588285; cv=none; b=Rd/SZCZsuufF6YkdLfYvCHlsImL/WfSdjBs48EsKIWCiK9AL+kG5KFcsmcOg8vVtdRqa0GDUOpoPkMiXZJLpg25wTTbqpBmL0KeXMU3LA+RbGCSUE+dSI+zeHdqNcgbOgFBR9+v1CJHGc6yfS2zokKs2TTNMsPnc0+G69H5w4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730588285; c=relaxed/simple;
	bh=lQTJmVE2dpbn2916q3lXchAWyB180O9oib1aRjyR9Zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UwcUXDsaFdn4iWTu0scNWQAdh8u4x6LRV6yu+8f+9n+UwAgU96723VtXfTt1xtX6ak613bll8D5pZ+r7+fvXTxv2O4MEaZr7P8s6IRrrcuKlAD/yDGxEsGsHusPjirqqcpfTnCVVdYaSXgDi+2IE2Hquv2tRxKWsrGZCBxLuYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so6868235ab.3
        for <linux-ext4@vger.kernel.org>; Sat, 02 Nov 2024 15:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730588283; x=1731193083;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yBzUyljWebaGC+XnQZjALDFZL0q7JsGCGKAUh0yZEw=;
        b=T1RzohqcAN1w1ssk+Z4LHZIQlpQ3m+bFBl9VRyUNKhoKwgiAfOC28nvJPOlpbn0mLv
         4XzM6VykF5iTNrMksekbIS/9HqnuMFaD+35OhKNZNCHbEIPv+PRTUxsT+glEBN6RDLRB
         sPdFduqVMULb9GLsgv412WtQGay28LaF86w61AOxCveyy1kNcEhwIaY4lBz5SsqjwtAt
         YqIrJDF6vQmGX3uCGIx2cwyxZRG7dnYPOKztMNOMkCb6/0DmWP6LoSybjaUGV+YD/wl/
         0ws2ut5J3hUFvkZYq/T28tZbEM87dnxT5LxtZrbV40ZDF2aMfqb/4GTd3f+2f8nzC25d
         UDtw==
X-Forwarded-Encrypted: i=1; AJvYcCUEFyn3wP8bMwsiHu06mFPCHEGPPbuzaM4LOg46t+gSIJ36VbvJq1keOgcwQbmyRnhUrXI7CCB801di@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTLEW3ngWlVvlWl0nWtpRLebtcoYIj0Vjz3WPE+CuqtQ4a5H3
	9twB+ZcnI/ZXPtLA4MWBU+Qh9+rtdJFkK0X+sEqfyPUaFSn78UuJVL+nFPHLkxHomnxlWO2lgwn
	Pvoqb8YI1dhfb2qvrQK8spD4dZemnWxhrjkAyo7EmKu8+dx1vQ0YrtfU=
X-Google-Smtp-Source: AGHT+IHiBflm0OrHzRauDd2+Qk79yPQ2UsUXEsZO3NY2JhYxJXK8UlMJyJX29+TPwFZDLAECael9bu2Y9DD9M2ZTmExsyybtfnvw
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a4ed29dcdemr256947425ab.10.1730588283359; Sat, 02 Nov 2024
 15:58:03 -0700 (PDT)
Date: Sat, 02 Nov 2024 15:58:03 -0700
In-Reply-To: <000000000000163e1406152c6877@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726ae7b.050a0220.35b515.018a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
From: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, adilger@dilger.ca, eadavis@qq.com, 
	hdanton@sina.com, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot suspects this issue was fixed by commit:

commit d1bc560e9a9c78d0b2314692847fc8661e0aeb99
Author: Wojciech G=C5=82adysz <wojciech.gladysz@infogain.com>
Date:   Thu Aug 1 14:38:27 2024 +0000

    ext4: nested locking for xattr inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1245f55f9800=
00
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1a07d5da4eb2158=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dee72b9a7aad1e5a77=
c5c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12407f4518000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D140d9db1180000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: ext4: nested locking for xattr inode

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

