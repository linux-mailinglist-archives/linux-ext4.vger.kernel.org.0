Return-Path: <linux-ext4+bounces-2746-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7B8D7AC8
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 06:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BA51C2152D
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F122F0F;
	Mon,  3 Jun 2024 04:34:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50567101F4
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389245; cv=none; b=ZXMqcwI+ZQlgw1ejcnSpAAiC2oTiSXS2y5oEUgTCuQWw50Iw26ymMeyEPTu75BpTsAZl1DnJNWTftzyBHW2ry1abxgokw6KFeR00qEVaLDeh1iE2y0L9R50XNytfDXJnfQ/C5oY5c1j7WGjIISNJGUIfH5ppkN5dRKrEqJU9naQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389245; c=relaxed/simple;
	bh=XvC0SiEJbpVH/uBYqdcftKNyxVAMGHgOIGcomLlhPmk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lskcn/68uoaVVuX45wZ69W+KIJzq1NB4GMQPXEgzIq1wECBm/wOgZ+r97pZLTBCtt+gDwl16+1Q+Dkfgy+lCJoglwv5Xpda9QG4otKSrCNRbb2BzcUup4LFNvZGUMt+tZ+aLQuhKTteKXfjdKESJczSQdBE/9uJuK0wqrFxQTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ead5f29d93so352084739f.3
        for <linux-ext4@vger.kernel.org>; Sun, 02 Jun 2024 21:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717389243; x=1717994043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4vNl9aSBub11HSYUiO1Qffb2KM2Qlkf21jiN6qmFeg=;
        b=E2XQUsW7YuOcYCTFvBdbHXh3KNym/CSGwI2e3qNHI1y+xw9wjuJOLJ/bUEPluni+gH
         1EiMGgF0iwwtwIO0AiNCE2xRrOR0eXQW5R8qONoUi2oMqcTe/elyKdUxinuuodkAa+eB
         DjM2vjcrmYS8e/1LhtRcs7d3WvjCRwRnXOKzIGL8NXtlRQ6eNJLv7rdGhpAlBZjEsUPW
         e+YnDMIhz8xKpjE2iQhqwDCJ0xW7hCXdtGYAPMdUdunPCnVt65tTfyU4L4D0KmWPG/u6
         xrc+jJwsQWTgQviDiXnXgspoznUimN7xd+U4auA0PBJvi37CXbYtdRb6ZAvRBl1Smg0q
         0PkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4HUC2XTI/tHCvlC2Z168/NvIqRbpn33WUPlBXIaz93fdR0t0jWc4Mal9Kh5pfoEDeDukPaBzKWFZqDvKkYqM9GzhVUBbFoUYIA==
X-Gm-Message-State: AOJu0YzEWpHOS7In4v1E6/UbxpmFJrb1MvURhM9/IJywHTUaYp0ePRTk
	1zyfBc+nTY4EXI4uzizLeY/uY5Kt9S0ibFeXkVvo8b4Bl0HiR27nCK5BVuza7LG5rQacQ7ePRzJ
	OJnTwF20MAXUoTysUoTNvI/WAVGRLD1z45DEOl2Nt9mupaJpcM0VoPnc=
X-Google-Smtp-Source: AGHT+IFJF86xiMzFFPnya5J2F0WVQeTFP2xpVeNQH9BTe2iwAatl+IEZdZVB7KJ5SbCBJJnRnglxEPi/YP+bSmu0HwYFkIC8opkc
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:603:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-4b541a80d6dmr100445173.2.1717389243514; Sun, 02 Jun 2024
 21:34:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 21:34:03 -0700
In-Reply-To: <20240603042116.GL1629371@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd11c70619f4d7f7@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

scripts/extract-cert.c:46:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/extract-cert.c:59:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]


Tested on:

commit:         1c163f4c Linux 5.0
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 v5.0
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
compiler:       Debian clang version 15.0.6

Note: no patches were applied.

