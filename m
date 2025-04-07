Return-Path: <linux-ext4+bounces-7088-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA2A7E0C4
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D813A7AE9
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587811C5D63;
	Mon,  7 Apr 2025 14:07:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E218309C
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034824; cv=none; b=NDVQf/8792/33Ykp7HcCUWlC0TOoWyrzcenmBV1qvPAVY/G3hKcLT+FOxRWx1EvoWmYlx4jclG5L/ugsNFNdCWwHMZ2/B2q9LCNQDatCzVUMH4jn+oN2Qc7gxNfqxkpkEb6rJNVbjSS7p6NeXBNVWmkg+yJ+1h+zOJ616/evAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034824; c=relaxed/simple;
	bh=ncxjzCSmxOakrfI+ux5lY32lyCKIK2l6GJc70zdDPOM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FcztqZDdQXshj3zHjnasyo+3ogH7DPCQs5C99IyqInxja0d4Uhk3QpPt+LNSaaE3xDSyQpbRvkKM7UtAo/5rHNw/fq/dVqAetF/VT/cfgbA1rWm+BpbIqBaR9kgMGgHHNusfXuifWrphbQmQDNSapIPxVxwNWcgrpOD53ldlJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43b460962so85564535ab.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Apr 2025 07:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034821; x=1744639621;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwXWzXPAt90Ym5+D6NPAF0rUeU+1DPFdOJn+FQQCuts=;
        b=lRjjRg8jhKX7vLYuLvvSDfTHHhNnwXKWu+nSYjU5B8dHw+ui2Mun6GpjW0cZ8i+kon
         ipEi6ytixFwFRqZRgTK6bh2bIMjIQ3aAgKFSRYm6Srz1KVFsrF4jDz3MnF1SxR2F/mUy
         qPCAX50AYRpdUbwEa+MmrfieECIR+fOjmxE4JgGflkl8aFbSs/tcDVXRzm0mR8MPIvcx
         A1ApokoCtAnqA+6lWGlSIq59aLrti1+5+TU08979LOav9M7GBCcMwkhROuwI3ttUzMuF
         NEF4DXiFW+pxoMAxqBm2iI1smHerk6EpNG7QrNd6MHGv3AxMtUgpE4wTXiFnm7hWgMKE
         cMgw==
X-Forwarded-Encrypted: i=1; AJvYcCU1yEqWYWhKf0KdTJFbOCtFfA4HfHdU9Lj5O72xgzde1FLbuhUUi8MGejwyn0iE4qUvvZB4kSN8v4eO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywur2xxnTihAeR+JRsw6fUvq1Y67XWKBCqITGheBGwumeQ6eCgv
	UJQjVQ1aJvkY9j2NuKNjGoUoTEUxmTxplQjyhzmjUgyNzRz8eeIrd0trUJjkYtXm53ATmH+QDZo
	OnYuW8h6pwdeGDHcmdS0rZHLq4tgbiu04rPTPien0mDLVZDJF8EqDXOo=
X-Google-Smtp-Source: AGHT+IGk0qg4Non5+RqSgTngMpr84QybCMyGxRObEpMS/OBnGd9K0v8L1YYw6HKMv3i9T2PNneYp7wP0WdoYv8xmIodS/MaJDTO2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3d5:d71f:75b3 with SMTP id
 e9e14a558f8ab-3d6ec57f9damr97693795ab.15.1744034821687; Mon, 07 Apr 2025
 07:07:01 -0700 (PDT)
Date: Mon, 07 Apr 2025 07:07:01 -0700
In-Reply-To: <CAJfpegvsi9SaeVdykBFhhwoOrsNQzy3C8HcJjn16uHdkzZ-EVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3dc05.050a0220.107db6.059d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [overlayfs?] WARNING in file_seek_cur_needs_f_lock
From: syzbot <syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, amir73il@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         0af2f6be Linux 6.15-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.15-rc1
console output: https://syzkaller.appspot.com/x/log.txt?x=123c0070580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bae073f4634b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=4036165fc595a74b09b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151deb4c580000


