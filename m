Return-Path: <linux-ext4+bounces-8942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E073EB022A0
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938A93A6816
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jul 2025 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388E2D3754;
	Fri, 11 Jul 2025 17:30:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279162F0E34
	for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255004; cv=none; b=ruedhP7ny6YXZpoopknWE4GKc3mAmGhmMBrSQO0ei/ZaetlAD5TwJ+2SJLEyltUkE33WErFLFiFgDfDKNEOl+VD/Z9eXNYdeZIuXS7wwF4YAuDA3A2c2yQexX3nX6olLg6ns0dGZ9cx9t97LcjuxMEp5xhZ9p1GPug6nJE9mMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255004; c=relaxed/simple;
	bh=5wIUFH3p3hc8B6Ka7CMxGym9Tziz+cragojfTnvgQOc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ftcZ28dYu/+F3Unkt8vDGFcWhK5/R76OHzMQgwec9OY6MJHJH7NfWjL5XpT8tqA1Dfaht7czywkqK+zPz3Vi5BhGNAH/fUfuFhmCJlG1gkuqvq570FTmFFxIv18jCsF8dVHvQguyeAWqiUT0YyoNLoabyEuma7NjHMN8OozoqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e05997f731so47204805ab.3
        for <linux-ext4@vger.kernel.org>; Fri, 11 Jul 2025 10:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255002; x=1752859802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtYj5NrUJYfCiYvUPXTxIhWupGeSnswC1vMADMD4/6E=;
        b=RKM7SgIDqhjSwXmQI2h+mAXyTGUr6iB+YwYMN8RP1vqtXePz5oXOMYIa7jSDIrFgjT
         3rE1PPjgNAQrK8R9wmdRbK8m7gmynjzQni+termM4qtv1fQfEyxZ19Y4tlEhV4rVUZMf
         YUeccDTOANljY+0jnqpLBH+uDvpia/SmN8ko5xhHUiazVR8bGnglhbPo8JQH11FG7zrC
         J6W4w4pQVEDluGSUGsmXq3g4i0giha4IgtKD0xamtJMYn8OZjtNoVxdzhD7cnrkVG9et
         1h7Y8Z/TnCtexr/0am4u61bmLgLyjjsCp/6lwHFWTnDCStRBcSgpjH1GRkabkd5bPK4T
         x23A==
X-Forwarded-Encrypted: i=1; AJvYcCV//IW1NPM/Z/MZx1zN6uA1L+98OOSeGIMeCf2G6Mi4Kyol6hRZlPCgy2PRgWR2doi7/5G+R9c1Mhu/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zGwcgoIZ0l0HPyo9gdvHfxvHu36kqPZn+anmRkBqLlno7Sld
	xmzhIw9rY8qFHnCiZkuJBqugZ+8OoUWTqimJna8kFB73NxkMqhZ/87z6JUUSpB40n1MdmNBdRD8
	cdiDc8xITnhK9NKtiCOSmLD4gmSultrnUaJ4CXF1rhY8IiNLavP7IjPXRBF0=
X-Google-Smtp-Source: AGHT+IHzRB2BUsrViLN0NCJNyjkK8/XfSLHMn0mIEK6+ILPjJzMMqz5TTV41Eh8cSECo1M/2sndo3Feu2SABg0xx1Qq2f1RrQxs5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:3e0:51bb:6e42 with SMTP id
 e9e14a558f8ab-3e254313c42mr45683925ab.6.1752255002208; Fri, 11 Jul 2025
 10:30:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:30:02 -0700
In-Reply-To: <okx6a3ngonajh7jrzc65ybd4i6bcnkc7gm4mggyo3jlm6s2ojx@yy5jcipsnd3l>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68714a1a.a00a0220.26a83e.005a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Tested-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com

Tested on:

commit:         a62b7a37 Add linux-next specific files for 20250711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b87a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb4e3ec360fcbd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c6c68c580000

Note: testing is done by a robot and is best-effort only.

