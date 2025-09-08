Return-Path: <linux-ext4+bounces-9849-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE4B49A59
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 21:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DD7AFFD0
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B02D3A85;
	Mon,  8 Sep 2025 19:52:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104F2472AE
	for <linux-ext4@vger.kernel.org>; Mon,  8 Sep 2025 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361125; cv=none; b=Yq258WLubW26pIM9+pJSJA7JgZHpee4UDxbTd3+uM+kvV0CexReEW6vbaGT1BwH0t98f/wkTFuiJzY+o0AKbvrOz5USCXXVJHB5eFexqgYa0+HtAiluL6lwtopvcSDGpOVnveax0Mx/H0VdRLB2vgY9owF2oM2PTPCfrly3tlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361125; c=relaxed/simple;
	bh=Xw3fA3hYo91wcLGD0HNrTR+08mGg9P6FC4LeHeM9EQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YzDXmoI2bZg6PRD/A74QktaK2zeSm6lLwI/HJcJelZy1+ux+SQL/0fiIMPFqjYWiaatH0Qf6901JNN4fl1UeJ2YUCp6DhNBXDFbY/jm3gvDQQTz3b1+zx6zZvZyOHEvuNg6vxgnq4cvRxcxpg1cboY4jZYixM9ufbRZ0GPhkKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8876712ea4bso1203419239f.0
        for <linux-ext4@vger.kernel.org>; Mon, 08 Sep 2025 12:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361123; x=1757965923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6E6CGk2tmAlq5+OVCzHjqNr7fmm4smeKYiarZdZ2kMw=;
        b=bGPvcmKQUOAZClBNgkr6GbUddZlI2E49fXw02iAA6UDF3iWjWfsE4QtwNEMlJ99qld
         x5m51HuSOsfwJwMkcnFrzSEre0n4hCwmRyl/UKjXd0/G0Rs2tInAYX0UK8p1RgeeIXnu
         RHG4LANdZte8woAwxo+hpjDX2lOTnOI5r3Xy618dWf+BfAWit3tl1af3XciNJ/gYMwmE
         3W8FARGYKVaEZXCNFxKCQXGdjbBqKs2GwR+7AINoXlRbskaVfL0Z8IJDuewJnc+aAQh5
         jb2s2oSaxMU+rHNrEU3o4PGUnq87hkl6hDjbOe8g03vVoD8sqg3jH4PVIYNm28NnyB7a
         ZFrg==
X-Forwarded-Encrypted: i=1; AJvYcCUiqXjJDly3iBViR9y65UGpA4SUDpk4Vaqla6RRieBUF2WVUdHwcn5C7//9+uxLO1T5BR/s4hT7dyVv@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvyhq2uCWr9TBX8Gwd4zpsVlaJ+g/aAwIYuV385eFHzvtgyTz
	U7sxTaJ91y4lGvb1kep3i1RhBFc3W1Q1nDnaISk2mdCBJLUF+AdBpRRA+nWG7po1LsH3rJ3DRLN
	qIncYTahpr+zVuUvyUkmSsRX1z0lZiniBU9TwQIQ9LVOtcI57Yxm1uvJNDnA=
X-Google-Smtp-Source: AGHT+IGXg7L5kD0uoY5KYmviwfxTBneLi5Cm1Bw2Zj7cRXNgGfxtx4v4PIo7McUtRBfK4wibi8nrfPuz44FeC2vNCprnp34kScX8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:407:51a8:6b5c with SMTP id
 e9e14a558f8ab-40751a86cfemr66244445ab.32.1757361123448; Mon, 08 Sep 2025
 12:52:03 -0700 (PDT)
Date: Mon, 08 Sep 2025 12:52:03 -0700
In-Reply-To: <68bf244a.050a0220.192772.0883.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf33e3.a70a0220.7a912.02c3.GAE@google.com>
Subject: Re: [syzbot] [mm?] [ext4?] WARNING in ext4_init_orphan_info
From: syzbot <syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, apopple@nvidia.com, 
	byungchul@sk.com, david@redhat.com, gourry@gourry.net, jack@suse.cz, 
	joshua.hahnjy@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 02f310fcf47fa9311d6ba2946a8d19e7d7d11f37
Author: Jan Kara <jack@suse.cz>
Date:   Mon Aug 16 09:57:06 2021 +0000

    ext4: Speedup ext4 orphan inode handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16645562580000
start commit:   76eeb9b8de98 Linux 6.17-rc5
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15645562580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11645562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=0b92850d68d9b12934f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d2562580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15869562580000

Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

