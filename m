Return-Path: <linux-ext4+bounces-4003-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6864E967670
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Sep 2024 14:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5E1F21B3E
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Sep 2024 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56975166307;
	Sun,  1 Sep 2024 12:34:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E014B972
	for <linux-ext4@vger.kernel.org>; Sun,  1 Sep 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194045; cv=none; b=lQOjob7TfbSXc0JPFoV47qUSNt7kcKOxZNEQEjmnYzATkeNI5Uj48enRAqD1dDxrqaL5/TDZE8uBMXkiAaaOUlbLrj0WyqaFHxsOvXEWsGlWgA8MxoMxGupNQrh1hHU6boIqHKkB52x/O0YLUQ32R/o2HiVrfDCEdojPr68YhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194045; c=relaxed/simple;
	bh=CUJxDY4vmJAEJqKS6S5TN8fIMXnins6MR89/cBuKf5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QSB9aih0zuZuOOuzoSwanPGyXe5l7jjTuzTJOAoAUR5u1gpcffcnlW7hCoBA/b34W9QU9sfO83sw9qF2Gmyo+zVBDEyqGWpShUwkN0I5JieOmLAJSwEnwXzc/ZXiKC3Yz+1PEWBlNmaXDtfaQ+45Famzkwwb1ZDC17DKJzwR99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a32368e13so199753939f.0
        for <linux-ext4@vger.kernel.org>; Sun, 01 Sep 2024 05:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194043; x=1725798843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VW7ap+EQYIq3PDTTReUgdcQQbZo1rtiFoKurLifu6B4=;
        b=O/VOARTzjHnBVjrKtyGgOMxyvBmb+pQXon3G/ghMDmkVQUN+tEcg0UYEU3kT4e3NIu
         zn2BWx2K70ttIJSotr3kQn79AmkLeZ7j+IwMEU0mtRoVNmNyEOVjtL2mN8XE/Vq+fhDK
         1DGZILjQhcq/bJdr84bK9HSRXubeGGPr8RpxPGQSWxcqSC/cOpcyB0FcMrsXPKR5fYa2
         99AQNy5MnhqrYw79VGZvjxwoyCcGuxvpFOdS9UBqYvb8M7zaK4E9BzWvOYLRaUgykyHz
         1O7RxoIo1kLDmvyU5y9O58u41MBt3uG913v6R1f6Xsm0HJgt8xIZth4To5e1JfBta9T0
         5pvg==
X-Forwarded-Encrypted: i=1; AJvYcCVvKm/1HwfVUa/TKPCIEdL/lHs5OyvLOR/HfWiBveAXUHueatSVdxaco/3nyhVkrqF6tPfVuofpJaLZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1qTgLUWy1WkVwHcWI9FccsWt97g5vLmrjbIam+gReq1KnJuq
	fZIAsYNoQwGHYa/SzW5XXCA4g+0KQj3VXqVt5vfRD6Q+6N1xL6VWjXflVDehLjv91eBxyOtVoxz
	tj2E9nbcgkL1KTjmHj1mzM8PVGftb+UhCv2WexYQcqSCzVPZDW+tMEx0=
X-Google-Smtp-Source: AGHT+IGhn0gJE/LtqBPSue2jbVawIErocTYS+T6i9Td6ddXhgfdqdIGSiKhau5wwKSr99H0biFbMarPHK3i6WljiNPEXWxneMD2a
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:807:c095:9d39 with SMTP id
 ca18e2360f4ac-82a2611ad50mr67640739f.0.1725194042871; Sun, 01 Sep 2024
 05:34:02 -0700 (PDT)
Date: Sun, 01 Sep 2024 05:34:02 -0700
In-Reply-To: <tencent_27C9A8AECAEEFD8C8FA7E286C892D0865106@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018212a06210e0a75@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_inline_data_truncate
From: syzbot <syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	libaokun1@huawei.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com
Tested-by: syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com

Tested on:

commit:         431c1646 Linux 6.11-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15146cfb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f4a91e4d2a2d49
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa6090cbe3c97dc9565
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cfab47980000

Note: testing is done by a robot and is best-effort only.

