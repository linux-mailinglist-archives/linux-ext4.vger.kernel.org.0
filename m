Return-Path: <linux-ext4+bounces-6394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D35A2D7F9
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2025 19:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E561887665
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2025 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE281AF0BC;
	Sat,  8 Feb 2025 18:13:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512D18FDCE
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739038389; cv=none; b=huvU3lALmNmATmSPOGmpXUTwHNOnfdApvJSFiRpKrDRoQDNSoPuO0XTxnyo3dfP3es0rBFZnzfxX+09KngTsPYbaWF3KRAS7DfTlaSHBbHVRI8pvzorer2w0jo+R6j9nzCJTyCOEil6nOPjPtQlyRu70VaPUqZGX2wZpiv4yc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739038389; c=relaxed/simple;
	bh=jCe5Ko+BEiMMqUX4MLdnqnpGJApSfygeryF1Wff+3MY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2YYa8fHD6kLiRRmTUAsy+z+ub08KvN1UMCMgTFZtQObSWkNxGSW/VKBm9UjhBXDxTtmfuXi9brPKIuDz/MmMHioV1K6HeZxlhcFNwf14/+iadwBSibv1CFuV8MXYkXPsuTl4z9fzNDxBR+oGBTfbCMb0+ADMYWUwpq/4Vwxcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844cfac2578so593793439f.2
        for <linux-ext4@vger.kernel.org>; Sat, 08 Feb 2025 10:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739038387; x=1739643187;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L68seCHq06A0QlTsoJnIo63XmqePBu8IWHQHQYEeSNY=;
        b=rzpLz7qt4wFW59cH3e0kXy4m4EF57Ut7YErork9GPG0o2yq9/Rak5ANEpeQQpelMVM
         9vCDF5/hgljZDkSNNTPUbUm2eWbQIEnxdK4wz3x1dE5ygtIjcroN+FBm0aTKlp/rQwtF
         eZqBa3+jkJf9XexCMPFGxenAicJfyuw95vNwJFA/kmU7L5kT/+deMw2Hf5KG4grwcmLO
         raqsGk5QTtTSAoMWZFxk2EYtEz/olJIF9HMOy/DVkLR8C8L+nac8OZKFEbwHi9ZTlNmn
         P1Ty4h666YCT5JyqL3/DcB6lgr/JQs/qHcsihVyoKbbWuUAKFV8LErGYXRiX77CuJ1TG
         IC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpVjBVTixnfcuXiKBp0G8SfFGszt2/04P64XA6J+JKRCxcPWxFtSDpjD1gDkZOB/DUxfW5M1AnwAYS@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKI3iArkhghaqjzm+fmSaXA8+B6MutcGxf2Z+kvZThcMlPPuu
	Hn2SY78m081WnTxBQRBEMtxN2xkixNJMTlJE9DFrE4sD8mIGbWVo9vWivon6WVHk7J0O8sclIW/
	txXHmcEzVUT7IxYCsObHKhHOhOlyd33vaZn8snbJ/ui3H1syxukdFkkw=
X-Google-Smtp-Source: AGHT+IETwaFD92Sx+P5rd0Aiu+L8tKh8GHvF1IBMYWIs66lr6Xv785MVVxiiiHfBDzg8qLYAfHoRYvd8OWkdK2oWeDLD3BKcI1IL
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3d13de77ae3mr64920575ab.2.1739038387122; Sat, 08 Feb 2025
 10:13:07 -0800 (PST)
Date: Sat, 08 Feb 2025 10:13:07 -0800
In-Reply-To: <67a4eae3.050a0220.65602.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a79eb3.050a0220.3d72c.002b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in inode_set_cached_link
From: syzbot <syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6408a56623761f969537b421d99f045a4cc955b9
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue Feb 4 21:32:07 2025 +0000

    vfs: sanity check the length passed to inode_set_cached_link()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152ffca4580000
start commit:   808eb958781e Add linux-next specific files for 20250206
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172ffca4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=132ffca4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88b25e5d30d576e4
dashboard link: https://syzkaller.appspot.com/bug?extid=2cca5ef7e5ed862c0799
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161241b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ee80e4580000

Reported-by: syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com
Fixes: 6408a5662376 ("vfs: sanity check the length passed to inode_set_cached_link()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

